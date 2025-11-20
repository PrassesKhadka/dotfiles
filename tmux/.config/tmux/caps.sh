#!/bin/bash
if xset q | grep -q "Caps Lock:   on"; then
  echo "🔒CAPS"
else
  echo ""
fi
