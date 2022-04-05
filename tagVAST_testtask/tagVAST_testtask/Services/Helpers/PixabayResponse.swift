//
//  PixabayResponse.swift
//  tagVAST_testtask
//
//  Created by Sergey Verlygo on 05/04/2022.
//

import Foundation


enum Pixabay {

    struct Response: Codable {
        var total: Int
        var totalHits: Int
        var hists: [Hit]
    }

    struct Hit: Codable {
        var id: Int
        var pageURL: String
        var type: String // TODO: make enum
        var tags: String
        var duration: Decimal
        var picture_id: String
        var videos: [Video]
        var views: Int
        var downloads: Int
        var likes: Int
        var comments: Int
        var user_id: Int
        var user: String
        var userImageURL: String
    }
    
    struct Video: Codable {
        var large: VideoItem
        var medium: VideoItem
        var small: VideoItem
        var tiny: VideoItem
    }
    
    struct VideoItem: Codable {
        var url: String
        var width: Int
        var height: Int
        var size: Int
    }

}

