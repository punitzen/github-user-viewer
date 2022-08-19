//
//  Utilities.swift
//  GitUserViewer
//
//  Created by Punit Kumar on 01/08/22.
//

import UIKit
import Foundation

// MARK: - Image Download Extension
extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.activityIndicator.stopAnimating()
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        self.activityIndicator.startAnimating()
        guard let url = URL(string: link) else {
            return }
        downloaded(from: url, contentMode: mode)
    }
    
    fileprivate var activityIndicator: UIActivityIndicatorView {
        get {
            if let indicator = self.subviews.first(where: { $0 is UIActivityIndicatorView }) as? UIActivityIndicatorView {
                return indicator
            }
            
            let activityIndicator = UIActivityIndicatorView(style: .large)
            activityIndicator.hidesWhenStopped = true
            self.addSubview(activityIndicator)
            activityIndicator.translatesAutoresizingMaskIntoConstraints = false
            
            let centerX = NSLayoutConstraint(item: self,
                                             attribute: .centerX,
                                             relatedBy: .equal,
                                             toItem: activityIndicator,
                                             attribute: .centerX,
                                             multiplier: 1,
                                             constant: 0)
            
            let centerY = NSLayoutConstraint(item: self,
                                             attribute: .centerY,
                                             relatedBy: .equal,
                                             toItem: activityIndicator,
                                             attribute: .centerY,
                                             multiplier: 1,
                                             constant: 0)
            
            self.addConstraints([centerX, centerY])
            return activityIndicator
        }
    }
    
    func circular(){
        self.layer.cornerRadius = self.frame.size.width/2
        self.clipsToBounds = true
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 4
    }
}

// MARK: - PopViewController Extension
extension UINavigationController {
    func getViewController<T: UIViewController>(of type: T.Type) -> UIViewController? {
        return self.viewControllers.first(where: { $0 is T })
    }
    func popToViewController<T: UIViewController>(of type: T.Type, animated: Bool) {
        guard let viewController = self.getViewController(of: type) else { return }
        self.popToViewController(viewController, animated: animated)
    }
}

// MARK: - Date Difference Extension
extension Date {
    /// Returns the amount of years from another date
    func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    /// Returns the amount of months from another date
    func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
    /// Returns the amount of weeks from another date
    func weeks(from date: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfMonth], from: date, to: self).weekOfMonth ?? 0
    }
    /// Returns the amount of days from another date
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    /// Returns the amount of hours from another date
    func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    /// Returns the amount of minutes from another date
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    /// Returns the amount of seconds from another date
    func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
    /// Returns the a custom time interval description from another date
    func offset(from date: Date) -> String {
        
        if years(from: date) == 1 { return "last updated a year ago" }
        else if years(from: date) > 0 { return "last updated \(years(from: date)) years ago" }
        if months(from: date) == 1 { return "last updated a month ago" }
        else if months(from: date) > 0 { return "last updated \(months(from: date)) months ago" }
        if weeks(from: date) == 1 { return "last updated a week ago" }
        else if weeks(from: date) > 0 { return "last updated \(weeks(from: date)) weeks ago" }
        if days(from: date) == 1 { return "last updated a day ago" }
        else if days(from: date) > 0 { return "last updated \(days(from: date)) days ago" }
        if hours(from: date) == 1 { return "last updated a hour ago" }
        else if hours(from: date) > 0 { return "last updated \(hours(from: date)) hours ago" }
        if minutes(from: date) == 1 { return "last updated a minute ago" }
        else if minutes(from: date) > 0 { return "last updated \(minutes(from: date)) minutes ago" }
        if seconds(from: date) == 1 { return "last updated a seconds ago" }
        else if seconds(from: date) > 0 { return "last updated \(seconds(from: date)) seconds ago" }
        return ""
    }
}

// MARK: - Activity Indicator Extension
fileprivate var activityView: UIView?

extension UIViewController {
    func startSpinner() {
        activityView = UIView(frame: self.view.bounds)
        activityView?.backgroundColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 1)
        let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        activityIndicator.center = activityView!.center
        activityIndicator.startAnimating()
        activityView?.addSubview(activityIndicator)
        self.view.addSubview(activityView!)
    }
    
    func stopSpinner(){
        activityView?.removeFromSuperview()
        activityView = nil
    }
}

class RoundNumberUtility {
    // MARK: - Round off Utility
    static func roundedWithAbbreviations(_ number: Int) -> String{
        let nf = NumberFormatter()
        nf.roundingMode = .down
        nf.maximumFractionDigits = 1
        
        let number = Double(number)
        let thousand = number / 1000
        let million = number / 1000000
        let billion = number / 1000000000
        
        if billion >= 1.0 {
            return nf.string(for: billion)! + "B"
        }
        else if million >= 1.0 {
            return nf.string(for: million)! + "M"
        }
        else if thousand >= 1.0 {
            return nf.string(for: thousand)! + "K"
        }
        else {
            return "\(Int(number))"
        }
    }
}

class DateUtility {
    // MARK: - Date Difference Utility
    let date: Date
    
    init(date: Date = Date()){
        self.date = date
    }
    
    func timeDateDifference(repoDate: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        if let date = dateFormatter.date(from: repoDate){
            return (self.date.offset(from: date))
        }
        return ""
    }
}
