(define (problem waiting-32)
    (:domain waiting)
    (:objects 
    
        c - customer 
        p - plate 
        b - broom 

        
        ; Locations
        
        UB - location 
        UF - location 
        MB - location 
        MF - location 
        LB - location 
        LF - location
    )

    
    (:init
        ; The agent starts at BUFF
        (At Agent BUFF)
        
        ; There is an unserved customer at LB 
        (At c LB)
        ;(not (IsServed c))
        
        ; There is an empty plate at BUFF
        (At p BUFF)
        ;(not (HasFood p))
        
        ; There is a broom at UB 
        (At b UB)
        
        ; There is a broken plate at MF and MB 
        (BrokenPlate MF)
        (BrokenPlate MB)
        
        ; There is dropped food at UF
        (DroppedFood UF)
        
        ; Initial State of the restaurant setting
        (Adjacent UB UF)
        (Adjacent BUFF UF)
        (Adjacent UF MF)
        (Adjacent MF LF)
        (Adjacent LB MB)
        (Adjacent UB MB)
        (Adjacent LB LF)
        
        (Adjacent UF UB)
        (Adjacent UF BUFF)
        (Adjacent MF UF)
        (Adjacent LF MF)
        (Adjacent MB LB)
        (Adjacent MB UB)
        (Adjacent LF LB)

    )
    
    (:goal (and 
    
        ; All customers are served
        (forall (?c - customer) (IsServed ?c))
        
        ; The agent is at BUFF
        (At Agent BUFF)
        
        ; There is not any rubbish on any part of the floor 
        (forall (?loc - location) (not(BrokenPlate ?loc)))
        (forall (?loc - location) (not(DroppedFood ?loc)))
        
    ))
)