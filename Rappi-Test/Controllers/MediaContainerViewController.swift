//
//  MediaContainerViewController.swift
//  Rappi-Test
//
//  Created by Pablo de la Rosa Michicol on 4/19/19.
//  Copyright © 2019 CraftCode. All rights reserved.
//

import UIKit


class MediaContainerViewController: UIViewController {

    @IBOutlet weak var mediaSegmentedController: UISegmentedControl!

    @IBOutlet weak var contentView: UIView!
    var currentViewController: UIViewController?
    

    lazy var firstChildTabVC: UIViewController? = {
        let firstChildTabVC = self.storyboard?.instantiateViewController(withIdentifier: "MoviesController") as! MoviesCollectionViewController
        
       // firstChildTabVC.restaurant_id = self.restaurant.id
        
   
        return firstChildTabVC
    }()
    
    lazy var secondChildTabVC : UIViewController? = {
        let secondChildTabVC = self.storyboard?.instantiateViewController(withIdentifier: "SeriesController") as! SeriesCollectionViewController
      //  secondChildTabVC.restaurant_id = self.restaurant.id
        
        return secondChildTabVC
    }()
    
    
    private enum TabIndex : Int {
        case firstChildTab = 0
        case secondChildTab = 1
        case thirdChildTab = 2
        case fourthChildTab = 3
        case fifthChildTab = 4
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     //   mediaSegmentedController.titleForSegment(at: 3)
        
        let searchBar = UISearchBar()
        searchBar.placeholder = "Find your movie"
        searchBar.showsScopeBar = true
        searchBar.barTintColor = UIColor(white: 0.9, alpha: 0.1)

        // To change UISegmentedControl color only when appeared in UISearchBar
        UISegmentedControl.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = .red

        self.navigationItem.titleView = searchBar

    
        mediaSegmentedController.selectedSegmentIndex = TabIndex.firstChildTab.rawValue
        displayCurrentTab(TabIndex.firstChildTab.rawValue)
        mediaSegmentedController.layer.cornerRadius = 5.0
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let currentViewController = currentViewController {
            currentViewController.viewWillDisappear(animated)
        }
    }
    
    // MARK: - Switching Tabs Functions
    
    @IBAction func switchTabs(_ sender: UISegmentedControl) {
        self.currentViewController!.view.removeFromSuperview()
        self.currentViewController!.removeFromParent()
        
        displayCurrentTab(sender.selectedSegmentIndex)
    }
    func displayCurrentTab(_ tabIndex: Int){
        if let vc = viewControllerForSelectedSegmentIndex(tabIndex) {
            
            self.addChild(vc)
            vc.didMove(toParent: self)
            
            vc.view.frame = self.contentView.bounds
            self.contentView.addSubview(vc.view)
            self.currentViewController = vc
        }
    }
    
    func viewControllerForSelectedSegmentIndex(_ index: Int) -> UIViewController? {
        var vc: UIViewController?
        switch index {
        case TabIndex.firstChildTab.rawValue :
            vc = firstChildTabVC
        case TabIndex.secondChildTab.rawValue :
            vc = secondChildTabVC
        default:
            return nil
        }
        
        return vc
    }

}
