//
//  SplashScreenView.swift
//  MyMood
//
//  Created by Lauro Marinho on 25/04/25.
//

import SwiftUI

struct SplashScreenView: View {
    @Environment(\.colorScheme) var colorScheme // 📍 Detecta claro/escuro

    @State private var animateLogo = false
    @State private var animateMoveUp = false
    @State private var animateTextMoveUp = false
    @State private var showOnboarding = false
    @State private var animateText = false

    var body: some View {
        ZStack {
            // Fundo adaptativo
            LinearGradient(
                gradient: Gradient(stops: [
                    .init(color: backgroundGradientStart, location: 0.0),
                    .init(color: backgroundGradientMiddle, location: 0.5),
                    .init(color: backgroundGradientEnd, location: 1.0)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 20) {
                Spacer()

                // Livro animado
                Image("Onboarding")
                    .resizable()
                    .frame(width: 400, height: 400)
                    .opacity(animateLogo ? 1 : 0)
                    .offset(y: animateMoveUp ? -60 : 0)
                    .shadow(color: dynamicShadowColor, radius: 20, x: 0, y: 10)
                    .animation(.easeInOut(duration: 1.0), value: animateMoveUp)

                // Texto "MyMood"
                if !showOnboarding {
                    Text("MyMood")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(dynamicPurple)
                        .shadow(color: dynamicPurple.opacity(0.3), radius: 6, x: 0, y: 3)
                        .opacity(animateText ? 1 : 0)
                        .offset(y: animateTextMoveUp ? -40 : 0)
                        .animation(.easeInOut(duration: 1.0), value: animateTextMoveUp)
                }

                Spacer()
            }
            .overlay(
                VStack {
                    if showOnboarding {
                        OnboardingView()
                            .transition(.opacity)
                    }
                }
            )
        }
        .onAppear {
            animateLogo = true
            animateText = true

            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                animateMoveUp = true
                animateTextMoveUp = true
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation(.easeInOut(duration: 1.0)) {
                    showOnboarding = true
                }
            }
        }
    }

    // 🎨 Cor adaptativa para fundo (início do gradiente)
    var backgroundGradientStart: Color {
        colorScheme == .dark ? Color.purple.opacity(0.1) : Color.purple.opacity(0.2)
    }

    // 🎨 Cor adaptativa para meio do gradiente
    var backgroundGradientMiddle: Color {
        colorScheme == .dark ? Color(white: 0.2).opacity(0.6) : Color.purple.opacity(0.2)
    }

    // 🎨 Cor adaptativa para fim do gradiente
    var backgroundGradientEnd: Color {
        colorScheme == .dark ? Color(white: 0.3).opacity(0.8) : Color.white
    }

    // 🎨 Roxo adaptativo para texto/botões
    var dynamicPurple: Color {
        colorScheme == .dark ? Color.purple.opacity(0.7) : Color.purple
    }
    
    var dynamicShadowColor: Color {
        colorScheme == .dark ? Color.black.opacity(0.5) : Color.black.opacity(0.2)
    }
}








