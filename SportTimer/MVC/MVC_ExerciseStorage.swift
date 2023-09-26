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
    private var colors = M_ColorScheme()
    private var userDefaultsKey: String {"ExerciseSetStore"}
    
    
    /// Ensure that choosableWorkouts is correctly initialised
    /// 1. Way) The old choosableWorkouts is loaded from the last session
    /// 2. Way) If there is no choosableWorkouts a standard initialiser is chosen
    init() {
        choosableWorkouts = M_ChoosableExerciseSets(basicInit: true)
        deleteUserDefaults()
        //restoreFromUserDefaults()
    }
    
    /// creates exerciseSets and adds it choosableWorkouts if the given name is not ""
    /// - Parameters:
    ///   - nameOfExerciseSet: should not be ""
    ///   - exercisesOfSet: list of M_exercises
    func createExerciseSet(nameOfExerciseSet: String, exercisesOfSet: [M_Exercise]) {
        if(nameOfExerciseSet == "") {
            return
        }
        var copiedExerciseSet = exercisesOfSet
        //remove the last element of the exerciseSet if its a break
        if exercisesOfSet.contains(where: {element in !element.isPause}) {
            if let lastElement = exercisesOfSet.last {
                if lastElement.isPause {
                    copiedExerciseSet.removeLast()
                }
            }
        }
        choosableWorkouts.createNewExerciseSet(name: nameOfExerciseSet, exercises: copiedExerciseSet)
    }
    
    
    /// deletes exercise if it is there
    /// - Parameter id: the id that shall be deleted
    func deleteExerciseSet(uniqueIdOfExerciseSet id: String) {
        choosableWorkouts.deleteExerciseSet(uniqueName: id)
    }
    
    /// as function name
    /// - Returns: as function name
    func getSelectedExerciseSet() -> M_ExerciseSet {
        choosableWorkouts.getSelectedExerciseSet()
    }
    
    
    /// Moves internal pointer to the chosen exerciseSet so that this exerciseSet will be used for the next workout
    /// - Parameter exerciseSet: the exerciseSet that shall be used for workout
    func chooseExerciseSet(exerciseSet: M_ExerciseSet) {
        choosableWorkouts.chooseExerciseSet(nameOfExerciseSet: exerciseSet.name)
    }
    
    func getThemeColors(type: TypeOfColor, colorScheme: ColorScheme) -> Color {
        colors.giveColor(typeOfColor: type, darkMode: colorScheme)
    }
    
    /// save persistent data
    private func storeInUserDefaults() {
        UserDefaults.standard.set(try? JSONEncoder().encode(choosableWorkouts), forKey: userDefaultsKey)
    }
    
    ///delete persistent data
    private func deleteUserDefaults() {
        let prefs = UserDefaults.standard
        //let keyValue = prefs.string(forKey: "ExerciseSetStore")
        prefs.removeObject(forKey: "ExerciseSetStore")
    }
    
    /// load persistent data
    private func restoreFromUserDefaults() {
        if let jsonData = UserDefaults.standard.data(forKey: userDefaultsKey),
           let decodedM_ChoosableExerciseSets = try? JSONDecoder().decode(M_ChoosableExerciseSets.self, from: jsonData) {
            choosableWorkouts = decodedM_ChoosableExerciseSets
        }
    }
    
}

