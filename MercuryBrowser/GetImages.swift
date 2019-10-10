//
//  BuildImageList.swift
//  MercuryBrowser
//
//  Created by Amelia on 06/10/2019.
//  Copyright © 2019 Russell Mirabelli. All rights reserved.
//

import UIKit

struct ImageFetcher {
    func getImage(urlString: String, completion: @escaping ((UIImage, URL)->Void)) {
        let url = URL(string: urlString)
        let session = URLSession(configuration: .ephemeral)
        let task = session.dataTask(with: url!) { (data, response, error) in
            if let data = data{
                let img = UIImage(data: data)
                completion(img!, url!)
            }
        }
        task.resume()
    }
}



struct MercuryList: Codable { //list of JSON objects not images
    let mercury: [MercuryObject]
}

struct MercuryObject: Codable {
    let name: String
    let type: String
    let url: String
}

struct MercuryObjectFetcher {

    let urlString = "https://raw.githubusercontent.com/rmirabelli/mercuryserver/master/mercury.json"
        

    func getData(completion: @escaping (([MercuryObject]) -> Void)) {
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .ephemeral)
            let task = session.dataTask(with: url) { (data, response, error) in
                let mercuryList = try! JSONDecoder().decode(MercuryList.self, from: data!)
                completion(mercuryList.mercury)
            }
            task.resume()
        }
    }


}
