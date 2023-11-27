//
//  RandomUserViewModel.swift
//  MVVM_Practice
//
//  Created by 정채은 on 11/27/23.
//

import Foundation

final class RandomUserViewModel {
    var person: [Person] = []
    let userCount = 4
}

extension RandomUserViewModel {
    var numberOfSections: Int {
        return self.person.count
    }
    
    func networkRandomUser(completion: @escaping () -> Void) {
        guard let url = URL(string: "https://randomuser.me/api/") else {
            fatalError("Can't find URL")
        }
        if person.count > 4 {
            self.person = []
        }
        
        for _ in 1...userCount {
            RandomUserService().getRandomPerson(url: url) {
                randomUser in
                if let randomUser = randomUser {
                    let newPerson = Person(name: randomUser.results[0].name.first +  randomUser.results[0].name.last, profileImage: randomUser.results[0].picture.thumbnail, emailAddress: randomUser.results[0].email)
                    print(newPerson)
                    self.person.append(newPerson)
                }
            }
        }
        print(self.person)
        print("❤️")
        if person.count == 4 {
            completion()
        }
    }
}
