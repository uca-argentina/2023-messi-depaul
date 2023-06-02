Class {
	#name : #CardTest,
	#superclass : #TestCase,
	#instVars : [
		'cellEffects'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #running }
CardTest >> setUp [
	super setUp.
	cellEffects := OrderedCollection new.
	cellEffects add: (Cell on: 1 of: NoEffect new).
	cellEffects add: (Cell on: 2 of: NoEffect new).
	cellEffects add: (Cell on: 3 of: NoEffect new).
	cellEffects add: (Cell on: 4 of: NoEffect new).
	cellEffects add: (Cell on: 5 of: NoEffect new).
	cellEffects add: (Cell on: 6 of: NoEffect new).
	cellEffects add: (Cell on: 7 of: NoEffect new).
	cellEffects add: (Cell on: 8 of: NoEffect new).
	cellEffects add: (Cell on: 9 of: NoEffect new).
	cellEffects add: (Cell on: 10 of: NoEffect new).
]

{ #category : #tests }
CardTest >> test01 [

	| spaceships aBoard aBoardGame aSpeedCard aDeckOfCards|
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	aBoard := Board of: cellEffects withLenght: 15.
	aSpeedCard := SpeedCard new.
	aDeckOfCards:= OrderedCollection new.
	aDeckOfCards add: aSpeedCard. 
	
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 3 4 20 )))
		              on: aBoard
		              with: 3
		              utilizing: aDeckOfCards.


	aBoardGame throwSpeedCardFrom: 'Vicky' to: 'Vicky'.
	aBoardGame playTurnFor: 'Vicky'.

	self
		assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber
		equals: 5
]
