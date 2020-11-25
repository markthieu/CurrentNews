//
//  NewsData.swift
//  CurrentNews
//
//  Created by Marmago on 12/11/2020.
//

import Foundation

struct NewsData: Decodable{
    let news: [News]
}
struct News: Decodable{
    let title: String
    let url: String
}
