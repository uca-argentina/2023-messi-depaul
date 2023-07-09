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
Croupier >> cancellationCardTo: cardId [

	| aCardPlayers |
	aCardPlayers := permanentCardsPlayers detect: [ :cardPlayers | 
		                cardPlayers card id = cardId ]ifNone:[Error signal: 'That card does not exist'].
	
	permanentCardsPlayers remove: aCardPlayers .
	lastCardPlayed := CancellationCard new.
]

{ #category : #action }
Croupier >> dealACardTo: aSpaceship [
		playersCards do: [ :playerCards | 
		(playerCards spaceships = aSpaceship) ifTrue: [ 
			playerCards card add: (deckOfCards card at: indexCards).
			indexCards := indexCards \\ deckOfCards card size + 1]].
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

{ #category : #'instance creation' }
Croupier >> lastCardPlayed [
	^lastCardPlayed .
]

{ #category : #action }
Croupier >> permanentCardsOf: aSpaceship [

	| anAmount |
	anAmount := 0.
	permanentCardsPlayers do: [ :cardPlayers | 
		(cardPlayers spaceships includes: aSpaceship) ifTrue: [ 
			anAmount := anAmount + (cardPlayers card implementOn: self) ] ].
	^ anAmount
]

{ #category : #play }
Croupier >> play: aCardPlayers [ 
	aCardPlayers card playOn: self to: aCardPlayers
]

{ #category : #play }
Croupier >> play: aCard forSelected: cardId [ 
	aCard playOn: self to: cardId
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

{ #category : #permanentCards }
Croupier >> recordPermanent: aCardPlayers [

	permanentCardsPlayers add: aCardPlayers.
	lastCardPlayed := aCardPlayers card
]

{ #category : #repetedCard }
Croupier >> repeatCardTo: aCardPlayers [ 
	self shouldBeImplemented.
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
