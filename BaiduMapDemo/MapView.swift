import SwiftUI
import Foundation

struct MapViewData {
    var isRequestionLocationButtonON = false
}

class MapViewDataByHandler: ObservableObject {
    @Published var mapViewData: MapViewData = MapViewData()
    
}


struct MapView: View {
    @StateObject var locationManager = LocationManager()
    
    let mapViewDataByHandler = MapViewDataByHandler()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                BaiduMapView(locationManager: locationManager)
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            mapViewDataByHandler.mapViewData.isRequestionLocationButtonON.toggle()
                            if mapViewDataByHandler.mapViewData.isRequestionLocationButtonON {
                                // 此处调用 locationManager 的 requestLocation 方法
                                locationManager.requestLocation()
                                mapViewDataByHandler.mapViewData.isRequestionLocationButtonON = false
                            }
                            
                        }) {
                            Image(systemName: "location.circle")
                                .resizable()
                                .frame(width: geometry.size.width * 0.15, height: geometry.size.height * 0.07)
                                .imageScale(.large)
                                .padding()
                        }
                    }
                }
            }
        }
        
    }
}

