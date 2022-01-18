program bruh

implicit none

real(8) :: x,y, pi
integer(4) :: n, nmax, nlines

pi = 4.0*atan(1.0)
open(unit=69,file='exact.dat')
open(unit=420, file='approx.dat')

write(*,*) 'Enter the number of terms you would like (n)'
read(*,*) nmax

write(*,*) 'Enter the number of series below n you would like displayed (0 -> n only)'
read(*,*) nlines

do x = 0, 2*pi, 0.001
    !Piecewise function
    if(0 <= x .AND. x <= pi) THEN
        write(69, *) x, x
    else
        write(69, *) x, x - 2*pi
    end if  

    !Fourier series approximation, n terms
    !nlines -> number of approximations below n run
    y = 0
    do n=1,nmax
        y = y + 2 * ((-1)**(n+1)) * sin(n*x) / n
        if (nmax - nlines <= n .AND. n <= nmax) then
            write(420, *) x, y
        end if
    end do
end do

close(69)
close(420)


end program bruh

!Use ./plot.sh to run the program