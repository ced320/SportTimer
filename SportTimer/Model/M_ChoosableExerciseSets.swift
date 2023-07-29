//
//  ChoosableExerciseSets.swift
//  SportTimer
//
//  Created by Cedric Frimmel-Hoffmann on 29.07.23.
//

import Foundation

struct M_ChoosableExerciseSets: Codable {
    private(set) var exerciseSets = [M_ExerciseSet]()
    private(set) var exerciseIDs: Set<Int>
    private(set) var lastKnownExerciseId = 0
    private(set) var pointerWorkoutSet = 0
    
    
    /// This initater is needed to ensure there is never an empty exerciseSetsArray because that would lead to fatal failure of the app
    /// - Parameter basicInit: true and false has no impact till more is implemented
    init(basicInit: Bool) {
        var exercises = [M_Exercise]()
        let p1 = M_Exercise(uniqueId: 0, name: "1Pause1", isPause: true, durationInSeconds: 4)
        let exercise1 = M_Exercise(uniqueId: 1, name: "1e1", isPause: false, durationInSeconds: 4)
        let p2 = M_Exercise(uniqueId: 2, name: "1Pause2", isPause: true, durationInSeconds: 4)
        let exercise2 = M_Exercise(uniqueId: 3, name: "1e2", isPause: false, durationInSeconds: 4)
        let p3 = M_Exercise(uniqueId: 4, name: "1Pause3", isPause: true, durationInSeconds: 4)
        let exercise3 = M_Exercise(uniqueId: 5, name: "1e3", isPause: false, durationInSeconds: 4)
        let p4 = M_Exercise(uniqueId: 6, name: "1Pause4", isPause: true, durationInSeconds: 4)
        exercises.append(p1)
        exercises.append(exercise1)
        exercises.append(p2)
        exercises.append(exercise2)
        exercises.append(p3)
        exercises.append(exercise3)
        exercises.append(p4)
        let exerciseSet = M_ExerciseSet(uniqueName: "Test1", exercises: exercises)
        exerciseSets.append(exerciseSet)
        exerciseIDs = [0,1,2,3,4,5,6]
        lastKnownExerciseId = 6
        pointerWorkoutSet = 0
        
        var exercises2 = [M_Exercise]()
        let p12 = M_Exercise(uniqueId: 7, name: "2Pause1", isPause: true, durationInSeconds: 4)
        let exercise12 = M_Exercise(uniqueId: 8, name: "2e1", isPause: false, durationInSeconds: 4)
        let p22 = M_Exercise(uniqueId: 9, name: "2Pause2", isPause: true, durationInSeconds: 4)
        let exercise22 = M_Exercise(uniqueId: 10, name: "2e2", isPause: false, durationInSeconds: 4)
        let p32 = M_Exercise(uniqueId: 11, name: "2Pause3", isPause: true, durationInSeconds: 4)
        let exercise32 = M_Exercise(uniqueId: 12, name: "2e3", isPause: false, durationInSeconds: 4)
        let p42 = M_Exercise(uniqueId: 13, name: "2Pause4", isPause: true, durationInSeconds: 4)
        exercises2.append(p12)
        exercises2.append(exercise12)
        exercises2.append(p22)
        exercises2.append(exercise22)
        exercises2.append(p32)
        exercises2.append(exercise32)
        exercises2.append(p42)
        let exerciseSet2 = M_ExerciseSet(uniqueName: "Test2", exercises: exercises2)
        exerciseSets.append(exerciseSet2)
        exerciseIDs = [0,1,2,3,4,5,6,7,8,9,10,11,12,13]
        lastKnownExerciseId = 13
        pointerWorkoutSet = 0
    }
    
    
    /// Creates a new exerciseSet that contains unique exercises and a unique name
    /// However the input name and the input exercises do not have to be unique
    /// They will be transformed to unique ids
    /// - Parameters:
    ///   - possibleNotUniqueName: nameOfExerciseSet
    ///   - exercisesWithPossibleNoUniqueIds: exercises that shall be part of the exerciseSet
    mutating func createNewExerciseSet(name possibleNotUniqueName: String, exercises exercisesWithPossibleNoUniqueIds: [M_Exercise]) {
        let name = transformToUniqueName(name: possibleNotUniqueName)
        let exercises = transformToUniqueExerciseList(exercises: exercisesWithPossibleNoUniqueIds)
        let exerciseSet = M_ExerciseSet(uniqueName: name, exercises: exercises)
        exerciseSets.append(exerciseSet)
    }
    
    
    /// Deletes the Exercise with the given id if the id exists in the set
    /// - Parameter id: id of set to delete
    mutating func deleteExerciseSet(uniqueName id: String) {
        if(id != "Test1" && exerciseSets.map{$0.name}.contains(id)) { //BUG?
            exerciseSets.removeAll { $0.id == id}
            while(pointerWorkoutSet >= exerciseSets.count) { //Make sure that if the currently selected workout was deleted the pointer still points into the range
                pointerWorkoutSet -= 1 //TODO
            }
        }
    }
    
    
    /// sets the pointerToWorkoutSet to the given exerciseSet if it exists
    /// otherwise the pointer does not change
    /// - Parameter searchedName: name of searched exerciseSet
    mutating func chooseExerciseSet(nameOfExerciseSet searchedName: String) {
        var result = 0
        for exerciseSet in exerciseSets {
            if searchedName == exerciseSet.name {
                pointerWorkoutSet = result
                break
            }
            result += 1
        }
    }
    
    
    /// returns ExerciseSet to which pointerToWorkoutSet points
    /// - Returns: ExerciseSet to which pointerToWorkoutSet points
    func getSelectedExerciseSet() -> M_ExerciseSet {
        return exerciseSets[pointerWorkoutSet]
    }
    
    /// unique name
    /// - Parameter givenName: givenName description
    /// - Returns: description
    private func checkUniqueSetName(name givenName: String) -> Bool {
        return exerciseSets.map{$0.name}.contains(givenName)
    }
    
    /// make name unique that does not already exists in form a -> a(0) or a(1) etc.
    /// - Parameter givenName: givenName description
    /// - Returns: uniqueName
    private func transformToUniqueName(name givenName: String) -> String {
        var uniqueName = givenName
        var i = 0
        while checkUniqueSetName(name: uniqueName) {
            uniqueName = givenName + "(\(i))"
            i += 1
        }
        return uniqueName
    }
    
    /// unique exerciseList
    /// - Parameter givenExercises: givenExercises description
    /// - Returns: unique exerciseList
    private mutating func transformToUniqueExerciseList(exercises givenExercises: [M_Exercise]) -> [M_Exercise] {
        var uniqueExercises = [M_Exercise]()
        for exercise in givenExercises {
            uniqueExercises.append(M_Exercise(uniqueId: makeNewUniqueExerciseId(), name: exercise.name, isPause: exercise.isPause, durationInSeconds: exercise.durationInSeconds))
        }
        return uniqueExercises
    }
    
    //func getNamesOfExistingExerciseSets() -> Set<String> {
    //    return Set(exerciseSets.map{$0.name})
    //}
    
    /// Creates a new id that does not already exists in this instance of M_ChoosableExerciseSets
    /// and adds it to existingIds
    /// - Returns: unique id
    private mutating func makeNewUniqueExerciseId() -> Int {
        var i = lastKnownExerciseId
        while(exerciseIDs.contains(i)) {
            i = i + 1
        }
        exerciseIDs.insert(i)
        return i
    }
    
}
