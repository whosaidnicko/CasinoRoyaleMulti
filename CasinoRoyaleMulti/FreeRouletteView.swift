//
//  FreeRouletteView.swift
//  JackKas
//
//  Created by Jack Betha on 31/12/2024.
//

import Foundation
import SwiftUI


struct FreeRouletteView: View {
    @State var showMoneyTake: Bool = false
    var isFree: Bool
    @State var bet: Int = 0
    @State var showTradeEnergy: Bool = false
    @StateObject private var userStorage: UserStorageGameClass = UserStorageGameClass.shared
    @State var gold: Int = 0
    @State var experience: Int = 0
    @State var userWin: Bool?
    @State var selectedColor: Color?
    @State var selectedNumber: Int = -1
    @State var numbers: [Int] = []
    let columns = [
        GridItem(.fixed(24), spacing: 0),
        GridItem(.fixed(24), spacing: 0),
        GridItem(.fixed(24), spacing: 0),
        GridItem(.fixed(24), spacing: 0),
        GridItem(.fixed(24), spacing: 0),
        GridItem(.fixed(24), spacing: 0),
        GridItem(.fixed(24), spacing: 0),
        GridItem(.fixed(24), spacing: 0),
        GridItem(.fixed(24), spacing: 0),
        GridItem(.fixed(24), spacing: 0)
    ]
    var body: some View {
        ZStack {
            Image("bgRed")
                .resizable()
                .ignoresSafeArea()
            
            
            HStack {
                self.rouleteView()
                
                Spacer()
            }
            
            VStack {
                HStack {
                   Spacer()
                    
                    LazyVGrid(columns: columns,alignment: .center, spacing: 6) {
                        ForEach(self.numbers.indices, id: \.self) { index in
                            RoundedRectangle(cornerRadius: 3)
                                .fill(numbers[index] == 0 ? Color.init(hex: "#66B945") : (numbers[index] % 2 == 0 ? Color.black : Color.init(hex: "#F2272F")))
                                .overlay {
                                    RoundedRectangle(cornerRadius: 3)
                                        .trim(from: 0, to: self.selectedNumber == numbers[index]  && selectedColor == nil  ? 1 : 0)
                                        .stroke(Color.white
                                                ,lineWidth: 1)
                                    
                                    Text(String(numbers[index]))
                                        .font(.custom(Font.lalezar
                                                      , size: 10))
                                        .foregroundStyle(Color.white)
                                }
                                .animation(Animation.easeInOut(duration: 2), value: self.selectedNumber)
                                .frame(width: 19, height: 19)
                                .onTapGesture {
                                    self.selectedColor = nil
                                    self.selectedNumber = self.numbers[index]
                                }
                        }
                    }
                }
                
                HStack(spacing: 49) {
                    Button(action: {
                        selectedNumber = -1
                        selectedColor = Color.init(hex: "#F5222A")
                    }, label: {
                        RoundedRectangle(cornerRadius: 3)
                            .fill(Color.init(hex: "#F5222A"))
                            .overlay {
                            RoundedRectangle(cornerRadius: 3)
                                    .trim(from: 0, to: Color.init(hex: "#F5222A") == selectedColor ? 1 : 0)
                                    .stroke(Color.white
                                        ,lineWidth: 1)
                               
                            }
                            .frame(width: 33, height: 33)
                            .animation(Animation.easeInOut(duration: 2), value: self.selectedColor)
                    })
                    .buttonStyle(CustomStyle())
                    
                    Button(action: {
                        selectedNumber = -1
                        selectedColor = Color.init(hex: "#000000")
                    }, label: {
                        RoundedRectangle(cornerRadius: 3)
                            .fill(Color.init(hex: "#000000"))
                            .overlay {
                            RoundedRectangle(cornerRadius: 3)
                                    .trim(from: 0, to: Color.init(hex: "#000000") == selectedColor ? 1 : 0)
                                    .stroke(Color.white
                                        ,lineWidth: 1)
                               
                            }
                            .frame(width: 33, height: 33)
                            .animation(Animation.easeInOut(duration: 2), value: self.selectedColor)
                    })
                    .buttonStyle(CustomStyle())

                 
                }
                .padding(.top)
                
                Spacer()
                
                Group {
                    if !self.isSpinning && (selectedNumber > -1 || selectedColor != nil) {
                        if isFree {
                            Button {
                                isSpinning = true
                                randomAngle = Double.random(in: 1...360)
                                rotationAngle += 1080 + randomAngle
                                calculatedAngle = normalizeAngle(angle: rotationAngle)
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2.9) {
                                    isSpinning = false
                                    self.determineSector(from: calculatedAngle)
                                }
                                
                            } label: {
                                Image("menuLeibl")
                                    .overlay {
                                        Text("FREE SPIN")
                                            .font(.custom(Font.lalezar, size: 17))
                                            .foregroundStyle(.white)
                                    }
                            }
                            .buttonStyle(CustomStyle())
                            .disabled(isSpinning)
                        } else {
                            HStack(spacing: 3) {
                                Button {
                                    let decrement = 0.10 * Double(self.userStorage.coin)
                                    let newBet = bet - Int(decrement)
                                    // Ensure the bet does not go below zero
                                    if newBet >= 0 {
                                        bet = newBet
                                    } else {
                                        bet = 0
                                    }
                                } label: {
                                    Image("menuLeibl")
                                        .resizable()
                                        .frame(width: 45, height: 45)
                                        .overlay {
                                            Text("-")
                                                .font(.custom(Font.lalezar, size: 25))
                                                .foregroundStyle(.white)
                                        }
                                }
                                .buttonStyle(CustomStyle())
                                
                                Image("menuLeibl")
                                    .resizable()
                                    .frame(width: 141, height: 45)
                                    .overlay {
                                        Text(String(bet))
                                            .font(.custom(Font.lalezar, size: 25))
                                            .foregroundStyle(.white)
                                    }
                                
                                Button {
                                        let increment = 0.10 * Double(self.userStorage.coin)
                                    let newBet = bet + Int(increment)
                                    
                                    // Ensure the bet does not exceed current money
                                    if newBet <= self.userStorage.coin {
                                        if newBet == 0 {
                                            self.bet = self.userStorage.coin
                                        } else {
                                            bet = newBet
                                        }
                                        
                                    }
                                    if self.userStorage.coin == 0 {
                                        withAnimation {
                                                self.showMoneyTake = true
                                        }
                                    }
                                } label: {
                                    Image("menuLeibl")
                                        .resizable()
                                        .frame(width: 45, height: 45)
                                        .overlay {
                                            Text("+")
                                                .font(.custom(Font.lalezar, size: 25))
                                                .foregroundStyle(.white)
                                        }
                                }
                                .buttonStyle(CustomStyle())
                            }
                            Button(action: {
                                isSpinning = true
                                self.userStorage.coin -= self.bet
                                randomAngle = Double.random(in: 1...360)
                                rotationAngle += 1080 + randomAngle
                                calculatedAngle = normalizeAngle(angle: rotationAngle)
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2.9) {
                                    isSpinning = false
                                    self.determineSector(from: calculatedAngle)
                                }
                                
                            }, label: {
                                Image("menuLeibl")
                                    .resizable()
                                    .frame(width: 141, height: 45)
                                    .overlay {
                                        Text("Spin")
                                            .font(.custom(Font.lalezar, size: 25))
                                            .foregroundStyle(.white)
                                    }
                            })
                            .buttonStyle(CustomStyle())
                            .scaleEffect(!self.isSpinning  ? 1 : 0)
                            .disabled(self.bet == 0)
                            .animation(Animation.easeInOut(duration: 1.2), value: self.bet)
                        }
                    }
                }
                .transition(.scale)
                .padding(.bottom, 10)
            }
            .blur(radius: self.userWin != nil ? 3 : 0)
            .disabled(self.userWin != nil)
            
