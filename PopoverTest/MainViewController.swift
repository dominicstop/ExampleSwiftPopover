//
//  MainViewController.swift
//  PopoverTest
//
//  Created by Dominic Go on 12/3/20.
//

import UIKit;

class MainViewController: UIViewController {
  
  override func loadView() {
    self.view = {
      let view = UIView();
      view.backgroundColor = .systemBackground;
      
      return view;
    }();
    
    let popoverButtonVC = PopoverButtonViewController();
    
    self.addChild(popoverButtonVC);
    self.view.addSubview(popoverButtonVC.view);
    
    popoverButtonVC.view.translatesAutoresizingMaskIntoConstraints = false;
    
    NSLayoutConstraint.activate([
      popoverButtonVC.view.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
      popoverButtonVC.view.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
    ]);
    
    popoverButtonVC.didMove(toParent: popoverButtonVC);
  };
};
