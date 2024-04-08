/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The views of the app, which display details of the fetched earthquake data.
*/

import SwiftUI

struct Quakes: View {
    @EnvironmentObject var provider: QuakesProvider

    @AppStorage("lastUpdated")
    var lastUpdated = Date.distantFuture.timeIntervalSince1970

    @State var editMode: EditMode = .inactive
    @State var selectMode: SelectMode = .inactive
    @State var isLoading = false
    @State var selection: Set<String> = []
    @State private var error: QuakeError?
    @State private var hasError = false

    var body: some View {
        NavigationView {
            List(selection: $selection) {
                ForEach(provider.quakes) { quake in
                    NavigationLink(destination: QuakeDetail(quake: quake)) {
                        QuakeRow(quake: quake)
                    }
                }
                .onDelete(perform: deleteQuakes)
            }
            .listStyle(.inset)
            .navigationTitle(title)
            .toolbar(content: toolbarContent)
            .environment(\.editMode, $editMode)
            .refreshable {
                do {
                    try await provider.fetchQuakes()
                } catch {
                    self.error = QuakeError.missingData
                    hasError = true
                }
            }
            // Add the button in the bottom right corner
            .overlay(
                Button(action: {
                    openTableViewController()
                }) {
                    Image(systemName: "square.and.pencil")
                        .font(.title)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                }
                .padding(.bottom, 20)
                .padding(.trailing, 20),
                alignment: .bottomTrailing
            )
        }
        .task {
            try? await provider.fetchQuakes()
        }
    }
    
    func openTableViewController() {
        // Code to open the TableViewController file
        // This code assumes TableViewController is a Swift file in the same project
        guard let url = URL(string: "TableViewController.swift") else {
            return
        }
        UIApplication.shared.open(url)
    }
    
    var title: String {
        if selectMode.isActive || selection.isEmpty {
            return "Earthquakes"
        } else {
            return "\(selection.count) Selected"
        }
    }
    func deleteQuakes(at offsets: IndexSet) {
        provider.deleteQuakes(atOffsets: offsets)
    }
    func deleteQuakes(for codes: Set<String>) {
        var offsetsToDelete: IndexSet = []
        for (index, element) in provider.quakes.enumerated() {
            if codes.contains(element.code) {
                offsetsToDelete.insert(index)
            }
        }
        deleteQuakes(at: offsetsToDelete)
        selection.removeAll()
    }
    func fetchQuakes() async {
        isLoading = true
        do {
            try await provider.fetchQuakes()
            lastUpdated = Date().timeIntervalSince1970
        } catch {
            self.error = error as? QuakeError ?? .unexpectedError(error: error)
            self.hasError = true
        }
        isLoading = false
    }
}

struct Quakes_Previews: PreviewProvider {
    static var previews: some View {
        Quakes()
            .environmentObject(QuakesProvider(client: QuakeClient(downloader: TestDownloader())))
    }
}
