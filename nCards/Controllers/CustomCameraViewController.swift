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
//		setupCaptureSession()
//		setupDevice()
//		setupInputOutput()
//		setupPreviewLayer()
//		captureSession.startRunning()
	}
	
	@IBAction func cameraButtonTapped(_ sender: UIButton) {
		let settings = AVCapturePhotoSettings()
		photoOutput?.capturePhoto(with: settings, delegate: self)
	}
	
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
	
	// MARK: Transitions between views by scrolling 
	@IBAction func personalContactCardButtonTapped(_ sender: UIButton) {
		ContainerViewController.scrollToContactCardView()
	}
	
	@IBAction func locationsButtonTapped(_ sender: UIButton) {
		ContainerViewController.scrollToLocationsView()
	}
}

extension CustomCameraViewController: AVCapturePhotoCaptureDelegate {
	func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
		if let imageData = photo.fileDataRepresentation() {
			self.image = UIImage(data: imageData)
			print(imageData)
			
		}
	}
}






