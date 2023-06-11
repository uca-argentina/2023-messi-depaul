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
CancellationCard >> playOn: aBoardGame to: aSpaceshipCard [ 
	aBoardGame cancellationCardTo: aSpaceshipCard 
]
