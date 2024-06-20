/*
 * CS 261 PA3: Mini-ELF disassembler
 *
 * Name: Robert Petro
 */

#include <getopt.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "p3-disas.h"

//============================================================================
void usage_p3 ()
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
    printf("  -d      Disassemble code contents\n");
    printf("  -D      Disassemble data contents\n");
    printf("Options must not be repeated neither explicitly nor implicitly.\n");
}

//============================================================================
bool parse_command_line_p3 (int argc, char **argv,
        bool *header, bool *segments, bool *membrief, bool *memfull,
        bool *disas_code, bool *disas_data, char **file)
{
    if (!argv || !header || !segments || !membrief || !memfull || !disas_code|| !disas_data|| !file)
	return false;

    *header = *segments = *membrief = *memfull = *disas_code = *disas_data = false;
    *file = NULL;

    opterr = 0;
    char *optionStr = "+hHafsmMdD";

    bool H_opt = false;
    bool mem_opt = false;
    bool seg_opt = false;
    bool code_opt = false;
    bool data_opt = false;

    int opt;
    while((opt = getopt(argc, argv, optionStr))  != -1)
    {
        switch (opt)
        {
            case 'h':   usage_p3();
                        *header = *segments = *membrief = *memfull = *disas_code = *disas_data = false;
                        *file = NULL;
                        return false;

            case 'H':   if (!H_opt)
			{
			    *header = H_opt = true;
			}
			else
			{
			    usage_p3();
                            *header = *segments = *membrief = *memfull = *disas_code = *disas_data = false;
                            *file = NULL;
                            return false;
			}
                        break;

	    case 'a':   if (!H_opt && !seg_opt && !mem_opt)
			{
			    *header = H_opt = *segments = seg_opt = *membrief = mem_opt = true;
			}
			else
			{
			    usage_p3();
			    *header = *segments = *membrief = *memfull = *disas_code = *disas_data = false;
			    *file = NULL;
			    return false;
			}
			break;

	    case 'f':   if (!H_opt && !seg_opt && !mem_opt)
			{
			    *header = H_opt = *segments = seg_opt = *memfull = mem_opt = true;
			}
			else
			{
			    usage_p3();
                            *header = *segments = *membrief = *memfull = *disas_code = *disas_data = false;
                            *file = NULL;
                            return false;
			}
			break;

	    case 's':   if (!seg_opt)
			{
			    *segments = seg_opt = true;
			}
			else
			{
			    usage_p3();
                            *header = *segments = *membrief = *memfull = *disas_code = *disas_data = false;
                            *file = NULL;
                            return false;
			}
			break;

	    case 'm':   if (!mem_opt)
			{
			    *membrief = mem_opt = true;
			}
			else
			{
			    usage_p3();
                            *header = *segments = *membrief = *memfull = *disas_code = *disas_data = false;
                            *file = NULL;
                            return false;
			}
			break;

	    case 'M':   if (!mem_opt)
			{
			    *memfull = mem_opt = true;
			}
			else
			{
			    usage_p3();
                            *header = *segments = *membrief = *memfull = *disas_code = *disas_data = false;
                            *file = NULL;
                            return false;
			}
			break;

	    case 'd':   if (!code_opt)
			{
			    *disas_code = code_opt = true;
			}
			else
			{
			    usage_p3();
                            *header = *segments = *membrief = *memfull = *disas_code = *disas_data = false;
                            *file = NULL;
                            return false;
			}
			break;

	    case 'D':   if (!data_opt)
			{
			    *disas_data = data_opt = true;
			}
			else
			{
			    usage_p3();
                            *header = *segments = *membrief = *memfull = *disas_code = *disas_data = false;
                            *file = NULL;
                            return false;
			}
			break;

            default:    usage_p3();
                        *header = *segments = *membrief = *memfull = *disas_code = *disas_data = false;
                        *file = NULL;
                        return false;
        }
    }

    if (optind != argc - 1)  // Exactly ONE FileName must be passed at the end
    {
        usage_p3() ; // either no fileNames, or more than one fileName present
        return false;
    }
    *file = argv[optind];
    return true;
}

