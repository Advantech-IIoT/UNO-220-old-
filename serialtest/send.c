#include <errno.h>
#include <fcntl.h> 
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <termios.h>
#include <unistd.h>

int set_interface_attribs(int fd, int speed)
{
  struct termios tty;

  if (tcgetattr(fd, &tty) < 0) {
    printf("Error from tcgetattr: %s\n", strerror(errno));
    return -1;
  }

  cfsetospeed(&tty, (speed_t)speed);
  cfsetispeed(&tty, (speed_t)speed);

  tty.c_cflag |= (CLOCAL | CREAD);  /* ignore modem controls */
  tty.c_cflag &= ~CSIZE;
  tty.c_cflag |= CS8;     /* 8-bit characters */
  tty.c_cflag &= ~PARENB;   /* no parity bit */
  tty.c_cflag &= ~CSTOPB;   /* only need 1 stop bit */
  tty.c_cflag &= ~CRTSCTS;  /* no hardware flowcontrol */

  /* setup for non-canonical mode */
  tty.c_iflag &= ~(IGNBRK | BRKINT | PARMRK | ISTRIP | INLCR | IGNCR | ICRNL | IXON);
  tty.c_lflag &= ~(ECHO | ECHONL | ICANON | ISIG | IEXTEN);
  tty.c_oflag &= ~OPOST;

  /* fetch bytes as they become available */
  tty.c_cc[VMIN] = 1;
  tty.c_cc[VTIME] = 1;

  if (tcsetattr(fd, TCSANOW, &tty) != 0) {
    printf("Error from tcsetattr: %s\n", strerror(errno));
    return -1;
  }
  return 0;
}

void set_mincount(int fd, int mcount)
{
  struct termios tty;

  if (tcgetattr(fd, &tty) < 0) {
    printf("Error tcgetattr: %s\n", strerror(errno));
    return;
  }

  tty.c_cc[VMIN] = mcount ? 1 : 0;
  tty.c_cc[VTIME] = 5;    /* half second timer */

  if (tcsetattr(fd, TCSANOW, &tty) < 0)
    printf("Error tcsetattr: %s\n", strerror(errno));
}


int main(int argc, char *argv[]){
  char *portname = "/dev/ttyS0";
  int fd;
  int wlen;

  if(argc>1) portname=argv[1]; 
  fd = open(portname, O_RDWR | O_NOCTTY | O_SYNC);
  //fd = open(portname, O_RDWR | O_NOCTTY | O_SYNC | O_NDELAY);
  if (fd < 0) {
    printf("Error opening %s: %s\n", portname, strerror(errno));
    return -1;
  }
  /*baudrate 115200, 8 bits, no parity, 1 stop bit */
  set_interface_attribs(fd, B115200);
  //set_mincount(fd, 0);        /* set to pure timed read */

  /* simple output */
  char sendstr[64]="Hello!\xa\xd"; 
  int sendlen=0;
  if(argc>2){
    strcpy(sendstr, argv[2]); 
  }
  sendlen=strlen(sendstr);
  wlen = write(fd, sendstr, sendlen);
  if (wlen != sendlen) {
    printf("Error from write: %d, %d\n", wlen, errno);
  }
  tcdrain(fd);  /* delay for output */

  return 0; 
}
