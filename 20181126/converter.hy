#! /usr/bin/env hy

(defn validate [input]
    "checks the value so that it's a valid rgb value (i.e. 0 <= x <= 255)"
    (and (<= input 255) (>= input 0))
)

(defn hyhex [r g b]
    "formats a rgb value to its hex representation"
    (if (and (= (validate r) (validate g) (validate b)))
        (.format "#{0:02X}{1:02X}{2:02X}" r g b)
        (raise (TypeError "invalid input")))
)

(defn extractor [start color]
    (int (cut color start (+ start 2)) 16)
)

(defn hyblendcolors [colors]
    "blends two or more hex colors into one"
    (setv r (int (/ (reduce + (map (fn [c] (extractor 1 c)) colors)) (len colors))))
    (setv g (int (/ (reduce + (map (fn [c] (extractor 3 c)) colors)) (len colors))))
    (setv b (int (/ (reduce + (map (fn [c] (extractor 5 c)) colors)) (len colors))))
    (hyhex r g b)
)

; tests

(print (= "#FF6347" (hyhex 255 99 71)))
(print (= "#B8860B" (hyhex 184 134 11)))
(print (= "#BDB76B" (hyhex 189 183 107)))
(print (= "#0000CD" (hyhex 0 0 205)))
(try 
    (hyhex 0 0 300)
    (print False)
    (except [TypeError](print True))
)

(try 
    (hyhex 0 0 -1)
    (print False)
    (except [TypeError](print True))
)


(print (= (hyblendcolors ["#000000" "#778899"]) "#3B444C"))
(print (= (hyblendcolors ["#E6E6FA" "#FF69B4" "#B0C4DE" ]) "#DCB1D9"))