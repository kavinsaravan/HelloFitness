//
//  FoodLog.swift
//  HelloFitness
//
//  Created by Kavin Saravanan on 5/26/25.
//

import Foundation
import SwiftUI

struct FoodEntry {
    let id = UUID()
    let foodName: String
    let description: String?
    let mealType: MealType
    let time: String
}

enum MealType: String, CaseIterable {
    case breakfast = "Breakfast"
    case lunch = "Lunch"
    case dinner = "Dinner"
    case snack = "Snack"
}

struct FoodLogView: View {
    @State private var foodEntries = [
        FoodEntry(foodName: "Greek Yogurt with Berries", description: "Plain Greek yogurt with mixed berries and honey", mealType: .breakfast, time: "7:30 AM"),
        FoodEntry(foodName: "Oatmeal", description: nil, mealType: .breakfast, time: "8:15 AM"),
        FoodEntry(foodName: "Apple", description: nil, mealType: .snack, time: "10:30 AM"),
        FoodEntry(foodName: "Grilled Chicken Salad", description: "Mixed greens with grilled chicken, cherry tomatoes, and balsamic dressing", mealType: .lunch, time: "12:45 PM"),
        FoodEntry(foodName: "Protein Bar", description: "Chocolate peanut butter protein bar", mealType: .snack, time: "3:20 PM"),
        FoodEntry(foodName: "Salmon with Quinoa", description: "Baked salmon with quinoa and steamed broccoli", mealType: .dinner, time: "6:30 PM"),
        FoodEntry(foodName: "Dark Chocolate", description: nil, mealType: .snack, time: "8:45 PM")
    ]
    
    @State private var showingAddSheet = false
    
    var body: some View {
        ZStack {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 12) {
                    ForEach(foodEntries, id: \.id) { entry in
                        FoodEntryRow(entry: entry)
                    }
                }
                .padding()
                .padding(.bottom, 80) // Add space for the floating button
            }
            
            // Floating Add Button
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        showingAddSheet = true
                    }) {
                        Text("Add")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 12)
                            .background(Color.blue)
                            .cornerRadius(25)
                            .shadow(radius: 5)
                    }
                    .padding(.trailing, 20)
                    .padding(.bottom, 20)
                }
            }
        }
        .sheet(isPresented: $showingAddSheet) {
            AddFoodEntryView { newEntry in
                foodEntries.append(newEntry)
            }
        }
    }
}

struct AddFoodEntryView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var foodName = ""
    @State private var description = ""
    @State private var selectedMealType = MealType.breakfast
    @State private var selectedTime = Date()
    
    let onSave: (FoodEntry) -> Void
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Food Details")) {
                    TextField("Food Name", text: $foodName)
                    TextField("Description (Optional)", text: $description)
                }
                
                Section(header: Text("Meal Information")) {
                    Picker("Meal Type", selection: $selectedMealType) {
                        ForEach(MealType.allCases, id: \.self) { mealType in
                            Text(mealType.rawValue).tag(mealType)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    DatePicker("Time", selection: $selectedTime, displayedComponents: .hourAndMinute)
                }
            }
            .navigationTitle("Add Food Entry")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        let timeFormatter = DateFormatter()
                        timeFormatter.dateFormat = "h:mm a"
                        
                        let newEntry = FoodEntry(
                            foodName: foodName,
                            description: description.isEmpty ? nil : description,
                            mealType: selectedMealType,
                            time: timeFormatter.string(from: selectedTime)
                        )
                        
                        onSave(newEntry)
                        dismiss()
                    }
                    .disabled(foodName.isEmpty)
                }
            }
        }
    }
}

struct FoodEntryRow: View {
    let entry: FoodEntry
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(entry.foodName)
                .font(.headline)
                .fontWeight(.medium)
            
            if let description = entry.description {
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            HStack {
                Text(entry.mealType.rawValue)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 2)
                    .background(mealTypeColor(entry.mealType))
                    .foregroundColor(.white)
                    .cornerRadius(8)
                
                Spacer()
                
                Text(entry.time)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
    
    func mealTypeColor(_ mealType: MealType) -> Color {
        switch mealType {
        case .breakfast:
            return .orange
        case .lunch:
            return .green
        case .dinner:
            return .blue
        case .snack:
            return .purple
        }
    }
}
