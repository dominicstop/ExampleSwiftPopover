//
//  PopoverViewController.swift
//  PopoverTest
//
//  Created by Dominic Go on 12/3/20.
//

import UIKit

/// Helper/Utility for configuring a view controller to be presented as a popover modal.
/// For some weird reason, everytime I programmatically present a view controller as a popever, its always
/// presented as a page sheet modal instead. But if i extract the logic here, it worrks (iOS  13/14, Xcode 12).
/// Note: The  code  is the exact same, the ony diff. is that the logic is extracted to use a singleton, (i.e.
/// a  `sharedInstance`) to handle the `UIPopoverPresentationControllerDelegate`.
class PresentAsPopover: NSObject, UIPopoverPresentationControllerDelegate {
  
  private static let sharedInstance = PresentAsPopover()
    
  func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
    return .none;
  };
    
  static func configure(for controller: UIViewController) -> UIPopoverPresentationController {
    controller.modalPresentationStyle = .popover;
    
    let presentationController = controller.popoverPresentationController!;
    presentationController.delegate = PresentAsPopover.sharedInstance;

    return presentationController
  };
};

class PopoverButtonContentViewController: UIViewController {
  override func loadView() {
    self.view = {
      let view = UIView();
      
      view.backgroundColor = .red;
      
      return view;
    }();
  }
};

class PopoverButtonViewController: UIViewController {
  override func loadView() {
    self.view = {
      let button = UIButton(type: .system);
      
      button.setTitle("Show Popover", for: .normal);
      button.addTarget(self,
        action: #selector(onButtonPress(_:)),
        for: .touchUpInside
      );
      
      return button;
    }();
  };
  
  @objc func onButtonPress(_ sender: UIButton!){
    let contentVC = PopoverButtonContentViewController();
    // make as big as possible
    contentVC.preferredContentSize = CGSize(width: 0, height: 0);
    
    let popoverController = PresentAsPopover.configure(for: contentVC);
    popoverController.sourceView = sender;
    popoverController.sourceRect = sender.bounds;
    popoverController.permittedArrowDirections = [.down];
    
    self.present(contentVC, animated: true, completion: nil);
  };
};
