//
//  ContentView.swift
//  Shoping

import SwiftUI

struct ContentView: View {
    @State var providerDataController = ProviderDataController()
    @State var providerData = [Values]()
    var body: some View {
        VStack{
            if providerData.count ?? 0 > 0{
                ForEach(providerData, id: \.self) { homeData in
                    if homeData.type == "category" {
                        ScrollView(.horizontal){
                            HStack{
                                ForEach(homeData.values!, id: \.self) { values in
                                    VStack{
                                        VStack{
                                            AsyncImage(url: URL(string: values.image_url!), content: { image in
                                                image
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: 60, height: 60)
                                                
                                            }, placeholder: {
                                                ProgressView()
                                            })
                                        }.background(Color.gray)
                                        .clipShape(Circle())
                                       
                                        Text(values.name ?? "no")
                                            .padding(.top, 10)
                                    }
                                }
                            }.padding(.leading, 10)
                        }
                        
                    }
                    else if homeData.type == "banners" {
                        ScrollView(.horizontal){
                            HStack{
                                ForEach(homeData.values!, id: \.self) { values in
                                    HStack(spacing: 10){
                                        AsyncImage(url: URL(string: values.banner_url!), content: { image in
                                            image.resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: UIScreen.main.bounds.width-40, height: UIScreen.main.bounds.width/1.5)
                                        }, placeholder: {
                                            ProgressView()
                                        })
                                    }
                                }
                            }.padding(.leading, 10)
                        }
                    }
                    else if homeData.type == "products" {
                        ScrollView(.horizontal){
                            HStack{
                                VStack{
                                    HStack{
                                        ForEach(homeData.values!, id: \.self) { values in
                                            VStack{
                                                VStack{
                                                    HStack{
                                                        if values.offer ?? 0 > 0 {
                                                            Text("\(values.offer!) % OFF")
                                                                .foregroundColor(Color.white)
                                                                .background(Color.red)
                                                                    Spacer()
                                                        }
                                                        else{
                                                            Text("")
                                                        }
                                                        Spacer()
                                                    }
                                                    HStack{
                                                        AsyncImage(url: URL(string: values.image!), content: { image in
                                                            image.resizable()
                                                                .aspectRatio(contentMode: .fit)
                                                                .frame(width: 120, height: 130)
                                                        }, placeholder: {
                                                            ProgressView()
                                                        })
                                                    }
                                                    HStack{
                                                        if values.is_express == true{
                                                            Image("truck")
                                                                .resizable()
                                                                .aspectRatio(contentMode: .fit)
                                                                .frame(width: 20, height: 18)
                                                                .background(Color.yellow)
                                                        }
                                                        else{
                                                            Image("")
                                                                .resizable()
                                                                .aspectRatio(contentMode: .fit)
                                                                .frame(width: 20, height: 18)
                                                        }
                                                        Spacer()
                                                    }
                                                    HStack{
                                                        if values.actual_price != values.offer_price {
                                                            Text(values.actual_price ?? "")
                                                                .overlay( Divider().foregroundColor(.black)
                                                                            .frame(height: 2)
                                                                )
                                                        }
                                                        else{
                                                            Text(values.actual_price ?? "")
                                                        }
                                                        Spacer()
                                                    }
                                                    HStack{
                                                        if values.actual_price != values.offer_price {
                                                            Text(values.offer_price ?? "")
                                                            .fontWeight(.bold)
                                                            .font(.system(size: 18))
                                                        }
                                                        else{
                                                            Text("")
                                                                .font(.system(size: 18))
                                                        }
                                                        Spacer()
                                                    }
                                                    HStack{
                                                        Text(values.name ?? "")
                                                        Spacer()
                                                    }
                                                    HStack{
                                                        Spacer()
                                                        Button(action: { }){
                                                            HStack{
                                                                Spacer()
                                                                Text("ADD")
                                                                    .fontWeight(.bold)
                                                                    .font(.system(size: 20))
                                                                    .foregroundColor(.white)
                                                                    .padding(.vertical, 10)
                                                                    .padding(.horizontal, 10)
                                                                Spacer()
                                                            }.background(Color.green)
                                                                .cornerRadius(5)
                                                                .frame(width: 100, height: 30)
                                                        }
                                                        Spacer()
                                                    }.padding(.bottom, 15)
                                                        .padding(.top, 15)
                                                }.padding(.all, 10)
                                            }.frame(width: (UIScreen.main.bounds.width/2)-30)
                                            .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray))
                                            .padding(.horizontal, 10)
                                            
                                        }
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
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
