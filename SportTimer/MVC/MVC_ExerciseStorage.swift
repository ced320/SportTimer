//
//  MVC_ExerciseStorage.swift
//  SportTimer
//
//  Created by Cedric Frimmel-Hoffmann on 25.07.23.
//


import SwiftUI
import AVFAudio

class MVC_ExerciseStorage: ObservableObject {
    
    @Published private(set) var choosableWorkouts: M_ChoosableExerciseSets {
        didSet {
            storeInUserDefaults()
        }
    }
    private var userDefaultsKey: String {"ExerciseSetStore"}
    
    init(named name: String) {
        choosableWorkouts = M_ChoosableExerciseSets(basicInit: true)
        //deleteUserDefaults()
        restoreFromUserDefaults()
    }
    
    func createExerciseSet(nameOfExerciseSet: String, exercisesOfSet: [M_Exercise]) {
        if(nameOfExerciseSet == "") {
            return
        }
        choosableWorkouts.createNewExerciseSet(name: nameOfExerciseSet, exercises: exercisesOfSet)
    }
    
    func deleteExerciseSet(uniqueIdOfExerciseSet id: String) {
        choosableWorkouts.deleteExerciseSet(uniqueName: id)
    }
    
    func getSelectedExerciseSet() -> M_ExerciseSet {
        choosableWorkouts.getSelectedExerciseSet()
    }
    
    func chooseExerciseSet(exerciseSet: M_ExerciseSet) {
        choosableWorkouts.chooseExerciseSet(nameOfExerciseSet: exerciseSet.name)
    }
    
    
    private func storeInUserDefaults() {
        UserDefaults.standard.set(try? JSONEncoder().encode(choosableWorkouts), forKey: userDefaultsKey)
    }
    
    private func deleteUserDefaults() {
        let prefs = UserDefaults.standard
        //let keyValue = prefs.string(forKey: "ExerciseSetStore")
        prefs.removeObject(forKey: "ExerciseSetStore")
    }
    
    private func restoreFromUserDefaults() {
        if let jsonData = UserDefaults.standard.data(forKey: userDefaultsKey),
           let decodedM_ChoosableExerciseSets = try? JSONDecoder().decode(M_ChoosableExerciseSets.self, from: jsonData) {
            choosableWorkouts = decodedM_ChoosableExerciseSets
        }
    }
}

