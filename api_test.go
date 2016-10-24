package main

import (
	"net/http"
	"net/http/httptest"
	"testing"
)


/* Tests
go test .
*/
func TestHandler(t *testing.T) {
	rec := httptest.NewRecorder()
	req, err := http.NewRequest(
		http.MethodGet,
		"http://localhost:8080/test@govithub.ro",
		nil,
	)
	if err != nil {
		t.Fatalf("could not create request: %v", err)
	}
	handler(rec, req)
	if rec.Code != http.StatusOK {
		t.Errorf("expected 200 OK; got %v", rec.Code)
	}
	if rec.Body.String() != "hello, client test" {
		t.Errorf("expected client in the body; got %q", rec.Body)
	}
}

func TestHandlerNotMatch(t *testing.T) {
	rec := httptest.NewRecorder()
	req, err := http.NewRequest(
		http.MethodGet,
		"http://localhost:8080/test@govithub.ro",
		nil,
	)
	if err != nil {
		t.Fatalf("could not create request: %v", err)
	}
	handler(rec, req)
	if rec.Code != http.StatusOK {
		t.Errorf("expected 200 OK; got %v", rec.Code)
	}
}

/* 
Benchmarks
go test -bench .

 CPU profile
go test -bench . -benchname -cpuprofile prof.cpu && go tool pprof infotranspub-api.test prof.cpu && web
go-torch --binaryname infotranspub-api.test -b prof.cpu && xdg-open torch.svg

Memory profile
go test -bench . -benchmem -cpuprofile prof.cpu -memprofile prof.mem

Show where all the allocations are happening
go tool pprof --alloc_objects infotranspub-api.test prof.mem && list handler
*/
func BenchmarkHandler(b *testing.B) {
	for i := 0; i < b.N; i++ {
		rec := httptest.NewRecorder()
		req, err := http.NewRequest(
			http.MethodGet,
			"http://localhost:8080/test@govithub.ro",
			nil,
		)
		if err != nil {
			b.Fatalf("could not create request: %v", err)
		}
		handler(rec, req)
		if rec.Code != http.StatusOK {
			b.Errorf("expected 200 OK; got %v", rec.Code)
		}
		if rec.Body.String() != "hello, client test" {
			b.Errorf("expected client in the body; got %q", rec.Body)
		}
	}
}
