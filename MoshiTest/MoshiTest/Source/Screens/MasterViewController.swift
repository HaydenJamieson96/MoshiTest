//
//  MasterViewController.swift
//  MoshiTest
//
//  Created by Hayden Jamieson on 05/07/2020.
//  Copyright © 2020 Hayden Jamieson. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController {
    
    private let viewModel = MasterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBarProperties()
        
        viewModel.getLatestAlbumReleases()
    }
    
    private func setNavigationBarProperties() {
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        title = "New Album Releases"
    }
}
