import SwiftUI
import AVFoundation

struct Submarino: View {
    @State private var player: AVAudioPlayer?
    @State var ejeX: CGFloat = 0
    @State var ejeY: CGFloat = 0
    @State var rotationDegrees: Double = 0
    
    var body: some View {
        VStack {
            Image("submarino")
                .resizable()
                .aspectRatio(contentMode: .fit) 
                .frame(width: 60, height: 60) 
                .foregroundColor(Color(hex: "#A1A8BE")) 
                .offset(x: ejeX, y: ejeY)
                .rotationEffect(.degrees(rotationDegrees))
                .animation(.easeInOut(duration: 2), value: ejeX)
                .animation(.easeInOut(duration: 2), value: ejeY)

            
            Button(action: {
                sumergir()
            }) {
                Text("Sumergir Submarino")
                    .padding()
                    .background(Color(hex: "#EA785B")) 
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
    
    func sumergir() {
        withAnimation(.easeInOut(duration: 3)) {
            ejeY = 250 
           
        }
        reproducirSonido(nombreArchivo: "sumergir") 
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            desplazar()
        }
    }
    
    func desplazar() {
        withAnimation(.linear(duration: 5)) {
            ejeX = 200 
            rotationDegrees = 15
        }
        reproducirSonido(nombreArchivo: "navegacion") 
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            emerger()
        }
    }
    
    func emerger() {
        withAnimation(.easeInOut(duration: 3)) {
            ejeY = 0 
            rotationDegrees = 0 
        }
        reproducirSonido(nombreArchivo: "emerger") 
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            sumergir2()
        }
    }
    
    func sumergir2() {
        withAnimation(.easeInOut(duration: 3)) {
            ejeY = 250 
            rotationDegrees = 0
        }
        reproducirSonido(nombreArchivo: "sumergir") 
    }
}


