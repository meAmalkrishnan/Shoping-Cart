//
//  ProviderDataController.swift
//  ShipDone
//
//  Created by Nexibit on 5/2/22.
//  Copyright © 2022 ShipDone Inc. All rights reserved.
//

import Foundation

public class ProviderDataController : ObservableObject {
    @Published var providerEntity = HomeData()
    
    func getDetails(group: DispatchGroup){
        guard let url = URL(string: "https://run.mocky.io/v3/69ad3ec2-f663-453c-868b-513402e515f0")
        else{ return }
        group.enter()
        let task = URLSession.shared.dataTask(with: url){ (data, response, error) in
            if(error != nil) {
                print(error!.localizedDescription)
            }
            guard let data = data else{ return }
            do{
                if let TransactionResponse = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]{
                    print("Response- \(TransactionResponse)")
                }
            }
            catch{
            print("Error- \(error)")
            }
            do{
                let baseData = try JSONDecoder().decode(HomeData.self, from: data)
                DispatchQueue.main.async {
                    self.providerEntity = baseData
                    group.leave()
                }
            }catch{
                print(error)
            }
        }
        task.resume()
    }
}
