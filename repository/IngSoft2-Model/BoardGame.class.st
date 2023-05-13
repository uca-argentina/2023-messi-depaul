Class {
	#name : #BoardGame,
	#superclass : #Object,
	#instVars : [
		'spaceships',
		'turn',
		'dice',
		'spaceshipPositions',
		'board',
		'play',
		'winner'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialize }
BoardGame class >> of: aBoard with: spaceships andWith: dice [
	self validateCanExistWith: spaceships.
	^(self new) initializesOf: aBoard with: spaceships andWith: dice.
]

{ #category : #'instance creation' }
BoardGame class >> validateCanExistWith: aSpaceshipCollection [
	
	(aSpaceshipCollection isEmpty) ifTrue: [Error signal: 'Cannot create board with no spaceships'].
]

{ #category : #action }
BoardGame >> aSpaceshipPlays: aName [

	| aSpaceshipPosition1 |
	play
		ifTrue: [ 
			self aSpaceshipTurn = aName
				ifTrue: [ 
					aSpaceshipPosition1 := spaceshipPositions detect: [ 
						                       :aSpaceshipPosition | 
						                       aSpaceshipPosition spaceship == aName ].

					aSpaceshipPosition1
						change: self throwDice
						and: board anAmountOfCells.
						
					self validateWinner: aSpaceshipPosition1 ]
				
				ifFalse: [ self validateTurn ] ]
			
		ifFalse: [ self validateKeepPlaying ]
]

{ #category : #action }
BoardGame >> aSpaceshipTurn [

	| aSpaceship |
	aSpaceship := spaceships at: turn.
	turn := turn \\ spaceships size + 1.
	^ aSpaceship
]

{ #category : #'instance variables' }
BoardGame >> dice [
	^ dice
]

{ #category : #initialization }
BoardGame >> initializesOf: aBoard with: spaceshipsCollection andWith: diceCollection [ 
	board := aBoard  .
	spaceships := spaceshipsCollection .
	dice := diceCollection .
	turn:= 1.
	self spaceshipsInitialization.
	play := true.
]

{ #category : #action }
BoardGame >> positions [

	^ spaceshipPositions collect: [ :spaceship | spaceship position ].
]

{ #category : #action }
BoardGame >> spaceshipPosition: aName [
	^ ((spaceshipPositions detect: [:spaceshipPosition | spaceshipPosition spaceship == aName ]) position).
]

{ #category : #action }
BoardGame >> spaceshipRound: aName [ 
	^ ((spaceshipPositions detect: [:spaceshipPosition | spaceshipPosition spaceship == aName ]) round).
]

{ #category : #action }
BoardGame >> spaceshipsInitialization [

	| size |
	size := 0.
	spaceshipPositions := OrderedCollection new.
	[ spaceships size > size ] whileTrue: [ 
		spaceshipPositions add:
			(SpaceshipPosition of: (spaceships at: size + 1) with: 1).
		size := size + 1 ]
]

{ #category : #action }
BoardGame >> throwDice [

	| result |
	result := 0.
	dice do: [ :each | result := result + each throw ].
	^ result
]

{ #category : #action }
BoardGame >> validateKeepPlaying [

	Error signal: 'There is a winner, you cant keep moving forward'
]

{ #category : #validation }
BoardGame >> validateTurn [
	Error signal: 'Its not your turn'.
]

{ #category : #validation }
BoardGame >> validateWinner: aSpaceshipPosition [

	aSpaceshipPosition round >= board rounds ifTrue: [ 
		play := false.
		aSpaceshipPosition winner: board rounds.
		winner:= aSpaceshipPosition spaceship.
		]
	ifFalse:[].
]

{ #category : #'instance variable' }
BoardGame >> winner [
	^ winner
]
