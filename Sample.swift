//
//  Sample.swift
//  ShipDone
//
//  Created by Nexibit on 5/2/22.
//  Copyright © 2022 ShipDone Inc. All rights reserved.
//

import SwiftUI

struct Sample: View {
    
    @State var providerDataController = ProviderDataController()
    @State var name: String = ""
    @State var Image: String = ""
    @State var providerData = [Values]()
    @State var flag: Bool = false
    var body: some View {
        VStack{
            VStack{
                if providerData.count ?? 0 > 0{
                    ForEach(providerData, id: \.self) { homeData in
                        if homeData.type == "category" {
                            ScrollView(.horizontal){
                                HStack{
                                    ForEach(homeData.values!, id: \.self) { values in
                                        VStack{
                                           /* Image("")
                                            .resizable()
                                            .clipShape(Circle())
                                            .frame(width: 30, height: 30)*/
                                           
                                            Text(values.name ?? "no")
                                        }
                                    }
                                }.padding(.leading, 10)
                            }
                            
                        }
                        else if homeData.type == "banners" {
                            ForEach(homeData.values!, id: \.self) { values in
                              /*  Image("")
                                    .resizable()
                                    .clipShape(Circle())
                                    .frame(width: 80, height: 80)*/
                            }
                        }
                        else if homeData.type == "products" {
                            ScrollView(.horizontal){
                                HStack{
                                ForEach(homeData.values!, id: \.self) { values in
                                  /*  Image(uiImage: (UIImage(data: Helper().convertBase64ToImage1(imageString: values.image_url))!))
                                        .resizable()
                                        .clipShape(Circle())
                                        .frame(width: 80, height: 80)*/
                                    VStack{
                                        VStack{
                                        HStack{
                                            if values.offer ?? 0 > 0 {
                                                Text("\(values.offer!) % OFF")
                                                    .foregroundColor(Color.white)
                                                    .background(Color.red)
                                                        Spacer()
                                            }
                                        }
                                        HStack{
                                            Spacer()
                                           /* Image("")
                                                .resizable()
                                                .clipShape(Circle())
                                                .frame(width: 80, height: 80)*/
                                            Spacer()
                                        }
                                       /* HStack{
                                        if values.is_express{
                                                    Spacer()
                                                   /* Image("")
                                                        .resizable()
                                                        .clipShape(Circle())
                                                        .frame(width: 80, height: 80)*/
                                                    Spacer()
                                        }
                                            
                                        }*/
                                        }
                                        VStack{
                                        HStack{
                                            Text(values.actual_price ?? "")
                                            Spacer()
                                        }
                                            HStack{
                                        if values.actual_price != values.offer_price {
                                            HStack{
                                                Text(values.offer_price ?? "")
                                                Spacer()
                                                }
                                        }
                                            }
                                        HStack{
                                            Text(values.name ?? "")
                                            Spacer()
                                        }
                                        }
                                    }.padding(.all, 15)
                                
                                }
                                }
                            }
                        }
                    }
                }
            }
        }
        .onAppear{
            self.getDetails()
        }
    }
    func getDetails(){
        let group = DispatchGroup()
        self.providerDataController.getDetails(group: group)
        group.notify(queue: .main) {
            self.providerData = self.providerDataController.providerEntity.homeData ?? []
            self.flag = true
        }
    }
}

struct Sample_Previews: PreviewProvider {
    static var previews: some View {
        Sample()
    }
}
