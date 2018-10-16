function fish_prompt --description "Sets the Fish Shell prompt"
	 ~/go/bin/powerline-go \
#	Usage of powerline-go:
#		-colorize-hostname
#			Colorize the hostname based on a hash of itself
#		-cwd-max-depth int
#			Maximum number of directories to show in path
#				(default 5)
#		-cwd-max-dir-size int
#			Maximum number of letters displayed for each directory in the path
#				(default -1)
#		-cwd-mode string
#			How to display the current directory
#				(valid choices: fancy, plain, dironly)
#				(default "fancy")
#		-duration string
#			The number of wall-clock seconds elapsed for the previous command.  May be an integer (whole seconds) or floating point (seconds and fractions of a second).
#		-east-asian-width
#			Use East Asian Ambiguous Widths
#		-error int
#			Exit code of previously executed command
		-error $status \
#		-ignore-repos string
#			A list of git repos to ignore. Separate with ','.
#				Repos are identified by their root directory.
#		-max-width int
#			Maximum width of the shell that the prompt may use, in percent. Setting this to 0 disables the shrinking subsystem.
#		-mode string
#			The characters used to make separators between segments.
#				(valid choices: patched, compatible, flat)
#				(default "patched")
		-mode "flat" \
#		-modules string
#			The list of modules to load, separated by ','
#				(valid choices: aws, cwd, docker, dotenv, duration, exit, git, gitlite, hg, host, jobs, load, nix-shell, perlbrew, perms, root, shell-var, ssh, termtitle, time, user, venv, node)
#				(default "venv,user,host,ssh,cwd,perms,git,hg,jobs,exit,root")
		-modules "docker,ssh,cwd,gitlite,hg,jobs,root" \
#		-newline
#			Show the prompt on a new line
#		-numeric-exit-codes
#			Shows numeric exit codes for errors.
#		-path-aliases string
#			One or more aliases from a path to a short name. Separate with ','.
#				An alias maps a path like foo/bar/baz to a short name like FBB.
#				Specify these as key/value pairs like foo/bar/baz=FBB.
#				Use '~' for your home dir. You may need to escape this character to avoid shell substitution.
#		-priority string
#			Segments sorted by priority, if not enough space exists, the least priorized segments are removed first. Separate with ','
#				(valid choices: aws, cwd, cwd-path, docker, duration, exit, git-branch, git-status, hg, host, jobs, load, nix-shell, perlbrew, perms, root, ssh, time, user, venv, node)
#				(default "root,cwd,user,host,ssh,perms,git-branch,git-status,hg,jobs,exit,cwd-path")
#		-shell string
#			Set this to your shell type
#				(valid choices: bare, bash, zsh)
#				(default "bash")
		-shell "bare"
#		-shell-var string
#			A shell variable to add to the segments.
#		-shorten-gke-names
#			Shortens names for GKE Kube clusters.
#		-theme string
#			Set this to the theme you want to use
#				(valid choices: default, low-contrast)
#				(default "default")
#		-truncate-segment-width int
#			Minimum width of a segment, segments longer than this will be shortened if space is limited. Setting this to 0 disables it.
#				(default 16)
end
