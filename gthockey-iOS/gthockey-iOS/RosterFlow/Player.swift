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
    
    init(id_: Int, fn: String, ln:String, pos:String, ht:String, sch:String) {
        id = id_
        firstName = fn
        lastName = ln
        position = pos
        hometown = ht
        school = sch
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
