//
//  CheckoutView.swift
//  GetYourCupCake
//
//  Created by berat can beduk on 7.12.2022.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    
    var body: some View {
        ScrollView{
            VStack{
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"),scale: 3){image in
                    image.resizable().scaledToFit()
                        
                    
                } placeholder: {
                    ProgressView()
                }
                .frame(height:233)
                Text("Your total is \(order.myObject.cost, format: .currency(code: "USD"))")
                    .font(.title)
                Button("Place Order", action: {
                    Task{
                        await placeOrder()
                    }
                }
                )
                          .padding()
            }//VStack
            .navigationTitle("Check out")
            .alert("Thank you!", isPresented: $showingConfirmation) {
                Button("OK") { }
            } message: {
                Text(confirmationMessage)
            }
            .navigationBarTitleDisplayMode(.inline)
        }//Scroll View
    }//ContentView
    
    
    func placeOrder() async {
        let encoder = JSONEncoder()
        
        guard let encoded = try? encoder.encode(order) else {
            print("Failed to encode order")
              return
        }
        
        guard let url =  URL(string: "https://reqres.in/api/cupcakes")else{
           print("Someting")
           return
        }
        var request = URLRequest(url: url)
        request.setValue("application/Json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "Your order for \(decodedOrder.myObject.quantity)x \(Order.types[decodedOrder.myObject.type].lowercased()) cupcakes is on its way!"
            showingConfirmation = true
        } catch {
            print("Checkout failed.")
        }
    }
}



struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
