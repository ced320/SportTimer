//
//  MVC_ExerciseChooser.swift
//  SportTimer
//
//  Created by Cedric Frimmel-Hoffmann on 10.04.23.
//

import SwiftUI

class ExerciseChooser: ObservableObject {
    
    @Published private(set) var exerciseSets = [ExerciseSet]() {
        didSet {
            storeInUserDefaults()
        }
    }
    @Published private(set) var currentExerciseSetPosition = 0
    
    let name: String
    
    private var userDefaultsKey: String {"ExerciseSetStore"}
    
    init(named name: String) {
        self.name = name
        //restoreFromUserDefaults()
        if exerciseSets.isEmpty {
            exerciseSets.append(createDefaultExerciseSet())
            exerciseSets.append(createDefaultExerciseSet2())
        }
    }
    
    func createExerciseSet(nameOfExerciseSet: String, exercises: [Exercise]) {
        //1.) Create an Exercise Set with an unique id
        let exerciseSet = ExerciseSet(id: generateUniqueID(), name: nameOfExerciseSet, exercises: exercises)
        //2.) Add that ExerciseSet to the existing ExerciseSets
        exerciseSets.append(exerciseSet)
    }
    
    
    func getSelectedExerciseSet() -> ExerciseSet {
        if currentExerciseSetPosition < exerciseSets.count {
            return exerciseSets[currentExerciseSetPosition]
        }
        return exerciseSets[0]
    }
    
    func chooseExerciseSet(exerciseSet: ExerciseSet) {
        if let position = exerciseSets.firstIndex(of: exerciseSet) {
            currentExerciseSetPosition = position
        } else {
            currentExerciseSetPosition = 0
        }
    }
    
    
    private func storeInUserDefaults() {
        UserDefaults.standard.set(try? JSONEncoder().encode(exerciseSets), forKey: userDefaultsKey)
    }
    
    private func restoreFromUserDefaults() {
        if let jsonData = UserDefaults.standard.data(forKey: userDefaultsKey),
           let decodedExercisesSets = try? JSONDecoder().decode(Array<ExerciseSet>.self, from: jsonData) {
            exerciseSets = decodedExercisesSets
        }
    }
    
    private func generateUniqueID() -> Int {
        //1.) Get all existing IDs
        let existingIDs = getExistingIDs()
        //2.) Find an ID that does not exist yet
        var candidate = 0
        var candidateExists = true
        while(candidateExists && candidate < 2_147_483_600) {
            candidateExists = false
            if(existingIDs.contains(candidate)) {
                candidate += 1
                candidateExists = true
            }
        }
        //3.) If there are no IDs left crash program
        if(candidateExists) {
            fatalError("There are no IDs left")
        }
        //4.) Give back that unique ID
        return candidate

    }
    
    private func getExistingIDs() -> Set<Int> {
        var result: Set<Int> = Set()
        for exerciseSet in exerciseSets {
            result.insert(exerciseSet.id)
        }
        return result
    }
    
    private func createDefaultExerciseSet() -> ExerciseSet {
        
        let pause5Sec = Exercise(name: "1Pause",isPause: true, durationInSeconds: 5)
        let pause10Sec = Exercise(name: "1Pause",isPause: true, durationInSeconds: 10)
        let pause15Sec = Exercise(name: "1Pause",isPause: true, durationInSeconds: 15)
        
        var exercises = [Exercise]()
        exercises.append(pause5Sec)
        exercises.append(Exercise(name: "1SQUAD",isPause: false, durationInSeconds: 30))
        exercises.append(pause15Sec)
        exercises.append(Exercise(name: "1HANDS TO GROUND",isPause: false, durationInSeconds: 30))
        exercises.append(pause15Sec)
        exercises.append(Exercise(name: "1SITTING",isPause: false, durationInSeconds: 35))
        exercises.append(pause15Sec)
        exercises.append(Exercise(name: "1RIGHT KNEE TO WALL",isPause: false, durationInSeconds: 30))
        exercises.append(pause10Sec)
        exercises.append(Exercise(name: "1LEFT KNEE TO WALL",isPause: false, durationInSeconds: 30))
        exercises.append(pause10Sec)
        exercises.append(Exercise(name: "1HANDS TO TABLE",isPause: false, durationInSeconds: 30))
        exercises.append(pause10Sec)
        exercises.append(Exercise(name: "1TABLE",isPause: false, durationInSeconds: 45))
        exercises.append(pause10Sec)
        exercises.append(Exercise(name: "1SQUAD",isPause: false, durationInSeconds: 30))
        
        return ExerciseSet(id: generateUniqueID(), name: "test1", exercises: exercises)
    }
    
    private func createDefaultExerciseSet2() -> ExerciseSet {
        
        let pause5Sec = Exercise(name: "2Pause",isPause: true, durationInSeconds: 5)
        let pause10Sec = Exercise(name: "2Pause",isPause: true, durationInSeconds: 10)
        let pause15Sec = Exercise(name: "2Pause",isPause: true, durationInSeconds: 15)
        
        var exercises = [Exercise]()
        exercises.append(pause5Sec)
        exercises.append(Exercise(name: "2SQUAD",isPause: false, durationInSeconds: 30))
        exercises.append(pause15Sec)
        exercises.append(Exercise(name: "2HANDS TO GROUND",isPause: false, durationInSeconds: 30))
        exercises.append(pause15Sec)
        exercises.append(Exercise(name: "2SITTING",isPause: false, durationInSeconds: 35))
        exercises.append(pause15Sec)
        exercises.append(Exercise(name: "2RIGHT KNEE TO WALL",isPause: false, durationInSeconds: 30))
        exercises.append(pause10Sec)
        exercises.append(Exercise(name: "2LEFT KNEE TO WALL",isPause: false, durationInSeconds: 30))
        exercises.append(pause10Sec)
        exercises.append(Exercise(name: "2HANDS TO TABLE",isPause: false, durationInSeconds: 30))
        exercises.append(pause10Sec)
        exercises.append(Exercise(name: "2TABLE",isPause: false, durationInSeconds: 45))
        exercises.append(pause10Sec)
        exercises.append(Exercise(name: "2SQUAD",isPause: false, durationInSeconds: 30))
        
        return ExerciseSet(id: generateUniqueID(), name: "test2", exercises: exercises)
    }
    
