//
//  MusicService.swift
//  MoshiTest
//
//  Created by Hayden Jamieson on 04/07/2020.
//  Copyright © 2020 Hayden Jamieson. All rights reserved.
//

import Foundation

protocol MusicService {
    
    func getNewAlbumReleases(_ completion: @escaping (_ albums: Albums?) -> Void)
}
