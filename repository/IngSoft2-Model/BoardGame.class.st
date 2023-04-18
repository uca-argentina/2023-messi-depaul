Class {
	#name : #BoardGame,
	#superclass : #Object,
	#instVars : [
		'board',
		'spaceships'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
BoardGame class >> with: aBoard and: anAmountOfSpaceships [
	^(self new) initializedWith: aBoard and: anAmountOfSpaceships. 
]

{ #category : #validations }
BoardGame >> hasAnySpaceshipWon [
	^ spaceships detect: [:spaceship | spaceship whereIsMyPosition == board howManyCellsDoIHave].
]

{ #category : #initialization }
BoardGame >> initializedWith: aBoard and: aSpaceship [ 
	board := aBoard.
	spaceships := aSpaceship.
]

{ #category : #validation }
BoardGame >> isValid [
	^true.
]
