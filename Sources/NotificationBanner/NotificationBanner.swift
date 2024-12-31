//
//  SwiftUIView.swift
//  NotificationBanner
//
//  Created by Holger Krupp on 12.12.24.
//


import SwiftUI
import Combine



public struct NotificationBanner: View {
    
    public init() {
        
    }

    
    public enum NotificationType: Hashable {
        case success
        case error
    }

    
    @State var isVisible:Bool = false
    @State var titletext: String? = "Notification"
    @State var bodytext: String? = "Notification Text"
    @State var imageData: Data?
    @State var notificationType: NotificationType?
    let showTime: Double = 3.0
    let imgsize = 50.0
    let pub = NotificationCenter.default
        .publisher(for: NSNotification.Name("NotificationBanner"))
    
    
    public var body: some View {
  
            HStack{
                if let data = imageData{
                    Image(uiImage: UIImage(data: data) ?? UIImage())
                        .resizable()
                     .frame(width: imgsize, height: imgsize)
                    .aspectRatio(contentMode: .fit)
                }
                VStack(alignment: .leading) {
                    Text(titletext ?? "")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(bodytext ?? "")
                        .font(.body)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                }
            }
            .onTapGesture {
                withAnimation {
                    isVisible.toggle()
                    resetData()
                }
            }
            .padding()
            .background(.thinMaterial)
            .cornerRadius(15)
            
            .frame(
                width: UIScreen.main.bounds.width * 0.9,
                height: UIScreen.main.bounds.height * 0.1
            )
            
            .opacity(isVisible ? 1 : 0)
            .animation(.easeInOut(duration: 0.3), value: isVisible)
            
            .onReceive(pub) { (output) in
            self.loadData(output: output)
        }
                
    }
    
    func loadData(output: NotificationCenter.Publisher.Output) {
        titletext = output.userInfo?["titletext"] as? String ?? ""
        bodytext = output.userInfo?["bodytext"] as? String ?? ""
        isVisible = true
        imageData = output.userInfo?["image"] as? Data
        
        let _delay = RunLoop.SchedulerTimeType(.init(timeIntervalSinceNow: self.showTime))
        RunLoop.main.schedule(after: _delay) {
            self.isVisible.toggle()
            resetData()
        }
        
    }
    
    func resetData(){
        titletext = nil
        bodytext = nil
        isVisible = false
        imageData = nil
    }
}



#Preview {
    
    ZStack(alignment: .top)  {
        
  
        NotificationBanner()

        
    }

}
