//
//  TableViewController.swift
//  Earthquakes
//
//  Created by Omar Issentayev on 31.03.2024.
//  Copyright © 2024 Apple. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let stationSources = [
        ("BGR", "https://eida.bgr.de/fdsnws/station/1/"),
        ("KNMI", "http://rdsa.knmi.nl/fdsnws/station/1/"),
        ("KOERI", "http://eida-service.koeri.boun.edu.tr/fdsnws/station/1/"),
        ("ETHZ", "http://eida.ethz.ch/fdsnws/station/1/"),
        ("GEOFON, GFZ", "https://geofon.gfz-potsdam.de/fdsnws/station/1/"),
        ("ICGC", "http://ws.icgc.cat/fdsnws/station/1/"),
        ("IPGP", "http://ws.ipgp.fr/fdsnws/station/1/"),
        ("INGV", "http://webservices.ingv.it/fdsnws/station/1/"),
        ("LMU", "http://erde.geophysik.uni-muenchen.de/fdsnws/station/1/"),
        ("NIEP", "https://eida-sc3.infp.ro/fdsnws/station/1/"),
        ("NOA", "http://eida.gein.noa.gr/fdsnws/station/1/"),
        ("ORFEUS", "http://www.orfeus-eu.org/fdsnws/station/1/"),
        ("RESIF", "http://ws.resif.fr/fdsnws/station/1/"),
        ("IRIS DMC", "http://service.iris.edu/fdsnws/station/1/"),
        ("NCEDC", "https://service.ncedc.org/fdsnws/station/1/"),
        ("SCEDC", "http://service.scedc.caltech.edu/fdsnws/station/1/"),
        ("TexNet", "http://rtserve.beg.utexas.edu/fdsnws/station/1/"),
        ("USP-IAG", "http://seisrequest.iag.usp.br/fdsnws/station/1/"),
        ("BMKG", "https://geof.bmkg.go.id/fdsnws/station/1/"),
        ("AusPass", "https://auspass.edu.au:8080/fdsnws/station/1/"),
        ("ESM", "https://esm-db.eu/fdsnws/station/1/"),
        ("GeoNet", "https://service.geonet.org.nz/fdsnws/station/1/"),
        ("Haiti", "https://ayiti.unice.fr/ayiti-seismes/fdsnws/station/1/"),
        ("SismoAzur", "https://sismoazur.oca.eu/fdsnws/station/1/")
    ]
    
    let seedlinkNetworks = [
        ("AusPass", "auspass.edu.au", 18000),
        ("GEOFON, GFZ", "geofon.gfz-potsdam.de", 18000),
        ("GEONET", "link.geonet.org.nz", 18000),
        ("IDA Project", "rtserve.ida.ucsd.edu", 18000),
        ("IFZ", "data.ifz.ru", 18000),
        ("IRIS DMC", "rtserve.iris.washington.edu", 18000),
        ("IRIS Jamaseis", "jamaseis.iris.edu", 18000),
        ("ISNET - UNINA Università degli Studi di Napoli Federico II", "185.15.171.86", 18000),
        ("OBSEBRE", "obsebre.es", 18000),
        ("OGS", "nam.ogs.it", 18000),
        ("Oklahoma University", "rtserve.ou.edu", 18000),
        ("Red Sìsmica Baru", "helis.redsismicabaru.com", 18000),
        ("RESIF", "rtserve.resif.fr", 18000),
        ("SCSN-USC (South Carolina Seismic Network)", "eeyore.seis.sc.edu", 6382),
        ("Seisme IRD", "rtserve.ird.nc", 18000),
        ("SNAC NOA", "snac.gein.noa.gr", 18000),
        ("UFRN (Universidade Federal do Rio Grande do Norte)", "sislink.geofisica.ufrn.br", 18000),
        ("Universidade de Évora", "clv-cge.uevora.pt", 18000),
        ("UPR", "worm.uprm.edu", 18000),
        ("NRCAN", "earthquakescanada.nrcan.gc.ca", 18000),
        ("USGS", "cwbpub.cr.usgs.gov", 18000),
        ("BGR", "eida.bgr.de", 18000),
        ("ENS", "ephesite.ens.fr", 18000),
        ("Helsinki", "finseis.seismo.helsinki.fi", 18000),
        ("Haiti", "ayiti.unice.fr", 18000),
        ("ICGC", "ws.icgc.cat", 18000),
        ("IPGP", "rtserver.ipgp.fr", 18000),
        ("TexNet", "rtserve.beg.utexas.edu", 18000),
        ("LMU", "erde.geophysik.uni-muenchen.de", 18000),
        ("NIGGG", "195.96.231.100", 18000),
        ("ORFEUS", "eida.orfeus-eu.org", 18000),
        ("PLSN (IGF Poland)", "hudson.igf.edu.pl", 18000),
        ("SANET", "147.213.113.73", 18000),
        ("Thai Meteorological Department", "119.46.126.38", 18000),
        ("Unical Universita Della Calabria", "www.sismocal.org", 18000),
        ("UNIV-AGUniversité des Antilles", "seedsrv0.ovmp.martinique.univ-ag.fr", 18000)
    ]
    
    var body: some View {
        List {
            Section(header: Text("Station Sources")) {
                ForEach(stationSources, id: \.0) { source in
                    NavigationLink(destination: Text(source.1)) {
                        Text(source.0)
                    }
                }
            }
            
            Section(header: Text("Seedlink Networks")) {
                ForEach(seedlinkNetworks, id: \.0) { network in
                    NavigationLink(destination: Text(network.1)) {
                        Text(network.0)
                    }
                }
            }
        }
        .navigationTitle("Data Sources")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
