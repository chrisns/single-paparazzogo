package main

import (
	"github.com/putsi/paparazzogo"
	"log"
	"net/http"
	"os"
	"time"
)

func main() {

	imgPath := "/"
	addr := ":8080"
	timeout := 30 * time.Second

	mjpegHandler := paparazzogo.NewMjpegproxy()
	mjpegHandler.OpenStream(os.Getenv("URL"), "", "", timeout)

	http.Handle(imgPath, mjpegHandler)

	s := &http.Server{
		Addr:    addr,
		Handler: mjpegHandler,
		// Read- & Write-timeout prevent server from getting overwhelmed in idle connections
		ReadTimeout:  10 * time.Second,
		WriteTimeout: 10 * time.Second,
	}

	log.Fatal(s.ListenAndServe())

	block := make(chan bool)
	// time.Sleep(time.Second * 30)
	// mp.CloseStream()
	// mp.OpenStream(newMjpegstream, newUser, newPass, newTimeout)
	<-block

}