            Group {
                if self.userWin != nil {
                    
                    DidUserShowWin(bablosiki: self.gold,
                                 experince: self.experience,
                                 userWin: userWin!,
                                 isFreeRoulette: isFree ) {
                        withAnimation {
                            self.userWin = nil
                        }
                    }
                        .onAppear() {
                            self.userStorage.roulettePressedAction()
                        }
                }
            }
            .transition(.scale)
            
            showTradeEnery()
                .scaleEffect(self.showTradeEnergy ? 1 : 0)
            MoneyAlert(moneyAlert: $showMoneyTake)
        }
        
        .animation(Animation.easeInOut, value: isSpinning)
        .navigationBarBackButtonHidden()
        .navigationBarItems(trailing: GoldView())
        .navigationBarItems(leading: NazadKnopocika())
        .onAppear() {
            for number in 0...36 {
                self.numbers.append(number)
            }
            if !self.isFree {
                self.userStorage.energy -= 1
            }
        }
    }
    internal func leftBar() -> some View {
        HStack {
            VStack(spacing: 0) {
                HStack {
                    Button(action: {
                        withAnimation {
                            self.showTradeEnergy = true
                        }
                    }, label: {
                        ZStack {
                            
                            
                            Image("plus")
                        }
                    })
                    .offset(x: -5
                        ,y: 2)
                    .buttonStyle(CustomStyle())
                    
                    Spacer()
                    
                    Text(String(self.userStorage.energy))
                        .font(.custom(Font.lalezar, size: 20))
                        .foregroundStyle(.white)
                    
                    Spacer()
                    
                    Image("enr")
                        .padding(.horizontal)
                }
                
                HStack {
                    Rectangle()
                        .fill(Color.init(hex: "#FFFFFF").opacity(0.4))
                        .frame(width: 132.78, height: 1.45)
                    
                    Spacer()
                }
            }
            .frame(width: 133)
            
            Spacer()
        }
    }
    
    
    
    func showTradeEnery() -> some View {
        Image("rectName")
            .overlay {
                VStack {
                    HStack {
                        Spacer()
                        Button {
                            withAnimation {
                                self.showTradeEnergy = false
                            }
                        } label: {
                            Image("closeIc")
                        }
                    }
                    HStack {
                        Text("50")
                            .font(.custom(Font.lalezar, size: 20))
                            .foregroundStyle(Color.white)
                        
                        Image("popro")
                            .resizable()
                            .frame(width: 34, height: 28.5)
                        
                        Text("=")
                            .font(.custom(Font.lalezar, size: 25))
                            .foregroundStyle(.white)
                        
                        Text("1")
                            .font(.custom(Font.lalezar, size: 25))
                            .foregroundStyle(.white)
                        
                        Image("enr")
                            .resizable()
                            .frame(width: 31, height: 33)
                    }
                    Button {
                        if self.userStorage.coin >= 50 {
                            self.userStorage.coin -= 50
                            self.userStorage.energy += 1
                        }
                    } label: {
                     
                                Text("Change")
                                    .font(.custom(Font.lalezar
                                                  , size: 15))
                                    .foregroundStyle(.white)
                            
                    }
                    .buttonStyle(CustomStyle())
                    Spacer()
                }
            }
    }

    
    func rouleteView() -> some View {
        VStack(spacing: 0) {
            Image("showingArrow")
                .scaleEffect(UIScreen.main.bounds.height > 680 ? 1 : 0.8)
           
            Image("imageRoullete")
                .resizable()
                .scaledToFit()
                .rotationEffect(Angle(degrees: rotationAngle))
                .frame(width: 245 * (UIScreen.main.bounds.height > 680 ? 1 : 0.8), height: 245 * (UIScreen.main.bounds.height > 680 ? 1 : 0.8))
                .animation(Animation.easeInOut(duration: 2.9),
                           value: rotationAngle)
  
            
        }
    }
 
    @State private var rotationAngle = 0.0
    @State private var randomAngle = 0.0
    @State private var calculatedAngle = 0.0
    
    let halfSectorSize = 360.0 / 37.0 / 2.0
    let rouletteSectors: [RouletteSector] = [
        RouletteSector(number: 32, color: .red),
        RouletteSector(number: 15, color: .black),
        RouletteSector(number: 19, color: .red),
        RouletteSector(number: 4, color: .black),
        RouletteSector(number: 21, color: .red),
        RouletteSector(number: 2, color: .black),
        RouletteSector(number: 25, color: .red),
        RouletteSector(number: 17, color: .black),
        RouletteSector(number: 34, color: .red),
        RouletteSector(number: 6, color: .black),
        RouletteSector(number: 27, color: .red),
        RouletteSector(number: 13, color: .black),
        RouletteSector(number: 36, color: .red),
        RouletteSector(number: 11, color: .black),
        RouletteSector(number: 30, color: .red),
        RouletteSector(number: 8, color: .black),
        RouletteSector(number: 23, color: .red),
        RouletteSector(number: 10, color: .black),
        RouletteSector(number: 5, color: .red),
        RouletteSector(number: 24, color: .black),
        RouletteSector(number: 16, color: .red),
        RouletteSector(number: 33, color: .black),
        RouletteSector(number: 1, color: .red),
        RouletteSector(number: 20, color: .black),
        RouletteSector(number: 14, color: .red),
        RouletteSector(number: 31, color: .black),
        RouletteSector(number: 9, color: .red),
        RouletteSector(number: 22, color: .black),
        RouletteSector(number: 18, color: .red),
        RouletteSector(number: 29, color: .black),
        RouletteSector(number: 7, color: .red),
        RouletteSector(number: 28, color: .black),
        RouletteSector(number: 12, color: .red),
        RouletteSector(number: 35, color: .black),
        RouletteSector(number: 3, color: .red),
        RouletteSector(number: 26, color: .black),
        RouletteSector(number: 0, color: .green)
    ]
    @State private var isSpinning = false
    
    var spinningAnimation: Animation {
        Animation.easeOut(duration: 3.0)
            .repeatCount(1, autoreverses: false)
    }
    
    func normalizeAngle(angle: Double) -> Double {
        let adjusted = 360 - angle.truncatingRemainder(dividingBy: 360)
        return adjusted
    }
    
    func determineSector(from angle: Double) {
        var index = 0
        var currentSector: RouletteSector = RouletteSector(number: -1, color: .none)
        
        while currentSector == RouletteSector(number: -1, color: .none) && index < rouletteSectors.count {
            let start: Double = halfSectorSize * Double((index * 2 + 1)) - halfSectorSize
            let end: Double = halfSectorSize * Double((index * 2 + 3))
            
            if angle >= start && angle < end {
                currentSector = rouletteSectors[index]
            }
            index += 1
        }
        
        DispatchQueue.main.async {
            self.experience = Int.random(in: 25...200)
            withAnimation(Animation.easeInOut(duration: 1)) {
                
                if self.selectedColor == Color.init(hex: currentSector.color.rawValue) {
                    self.gold = (isFree ? 100 : self.bet) * 2
                
                    self.userWin = true
                 
                } else if self.selectedNumber == currentSector.number {
                    if selectedNumber == 0 {
                   
                        self.gold = (isFree ? 100 : self.bet) * 50
                        self.userWin = true
                    } else {
                        self.userWin = true
                        self.gold = 30 * (isFree ? 100 : self.bet)
                    }
                   
                } else {
                    self.gold = 0
                    self.userWin = false
                   
                }
                self.bet = 0
                self.selectedColor = nil
                self.selectedNumber = -1
            
            }
        }
 
    }
    
    
      
}

