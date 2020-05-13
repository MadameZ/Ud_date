//
//  ViewController.swift
//  Date
//
//  Created by Caroline Zaini on 13/05/2020.
//  Copyright © 2020 Caroline Zaini. All rights reserved.
//

import UIKit

/// Objectif : mettre à jour tous les labels en fonctions de la dateStringLbl

class ViewController: UIViewController {

    /// obtenir une String au format de notre choix
    @IBOutlet weak var dateStringLbl: UILabel!
    
    /// Time Interval
    @IBOutlet weak var timeIntervalLbl: UILabel!
    
    /// Si aujourd'hui, demain, hier, weekend
    @IBOutlet weak var calendarLbl: UILabel!
    
    /// Il y a + mois, jours, heures
    @IBOutlet weak var ilyaLbl: UILabel!
    
    /// Voir le site :
    ///https://codabee.com/convertir-string-date-swift/
    let format = "EEEE dd MMMM yy - HH:mm:ss - ZZZZ"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func dateChoisie(_ sender: UIDatePicker) {
        
        let date = sender.date
        
//        dateStringLbl.text = date.toString()
        
        /// format de la date
        dateStringLbl.text = date.stringWithFormat(format)
        
        /// timeInterval cad le nombre de secondes passées depuis une date
        timeIntervalLbl.text = date.timeStamp()
        
        calendarLbl.text = date.quelJour()
        
        ilyaLbl.text = date.components()
    }
    
}

extension Date {
    
    func toString() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        formatter.locale = Locale(identifier: "fr_FR")
        return formatter.string(from: self)
    }
    
    func stringWithFormat(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale(identifier: "fr_FR")
        return formatter.string(from: self)
    }
    
    func timeStamp() -> String {
        let tempsEcoule = self.timeIntervalSinceNow
        return String(format: "%.2f", tempsEcoule)
    }
    
    func quelJour() -> String {
        var str = ""
        let cal = Calendar.current
        
            if cal.isDateInToday(self) {
                str += "Aujourd'hui "
            }
            if cal.isDateInYesterday(self) {
                str += "Hier "
            }
            if cal.isDateInTomorrow(self) {
                str += "Demain "
            }
            if cal.isDateInWeekend(self) {
                str += "Weekend"
            }
        
            return str
    }
    
    func components() -> String {
        let cal = Calendar.current
        let components = cal.dateComponents([.month, .day, .hour, .minute], from: self, to: Date())
        /// month sera égal à components.month sinon il sera égal à 0
        let month = components.month ?? 0
        let day = components.day ?? 0
        let hour = components.hour ?? 0
        let minute = components.minute ?? 0
        return "Temps écoulé -> mois: \(month), jour(s): \(day), heure(s): \(hour), minute(s): \(minute)"
    }
}

