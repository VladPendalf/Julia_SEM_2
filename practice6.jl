#Задача 1. Написать функцию, получающую 2 отсортированных массива A и B, и объединяющую их в одном отсортированном массиве C (length(C)=length(A)+length(B)=n). Алгоритм должен иметь оценку сложности O(n). Функцию можно назвать merge. Реализовать 2 варианта этой функции:
function merge(A::Vector{T},B::Vector{T})::Vector{T} where T
    i,j=1,1
    v = Array{Int}(undef,length(A)+length(B))
    for k in 1:(length(A)+length(B))
        if (i!=length(A)+1 && (j==length(B)+1 || A[i]<B[j]))
            v[k]=A[i]
            i+=1
        elseif (j!=length(B)+1)
            v[k]=B[j]
            j+=1
        end
    end
    return v
end

#Задача 2 Написать функцию, выполняющую частичную сортировку. А именно, функция получает некоторый массив A и некоторое значение b, и переставляет элементы в массивае A так, что бы в нём сначала шли все элементы, меньшие b, затем - все, равные b, и затем, наконец, - все большие b. Алгоритм должен иметь оценку сложности O(n). Реализовать следующие 2 варианта этой функции:
function sort(A::Vector{T},b::Int64)::Vector{T} where T
    res = copy(A)
    move = 1
    for i in 1:length(A)
        if res[i]<=b
            res[move+1:i],res[move]=res[move:i-1],res[i]
            if res[move]<b
                move = move + 1
            end
        end
    end
    return res
end

#a) c использованием 3-х вспомогательных массивов (с последующим их объединением в один)
function sort_a(A::Vector{T},b::Int64)::Vector{T} where T
    arr1 = Vector{Int}(undef,0)
    arr2 = Vector{Int}(undef,0)
    arr3 = Vector{Int}(undef,0)
    for a in A
        if (a<b)
            push!(arr1,a)
        elseif (a==b)
            push!(arr2,a)
        elseif (a>b)
            push!(arr3,a)
        end
    end
    return append!(append!(arr1,arr2),arr3)
end

#Задача 3 Написать функцию, выполняющую частичную сортировку. А именно, функция получает некоторый массив A и некотрое значение b, и переставляет элементы в массивае A так, чтобы в нём сначала шли все элементы, меньшие или равные b, а затем - все большие b. Алгоритм должен иметь оценку сложности O(n).
function sort_(A::Vector{T},b::Int64)::Vector{T} where T
    arr1 = Vector{Int}(undef,0)
    arr2 = Vector{Int}(undef,0)
    for a in A
        if (a<=b)
            push!(arr1,a)
        else
            push!(arr2,a)
        end
    end
    return append!(arr1,arr2)
end

