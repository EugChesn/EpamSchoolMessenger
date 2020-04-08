//
//  ImagePicker.swift
//  Messenger
//
//  Created by Евгений on 08.04.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import Photos

protocol ImagePickerDelegate: class {
    func imagePickerDelegate(canUseCamera accessIsAllowed: Bool, delegatedForm: ImagePicker)
    func imagePickerDelegate(canUseGallery accessIsAllowed: Bool, delegatedForm: ImagePicker)
    func imagePickerDelegate(didSelect image: UIImage, delegatedForm: ImagePicker)
    func imagePickerDelegate(didCancel delegatedForm: ImagePicker)
}

class ImagePicker: NSObject {

    private weak var controller: UIImagePickerController?
    weak var delegate: ImagePickerDelegate? = nil

    func present(parent viewController: UIViewController, sourceType: UIImagePickerController.SourceType) {
        DispatchQueue.main.async {
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.sourceType = sourceType
        self.controller = controller
            viewController.present(controller, animated: true, completion: nil)
        }
    }

    func dismiss() { controller?.dismiss(animated: true, completion: nil) }
}

extension ImagePicker: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            delegate?.imagePickerDelegate(didSelect: image, delegatedForm: self)
            return
        }
        
        if let image = info[.originalImage] as? UIImage {
            delegate?.imagePickerDelegate(didSelect: image, delegatedForm: self)
        } else {
            print("Other source")
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        delegate?.imagePickerDelegate(didCancel: self)
    }
}

extension ImagePicker {
    func photoGalleryAsscessRequest() {
        PHPhotoLibrary.requestAuthorization { [weak self] result in
            guard let self = self else { return }
            if result == .authorized {
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.delegate?.imagePickerDelegate(canUseGallery: result == .authorized, delegatedForm: self)
                }
            } else {
                print("decline")
            }
        }
    }

    func cameraAsscessRequest() {
        if AVCaptureDevice.authorizationStatus(for: .video) ==  .authorized {
            delegate?.imagePickerDelegate(canUseCamera: true, delegatedForm: self)
        } else {
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                guard let self = self else { return }
                if granted {
                    self.delegate?.imagePickerDelegate(canUseCamera: granted, delegatedForm: self)
                } else {
                    print("decline")
                }
            }
        }
    }
}
