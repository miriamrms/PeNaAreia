//
//  ContentView.swift
//  PeNaAreia
//
//  Created by Miriam Mendes on 26/08/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            ZStack {
                Color("backgroundsand")
                
                ZStack {
                    VStack {
                        Image("fotoBarracaTemp")
                            .frame(width: 393.0, height: 291.0)
                        Spacer()
                    }
                    
                    VStack {
                        HStack {
                            Image("back.ic")
                                .padding(.leading, 25.0)
                                .padding(.top, 40.0)
                            Spacer()
                        }
                        Spacer()
                    }
                }
                .edgesIgnoringSafeArea(.top)

                
                VStack(alignment: .center) {
                    Spacer()
                    ZStack {
                        Image("BackgroundBarracas")
                            .resizable()
                            .scaledToFill()
                            .frame(height: 596.0)
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
//MARK: - Infos Barraca
//Tudo abaixo da imagem da barraca
                        VStack {
                            
                            HStack {
                                Spacer()
                                Image("like.ic")
                                    .padding(.trailing, 26.0)
                            }
                            
                            VStack {
                                HStack {
                                        Text("Nome da Barraca")
                                            .font(.system(size: 34))
                                            .fontDesign(.rounded)
                                            .fontWeight(.bold)
                                            .foregroundColor(Color.darkblue)
                                        
                                        VStack {
                                            Image("lotacaoBaixa.ic")
                                            
                                            Text("Lotação há 2min")
                                                .font(.system(size: 12))
                                                .fontDesign(.rounded)
                                                .fontWeight(.light)
                                                .foregroundColor(Color.darkblue)
                                        }
                                }
                                
                                //localização
                                HStack {
                                    Link(destination: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=URL@*/URL(string: "https://www.apple.com")!/*@END_MENU_TOKEN@*/) {
                                                                    Image(systemName: "map")
                                                                    Text("2,4km de distância")
                                            .underline()
                                            .font(.system(size: 16))
                                            .fontDesign(.rounded)
                                            .fontWeight(.light)
                                        
                                    }
                                    Spacer()
                                }
                                .padding(.leading)
                            }
                            
                            VStack{
                                HStack {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 15)
                                            .frame(width: 144.0, height: 29.0)
                                        .foregroundColor(.lightblue)
                                        
                                        HStack {
                                            //colocar chuveiro
                                            Text(/*@START_MENU_TOKEN@*/"Placeholder"/*@END_MENU_TOKEN@*/)
                                        }
                                    }
                                    
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 15)
                                            .frame(width: 144.0, height: 29.0)
                                        .foregroundColor(.lightblue)
                                    }
                                    
                                }
                            }
                            }
                        
                        
                        }
                    }
                }
                .edgesIgnoringSafeArea(.bottom)
            }
            
        }
    }

#Preview {
    ContentView()
}
