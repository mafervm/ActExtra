import SwiftUI

struct ContentView: View {
    @State private var seleccion: String? = nil
    
    var body: some View {
        VStack {
            Text("Selecciona un vehículo para navegar")
                .font(.title)
                .padding()
            
            Button(action: {
                seleccion = "avion"
            }) {
                Text("Navegar Avión")
                    .padding()
                    .background(Color(hex: "#7A958F"))
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
            
            Button(action: {
                seleccion = "submarino"
            }) {
                Text("Navegar Submarino")
                    .padding()
                    .background(Color(hex: "#515559"))
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
            
        
            if let seleccion = seleccion {
                if seleccion == "avion" {
                    Avion() 
                    
                } else if seleccion == "submarino" {
                    Submarino() 
                }
            }
        }
    }
}