//============================================================================
y86_inst_t fetch (y86_t *cpu, memory_t memory)
{
    y86_inst_t ins;

    // Initialize the instruction
    memset( &ins , 0 , sizeof(y86_inst_t) );  // Clear all fields i=on instr.
    ins.type = INVALID;   // Invalid instruction until proven otherwise

    if (!cpu || &memory[cpu->pc] == NULL)
	return ins;
    if (cpu->pc >= MEMSIZE)
    {
	cpu->stat = ADR;
	return ins;
    }

    uint8_t type = memory[cpu->pc];

    switch(type >> 4)
    {
	case 0:	   ins.type = 0;
		   ins.size = 1;
		   ins.opcode = type;
		   cpu->stat = HLT;
		   if ((memory[cpu->pc] & 0x0F) != 0)
		   {
			ins.type = INVALID;
			cpu->stat = INS;
		   }
		   break;

	case 1:    ins.type = NOP;
		   ins.size = 1;
		   ins.opcode = type;
		   cpu->stat = AOK;
		   if ((memory[cpu->pc] & 0x0F) != 0)
                   {
                        ins.type = INVALID;
                        cpu->stat = INS;
                   }
		   break;

	case 2:    ins.type = CMOV;

		   switch(type & 0x0F)
		   {
			case 0:    ins.cmov = 0;
                   		   cpu->stat = AOK;
				   break;

			case 1:    ins.cmov = CMOVLE;
                                   cpu->stat = AOK;
				   break;

			case 2:    ins.cmov = CMOVL;
                                   cpu->stat = AOK;
				   break;

			case 3:    ins.cmov = CMOVE;
                                   cpu->stat = AOK;
				   break;

			case 4:    ins.cmov = CMOVNE;
                                   cpu->stat = AOK;
				   break;

			case 5:    ins.cmov = CMOVGE;
                                   cpu->stat = AOK;
				   break;

			case 6:    ins.cmov = CMOVG;
                                   cpu->stat = AOK;
				   break;

			default:   ins.type = INVALID;
				   ins.cmov = BADCMOV;
				   cpu->stat = INS;
				   break;
		   }

		   ins.size = 2;
                   ins.opcode = type;

		   if (cpu->pc + ins.size > MEMSIZE)
		   {
			ins.type = INVALID;
			cpu->stat = ADR;
		   }
		   else
		   {
			ins.ra = memory[cpu->pc + 1] >> 4;
		   	ins.rb = memory[cpu->pc + 1] & 0x0F;
		   	if (ins.ra >= 15)
		   	{
			    ins.type = INVALID;
			    cpu->stat = ADR;
		   	}
		   	if (ins.rb >= 15)
		   	{
                            ins.type = INVALID;
                            cpu->stat = INS;
		   	}
		   }
		   break;

	case 3:    ins.type = IRMOVQ;
		   ins.rb = memory[cpu->pc + 1] & 0x0F;

		   for (int i = 0; i < 8; i++)
		   {
			uint64_t byte = memory[cpu->pc + (i + 2)];
			ins.value = (byte << (8 * i)) | ins.value;
		   }

		   ins.size = 10;
		   ins.opcode = type;
                   cpu->stat = AOK;

		   if ((memory[cpu->pc] & 0x0F) != 0)
                   {
                        ins.type = INVALID;
                        cpu->stat = INS;
                   }
		   else
		   {
                   	if (ins.rb >= 15)
                   	{
                            ins.type = INVALID;
                            cpu->stat = ADR;
                   	}
                   	if ((memory[cpu->pc + 1] >> 4) != 15)
                   	{
                            ins.type = INVALID;
                            cpu->stat = INS;
                   	}
		   }
		   break;

	case 4:    ins.type = RMMOVQ;
                   ins.ra = memory[cpu->pc + 1] >> 4;
                   ins.rb = memory[cpu->pc + 1] & 0x0F;
                   for (int i = 0; i < 8; i++)
                   {
                        uint64_t byte = memory[cpu->pc + (i + 2)];
                        ins.d = (byte << (8 * i)) | ins.d;
                   }
		   ins.size = 10;
                   ins.opcode = type;
                   cpu->stat = AOK;

		   if ((memory[cpu->pc] & 0x0F) != 0)
                   {
                        ins.type = INVALID;
                        cpu->stat = INS;
                   }

		   if (cpu->pc + ins.size > MEMSIZE)
                   {
                        ins.type = INVALID;
                        cpu->stat = ADR;
                   }
                   else
                   {
                   	if (ins.ra >= 15)
                   	{
                            ins.type = INVALID;
                            cpu->stat = ADR;
                   	}
                   	if (ins.rb > 15)
                   	{
                            ins.type = INVALID;
                            cpu->stat = ADR;
                   	}
		   }
		   break;

	case 5:    ins.type = MRMOVQ;
                   ins.ra = memory[cpu->pc + 1] >> 4;
                   ins.rb = memory[cpu->pc + 1] & 0x0F;

                   for (int i = 0; i < 8; i++)
                   {
                        uint64_t byte = memory[cpu->pc + (i + 2)];
                        ins.d = (byte << (8 * i)) | ins.d;
                   }
                   ins.size = 10;
                   ins.opcode = type;
                   cpu->stat = AOK;

		   if ((memory[cpu->pc] & 0x0F) != 0)
                   {
                        ins.type = INVALID;
                        cpu->stat = INS;
                   }

		   if (ins.ra >= 15)
		   {
                        ins.type = INVALID;
                        cpu->stat = ADR;
		   }
                   if (ins.rb == 15)
                        ins.rb = 0;
                   if (ins.rb >= 15)
                   {
                        ins.type = INVALID;
                        cpu->stat = ADR;
                   }
		   break;

	case 6:    ins.type = OPQ;

		   switch(type & 0x0F)
		   {
			case 0:    ins.op = 0;
                                   cpu->stat = AOK;
				   break;

			case 1:    ins.op = SUB;
                                   cpu->stat = AOK;
				   break;

			case 2:    ins.op = AND;
                                   cpu->stat = AOK;
				   break;

			case 3:    ins.op = XOR;
                                   cpu->stat = AOK;
				   break;

			default:   ins.type = INVALID;
				   ins.op = BADOP;
				   cpu->stat = INS;
				   break;
		   }

                   ins.ra = memory[cpu->pc + 1] >> 4;
                   ins.rb = memory[cpu->pc + 1] & 0x0F;
                   if (ins.ra >= 15)
		   {
                        ins.type = INVALID;
                        cpu->stat = ADR;
		   }
                   if (ins.rb >= 15)
		   {
                        ins.type = INVALID;
                        cpu->stat = ADR;
		   }
                   ins.size = 2;
                   ins.opcode = type;
		   break;

	case 7:    ins.type = JUMP;

		   switch(type & 0x0F)
		   {
			case 0:    ins.jump = 0;
                                   cpu->stat = AOK;
				   break;

			case 1:    ins.jump = JLE;
                                   cpu->stat = AOK;
                                   break;

			case 2:    ins.jump = JL;
                                   cpu->stat = AOK;
                                   break;

			case 3:    ins.jump = JE;
                                   cpu->stat = AOK;
                                   break;

			case 4:    ins.jump = JNE;
                                   cpu->stat = AOK;
                                   break;

			case 5:    ins.jump = JGE;
                                   cpu->stat = AOK;
                                   break;

			case 6:    ins.jump = JG;
                                   cpu->stat = AOK;
                                   break;

			default:   ins.type = INVALID;
				   ins.jump = BADJUMP;
				   cpu->stat = INS;
                                   break;
		   }

                   for (int i = 0; i < 8; i++)
                   {
			uint64_t byte = memory[cpu->pc + (i + 1)];
                        ins.dest = (byte << (8 * i)) | ins.dest;
                   }
                   ins.size = 9;
                   ins.opcode = type;
		   break;

	case 8:    ins.type = CALL;
		   for (int i = 0; i < 8; i++)
                   {
			uint64_t byte = memory[cpu->pc + (i + 1)];
                        ins.dest = (byte << (8 * i)) | ins.dest;
                   }
                   ins.size = 9;
                   ins.opcode = type;
                   cpu->stat = AOK;
		   if ((memory[cpu->pc] & 0x0F) != 0)
                   {
                        ins.type = INVALID;
                        cpu->stat = INS;
                   }
		   if (cpu->pc + ins.size > MEMSIZE)
                   {
                        ins.type = INVALID;
                        cpu->stat = ADR;
                   }
		   break;

	case 9:    ins.type = RET;
		   ins.size = 1;
		   ins.opcode = type;
                   cpu->stat = AOK;
		   if (memory[cpu->pc] & 0x0F)
                   {
                        ins.type = INVALID;
                        cpu->stat = INS;
                   }
		   break;

	case 10:   ins.type = PUSHQ;
		   ins.ra = memory[cpu->pc + 1] >> 4;
                   ins.size = 2;
                   ins.opcode = type;
                   cpu->stat = AOK;
                   if (ins.ra >= 15)
		   {
                        ins.type = INVALID;
                        cpu->stat = ADR;
		   }
		   if ((memory[cpu->pc] & 0x0F) != 0 || (memory[cpu->pc + 1] & 0x0F) != 0x0F)
                   {
                        ins.type = INVALID;
                        cpu->stat = INS;
                   }
		   break;

	case 11:   ins.type = POPQ;
                   ins.ra = memory[cpu->pc + 1] >> 4;
                   ins.size = 2;
                   ins.opcode = type;
                   cpu->stat = AOK;
                   if (ins.ra >= 15)
		   {
                        ins.type = INVALID;
                        cpu->stat = ADR;
		   }
		   if ((memory[cpu->pc] & 0x0F) != 0 || (memory[cpu->pc + 1] & 0x0F) != 0x0F)
		   {
			ins.type = INVALID;
			cpu->stat = INS;
		   }
		   break;

	default:   ins.type = INVALID;
		   cpu->stat = INS;
		   ins.opcode = type;
		   break;
    }

    return ins;
}

