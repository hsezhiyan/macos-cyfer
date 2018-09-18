# Overview

Cyfer is a cross-platform application time-tracker that collects user data on websites visited and applications. The purpose of this is to provide users a 'trainer' that helps them remain productive throughout their day, one that learns each user's particular behavior. We intend to create a sort of life-manager and combine social features as well. This repo contains the macOS data collection components.

# Data Collected
  - Time spent on websites (within Safari/Chrome browsers)
  - Time spent on macOS applications
  - CPU/GPU Usage (coming soon)
  - Number of task switches within a set interval length (coming soon)
  - Idle Time

# Technologies Used
  - Objective-C
  - AppleScript

# Components of Project

**First part: Collection Methods (collectionMethods.m)**

This project runs with 4 concurrent threads. One thread is called whenever an application, and another is called when an application closes. The third thread is called every 30 seconds, and sends current data to the server. The fourth thread is called every 2 seconds and polls for website usage in browsers.

**Second part: Server Communication (serverComm.m)**

This component involves communicating with the server. We have set up the server endpoint at https://cyferapp-server.herokuapp.com/data/usage. Details on this on the server repository. Every 30 seconds, data from collectionMethods.m is posted to the server endpoint in JSON format. Additional processing done on server side.

**Third part: Apple Script (systemController.m)**

This component involves abilities to control the Mac the code is running on. This includes actions like openning websites/applications, quitting/blocking them, and setting up basic workstations. A user who wants more powerful assistance has the option to turn on these powerful features.

# Data

All data is in JSON format. The JSON structures used are located in the file JSON.rtf

The following is an image of how the data looks on Xcode:

# Usage

Simply download the project, and run in Xcode. You will need to give the program permission to access OS level features, but after that it is completely hands off.
