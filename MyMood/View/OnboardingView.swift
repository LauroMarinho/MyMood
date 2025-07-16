//
//  OnboardingView.swift
//  MyMood
//
//  Created by Lauro Marinho on 21/04/25.
//

import SwiftUI

struct OnboardingView: View {
    @Environment(\.colorScheme) var colorScheme // 📍 Detectar claro/escuro

    @State private var animateText = false
    @State private var animateButton = false
    @State private var showHome = false
    let message = onboardingMessages.randomElement() ?? "Welcome!"

    var body: some View {
        ZStack {
            // Fundo degradê adaptativo
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

            VStack {
                Spacer()

                // Espaço reservado para o livro
                Spacer().frame(height: 400)

                // Texto inspirador
                Text(message)
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .opacity(animateText ? 1 : 0)
                    .animation(.easeIn(duration: 1.5).delay(0.3), value: animateText)

                Spacer()

                // Botão "Let's Start" na parte inferior
                Button {
                    showHome = true
                } label: {
                    Text("Let’s Start")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.purple)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .padding(.horizontal, 40)
                        .padding(.bottom, 40)
                }
                .scaleEffect(animateButton ? 1 : 0.8)
                .animation(.interpolatingSpring(stiffness: 100, damping: 10).delay(0.5), value: animateButton)
            }
        }
        .fullScreenCover(isPresented: $showHome) {
            HomeView()
        }
        .onAppear {
            animateText = true
            animateButton = true
        }
    }

    // 🎨 Gradiente adaptativo
    var backgroundGradientStart: Color {
        colorScheme == .dark ? Color.purple.opacity(0.1) : Color.purple.opacity(0.2)
    }

    var backgroundGradientMiddle: Color {
        colorScheme == .dark ? Color(white: 0.2).opacity(0.6) : Color.purple.opacity(0.2)
    }

    var backgroundGradientEnd: Color {
        colorScheme == .dark ? Color(white: 0.3).opacity(0.8) : Color.white
    }
}













