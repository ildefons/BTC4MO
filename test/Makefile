default:
	moc --package base ~/.cache/dfinity/versions/0.8.4/base -wasi-system-api -o Test.wasm Test.mo && wasmtime Test.wasm
	rm -f Test.wasm
