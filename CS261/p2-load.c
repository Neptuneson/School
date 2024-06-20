/*
 * CS 261 PA2: Mini-ELF loader
 *
 * Name: Robert Petro
 */

#include <getopt.h>
#include <stdio.h>
#include <stdlib.h>

#include "p2-load.h"

void usage_p2 ()
{
    printf("Usage: y86 <option(s)> mini-elf-file\n");
    printf(" Options are:\n");
    printf("  -h      Display usage\n");
    printf("  -H      Show the Mini-ELF header\n");
    printf("  -a      Show all with brief memory\n");
    printf("  -f      Show all with full memory\n");
    printf("  -s      Show the program headers\n");
    printf("  -m      Show the memory contents (brief)\n");
    printf("  -M      Show the memory contents (full)\n");
    printf("Options must not be repeated neither explicitly nor implicitly.\n");
}

bool parse_command_line_p2 (int argc, char **argv, bool *header, bool *segments, bool *membrief, bool *memfull, char **file)
{
     if (!argv || !header || !segments || !membrief || !memfull ||!file)
	return false;

    *header = false;
    *segments = false;
    *membrief = false;
    *memfull = false;
    *file = NULL;

    opterr = 0;
    char *optionStr = "+hHafsmM";

    bool H_opt = false;
    bool mem_opt = false;
    bool seg_opt = false;
    int opt;
    while((opt = getopt(argc, argv, optionStr))  != -1)
    {
        switch (opt)
        {
            case 'h':   usage_p2();
                        *header = false;
                        *segments = false;
                        *membrief = false;
                        *memfull = false;
                        *file = NULL;
                        return false;

            case 'H':   if (!H_opt)
			{
			    *header = true;
			    H_opt = true;
			}
			else
			{
			    usage_p2();
                            *header = false;
                            *segments = false;
                            *membrief = false;
                            *memfull = false;
                            *file = NULL;
                            return false;
			}
                        break;
	    case 'a':   if (!H_opt && !seg_opt && !mem_opt)
			{
			    *header = true;
			    H_opt = true;
			    *segments = true;
			    seg_opt = true;
			    *membrief = true;
			    mem_opt = true;
			}
			else
			{
			    usage_p2();
			    *header = false;
			    *segments = false;
			    *membrief = false;
			    *memfull = false;
			    *file = NULL;
			    return false;
			}
			break;
	    case 'f':   if (!H_opt && !seg_opt && !mem_opt)
			{
			    *header = true;
                            H_opt = true;
                            *segments = true;
                            seg_opt = true;
                            *memfull = true;
                            mem_opt = true;
			}
			else
			{
			    usage_p2();
                            *header = false;
                            *segments = false;
                            *membrief = false;
                            *memfull = false;
                            *file = NULL;
                            return false;
			}
			break;
	    case 's':   if (!seg_opt)
			{
			    *segments = true;
			    seg_opt = true;
			}
			else
			{
			    usage_p2();
                            *header = false;
                            *segments = false;
                            *membrief = false;
                            *memfull = false;
                            *file = NULL;
                            return false;
			}
			break;
	    case 'm':   if (!mem_opt)
			{
			    *membrief = true;
			    mem_opt = true;
			}
			else
			{
			    usage_p2();
                            *header = false;
                            *segments = false;
                            *membrief = false;
                            *memfull = false;
                            *file = NULL;
                            return false;
			}
			break;
	    case 'M':   if (!mem_opt)
			{
			    *memfull = true;
			    mem_opt = true;
			}
			else
			{
			    usage_p2();
                            *header = false;
                            *segments = false;
                            *membrief = false;
                            *memfull = false;
                            *file = NULL;
                            return false;
			}
			break;
            default:    usage_p2();
                        *header = false;
                        *segments = false;
                        *membrief = false;
                        *memfull = false;
                        *file = NULL;
                        return false;
        }
    }

    if (optind != argc - 1)  // Exactly ONE FileName must be passed at the end
    {
        usage_p2() ; // either no fileNames, or more than one fileName present
        return false;
    }
    *file = argv[optind];
    return true;
}

bool read_phdr (FILE *file, uint16_t offset, elf_phdr_t *phdr)
{
    if (!file || !phdr)
	return false;
    if (fseek(file, offset, SEEK_SET) != 0)
    {
	return false;
    }
    if (fread(phdr, sizeof(elf_phdr_t), 1, file) != 1)
    {
	return false;
    }
    const uint32_t valid = 0xDEADBEEF;
    if (phdr->magic != valid)
    {
	return false;
    }
    return true;
}

void dump_phdrs (uint16_t numphdrs, elf_phdr_t phdr[])
{
    char const* types[] = {"DATA   ", "CODE   ", "STACK  ", "HEAP   ", "UNKNOWN"};
    char const* flags[] = {"R  ", "W  ", "X","RW" , "R  ", "R X", "RW "};
    printf("Segment   Offset    VirtAddr  FileSize  Type      Flag");
    for (int i = 0; i < numphdrs; i++)
    {
	printf("\n  %02d      0x%04x    0x%04x    0x%04x    %s   %s", i, phdr[i].p_offset, phdr[i].p_vaddr, phdr[i].p_filesz, types[phdr[i].p_type], flags[phdr[i].p_flag]);
    }
    printf("\n\n");
}

bool load_segment (FILE *file, memory_t memory, elf_phdr_t phdr)
{
    const uint32_t valid = 0xDEADBEEF;
    if (!file || !memory || phdr.magic != valid || phdr.p_vaddr + phdr.p_filesz > MEMSIZE)
	return false;
    if (phdr.p_filesz ==0)
	return true;
    if (fseek (file, phdr.p_offset, SEEK_SET) != 0)
        return false;
    if (fread (memory + phdr.p_vaddr, phdr.p_filesz, 1, file) != 1)
        return false;
    return true;
}

void dump_memory (memory_t memory, uint16_t start, uint16_t end)
{
    printf("Contents of memory from %04x to %04x:", start, end);
    for (int i = start; i < end; i++) {
	if (i % 16 == 0)
	    printf("\n  %04x ", i);
	if (i % 8 == 0)
	    printf(" ");
	printf("%02x ", memory[i]);
    }
    printf("\n\n");
}
