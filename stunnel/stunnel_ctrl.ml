
type t = 
	| Stat of string * int
	| Nothing
let _ =
	let socket = ref "/tmp/control-socket" in
	let cmd = ref Nothing in

	let arg_stat x = 
		Scanf.sscanf x "%s@:%d"
			(fun ip port ->
				cmd := Stat(ip, port)
			) in

	Arg.parse [
		"-socket", Arg.Set_string socket, "stunnel control socket";
 		"-stat", Arg.String (fun x -> arg_stat x), "stat <ip:port>"; 
	]
		(fun x -> Printf.fprintf stderr "Ignoring argument: %s\n" x)
		"send a control message to stunnel";
	match !cmd with
		| Nothing -> ()
		| Stat (ip, port) ->
			let ip', port' = Stunnel.stat !socket ip port in
			Printf.printf "%s:%d -> %s:%d\n" ip' port' ip port

