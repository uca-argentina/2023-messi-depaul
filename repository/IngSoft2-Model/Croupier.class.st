Class {
	#name : #Croupier,
	#superclass : #Object,
	#instVars : [
		'deckOfCards',
		'playersCards',
		'indexCards',
		'playersPermanentCards',
		'playingCard'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Croupier class >> handling: aDeckOfCards [ 
	^(self new) handling: aDeckOfCards.
]

{ #category : #action }
Croupier >> dealACardTo: aSpaceship [
		playersCards do: [ :playerCards | 
		(playerCards spaceship = aSpaceship) ifTrue: [ 
			playerCards cards add: (deckOfCards at: indexCards).
			indexCards := indexCards \\ deckOfCards size + 1]].
]

{ #category : #action }
Croupier >> dealCardsTo: spaceships [
	| size amountOfCards |
	size := 0.
	amountOfCards := 0.
	playersCards := OrderedCollection new.
	
	[ spaceships size > size ] whileTrue: [ 
		playersCards add: (PlayerCards
				 of: (spaceships at: size + 1)).
		self dealACardTo: (spaceships at: size + 1).
		self dealACardTo: (spaceships at: size + 1).
		size := size + 1 ]
	
	
	"[ spaceships size > size ] whileTrue: [ 
		playersCards add: (PlayerCards
				 named: (spaceships at: size + 1)
				 with: (deckOfCards at: indexCards)).
		indexCards := indexCards \\ deckOfCards size + 1.
		size := size + 1 ]"
]

{ #category : #'instance creation' }
Croupier >> handling: aDeckOfCards [ 
	deckOfCards := aDeckOfCards.
	indexCards := 1.
]

{ #category : #action }
Croupier >> permanentCardsOf: aSpaceship [

	| anAmount |
	anAmount := 0.
	playersPermanentCards
		do: [ :playerPermanentCard | 
		(playerPermanentCard spaceship = aSpaceship)ifTrue: [ 
		anAmount := anAmount + (playerPermanentCard card implementOn: self) ]]
]

{ #category : #action }
Croupier >> take: aCard from: aSpaceship [
	| aPlayerCards aPlayerCard|
	aPlayerCards := playersCards detect: [ :playerCards | 
			                  (playerCards spaceship = aSpaceship) ]
		                  ifNone: [ 
		                  Error signal: 'That player does not exist' ].
	
	aPlayerCard := aPlayerCards detect: [ :playerCard | 
			                  (playerCard = aCard) ]
		                  ifNone: [ 
		                  Error signal: 'You do not have that card' ].
	playingCard := aPlayerCard.
	aPlayerCards remove: aPlayerCard.
	"aSpaceshipCard card canBePlayedIn: self for: aSpaceship"
]
