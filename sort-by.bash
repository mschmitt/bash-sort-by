if [[ ${BASH_VERSINFO[0]} -lt 4 ]] 
then
	printf "Bash ≥ 4 is required.\n"
	exit 1
fi

function sort-by {
	# sort-by is a wrapper to sort things by arbitrary sorting criteria.

	# Sort criteria are passed as regex in the function arguments, e.g.: 
	# sort-by "backend" "(fe|frontend)" "db" < serverlist.txt
	local sort_order=("${@}")
	
	# Pre-sort and read entire input into array
	declare -a input
	while read -r line
	do
		input+=("${line}")
	done < <(sort)

	# Prepare output buckets 
	# (per order expression)
	declare -A output
	# (remaining lines)
	declare -a remaining

	# Sort into each bucket
	for line in "${input[@]}"
	do
		local line_matched='no'
		for expression in "${sort_order[@]}"
		do 
			if [[ "${line}" =~ ${expression} ]]
			then
				# Append to output bucket for this expression
				printf -v output["${expression}"] "%s%s\n" "${output["$expression"]}" "${line}"
				line_matched='yes'
				break
			fi
		done
		if [[ "${line_matched}" == 'no' ]]
		then
			printf -v remaining "%s%s\n" "${remaining}" "${line}"
		fi
	done

	# Show output
	for expression in "${sort_order[@]}"
	do 
		printf "%s" "${output["$expression"]}"
	done
	printf "%s" "${remaining}"
}

# vim: filetype=sh
