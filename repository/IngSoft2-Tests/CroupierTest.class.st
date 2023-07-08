Class {
	#name : #CroupierTest,
	#superclass : #TestCase,
	#instVars : [
		'cellEffects',
		'aDeckOfCards'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #running }
CroupierTest >> setUp [

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
	
	aDeckOfCards := OrderedCollection new.
	aDeckOfCards add: SpeedCard new.
	aDeckOfCards add: OverloadCard new.
	aDeckOfCards add: AccelerationCard new.
	aDeckOfCards add: CancellationCard new.
]

{ #category : #asserting }
CroupierTest >> should: anErrorBlock raise: anExceptionClass withMessage: anErrorMessage [

	self
		should: anErrorBlock
		raise: anExceptionClass
		withExceptionDo: [ :error | 
			self assert: error messageText equals: anErrorMessage ].
]

{ #category : #asserting }
CroupierTest >> test01ACroupier [

	| aCroupier spaceships aBoard aLoadedDie aBoardGame aSpeedCard|
	
	aCroupier := Croupier handling: aDeckOfCards. 
	
	aSpeedCard := SpeedCard new.
	
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.

	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).

	aLoadedDie := LoadedDie of: #( 1 2 3 ).

	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling: (OrderedCollection with: aLoadedDie)
		              on: aBoard
		              with: 2 managedBy: aCroupier.
	aBoardGame throw: aSpeedCard from: 'Vicky' to: 'Cami'.
	
	aBoardGame playTurnFor: 'Vicky'.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber equals: 2
	
	

]
