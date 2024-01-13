//
//  Quakes.swift
//  Quake
//
//  Created by Abdelrahman Shehab on 13/01/2024.
//

import SwiftUI

struct Quakes: View {
    @AppStorage("lastUpdated")
    var lastUpdated = Date.distantFuture.timeIntervalSince1970
    
    @EnvironmentObject var provider: QuakesProvider
    @State var editMode: EditMode = .inactive
    @State var selectMode: SelectMode = .inActive
    @State var isLoading: Bool = false
    @State var selection: Set<String> = []
    @State private var error: QuakeError?
    @State private var hasError: Bool = false
    
    var body: some View {
        NavigationView {
            List(selection: $selection) {
                ForEach(provider.quakes) { quake in
                    QuakeRow(quake: quake)
                }
                .onDelete(perform: deleteQuakes)
            }
            .navigationTitle(title)
            .listStyle(.insetGrouped)
            .environment(\.editMode, $editMode)
            .toolbar(content: toolbarContent)
            .refreshable {
                await fetchQuakes()
            }
            .alert(isPresented: $hasError, error: error) {}
        }
        .task {
            await fetchQuakes()
        }
    }
}

#Preview {
    Quakes()
        .environmentObject(QuakesProvider(client: QuakeClient(downloader: TestDownloader())))
}

extension Quakes {
    var title: String {
        if selectMode.isActive || selection.isEmpty {
            return "Earthquakes"
        } else {
            return "\(selection.count) Selected"
        }
    }
    
    func deleteQuakes(at offset: IndexSet) {
        provider.quakes.remove(atOffsets: offset)
    }
    
    func deleteQuakes(for codes: Set<String>) {
        var offsetsToDelete: IndexSet = []
        for (index, element) in provider.quakes.enumerated() {
            if codes.contains(element.code) {
                offsetsToDelete.insert(index)
            }
            deleteQuakes(at: offsetsToDelete)
            selection.removeAll()
        }
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

extension Quakes {
    @ToolbarContentBuilder
    func toolbarContent() -> some ToolbarContent {
        
        ToolbarItem(placement: .topBarLeading) {
            if editMode == .active {
                SelectButton(mode: $selectMode) {
                    if selectMode.isActive {
                        selection = Set(provider.quakes.map({ $0.code }))
                    } else {
                        selection = []
                    }
                }
            }
        }
        
        ToolbarItem(placement: .topBarTrailing) {
            EditButton(editButton: $editMode) {
                selection.removeAll()
                editMode = .inactive
                selectMode = .inActive
            }
        }
        
        ToolbarItemGroup(placement: .bottomBar) {
            RefreshButton {
                Task {
                    await fetchQuakes()
                }
            }
            
            Spacer()
            ToolbarStatus(isLoading: isLoading,
                          lastUpdated: lastUpdated,
                          quakeCount: provider.quakes.count)
            
            Spacer()
            if editMode == .active {
                DeleteButton {
                    deleteQuakes(for: selection)
                }
                .disabled(isLoading || selection.isEmpty)
            }
        }
    }
}
