/*
 * CS 261: P4 Y86 Interpreter Main driver
 *
 * Name: Robert Petro
 *    or risk losing points, and delays when you seek my help during office hours
 */

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#include "p1-check.h"
#include "p2-load.h"
#include "p3-disas.h"
#include "p4-interp.h"

int main (int argc, char **argv)
{
    bool header, segments, membreif, memfull, disas_code, disas_data, exec_normal, exec_debug;
    header = segments = membreif = memfull = disas_code = disas_data = exec_normal = exec_debug = false;
    char *fileName = NULL;

    if (parse_command_line_p4(argc, argv, &header, &segments, &membreif, &memfull, &disas_code, &disas_data, &exec_normal, &exec_debug, &fileName))
    {
	if (argc == 0)
	{
	    printf("Failed to Read Program Header");
            exit(EXIT_FAILURE);
	}

	if(fileName)
	{
	    FILE *file = fopen(fileName, "r");
	    if (!file)
	    {
		printf("Failed to open File\n");
		exit(EXIT_FAILURE);
	    }

	    elf_hdr_t hdr;
            if(!read_header(file, &hdr))
            {
		printf("Failed to Read ELF Header\n");
		exit(EXIT_FAILURE);
            }

	    if (header)
            {
                dump_header(hdr);
		printf("\n");
            }

	    memory_t memory = calloc(MEMSIZE, sizeof(uint8_t));
            elf_phdr_t* phdrs = (elf_phdr_t*) malloc(hdr.e_num_phdr * sizeof(elf_phdr_t));
	    for (int i = 0; i < hdr.e_num_phdr; i++)
            {
                elf_phdr_t phdr;
                uint16_t offset = hdr.e_phdr_start + sizeof(elf_phdr_t) * i;
                if (!read_phdr(file, offset, &phdr))
                {
		    free(phdrs);
                    free(memory);
                    printf("Failed to Read Program Header\n");
                    exit(EXIT_FAILURE);
                }

		phdrs[i] = phdr;

                if (!load_segment(file, memory, phdr))
                {
                    free(phdrs);
                    free(memory);
                    printf("Failed to Load Segment\n");
                    exit(EXIT_FAILURE);
                }
            }

	    if (segments)
	    {
		dump_phdrs(hdr.e_num_phdr, phdrs);
	    }

	    if (membreif)
	    {
		for (int i = 0; i < hdr.e_num_phdr; i++)
		{
		    int start = phdrs[i].p_vaddr / 16;
		    start = start * 16;
		    if (phdrs[i].p_filesz)
		        dump_memory(memory, start, start + phdrs[i].p_filesz + phdrs[i].p_vaddr % 16);
		}
	    }

	    if (memfull)
	    {
		dump_memory(memory, 0, MEMSIZE);
	    }

	    if (disas_code)
	    {
		printf("Disassembly of executable contents:\n");
		for (int i = 0; i < hdr.e_num_phdr; i++)
		{
		    if (phdrs[i].p_type == 1)
		    {
			disassemble_code(memory, &phdrs[i], &hdr);
			printf("\n");
		    }
		}
            }

	    if (disas_data)
	    {
		printf("Disassembly of data contents:\n");
		for (int i = 0; i < hdr.e_num_phdr; i++)
		{
                    if (phdrs[i].p_type == 0)
		    {
			if (phdrs[i].p_flag == 4)
			    disassemble_rodata(memory, &phdrs[i]);
			else
                            disassemble_data(memory, &phdrs[i]);
			printf("\n");
                    }
                }
	    }

	    y86_t cpu;
	    memset(&cpu, 0, sizeof(y86_t));
	    cpu.pc = hdr.e_entry;
	    cpu.stat = AOK;

	    y86_inst_t inst;
	    memset(&inst, 0, sizeof(y86_inst_t));
    	    inst.type = INVALID;

	    y86_register_t valA, valE;
	    valA = valE = 0;

	    bool cond = false;
	    int exe_count = 0;

	    if (exec_normal)
	    {
		printf("Entry execution point at 0x%04x\n", hdr.e_entry);
		printf("Initial ");
		dump_cpu(&cpu);
		while(cpu.stat == AOK)
		{
		    inst = fetch(&cpu, memory);
                    valE = decode_execute(&cpu, &cond, &inst, &valA);
		    if(cpu.stat != INS)
		    {
		        memory_wb_pc(&cpu, memory, cond, &inst, valE, valA);
		    }
		    else
		    {
		    	printf("Corrupt Instruction (opcode 0x%02x) at address 0x%04lx\n", inst.opcode, cpu.pc);
		    }
      		    exe_count = exe_count + 1;
		}
		if(cpu.stat == INS)
		    printf("Post-Fetch ");
		else
		    printf("Post-Exec ");
		dump_cpu(&cpu);
		printf("Total execution count: %d instructions\n\n", exe_count);
	    }

	    if (exec_debug)
	    {
		printf("Entry execution point at 0x%04x\n", hdr.e_entry);
		printf("Initial ");
                dump_cpu(&cpu);
		while(cpu.stat == AOK)
		{
		    inst = fetch(&cpu, memory);
		    printf("Executing: ");
		    disassemble(inst);
                    printf("\n");
		    valE = decode_execute(&cpu, &cond, &inst, &valA);
		    if(cpu.stat != INS)
                    {
                        memory_wb_pc(&cpu, memory, cond, &inst, valE, valA);
			printf("Post-Exec ");
                    }
                    else
		    {
                        printf("Corrupt Instruction (opcode 0x%02x) at address 0x%04lx\n", inst.opcode, cpu.pc);
			printf("Post-Fetch ");
		    }
                    exe_count = exe_count + 1;
                    dump_cpu(&cpu);
		}
		printf("Total execution count: %d instructions\n\n", exe_count);
		dump_memory(memory, 0, MEMSIZE);
	    }

	    free(phdrs);
            free(memory);
	    exit(EXIT_SUCCESS);
	}
    }
    exit(EXIT_FAILURE);
}


