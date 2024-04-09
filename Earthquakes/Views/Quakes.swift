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

    @State private var isShowingStations = false // New state for showing stations tab

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
        }
        .task {
            try? await provider.fetchQuakes()
        }
        .sheet(isPresented: $isShowingStations) {
            ContentView() // Replace StationsListView with your actual view for stations
        }
        .overlay(
            Button(action: {
                isShowingStations.toggle()
            }, label: {
                Image(systemName: "list.bullet.rectangle")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .clipShape(Circle())
            })
            .padding(.trailing)
            .padding(.bottom)
            , alignment: .bottomTrailing
        )
    }
}

extension Quakes {
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
