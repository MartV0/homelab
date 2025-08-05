{ config, lib, ... }:
{
  age.secrets.isso-admin-passwd.file = ./../secrets/isso-admin-passwd;

  services.isso = {
    enable = true;
    settings = {
      general = {
        dbpath = "/var/lib/isso/comments.db";
        host = ''
	  http://martijnv.com
	  https://martijnv.com
	'';
      };
      server = {
        listen = "http://localhost:8123";
      };
      admin = {
      	enabled = true;
	# No the proper (age)nix way to do this, this will store the password unencrypted
	# in the nix store. But the isso config does not have a config file option.
	password = lib.removeSuffix "\n"
	         (builtins.readFile config.age.secrets.isso-admin-passwd.path);
      };
    };
  };
}