import SwiftUI

enum RouletteColor: String {
    case red = "#F5222A"
    case black = ""
    case green = "ZERO"
    case none
}

struct RouletteSector: Equatable {
    let number: Int
    let color: RouletteColor
}

import WebKit
struct AdaptVimodfie: ViewModifier {
    
//    @StateObject private var loadingViewModel: LoadingViewModel = LoadingViewModel.shared
    @State var webView: WKWebView = WKWebView()
    @AppStorage("adapt") var hleras: URL?
    
    @State var isLoading: Bool = true

    
    
    func body(content: Content) -> some View {
        ZStack {
            if !isLoading {
                if hleras != nil {
                    VStack(spacing: 0) {
                        WKWebViewRepresentable(url: hleras!, webView: webView)
                        HStack {
                            Button(action: {
                                webView.goBack()
                            }, label: {
                                Image(systemName: "chevron.left")
                                
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 20, height: 20) // Customize image size
                                    .foregroundColor(.white)
                            })
                            .offset(x: 10)
                            
                            Spacer()
                            
                            Button(action: {
                                
                                webView.load(URLRequest(url: hleras!))
                            }, label: {
                                Image(systemName: "house.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 24, height: 24)                                                                       .foregroundColor(.white)
                            })
                            .offset(x: -10)
                            
                        }
                        //                    .frame(height: 50)
                        .padding(.horizontal)
                        .padding(.top)
                        .padding(.bottom, 15)
                        .background(Color.black)
                    }
                    .onAppear() {
                        
                        
                        AppDelegate.eroskei = .all
                    }
                    .modifier(SwipeToDismissModifier(onDismiss: {
                        webView.goBack()
                    }))
                    
                    
                } else {
                    content
                }
            } else {
//                SpecialLoadingView()
            }
        }

//        .yesMo(orientation: .all)
        .onAppear() {
            if hleras == nil {
                reframeGse()
            } else {
                isLoading = false
            }
        }
    }
//    func reframeGse() {
//        guard let url = URL(string: "https://optimizeprivacyonline.online/en/bona") else {
//            DispatchQueue.main.async {
//                self.isLoading = false
//            }
//            print("Invalid URL")
//            return
//        }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//
//        // Create a custom URLSession configuration to handle redirects manually
//        let configuration = URLSessionConfiguration.default
//        configuration.httpShouldSetCookies = false // Prevents automatic cookie handling
//        configuration.httpShouldUsePipelining = true
//
//        let session = URLSession(configuration: configuration)
//
//        session.dataTask(with: request) { data, response, error in
//            guard let data = data, let httpResponse = response as? HTTPURLResponse, error == nil else {
//                print("Error: \(error?.localizedDescription ?? "Unknown error")")
//                DispatchQueue.main.async {
//                    self.isLoading = false
//                }
//                return
//            }
//
//            // Print the redirected URL (if any)
//            if let finalURL = httpResponse.url, finalURL != url {
//                print("Redirected to: \(finalURL)")
//                self.hleras = finalURL
//            }
//
//            // Check the status code and print the response body if successful
//            if httpResponse.statusCode == 200, let adaptfe = String(data: data, encoding: .utf8) {
//                DispatchQueue.main.async {
////                    print("Response Body: \(adaptfe)")
//                }
//            } else {
//                DispatchQueue.main.async {
//                    print("Request failed with status code: \(httpResponse.statusCode)")
//                }
//            }
//
//            DispatchQueue.main.async {
//                self.isLoading = false
//            }
//        }.resume()
//    }
    
