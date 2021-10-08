import core.internal.entrypoint, libbc.ds;

mixin _d_cmain;

extern(C) int _Dmain(char[][])
{
    libbc.ds.string.runTests();
    libbc.ds.hashmap.runTests();
    libbc.ds.array.runTests();
    return 0;
}