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
	cellEffects add: (Cell on: 5 of: CardEffect new).
	cellEffects add: (Cell on: 6 of: NoEffect new).
	cellEffects add: (Cell on: 7 of: NoEffect new).
	cellEffects add: (Cell on: 8 of: NoEffect new).
	cellEffects add: (Cell on: 9 of: NoEffect new).
	cellEffects add: (Cell on: 10 of: NoEffect new).
]

{ #category : #tests }
CardTest >> should: anErrorBlock raise: anExceptionClass withMessage: anErrorMessage [

	self
		should: anErrorBlock
		raise: anExceptionClass
		withExceptionDo: [ :error | 
			self assert: error messageText equals: anErrorMessage ].
			
			
		
]

{ #category : #tests }
CardTest >> test01WhenASpaceshipPlaysASpeedCardThenStaysOnTheGame [

	| spaceships aBoard aBoardGame aSpeedCard aDeckOfCards |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := Board of: cellEffects withLenght: (Parsec withValue: 15).
	aSpeedCard := SpeedCard new.
	aDeckOfCards := OrderedCollection new.
	aDeckOfCards add: aSpeedCard.

	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
		              on: aBoard
		              with: 3
		              utilizing: aDeckOfCards.


	aBoardGame throwSpeedCardFrom: 'Vicky' to: 'Cami'.
	aBoardGame playTurnFor: 'Vicky'.
	aBoardGame playTurnFor: 'Cami'.

	self
		assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber
		equals: 4.

	aBoardGame playTurnFor: 'Vicky'.
	aBoardGame playTurnFor: 'Cami'.

	self
		assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber
		equals: 6
]

{ #category : #tests }
CardTest >> test02WhenTwoSpeedCardsAffectASpaceshipThenSpaceshipMovesAffected [

	| spaceships aBoard aBoardGame aSpeedCard aDeckOfCards |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := Board of: cellEffects withLenght: (Parsec withValue: 15).

	aSpeedCard := SpeedCard new.
	aDeckOfCards := OrderedCollection new.
	aDeckOfCards add: aSpeedCard.

	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
		              on: aBoard
		              with: 3
		              utilizing: aDeckOfCards.


	aBoardGame throwSpeedCardFrom: 'Vicky' to: 'Cami'.
	aBoardGame throwSpeedCardFrom: 'Vicky' to: 'Cami'.
	aBoardGame playTurnFor: 'Vicky'.
	aBoardGame playTurnFor: 'Cami'.

	self
		assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber
		equals: 5.

	aBoardGame playTurnFor: 'Vicky'.
	aBoardGame playTurnFor: 'Cami'.

	self
		assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber
		equals: 8
]

{ #category : #tests }
CardTest >> test03WhenSpaceshipTriesToThrowSpeedCardThenCannotThrowIt [

	| spaceships aBoard aBoardGame aSpeedCard aDeckOfCards |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := Board of: cellEffects withLenght: (Parsec withValue: 15).

	aSpeedCard := SpeedCard new.
	aDeckOfCards := OrderedCollection new.
	aDeckOfCards add: aSpeedCard.

	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
		              on: aBoard
		              with: 3
		              utilizing: aDeckOfCards.


	aBoardGame throwSpeedCardFrom: 'Vicky' to: 'Cami'.
	aBoardGame throwSpeedCardFrom: 'Vicky' to: 'Cami'.

	self
		should: [ aBoardGame throwSpeedCardFrom: 'Vicky' to: 'Cami' ]
		raise: Error
		withMessage: 'You do not have that card'
]

{ #category : #tests }
CardTest >> test04WhenASpaceshipPlaysOverloadCardThenAffectedSpaceshipIsMovesTwoLessThanTotalDiceThrown [

	| spaceships aBoard aBoardGame aOverloadCard aDeckOfCards |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := Board of: cellEffects withLenght: (Parsec withValue: 15).

	aOverloadCard := OverloadCard new.
	aDeckOfCards := OrderedCollection new.
	aDeckOfCards add: aOverloadCard.

	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 5 3 )))
		              on: aBoard
		              with: 3
		              utilizing: aDeckOfCards.


	aBoardGame throwOverloadCardFrom: 'Vicky' to: 'Cami'.
	aBoardGame playTurnFor: 'Vicky'.
	aBoardGame playTurnFor: 'Cami'.

	self
		assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber
		equals: 4
]

{ #category : #tests }
CardTest >> test05WhenSpaceshipPlaysAccelerationCardThenAllSpaceshipIncrementsOneMove [

	| spaceships aBoard aBoardGame aAcelerationCard aDeckOfCards |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := Board of: cellEffects withLenght: (Parsec withValue: 15).

	aAcelerationCard := AccelerationCard new.
	aDeckOfCards := OrderedCollection new.
	aDeckOfCards add: aAcelerationCard.

	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
		              on: aBoard
		              with: 3
		              utilizing: aDeckOfCards.


	aBoardGame throwAccelerationCardFrom: 'Vicky'.
	aBoardGame playTurnFor: 'Vicky'.
	aBoardGame playTurnFor: 'Cami'.

	self
		assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber
		equals: 3.
	self
		assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber
		equals: 4
]

{ #category : #tests }
CardTest >> test06WhenSpaceshipTriesToPlayPermanentCardAndItsNotHisTurnThenCannotThrowIt [

	| spaceships aBoard aBoardGame aDeckOfCards |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := Board of: cellEffects withLenght: (Parsec withValue: 15).

	aDeckOfCards := OrderedCollection new.
	aDeckOfCards add: SpeedCard new.
	aDeckOfCards add: OverloadCard new.
	aDeckOfCards add: AccelerationCard new.

	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
		              on: aBoard
		              with: 3
		              utilizing: aDeckOfCards.

	self
		should: [ aBoardGame throwSpeedCardFrom: 'Cami' to: 'Vicky' ]
		raise: Error
		withMessage: 'Its not your turn'
]

{ #category : #tests }
CardTest >> test07WhenSpaceshipPlaysDifferentPermanentCardsThenSpaceshipsMovesAreAffected [

	| spaceships aBoard aBoardGame aDeckOfCards |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := Board of: cellEffects withLenght: (Parsec withValue: 15).

	aDeckOfCards := OrderedCollection new.
	aDeckOfCards add: SpeedCard new.
	aDeckOfCards add: OverloadCard new.
	aDeckOfCards add: AccelerationCard new.

	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
		              on: aBoard
		              with: 3
		              utilizing: aDeckOfCards.

	aBoardGame throwOverloadCardFrom: 'Vicky' to: 'Cami'.
	aBoardGame throwSpeedCardFrom: 'Vicky' to: 'Vicky'.
	aBoardGame playTurnFor: 'Vicky'.
	aBoardGame throwAccelerationCardFrom: 'Cami'.
	aBoardGame playTurnFor: 'Cami'.

	self
		assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber
		equals: 3.
	self
		assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber
		equals: 2.
		
	aBoardGame playTurnFor: 'Vicky'.
	self
		assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber
		equals: 8.
	
]

{ #category : #tests }
CardTest >> test08WhenSpaceshipTriesToPlayPermanentCardAndItsNotHisTurnThenCannotThrowIt [

	| spaceships aBoard aBoardGame aDeckOfCards |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := Board of: cellEffects withLenght: (Parsec withValue: 15).

	aDeckOfCards := OrderedCollection new.
	aDeckOfCards add: SpeedCard new.
	aDeckOfCards add: OverloadCard new.
	aDeckOfCards add: AccelerationCard new.

	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
		              on: aBoard
		              with: 3
		              utilizing: aDeckOfCards.

	self
		should: [ aBoardGame throwSpeedCardFrom: 'Vicky' to: 'Micaela' ]
		raise: Error
		withMessage: 'That spaceship doesn´t exists'
]

{ #category : #tests }
CardTest >> test09WhenASpaceshipPlaysACancellationCardThenAffectedSpaceshipMovesWithoutCardEffect [

	| spaceships aBoard aBoardGame aDeckOfCards aSpaceshipCard |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := Board of: cellEffects withLenght: (Parsec withValue: 15).

	aDeckOfCards := OrderedCollection new.
	aDeckOfCards add: SpeedCard new.
	aDeckOfCards add: OverloadCard new.
	aDeckOfCards add: AccelerationCard new.
	aDeckOfCards add: CancellationCard new.
	
	aSpaceshipCard := SpaceshipCard named: (OrderedCollection with: 'Vicky') with: SpeedCard new. 

	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
		              on: aBoard
		              with: 3
		              utilizing: aDeckOfCards.
		
	aBoardGame throwOverloadCardFrom: 'Vicky' to: 'Cami'.
	aBoardGame throwSpeedCardFrom: 'Vicky' to: 'Vicky'.
	aBoardGame playTurnFor: 'Vicky'.
	aBoardGame throwAccelerationCardFrom: 'Cami'.
	aBoardGame playTurnFor: 'Cami'.
	aBoardGame throwCancellationCardFrom: 'Cami' to: aSpaceshipCard. 
	aBoardGame playTurnFor: 'Vicky'.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber equals: 7.

]

{ #category : #tests }
CardTest >> test10WhenASpaceshipCancelsAccelerationCardThenAllSpaceshipsAreAffected [

	| spaceships aBoard aBoardGame aDeckOfCards aSpaceshipCard |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := Board of: cellEffects withLenght: (Parsec withValue: 15).

	aDeckOfCards := OrderedCollection new.
	aDeckOfCards add: SpeedCard new.
	aDeckOfCards add: OverloadCard new.
	aDeckOfCards add: AccelerationCard new.
	aDeckOfCards add: CancellationCard new.
	aDeckOfCards add: CancellationCard new.
	
	aSpaceshipCard := SpaceshipCard named: spaceships with: AccelerationCard new. "Esto dsps de ultima lo cambiamos en la forma del msjs y que se pase la nave y la tarjeta pero same shit"

	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
		              on: aBoard
		              with: 3
		              utilizing: aDeckOfCards.
		
	aBoardGame throwOverloadCardFrom: 'Vicky' to: 'Cami'.
	aBoardGame throwSpeedCardFrom: 'Vicky' to: 'Vicky'.
	aBoardGame playTurnFor: 'Vicky'.
	aBoardGame throwAccelerationCardFrom: 'Cami'.
	aBoardGame playTurnFor: 'Cami'.
	aBoardGame throwCancellationCardFrom: 'Cami' to: aSpaceshipCard. 
	aBoardGame playTurnFor: 'Vicky'.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber equals: 7.

]

{ #category : #tests }
CardTest >> test11WhenASpaceshipLandsOnACardEffectCellThenAnotherCardIsDealed [

	| spaceships aBoard aBoardGame aDeckOfCards aSpaceshipCard |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := Board of: cellEffects withLenght: (Parsec withValue: 15).

	aDeckOfCards := OrderedCollection new.
	aDeckOfCards add: SpeedCard new.
	aDeckOfCards add: OverloadCard new.
	aDeckOfCards add: AccelerationCard new.
	aDeckOfCards add: CancellationCard new.
	aDeckOfCards add: AccelerationCard new.
	
	aSpaceshipCard := SpaceshipCard named: spaceships with: AccelerationCard new. "Esto dsps de ultima lo cambiamos en la forma del msjs y que se pase la nave y la tarjeta pero same shit"

	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 4 2 3 )))
		              on: aBoard
		              with: 3
		              utilizing: aDeckOfCards.
	
	aBoardGame playTurnFor: 'Vicky'.
	aBoardGame playTurnFor: 'Cami'.
	aBoardGame throwAccelerationCardFrom: 'Vicky'.
	aBoardGame playTurnFor: 'Vicky'.
	
	self assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber equals: 9.
]

{ #category : #tests }
CardTest >> test12WhenASpaceshipPlaysACancellationCardButThereAreNotPermanentCardOnGameThenCannotPlayCard [

	| spaceships aBoard aBoardGame aDeckOfCards aSpaceshipCard |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := Board of: cellEffects withLenght: (Parsec withValue: 15).
	
	aDeckOfCards := OrderedCollection new.

	aDeckOfCards add: CancellationCard new.
	aDeckOfCards add: CancellationCard new.
	aDeckOfCards add: CancellationCard new.
	aDeckOfCards add: CancellationCard new.
	aDeckOfCards add: CancellationCard new.
	
	aSpaceshipCard := SpaceshipCard named: (OrderedCollection with: 'Vicky') with: OverloadCard new. 

	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
		              on: aBoard
		              with: 3
		              utilizing: aDeckOfCards.

	aBoardGame playTurnFor: 'Vicky'.
	aBoardGame playTurnFor: 'Cami'.
	
	self
		should: [ aBoardGame throwCancellationCardFrom: 'Cami' to: aSpaceshipCard. ]
		raise: Error
		withMessage: 'That card does not exist'.
	

]

{ #category : #tests }
CardTest >> test13WhenASpaceshipPlaysCancellationCardThenCardDoesNotExists [

	| spaceships aBoard aBoardGame aDeckOfCards aSpaceshipCard |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := Board of: cellEffects withLenght: (Parsec withValue: 15).

	aDeckOfCards := OrderedCollection new.
	aDeckOfCards add: SpeedCard new.
	aDeckOfCards add: OverloadCard new.
	aDeckOfCards add: AccelerationCard new.
	aDeckOfCards add: CancellationCard new.
	
	aSpaceshipCard := SpaceshipCard named: (OrderedCollection with: 'Vicky') with: OverloadCard new. 

	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
		              on: aBoard
		              with: 3
		              utilizing: aDeckOfCards.
		
	aBoardGame throwOverloadCardFrom: 'Vicky' to: 'Cami'.
	aBoardGame throwSpeedCardFrom: 'Vicky' to: 'Vicky'.
	aBoardGame playTurnFor: 'Vicky'.
	aBoardGame throwAccelerationCardFrom: 'Cami'.
	aBoardGame playTurnFor: 'Cami'.
	
	self
		should: [ aBoardGame throwCancellationCardFrom: 'Cami' to: aSpaceshipCard. ]
		raise: Error
		withMessage: 'That card does not exist'.
	

]

{ #category : #tests }
CardTest >> test14 [

	| spaceships aBoard aBoardGame aDeckOfCards aSpaceshipCard |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := Board of: cellEffects withLenght: (Parsec withValue: 15).

	aDeckOfCards := OrderedCollection new.
	aDeckOfCards add: SpeedCard new.
	aDeckOfCards add: AccelerationCard new.
	aDeckOfCards add: RedoCard new.
	aDeckOfCards add: CancellationCard new.
	
	aSpaceshipCard := SpaceshipCard named: (OrderedCollection with: 'Vicky') with: OverloadCard new. 

	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
		              on: aBoard
		              with: 3
		              utilizing: aDeckOfCards.
		
	aBoardGame throwSpeedCardFrom: 'Vicky' to: 'Vicky'.
	aBoardGame playTurnFor: 'Vicky'.
	aBoardGame throwRedoCardFrom: 'Cami' to: 'Vicky'.
	aBoardGame playTurnFor: 'Cami'.
	
	self
		should: [ aBoardGame throwCancellationCardFrom: 'Cami' to: aSpaceshipCard. ]
		raise: Error
		withMessage: 'That card does not exist'.
	

]
