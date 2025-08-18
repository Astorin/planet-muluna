local Public = {}

local space_graph = {}
local function update_graph(prototype_list)

    do
        for _, conn in pairs(prototype_list) do
            if not space_graph[conn.from] then space_graph[conn.from] = {} end
            if not space_graph[conn.to] then space_graph[conn.to] = {} end

            -- Assuming bidirectional travel
            space_graph[conn.from][conn.to] = conn.length
            space_graph[conn.to][conn.from] = conn.length
        end
    end

end

-- if Muluna.stage == "control" then
--     -- Prebuild adjacency list from space connections (done once at load time)
--     update_graph(prototypes.space_connection)
-- end




--- Shortest path calculation using prebuilt graph
-- Vibe-coded, but seems to work well.
function Public.shortest_space_distance(start_name, end_name)
    if Muluna.stage == "data" then -- If in data stage, update graph with every execution, since the contents of space-connections can change over time.
        update_graph(data.raw["space-connection"])
    end
    -- Dijkstra's algorithm
    local dist = {}
    local visited = {}
    for node in pairs(space_graph) do
        dist[node] = math.huge
        visited[node] = false
    end
    dist[start_name] = 0

    while true do
        -- Find closest unvisited node
        local min_node = nil
        local min_dist = math.huge
        for node, d in pairs(dist) do
            if not visited[node] and d < min_dist then
                min_dist = d
                min_node = node
            end
        end

        if not min_node then break end -- No reachable node left
        if min_node == end_name then return dist[min_node] end -- Found shortest distance

        visited[min_node] = true

        for neighbor, length in pairs(space_graph[min_node]) do
            if not visited[neighbor] then
                local new_dist = dist[min_node] + length
                if new_dist < dist[neighbor] then
                    dist[neighbor] = new_dist
                end
            end
        end
    end

    return nil -- No path found
end

return Public