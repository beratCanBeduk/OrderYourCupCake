//
//  AddressView.swift
//  GetYourCupCake
//
//  Created by berat can beduk on 7.12.2022.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: Order

    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.myObject.name)
                TextField("Street Address", text: $order.myObject.streetAddress)
                TextField("City", text: $order.myObject.city)
                TextField("Zip", text: $order.myObject.zip)
            }

            Section {
                NavigationLink {
                    CheckoutView(order: order)
                } label: {
                    Text("Check out")
                }
            }.disabled(order.myObject.hasValidAddress == false)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: Order())
    }
}
