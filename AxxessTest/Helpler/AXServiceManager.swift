//
//  ServiceManager.swift
//  AxxessTest
//
//  Created by Hemil Modi on 05/09/20.
//  Copyright © 2020 Hemil Modi. All rights reserved.
//

import UIKit
import  Alamofire

enum AXAPIType
{
    case Challenge
   
    func getEndPoint() -> String
    {
        switch self
        {
        case .Challenge:
            return "master/challenge.json"
        }
    }
}

typealias APIResponseBlock = ((_ response: Any?,_ isSuccess: Bool,_ error: Error?)->())

class AXServiceManager: NSObject {

    static let shared:AXServiceManager = AXServiceManager()
    private override init() {
        
    }
    
    private  let baseURL:String = "https://raw.githubusercontent.com/AxxessTech/Mobile-Projects/"
    
    
    private let APIVersion:String = ""
    
    
    //MARK: - GET REQUEST
    
    private func getRequestParams(ForAPIType apiType:AXAPIType,WithParams paramFromController:[String:Any]?,withID strID:String = "") -> (apiURL:String,params:Data,headers:[String:String])
    {
        
        /* API URL */
        
        var  apiUrl:String = "\(self.baseURL)"
        if APIVersion.characters.count > 0
        {
            apiUrl = apiUrl.appending("\(self.APIVersion)/")
        }
        apiUrl = apiUrl.appending("\(apiType.getEndPoint())")
        if !strID.isEmpty{
            apiUrl = apiUrl.appending("/\(strID)")
        }
        
        /* API Headers */
        var headersForAPI:[String:String] = [:]
        
        /* API Parameters */
        let structuredParams = paramFromController
        
        switch apiType {
        case .Challenge:
            
            break
        default:
            headersForAPI["content-type"] = "application/json"
            break
        }
        var dataPerameters:Data = Data()
        
        do {
            if structuredParams != nil
            {
                dataPerameters = try JSONSerialization.data(withJSONObject: structuredParams as Any, options: .prettyPrinted)
            }
        }catch
        {
            print("Failed to convert to string")
        }
        
        return (apiUrl,dataPerameters,headersForAPI)
    }
    
    func callGetAPI(forAPIType apiType:AXAPIType, withPerameters perameters:[String:Any],withAppendIDInURL strID:String = "",withDisplayLoader isVisible:Bool = true ,withResponseBlock responseBlock:APIResponseBlock?) -> Void
    {
        if AXRechability.shared.networkStatus == .disconnected
        {
                   AXToastManager.shared.showInternetConnectionMessage(withMessage: Constant.ErrorMessage.InternetNotConnected)
                   //return
        }
        let apiHelpers = self.getRequestParams(ForAPIType: apiType, WithParams: perameters,withID: strID)
        if Constant.isPrintEnable{
        print("/****************** New API Called ******************/")
        print("/* API URL : \(apiHelpers.apiURL)")
        print("/* API Params : \(perameters)")
        print("/* API Headers : \(apiHelpers.headers)")
        print("/*******************************************************/")
        }
        var request = URLRequest(url: URL(string: apiHelpers.apiURL)!)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        //request.httpBody = apiHelpers.params;
        request.allHTTPHeaderFields = apiHelpers.headers
        if isVisible{
           AXLoader.shared.showLoader(withMessage: "")
        }

        AF.request(request).responseJSON { (response) in
            AXLoader.shared.hideLoader()
            
            switch response.result{
            case .success(let json):
                // You got Success :)
                if Constant.isPrintEnable{
                print(json)
                print("Response Status Code :: \(response.response?.statusCode)")
                }
                if response.response?.statusCode == 200
                {
                    if let jsonResponse = json as? [NSDictionary]
                    {
                        responseBlock!(jsonResponse, true, nil)
                    }else{
                        print("Json Object is not NSDictionary : Please Check this API \(apiType.getEndPoint())")
                        responseBlock!(nil, true, nil)
                    }
                }
                else
                {
                    if let jsonResponse = json as? NSDictionary
                    {
                        responseBlock!(jsonResponse, false, nil)
                    }else{
                        print("Json Object is not NSDictionary : Please Check this API \(apiType.getEndPoint())")
                        responseBlock!(nil, false, nil)
                    }
                }
                
                
                break
            case .failure(let error):
                // You Got Failure :(
                
                print("Response Status Code :: \(apiType) ::\(response.response?.statusCode)")
                if let data = response.data{
                    let datastring = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                    print(datastring ?? "Test")
                    
                }
                responseBlock!(nil,false,error)
                break
            }
            
        }
        
    }
    
    
}
