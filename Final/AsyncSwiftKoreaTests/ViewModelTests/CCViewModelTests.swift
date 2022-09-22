//
//  CCViewModelTests.swift
//  AsyncSwiftKoreaTests
//
//  Created by daco daco on 2022/09/20.
//

import XCTest
import SwiftUI
@testable import AsyncSwiftKorea

class CCViewModelTests: XCTestCase {
    
    var ccViewModel: ChamChamViewModel?
    
    override func setUpWithError() throws {
        let moon = MockMoon()
        ccViewModel = ChamChamViewModel(moon: moon)
    }
    
    func test_moon_얼굴방향과_손가락방향이일치할때_true가_반환되는가() {
        // Given
        ccViewModel?.moon.playChamChamCham()
        ccViewModel?.fingerDirection = .right
        
        // When
        let checkedResult = ccViewModel?.checkDirectionMatched()
        
        // Then
        XCTAssertEqual(checkedResult, true)
    }
    
    func test_moon_얼굴방향과_손가락방향이불일치할때_false가_반환되는가() {
        // Given
        ccViewModel?.moon.playChamChamCham()
        ccViewModel?.fingerDirection = .left
        
        // When
        let checkedResult = ccViewModel?.checkDirectionMatched()
        
        // Then
        XCTAssertEqual(checkedResult, false)
    }
    
    func test_playGame시_방향을맞춘경우_score가_10올라가는가() {
        // Given
        let direction = Direction.right
        
        // When
        ccViewModel?.playGame(with: direction)
        let score = ccViewModel?.score
        
        // Then
        XCTAssertEqual(score, 10)
    }
    
    func test_참참참에서방향을맞췄을때_올라가는점수가10인가() {
        // Given
        let isMatched = true
        
        // When
        let givenScore = ccViewModel?.giveScore(isMatched: isMatched)
        
        // Then
        XCTAssertEqual(givenScore, 10)
    }
    
    func test_참참참에서방향을맞췄을때_떨어지는점수가5인가() {
        // Given
        let isMatched = false
        
        // When
        let givenScore = ccViewModel?.giveScore(isMatched: isMatched)
        
        // Then
        XCTAssertEqual(givenScore, -5)
    }
    
    func test_fingerDirection이_right일때_Angle이_30이되는가() {
        // Given
        ccViewModel?.fingerDirection = .right
        
        // When
        let angle = ccViewModel?.fingerRotationAngle
        
        // Then
        XCTAssertEqual(angle,Angle(degrees: 30))
    }
    
    func test_fingerDirection이_front일때_Angle이_0이되는가() {
        // Given
        ccViewModel?.fingerDirection = .front
        
        // When
        let angle = ccViewModel?.fingerRotationAngle
        
        // Then
        XCTAssertEqual(angle,Angle(degrees: 0))
    }
    
    func test_fingerDirection이_left일때_Angle이_마이너스30이되는가() {
        // Given
        ccViewModel?.fingerDirection = .left
        
        // When
        let angle = ccViewModel?.fingerRotationAngle
        
        // Then
        XCTAssertEqual(angle,Angle(degrees: -30))
    }
}
