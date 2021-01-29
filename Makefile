nativeware:toolchain
	./scripts/compiler.sh

toolchain:
	./scripts/toolchain.sh

clean:
	git clean -fdxq && git reset --hard

toolchain-clean:
	rm -rf /opt/brcm/usr
