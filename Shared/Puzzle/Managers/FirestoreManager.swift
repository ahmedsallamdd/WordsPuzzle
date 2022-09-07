////
////  FirestoreManager.swift
////  Words Puzzle (iOS)
////
////  Created by Ahmed Sallam on 23/08/2022.
////
//
//import Foundation
//import FirebaseFirestore
//import FirebaseFirestoreSwift
//
//class FirestoreManager : DataLoadingProtocol {
//    static let shared = FirestoreManager()
//    private init() {}
//    
//    fileprivate let quizDB = Firestore.firestore().collection("Quizzes")
//    
//    func fetchQuizzes(completion: @escaping ([Quiz]) -> Void) {
//        var quizzesList = [Quiz]()
//        
//        self.quizDB.getDocuments() { (querySnapshot, err) in
//            
//            if let err = err {
//                print("Error getting documents: \(err)")
//            } else {
//                for document in querySnapshot!.documents {
//                    do {
//                        let quiz = try document.data(as: Quiz.self)
//                        quizzesList.append(quiz)
//                        
//                    } catch (let error) {
//                        print(error)
//                    }
//                }
//                completion(quizzesList)
//
//            }
//        }
//    }
//}
