//
//  ContentView.swift
//  HelloFitness
//
//  Created by Kavin Saravanan on 5/26/25.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        NavigationView {
            TabView(selection: $selectedTab) {
                HomeView()
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                    .tag(0)
                
                FoodLogView()
                    .tabItem {
                        Image(systemName: "fork.knife")
                        Text("Food Log")
                    }
                    .tag(1)
                
                WorkoutsView()
                    .tabItem {
                        Image(systemName: "dumbbell.fill")
                        Text("Workouts")
                    }
                    .tag(2)
                
                SettingsView()
                    .tabItem {
                        Image(systemName: "gearshape.fill")
                        Text("Settings")
                    }
                    .tag(3)
            }
            .navigationTitle("Fitness Pal")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}






//struct FoodLogView: View {
//    var body: some View {
//        VStack {
//            Text("Food Log")
//                .font(.largeTitle)
//                .fontWeight(.bold)
//            Spacer()
//        }
//        .padding()
//    }
//}


struct WorkoutsView: View {
    var body: some View {
        VStack {
            Text("Workouts")
                .font(.largeTitle)
                .fontWeight(.bold)
            Spacer()
        }
        .padding()
    }
}

struct SettingsView: View {
    var body: some View {
        VStack {
            Text("Settings")
                .font(.largeTitle)
                .fontWeight(.bold)
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
