project('libbcds', ['d'])

srcs = [
    'source/libbc/ds/alloc.d',
    'source/libbc/ds/array.d',
    'source/libbc/ds/hashmap.d',
    'source/libbc/ds/package.d',
    'source/libbc/ds/string.d',
]

include = include_directories('source/')

libbcds = static_library(
    'bcds',
    srcs,
    include_directories: include,
    d_args: ['-betterC']
)

libbcds_test = executable(
    'bcds_test',
    srcs,
    'source/test.d',
    include_directories: include,
    d_args: ['-betterC', '-unittest']
)

libbcds_dep = declare_dependency(
    include_directories: include,
    sources: srcs
)

test('libbcds', libbcds_test)