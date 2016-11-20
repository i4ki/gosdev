package runtime

import "unsafe"

func osinit() {
	ncpu = 1

	osdevinit()
}

func sigpanic() {}

func signame(sig uint32) string { return "" }

func goenvs() {}

//go:nowritebarrier
func newosproc(mp *m, stk unsafe.Pointer) {
	if true {
		print("newosproc stk=", stk, " m=", mp, " g=", mp.g0, " id=", mp.id, " ostk=", &mp, "\n")
	}

}

func minit() {
	println("minit()")
}

//go:nosplit
func unminit() {
	println("unminit()")
}

//go:nosplit
func mpreinit(mp *m) {
	print("mpreinit(", unsafe.Pointer(mp), ")", "\n")

	mp.gsignal = malg(32 * 1024)
	mp.gsignal.m = mp
}

//go:nosplit
func msigsave(mp *m) {
	print("msigsave(", unsafe.Pointer(mp), ")", "\n")
}

//go:nosplit
func msigrestore(sigset) {}

//go:nosplit
func sigblock() {}

type sigset struct{}

type mOS struct {
}
