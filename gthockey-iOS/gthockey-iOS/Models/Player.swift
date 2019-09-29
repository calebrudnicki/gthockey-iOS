//
//  Player.swift
//  gthockey-iOS
//
//  Created by Dylan Mace on 9/27/19.
//  Copyright © 2019 Caleb Rudnicki. All rights reserved.
//

import Foundation

class Player {
    private var id: Int
    private var firstName: String
    private var lastName: String
    private var position: String
    private var hometown: String
    private var school: String
    
    init(id: Int, firstName: String, lastName:String, position:String, hometown:String, school:String) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.position = position
        self.hometown = hometown
        self.school = school
    }
    
    func get_id() -> Int{
        return id
    }
    
    func get_firstname() -> String{
        return firstName
    }
    
    func get_lastname() -> String{
        return lastName
    }
    
    func get_position() -> String{
        return position
    }
    
    func get_hometown() -> String{
        return hometown
    }
    
    func get_school() -> String{
        return school
    }
    
    
}
