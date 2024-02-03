package main

import (
	"fmt"
	"os"
	"os/exec"
	"syscall"
)

func main() {
	if os.Getenv("GOKRAZY_FIRST_START") == "1" {
		os.Exit(0)
	}
	const frozenDir = "/usr/lib/x86_64-linux-gnu/dnsmasq.frozen"
	dnsmasq := exec.Command(
		frozenDir+"/ld-linux-x86-64.so.2",
		append([]string{
			frozenDir + "/dnsmasq",
		}, os.Args[1:]...)...)
	dnsmasq.Env = append(os.Environ(), "LD_LIBRARY_PATH="+frozenDir)
	dnsmasq.Stdin = os.Stdin
	dnsmasq.Stdout = os.Stdout
	dnsmasq.Stderr = os.Stderr
	err := dnsmasq.Run()
	if err != nil {
		if exiterr, ok := err.(*exec.ExitError); ok {
			if status, ok := exiterr.Sys().(syscall.WaitStatus); ok {
				os.Exit(status.ExitStatus())
			}
		} else {
			fmt.Fprintf(os.Stderr, "%v: %v\n", dnsmasq.Args, err)
		}
	}
}