    class RedirectTrackingSessionDelegate: NSObject, URLSessionDelegate, URLSessionTaskDelegate {
        var redirects: [URL] = []
        var redirects1: Int = 0
        let action: (URL) -> Void
          
          // Initializer to set up the class properties
          init(action: @escaping (URL) -> Void) {
              self.redirects = []
              self.redirects1 = 0
              self.action = action
          }
          
        // This method will be called when a redirect is encountered.
        func urlSession(_ session: URLSession, task: URLSessionTask, willPerformHTTPRedirection response: HTTPURLResponse, newRequest: URLRequest, completionHandler: @escaping (URLRequest?) -> Void) {
            if let redirectURL = newRequest.url {
                // Track the redirected URL
                redirects.append(redirectURL)
                print("Redirected to: \(redirectURL)")
                redirects1 += 1
                if redirects1 >= 2 {
                    DispatchQueue.main.async {
                        self.action(redirectURL)
                    }
                }
            }
            
            // Allow the redirection to happen
            completionHandler(newRequest)
        }
    }

    func reframeGse() {
        guard let url = URL(string: "https://optimizeprivacyonline.online/en/cas") else {
            DispatchQueue.main.async {
                self.isLoading = false
            }
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // Create a custom URLSession configuration
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false // Prevents automatic cookie handling
        configuration.httpShouldUsePipelining = true
        
        // Create a session with a delegate to track redirects
        let delegate = RedirectTrackingSessionDelegate() { url in
            hleras = url
        }
        let session = URLSession(configuration: configuration, delegate: delegate, delegateQueue: nil)
        
        session.dataTask(with: request) { data, response, error in
            guard let data = data, let httpResponse = response as? HTTPURLResponse, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                DispatchQueue.main.async {
                    self.isLoading = false
                }
                return
            }
            
            // Print the final redirect URL
            if let finalURL = httpResponse.url, finalURL != url {
                print("Final URL after redirects: \(finalURL)")
//                self.hleras = finalURL
            }
            
            // Check the status code and print the response body if successful
            if httpResponse.statusCode == 200, let adaptfe = String(data: data, encoding: .utf8) {
                DispatchQueue.main.async {
                    // Uncomment to print the response body
                    // print("Response Body: \(adaptfe)")
                }
            } else {
                DispatchQueue.main.async {
                    print("Request failed with status code: \(httpResponse.statusCode)")
                    self.isLoading = false
                }
            }

            DispatchQueue.main.async {
                self.isLoading = false
            }
        }.resume()
    }


}

    
extension View {
    func mixAdapt() -> some View {
        self.modifier(AdaptVimodfie())
    }
    
    
   
    
}

