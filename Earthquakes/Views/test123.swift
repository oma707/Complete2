import SwiftUI
import MapKit

struct EarthquakeMapView: View {
    @State private var annotations: [EarthquakeAnnotation] = []
    @State private var isLoading = false

    var body: some View {
        ZStack {
            Map(coordinateRegion: .constant(MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
                span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
            )), showsUserLocation: true, userTrackingMode: Binding.constant(.follow), annotationItems: annotations) { annotation in
                MapAnnotation(coordinate: annotation.coordinate) {
                    Circle()
                        .strokeBorder(Color.red, lineWidth: 2)
                        .frame(width: 25, height: 25)
                        .background(Circle().fill(Color.red))
                }
            }
            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .foregroundColor(.blue)
            }
        }
        .onAppear {
            fetchEarthquakes()
        }
    }

    func fetchEarthquakes() {
        isLoading = true
        let url = URL(string: "https://api.example.com/earthquakes")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            defer { isLoading = false }
            guard let data = data else {
                print("Error fetching earthquake data: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            do {
                let decoder = JSONDecoder()
                let earthquakeData = try decoder.decode([Earthquake].self, from: data)
                DispatchQueue.main.async {
                    updateAnnotations(with: earthquakeData)
                }
            } catch {
                print("Error decoding earthquake data: \(error.localizedDescription)")
            }
        }.resume()
    }

    func updateAnnotations(with earthquakeData: [Earthquake]) {
        // Clear existing annotations
        annotations.removeAll()

        // Add new annotations based on earthquake data
        for quake in earthquakeData {
            let annotation = EarthquakeAnnotation(
                coordinate: CLLocationCoordinate2D(latitude: quake.latitude, longitude: quake.longitude),
                magnitude: quake.magnitude
            )
            annotations.append(annotation)
        }
    }
}

struct Earthquake: Codable {
    let latitude: Double
    let longitude: Double
    let magnitude: Double
}

struct EarthquakeAnnotation: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
    let magnitude: Double
}

struct EarthquakeMapView_Previews: PreviewProvider {
    static var previews: some View {
        EarthquakeMapView()
    }
}
