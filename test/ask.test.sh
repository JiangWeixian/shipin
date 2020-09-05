#!/usr/bin/env bash

ask() {
  read -r -n 1 -p "❯ Would you like to $1? y/n: " "$2"
  echo
}