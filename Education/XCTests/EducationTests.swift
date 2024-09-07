//
//  EducationTests.swift
//  EducationTests
//
//  Created by Ignacio Juarez on 9/5/24.
//

import XCTest
@testable import Education

final class TestingTests: XCTestCase {

    // Test where a solution exists
    func testTwoSumWithValidInput() {
        let testing = Testing()
        let result = testing.twoSum(numbers: [2, 7, 11, 15], target: 9)
        XCTAssertEqual(result.sorted(), [0, 1], "The twoSum function failed to find the correct indices for the target sum.")
    }

    // Test with no valid solution
    func testTwoSumWithNoSolution() {
        let testing = Testing()
        let result = testing.twoSum(numbers: [1, 2, 3, 4], target: 10)
        XCTAssertTrue(result.isEmpty, "The twoSum function should return an empty array when no pairs sum to the target.")
    }

    // Test with negative numbers
    func testTwoSumWithNegativeNumbers() {
        let testing = Testing()
        let result = testing.twoSum(numbers: [-3, 4, 3, 90], target: 0)
        XCTAssertEqual(result, [2, 0], "The twoSum function failed to find the correct indices with negative numbers.")
    }

    // Test with multiple possible pairs
    func testTwoSumWithMultiplePossiblePairs() {
        let testing = Testing()
        let result = testing.twoSum(numbers: [3, 2, 4, 3], target: 6)
        XCTAssertEqual(result, [2, 1], "The twoSum function failed to return the first correct pair of indices.")
    }
}