    private func createDefaultExerciseSet3() -> ExerciseSet {
        
        let pause5Sec = Exercise(name: "3Pause",isPause: true, durationInSeconds: 5)
        let pause10Sec = Exercise(name: "3Pause",isPause: true, durationInSeconds: 10)
        let pause15Sec = Exercise(name: "3Pause",isPause: true, durationInSeconds: 15)
        
        var exercises = [Exercise]()
        exercises.append(pause5Sec)
        exercises.append(Exercise(name: "3SQUAD",isPause: false, durationInSeconds: 30))
        exercises.append(pause15Sec)
        exercises.append(Exercise(name: "3HANDS TO GROUND",isPause: false, durationInSeconds: 30))
        exercises.append(pause15Sec)
        exercises.append(Exercise(name: "2SITTING",isPause: false, durationInSeconds: 35))
        exercises.append(pause15Sec)
        exercises.append(Exercise(name: "2RIGHT KNEE TO WALL",isPause: false, durationInSeconds: 30))
        exercises.append(pause10Sec)
        exercises.append(Exercise(name: "2LEFT KNEE TO WALL",isPause: false, durationInSeconds: 30))
        exercises.append(pause10Sec)
        exercises.append(Exercise(name: "2HANDS TO TABLE",isPause: false, durationInSeconds: 30))
        exercises.append(pause10Sec)
        exercises.append(Exercise(name: "2TABLE",isPause: false, durationInSeconds: 45))
        exercises.append(pause10Sec)
        exercises.append(Exercise(name: "2SQUAD",isPause: false, durationInSeconds: 30))
        
        return ExerciseSet(id: generateUniqueID(), name: "test2", exercises: exercises)
    }
    
    private func createDefaultExerciseSet4() -> ExerciseSet {
        
        let pause5Sec = Exercise(name: "4Pause",isPause: true, durationInSeconds: 5)
        let pause10Sec = Exercise(name: "4Pause",isPause: true, durationInSeconds: 10)
        let pause15Sec = Exercise(name: "4Pause",isPause: true, durationInSeconds: 15)
        
        var exercises = [Exercise]()
        exercises.append(pause5Sec)
        exercises.append(Exercise(name: "4SQUAD",isPause: false, durationInSeconds: 30))
        exercises.append(pause15Sec)
        exercises.append(Exercise(name: "4HANDS TO GROUND",isPause: false, durationInSeconds: 30))
        exercises.append(pause15Sec)
        exercises.append(Exercise(name: "4SITTING",isPause: false, durationInSeconds: 35))
        exercises.append(pause15Sec)
        exercises.append(Exercise(name: "4RIGHT KNEE TO WALL",isPause: false, durationInSeconds: 30))
        exercises.append(pause10Sec)
        exercises.append(Exercise(name: "2LEFT KNEE TO WALL",isPause: false, durationInSeconds: 30))
        exercises.append(pause10Sec)
        exercises.append(Exercise(name: "2HANDS TO TABLE",isPause: false, durationInSeconds: 30))
        exercises.append(pause10Sec)
        exercises.append(Exercise(name: "2TABLE",isPause: false, durationInSeconds: 45))
        exercises.append(pause10Sec)
        exercises.append(Exercise(name: "2SQUAD",isPause: false, durationInSeconds: 30))
        
        return ExerciseSet(id: generateUniqueID(), name: "test2", exercises: exercises)
    }
    
    private func createDefaultExerciseSet5() -> ExerciseSet {
        
        let pause5Sec = Exercise(name: "5Pause",isPause: true, durationInSeconds: 5)
        let pause10Sec = Exercise(name: "5Pause",isPause: true, durationInSeconds: 10)
        let pause15Sec = Exercise(name: "5Pause",isPause: true, durationInSeconds: 15)
        
        var exercises = [Exercise]()
        exercises.append(pause5Sec)
        exercises.append(Exercise(name: "5SQUAD",isPause: false, durationInSeconds: 30))
        exercises.append(pause15Sec)
        exercises.append(Exercise(name: "5HANDS TO GROUND",isPause: false, durationInSeconds: 30))
        exercises.append(pause15Sec)
        exercises.append(Exercise(name: "2SITTING",isPause: false, durationInSeconds: 35))
        exercises.append(pause15Sec)
        exercises.append(Exercise(name: "2RIGHT KNEE TO WALL",isPause: false, durationInSeconds: 30))
        exercises.append(pause10Sec)
        exercises.append(Exercise(name: "2LEFT KNEE TO WALL",isPause: false, durationInSeconds: 30))
        exercises.append(pause10Sec)
        exercises.append(Exercise(name: "2HANDS TO TABLE",isPause: false, durationInSeconds: 30))
        exercises.append(pause10Sec)
        exercises.append(Exercise(name: "2TABLE",isPause: false, durationInSeconds: 45))
        exercises.append(pause10Sec)
        exercises.append(Exercise(name: "2SQUAD",isPause: false, durationInSeconds: 30))
        
        return ExerciseSet(id: generateUniqueID(), name: "test2", exercises: exercises)
    }
    
    
    
    
    
}
