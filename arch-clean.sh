#!/bin/bash

# Simple Arch Linux Cleanup Script
# By: mohdismailmatasin@gmail.com
# Date: $(date +%Y-%m-%d)

# Colors
GREEN='\033[1;32m'
RED='\033[1;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}==> Starting Arch Linux cleanup...${NC}"

# Check and remove pacman lock file if it exists
if [ -f /var/lib/pacman/db.lck ]; then
    echo -e "${RED}Pacman lock file found. Removing...${NC}"
    sudo rm /var/lib/pacman/db.lck
fi

# Step 1: Remove orphaned packages
echo -e "${YELLOW}Removing orphaned packages...${NC}"
orphans=$(sudo pacman -Qdtq)
if [[ -n "$orphans" ]]; then
    echo "$orphans" | sudo pacman -Rns --noconfirm -
else
    echo -e "${GREEN}No orphaned packages found.${NC}"
fi

# Step 2: Clean package cache (keep 3 versions)
echo -e "${YELLOW}Cleaning package cache (keep 3 versions)...${NC}"
sudo paccache -r

# Step 3: Full cache wipe (everything!)
echo -e "${YELLOW}Clearing all package cache...${NC}"
sudo pacman -Scc --noconfirm

# Step 4: Refresh package databases
echo -e "${YELLOW}Refreshing package databases...${NC}"
sudo pacman -Syy --noconfirm

# Step 5: Clean journal logs older than 2 weeks
echo -e "${YELLOW}Cleaning system journal logs (older than 2 weeks)...${NC}"
sudo journalctl --vacuum-time=2weeks

# Step 6: Clean pacman log (optional)
echo -e "${YELLOW}Cleaning pacman log (optional)...${NC}"
# Uncomment the line below to truncate pacman log:
# sudo truncate -s 0 /var/log/pacman.log

# Show disk space usage after cleanup
echo -e "${GREEN}Disk space after cleanup:${NC}"
df -h /

echo -e "${GREEN}✅ Arch Linux cleanup complete!${NC}"