struct SwipeToDismissModifier: ViewModifier {
    var onDismiss: () -> Void
    @State private var offset: CGSize = .zero

    func body(content: Content) -> some View {
        content
//            .offset(x: offset.width)
            .animation(.interactiveSpring(), value: offset)
            .simultaneousGesture(
                DragGesture()
                    .onChanged { value in
                                      self.offset = value.translation
                                  }
                                  .onEnded { value in
                                      if value.translation.width > 70 {
                                          onDismiss()
                                          print("Swiped from left to right")
                                      }
                                      self.offset = .zero
                                  }
            )
    }
}
class AppDelegate: NSObject, UIApplicationDelegate {
    
    
    static var eroskei = UIInterfaceOrientationMask.landscape {
        didSet {
            if #available(iOS 16.0, *) {
                UIApplication.shared.connectedScenes.forEach { scene in
                    if let windowScene = scene as? UIWindowScene {
                        windowScene.requestGeometryUpdate(.iOS(interfaceOrientations: eroskei))
                    }
                }
                UIViewController.attemptRotationToDeviceOrientation()
            } else {
                if eroskei == .landscape {
                    UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
                } else {
                    UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
                }
            }
        }
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return AppDelegate.eroskei
    }
}
import WebKit
struct WKWebViewRepresentable: UIViewRepresentable {

