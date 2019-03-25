(define (problem waiting-22) ;; Replace XX with task number
    (:domain waiting)
    (:objects 
        c - customer
        p - plate
        BUFF - location
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

	; There is an empty plate at BUFF
        (At p BUFF)

	; There is an unserved customer at LB
        (At c LB)
        
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
    

    (:goal 
	; The goal is for the customer to be served
        (IsServed c)
    )
)
