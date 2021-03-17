onestep(X,Y, byCar, C) :- byCar(X,Y,C).
onestep(X,Y, byTrain, C) :- byTrain(X,Y,C).
onestep(X,Y, byPlane, C) :- byPlane(X,Y,C).

travel(X,Y, go(X,Y, Transport),C) :- onestep(X,Y,Transport,C).
travel(X,Y, go(X,Z, Transport, Path), T) :- onestep(X,Z,Transport,A), travel(Z,Y,Path, C), T is +(A,C).


byCar(auckland,hamilton,103).
byCar(hamilton,raglan,42).
byCar(valmont,saarbruecken,36).
byCar(valmont,metz,38).
byTrain(metz,frankfurt,31).
byTrain(saarbruecken,frankfurt,60).
byTrain(metz,paris,84).
byTrain(saarbruecken,paris,120).
byPlane(frankfurt,bangkok,600).
byPlane(frankfurt,singapore,720).
byPlane(paris,losAngeles,780).
byPlane(bangkok,auckland,840).
byPlane(singapore,auckland,590).
byPlane(losAngeles,auckland,820).