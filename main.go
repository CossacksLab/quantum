package main

import (
	log "github.com/Sirupsen/logrus"
	"os"
)

func main() {
	utils.SetupLogging()
	utils.LoadConfig()
}
