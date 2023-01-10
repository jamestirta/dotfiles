#include <stdio.h>
#include <nvidia/gdk/nvml.h>

int main()
{
    nvmlReturn_t result;
    unsigned int temp;

    // First initialize NVML library
    result = nvmlInit();
    if (NVML_SUCCESS != result)
    { 
        printf("Failed to initialize NVML: %s\n", nvmlErrorString(result));

        printf("Press ENTER to continue...\n");
        getchar();
        return 1;
    }

    nvmlDevice_t device;

    result = nvmlDeviceGetHandleByIndex(0, &device);
    if (NVML_SUCCESS != result)
    { 
	printf("Failed to get handle for device %i: %s\n", 0, nvmlErrorString(result));
	goto Error;
    }

    result = nvmlDeviceGetTemperature(device, NVML_TEMPERATURE_GPU, &temp);
    if (NVML_SUCCESS != result) {
	printf("Failed to get temperature of device %i: %s\n", 0, nvmlErrorString(result));
    }
    printf("%d\n", temp);

    result = nvmlShutdown();
    if (NVML_SUCCESS != result)
        printf("Failed to shutdown NVML: %s\n", nvmlErrorString(result));

    return 0;

Error:
    result = nvmlShutdown();
    if (NVML_SUCCESS != result)
        printf("Failed to shutdown NVML: %s\n", nvmlErrorString(result));

    printf("Press ENTER to continue...\n");
    getchar();
    return 1;
}
