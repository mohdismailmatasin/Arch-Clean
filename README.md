# Arch-Clean

**Simple Shell Script to Clean Arch Linux**

1. textThis script is a Bash-based utility designed to perform a comprehensive cleanup of an Arch Linux system. It automates several maintenance tasks to free up disk space, remove unnecessary files, and ensure the system is in a clean state. The script uses color-coded output to enhance readability, with green, red, and yellow text indicating success, warnings, and ongoing actions, respectively.

2. The script begins by checking for the presence of the `pacman` lock file (`/var/lib/pacman/db.lck`), which can prevent package management operations if left behind after an interrupted process. If the lock file exists, it is removed using `sudo rm`. Next, the script identifies and removes orphaned packages—packages that are no longer required as dependencies—using `pacman -Qdtq` to list them and `pacman -Rns` to remove them.

3. The script then proceeds to clean the package cache in two steps. First, it uses `paccache -r` to retain only the three most recent versions of cached packages. Then, it performs a full cache wipe with `pacman -Scc`, removing all cached package files to free up additional disk space. Afterward, the package databases are refreshed using `pacman -Syy` to ensure the system has the latest package information.

4. To manage system logs, the script uses `journalctl --vacuum-time=2weeks` to delete journal logs older than two weeks, reducing log file clutter. Additionally, it includes an optional step to truncate the `pacman` log file, which is commented out by default but can be enabled if desired.

5. Finally, the script displays the disk space usage after the cleanup using the `df -h` command and concludes with a success message. This script is a practical tool for Arch Linux users who want to maintain their system's cleanliness and optimize disk usage with minimal manual effort.

**Example**

```zsh
==> Starting Arch Linux cleanup...
Removing orphaned packages...
[sudo] password for users: 
checking dependencies...

Package (1)               Old Version             Net Change

plank-reloaded-git-debug  0.11.120.r0.g5ea86d9-1   -8.39 MiB

Total Removed Size:  8.39 MiB

:: Do you want to remove these packages? [Y/n] 
:: Processing package changes...
(1/1) removing plank-reloaded-git-debug            [----------------------] 100%
:: Running post-transaction hooks...
(1/1) Arming ConditionNeedsUpdate...
Cleaning package cache (keep 3 versions)...
==> no candidate packages found for pruning
Clearing all package cache...

Cache directory: /var/cache/pacman/pkg/
:: Do you want to remove ALL files from cache? [y/N] 

Database directory: /var/lib/pacman/
:: Do you want to remove unused repositories? [Y/n] 
removing unused sync repositories...
Refreshing package databases...
:: Synchronizing package databases...
 core                  118.0 KiB  90.3 KiB/s 00:01 [----------------------] 100%
 extra                   7.7 MiB  2.01 MiB/s 00:04 [----------------------] 100%
 multilib              136.4 KiB  97.8 KiB/s 00:01 [----------------------] 100%
Cleaning system journal logs (older than 2 weeks)...
Vacuuming done, freed 0B of archived journals from /run/log/journal.
Vacuuming done, freed 0B of archived journals from /var/log/journal.
Vacuuming done, freed 0B of archived journals from /var/log/journal/6c3bf220752b45a084f6b46c43085136.
Cleaning pacman log (optional)...
Disk space after cleanup:
Filesystem      Size  Used Avail Use% Mounted on
/dev/sda2       223G   15G  206G   7% /
✅ Arch Linux cleanup complete!
```