//============================================================================
void disassemble (y86_inst_t inst)
{
    char const* reg[] = {"%rax", "%rcx", "%rdx", "%rbx", "%rsp", "%rbp", "%rsi", "%rdi", "%r8", "%r9", "%r10", "%r11", "%r12", "%r13", "%r14"};
    char const* cmov[] = {"rrmovq", "cmovle", "cmovl", "cmove", "cmovne","cmovge", "cmovg"};
    char const* op[] = {"addq", "subq", "andq", "xorq"};
    char const* jmp[] = {"jmp", "jle", "jl", "je", "jne", "jge", "jg"};

    switch(inst.type)
    {
	case 0:    printf("                   |   halt");
		   break;

	case 1:    printf("                   |   nop");
		   break;

        case 2:    printf("                 |   %s %s, %s", cmov[inst.opcode & 0x0F], reg[inst.ra], reg[inst.rb]);
		   break;

        case 3:    printf(" |   irmovq 0x%lx, %s", inst.value, reg[inst.rb]);
		   break;

        case 4:    printf(" |   rmmovq %s, 0x%lx", reg[inst.ra], inst.d);
		   if (inst.rb != 0 && inst.rb != 15)
		   {
			printf("(%s)", reg[inst.rb]);
		   }
		   break;

        case 5:    printf(" |   mrmovq 0x%lx(%s), %s", inst.d, reg[inst.rb], reg[inst.ra]);
		   break;

        case 6:    printf("                 |   %s %s, %s", op[inst.opcode & 0x0F], reg[inst.ra], reg[inst.rb]);
		   break;

        case 7:    printf("   |   %s 0x%-18lx", jmp[inst.opcode & 0x0F], inst.dest);
		   break;

        case 8:    printf("   |   call 0x%-18lx", inst.dest);
		   break;

        case 9:    printf("                   |   ret");
		   break;

        case 10:   printf("                 |   pushq %s", reg[inst.ra]);
		   break;

        case 11:   printf("                 |   popq %s", reg[inst.ra]);
		   break;

	default:   printf("Invalid opcode: 0x%02x\n", inst.opcode);
		   break;
    }
}

