/* Compile like so:
 * cp LibMPEG3.pm bak/
 * swig -perl5 -package MPEG::LibMPEG3 -o libmpeg3.c libmpeg3.i
 * gcc -c libmpeg3_wrap.c -I/usr/lib/perl5/i386-linux/CORE/ -L/usr/lib/perl5/i386-linux/CORE
 * cp bak/LibMPEG3.pm .
 * perl Makefile.PL
 * make
 * make test
 * make install
 */
%module LibMPEG3
%{
#include "libmpeg3.h"
%}

%typemap(perl5,out) unsigned char * { 
   $result = sv_2mortal( newSVpvn( $1, Y_SIZE + (2*UV_SIZE ) ) );
   free($1);
   argvi++;
}

/* Validation, Opening, and Closing the Bitstream */
extern int mpeg3_check_sig(char *path);
extern mpeg3_t* mpeg3_open(char *path);
extern mpeg3_t* mpeg3_open_copy(char *path, mpeg3_t *old_file);
extern int mpeg3_close(mpeg3_t *file);

/* Performance */
extern int mpeg3_set_cpus(mpeg3_t *file, int cpus);
extern int mpeg3_set_mmx(mpeg3_t *file, int use_mmx);

/* Query the MPEG3 stream about audio. */
extern int mpeg3_has_audio(mpeg3_t *file);
extern int mpeg3_total_astreams(mpeg3_t *file);             /* Number of multiplexed audio streams */
extern int mpeg3_audio_channels(mpeg3_t *file, int stream);
extern int mpeg3_sample_rate(mpeg3_t *file, int stream);
extern char* mpeg3_audio_format(mpeg3_t *file, int stream);

/* Total length obtained from the timecode. */
/* For DVD files, this is unreliable. */
extern long mpeg3_audio_samples(mpeg3_t *file, int stream); 
extern int mpeg3_set_sample(mpeg3_t *file, long sample, int stream);  /* Seek to a sample */
extern long mpeg3_get_sample(mpeg3_t *file, int stream);              /* Tell current position */

/* Read a PCM buffer of audio from 1 channel and advance the position. */
/* Return a 1 if error. */
/* Stream defines the number of the multiplexed stream to read. */
/* If both output arguments are null the audio is not rendered. */
extern int mpeg3_read_audio(mpeg3_t *file, 
			    float *output_f,      /* Pointer to pre-allocated buffer of floats */
			    short *output_i,      /* Pointer to pre-allocated buffer of int16's */
			    int channel,          /* Channel to decode */
			    long samples,         /* Number of samples to decode */
			    int stream);          /* Stream containing the channel */

/* Reread the last PCM buffer from a different channel and advance the position */
extern int mpeg3_reread_audio(mpeg3_t *file, 
			      float *output_f,      /* Pointer to pre-allocated buffer of floats */
			      short *output_i,      /* Pointer to pre-allocated buffer of int16's */
			      int channel,          /* Channel to decode */
			      long samples,         /* Number of samples to decode */
			      int stream);          /* Stream containing the channel */

/* Read the next compressed audio chunk.  Store the size in size and return a  */
/* 1 if error. */
/* Stream defines the number of the multiplexed stream to read. */
extern int mpeg3_read_audio_chunk(mpeg3_t *file, 
				  unsigned char *output, 
				  long *size, 
				  long max_size,
				  int stream);

/* Query the stream about video. */
extern int mpeg3_has_video(mpeg3_t *file);
extern int mpeg3_total_vstreams(mpeg3_t *file);             /* Number of multiplexed video streams */
extern int mpeg3_video_width(mpeg3_t *file, int stream);
extern int mpeg3_video_height(mpeg3_t *file, int stream);
extern float mpeg3_aspect_ratio(mpeg3_t *file, int stream); /* aspect ratio.  0 if none */
extern float mpeg3_frame_rate(mpeg3_t *file, int stream);   /* Frames/sec */

