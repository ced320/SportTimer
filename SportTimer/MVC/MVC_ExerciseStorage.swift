//
//  MVC_ExerciseStorage.swift
//  SportTimer
//
//  Created by Cedric Frimmel-Hoffmann on 25.07.23.
//


import SwiftUI
import AVFAudio

class MVC_ExerciseStorage: ObservableObject {
    
    @Published private(set) var exerciseSets = [M_ExerciseSet]() {
        didSet {
            storeInUserDefaults()
        }
    }
    @Published var exerciseSetBuilder = M_ExerciseSetBuilder()
    @Published private(set) var exerciseIDs = [Int]()
    @Published private(set) var exerciseSetIDs = [Int]()
    @Published private(set) var currentExerciseSetPosition = 0
    let name: String
    //private var lastUsedExerciseSet = 0
    private var userDefaultsKey: String {"ExerciseSetStore"}
    
    init(named name: String) {
        self.name = name
        self.currentExerciseSetPosition = 0
        deleteUserDefaults()
        //restoreFromUserDefaults()
        if exerciseSets.isEmpty {
            exerciseSets.append(createDefaultExerciseSet())
            exerciseSets.append(createDefaultExerciseSet2())
        } else {
            if exerciseSets.first != nil && exerciseSets.first!.exercises.first != nil {
            } else {
                let defaultExerciseSet = createDefaultExerciseSet()
                exerciseSets[0] = defaultExerciseSet
            }
        }
    }
    
    func resetTemporaryCreatedExercises() {
        exerciseSetBuilder = M_ExerciseSetBuilder()
    }
    
    func addInputToExerciseSet(name: String, duration: Double, pauseDuration: Double) {
        
        if name != "" && duration > 0 && pauseDuration > 0 {
            let exercise = stringExerciseToExerciseStruct(name: name, duration: duration)
            let pause = stringPauseToExerciseStruct(duration: pauseDuration)
            
            exerciseSetBuilder.temporaryCreatedExercises.append(exercise)
            exerciseSetBuilder.temporaryCreatedExercises.append(pause)
        }
    }
    
    func createNewExercise(name: String, isPause: Bool, durationInSeconds: Double) -> M_Exercise {
        let exercise = M_Exercise(existingIDs: exerciseIDs, name: name, isPause: isPause, durationInSeconds: durationInSeconds)
        exerciseIDs.append(exercise.id)
        return exercise
    }
    
    func createExerciseSet(nameOfExerciseSet: String) {
        if(nameOfExerciseSet == "") {
            return
        }
        //1.) Create an Exercise Set with an unique id
        exerciseSetBuilder.setNameOfExerciseSet(nameOfExerciseSetToBuild: nameOfExerciseSet)
        if let exerciseSet = exerciseSetBuilder.createExerciseSetWithGivenInput(exerciseSets: exerciseSets) {
            //2.) Add that ExerciseSet to the existing ExerciseSets if it can be created
            exerciseSets.append(exerciseSet)
        }
    }
    
    func deleteExerciseSet(uniqueIdOfExerciseSet id: Int) {
        if(id != 0 && id != 1) {
            if(id == exerciseSets[currentExerciseSetPosition].id) {
                currentExerciseSetPosition = 0
            }
            exerciseSets.removeAll { $0.id == id}
        }
    }
    
    func getSelectedExerciseSet() -> M_ExerciseSet {
        if currentExerciseSetPosition < exerciseSets.count {
            return exerciseSets[currentExerciseSetPosition]
        }
        return exerciseSets[0]
    }
    
    func chooseExerciseSet(exerciseSet: M_ExerciseSet) {
        if let position = exerciseSets.firstIndex(of: exerciseSet) {
            currentExerciseSetPosition = position
        } else {
            currentExerciseSetPosition = 0
        }
    }
    
    
    private func storeInUserDefaults() {
        UserDefaults.standard.set(try? JSONEncoder().encode(exerciseSets), forKey: userDefaultsKey)
    }
    
    private func deleteUserDefaults() {
        let prefs = UserDefaults.standard
        //let keyValue = prefs.string(forKey: "ExerciseSetStore")
        prefs.removeObject(forKey: "ExerciseSetStore")
    }
    
    private func restoreFromUserDefaults() {
        if let jsonData = UserDefaults.standard.data(forKey: userDefaultsKey),
           let decodedExercisesSets = try? JSONDecoder().decode(Array<M_ExerciseSet>.self, from: jsonData) {
            exerciseSets = decodedExercisesSets
        }
    }
    
