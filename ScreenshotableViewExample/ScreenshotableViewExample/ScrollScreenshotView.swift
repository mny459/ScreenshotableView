//
//  ScrollScreenshotView.swift
//  ScreenshotableViewExample
//
//  Created by Rickey on 2024/6/19.
//

import SwiftUI
import ScreenshotableView
import Kingfisher
/// 生成随机颜色
/// generate random color
extension Color {
    static var random: Color {
        return Color(red: .random(in: 0...1),
                     green: .random(in: 0...1),
                     blue: .random(in: 0...1))
    }
}

struct ScrollScreenshotView: View {
    @State var shotting = false
    @State var screenshot: Image? = nil
    @State var showResult = false
    
    let colors = generateRandomColors()
    let testImages = [
       "https://images.unsplash.com/photo-1703340021750-01c37e25d891?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHx0b3BpYy1mZWVkfDI3fHFQWXNEenZKT1ljfHxlbnwwfHx8fHw%3D",
       "https://images.unsplash.com/photo-1541580654-1004d7175ceb?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHx0b3BpYy1mZWVkfDJ8YkRvNDhjVWh3bll8fGVufDB8fHx8fA%3D%3D",
       "https://images.unsplash.com/photo-1703523888420-aa4c8a2cf027?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxNHx8fGVufDB8fHx8fA%3D%3D",
       "https://images.unsplash.com/photo-1702579454504-999228374c5e?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxOHx8fGVufDB8fHx8fA%3D%3D",
       "https://plus.unsplash.com/premium_photo-1685297603974-d80df6651975?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwzMnx8fGVufDB8fHx8fA%3D%3D",
       "https://images.unsplash.com/photo-1703192163759-316babf88c76?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwzNXx8fGVufDB8fHx8fA%3D%3D",
       "https://images.unsplash.com/photo-1703566757295-1a72f47a94de?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw0M3x8fGVufDB8fHx8fA%3D%3D",
       "https://images.unsplash.com/photo-1701743805074-497f68fb33b6?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw0OXx8fGVufDB8fHx8fA%3D%3D",
       "https://images.unsplash.com/photo-1702234711153-c4fa78c153c3?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw1OHx8fGVufDB8fHx8fA%3D%3D",
       "https://images.unsplash.com/photo-1677840147161-49e9c1508b0b?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHx0b3BpYy1mZWVkfDN8eGpQUjRobGtCR0F8fGVufDB8fHx8fA%3D%3D",
       "https://images.unsplash.com/photo-1667925132898-d3fd2b77c172?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHx0b3BpYy1mZWVkfDIzfHhqUFI0aGxrQkdBfHxlbnwwfHx8fHw%3D",
       "https://images.unsplash.com/photo-1628285477029-e98c852cfb63?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHx0b3BpYy1mZWVkfDZ8RnpvM3p1T0hONnd8fGVufDB8fHx8fA%3D%3D",
       "https://images.unsplash.com/photo-1703635670253-d8eef9eaa447?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHx0b3BpYy1mZWVkfDIxfEZ6bzN6dU9ITjZ3fHxlbnwwfHx8fHw%3D",
       "https://images.unsplash.com/photo-1701358235231-e5fdffeae4f9?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHx0b3BpYy1mZWVkfDI2fEZ6bzN6dU9ITjZ3fHxlbnwwfHx8fHw%3D",
       "https://images.unsplash.com/photo-1703237288996-9bb1d3f71a54?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHx0b3BpYy1mZWVkfDQ0fEZ6bzN6dU9ITjZ3fHxlbnwwfHx8fHw%3D",
       "https://images.unsplash.com/photo-1668595472892-57a348e65858?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHx0b3BpYy1mZWVkfDQxfEZ6bzN6dU9ITjZ3fHxlbnwwfHx8fHw%3D",
       "https://images.unsplash.com/photo-1557970304-58a545d77cae?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHx0b3BpYy1mZWVkfDE3fFM0TUtMQXNCQjc0fHxlbnwwfHx8fHw%3D3",
       "https://images.unsplash.com/photo-1555871856-58ecdb804499?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHx0b3BpYy1mZWVkfDMwfFM0TUtMQXNCQjc0fHxlbnwwfHx8fHw%3D",
       "https://images.unsplash.com/photo-1578857947780-d407a63e4351?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHx0b3BpYy1mZWVkfDQwfFM0TUtMQXNCQjc0fHxlbnwwfHx8fHw%3D",
       "https://images.unsplash.com/photo-1701252374756-ed5ced2457dc?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHx0b3BpYy1mZWVkfDU4fFM0TUtMQXNCQjc0fHxlbnwwfHx8fHw%3D",
       "https://images.unsplash.com/photo-1664477615410-ee1a7f540a7e?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHx0b3BpYy1mZWVkfDc1fFM0TUtMQXNCQjc0fHxlbnwwfHx8fHw%3D",
       "https://images.unsplash.com/photo-1653605790973-cf1ec66fd542?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHx0b3BpYy1mZWVkfDF8dG93SlpGc2twR2d8fGVufDB8fHx8fA%3D%3D",
       "https://images.unsplash.com/photo-1626892748363-302909d7aa5c?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHx0b3BpYy1mZWVkfDd8dG93SlpGc2twR2d8fGVufDB8fHx8fA%3D%3D",
       "https://images.unsplash.com/photo-1551845728-6820a30c64e2?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHx0b3BpYy1mZWVkfDEzfHRvd0paRnNrcEdnfHxlbnwwfHx8fHw%3D",
       "https://images.unsplash.com/photo-1516575334481-f85287c2c82d?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHx0b3BpYy1mZWVkfDE1fHRvd0paRnNrcEdnfHxlbnwwfHx8fHw%3D",
       "https://plus.unsplash.com/premium_photo-1691962725045-57ff9e77f0bd?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHx0b3BpYy1mZWVkfDIzfHRvd0paRnNrcEdnfHxlbnwwfHx8fHw%3D",
       "https://images.unsplash.com/photo-1531934864-f913897cf90e?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHx0b3BpYy1mZWVkfDQ4fHRvd0paRnNrcEdnfHxlbnwwfHx8fHw%3D",
       "https://images.unsplash.com/photo-1703600896974-889bea2f4c64?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHx0b3BpYy1mZWVkfDF8eEh4WVRNSExnT2N8fGVufDB8fHx8fA%3D%3D",
       "https://images.unsplash.com/photo-1529973625058-a665431328fb?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHx0b3BpYy1mZWVkfDExfHhIeFlUTUhMZ09jfHxlbnwwfHx8fHw%3D",
       "https://images.unsplash.com/photo-1703126806617-fc8fd6f3648c?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHx0b3BpYy1mZWVkfDQyfHhIeFlUTUhMZ09jfHxlbnwwfHx8fHw%3D",
       "https://images.unsplash.com/photo-1702498137770-145fccea4fb0?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHx0b3BpYy1mZWVkfDc1fHhIeFlUTUhMZ09jfHxlbnwwfHx8fHw%3D",
     ];
    var body: some View {
        VStack {
            Text("Scrollview ↓")
            ScreenshotableContent()
            
            Button("Generate Screenshot") {
                shotting.toggle()
                showResult.toggle()
            }
            .padding()
        }
        .sheet(isPresented: $showResult) {
            if let screenshot {
                ImagePreView(image: screenshot, isPresented: $showResult)
            }
        }
    }
    
    private func ScreenshotableContent() -> some View {
        ScreenshotableScrollView(shotting: $shotting) { screenshot in
            self.screenshot = Image(uiImage: screenshot)
        } content: { style in
            VStack {
                ForEach(0..<testImages.count, id: \.self) { index in
                    if let u = URL(string: testImages[index]) {
                        KFImage(u)
                            .resizable()
                            .scaledToFit()
                    } else {
                        ZStack {}
                    }                }
            }
            .padding()
            .border(.black)
            .padding()
        }
    }
    
    static func generateRandomColors(count: Int = 10) -> [Color] {
        return (0..<count).map { _ in Color.random }
    }
}

#Preview {
    ScrollScreenshotView()
}
