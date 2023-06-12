Class {
	#name : #CancellationCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
CancellationCard >> canBePlayedIn: aBoardGame for: aSpaceship [ 
	
]

{ #category : #'instance variable' }
CancellationCard >> name [
	^'cancellation'.
]

{ #category : #action }
CancellationCard >> playOn: aBoardGame [ 
	
	Error signal: 'You have to choose a card'.
]

{ #category : #action }
CancellationCard >> playOn: aBoardGame to: aString [ 
	
	Error signal: 'You have to choose a card.'
]

{ #category : #action }
CancellationCard >> playOn: aBoardGame toSelected: aSpaceshipCard [ 
	aBoardGame cancellationCardTo: aSpaceshipCard 
]
