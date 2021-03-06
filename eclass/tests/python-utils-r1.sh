#!/bin/bash

EAPI=5
source tests-common.sh

test_var() {
	local var=${1}
	local impl=${2}
	local expect=${3}

	tbegin "${var} for ${impl}"

	local ${var}
	python_export ${impl} ${var}
	[[ ${!var} == ${expect} ]] || eerror "(${impl}: ${var}: ${!var} != ${expect}"

	tend ${?}
}

test_is() {
	local func=${1}
	local expect=${2}

	tbegin "${func} (expecting: ${expect})"

	${func}
	[[ ${?} == ${expect} ]]

	tend ${?}
}

test_fix_shebang() {
	local from=${1}
	local to=${2}
	local expect=${3}
	local args=( "${@:4}" )

	tbegin "python_fix_shebang${args[@]+ ${args[*]}} from ${from} to ${to} (exp: ${expect})"

	echo "${from}" > "${tmpfile}"
	output=$( EPYTHON=${to} python_fix_shebang "${args[@]}" -q "${tmpfile}" 2>&1 )

	if [[ ${?} != 0 ]]; then
		if [[ ${expect} != FAIL ]]; then
			echo "${output}"
			tend 1
		else
			tend 0
		fi
	else
		[[ $(<"${tmpfile}") == ${expect} ]] \
			|| eerror "${from} -> ${to}: $(<"${tmpfile}") != ${expect}"
		tend ${?}
	fi
}

tmpfile=$(mktemp)

inherit python-utils-r1

test_var EPYTHON python2_7 python2.7
test_var PYTHON python2_7 /usr/bin/python2.7
test_var PYTHON_SITEDIR python2_7 /usr/lib/python2.7/site-packages
test_var PYTHON_INCLUDEDIR python2_7 /usr/include/python2.7
test_var PYTHON_LIBPATH python2_7 /usr/lib/libpython2.7$(get_libname)
test_var PYTHON_PKG_DEP python2_7 '*dev-lang/python*:2.7'
test_var PYTHON_SCRIPTDIR python2_7 /usr/lib/python-exec/python2.7

test_var EPYTHON python3_3 python3.3
test_var PYTHON python3_3 /usr/bin/python3.3
test_var PYTHON_SITEDIR python3_3 /usr/lib/python3.3/site-packages
test_var PYTHON_INCLUDEDIR python3_3 /usr/include/python3.3
test_var PYTHON_LIBPATH python3_3 /usr/lib/libpython3.3$(get_libname)
test_var PYTHON_PKG_DEP python3_3 '*dev-lang/python*:3.3'
test_var PYTHON_SCRIPTDIR python3_3 /usr/lib/python-exec/python3.3

test_var EPYTHON jython2_7 jython2.7
test_var PYTHON jython2_7 /usr/bin/jython2.7
test_var PYTHON_SITEDIR jython2_7 /usr/share/jython-2.7/Lib/site-packages
test_var PYTHON_PKG_DEP jython2_7 '*dev-java/jython*:2.7'
test_var PYTHON_SCRIPTDIR jython2_7 /usr/lib/python-exec/jython2.7

test_var EPYTHON pypy pypy
test_var PYTHON pypy /usr/bin/pypy
test_var PYTHON_SITEDIR pypy /usr/lib/pypy/site-packages
test_var PYTHON_INCLUDEDIR pypy /usr/lib/pypy/include
test_var PYTHON_PKG_DEP pypy '*virtual/pypy*:0='
test_var PYTHON_SCRIPTDIR pypy /usr/lib/python-exec/pypy

test_var EPYTHON pypy3 pypy3
test_var PYTHON pypy3 /usr/bin/pypy3
test_var PYTHON_SITEDIR pypy3 /usr/lib/pypy3/site-packages
test_var PYTHON_INCLUDEDIR pypy3 /usr/lib/pypy3/include
test_var PYTHON_PKG_DEP pypy3 '*virtual/pypy3*:0='
test_var PYTHON_SCRIPTDIR pypy3 /usr/lib/python-exec/pypy3

test_is "python_is_python3 python2.7" 1
test_is "python_is_python3 python3.2" 0
test_is "python_is_python3 jython2.7" 1
test_is "python_is_python3 pypy" 1
test_is "python_is_python3 pypy3" 0

