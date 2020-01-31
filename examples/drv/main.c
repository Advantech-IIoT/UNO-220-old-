#include <linux/kobject.h>
#include <linux/string.h>
#include <linux/sysfs.h>
#include <linux/module.h>
#include <linux/init.h>
#include <linux/kernel.h>
#include <linux/string.h>
#define __FILENAME__ (strrchr(__FILE__, '/') ? strrchr(__FILE__, '/') + 1 : __FILE__)
static int __init example_init(void){
  printk(KERN_INFO "%s, %s, %d: TEST: %s\n", __FILE__, __FUNCTION__, __LINE__, TEST);
  return 0;
}
static void __exit example_exit(void){
  printk(KERN_INFO "%s, %s, %d: \n", __FILE__, __FUNCTION__, __LINE__);
}
module_init(example_init);
module_exit(example_exit);
MODULE_LICENSE("GPL v2");
MODULE_AUTHOR("Ralph Wang <ralph.wang@advantech.com.tw>");
