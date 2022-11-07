//
//  Extension.swift
//  View to PDF
//
//  Created by Nur Mutmainnah Rahim on 04/11/22.
//

import SwiftUI

extension View {
    func convertToScrollView<Content: View>(@ViewBuilder content: @escaping ()->Content)->UIScrollView{
        let scrollView = UIScrollView()
        
        //converting DWIFTUI to UIKIT view
        let hostingController = UIHostingController(rootView: content()).view!
        hostingController.translatesAutoresizingMaskIntoConstraints = false
        
        //mark constrains
        let constraints = [
            hostingController.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            hostingController.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            hostingController.topAnchor.constraint(equalTo: scrollView.topAnchor),
            hostingController.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            //width anchor
            hostingController.widthAnchor.constraint(equalToConstant: screenBounds().width)
        ]
        scrollView.addSubview(hostingController)
        scrollView.addConstraints(constraints)
        scrollView.layoutIfNeeded()
        return scrollView
    }
    
    //Export To PDF
    //send status and URL
    func exportPDF<Content: View>(@ViewBuilder content: @escaping ()->Content,completion: @escaping (Bool,URL?)->()){
        
        //temp URL
        let documentDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        let outputFileURL = documentDirectory.appendingPathComponent("YOURPDFNAME\(UUID().uuidString).pdf")
        
        //PDF View
        let pdfView = convertToScrollView{
            content()
        }
        pdfView.tag = 1009
        let size = pdfView.contentSize
        //FRAMENYAA
        pdfView.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        
        //attact to root view and render the pdf
        getRootController().view.insertSubview(pdfView, at: 0)
        
        //rendering PDF
        let renderer = UIGraphicsPDFRenderer(bounds: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        
        do {
            try renderer.writePDF(to: outputFileURL, withActions: { context in
                context.beginPage()
                pdfView.layer.render(in: context.cgContext)
            })
            
            completion(true,outputFileURL)
        }
        catch{
            completion(false,nil)
            print(error.localizedDescription)
        }
        
        //removing the added view
        getRootController().view.subviews.forEach{ view in
            if view.tag == 1009{
                print("remove")
                view.removeFromSuperview()
            }
            
        }
        
        
        
    }
    
    func screenBounds()->CGRect{
        return UIScreen.main.bounds
    }
    
    func getRootController()->UIViewController{
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else{
            return.init()
        }
        
        guard let root = screen.windows.first?.rootViewController else{
            return.init()
        }
        
        return root
    }
    
}
