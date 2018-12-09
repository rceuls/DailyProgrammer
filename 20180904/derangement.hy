#! /usr/bin/env hy

(defn derangement[x]
    "Calculates the derangement"
    (cond
        [(= 0 x) 1]
        [(= 1 x) 0]
        [True (* (- x 1)(+ (derangement(- x 1)) (derangement(- x 2))))])
)

(print (= (derangement 0) 1))
(print (= (derangement 1) 0))
(print (= (derangement 14) 32071101049))
