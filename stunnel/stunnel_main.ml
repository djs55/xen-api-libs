(*
 * Copyright (C) Citrix Systems Inc.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published
 * by the Free Software Foundation; version 2.1 only. with the special
 * exception on linking described in file LICENSE.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *)

let _ =
	let host = ref "" in
	let port = ref (-1) in
	Arg.parse [ 
		"-h", Arg.Set_string host, "hostname to connect to";
		"-p", Arg.Set_int port, "port to connect to"
	] (fun x -> Printf.fprintf stderr "Skipping argument: %s" x)
		"Establish a secure tunnel to a remote destination";
	let host = !host and port = !port in
	Stunnel.init_stunnel_path ();
	let x = Stunnel.Tunnel.create host port in
	Printf.printf "Local port: %d; pid = %d" x.Stunnel.Tunnel.local_port x.Stunnel.Tunnel.pid
