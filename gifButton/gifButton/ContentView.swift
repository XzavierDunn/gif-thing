//
//  ContentView.swift
//  gifButton
//
//  Created by Xzavier dunn on 6/6/20.
//  Copyright © 2020 Xzavier Dunn. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    
    struct Message: Codable {
        var message: String
    }
    
    var body: some View {
        
        VStack {
        Button(action: {
            self.change()
        }) {
            Text("New Gif?")
        }
        }.navigationBarTitle("Gif")
        .alert(isPresented: $showingConfirmation) { Alert(title: Text("Thank you!"), message: Text(confirmationMessage), dismissButton: .default(Text("OK"))) }
        
    }
    func change() {
        NSLog("hit change")
        let url = URL(string: "http:// your ip :5000/")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown error").")
                return
            }
            
            if let decodedOrder = try? JSONDecoder().decode(Message.self, from: data) {
                self.confirmationMessage = "\(decodedOrder.message)"
                self.showingConfirmation = true
            } else {
                print("Invalid response from server")
            }
            
        }.resume()
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
