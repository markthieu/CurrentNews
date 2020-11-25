//
//  NewsManager.swift
//  CurrentNews
//
//  Created by Marmago on 12/11/2020.
//

import Foundation

protocol NewsManagerDelegate {
    func didUpdateNews(_ newsManager: NewsManager,articleArray: [NewsModel])
    func didFailWithError(error: Error)
}

struct NewsManager{
    
    let newsURL = "https://api.currentsapi.services/v1/latest-news?language="
    let apikey = "&apiKey="+K.apiKey
    
    var delegate: NewsManagerDelegate?
    
    
    func fetchNews(in language: String){
        //let urlString = newsURL+apikey
        let urlString = newsURL + language + apikey
        performRequest(with: urlString)
    }
    func performRequest(with urlString: String){
        //create a URL
        if let url = URL(string: urlString){
            //create a url session
            let session = URLSession(configuration: .default)
            //give session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil{
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data{
                    if let currentArray = self.parseJSON(safeData){
                        self.delegate?.didUpdateNews(self, articleArray: currentArray)
                    }
                }

            }
            //start the task
            task.resume()
        }
    }
    //Parse JSON Data
    func parseJSON(_ data: Data) -> [NewsModel]?{
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(NewsData.self, from: data)
            var articleArray = [NewsModel]()
            //Load every news article into an array
            for article in decodedData.news{
                articleArray.append(NewsModel(title: article.title, url: article.url))
            }

            return articleArray
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    
    
}
