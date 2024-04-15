//
//  ImageModel.swift
//  PhotoGallery
//
//  Created by PujaRaj on 15/04/24.
//

import Foundation


struct ImageModel : Codable{
    
    let urls : Urls
    
}

struct Urls : Codable{
    
    let regular : String
    var regularUrl : URL {
        return URL(string : regular)!
    }
}
