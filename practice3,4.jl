#Написать функцию с заголовком findallmax(A::AbstractVector)::AbstractVector{Int}, возвращающую вектор индексов всех элементов массива A, имеющих максимальное значение. Алгоритм должен быть однопроходным, т.е. иметь асимптотическую оценку вычислительной сложности O(n).
function findallmax(a)
    i_max=Vector{Int}(undef,size(a))
    i_max[begin]=firstindex(a)
    n = firstindex(i_max)
    for i in firstindex(a)+1:lastindex(a)
        if A[i]>A[i_max[end]]
            i_max[begin]=i
            n = firstindex(i_max)
        elseif A[i]==A[i_max[end]]
            n+=1
            i_max[n]=i
        end
    end
    return resize!(i_max,n)
end


#Задача 5 Написать функцию с заголовком возвращающую соответствующий срез неокоторого одномерного массива A.
function slice(A::Vector{T},p::Vector{Int})::Vector{T} where T
    return A[p]
end

#Задача 6 Пусть perm - это некоторый вектор перестановок индексов одномерного массива A. Написать свою реализацию встроенной функции permute!(A, perm), реализующую соответствующее премещение элементов массива A на месте (in-plice), т.е. без копирования их в новый массив . (Cвой вариант этой функции можно назвать permute_!).

function permute!(A::Vector{T},perm::Vector{Int})::Vector{T} where T
    return slice(A,perm);
end

#Задача 7 Реализовать встроенные функции вставки/добавления (deleteat!, insert!) элемента массива
function deleteat!(A::Vector{T},i::Int)::Vector{T} where T
    new_A=Array{Int}(undef,length(A)-1)
    j=1
    k=1
    while (j<length(A))
        if k!=i
            new_A[j]=A[k]
            j+=1
        end
        k+=1
    end
    return new_A
end

function insertat!(A::Vector{T},i::Int,value::T)::Vector{T} where T
    new_A=Array{Int}(undef,length(A)+1)
    j=1
    k=1
    while (j<=length(new_A))
        if k==i
            new_A[j]=value
            k-=1
            i=-1
        else
            new_A[j]=A[k]
        end
        k+=1
        j+=1
    end
    return new_A
end