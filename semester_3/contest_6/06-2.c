const char BACK_PATH[] = "/..", ZERO_PATH[] = "/.", BASE_PATH[] = "/";

enum
{
    BACK_PATH_LEN = sizeof(BACK_PATH) - 1,
    ZERO_PATH_LEN = sizeof(ZERO_PATH) - 1,
};

int
mystrlen(char *buf)
{
    int res = 0;
    while (buf[res] != 0) {
        res++;
    }
    return res;
}

void
mymemmove(char *to, char *from, int n)
{
    int i = 0;
    while (i < n) {
        to[i] = from[i];
        ++i;
    }
}

void
normalize_path(char *buf)
{
    if (buf == 0 || buf[0] == 0 || (buf[0] == '/' && buf[1] == 0)) {
        return;
    }
    int len = mystrlen(buf), cur = 0, end;
    if (buf[len - 1] == '/') {
        buf[--len] = 0;
    }
    while (cur <= len - ZERO_PATH_LEN) {
        if ((buf[cur] == '/' && buf[cur + 1] == '.') &&
            (buf[cur + ZERO_PATH_LEN] == '/' || buf[cur + ZERO_PATH_LEN] == 0)) {
            len -= ZERO_PATH_LEN;
            mymemmove(&buf[cur], &buf[cur + ZERO_PATH_LEN], len - cur + 1); // + 1 because of 0 at the end
        } else {
            cur++;
        }
    }
    cur = 0;
    while (cur <= len - BACK_PATH_LEN) {
        if ((buf[cur] == '/' && buf[cur + 1] == '.' && buf[cur + 2] == '.') &&
            (buf[cur + BACK_PATH_LEN] == '/' || buf[cur + BACK_PATH_LEN] == 0)) {
            end = cur + BACK_PATH_LEN;
            if (cur > 0) {
                cur--;
                while (buf[cur] != '/') {
                    cur--;
                }
            }
            len -= end - cur;
            mymemmove(&buf[cur], &buf[end], len - cur + 1); // + 1 because of 0 at the end
        } else {
            cur++;
        }
    }
    if (buf[0] == 0) {
        buf[0] = '/';
        buf[1] = 0;
    }
}
