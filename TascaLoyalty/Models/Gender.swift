//
//  Gender.swift
//  TascaLoyalty
//
//  Created by Azka Kusuma Edy on 22/01/21.
//

import Foundation
protocol prepareNembakDelegate {
    func siapNembak(name: String, nomerTelfon: String, birthDate: String, gender: String, password: String)
}
struct Gender {

    var gender = ["","Cowok", "Cewek"]
}