/* Total length.   */
/* For DVD files, this is 1 indicating only percentage seeking is available. */
extern long mpeg3_video_frames(mpeg3_t *file, int stream);
extern int mpeg3_set_frame(mpeg3_t *file, long frame, int stream); /* Seek to a frame */
/* extern int mpeg3_skip_frames();	                           THIS IS IN THE HEADER FILE BUT NOT libmpeg3.so! */
extern long mpeg3_get_frame(mpeg3_t *file, int stream);            /* Tell current position */

/* Seek all the tracks based on a percentage of the total bytes in the  */
/* file or the total */
/* time in a toc if one exists.  Percentage is a 0 to 1 double. */
/* This eliminates the need for tocs and 64 bit longs but doesn't  */
/* give frame accuracy. */
extern int mpeg3_seek_percentage(mpeg3_t *file, double percentage);
extern double mpeg3_tell_percentage(mpeg3_t *file);
extern int mpeg3_previous_frame(mpeg3_t *file, int stream);
extern int mpeg3_end_of_audio(mpeg3_t *file, int stream);
extern int mpeg3_end_of_video(mpeg3_t *file, int stream);

/* Give the seconds time in the last packet read */
extern double mpeg3_get_time(mpeg3_t *file);

/* Read a frame.  The dimensions of the input area and output frame must be supplied. */
/* The frame is taken from the input area and scaled to fit the output frame in 1 step. */
/* Stream defines the number of the multiplexed stream to read. */
/* The last row of **output_rows must contain 4 extra bytes for scratch work. */
extern int mpeg3_read_frame(mpeg3_t *file, 
			    unsigned char **output_rows, /* Array of pointers to the start of each output row */
			    int in_x,                    /* Location in input frame to take picture */
			    int in_y, 
			    int in_w, 
			    int in_h, 
			    int out_w,                   /* Dimensions of output_rows */
			    int out_h, 
			    int color_model,             /* One of the color model #defines */
			    int stream);

/* Get the colormodel being used natively by the stream */
extern int mpeg3_colormodel(mpeg3_t *file, int stream);
/* Set the row stride to be used in mpeg3_read_yuvframe */
extern int mpeg3_set_rowspan(mpeg3_t *file, int bytes, int stream);

/* Read a frame in the native color model used by the stream.  */
/* The Y, U, and V planes are copied into the y, u, and v */
/* buffers provided. */
/* The input is cropped to the dimensions given but not scaled. */
extern int mpeg3_read_yuvframe(mpeg3_t *file,
			       char *y_output,
			       char *u_output,
			       char *v_output,
			       int in_x,
			       int in_y,
			       int in_w,
			       int in_h,
			       int stream);

/* Read a frame in the native color model used by the stream.  */
/* The Y, U, and V planes are not copied but the _output pointers */
/* are redirected to the frame buffer. */
extern int mpeg3_read_yuvframe_ptr(mpeg3_t *file,
				   char **y_output,
				   char **u_output,
				   char **v_output,
				   int stream);

/* Drop frames number of frames */
extern int mpeg3_drop_frames(mpeg3_t *file, long frames, int stream);

/* Read the next compressed frame including headers. */
/* Store the size in size and return a 1 if error. */
/* Stream defines the number of the multiplexed stream to read. */
extern int mpeg3_read_video_chunk(mpeg3_t *file, 
				  unsigned char *output, 
				  long *size, 
				  long max_size,
				  int stream);


/* Master control */
/* THESE ARE ALSO MISSING FROM libmpeg3.so! */
/*
  extern int mpeg3_total_programs();
  extern int mpeg3_set_program(int program);
*/

// Some array helpers
%inline %{
  int Y_SIZE = 0, UV_SIZE=0;
  
  unsigned char *get_yuvframe( mpeg3_t *file, int w, int h ) {
    char *y, *u, *v;
    unsigned char *output;
    
    Y_SIZE  = w * h;
    UV_SIZE = Y_SIZE / 4;

    // This is Perl's fancy malloc
    New( 0, output, Y_SIZE + ( 2 * UV_SIZE ), char );

    y = &output[0];
    u = &output[Y_SIZE];
    v = &output[Y_SIZE + UV_SIZE];

    mpeg3_read_yuvframe( file,
			 y, u, v,
			 0, 0, 
			 w, h,
			 0 );

    return &output[0];
  }

%}
