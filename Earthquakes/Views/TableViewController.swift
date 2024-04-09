import SwiftUI

struct Station: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let ipAddress: String
    let port: Int
}

struct ContentView: View {
    @State private var selectedStation: Station?
    
    let stations = [
        Station(name: "AusPass", ipAddress: "auspass.edu.au", port: 18000),
               Station(name: "GEOFON, GFZ", ipAddress: "geofon.gfz-potsdam.de", port: 18000),
               Station(name: "GEONET", ipAddress: "link.geonet.org.nz", port: 18000),
               Station(name: "IDA Project", ipAddress: "rtserve.ida.ucsd.edu", port: 18000),
               Station(name: "IFZ", ipAddress: "data.ifz.ru", port: 18000),
               Station(name: "IRIS DMC", ipAddress: "rtserve.iris.washington.edu", port: 18000),
               Station(name: "IRIS Jamaseis", ipAddress: "jamaseis.iris.edu", port: 18000),
               Station(name: "ISNET - UNINA Università degli Studi di Napoli Federico II", ipAddress: "185.15.171.86", port: 18000),
               Station(name: "OBSEBRE", ipAddress: "obsebre.es", port: 18000),
               Station(name: "OGS", ipAddress: "nam.ogs.it", port: 18000),
               Station(name: "Oklahoma University", ipAddress: "rtserve.ou.edu", port: 18000),
               Station(name: "Red Sìsmica Baru", ipAddress: "helis.redsismicabaru.com", port: 18000),
               Station(name: "RESIF", ipAddress: "rtserve.resif.fr", port: 18000),
               Station(name: "SCSN-USC (South Carolina Seismic Network)", ipAddress: "eeyore.seis.sc.edu", port: 6382),
               Station(name: "Seisme IRD", ipAddress: "rtserve.ird.nc", port: 18000),
               Station(name: "SNAC NOA", ipAddress: "snac.gein.noa.gr", port: 18000),
               Station(name: "UFRN (Universidade Federal do Rio Grande do Norte)", ipAddress: "sislink.geofisica.ufrn.br", port: 18000),
               Station(name: "Universidade de Évora", ipAddress: "clv-cge.uevora.pt", port: 18000),
               Station(name: "UPR", ipAddress: "worm.uprm.edu", port: 18000),
               Station(name: "NRCAN", ipAddress: "earthquakescanada.nrcan.gc.ca", port: 18000),
               Station(name: "USGS", ipAddress: "cwbpub.cr.usgs.gov", port: 18000),
               Station(name: "BGR", ipAddress: "eida.bgr.de", port: 18000),
               Station(name: "ENS", ipAddress: "ephesite.ens.fr", port: 18000),
               Station(name: "Helsinki", ipAddress: "finseis.seismo.helsinki.fi", port: 18000),
               Station(name: "Haiti", ipAddress: "ayiti.unice.fr", port: 18000),
               Station(name: "ICGC", ipAddress: "ws.icgc.cat", port: 18000),
               Station(name: "IPGP", ipAddress: "rtserver.ipgp.fr", port: 18000),
               Station(name: "TexNet", ipAddress: "rtserve.beg.utexas.edu", port: 18000),
               Station(name: "LMU", ipAddress: "erde.geophysik.uni-muenchen.de", port: 18000),
               Station(name: "NIGGG", ipAddress: "195.96.231.100", port: 18000),
               Station(name: "ORFEUS", ipAddress: "eida.orfeus-eu.org", port: 18000),
               Station(name: "PLSN (IGF Poland)", ipAddress: "hudson.igf.edu.pl", port: 18000),
               Station(name: "SANET", ipAddress: "147.213.113.73", port: 18000),
               Station(name: "Thai Meteorological Department", ipAddress: "119.46.126.38", port: 18000),
               Station(name: "Unical Universita Della Calabria", ipAddress: "www.sismocal.org", port: 18000),
               Station(name: "UNIV-AGUniversité des Antilles", ipAddress: "seedsrv0.ovmp.martinique.univ-ag.fr", port: 18000)
           ]

    var body: some View {
        NavigationView {
            List(stations) { station in
                NavigationLink(destination: StationDetailView(station: station), label: {
                    Text(station.name)
                })
            }
            .navigationTitle("Stations")
        }
    }
}

struct StationDetailView: View {
    let station: Station
    
    var body: some View {
        VStack {
            Text("Station Name: \(station.name)")
            Text("IP Address: \(station.ipAddress)")
            Text("Port: \(station.port)")
            Button("Connect") {
                // Add your connection logic here
            }
            .padding()
        }
        .navigationTitle("Station Details")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
