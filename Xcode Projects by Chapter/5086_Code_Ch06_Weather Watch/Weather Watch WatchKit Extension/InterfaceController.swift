
import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    
    @IBOutlet var getWeatherButton: WKInterfaceButton!
    
    @IBAction func getWeatherButtonTapped() {
        requestWeatherData()
    }
    
    func requestWeatherData() {
        updateUIForNetworkActivity(true)
        WeatherSessionManager.sharedInstance.fetchWeatherData(){ (data: NSData?, response: NSURLResponse?, taskError: NSError?) in
            self.updateUIForNetworkActivity(false)
            if taskError == nil {
                do {
                    let jsonData = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! jsonDict
                    print(jsonData)
                    self.showWeather(jsonData)
                }
                catch let jsonError as NSError {
                    print(jsonError.localizedDescription)
                }
            } else {
                let action = WKAlertAction(title: "OK", style: .Default, handler: {})
                let alertText = taskError!.localizedDescription
                self.presentAlertControllerWithTitle(
                    alertText,
                    message: "",
                    preferredStyle: .ActionSheet,
                    actions: [action])
            }
        }
    }
    
    func showWeather(data: jsonDict) {
        pushControllerWithName("WeatherTableInterfaceController", context: data)
    }
    
    func updateUIForNetworkActivity(isActive: Bool) {
        if isActive {
            getWeatherButton.setTitle("Fetching Data")
            getWeatherButton.setEnabled(false)
        } else {
            getWeatherButton.setTitle("Update Weather")
            getWeatherButton.setEnabled(true)
        }
    }
    
}
