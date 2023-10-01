STYPE
bit_reverse(STYPE value)
{
    int size = 0;
    UTYPE test_value = -1, res = 0, temp, uvalue = (UTYPE) value;
    while (test_value) {
        test_value <<= 1;
        size++;
    }
    for (int i = 0; i < size; ++i) {
        temp = uvalue & 1;
        uvalue >>= 1;
        res <<= 1;
        res |= temp;
    }
    return (STYPE) res;
}