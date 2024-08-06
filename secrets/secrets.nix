let
  tht = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO1TqzsM18I70A0XhmBjYhryhkRFdGl6ofup92N3XNyC";
  users = [tht];

  ikaros = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICGFH9s1KhZjTIlxtFcqVwOS1xiNshJHyMTbUBxh0K9i";
  ace = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPIQLoPoEUW1Wy1Ta1/5hN187m2BSPtzdX5JqTXeJSrc";
  systems = [ikaros ace];
in {
  "cloudflare_stuff.age".publicKeys = users ++ systems;
  "pass.age".publicKeys = users ++ systems;
}
