#include "lib.h"

#include <criterion/criterion.h>

Test(lib, hello) { cr_assert_str_eq(hello(), "Hello, World!"); }
