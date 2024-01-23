import SwiftUI
import BaiduMapAPI_Map

class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    private let locationManager = CLLocationManager()
    @Published var location: CLLocation?
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
//        self.locationManager.startUpdatingLocation()
    }
    
    func requestLocation() {
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.location = locations.last
        locationManager.desiredAccuracy = kCLLocationAccuracyBest

    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // 处理定位错误
        print("定位错误: \(error.localizedDescription)")
        // 根据需要，您可以在这里添加更多的错误处理逻辑
    }
}

struct BaiduMapView: UIViewRepresentable {
    
    @ObservedObject var locationManager: LocationManager
    let mapView = BMKMapView()
    
    func makeUIView(context: Context) -> BMKMapView {
        // 启用定位图层
        mapView.showsUserLocation = true
        // 设置定位模式
        mapView.userTrackingMode = BMKUserTrackingModeFollow

        // 配置mapView的属性...
        
        
        
        return mapView
    }
    
    func updateUIView(_ uiView: BMKMapView, context: Context) {
        if let location = locationManager.location {
            // 更新地图的中心点为当前位置
            let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            uiView.centerCoordinate = coordinate
            
            // 创建并更新定位数据
            let userLocation = BMKUserLocation()
            userLocation.location = location
            uiView.updateLocationData(userLocation)
        }
    }
    
    
    class Coordinator: NSObject, BMKMapViewDelegate {
        var parent: BaiduMapView
        
        init(_ parent: BaiduMapView) {
            self.parent = parent
        }
        // 可以在这里添加更多地图代理方法
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}







