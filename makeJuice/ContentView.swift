// ESTUDANDO DOCUMENTAÇÃO DA APPLE E O OBJETIVO É APLICAR ERROR HANDLING (DOCUMENTATION - THE BASICS PG.15-16)
//  ContentView.swift
//  makeJuice
//
//  Created by Leandro Morais on 2025-07-17.
//

import SwiftUI

@available(iOS 26.0, *)
struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var fruitName: String = ""
    @State private var sizeCupString: String = ""
    @State private var juiceResult: String = ""
    //@State private var sizeCup: String = ""
    @State private var selectedPickerDefault: JuiceSize = .medium
    
    enum JuiceSize: String, CaseIterable, Identifiable {
        case small = "300 ml"
        case medium = "500 ml"
        case large = "1 litro"
        
        var id: String { self.rawValue }
    }
    
    // MARK: - Enum que define os possíveis erros ao fazer suco
    enum JuiceError: Error {
        case noFruit  // Erro para quando nenhuma fruta for informada
        //case noSize  // Erro para quando não informado tamanho do copo
    }
    
    
    // MARK: - Função que tenta fazer o suco
    func makeJuice(from fruit: String) throws -> String {
        // Verifica se a fruta está vazia
        guard !fruit.isEmpty else {
            // Lança um erro se nenhuma fruta foi informada
            throw JuiceError.noFruit
        }
        // Se deu tudo certo, retorna o "suco"
        return "🍹 Suco de \(fruit.capitalized) está sendo preparado!"
    }
    
    var body: some View {
        VStack(spacing: 20) {
            
            Text("🍊 Qual suco?")
                .font(.title)
                .bold()
            
            TextField("Digite o nome da fruta", text: $fruitName)
                .padding()
                .glassEffect(.regular, in: RoundedRectangle(cornerRadius: 16))
            
            Picker("Tamanho do copo", selection: $selectedPickerDefault) {
                ForEach(JuiceSize.allCases) { cup in
                    Text("\(cup.rawValue)")
                        .tag(cup)
                }
            }
            .pickerStyle(.segmented)
            .padding()
            
            Button("Solicitar Suco") {
                do {
                    let result = try makeJuice(from: fruitName)
                    juiceResult = result
                } catch JuiceError.noFruit {
                    juiceResult = "❌ Você precisa escolher uma fruta!"
                } catch {
                    juiceResult = "❌ Erro inesperado: \(error.localizedDescription)"
                }
            }
            .padding(20)
            .glassEffect(.regular.interactive().tint(colorScheme == .dark ? .green.opacity(0.5) : .green.opacity(0.9)))
            .font(.title)
            .bold()
            
            Spacer()
            
            // Exibe o resultado
            Text(juiceResult)
                .padding()
                .multilineTextAlignment(.center)
            
            Spacer()
        }
        .padding()
        .foregroundColor(colorScheme == .dark ? .white.opacity(0.8) : .black.opacity(0.8))
    }
}

// MARK: - Preview no canvas
#Preview {
    ContentView()
}