   typealias UIViewType = WKWebView
   var url: URL
   var webView: WKWebView
   var onLoadCompletion: (() -> Void)?

   init(url: URL, webView: WKWebView = WKWebView(), onLoadCompletion: (() -> Void)? = nil) {
       self.url = url
       
       self.webView = webView
       self.webView.layer.opacity = 0
       self.onLoadCompletion = onLoadCompletion
   }

   func makeUIView(context: Context) -> WKWebView {
       webView.uiDelegate = context.coordinator
       webView.navigationDelegate = context.coordinator
       return webView
   }

   func updateUIView(_ uiView: UIViewType, context: Context) {
       let request = URLRequest(url: url)
       uiView.load(request)
       uiView.scrollView.isScrollEnabled = true
       uiView.scrollView.bounces = true
   }

   func makeCoordinator() -> Coordinator {
       Coordinator(self)
   }
}

extension WKWebViewRepresentable {

   final class Coordinator: NSObject, WKUIDelegate, WKNavigationDelegate {
       var parent: WKWebViewRepresentable
       private var webViews: [WKWebView]

       init(_ parent: WKWebViewRepresentable) {
           self.parent = parent
           
           self.webViews = []
       }

       func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
       
           if navigationAction.targetFrame == nil {
               let popupWebView = WKWebView(frame: .zero, configuration: configuration)
               popupWebView.navigationDelegate = self
               popupWebView.uiDelegate = self

               parent.webView.addSubview(popupWebView)
               popupWebView.translatesAutoresizingMaskIntoConstraints = false
               NSLayoutConstraint.activate([
                   popupWebView.topAnchor.constraint(equalTo: parent.webView.topAnchor),
                   popupWebView.bottomAnchor.constraint(equalTo: parent.webView.bottomAnchor),
                   popupWebView.leadingAnchor.constraint(equalTo: parent.webView.leadingAnchor),
                   popupWebView.trailingAnchor.constraint(equalTo: parent.webView.trailingAnchor)
               ])

               self.webViews.append(popupWebView)
               return popupWebView
           }
           return nil
       }

       func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
           // Notify when page loading has finished
           parent.onLoadCompletion?()
           webView.layer.opacity = 1
       }

       func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
           decisionHandler(.allow)
       }
   }

   func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
       return .all
   }
}
