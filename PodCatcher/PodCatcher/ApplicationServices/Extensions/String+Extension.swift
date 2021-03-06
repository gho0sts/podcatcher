import Foundation

extension String {
    
    static func constructTimeString(time: Double) -> String {
        guard time > 0 else {
            return "0:00"
        }
        let hours: Int = Int(time / 3600)
        let minutes = Int(time.truncatingRemainder(dividingBy: 3600) / 60)
        let seconds = Int(time.truncatingRemainder(dividingBy: 60))

        let formattedMinutes = formatString(time: minutes)
        let formattedSeconds = formatString(time: seconds)
  
        var formattedTime = ""
        if hours > 0 {
            formattedTime = "\(hours):\(formattedMinutes):\(formattedSeconds)"
        } else {
            formattedTime = "\(formattedMinutes):\(formattedSeconds)"
        }
        return formattedTime
    }
    
    // Formats time for string for player time track timer
    static func formatString(time: Int) -> String {
        var formattedString = ""
        if time < 10 {
            formattedString = "0\(time)"
        } else {
            formattedString = "\(time)"
        }
        return formattedString
    }
    
    // String extension checks for valid id pattern and returns optional string

    static func extractID(from link: String) -> String? {
        let pattern = "id([0-9]+)"
        guard let regExp = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) else {
            return nil
        }
        let nsLink = link as NSString
        let options = NSRegularExpression.MatchingOptions(rawValue: 0)
        let range = NSRange(location: 0, length: nsLink.length)
        let matches = regExp.matches(in: link as String, options:options, range:range)
        if let firstMatch = matches.first {
            return nsLink.substring(with: firstMatch.range)
        }
        return nil
    }

}
