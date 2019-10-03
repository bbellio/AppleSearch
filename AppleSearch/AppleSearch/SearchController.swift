//
//  SearchController.swift
//  AppleSearch
//
//  Created by Bethany Wride on 10/3/19.
//  Copyright © 2019 Bethany Wride. All rights reserved.
//

// UIKit has Foundation in it
import UIKit

// MARK: - Magic Strings
struct StringConstants {
    //URL could be up here maybe?
    // Make sure to do this in the assessment
    fileprivate static let searchComponent = "search"
    fileprivate static let termkey = "term"
    fileprivate static let entityKey = "entity"
    fileprivate static let entityMusicValue = "musicTrack"
    fileprivate static let entityAppValue = "software"
}

class SearchController {
    // MARK: - Global variables
    
    // MARK: - Functions
    static let baseURL = URL(string: "https://itunes.apple.com/")
    
    // Use a completion handler with an array because you are returning results
    static func fetchMusicItemsWith(searchText: String, completion: @escaping ([MusicSearchResult]) -> Void) {
        guard var unwrappedURL = baseURL else{
            completion([])
            return
        }
        // No need to unwrap the components
        unwrappedURL.appendPathComponent(StringConstants.searchComponent)
        guard var urlComponents = URLComponents(url: unwrappedURL, resolvingAgainstBaseURL: true) else {
            completion([])
            return }
        let searchTermQuery = URLQueryItem(name: StringConstants.termkey, value: searchText)
        let entityQuery = URLQueryItem(name: StringConstants.entityKey, value: StringConstants.entityMusicValue)
        urlComponents.queryItems = [searchTermQuery, entityQuery]
        
        guard let finalURL = urlComponents.url else {
            print("Error with components")
            completion([])
            return
        }
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                completion([])
                return
            }
            
            guard let unwrappedData = data else {
                print("No data")
                completion([])
                return
            }
            
            do {
                let decodedMusicTopLevelDictionary = try JSONDecoder().decode(MusicTopLevelDictionary.self, from: unwrappedData)
                completion(decodedMusicTopLevelDictionary.results)
            } catch {
                print("Error decoding data")
            }
        }.resume()
    } // End of function
    
    static func fetchAppItemsWith(searchText: String, completion: @escaping ([AppSearchResult]) -> Void) {
        guard var unwrappedURL = baseURL else {
            completion([])
            return
        }
        unwrappedURL.appendPathComponent(StringConstants.searchComponent)
        guard var urlComponents = URLComponents(url: unwrappedURL, resolvingAgainstBaseURL: true) else {
            completion([])
            return
        }
        let searchTermQuery = URLQueryItem(name: StringConstants.termkey, value: searchText)
        let entityQuery = URLQueryItem(name: StringConstants.entityKey, value: StringConstants.entityAppValue)
        urlComponents.queryItems = [searchTermQuery, entityQuery]
        
        guard let finalURL = urlComponents.url else {
            print("Error with components")
            completion([])
            return
        }
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                completion([])
                return
            }
            
            guard let unwrappedData = data else {
                print("No data")
                completion([])
                return
            }
            
            do {
                let decodedAppTopLevelDictionary = try JSONDecoder().decode(AppTopLevelDictionary.self, from: unwrappedData)
                completion(decodedAppTopLevelDictionary.results)
            } catch {
                print("Error decoding data")
            }
        }.resume()
    } // End of function
    
    static func getMusicImageFor(item: MusicSearchResult, completion: @escaping (UIImage?) -> Void) {
        guard let imageURLAsString = item.artworkUrl100,
            let imageURL = URL(string: imageURLAsString) else {
                print("Item did not have an image at URL provided")
                completion(nil)
                return
        }
        
        URLSession.shared.dataTask(with: imageURL) { (data, _, error) in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                completion(nil)
                return
            }
            
            guard let unwrappedData = data else {
                print("No data")
                completion(nil)
                return
            }
            
            let image = UIImage(data: unwrappedData)
            completion(image)
        }.resume()
    } // End of function
    
    static func getAppImageFor(item: AppSearchResult, completion: @escaping (UIImage?) -> Void) {
        guard let imageURLAsString = item.artworkUrl100,
            let imageURL = URL(string: imageURLAsString) else {
                print("Item did not have an imaeg at URL provided")
                completion(nil)
                return
        }
        
        URLSession.shared.dataTask(with: imageURL) { (data, _, error) in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                completion(nil)
                return
            }
            
            guard let unwrappedData = data else {
                print("No data")
                completion(nil)
                return
            }
            
            let image = UIImage(data: unwrappedData)
            completion(image)
        }.resume()
    } // End of function
} // End of class
