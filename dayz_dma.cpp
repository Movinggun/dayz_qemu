Memory dayz_mem;

bool active = true;

int main (int arc, char *argv[]) {
    if (geteuid() != 0) {
        printf("Error: %s is not running as root\n", argv[0]);
		return 0;
    }

    const char* dz_proc = "DayZx64.exe";

    while (active) {
        if (dayz_mem.get_proc_status() != process_status::FOUND_READY) {
            std::this_thread::sleep_for(std::chrono::seconds(1));
			printf("Searching for DayZ Process...\n");

            dayz_mem.open_proc(dz_proc);
        }
    }

    return 0;
}