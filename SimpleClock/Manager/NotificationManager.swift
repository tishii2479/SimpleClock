//
//  NotificationManager.swift
//  SimpleClock
//
//  Created by Tatsuya Ishii on 2022/01/09.
//

import Foundation
import AudioToolbox

class NotificationManager: ObservableObject {
    static let shared = NotificationManager()
    @Published var isVibrating: Bool = false

    func vibrate() {
        isVibrating = true
        DispatchQueue.global(qos: .default).async {
            for _ in 0 ..< 10 {
                // if stopVibrate() is called, stop vibrating
                if self.isVibrating == false { break }
                AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                sleep(1)
            }
            
            DispatchQueue.main.async {
                self.isVibrating = false
            }
        }
    }
    
    func stopVibrate() {
        isVibrating = false
    }
}
