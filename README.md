# Overview

Cyfer is a cross-platform application time-tracker that collects user data on websites visited and applications. The purpose of this is to provide users a 'trainer' that helps them remain productive throughout their day, one that learns each user's particular behavior. This repo contains the macOS data collection components.

# Data Collected
  - Time spent on websites (within Safari/Chrome browsers)
  - Time spent on macOS applications
  - CPU/GPU Usage
  - Number of task switches within a set interval length
  - Idle Time

# Technologies Used
  - Objective-C
  - AppleScript

# Components of Project

First part: Collection Methods (collectionMethods.m)

This project runs with 4 concurrent threads. One thread is called whenever an application, and another is called when an application closes. The third thread is called every 30 seconds, and sends current data to the server. The fourth thread is called every 2 seconds and polls for website usage in browsers.

