import SwiftUI
import AVFoundation

struct Avion: View {
    @State private var player: AVAudioPlayer?
    @State var ejeX: CGFloat = 0
    @State var ejeY: CGFloat = 0
    @State var rotationDegrees: Double = 0
    
    var body: some View {
        VStack {
            Image(systemName: "airplane")
                .font(.largeTitle)
                .foregroundColor(Color(hex: "#C57D75"))
                .offset(x: ejeX, y: ejeY)
                .rotationEffect(.degrees(rotationDegrees))
                .animation(.easeInOut(duration: 2), value: ejeX) 
                .animation(.easeInOut(duration: 2), value: ejeY) 
            
            Button(action: {
                despegar()
            }) {
                Text("Despegar avión")
                    .padding()
                    .background(Color(hex: "#781727"))
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
    }
    
    func reproducirSonido(nombreArchivo: String) {
        guard let ubicacionSonido = Bundle.main.url(forResource: nombreArchivo, withExtension: "mp3") 
        else {
            print("No se encontró el archivo de sonido.")
            return
        }
        do {
            player = try AVAudioPlayer(contentsOf: ubicacionSonido)
            player?.play()
        } catch {
            print("Error al reproducir el sonido: \(error)")
        }
    }
    
    func despegar() {
        withAnimation(.easeInOut(duration: 6)) {
            ejeX = 80
            ejeY = -50
            rotationDegrees = -50
        }
        reproducirSonido(nombreArchivo: "despegue") 
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            vuelo()
        }
    }
    
    func vuelo() {
        withAnimation(.linear(duration: 8)) {
            ejeX = 400
        }
        reproducirSonido(nombreArchivo: "vuelo")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            accidente()
        }
    }
    
    func accidente() {
        withAnimation(.easeInOut(duration: 9)) {
            ejeY = 100
            rotationDegrees = 0
        }
        reproducirSonido(nombreArchivo: "accidente") 
    }
}

// PARA COLORES HEXADECIMAL
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

