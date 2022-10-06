//
//  FifthVC.swift
//  PushNotification_DemoPractice
//
//  Created by tmtech1 on 22/09/22.
//

import UIKit
import Foundation
import SwiftWebSocket

class FifthVC: UIViewController,URLSessionWebSocketDelegate {

    var webSocket: URLSessionWebSocketTask?
    var isOpened = false
    var isConnected = false
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .green
        button.setTitle("Close", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //openWebSocket(urlString: "wss://rtf.beta.getbux.com/subscriptions/me*")
        
        let url = "wss://demo.piesocket.com/v3/channel_1?api_key=VCXCEuvhGcBDP7XhiJJUDvR1e1D3eiVjgZ9VRiaV&notify_self"
        openWebSocketWithUrlSession(urlString: url)
        
        closeButton.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        view.addSubview(closeButton)
        closeButton.addTarget(self, action: #selector(close), for: .touchUpInside)
        closeButton.center = view.center
    }

    func ping() {
        
        webSocket?.sendPing(pongReceiveHandler: { (error) in
            if let error = error {
                print("ping error:- \(error)")
            }
        })
    }
    
    @objc func close() {
        
        webSocket?.cancel(with: .goingAway, reason: "Demo ended".data(using: .utf8))
    }
    
    func send() {
        
        DispatchQueue.global().asyncAfter(wallDeadline: .now() + 1) {
            self.webSocket?.send(.string("Send new message:- \(Int.random(in: 0...1000))"), completionHandler: { (error) in
                if let error = error {
                    print("send error:- \(error)")
                }
                self.send()
            })
        }
    }
    
    func receive() {
        
        webSocket?.receive(completionHandler: { [weak self] result in
            
            switch result {
                
                case .success(let message):
                    switch message {
                        case .data(let data):
                            print("got data:- \(data)")
                        case .string(let message):
                            print("got string: - \(message)")
                        @unknown default:
                            break
                    }
                case .failure(let error):
                    print("receive error:- \(error)")
            }
            self?.receive()
        })
    }
    
    //MARK: - web socket method - using default urlsessionwebsocket delegate method
    func openWebSocketWithUrlSession(urlString: String) {
        
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue())
            webSocket = session.webSocketTask(with: url)
            webSocket?.resume()
        }
    }
    
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didOpenWithProtocol protocol: String?) {
        
        print("did connect to socket")
        ping()
        receive()
        send()
        
        isOpened = true
    }
    
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
        
        print("did close connection with reason")
        
        isOpened = false
    }
    
    
    //MARK: - web socket method - using swiftwebsocket third party library
/*    private func openWebSocket(urlString: String) {
        if let url = URL(string: urlString) {
            var request = URLRequest(url: url)
            
            // Add custom header parameters if necessary
            //request.addCustomHeaders()
            
            let webSocket = WebSocket(request: request)
            
            webSocket.event.open = { [weak self] in
                self?.opened = true
            }
            
            webSocket.event.close = { [weak self] (code, reason, clean) in
                guard let self = self else { return }
                self.webSocket = nil
                self.connected = false
                self.opened = false
            }
            self.webSocket = webSocket
        } else {
            webSocket = nil
        }
    }
*/
}
