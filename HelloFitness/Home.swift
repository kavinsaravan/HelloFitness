//
//  Home.swift
//  HelloFitness
//
//  Created by Kavin Saravanan on 5/26/25.
//

import Foundation
import SwiftUI

struct HomeView: View {
    let breakfastRecommendations = [
            RecommendedFood(name: "Overnight Oats", description: "Rolled oats with Greek yogurt, chia seeds, and berries", calories: "320 cal"),
            RecommendedFood(name: "Avocado Toast", description: "Whole grain bread with mashed avocado and hemp seeds", calories: "280 cal"),
            RecommendedFood(name: "Protein Smoothie", description: "Banana, spinach, protein powder, and almond milk", calories: "250 cal"),
            RecommendedFood(name: "Greek Yogurt Bowl", description: "Plain Greek yogurt with granola and mixed berries", calories: "290 cal")
        ]
        
        let lunchRecommendations = [
            RecommendedFood(name: "Quinoa Buddha Bowl", description: "Quinoa with roasted vegetables and tahini dressing", calories: "420 cal"),
            RecommendedFood(name: "Grilled Chicken Salad", description: "Mixed greens with grilled chicken and balsamic vinaigrette", calories: "380 cal"),
            RecommendedFood(name: "Lentil Soup", description: "Red lentil soup with vegetables and whole grain roll", calories: "350 cal"),
            RecommendedFood(name: "Turkey Wrap", description: "Whole wheat tortilla with turkey, hummus, and vegetables", calories: "390 cal")
        ]
        
        let dinnerRecommendations = [
            RecommendedFood(name: "Baked Salmon", description: "Herb-crusted salmon with quinoa and steamed broccoli", calories: "480 cal"),
            RecommendedFood(name: "Chicken Stir-Fry", description: "Chicken breast with mixed vegetables over brown rice", calories: "450 cal"),
            RecommendedFood(name: "Vegetable Curry", description: "Mixed vegetable curry with chickpeas and basmati rice", calories: "420 cal"),
            RecommendedFood(name: "Lean Beef Bowl", description: "Grass-fed beef with sweet potato and green beans", calories: "510 cal")
        ]
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Welcome Message
                Text("Hello!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                
                Text("Here are some healthy meal recommendations for today:")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding(.horizontal)
                
                // Breakfast Section
                MealRecommendationSection(
                    title: "Breakfast",
                    recommendations: breakfastRecommendations,
                    color: .orange
                )
                
                // Lunch Section
                MealRecommendationSection(
                    title: "Lunch",
                    recommendations: lunchRecommendations,
                    color: .green
                )
                
                // Dinner Section
                MealRecommendationSection(
                    title: "Dinner",
                    recommendations: dinnerRecommendations,
                    color: .blue
                )
                
                Spacer(minLength: 20)
            }
        }
    }
}
struct RecommendedFood {
    let name: String
    let description: String
    let calories: String
}


struct MealRecommendationSection: View {
    let title: String
    let recommendations: [RecommendedFood]
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(title)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(color)
                Spacer()
            }
            .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(recommendations, id: \.name) { food in
                        RecommendedFoodCard(food: food, color: color)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}
struct RecommendedFoodCard: View {
    let food: RecommendedFood
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(food.name)
                .font(.headline)
                .fontWeight(.semibold)
                .multilineTextAlignment(.leading)
            
            Text(food.description)
                .font(.caption)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.leading)
                .lineLimit(3)
            
            Spacer()
            
            HStack {
                Spacer()
                Text(food.calories)
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(color)
            }
        }
        .padding()
        .frame(width: 180, height: 120)
        .background(Color(.systemGray6))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(color.opacity(0.3), lineWidth: 1)
        )
    }
}
