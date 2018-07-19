//
//  CustomCameraViewController.swift
//  nCards
//
//  Created by Juan Pablo Ramos on 7/17/18.
//  Copyright © 2018 Juan Pablo Ramos. All rights reserved.
//

import UIKit
import AVFoundation

class CustomCameraViewController: UIViewController {
	// MARK: Properties
	@IBOutlet weak var cameraButton: UIButton!
	@IBOutlet weak var loadingScreen: UIView!
	@IBOutlet weak var focusRectangle: UIView!
    @IBOutlet weak var promptLabel: UILabel!

    var newContact = Contact(uid: "", username: "", name: "", email: "", phone: "") //initialise the newContact that gets passed after photo taken
	var captureSession = AVCaptureSession()
	var backCamera: AVCaptureDevice?
	var frontCamera: AVCaptureDevice?
	var currentDevice: AVCaptureDevice?
	var photoOutput: AVCapturePhotoOutput?
	var cameraPreviewLayer:AVCaptureVideoPreviewLayer?
	var image: UIImage?

	// MARK: Methods
	override func viewDidLoad() {
		super.viewDidLoad()
		focusRectangle.layer.borderColor = UIColor.darkGray.cgColor
        focusRectangle.layer.cornerRadius = 8
		focusRectangle.layer.borderWidth = 1.5
        promptLabel.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
		setupCaptureSession()
		setupDevice()
		setupInputOutput()
		setupPreviewLayer()
		captureSession.startRunning()
	}

	// MARK: Camera button code and segue
	@IBAction func cameraButtonTapped(_ sender: UIButton) {
		let settings = AVCapturePhotoSettings()
		photoOutput?.capturePhoto(with: settings, delegate: self)
		loadingScreen.alpha = 1
		DispatchQueue.main.asyncAfter(deadline:.now() + 5.0, execute: {
			self.performSegue(withIdentifier:"toContactAddEdit",sender: self)
			self.loadingScreen.alpha = 0
		})

	}

	@IBAction func unwindWithSegue(_ segue: UIStoryboardSegue) {

	}

    //START CAMERA SETUP
	func setupCaptureSession() {
		captureSession.sessionPreset = AVCaptureSession.Preset.photo
	}

	func setupDevice() {
		let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: AVMediaType.video, position: AVCaptureDevice.Position.unspecified)
		let devices = deviceDiscoverySession.devices

		for device in devices {
			if device.position == AVCaptureDevice.Position.back {
				backCamera = device
			} else if device.position == AVCaptureDevice.Position.front {
				frontCamera = device
			}
		}
		currentDevice = backCamera
	}

	func setupInputOutput() {
		do {

			let captureDeviceInput = try AVCaptureDeviceInput(device: currentDevice!)
			captureSession.addInput(captureDeviceInput)
			photoOutput = AVCapturePhotoOutput()
			photoOutput!.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey : AVVideoCodecType.jpeg])], completionHandler: nil)
			captureSession.addOutput(photoOutput!)


		} catch {
			print(error)
		}
	}

	func setupPreviewLayer() {
		self.cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
		self.cameraPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
		self.cameraPreviewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
		self.cameraPreviewLayer?.frame = view.frame

		self.view.layer.insertSublayer(self.cameraPreviewLayer!, at: 0)
	}

	func startRunningCaptureSession() {
		captureSession.stopRunning()
	}
    //END CAMERA SETUP



	// MARK: Transitions between views by tapping buttons
	@IBAction func personalContactCardButtonTapped(_ sender: UIButton) {
		ContainerViewController().scrollToContactCardView()
	}

	@IBAction func locationsButtonTapped(_ sender: UIButton) {
		ContainerViewController().scrollToLocationsView()
	}

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toContactEdit" {  //!!!!!!!!check
            let vc = segue.destination as! ContactAddEditViewController
            vc.newContactCreated = newContact
        }
    }
}




extension CustomCameraViewController: AVCapturePhotoCaptureDelegate {
    //potentially return new contact here
	func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
		//take photo
        if let imageData = photo.fileDataRepresentation() {
			self.image = UIImage(data: imageData)

            //tag and return array of useful info
            let textRecognition = TextRecognition()
            textRecognition.detectTexts(image: self.image) { resultsText in
                print(resultsText)
                let output: [String] = textRecognition.linguisticTagger(resultsText)
                //add to firebase under currentUser
                self.newContact = self.addNewContactToFirebase(output)
            }
		}
	}
}

extension CustomCameraViewController {
    func addNewContactToFirebase(_ contactInfo: [String]) -> Contact {
        //random int as String to identify contacts within current user on Firebase (makeshift uid)
        let randomIntAsString = String(arc4random())
        let newContact = Contact(uid: randomIntAsString, username: "", name: contactInfo[0], email: contactInfo[1], phone: contactInfo[2])

        AddService.addContact(newContact)
        return newContact
    }
}