//============================================================================
void disassemble_code (memory_t memory, elf_phdr_t *phdr, elf_hdr_t *hdr)
{
    if (phdr && hdr)
    {
        y86_t cpu;
        y86_inst_t inst;
        cpu.pc = phdr->p_vaddr;

        printf("  0x%03x:                      | .pos 0x%03x code\n", phdr->p_vaddr, phdr->p_vaddr);

        do
        {
            inst = fetch(&cpu, memory);
            if (cpu.stat == AOK || cpu.stat == HLT)
            {
                if (hdr->e_entry == cpu.pc)
                {
                    printf("  0x%03x:                      | _start:\n", hdr->e_entry);
                }
                printf("  0x%03lx: ", cpu.pc);
                for(int j = cpu.pc; j < cpu.pc + inst.size; j++)
                {
                    printf("%02x", memory[j]);
                }
                disassemble(inst);
                cpu.pc = cpu.pc + inst.size;
                printf("\n");
            }
            else
            {
                disassemble(inst);
                break;
            }
        }
        while(cpu.pc < phdr->p_vaddr + phdr->p_filesz);
    }
}

//============================================================================
void disassemble_data (memory_t memory, elf_phdr_t *phdr)
{
    if (phdr)
    {
        printf("  %#05x:                      | .pos %#05x data\n", phdr->p_vaddr, phdr->p_vaddr);
        uint64_t data = 0;
        for (int i = phdr->p_vaddr; i < phdr->p_vaddr + phdr->p_filesz; i++)
        {
	    if (i % 8 == 0)
	    {
	        if (i != phdr->p_vaddr)
	        {
		    printf("     |   .quad 0x%-18lx\n", data);
		    data = 0;
	        }
	        printf("  0x%03x: ", i);
	        for (int j = 0; j < 8; j++)
	        {
		    uint64_t byte = memory[i + j];
                    data = (byte << (8 * j)) | data;
	        }
	    }
	    printf("%02x", memory[i]);
        }
        printf("     |   .quad 0x%-18lx\n", data);
    }
}

