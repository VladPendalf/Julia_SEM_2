ConnectList{T}=Vector{Vector{T}}
#Задача 1 Написать и протестировать функцию, получающую на вход список смежностей некоторого графа, и возвращающую вектор индексов его вершин, полученных в порядке поиска в глубину.
function dfs_(startver::T, graph::ConnectList{T}) where T
    mark = zeros(Bool, length(graph))
    stack  = [startver]
    mark[startver] = 1
    visited = Int64[]
    while !isempty(stack)
        v = pop!(stack)
        push!(visited,v)
        for u in graph[v]
            if mark[u] == 0
                push!(stack,u)
                mark[u] = 1
            end
        end
    end
    return visited
end

#Задача 2 Написать и протестировать функцию, получающую на вход список смежностей некоторого графа, и возвращающую вектор индексов его вершин, полученных в порядке поиска в ширину
function bfs_(startver::T, graph::ConnectList{T}) where T
    mark = zeros(Bool, length(graph))
    queue  = [startver]
    mark[startver] = 1
    visited = Int64[]
    while !isempty(queue)
        v = popfirst!(queue)
        push!(visited,v)
        for u in graph[v]
            if mark[u] == 0
                push!(queue, u)
                mark[u] = 1
            end
        end
    end
    return visited
end

#Задача 3 Написать и протестировать функцию, получающую на вход список смежностей некоторого графа, и возвращающую вектор валентностей его вершин по выходу.
function valentce(graph::ConnectList{T}) where T
    val = zeros(size(graph,1))
    for i in 1:size(graph,1)
        val[i]=length(graph[i])
    end
    return val
end

#Задача 10 Написать и протестировать функцию, получающую на вход список смежностей некоторого графа и индексы каких-либо двух его вершин, и возвращающую кратчайший путь из первой вершины во вторую в виде вектора из индексов последовательности вершин, через которые проходит этот путь.
function dist(start_ver::T, finish_ver::T, graph::ConnectList{T}) where T
    len = length(graph)
    dist = Array{Array{Int,1}}(undef,n)
    for i in 1:len
        dist[i] = []
    end
    queue  = [start_ver]
    dist[start_ver] = [start_ver]
    while !isempty(queue)
        v = popfirst!(queue)
        if v == finish_ver 
            return dist[v] 
        end
        for u in graph[v]
            if dist[u] == []
                push!(queue, u)
                dist[u] = push!(copy(dist[v]),u)
            end
        end
    end
end