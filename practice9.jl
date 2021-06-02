#Задача 1 Написать функцию, вычисляющую n-ую частичную сумму ряда Тейлора функции cos(x)=1-...
function T1(n,x)
    sum=1
    fact=1
    for i in 1:n
        fact*=i
        if (i%2==0)
            sum+=(((-1)^((i/2)%2))*(x^i))/fact
        end
    end
    return sum
end

#Задача 2 Написать функцию, вычисляющую значение суммы ряда Тейлора функции cos(x) в заданной точке с машинной точностью.
function T2(x,ε)
    sum=1
    fact=1
    i=1
    a=1
    while (abs(a)>ε)
        fact*=i
        if (i%2==0)
            a=(((-1)^((i/2)%2))*(x^i))/fact
            sum+=a
        end
        i+=1
    end
    return sum
end

#Задача 6 Написать функцию linsolve(A,b), получающую на вход невырожденную квадратную верхнетреугольную матрицу A (матрицу СЛАУ, приведенную к ступенчатому виду), вектор-столбец b (правую часть СЛАУ), и возвращающую решение соответствующей СЛАУ.

function linsolve(A,b)
    for i in length(A):-1:1
        for j in 1:i-1
            b[j]-=(A[j][i]/A[i][i])*b[i]
            A[j][i]=0
        end
    end
    for i in 1:length(A)
        println("x",i," = ",b[i]/A[i][i])
    end
end

#Задача 8. Написать функцию det(A), получающую на вход квадратную матрицу, и возвращающую значение её определителя.
function issingular_convert!(A)
    for k in firstindex(A,1):lastindex(A,1)
        imax = argmax(mod, @view A[k:end,k])       
        if isappoxzero(A[i,k])
            return nothing
        end
        colon_to_zeros!(A,k,imax)
    end
end

#Задача 10 Написать функцию rang(A), получающую на вход матрицу (вообще говоря, прямоугольную), и возвращающую её ранг.

function rang(Ab)
    B=copy(Ab)
    rang = length(B)
    while (det_(B)==0 && rang!=1)
        rang-=1
        B=B[1:rang]
    end
    return rang
end