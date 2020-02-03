#!/usr/bin/python3

import asyncio
import os
import json
import sys


socket = os.environ['SWAYSOCK']

magic_string = 'i3-ipc'
magic_string_len = len(magic_string)

message_types = {
	'RUN_COMMAND': 0,
	'GET_WORKSPACES': 1,
	'SUBSCRIBE': 2,
	'GET_OUTPUTS': 3,
	'GET_TREE': 4,
	'GET_MARKS': 5,
	'GET_BAR_CONFIG': 6,
	'GET_VERSION': 7,
	'GET_BINDING_MODES': 8,
	'GET_CONFIG': 9,
	'SEND_TICK': 10,
	'SYNC': 11,
	'GET_INPUTS': 100,
	'GET_SEATS': 101,
}


async def send_command(message_type, command=''):
	payload_type = message_types[message_type.upper()]
	payload_length = len(command)

	data = magic_string.encode()
	data += payload_length.to_bytes(4, sys.byteorder)
	data += payload_type.to_bytes(4, sys.byteorder)
	data += command.encode()

	(reader, writer) = await asyncio.open_unix_connection(path=socket)
	writer.write(data)
	return reader

async def get_response(reader):
	header = await reader.read(magic_string_len + 8)
	size = int.from_bytes(header[magic_string_len : magic_string_len + 4], sys.byteorder)
	return (await reader.read(size)).decode()

async def get_response_json(reader):
	response = await get_response(reader)
	return json.loads(response)

async def run_command(message_type, command=''):
	reader = await send_command(message_type, command)
	return await get_response(reader)

async def run_command_json(message_type, command=''):
	reader = await send_command(message_type, command)
	return await get_response_json(reader)

async def get_outputs():
	return sorted(await run_command_json('get_outputs'), key = lambda o : o['rect']['x'])
