/*
 * CS 261 PA1: Mini-ELF header verifier
 *
 * Name:Robert Petro
 */

#include <getopt.h>
#include <stdio.h>
#include <stdlib.h>

#include "p1-check.h"

void usage_p1 ()
{
    printf("Usage: y86 <option(s)> mini-elf-file\n");
    printf(" Options are:\n");
    printf("  -h      Display usage\n");
    printf("  -H      Show the Mini-ELF header\n");
    printf("Options must not be repeated neither explicitly nor implicitly.\n");
}

bool parse_command_line_p1 (int argc, char **argv, bool *header, char **file)
{
    if (!argv || !header || !file)
	return false;

    *header = false;
    *file = NULL;

    opterr = 0;
    char *optionStr = "+hH";

    bool H_opt = false;
    int opt;
    while((opt = getopt(argc, argv, optionStr))  != -1)
    {
        switch (opt)
        {
            case 'h':   usage_p1();
			*header = false;
			*file = NULL;
			return true;
            case 'H':   if (!H_opt)
			{
			    *header = true;
			    H_opt = true;
			}
			else
			{
			    usage_p1();
			    *header = false;
			    *file = NULL;
			    return false;
			}
                        break;
            default:    usage_p1();   // invalid options found
                        *header = false;
			*file = NULL;
			return false;
        }
    }

    if (optind != argc - 1)  // Exactly ONE FileName must be passed at the end
    {
        usage_p1() ; // either no fileNames, or more than one fileName present
        return false;
    }
    *file = argv[optind];
    return true;
}

bool read_header (FILE *file, elf_hdr_t *hdr)
{
    if (!file || !hdr)
	return false;
    if (fseek(file, 0, SEEK_SET) != 0)
    {
	return false;
    }
    if (fread(hdr, sizeof(struct elf), 1, file) != 1)
    {
	return false;
    }
    const uint32_t valid = 0x464c45;
    if (hdr->magic != valid)
    {
	return false;
    }
    return true;
}

void dump_header (elf_hdr_t hdr)
{
    printf("%08x  %02x %02x %02x %02x %02x %02x %02x %02x  %02x %02x %02x %02x %02x %02x %02x %02x \n", 0, (hdr.e_version & 0xFF), ((hdr.e_version >> 8) & 0xFF), (hdr.e_entry & 0xFF), ((hdr.e_entry >> 8) & 0xFF), (hdr.e_phdr_start & 0xFF), ((hdr.e_phdr_start >> 8) & 0xFF), (hdr.e_num_phdr & 0xFF), ((hdr.e_num_phdr >> 8) & 0xFF), (hdr.e_symtab & 0xFF), ((hdr.e_symtab >> 8) & 0xFF), (hdr.e_strtab & 0xFF), ((hdr.e_strtab >> 8) & 0xFF), (hdr.magic & 0xFF), ((hdr.magic >> 8) & 0xFF), ((hdr.magic >> 16) & 0xFF), ((hdr.magic >> 24) & 0xFF));
    printf("Mini-ELF version %d\n", hdr.e_version);
    printf("Entry point 0x%02x\n", hdr.e_entry);
    printf("There are %d program headers, starting at offset %d (0x%02x)\n", hdr.e_num_phdr ,hdr.e_phdr_start, hdr.e_phdr_start);
    if (hdr.e_symtab == 0)
    {
	printf("There is no symbol table present\n");
    }
    else
    {
	printf("There is a symbol table starting at offset %d (0x%02x)\n", hdr.e_symtab, hdr.e_symtab);
    }

    if (hdr.e_strtab == 0)
    {
	printf("There is no string table present\n");
    }
    else
    {
	printf("There is a string table starting at offset %d (0x%02x)\n", hdr.e_strtab, hdr.e_strtab);
    }
}
