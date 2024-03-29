Class {
	#name : #Croupier,
	#superclass : #Object,
	#instVars : [
		'deckOfCards',
		'playersCards',
		'indexCards',
		'permanentCardsPlayers',
		'lastCardPlayed'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Croupier class >> handling: aDeckOfCards [ 
	^(self new) handling: aDeckOfCards.
]

{ #category : #action }
Croupier >> cancellationCardTo: aCard [

	| aCardPlayers |
	aCardPlayers := permanentCardsPlayers detect: [ :cardPlayers | 
		                cardPlayers cards id = aCard id ]ifNone:[Error signal: 'That card does not exist'].
	
	permanentCardsPlayers remove: aCardPlayers .
	lastCardPlayed := CancellationCard new.
]

{ #category : #action }
Croupier >> dealACardTo: aSpaceship [
		playersCards do: [ :playerCards | 
		(playerCards spaceships = aSpaceship) ifTrue: [ 
			playerCards cards add: (deckOfCards cards at: indexCards).
			indexCards := indexCards \\ deckOfCards cards size + 1]].
]

{ #category : #'instance creation' }
Croupier >> dealCardsWhenGameIsStartedTo: spaceships [
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
	
	
]

{ #category : #'instance creation' }
Croupier >> handling: aDeckOfCards [ 
	deckOfCards := aDeckOfCards.
	indexCards := 1.
	permanentCardsPlayers:= OrderedCollection new.
]

{ #category : #action }
Croupier >> lastCardPlayed [
	^lastCardPlayed .
]

{ #category : #action }
Croupier >> permanentCardsOf: aSpaceship [

	| anAmount |
	anAmount := 0.
	permanentCardsPlayers do: [ :cardPlayers | 
		(cardPlayers spaceships includes: aSpaceship) ifTrue: [ 
			anAmount := anAmount + (cardPlayers cards implementOn: self) ] ].
	^ anAmount
]

{ #category : #play }
Croupier >> play: aCardPlayers [ 
	aCardPlayers cards playOn: self to: aCardPlayers.
]

{ #category : #play }
Croupier >> play: aCard forSelected: choosenCard [ 
	aCard playOn: self toSelected: choosenCard
]

{ #category : #play }
Croupier >> play: aCardPlayers on: aBoardGame [ 
	aCardPlayers cards playOn: aBoardGame to: aCardPlayers.
]

{ #category : #play }
Croupier >> playOnAll: aCardPlayers [ 
	aCardPlayers cards playOn: self toAll: aCardPlayers.
]

{ #category : #action }
Croupier >> playerCardOf: aSpaceship [

	| aPlayerCards |
	aPlayerCards := playersCards
		                detect: [ :playerCards | 
		                playerCards spaceships = aSpaceship ]
		                ifNone: [ Error signal: 'You are not playing' ].
	^ aPlayerCards
]

{ #category : #action }
Croupier >> recordPermanent: aCardPlayers [

	permanentCardsPlayers add: aCardPlayers.
	lastCardPlayed := aCardPlayers cards
]

{ #category : #play }
Croupier >> take: aCard from: aSpaceship on: aBoardGame [
	
	| aPlayerCards |
	"Verifico que pueda jugar en su turno (si es permanente)"
	aCard canBePlayedIn: aBoardGame for: aSpaceship.
	"Devuelvo el playerCards que coincide con esa spaceship"
	aPlayerCards:= self playerCardOf: aSpaceship.
	"Remover la carta de esa spaceship"
	aPlayerCards removeCard: aCard id.
	
]
