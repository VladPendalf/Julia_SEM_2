#Задача 3 Реализовать алгоритм сортировки методом пузырька, написав следующие 4 обобщенные функции: bubblesort, bubblesort!, bubblesortperm, bubblesortperm!, по аналогии со встоенными функциями sort!, sort, sortperm!, sortperm, ограничившись только случаем, когда входной параметр есть одномерный массив (вектор).
function bubblesort!(a)
    len = length(a)
    for k in 1:len-1
        fl = false 
        for i in 1:len-k
            if a[i]>a[i+1]
                a[i], a[i+1] = a[i+1], a[i]
                fl = true
            end
        end
        if fl == false
            break
        end
    end
    return a
end

bubblesort(a)=bubblesort!(deepcopy(a))

function bubblesortperm!(a)
    len = length(a)
    ind = collect(1:len)
    for k in 1:len-1
        fl = false
        for i in 1:len-k
            if a[i]>a[i+1]
                a[i],a[i+1]=a[i+1],a[i]
                ind[i],ind[i+1]=ind[i+1],ind[i]
                fl = true
            end
        end
        if fl == false
            break
        end
    end
    return ind
end

bubblesortperm(a)=bubblesortperm!(deepcopy(a))

#Задача 4 На основе разработанных в пункте 1 функций, сотрирующих одномерный массив, написать соответствующие функции, которые бы могли получать на вход матрицу, и сортировать каждый из ее столбцов по отдельности. Имена функций оставить прежними, что были и в пункте 1, воспользовавшись механизмом множественной диспетчеризации языка Julia.
function bubblesort!(A::Matrix)
    for i in size(A,2)
        bubblesort!(@view A[:,i]) 
    end
    return A
end

bubblesort(A::Matrix)=bubblesort!(deepcopy(A))

function bubblesortperm!(A::Matrix)
    ind=Matrix{Int}(undef,size(A)) 
    for i in size(A,2)
        ind[:,i]=bubblesortperm!(@view A[:,i]) 
    end
    return ind
end

bubblesortperm(A::Matrix)=bubblesortperm!(deepcopy(A))

#Задача 5 Написать функцию sortkey!(a, key_values), получающую на вход некоторый вектор a, и соответствующий вектор keyvalues ключевых значений элементов вектора a, осуществляющую сортировку вектора a по ключевым значениям его элементов, и возвращающую ссылку на вектор a. (Для сортировки вектора ключевых значений можно востпользоваться одной из разработанных в пункте 1 функций, или соответствующей встроенной функцией).
function sortkey!(key_values, a)
    ind = sort_bubble_perm!(key_values)
    return @view a[ind]
end

#Задача 6 Написать функцию calcsort, реализующую сортировку методом подсчета числа значений. Рассмотреть 2 варианта функции (2 метода - в терминологии Julia): в первом варианте возможные значения элементов сортируемого массива задаются некоторым диапазоном, во втором - некоторым отсортированным массивом (вектором).
function calcsort(a, diap::NTuple{2, Int})
    left_border, right_border = diap
    nums_count = right_border - left_border + 1
    nums = zeros(Int, nums_count)
    for i in a
        nums[i - left_border + 1] += 1 
    end
    my_ans = []
    for i in 1:(right_border - left_border + 1)
        for j in 1:nums[i]
            push!(my_ans, i + left_border - 1)
        end
    end
    return my_ans 
end

function calcsort(a, diap::Vector{Int})
    nums = Dict{Int64, Int64}()
    for i in a
        nums[i]= get(nums, i, 0) + 1
    end
    my_ans = []
    for i in sort(collect(keys(nums)))
        to_push = [i for j in 1:nums[i]]
        push!(my_ans, to_push...)
    end
    return my_ans 
end

#Задача 7 Написать функции insertsort!, insertsort, insertsortperm, insertsortperm! (по аналогии с пунктом 1) реализующие алгоритм сортировки вставками
function insertsort!(a)
    len = length(a)
    for i in 2:len
        j = i - 1
        while j > 0 && a[j] > a[j + 1]
            a[j+1], a[j] = a[j], a[j+1]
            j -= 1
        end 
    end
    return a    
end

insertsort(a) = insertsort!(copy(a))

function insertsortperm!(a)
    len = length(a)
    arr = []
    for i in 1:len
        push!(arr, i)
    end
    for i in 2:len
        j = i - 1
        while j > 0 && a[j] > a[j + 1]
            a[j+1], a[j] = a[j], a[j+1]
            arr[j+1], arr[j] = arr[j], arr[j + 1]
            j -= 1
        end 
    end
    return arr
end

insertsortperm(a) = insertsortperm!(copy(a))

#Задача 8 Реализовать ранее написанную функцию insertsort! с помощью встроенной функции reduce
insertsort!(A)=reduce(1:length(A))do _, k # в данном случае при выполнении операции вставки  первый аргумент фуктически не используется
    while k>1 && A[k-1] > A[k]
        A[k-1], A[k] = A[k], A[k-1]
        k-=1
    end
    return A
end