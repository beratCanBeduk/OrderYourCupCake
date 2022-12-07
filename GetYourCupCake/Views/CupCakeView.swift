//
//  CupCakeView.swift
//  GetYourCupCake
//
//  Created by berat can beduk on 7.12.2022.
//

import SwiftUI

struct CupCakeView: View {
    
    @StateObject var order = Order()
    
    var body: some View {
        NavigationView{
            
            
            Form{
                Section {
                    Picker("Select Your Cake Type", selection: $order.myObject.type) {
                        
                      
                        ForEach( Order.types.indices){
                           
                            Text(Order.types[$0])
                        }//ForEach
                    }//Picker */
                   
                    Stepper("Number of Cakes: \(order.myObject.quantity)", value: $order.myObject.quantity, in: 1...20)
                    
                }//First Section
                
                
                Section{
                    Toggle("Any Special Request ? ", isOn: $order.myObject.specialRequestEnabled)
                    
                    if order.myObject.specialRequestEnabled {
                        Toggle("Add extra frosting", isOn: $order.myObject.extraFrosting)
                        
                        Toggle("Add extra sprinkles", isOn: $order.myObject.addSprinkles)
                    }
                }// Second Section
                
                
                Section{
                    VStack{
                        NavigationLink("To Details View", destination: AddressView(order: order))
                        
                    }
                } // Third Section
                
                
                
                .navigationTitle("Cup Cake Order")
                
            }//Form
           
        }//Navigation View
        
    }
}
        struct CupCakeView_Previews: PreviewProvider {
            static var previews: some View {
                CupCakeView()
            }
        }
    

