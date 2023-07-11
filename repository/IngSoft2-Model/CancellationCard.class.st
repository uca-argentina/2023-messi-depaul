Class {
	#name : #CancellationCard,
	#superclass : #Object,
	#instVars : [
		'cardId'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #action }
CancellationCard >> canBePlayedIn: aBoardGame for: aSpaceship [ 
	
]

{ #category : #'instance variable' }
CancellationCard >> id [
	^cardId 
]

{ #category : #'instance variable' }
CancellationCard >> id: number [ 
	cardId:= number.
]

{ #category : #action }
CancellationCard >> playOn: aBoardGame [ 
	
	Error signal: 'You have to choose a card'.
]

{ #category : #action }
CancellationCard >> playOn: aCroupier to: aCardId [ 
	
	aCroupier cancellationCardTo: aCardId
]
