Class {
	#name : #CardGeneratorTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #running }
CardGeneratorTest >> test01WhenACardGeneratorCreatesCardsThenADeckOfCardsCreated [

	| aCardGenerator aDeckOfCards |
	aCardGenerator := (CardGenerator setWithCards: 100).
	aDeckOfCards:= DeckOfCards with: aCardGenerator cards.
	self assert: aDeckOfCards cards size equals: 100. 
]
