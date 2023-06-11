Class {
	#name : #RedoCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
RedoCard >> canBePlayedIn: aBoardGame for: aSpaceship [ 
	
	aBoardGame validateRedoCard
]

{ #category : #'instance variable' }
RedoCard >> name [

	^ 'redo'
]
