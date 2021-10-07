project('libbcds', ['d'])

srcs = [
    'source/libbc/ds/alloc.d',
    'source/libbc/ds/array.d',
    'source/libbc/ds/hashmap.d',
    'source/libbc/ds/package.d',
    'source/libbc/ds/string.d',
]

include = include_directories('source/')

static_library(
    'bcds',
    srcs,
    include_directories: include
)