//
//  Model.swift
//  NewsApp
//
//  Created by user on 18/11/2019.
//  Copyright © 2019 Artem Ulko. All rights reserved.
//

import Foundation

var articles: [Article] {
    let data = try? Data(contentsOf: urlToDate)
    if data == nil{
        return []
    }
    
    let rootDictionaryAny = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)
    if rootDictionaryAny == nil{
        return []
    }
    let rootDictionary = rootDictionaryAny as? Dictionary<String,Any>
    if rootDictionary == nil{
        return []
    }
    
    if let array = rootDictionary!["articles"] as? [Dictionary<String,Any>]{
        var returnArray: [Article] = []
        for dict in array{
            let newArticle = Article(dictionary: dict)
            returnArray.append(newArticle)
        }
        return returnArray
    }
    return []
}

var urlToDate: URL{
    let path = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0]+"/data.json"
    let urlPath = URL(fileURLWithPath: path)
    return urlPath
}

func loadNews(completionHandler:(()->Void)?){
    let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=928161ee44754218bf713fd797f17ea7")
    
    let session = URLSession(configuration: .default)
    let dounloadTask = session.downloadTask(with: url!) { (urlFile, responce, error) in
        if urlFile != nil{
            try? FileManager.default.copyItem(at: urlFile!, to: urlToDate)
            completionHandler?()
            
        }
    }
    
    dounloadTask.resume()
}
