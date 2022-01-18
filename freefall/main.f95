program freefall

implicit none    

!Declare variables
real(8) :: y, dt, v_0, y_0, a, last_v, last_y, v, t, pi, C_d, rho, r, m, atot
!integer(4) :: n

!Open data files
open(unit = 69, file="velocity.dat")
open(unit = 420, file = "position.dat")
open(unit = 666, file = "acceleration.dat")

!Initialize variables
y_0 = 100
v_0 = -3.8
a = -9.8 !0.9084
dt = 0.05
t = 0 !0.45
last_y = y_0
last_v = v_0
pi = 4*atan(1.0)

!Drag
r = 0.037 !m
C_d = 0.47 !?
rho = 1.2754 !kg/m^3
m = 0.15 !kg

!Write initial values to the files
write(69, *) t, v_0
write(420, *) t, y_0
write(666, *) t, a

do while(y >= 0)
    t = t + dt !Step t up once
    
    !Update v and y
    atot = a - 1/ (2*m) * C_d * pi * r**2 * rho * last_v * abs(last_v)
    v = atot*dt + last_v 
    !Euler's method (a doesn't change)
    y = 0.5*(last_v + v)*dt + last_y !Midpoint method 

    !Write all the values
    write(69, *) t, v
    write(420, *) t, y 
    write(666, *) t, atot

    !Save v and y values for the next iteration
    last_v = v 
    last_y = y
end do


end program