# generic shebangs
test_fix_shebang '#!/usr/bin/python' python2.7 '#!/usr/bin/python2.7'
test_fix_shebang '#!/usr/bin/python' python3.4 '#!/usr/bin/python3.4'
test_fix_shebang '#!/usr/bin/python' pypy '#!/usr/bin/pypy'
test_fix_shebang '#!/usr/bin/python' pypy3 '#!/usr/bin/pypy3'
test_fix_shebang '#!/usr/bin/python' jython2.7 '#!/usr/bin/jython2.7'

# python2/python3 matching
test_fix_shebang '#!/usr/bin/python2' python2.7 '#!/usr/bin/python2.7'
test_fix_shebang '#!/usr/bin/python3' python2.7 FAIL
test_fix_shebang '#!/usr/bin/python3' python2.7 '#!/usr/bin/python2.7' --force
test_fix_shebang '#!/usr/bin/python3' python3.4 '#!/usr/bin/python3.4'
test_fix_shebang '#!/usr/bin/python2' python3.4 FAIL
test_fix_shebang '#!/usr/bin/python2' python3.4 '#!/usr/bin/python3.4' --force

# pythonX.Y matching (those mostly test the patterns)
test_fix_shebang '#!/usr/bin/python2.7' python2.7 '#!/usr/bin/python2.7'
test_fix_shebang '#!/usr/bin/python2.7' python3.2 FAIL
test_fix_shebang '#!/usr/bin/python2.7' python3.2 '#!/usr/bin/python3.2' --force
test_fix_shebang '#!/usr/bin/python3.2' python3.2 '#!/usr/bin/python3.2'
test_fix_shebang '#!/usr/bin/python3.2' python2.7 FAIL
test_fix_shebang '#!/usr/bin/python3.2' python2.7 '#!/usr/bin/python2.7' --force
test_fix_shebang '#!/usr/bin/pypy' pypy '#!/usr/bin/pypy'
test_fix_shebang '#!/usr/bin/pypy' python2.7 FAIL
test_fix_shebang '#!/usr/bin/pypy' python2.7 '#!/usr/bin/python2.7' --force
test_fix_shebang '#!/usr/bin/jython2.7' jython2.7 '#!/usr/bin/jython2.7'
test_fix_shebang '#!/usr/bin/jython2.7' jython3.2 FAIL
test_fix_shebang '#!/usr/bin/jython2.7' jython3.2 '#!/usr/bin/jython3.2' --force

# fancy path handling
test_fix_shebang '#!/mnt/python2/usr/bin/python' python3.4 \
	'#!/mnt/python2/usr/bin/python3.4'
test_fix_shebang '#!/mnt/python2/usr/bin/python2' python2.7 \
	'#!/mnt/python2/usr/bin/python2.7'
test_fix_shebang '#!/mnt/python2/usr/bin/env python' python2.7 \
	'#!/mnt/python2/usr/bin/env python2.7'
test_fix_shebang '#!/mnt/python2/usr/bin/python2 python2' python2.7 \
	'#!/mnt/python2/usr/bin/python2.7 python2'
test_fix_shebang '#!/mnt/python2/usr/bin/python3 python2' python2.7 FAIL
test_fix_shebang '#!/mnt/python2/usr/bin/python3 python2' python2.7 \
	'#!/mnt/python2/usr/bin/python2.7 python2' --force
test_fix_shebang '#!/usr/bin/foo' python2.7 FAIL

# regression test for bug #522080
test_fix_shebang '#!/usr/bin/python ' python2.7 '#!/usr/bin/python2.7 '

# make sure we don't break pattern matching
test_is "_python_impl_supported python2_5" 1
test_is "_python_impl_supported python2_6" 1
test_is "_python_impl_supported python2_7" 0
test_is "_python_impl_supported python3_1" 1
test_is "_python_impl_supported python3_2" 0
test_is "_python_impl_supported python3_3" 0
test_is "_python_impl_supported python3_4" 0
test_is "_python_impl_supported pypy1_8" 1
test_is "_python_impl_supported pypy1_9" 1
test_is "_python_impl_supported pypy2_0" 1
test_is "_python_impl_supported pypy" 0
test_is "_python_impl_supported pypy3" 0
test_is "_python_impl_supported jython2_5" 0
test_is "_python_impl_supported jython2_7" 0

rm "${tmpfile}"

texit
