//
//  SecondPage.swift
//  Journal_Sympta
//
//  Created by Nur Mutmainnah Rahim on 14/10/22.
//

import SwiftUI

struct SecondPage: View {
    
    var body: some View {
        VStack {
            ConvertViewController()
            /*
             Text("this is text")
             Button {
             exportPDF()
             } label: {
             Text("save this page")
             }
             }
             */
        }
    }
    
}

@MainActor
private func exportPDF() {
    guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }

    let renderedUrl = documentDirectory.appending(path: "linechart.pdf")

    if let consumer = CGDataConsumer(url: renderedUrl as CFURL),
       let pdfContext = CGContext(consumer: consumer, mediaBox: nil, nil) {

        let renderer = ImageRenderer(content: SecondPage())
        renderer.render { size, renderer in
            let options: [CFString: Any] = [
                kCGPDFContextMediaBox: CGRect(origin: .zero, size: size)
            ]

            pdfContext.beginPDFPage(options as CFDictionary)

            renderer(pdfContext)
            pdfContext.endPDFPage()
            pdfContext.closePDF()
        }
    }

    print("Saving PDF to \(renderedUrl.path())")
}



 
struct SecondPage_Preview: PreviewProvider {
    static var previews: some View {
       SecondPage()
    }
}

