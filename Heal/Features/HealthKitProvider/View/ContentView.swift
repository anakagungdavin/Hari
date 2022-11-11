//
//  ContentView.swift
//  Heal
//
//  Created by Anak Agung Gede Agung Davin on 27/09/22.
// swiftlint:disable unused_closure_parameter
// swiftlint:disable line_length
// swiftlint:multiple_closures_with_trailing_closure

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Ecg.timeStampECG, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Ecg>
//    private var healthEcg: HKEcgs?
    private var authProc: HKAuthorize?
    let dateFormatter = DateFormatter()

//    @ObservedObject var ecgDates1 = HKEcgs()

    init() {
        authProc = HKAuthorize()
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        Text("Item at \(item.timeStampECG!, formatter: itemFormatter)")
                    } label: {
                        Text(item.timeStampECG!, formatter: itemFormatter)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
                ToolbarItem {
                    Button(action: {
                        authProc?.authorizeHealthKit(viewContext: viewContext, completion: { success, error in
                        })
                        HealthSymptoms().writeSymptoms(symptoms: ["vomit", "headAche", "chestPain"], now: .now) { success, error in
                            print(success)
                        }
//                        print(ecgDates1.ecgDates)
//                        for item in items {
//                            print(item.voltageECG ?? "")
//                        }
                    }) {
                        Label("Add Item", systemImage: "heart.text.square")
                    }
                }
            }
            Text("Select an item")
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Ecg(context: viewContext)
            newItem.timeStampECG = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
