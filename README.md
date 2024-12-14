﻿# 2D Driving Car Simulation in x86 Assembly

## Overview
This is a realistic 2D driving car simulation written in x86 assembly language. The goal is to drive the car while avoiding obstacles (holes in the road) and managing your health. The game features realistic behavior:

- If the car collides entirely with a hole (front-on crash), the car is destroyed, and the player loses immediately.
- If the car brushes against the hole partially (side collision), the health decreases, allowing the player to continue playing unless health reaches 0.

The game combines obstacle avoidance, health management, and simple 2D screen mechanics to deliver a fun and challenging experience.
