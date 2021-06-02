#Задача 1. Написать функцию pow(a, n::Integer), возвращающую значение a^n, и реализующую алгоритм быстрого возведения в степень.
function pow(a, n::Integer)
    k, t, p = n, 1, a
    while k>0
        if (k%2 == 0)
            k÷=2
            p*=p
        else
            k-=1
            t*=p
        end   
    end
return t
end

#Задача 2. Написать функцию fibonacci(n::Intrger), возвращающую n-ое число последовательности Фибоначчи, имеющую оценку алгоритмической сложности O(log(n)), и не используя известную формулу Бине.
function fibonacci(n::Integer)
    a,b,c=1,1,1
    rc,d,rd = 0,0,1
    while (n>0)
        if (n%2!=0)
            tc = rc
            rc = rc*a + rd*c
            rd = tc*b + rd*d
        end
        ta,tb,tc=a,b,c
        a = a*a  + b*c
        b = ta*b + b*d
        c = c*ta + d*c
        d = tc*tb+ d*d
        n >>= 1
    end
    return rc
end

#Задача 3. Написать функцию log(a::Real,x::Real,ε::Real), реализующую приближенное вычисление логарифма по основанию a>1 числа x>0 с максимально допустимой погрешностью ε>0 (без использования разложения логарифмической функции в степенной ряд).
function log(a::Real,x::Real,ε::Real)
    z, t, y = x, 1, 0
    while (z>a || z<1/a || t>ε)
        if (z>a)
            z/=a
            y+=t
        elseif (z<1/a)
            z*=a
            y-=t
        else
            t/=2
            z*=z
        end
    end
    return y
end

#Задача 4. Написать функцию isprime(n)::Bool, возвращающую значение true, если аргумент есть простое число, и - значение false, в противном случае. При этом следует иметь ввиду, что число 1 простым не считается.
function isprime(n::Int)::Bool
    d=2
    while (d*d<=n)
        if (n%d==0)
            return false
        end
        d+=1
    end
    return true
end

#Задача 5. Написать функцию eratosphen(n), возвращающую вектор всех простых чисел, не превосходящих заданного натурального числа n.
function eratosphen(n::Integer)
    ser=fill(true,n)
    ser[1]=false
    k=2
    while k<n || k !== nothing
        ser[2k:k:end] .= false # но лучше: numser[k^2:k:end] .= false
        k=findnext(ser, k+1)
    end
    return findall(ser)
end

#Задача 8. Самостоятельно написать подобную функцию, реализующую расширенный алгоритм Евклида.
function gcdx(m::Int,n::Int)
    a, b = m, n
    u_a, v_a = 1, 0
    u_b, v_b = 0, 1
    while b != 0
        k = a÷b
        a, b = b, a % b 
        u, v = u_a, v_a
        u_a, v_a = u_b, u_a
        u_b, v_b = u-k*u_b, v-k*v_b
    end
    if u_a<0
        u_a+=n
    end
    return u_a
end

#Задача 9 Написать функцию inv(m::Integer,n::Integer) возвращающий обратный элемент к значению m в кольце вычетов по модулю n (см. лекцию 3). При этом, если значение n не обратимо, то должно возвращаться значение nothing.
function inv(m::Integer,n::Integer)
    if (gcd(m,n)>1)
        return nothing
    else
        return gcdex(m,n)
    end
end

#Задача 10 Написать функцию zerodivisors(m), возвращающую все делители нуля кольца вычетов по заданному модулю $n$.
function zerodivisors(n::Integer)
    v = [1]
    for i in 2:n
        if (gcd(n,i)==1)
                push!(v,i)
        end
    end
    return v
end

#Задача 12 Написать функцию ord(a,p), возвращающую порядок заданного элемента a мультипликативной группы кольца вычетов по заданному простому модулю p.
function order(a,p)
    phi = p-1
    res = 0
    for i in 1:(p-1)
        if (phi%i==0 && (a^i)%p==1)
            res = i
            break
        end
    end
    return res
end