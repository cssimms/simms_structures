require_relative 'graph'

# O(|V|**2 + |E|).
def dijkstra1(source)
  shortest_paths = { source => {cost: 0} }
  possible_paths = Hash.new(Float::INFINITY)
  possible_paths[source] = 0

  until possible_paths.empty?
    vertex, cost = possible_paths.min_by(&:last)
    shortest_paths[vertex] = { cost: cost }
    possible_paths.delete(vertex)

    vertex.out_edges.each do |edge|
      next_vertex, next_cost = edge.to_vertex, edge.cost

      next if shortest_paths[next_vertex]

      next_cost = [possible_paths[vertex], cost + next_cost].min
      possible_paths[next_vertex] = next_cost
    end
  end

  shortest_paths
end
