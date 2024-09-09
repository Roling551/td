extends Node
class_name AssignPopulationAlgorithms

static func assign_equally(population_container: PopulationContainer, resources_container: ResourcesContainer, buildings):
	var group = population_container.citizen_groups["settlers"]
	var avaliable_population = group.avaliable_population
	
	for building in buildings:
		if building.building_components.has("population"):
			building.building_components["population"].reset_population()

	Util.divide_integer_resource_proportianlly_to_request(
		avaliable_population,
		buildings,
		func(requester): 
			if requester.building_components.has("population"):
				return requester.building_components["population"].max_population
			else:
				return 0,
		func(requester, to_assign):
			if requester.building_components.has("population"):
				requester.building_components["population"].assign_population(GroupPart.new(group, to_assign))
	)
