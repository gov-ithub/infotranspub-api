package main

import (
	"fmt"
	"log"
	"net/http"
	_ "net/http/pprof"
	_ "regexp"
	"strings"
)

func main() {
	http.HandleFunc("/", handler)
	err := http.ListenAndServe(":8080", nil)
	if err != nil {
		log.Fatal(err)
	}
}

func handler(w http.ResponseWriter, r *http.Request) {
	path := r.URL.Path[1:]
		
	/*
	var re = regexp.MustCompile("(.*)@govithub.ro")
	match := re.FindAllStringSubmatch(path, -1)
	if match != nil {
		fmt.Fprintf(w, "hello, client %s", match[0][0])
		return
	}
	*/
	
	if strings.HasSuffix(path, "@govithub.ro") {
		name := strings.TrimSuffix(path, "@govithub.ro")
		fmt.Fprintf(w, "hello, client %s", name)
		return
	}
	
	fmt.Fprintf(w, "hello, unknown %s", path)
}