    private func stringExerciseToExerciseStruct(name: String, duration: Double) -> M_Exercise {
        if duration < 0.1 {
            return createNewExercise(name: name, isPause: false, durationInSeconds: 0.1)
        }
        return createNewExercise(name: name, isPause: false, durationInSeconds: duration)
    }
    
    private func stringPauseToExerciseStruct(duration: Double) -> M_Exercise {
        if duration < 0.1 {
            return createNewExercise(name: "Pause", isPause: true, durationInSeconds: 0.1)
        }
        return createNewExercise(name: "Pause", isPause: true, durationInSeconds: duration)
    }
    
    /**
     

    ///TODO remove
    ///
    private func setTimerManager(toSetNumber num: Int) {
        if num < exerciseSets.count && exerciseSets[num].exercises.count != 0 && exerciseSets[num].exercises.first != nil {
            currentExerciseSetPosition = num
            timerManager!.currentExercise = exerciseSets[num].exercises.first!
            timerManager!.exerciseSet = exerciseSets[num]
            timerManager!.setHasStartedExercise(to: false) 
            timerManager!.remainingTime = exerciseSets[num].exercises.first!.durationInSeconds
            
        }
    }
    */
    
    private func createDefaultExerciseSet() -> M_ExerciseSet {

        var exercises = [M_Exercise]()
        let p1 = createNewExercise(name: "1Pause1", isPause: true, durationInSeconds: 4)
        let exc1 = createNewExercise(name: "1Squad", isPause: false, durationInSeconds: 3)
        let p2 = createNewExercise(name: "1Pause2", isPause: true, durationInSeconds: 3)
        let exc2 = createNewExercise(name: "1Hands to Ground", isPause: false, durationInSeconds: 3)
        let p3 = createNewExercise(name: "1Pause3", isPause: true, durationInSeconds: 5)
        let exc3 = createNewExercise(name: "Sitting", isPause: false, durationInSeconds: 3)

        
        exercises.append(p1)
        exercises.append(exc1)
        exercises.append(p2)
        exercises.append(exc2)
        exercises.append(p3)
        exercises.append(exc3)
        exercises.append(p3)

        
        return M_ExerciseSet(exerciseSets: exerciseSets, name: "test1", exercises: exercises)
    }
    
    private func createDefaultExerciseSet2() -> M_ExerciseSet {
        
        var exercises = [M_Exercise]()
        let p1 = createNewExercise(name: "2Pause", isPause: true, durationInSeconds: 5)
        let exc1 = createNewExercise(name: "2Squad", isPause: false, durationInSeconds: 30)
        let p2 = createNewExercise(name: "2Pause", isPause: true, durationInSeconds: 15)
        let exc2 = createNewExercise(name: "2Hands to Ground", isPause: false, durationInSeconds: 30)
        let p3 = createNewExercise(name: "1Pause", isPause: true, durationInSeconds: 15)
        let exc3 = createNewExercise(name: "Sitting", isPause: false, durationInSeconds: 35)
        let p4 = createNewExercise(name: "1Pause", isPause: true, durationInSeconds: 15)
        let exc4 = createNewExercise(name: "Right Knee to wall", isPause: false, durationInSeconds: 30)
        let p5 = createNewExercise(name: "1Pause", isPause: true, durationInSeconds: 10)
        let exc5 = createNewExercise(name: "Left Knee to wall", isPause: false, durationInSeconds: 30)
        let p6 = createNewExercise(name: "1Pause", isPause: true, durationInSeconds: 10)
        let exc6 = createNewExercise(name: "Hands to table", isPause: false, durationInSeconds: 30)
        let p7 = createNewExercise(name: "1Pause", isPause: true, durationInSeconds: 10)
        let exc7 = createNewExercise(name: "table", isPause: false, durationInSeconds: 45)
        let p8 = createNewExercise(name: "1Pause", isPause: true, durationInSeconds: 10)
        let exc8 = createNewExercise(name: "Squad", isPause: false, durationInSeconds: 30)
        
        exercises.append(p1)
        exercises.append(exc1)
        exercises.append(p2)
        exercises.append(exc2)
        exercises.append(p3)
        exercises.append(exc3)
        exercises.append(p4)
        exercises.append(exc4)
        exercises.append(p5)
        exercises.append(exc5)
        exercises.append(p6)
        exercises.append(exc6)
        exercises.append(p7)
        exercises.append(exc7)
        exercises.append(p8)
        exercises.append(exc8)
        
        return M_ExerciseSet(exerciseSets: exerciseSets, name: "test2", exercises: exercises)
    }

    
    
    
    
    
}

