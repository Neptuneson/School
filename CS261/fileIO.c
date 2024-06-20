#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <getopt.h>

void usage( char *cmd )
{
    printf("Usage: %s <option(s)> fileName\n" , cmd);
    printf(" Options are:\n");
    printf("  -h      display this help screen\n");
    printf("  -s b    start reading at location 'b'. Default b=0\n");
    printf("  -n m    read 'm' bytes. Default m=1\n");
}

/*-------------------------------------------------------------------------*/

bool parse_CL( int argc, char **argv, bool *sOpt, unsigned *sVal ,
               bool *nOpt, unsigned *nVal, char **file )
{
    int opt;


    // Initialize the call-by-ref agruments
    *sOpt = *nOpt =  false ;
    *sVal = 0;  *nVal=1 ;
    *file   = NULL ;

    opterr = 0 ;  /* Prevent getopt() from printing error messages */
    char *optionStr = "+hs:n:";

    const int numbase = 10;
    long number;
    char *end;
    while ( ( opt = getopt(argc, argv, optionStr ) ) != -1)
    {
        switch (opt)
        {
            case 'h':	usage( argv[0] );
                        return true ;
                        break ;
            case 's':   end = optarg;
			number = strtol( optarg, &end, numbase);
			if (end == optarg)
			{
				usage( argv[0] );
				return false;
			}
			*sOpt = true;
			*sVal = (int) number;
                        break ;

            case 'n':   end = optarg;
			number = strtol( optarg, &end, numbase);
			if (end == optarg)
			{
				usage( argv[0] );
				return false;
			}
			*nOpt = true;
			*nVal = (int) number;
                        break ;

            default:	usage( argv[0] ) ;   // invalid options found
                        return false ;
        }
    }

    // Get the mandatory file name
    // Exactly ONE FileName must be passed at the end of command line
    if( optind != argc - 1 )
    {
        usage( argv[0] );
        return false;
    }
    *file = argv[optind];
    return true;
}

/*-------------------------------------------------------------------------*/

bool read_bytes (FILE *file, unsigned long start, unsigned long count, void* buffer)
{
    if ( fseek ( file, start, SEEK_SET ) != 0 )
	return false;   // Invalid starting location in the file
    if( fread( buffer, count, 1, file ) != 1 )
	return false;  // The desired number of bytes could not be read from the file
    return true;
}
/*-------------------------------------------------------------------------*/

#define MAXBUF  2000

int main (int argc, char **argv)
{
    bool        s_opt , n_opt ;
    unsigned    s_val , n_val ;
    char        *fname = NULL ;
    uint8_t     data[MAXBUF] ;

    // Parse command line and check for failure
    if( ! parse_CL ( argc, argv, &s_opt, &s_val, &n_opt, &n_val, &fname ) )
        exit( EXIT_FAILURE );

    if( !fname )  // Parsing succeeds, but no file name, it was a '-h' case
        exit( EXIT_SUCCESS );

    // Open the input file
    FILE *input = fopen( fname, "r" );
    if( !input )
    {
        puts("Failed to read file");
        exit( EXIT_FAILURE );
    }

    // Read the desired file bytes into the buffer
    if( ! read_bytes( input, s_val, n_val, &data ) )
    {
        puts("Failed to read file");
        exit( EXIT_FAILURE );
    }

    // Now, dump those bytes to the stdout in hexadecimal format
    int i=0 ;
    while ( i < n_val )
    {
        printf("%08x  ", i + 16);
	do
	{
	    printf("%02x ", data[i]);
	    i++;
	    if (i % 8 == 0)
		printf(" ");
	}
	while(i % 16 != 0 && i < n_val);
	printf("\n") ;
    }

    exit( EXIT_SUCCESS );
}
