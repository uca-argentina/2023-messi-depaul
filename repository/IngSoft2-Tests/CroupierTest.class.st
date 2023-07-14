Class {
	#name : #CroupierTest,
	#superclass : #TestCase,
	#instVars : [
		'cellEffects',
		'aDeckOfCards',
		'anOverloadCard',
		'aSpeedCard',
		'anAccelerationCard',
		'aCancellationCard',
		'aRepeatCard',
		'aRedoCard'
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
	cellEffects add: (Cell on: 5 of: DrawCardEffect new).
	cellEffects add: (Cell on: 6 of: NoEffect new).
	cellEffects add: (Cell on: 7 of: NoEffect new).
	cellEffects add: (Cell on: 8 of: NoEffect new).
	cellEffects add: (Cell on: 9 of: AtomicBombEffect new).
	cellEffects add: (Cell on: 10 of: SpeedUpEffect new).

	anOverloadCard := OverloadCard new.
	aSpeedCard := SpeedCard new.
	anAccelerationCard := AccelerationCard new.
	aCancellationCard := CancellationCard new.
	aRepeatCard := RepeatCard new.
	aRedoCard := RedoCard new
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

	| aCroupier spaceships aBoard aLoadedDie aBoardGame |
	
	aDeckOfCards := DeckOfCards with: (OrderedCollection with: aSpeedCard).
	aCroupier := Croupier handling: aDeckOfCards. 
	
	
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.

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

{ #category : #asserting }
CroupierTest >> test01WhenASpaceshipPlaysASpeedCardThenStaysOnTheGame [

	| spaceships aBoard aBoardGame aCroupier|
		
	aDeckOfCards := DeckOfCards with: (OrderedCollection with: aSpeedCard).
	aCroupier := Croupier handling: aDeckOfCards. 
	
	
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.

	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling: (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
		              on: aBoard
		              with: 2 managedBy: aCroupier.


	aBoardGame throw: aSpeedCard from: 'Vicky' to: 'Cami'.
	
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

{ #category : #asserting }
CroupierTest >> test02 [

	| aCroupier spaceships aBoard aLoadedDie aBoardGame |
	
	aDeckOfCards := DeckOfCards with: (OrderedCollection with: aSpeedCard).
	aCroupier := Croupier handling: aDeckOfCards. 
	
	
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.

	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	aLoadedDie := LoadedDie of: #( 1 2 3 ).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling: (OrderedCollection with: aLoadedDie)
		              on: aBoard
		              with: 2 managedBy: aCroupier.
		
	aBoardGame throw: aSpeedCard from: 'Vicky' to: 'Vicky'.
	
	aBoardGame playTurnFor: 'Vicky'.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber equals: 3
]

{ #category : #asserting }
CroupierTest >> test02WhenTwoSpeedCardsAffectASpaceshipThenSpaceshipMovesAffected [

	| spaceships aBoard aBoardGame aCroupier|
	aDeckOfCards := DeckOfCards with: (OrderedCollection with: aSpeedCard).
	aCroupier := Croupier handling: aDeckOfCards. 
	
	
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.

	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling: (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
		              on: aBoard
		              with: 2 managedBy: aCroupier.

	aBoardGame throw: aSpeedCard from: 'Vicky' to: 'Cami'.
	aBoardGame throw: aSpeedCard from: 'Vicky' to: 'Cami'.

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

{ #category : #asserting }
CroupierTest >> test03WhenSpaceshipTriesToThrowSpeedCardThenCannotThrowIt [

	| spaceships aBoard aBoardGame aCroupier|
	aDeckOfCards := DeckOfCards with: (OrderedCollection with: aSpeedCard).
	aCroupier := Croupier handling: aDeckOfCards. 
	
	
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.

	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling: (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
		              on: aBoard
		              with: 2 managedBy: aCroupier.

	aBoardGame throw: aSpeedCard from: 'Vicky' to: 'Cami'.
	aBoardGame throw: aSpeedCard from: 'Vicky' to: 'Cami'.

	self
		should: [ aBoardGame throw: aSpeedCard from: 'Vicky' to: 'Cami' ]
		raise: Error
		withMessage: 'You do not have that card'
]

{ #category : #asserting }
CroupierTest >> test04WhenASpaceshipPlaysOverloadCardThenAffectedSpaceshipIsMovesTwoLessThanTotalDiceThrown [

	| spaceships aBoard aBoardGame aCroupier|
	aDeckOfCards := DeckOfCards with: (OrderedCollection with: anOverloadCard).
	aCroupier := Croupier handling: aDeckOfCards. 
	
	
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.

	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling: (OrderedCollection with: (LoadedDie of: #( 1 5 3 )))
		              on: aBoard
		              with: 2 managedBy: aCroupier.
		
	aBoardGame throw: anOverloadCard from: 'Vicky' to: 'Cami'.
	aBoardGame playTurnFor: 'Vicky'.
	aBoardGame playTurnFor: 'Cami'.

	self
		assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber
		equals: 4
]

{ #category : #tests }
CroupierTest >> test05WhenSpaceshipPlaysAccelerationCardThenAllSpaceshipIncrementsOneMove [

	| spaceships aBoard aBoardGame aCroupier |
	aDeckOfCards := DeckOfCards with:
		                (OrderedCollection with: anAccelerationCard).
	aCroupier := Croupier handling: aDeckOfCards.


	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.

	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
		              on: aBoard
		              with: 2
		              managedBy: aCroupier.

	aBoardGame throw: anAccelerationCard from: 'Vicky'.

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
CroupierTest >> test06WhenSpaceshipTriesToPlayPermanentCardAndItsNotHisTurnThenCannotThrowIt [

	| spaceships aBoard aBoardGame aCroupier |
	aDeckOfCards := DeckOfCards with: (OrderedCollection
			                 with: aSpeedCard
			                 with: anOverloadCard
			                 with: anAccelerationCard).
	aCroupier := Croupier handling: aDeckOfCards.


	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.

	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
		              on: aBoard
		              with: 3
		              managedBy: aCroupier.

	self
		should: [ aBoardGame throw: aSpeedCard from: 'Cami' to: 'Cami' ]
		raise: Error
		withMessage: 'Its not your turn'
]

{ #category : #tests }
CroupierTest >> test07WhenSpaceshipPlaysDifferentPermanentCardsThenSpaceshipsMovesAreAffected [

	| spaceships aBoard aBoardGame aCroupier |
	aDeckOfCards := DeckOfCards with: (OrderedCollection
			                 with: aSpeedCard
			                 with: anOverloadCard
			                 with: anAccelerationCard).
	aCroupier := Croupier handling: aDeckOfCards.


	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.

	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
		              on: aBoard
		              with: 3
		              managedBy: aCroupier.
	
	aBoardGame throw: anOverloadCard from: 'Vicky' to: 'Cami'.
	aBoardGame throw: aSpeedCard from: 'Vicky' to: 'Vicky'.
	aBoardGame playTurnFor: 'Vicky'.
	aBoardGame throw: anAccelerationCard from: 'Cami'.
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
		equals: 8
]

{ #category : #tests }
CroupierTest >> test08WhenSpaceshipTriesToPlayPermanentCardAndItsNotHisTurnThenCannotThrowIt [

	| spaceships aBoard aBoardGame aCroupier |
	aDeckOfCards := DeckOfCards with: (OrderedCollection
			                 with: aSpeedCard).
	aCroupier := Croupier handling: aDeckOfCards.


	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.

	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
		              on: aBoard
		              with: 3
		              managedBy: aCroupier.

	self
		should: [ 
			aBoardGame throw: aSpeedCard from: 'Vicky' to: 'Delfina' ]
		raise: Error
		withMessage: 'That spaceship doesn´t exists'
]

{ #category : #tests }
CroupierTest >> test09WhenASpaceshipPlaysACancellationCardThenAffectedSpaceshipMovesWithoutCardEffect [

	| spaceships aBoard aBoardGame aCroupier |
	aDeckOfCards := DeckOfCards with: (OrderedCollection
			                 with: aSpeedCard
			                 with: anOverloadCard
			                 with: anAccelerationCard
			                 with: aCancellationCard).
	aCroupier := Croupier handling: aDeckOfCards.

	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.

	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
		              on: aBoard
		              with: 3
		              managedBy: aCroupier.

	aBoardGame throw: aSpeedCard from: 'Vicky' to: 'Vicky'.
	aBoardGame playTurnFor: 'Vicky'.

	aBoardGame throw: anAccelerationCard from: 'Cami'.
	aBoardGame playTurnFor: 'Cami'.

	aBoardGame throw: aCancellationCard from: 'Cami' choosing: aSpeedCard.

	aBoardGame playTurnFor: 'Vicky'.

	self
		assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber
		equals: 7
]

{ #category : #tests }
CroupierTest >> test10WhenASpaceshipCancelsAccelerationCardThenAllSpaceshipsAreAffected [

	| spaceships aBoard aBoardGame aCroupier |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).

	aDeckOfCards := DeckOfCards with: (OrderedCollection
			                 with: aSpeedCard
			                 with: anOverloadCard
			                 with: anAccelerationCard
			                 with: aCancellationCard
			                 with: aCancellationCard).
	aCroupier := Croupier handling: aDeckOfCards.


	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
		              on: aBoard
		              with: 3
		              managedBy: aCroupier.

	aBoardGame throw: anOverloadCard from: 'Vicky' to: 'Cami'.
	aBoardGame throw: aSpeedCard from: 'Vicky' to: 'Vicky'.
	aBoardGame playTurnFor: 'Vicky'.

	aBoardGame throw: anAccelerationCard from: 'Cami'.
	aBoardGame playTurnFor: 'Cami'.
	aBoardGame throw: aCancellationCard from: 'Cami' choosing: anAccelerationCard.
	aBoardGame playTurnFor: 'Vicky'.

	self
		assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber
		equals: 7
]

{ #category : #tests }
CroupierTest >> test11WhenASpaceshipLandsOnACardEffectCellThenAnotherCardIsDealed [

	| spaceships aBoard aBoardGame aCroupier |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).

	aDeckOfCards := DeckOfCards with: (OrderedCollection
			                 with: aSpeedCard
			                 with: anOverloadCard
			                 with: anAccelerationCard
			                 with: aCancellationCard
			                 with: anAccelerationCard).
	aCroupier := Croupier handling: aDeckOfCards.
	
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 4 2 3 )))
		              on: aBoard
		              with: 3
		              managedBy: aCroupier.
	
	aBoardGame playTurnFor: 'Vicky'.
	aBoardGame playTurnFor: 'Cami'.

	aBoardGame throw: anAccelerationCard from: 'Vicky'. 
	aBoardGame playTurnFor: 'Vicky'.
	
	self assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber equals: 1.
]

{ #category : #tests }
CroupierTest >> test12WhenASpaceshipPlaysACancellationCardButThereAreNotPermanentCardOnGameThenCannotPlayCard [

	| spaceships aBoard aBoardGame aCroupier |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).

	aDeckOfCards := DeckOfCards with:
		                (OrderedCollection with: aCancellationCard).
	aCroupier := Croupier handling: aDeckOfCards.

	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
		              on: aBoard
		              with: 3
		              managedBy: aCroupier.

	aBoardGame playTurnFor: 'Vicky'.
	aBoardGame playTurnFor: 'Cami'.

	self
		should: [ 
		aBoardGame throw: aCancellationCard from: 'Vicky' choosing: 2 ]
		raise: Error
		withMessage: 'That card does not exist'
]

{ #category : #tests }
CroupierTest >> test13WhenASpaceshipPlaysCancellationCardThenCardDoesNotExists [

	| spaceships aBoard aBoardGame aCroupier |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).

	aDeckOfCards := DeckOfCards with: (OrderedCollection
			                 with: aSpeedCard
			                 with: anOverloadCard
			                 with: anAccelerationCard
			                 with: aCancellationCard).
	aCroupier := Croupier handling: aDeckOfCards.


	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
		              on: aBoard
		              with: 3
		              managedBy: aCroupier.

	aBoardGame throw: anOverloadCard from: 'Vicky' to: 'Cami'.
	aBoardGame throw: aSpeedCard from: 'Vicky' to: 'Vicky'.

	aBoardGame playTurnFor: 'Vicky'.
	aBoardGame throw: anAccelerationCard from: 'Cami'.

	self
		should: [ 
		aBoardGame throw: aCancellationCard from: 'Cami' choosing: aCancellationCard ]
		raise: Error
		withMessage: 'That card does not exist'
]

{ #category : #tests }
CroupierTest >> test14WhenASpaceshipsThrowsARedoAndLastCardASpeedThenSpaceshipsAffected [

	| spaceships aBoard aBoardGame aCroupier|
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).

	aDeckOfCards := DeckOfCards with:
		                (OrderedCollection
			                 with: aSpeedCard
			                 with: aRedoCard).
	aCroupier := Croupier handling: aDeckOfCards.

	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
		              on: aBoard
		              with: 3
		              managedBy: aCroupier.


	aBoardGame throw: aSpeedCard from: 'Vicky' to: 'Cami'.
	aBoardGame throw: aRedoCard from: 'Vicky' to: 'Vicky'.

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
CroupierTest >> test15WhenASpaceshipsThrowsARedoAndLastCardAOverloadThenSpaceshipsAffected [

	| spaceships aBoard aBoardGame aCroupier|
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).

	aDeckOfCards := DeckOfCards with:
		                (OrderedCollection
			                 with: anOverloadCard
			                 with: aRedoCard).
	aCroupier := Croupier handling: aDeckOfCards.

	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 9 3 )))
		              on: aBoard
		              with: 3
		              managedBy: aCroupier.



	aBoardGame throw: anOverloadCard from: 'Vicky' to: 'Cami'.
	aBoardGame throw: aRedoCard from: 'Vicky' to: 'Vicky'.

	aBoardGame playTurnFor: 'Vicky'.
	aBoardGame playTurnFor: 'Cami'.

	self
		assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber
		equals: 8.
	self
		assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber
		equals: 1
]

{ #category : #tests }
CroupierTest >> test16WhenASpaceshipsThrowsTwoRedoAndLastCardASpeedThenSpaceshipsAffected [

	| spaceships aBoard aBoardGame aCroupier |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).

	aDeckOfCards := DeckOfCards with:
		                (OrderedCollection with: aSpeedCard with: aRedoCard).
	aCroupier := Croupier handling: aDeckOfCards.

	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
		              on: aBoard
		              with: 3
		              managedBy: aCroupier.


	aBoardGame throw: aSpeedCard from: 'Vicky' to: 'Cami'.
	aBoardGame throw: aRedoCard from: 'Vicky' to: 'Vicky'.
	aBoardGame playTurnFor: 'Vicky'.

	aBoardGame throw: aRedoCard from: 'Cami' to: 'Cami'.
	aBoardGame playTurnFor: 'Cami'.

	self
		assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber
		equals: 3.

	self
		assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber
		equals: 5
]

{ #category : #tests }
CroupierTest >> test17WhenASpaceshipsThrowsARedoAndLastCardAAccelerationThenSpaceshipsAffected [

	| spaceships aBoard aBoardGame aCroupier|
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).

	
	aDeckOfCards := DeckOfCards with:
		                (OrderedCollection with: anAccelerationCard with: aRedoCard).
	aCroupier := Croupier handling: aDeckOfCards.

	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
		              on: aBoard
		              with: 3
		              managedBy: aCroupier.



	aBoardGame throw: anAccelerationCard from: 'Vicky'.
	aBoardGame throw: aRedoCard from: 'Vicky'.

	aBoardGame playTurnFor: 'Vicky'.

	aBoardGame playTurnFor: 'Cami'.

	self
		assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber
		equals: 5.
	self
		assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber
		equals: 4.
]

{ #category : #tests }
CroupierTest >> test18WhenASpaceshipsThrowsARedoAndLastCardACancellationThenSpaceshipsAffected [

	| spaceships aBoard aBoardGame aCroupier aSpeedCard2 aCardPlayer2 aSpeedCard3 aCancellationCard2|
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	aSpeedCard2 := SpeedCard new.

	aDeckOfCards := DeckOfCards with: (OrderedCollection
			                 with: aSpeedCard
			                 with: aCancellationCard
			                 with: aSpeedCard2
			                 with: aRedoCard).
	aCroupier := Croupier handling: aDeckOfCards.
	
	aCardPlayer2 := CardPlayers of: aCancellationCard with: 'Vicky'. 

	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
		              on: aBoard
		              with: 3
		              managedBy: aCroupier.


	aBoardGame throw: aSpeedCard from: 'Vicky' to: 'Vicky'.
	aBoardGame playTurnFor: 'Vicky'.

	aBoardGame throw: aSpeedCard2 from: 'Cami' to: 'Vicky'.
	aBoardGame throw: aCancellationCard from: 'Vicky' choosing: aSpeedCard.

	aBoardGame throw: aRedoCard from: 'Cami' choosing: aCardPlayer2.

	aBoardGame playTurnFor: 'Cami'.

	self
		assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber
		equals: 3.
	self
		assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber
		equals: 3
]

{ #category : #tests }
CroupierTest >> test19WhenASpaceshipThrowsRepeatCardAndLastCellEffectSpeedUpThenASpaceshipIsAffected [

	| spaceships aBoard aBoardGame aCroupier|
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	spaceships add: 'Delfi'.
	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	
	aDeckOfCards := DeckOfCards with: (OrderedCollection
			                 with: aRepeatCard).
	aCroupier := Croupier handling: aDeckOfCards.

	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 9 2 3 )))
		              on: aBoard
		              with: 3
		              managedBy: aCroupier.

	aBoardGame playTurnFor: 'Vicky'.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber equals: 4.
	
	aBoardGame throw: aRepeatCard from: 'Delfi' to: 'Delfi'.
	
	self assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber equals: 1.
	self assert: (aBoardGame spaceshipPosition: 'Delfi') cellNumber equals: 5.
	


]

{ #category : #tests }
CroupierTest >> test20WhenAspaceshipThrowsRepeatCardAndLastCellEffectAtomicBombThenAllSpaceshipsReturnToInitialPosition [

	| spaceships aBoard aBoardGame aCroupier |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	spaceships add: 'Delfi'.
	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).

	aDeckOfCards := DeckOfCards with: (OrderedCollection
			                 with: aRepeatCard).
	aCroupier := Croupier handling: aDeckOfCards.

	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 7 8 3 )))
		              on: aBoard
		              with: 3
		              managedBy: aCroupier.

	aBoardGame playTurnFor: 'Vicky'.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber equals: 8.
	aBoardGame playTurnFor: 'Cami'.
	aBoardGame throw: aRepeatCard from: 'Delfi'.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber equals: 1.
	self assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber equals: 1.
	self assert: (aBoardGame spaceshipPosition: 'Delfi') cellNumber equals: 1.
	


]

{ #category : #tests }
CroupierTest >> test21WhenASpaceshipThrowsRepeatCardAndLastCellEffectMoonWalkThenSomeSpaceshipsGoBackwards [

| spaceships aBoard aBoardGame cellEffectsCollection aMoonWalkEffect aCroupier |
	cellEffectsCollection := OrderedCollection new.
	aMoonWalkEffect := MoonWalkEffect with: 5.
	
	aDeckOfCards := DeckOfCards with: (OrderedCollection
			                 with: aRepeatCard).
	aCroupier := Croupier handling: aDeckOfCards.

	cellEffectsCollection add: (Cell on: 1 of: NoEffect new).
	cellEffectsCollection add: (Cell on: 2 of: NoEffect new).
	cellEffectsCollection add: (Cell on: 3 of: NoEffect new).
	cellEffectsCollection add: (Cell on: 4 of: NoEffect new).
	cellEffectsCollection add: (Cell on: 5 of: NoEffect new).
	cellEffectsCollection add: (Cell on: 6 of: aMoonWalkEffect).
	cellEffectsCollection add: (Cell on: 7 of: NoEffect new).
	cellEffectsCollection add: (Cell on: 8 of: NoEffect new).
	cellEffectsCollection add: (Cell on: 9 of: NoEffect new).
	cellEffectsCollection add: (Cell on: 10 of: NoEffect new).


	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	spaceships add: 'Delfi'.
	
		
	aBoard := Board of: cellEffectsCollection withLenght: (Parsec of: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 7 5 3 )))
		              on: aBoard
		              with: 2 managedBy: aCroupier.

	aBoardGame playTurnFor: 'Vicky'.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber equals: 8.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') round equals: 1.

	aBoardGame playTurnFor: 'Cami'.
	self assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber equals: 6.
	self assert: (aBoardGame spaceshipPosition: 'Cami') round equals: 1.

	self assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber equals: 3.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') round equals: 1.
	
	aBoardGame throw: aRepeatCard from: 'Delfi' to: 'Vicky'.
	
	self assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber equals: 1.
	self assert: (aBoardGame spaceshipPosition: 'Cami') round equals: 1.

	self assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber equals: 3.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') round equals: 1.

	
]

{ #category : #tests }
CroupierTest >> test22WhenASpaceshipThrowsAnAccelerationCardToAnotherSpaceshipThenCannotThrowCard [

	| spaceships aBoard aBoardGame aCroupier |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).

	aDeckOfCards := DeckOfCards with:
		                (OrderedCollection with: anAccelerationCard).
	aCroupier := Croupier handling: aDeckOfCards.

	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
		              on: aBoard
		              with: 3
		              managedBy: aCroupier.

	aBoardGame playTurnFor: 'Vicky'.
	aBoardGame throw: anAccelerationCard from: 'Cami' to: 'Cami'.
	self
		should: [ 
		aBoardGame throw: anAccelerationCard from: 'Cami' to: 'Cami' ]
		raise: Error
		withMessage: 'You cannot choose a player for acceleration card.'
]

{ #category : #tests }
CroupierTest >> test23WhenASpaceshipThrowsRepeatCardAndLastCellEffectWormHoleThenASpaceshipGoesBackwards [

| spaceships aBoard aBoardGame cellEffectsCollection aCroupier |
	cellEffectsCollection := OrderedCollection new.
	
	cellEffectsCollection add: (Cell on: 1 of: NoEffect new).
	cellEffectsCollection add: (Cell on: 2 of: NoEffect new).
	cellEffectsCollection add: (Cell on: 3 of: NoEffect new).
	cellEffectsCollection add: (Cell on: 4 of: NoEffect new).
	cellEffectsCollection add: (Cell on: 5 of: NoEffect new).
	cellEffectsCollection add: (Cell on: 6 of: WormHoleEffect new).
	cellEffectsCollection add: (Cell on: 7 of: NoEffect new).
	cellEffectsCollection add: (Cell on: 8 of: NoEffect new).
	cellEffectsCollection add: (Cell on: 9 of: NoEffect new).
	cellEffectsCollection add: (Cell on: 10 of: NoEffect new).


	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	spaceships add: 'Delfi'.
	
	aDeckOfCards := DeckOfCards with: (OrderedCollection
			                 with: aRepeatCard).
	aCroupier := Croupier handling: aDeckOfCards.
		
	aBoard := Board of: cellEffectsCollection withLenght: (Parsec of: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 9 5 3 )))
		              on: aBoard
		              with: 2 managedBy: aCroupier.
	aBoardGame playTurnFor: 'Vicky'.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber equals: 10.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') round equals: 1.

	aBoardGame playTurnFor: 'Cami'.
	self assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber equals: 2.
	self assert: (aBoardGame spaceshipPosition: 'Cami') round equals: 1.
	
	aBoardGame throw: aRepeatCard from: 'Delfi' to: 'Vicky'.

	self assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber equals: 6.
	self assert: (aBoardGame spaceshipPosition: 'Cami') round equals: 1.
	

	
]

{ #category : #tests }
CroupierTest >> test24WhenASpaceshipThrowsRepeatCardAndDiceWerentThrownThenNoEffect [

| spaceships aBoard aBoardGame cellEffectsCollection aCroupier |
	cellEffectsCollection := OrderedCollection new.
	
	cellEffectsCollection add: (Cell on: 1 of: NoEffect new).
	cellEffectsCollection add: (Cell on: 2 of: NoEffect new).
	cellEffectsCollection add: (Cell on: 3 of: NoEffect new).
	cellEffectsCollection add: (Cell on: 4 of: NoEffect new).
	cellEffectsCollection add: (Cell on: 5 of: NoEffect new).
	cellEffectsCollection add: (Cell on: 6 of: WormHoleEffect new).
	cellEffectsCollection add: (Cell on: 7 of: NoEffect new).
	cellEffectsCollection add: (Cell on: 8 of: NoEffect new).
	cellEffectsCollection add: (Cell on: 9 of: NoEffect new).
	cellEffectsCollection add: (Cell on: 10 of: NoEffect new).


	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	spaceships add: 'Delfi'.
	
	aDeckOfCards := DeckOfCards with: (OrderedCollection
			                 with: aRepeatCard).
	aCroupier := Croupier handling: aDeckOfCards.
		
	aBoard := Board of: cellEffectsCollection withLenght: (Parsec of: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 9 5 3 )))
		              on: aBoard
		              with: 2 managedBy: aCroupier.
	aBoardGame throw: aRepeatCard from: 'Delfi' to: 'Vicky'.
	aBoardGame playTurnFor: 'Vicky'.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber equals: 10.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') round equals: 1.

	aBoardGame playTurnFor: 'Cami'.
	self assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber equals: 2.
	self assert: (aBoardGame spaceshipPosition: 'Cami') round equals: 1.
	
	aBoardGame throw: aRepeatCard from: 'Delfi' to: 'Vicky'.

	self assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber equals: 6.
	self assert: (aBoardGame spaceshipPosition: 'Cami') round equals: 1.
	

	
]

{ #category : #tests }
CroupierTest >> test25WhenASpaceshipThrowsARepeatCardNotIndicatingSpaceshipAndLastCellEffectAMoonWalkThenAppliesToSpaceshipPlaying [

| spaceships aBoard aBoardGame cellEffectsCollection aMoonWalkEffect aCroupier |
	cellEffectsCollection := OrderedCollection new.
	aMoonWalkEffect := MoonWalkEffect with: 5.
	
	cellEffectsCollection add: (Cell on: 1 of: NoEffect new).
	cellEffectsCollection add: (Cell on: 2 of: NoEffect new).
	cellEffectsCollection add: (Cell on: 3 of: NoEffect new).
	cellEffectsCollection add: (Cell on: 4 of: NoEffect new).
	cellEffectsCollection add: (Cell on: 5 of: NoEffect new).
	cellEffectsCollection add: (Cell on: 6 of: aMoonWalkEffect).
	cellEffectsCollection add: (Cell on: 7 of: NoEffect new).
	cellEffectsCollection add: (Cell on: 8 of: NoEffect new).
	cellEffectsCollection add: (Cell on: 9 of: NoEffect new).
	cellEffectsCollection add: (Cell on: 10 of: NoEffect new).


	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	spaceships add: 'Delfi'.
	
	aDeckOfCards := DeckOfCards with: (OrderedCollection
			                 with: aRepeatCard).
	aCroupier := Croupier handling: aDeckOfCards.
		
	aBoard := Board of: cellEffectsCollection withLenght: (Parsec of: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 9 5 5 )))
		              on: aBoard
		              with: 2 managedBy: aCroupier.
	aBoardGame playTurnFor: 'Vicky'.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber equals: 10.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') round equals: 1.

	aBoardGame playTurnFor: 'Cami'.
	self assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber equals: 6.
	self assert: (aBoardGame spaceshipPosition: 'Cami') round equals: 1.
	
	aBoardGame playTurnFor: 'Delfi'.
	
	aBoardGame throw: aRepeatCard from: 'Delfi'. 
	
	self assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber equals: 1.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') round equals: 1.
	
	self assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber equals: 1.
	self assert: (aBoardGame spaceshipPosition: 'Cami') round equals: 1.
	
	self assert: (aBoardGame spaceshipPosition: 'Delfi') cellNumber equals: 1.
	self assert: (aBoardGame spaceshipPosition: 'Delfi') round equals: 1.
	

	
]

{ #category : #tests }
CroupierTest >> test26WhenASpaceshipThrowsSpeedCardNotChoosingAPlayerThenCanNotThrowCard [
	| spaceships aBoard aBoardGame aCroupier |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	aDeckOfCards := DeckOfCards with: (OrderedCollection
			                 with: aSpeedCard).
	aCroupier := Croupier handling: aDeckOfCards.

	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
		              on: aBoard
		              with: 3
		              managedBy: aCroupier.
		
	aBoardGame throw: aSpeedCard from: 'Vicky' to: 'Vicky'.
	aBoardGame throw: aSpeedCard from: 'Vicky'.
	 
	self should: [ 	aBoardGame throw: aSpeedCard from: 'Vicky'.  ] raise: Error  withMessage: 'To play card, choose a player' .	
]

{ #category : #tests }
CroupierTest >> test27WhenASpaceshipThrowsSpeedCardChoosingASpaceshipCardThenCanNotThrowCard [

	| spaceships aBoard aBoardGame aCroupier |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	
	aDeckOfCards := DeckOfCards with: (OrderedCollection
			                 with: aSpeedCard).
	aCroupier := Croupier handling: aDeckOfCards.

	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
		              on: aBoard
		              with: 3
		              managedBy: aCroupier.
		
	aBoardGame throw: aSpeedCard from: 'Vicky' to: 'Vicky'.

	self should: [ 	aBoardGame throw: aSpeedCard from: 'Vicky' choosing: 1.  ] raise: Error  withMessage: 'To play card, choose a player' .
	
]

{ #category : #tests }
CroupierTest >> test28WhenASpaceshipThrowsOverloadCardChoosingASpaceshipCardThenCanNotThrowCard [

	| spaceships aBoard aBoardGame aCroupier |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
		
	aDeckOfCards := DeckOfCards with: (OrderedCollection
			                 with: anOverloadCard).
	aCroupier := Croupier handling: aDeckOfCards.

	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
		              on: aBoard
		              with: 3
		              managedBy: aCroupier.

	aBoardGame throw: anOverloadCard from: 'Vicky' to: 'Vicky'.

	self
		should: [ 
			aBoardGame
				throw: anOverloadCard
				from: 'Vicky'
				choosing: 1 ]
		raise: Error
		withMessage: 'To play card, choose a player'
]

{ #category : #tests }
CroupierTest >> test29WhenASpaceshipThrowsOverloadCardNotChoosingAPlayerThenCanNotThrowCard [

	| spaceships aBoard aBoardGame aCroupier |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	
	aDeckOfCards := DeckOfCards with: (OrderedCollection
			                 with: anOverloadCard).
	aCroupier := Croupier handling: aDeckOfCards.
	

	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
		              on: aBoard
		              with: 3
		              managedBy: aCroupier.

	aBoardGame throw: anOverloadCard from: 'Vicky' to: 'Vicky'.
	
	self
		should: [ 
			aBoardGame
				throw: anOverloadCard
				from: 'Vicky'.]
		raise: Error
		withMessage: 'To play card, choose a player'
]

{ #category : #tests }
CroupierTest >> test30WhenASpaceshipThrowsAccelerationCardChoosingASpaceshipCardThenCanNotThrowCard [

	| spaceships aBoard aBoardGame aCroupier |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	
		
	aDeckOfCards := DeckOfCards with: (OrderedCollection
			                 with: anAccelerationCard).
	aCroupier := Croupier handling: aDeckOfCards.

	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
		              on: aBoard
		              with: 3
		              managedBy: aCroupier.

	aBoardGame throw: anAccelerationCard  from: 'Vicky'.
	
	self
		should: [ 
			aBoardGame
				throw: anAccelerationCard 
				from: 'Vicky' choosing: 1.]
		raise: Error
		withMessage: 'You cannot choose a player for acceleration card.'
]

{ #category : #tests }
CroupierTest >> test31WhenASpaceshipThrowsCancellationCardChoosingAPlayerThenCanNotThrowCard [

	| spaceships aBoard aBoardGame  aCroupier |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	
		
	aDeckOfCards := DeckOfCards with: (OrderedCollection
			                 with: aSpeedCard with: aCancellationCard).
	aCroupier := Croupier handling: aDeckOfCards.

	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
		              on: aBoard
		              with: 3
		              managedBy: aCroupier.

	aBoardGame throw: aSpeedCard from: 'Vicky' to: 'Vicky'.

	self
		should: [ aBoardGame throw: aCancellationCard from: 'Vicky' ]
		raise: Error
		withMessage: 'You have to choose a card'
]

{ #category : #tests }
CroupierTest >> test32WhenASpaceshipThrowsCancellationCardNotChoosingSpaceshipCardThenCanNotThrowCard [

	| spaceships aBoard aBoardGame aCroupier |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	
	aDeckOfCards := DeckOfCards with: (OrderedCollection
			                 with: aCancellationCard).
	aCroupier := Croupier handling: aDeckOfCards.

	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
		              on: aBoard
		              with: 3
		              managedBy: aCroupier.
	self
		should: [ 
		aBoardGame throw: aCancellationCard from: 'Vicky' to: 'Vicky' ]
		raise: Error
		withMessage: 'You have to choose a card.'
]

{ #category : #tests }
CroupierTest >> test33WhenASpaceshipThrowsRedoCardNotChoosingAPlayerForSpeedCardThenCanNotThrowCard [

	| spaceships aBoard aBoardGame aCroupier |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).

	
	aDeckOfCards := DeckOfCards with: (OrderedCollection
			                 with: aSpeedCard with: aRedoCard ).
	aCroupier := Croupier handling: aDeckOfCards.

	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
		              on: aBoard
		              with: 3
		              managedBy: aCroupier.

	aBoardGame throw: aSpeedCard from: 'Vicky' to: 'Vicky'.

	self
		should: [ aBoardGame throw: aRedoCard from: 'Vicky' ]
		raise: Error
		withMessage: 'To play card, choose a player'
]
