//
//  RandomUserViewModel.swift
//  MVVM_Practice
//
//  Created by 정채은 on 11/27/23.
//

import Foundation

final class RandomUserViewModel {
    var person: [Person] = []

}

extension RandomUserViewModel {
    var numberOfSections: Int {
        return self.person.count
    }
    
    func networkRandomUser() {
        guard let url = URL(string: "https://randomuser.me/api/") else {
            fatalError("Can't find URL")
        }
        
        RandomUserService().getRandomPerson(url: url) {
            randomUser in
            if let randomUser = randomUser {
                let newPerson = Person(name: randomUser.results[0].name.first +  randomUser.results[0].name.last, profileImage: randomUser.results[0].picture.thumbnail, emailAddress: randomUser.results[0].email)
                self.person.append(newPerson)
            }
        }
        print(self.person)
        print("❤️")
    }
}
