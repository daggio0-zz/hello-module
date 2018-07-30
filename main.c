
#include <linux/init.h>
#include <linux/module.h>

MODULE_LICENSE("Dual BSD/GPL");

static int __init my_init(void)
{
    pr_info("Hello world.\n");
    return  0;
}
   
static void __exit my_exit(void)
{
    pr_info("Goodbye world.\n");
}
   
module_init(my_init);
module_exit(my_exit);
