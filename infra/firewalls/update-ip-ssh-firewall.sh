#!/bin/bash

set -eu

source ./utils/logger.sh
source ./utils/prompt.sh
source ./utils/path.sh

##
# Updates source IPs in a JSON firewall rules file
#
# @param json_file Path to the JSON file
# @param new_ip New IP address in CIDR format (e.g., "192.168.1.1/32")
# @return Modifies file in place, returns 0 on success
# @example
#   update_json_source_ips "firewall-rules.json" "192.168.1.100/32"
##
function update_json_source_ips() {
   local json_file="$1"
   local new_ip="$2"

   # Use jq to replace the source_ips array with the new IP
   # jq breakdown:
   # --arg new_ip "$new_ip"  : Pass shell variable as jq variable
   # '.[0]'                  : Access first element of root array
   # '.source_ips'           : Access the source_ips property
   # '= [$new_ip]'          : Assign new array with single element
   # Full: '.[0].source_ips = [$new_ip]' means "set source_ips of first object to array containing new_ip"
   jq --arg new_ip "$new_ip" \
      'del(.[0].source_ips) | .[0].source_ips = [$new_ip]' \
      "$json_file" > "${json_file}.tmp" && mv "${json_file}.tmp" "$json_file"
}

function run() {
   script_dir=$(get_absolute_path)
   json_file=$script_dir/files/firewall-rules.json

   logger DEBUG "script dir: ${script_dir}"
   logger DEBUG "previous JSON file: ${json_file}"
   logger DEBUG "firewall to be changed: ${FIREWALL_NAME}"

   cat $json_file

   current_ip="$(curl https://ipinfo.io/ip)/32"

   logger DEBUG "current ip: ${current_ip}"

   update_json_source_ips $json_file $current_ip

   logger DEBUG "updated file with current ip"

   cat $json_file

   if confirm; then
      logger INFO "Proceeding with hcloud update"
      hcloud firewall replace-rules $FIREWALL_NAME --rules-file $json_file
   else
      logger INFO "Cancelled operation"
      exit 1
   fi
}

run

logger INFO "DONE"

