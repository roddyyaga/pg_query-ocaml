#!/usr/bin/env bash
rm -r docs
dune clean && dune build @doc
cp -r _build/default/_doc/html docs
