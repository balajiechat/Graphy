//
//  GADataManager.swift
//  GraphyAssignment
//
//  Created by Balaji S on 05/05/20.
//  Copyright © 2020 balaji. All rights reserved.
//

import UIKit
import  CoreData

enum HeaderKeyField: String {
    case contentType = "Content-Type"
}

enum HeaderValueField: String {
    case contentType = "application/json"
}

enum NetworkError: Error {
    case decodingError
    case domainError
    case urlError
}

enum HttpMethod: String {
    case get
}

struct Resource<T: Codable> {
    let url: URL
    var httpMethod: HttpMethod = .get
    var body: Data?

    init(url: URL) {
        self.url = url
    }
}

class GADataManager {

    static func fetchDataFromServer<T>(resource: Resource<T>, completion: @escaping (Result<T, NetworkError>) -> Void) {
        var request = URLRequest(url: resource.url)
        request.httpMethod = resource.httpMethod.rawValue.uppercased()
        request.httpBody = resource.body
        request.addValue(HeaderValueField.contentType.rawValue, forHTTPHeaderField: HeaderKeyField.contentType.rawValue)

        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(.domainError))
                return
            }

            do {
                guard let data = String(decoding: data, as: UTF8.self).data(using: .utf8) else { return }
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(.success(result))
            } catch {
                print(error)
                completion(.failure(.decodingError))
            }

            }.resume()
    }

    static func updateToDB(homeModels: [GAHomeList]) {
        let context: NSManagedObjectContext = GACoreDataModel.sharedDataModel.privateManagedContext
        for model in homeModels {
            let entity = NSEntityDescription.entity(forEntityName: "GAVideo", in: context)
            let video = NSManagedObject(entity: entity!, insertInto: context) as! GAVideo
            video.id = Int64(model.id)
            video.title = model.title
            video.subTitle = model.description
            video.image = model.image
            video.video = model.video
        }

        do {
            try context.save()
        } catch {
            debugPrint("Failed saving")
        }
    }

    static func fetchFromDB(completion: (_ videos: [GAVideo]?) -> Void) {
        let context: NSManagedObjectContext = GACoreDataModel.sharedDataModel.privateManagedContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "GAVideo")
        request.returnsObjectsAsFaults = false
        do {
            if let result = try context.fetch(request) as? [GAVideo] {
                completion(result)
            } else {
                completion(nil)
            }
        } catch {
            print("Failed")
            completion(nil)
        }
    }

}
