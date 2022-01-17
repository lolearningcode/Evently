//
//  ContentView.swift
//  Evently
//
//  Created by Cleo Howard on 1/12/22.
//

import SwiftUI

struct NewsView: View {
    
    @StateObject var viewModel = EventViewModel()
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                List(viewModel.events) { event in
                    
                    EventsRemoteImage(urlString: event.imageURL)
//                    event.image
//                        .resizable()
//                        .scaledToFit()
//    //                    .frame(width: 250, height: 200)
//                        .clipped()
                    
                    Text(event.name)
                        .font(.title2)
                        .fontWeight(.bold)
                                    
                    Text("Starting in \(event.timeStart) minutes")
                        .font(.subheadline)
                }
                EventRow(events: viewModel.events, headerText: "Your upcoming events")
                
                EventRow(events: viewModel.events, headerText: "Explore upcoming events")
            }
        }
        .navigationTitle("Events")
        .onAppear {
            viewModel.getEvents()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
    }
}

struct EventRow: View {
    
    var events: [Events]
    var headerText: String
 
    var body: some View {
        VStack(alignment: .leading) {
            Text(headerText)
                .font(.headline)
                .padding(.leading, 15)
                .padding(.top, 5)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 0) {
                    ForEach(events) { event in
                        VStack {
                            EventsRemoteImage(urlString: event.imageURL)
                                .frame(width: 155, height: 155)
                                .cornerRadius(8)
                            
                            
                            Text(event.name)
                                .font(.caption)
                        }
                    }
                    .padding(.leading, 15)
                }
            }
            .frame(height: 200)
        }
    }
}