//============================================================================
void disassemble_rodata (memory_t memory, elf_phdr_t *phdr)
{
    if (phdr)
    {
        printf("  %#05x:                      | .pos %#05x rodata\n", phdr->p_vaddr, phdr->p_vaddr);
	uint16_t start = phdr->p_vaddr;
        uint8_t count = 0;
	uint8_t level = 0;
	for (int i = phdr->p_vaddr; i < phdr->p_vaddr + phdr->p_filesz; i++)
        {
	    if (memory[i] == 0)
	    {
		printf("  0x%03x: ", start);

		for (int j = start; j <= i; j++)
	        {
		    count = count + 1;
		    printf("%02x", memory[j]);
		    if (i == j && count < 10)
                    {
                        for (int k = count; k < 10; k++)
                        {
                            printf("  ");
			    count = count + 1;
                        }
                    }

		    if (count % 10 == 0)
		    {
			count = 0;
		        if (level == 0)
		        {
			    level = level + 1;
			    printf(" |   .string \"");
			    for (int k = start; k <= i; k++)
			    {
				int c = memory[k];
				if (c != 0) {
				    printf("%c", (char)(c));
				}
			    }
			    printf("\"");
		        }
		        else
		        {
			    printf(" |");
		        }
		        if (i != j)
		            printf("\n  0x%03x: ", j + 1);
		    }
	        }
		level = 0;
		start = i + 1;
		printf("\n");
	    }
	}
    }
}
//============================================================================

