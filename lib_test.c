#include <criterion/criterion.h>
#include "lib.h"

Test(lib, hello) { cr_assert_str_eq(hello(), "Hello, World!"); }
