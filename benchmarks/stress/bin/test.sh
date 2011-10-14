#!/bin/bash

  while [  `pgrep batch.she` ]
  do
      echo "in progress" 
      sleep 5
  done



  exit 0