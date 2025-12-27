#include <iostream>
#include <unistd.h>

#define HOST_NAME_MAX 255

using namespace std;

int main() {
    char hostname[255];
    gethostname(hostname, 255);
    cout << "Hostname: " << hostname << endl;

    return 0;
}