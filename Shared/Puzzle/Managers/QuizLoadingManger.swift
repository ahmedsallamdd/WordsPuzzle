//
//  QuizLoadingManger.swift
//  Words Puzzle (iOS)
//
//  Created by Ahmed Sallam on 04/09/2022.
//

import Foundation

protocol DataLoadingProtocol {
    func fetchQuizzes(completion: @escaping ([Quiz]) -> Void)
}

class QuizLoadingManager : DataLoadingProtocol {
    
    func fetchQuizzes(completion: @escaping ([Quiz]) -> Void) {
        var quizList = [Quiz]()
        
        if let quizzes = self.loadMovies() {
            quizList.append(contentsOf: quizzes)
        }
        
        if let countriesAndCapitals = self.loadCountriesAndCities() {
            quizList.append(contentsOf: countriesAndCapitals)
        }
        
        completion(quizList.shuffled())
    }
    
    fileprivate func loadCountriesAndCities() -> [Quiz]? {
        if let url = Bundle.main.url(forResource: "Countries", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(CountriesModel.self, from: data)
                
                var quizList = [Quiz]()
                
                let countries = jsonData.countries
                for country in countries {
                    
                    var largestWordCount = country.name.getBiggestWordSizeFromSentence(splitBy: " ")
                    
                    if largestWordCount > 0
                        && largestWordCount < 10
                        && country.name.containsSpecialCharacter == false {
                        
                        let countryQuiz = Quiz(content: country.name,
                                               category: "Countries",
                                               hint: "")
                        
                        quizList.append(countryQuiz)
                        
                    }
                    
                    largestWordCount = country.capital.getBiggestWordSizeFromSentence(splitBy: " ")
                    if largestWordCount > 0
                        && largestWordCount < 10
                        && country.capital.containsSpecialCharacter == false {
                        
                        let capitalCityQuiz = Quiz(content: country.capital,
                                                   category: "Capitals",
                                                   hint: "")
                        
                        quizList.append(capitalCityQuiz)
                    }
                }
                
                return quizList
                
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
    
    fileprivate func loadMovies() -> [Quiz]? {
        if let url = Bundle.main.url(forResource: "Movies", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(MoviesModel.self, from: data)
                
                var quizList = [Quiz]()
                
                let movies = jsonData.movies
                for movie in movies {
                    let largestWordCount = movie.title.getBiggestWordSizeFromSentence(splitBy: " ")
                    if largestWordCount > 0
                        && largestWordCount < 10
                        && movie.title.containsSpecialCharacter == false {
                        
                        let quiz = Quiz(content: movie.title,
                                        category: "Movies / Series",
                                        hint: "")
                        quizList.append(quiz)
                        
                    }
                }
                
                return quizList
                
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
}
