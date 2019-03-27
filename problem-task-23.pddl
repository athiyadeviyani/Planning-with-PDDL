(define (problem waiting-23)
    (:domain waiting)
    (:objects 

        c1 - customer 
        c2 - customer 
        p1 - plate 
        p2 - plate
        BUFF - location
        UB - location 
        UF - location 
        MB - location 
        MF - location 
        LB - location 
        LF - location
    )
    
    (:init
        ; The agent starts at MF
        (At Agent MF)
        
        ; There is one empty plate at MB and another at LB 
        (At p1 MB)
        (At p2 LB)
        
        ; There are two customers - One at UB and one at LF 
        (At c1 UB)
        (At c2 LF)
        
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
        ; The goal is that both customers are served, and the agent is at BUFF
        (and 
            (IsServed c1)
            (IsServed c2)
            (At Agent BUFF)
        )
    )
)
