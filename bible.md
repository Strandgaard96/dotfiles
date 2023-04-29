# Things that I learn on the way 


Python
----


Bash/sh syntax
----


### Useful commands

**Important fommand for converting to mol files**
```console
amsreport adf.rkf SDF > traj.mol
```


=======
**Remove columns in file**
```console
colrm 4 14 < backup.crds > newfile.xyz
# Remove columns 4 to 14 in backup.crds file and write to newfile.xyz
```


```console
tree # Shows a neet directory tree
```


**Brace expansion**
```console
{a,b}.out will print a.out and b.out
```


**Command for copying files of specific type into another directory, maintaining the tree structure**

```console
find . -name '*.log' -exec cp --parents {} ../logfiles \;
# First it finds the files. 
# exec then performs an action based on these files
# --parents keep the tree structure
# "\;" is the escape character that feeds the ; which ends the exec command. 
# {} insert the currently found file name with parent directories
```

**Navigation**
```console
** Cursor control in command line
ctrl+w deletes the word before the cursor
ctrl+u deletes whole line before cursor
ctrl+a/e for beginning/end of line
```
alt-shift-hash comments the current line and saves in history

**Sed command**
```console
# Sed is a file manipulator tool. There are many things you can do. 
# This example demonstrates how to substitute an occurence of a word with
# another in a specific file
sed 's/unix/linux/' example.txti
# s indicated substitute. / is a delimeter.
# unix is the word to put in. The delimeter can be something different.
# 
```

**ssh**
```console
# Use jump host to transfer files from steno to niflheim
scp -r -oProxyCommand="ssh -W %h:%p gbar" GA* magstr@slid.fysik.dtu.dk:~
```



** Grep stuff

```console
grep -r --include=\*.out "Energy"
# Find the lines matching the pattern in al files with the given extension
```

```console
find . -type f -name "NOT*"
# Find all files with specific file name
```

```console
grep -R 'bonds changes' . | wc -l 
# Count the number of matches output by grep
```
```console
find . -name \*.swp -type f -delete
# Find matching files in subdir and delete
```

TMUX
----
```console
ctrl+b (C-b) is the prefix for most commands
C-b+p switches windows
tmux ls shows available windows
C-b+% opens a new pane
C-b+c opens new window
typing exit will close current pane
C-b+d to detach from session
C-b+& to close window

tmux attach -t 'session number' will reattatch to the sessoin
exit will close pane or session

C-b+C-arrow resizes the pane!

C-b+[ to enter scroll mode in termianl
```

```console
# copy mode
#Mark and yank text like vim. 
#You can then paste it again in the commandline

```


VIM
----
```console 
ggVG # Highlights all text
o # Insert new line under current line (O the reverse)
e path opens the specified file
e# takes you to the previous opened file
ls shows open buffers
bd closes current buffer
```

**Editing**
```console
C-r # Will redo the last thing
```


**Navigation**
```console

```

Conda
---
```
# Export env to yml file with only your own installed packages!
conda env export --from-history
```

PyCharm
---
```console 
shift-enter # Creates new line and moves cursor there
C-shift # Enables the movement of current code line up or down. 
```


SLURM
---
```console
# Command to show job history and how much mem it used
sacct --starttime 2022-07-12 --format=User,JobID,partition,state,time,end,MaxRss,nnodes,ncpus,nodelistb
```
