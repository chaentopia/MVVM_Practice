//
//  RandomUserService.swift
//  MVVM_Practice
//
//  Created by 정채은 on 11/27/23.
//

import Foundation

class RandomUserService {
    func getRandomPerson(url: URL, completion: @escaping (RandomUserResponseDTO?) -> ()) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            }
            else if let data = data {
                let personList = try? JSONDecoder().decode(RandomUserResponseDTO.self, from: data)
                if let personList = personList {
                    completion(personList)
                }
            }
        }.resume()
    }
}
