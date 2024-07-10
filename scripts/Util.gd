extends Node
class_name Util

static func setAnchorFullRect(control: Control):
	control.anchor_left = 0
	control.anchor_right = 1
	control.anchor_top = 0
	control.anchor_bottom = 1

static func divide_list_into_requesters(
	array_to_divide,
	divided_elements,
	left_out_array,
	requesters,
	get_requested_amount,
	assign_request
):
	var whole_needed_amount = 0
	for requester in requesters:
		whole_needed_amount += get_requested_amount.call(requester)
	if array_to_divide.size() >= whole_needed_amount:
		left_out_array.append_array(array_to_divide.slice(whole_needed_amount))
		divided_elements.append_array(array_to_divide.slice(0, whole_needed_amount))
		var assigned_num = 0
		for requester in requesters:
			var to_assign = array_to_divide.slice(assigned_num, assigned_num + get_requested_amount.call(requester))
			assign_request.call(requester, to_assign)
			assigned_num += to_assign.size()
	else:
		divided_elements.append_array(array_to_divide)
		var assigned_num = 0
		for requester in requesters:
			var to_assign_num = floor(array_to_divide.size() * get_requested_amount.call(requester) / whole_needed_amount)
			assign_request.call(requester, array_to_divide.slice(assigned_num, assigned_num + to_assign_num))
			assigned_num += to_assign_num
		for requester in requesters:
			if assigned_num == array_to_divide.size():
				break
			assign_request.call(requester, array_to_divide.slice(assigned_num, assigned_num+1))
			assigned_num += 1

static func divide_resource_proportianlly_to_request(
	resource_amount,
	requesters,
	get_requested_amount,
	assign_request
):
	var whole_needed_amount = 0
	for requester in requesters:
		whole_needed_amount += get_requested_amount.call(requester)
	if whole_needed_amount > resource_amount:
		for requester in requesters:
			assign_request.call(requester, get_requested_amount.call(requester)*resource_amount/whole_needed_amount)
		return 0
	else:
		for requester in requesters:
			assign_request.call(requester, get_requested_amount.call(requester))
		return resource_amount - whole_needed_amount
	
static func get_avg(
	array,
	get_amount
):
	if array.size() == 0:
		return 0
	var sum = 0
	for item in array:
		sum += get_amount.call(item)
	return sum / array.size()
	
