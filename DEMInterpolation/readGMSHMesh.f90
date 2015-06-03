!   Read mesh from GMSH format files
	subroutine readGMSHMesh()
	USE COMMON_MODULE
	implicit none

	integer*4 i
	integer*4 iTemp1, iTemp2
	character*100 string
    integer*4 iDummy
	integer*4 points_temp(4), mark_temp
    
    character ( len = 255 ) text
    integer ( kind = 4 ) input_stat
    
    integer(kind=4) length
    
    !external s_to_i4


     !read data files from GMSH format file of face from GMSH
	 tempfilename=trim(meshfilename)//'.msh'
	 write(*,*)   tempfilename
     
	 open(1, file = tempfilename, status = 'old', iostat = ios)
     if ( ios /= 0 ) then
           ierror = 1
           write ( *, '(a)' ) ' '
           write ( *, '(a)' ) 'Could not open the input file'
           
		   stop
     end if

     !read out 4 line of comments
     read(1,*) string
	 read(1,*) string
	 read(1,*) string
	 read(1,*) string
       
	 read(1,*) nNodes

       do i = 1, nNodes
           read(1, *) iDummy,pcoor(i,1),pcoor(i,2),pcoor(i,3)
       enddo
	
	!read out 2 line of comments 
       read(1,*) string
       read(1,*) string

	!read elements: lines (=1), triangles(=2), quad (=3)
	 nElementType=1
	 iTemp1=0
	 
	 read(1,*) nElements

	 do i=1, nElements
 		 read(1,*) iDummy,nElementType(i),mark_temp,iDummy,iDummy, &
      			   points_temp(1),points_temp(2)

         if(nElementType(i)==1) then   !readout lines
			iTemp1=iTemp1+1
	     elseif(nElementType(i)==2.or.nElementType(i)==3) then
	        goto 100
         else 
            write(*,*) 'Element types not supported.'
            stop
	     end if
	 end do

100	 nBoundaryEdges=iTemp1
	 nFaces=nElements - nBoundaryEdges

	 rewind 1

     !read out 4 line of comments
     read(1,*) string
	 read(1,*) string
	 read(1,*) string
	 read(1,*) string
       
	 read(1,*) nNodes	

       do i = 1, nNodes
           read(1, *) iDummy,pcoor(i,1),pcoor(i,2),pcoor(i,3)
       enddo
	
	!read out 2 line of comments 
       read(1,*) string
       read(1,*) string
	 
	 read(1,*) nElements

	 do i = 1, nBoundaryEdges 
 		 read(1,*) iDummy,nElementType(i),iDummy,iDummy,iDummy,points_temp(1),points_temp(2)

	     	boundaryEdgeMarkers(i)=mark_temp
			boundaryEdgePoints(i,1)=points_temp(1)
			boundaryEdgePoints(i,2)=points_temp(2)
     enddo

     !read triangles or quads    
	 do i = 1, nFaces 
         read ( 1, '(a)', iostat = input_stat ) text
         
 		 !read(1,*) iDummy,nElementType,iDummy, mark_temp,iDummy,iDummy, &
     	 !		   points_temp(1),points_temp(2),points_temp(3)

         !read a iDummy
         call s_to_i4 ( text, iDummy, ierror, length )
         text = text(length+1:)
         
         !read nElementType
         call s_to_i4 ( text, nElementType(i+nBoundaryEdges), ierror, length )
         text = text(length+1:)
         
         !read a iDummy
         call s_to_i4 ( text, iDummy, ierror, length )
         text = text(length+1:)

         !read mark_temp
         call s_to_i4 ( text, mark_temp, ierror, length )
         text = text(length+1:)
         
         !read a iDummy
         call s_to_i4 ( text, iDummy, ierror, length )
         text = text(length+1:)
        
         
         !read a points_temp(1)
         call s_to_i4 ( text, points_temp(1), ierror, length )
         text = text(length+1:)
         
         !read a points_temp(2)
         call s_to_i4 ( text, points_temp(2), ierror, length )
         text = text(length+1:)

         !read a points_temp(3)
         call s_to_i4 ( text, points_temp(3), ierror, length )
         text = text(length+1:)

         if(nElementType(i+nBoundaryEdges)==3)  then !quad
            !read a points_temp(4)
            call s_to_i4 ( text, points_temp(4), ierror, length )
         endif
            
        
			facePoints(i,1)=points_temp(1)
			facePoints(i,2)=points_temp(2)
			facePoints(i,3)=points_temp(3)

            if(nElementType(i+nBoundaryEdges)==2) then !triangle
			   faceEdgesNum(i)=3 
			   !facePoints(i,4)=points_temp(1) !make a loop
            elseif(nElementType(i+nBoundaryEdges)==3) then !quad
			   faceEdgesNum(i)=4 
			   facePoints(i,4)=points_temp(4) !make a loop
            endif
               
 	 enddo

     close(1)

    end subroutine

    subroutine s_to_i4 ( s, ival, ierror, length )

!*****************************************************************************80
!
!! S_TO_I4 reads an I4 from a string.
!
!  Licensing:
!
!    This code is distributed under the GNU LGPL license.
!
!  Modified:
!
!    28 June 2000
!
!  Author:
!
!    John Burkardt
!
!  Parameters:
!
!    Input, character ( len = * ) S, a string to be examined.
!
!    Output, integer ( kind = 4 ) IVAL, the integer value read from the string.
!    If the string is blank, then IVAL will be returned 0.
!
!    Output, integer ( kind = 4 ) IERROR, an error flag.
!    0, no error.
!    1, an error occurred.
!
!    Output, integer ( kind = 4 ) LENGTH, the number of characters of S
!    used to make IVAL.
!
  implicit none

  character c
  integer ( kind = 4 ) i
  integer ( kind = 4 ) ierror
  integer ( kind = 4 ) isgn
  integer ( kind = 4 ) istate
  integer ( kind = 4 ) ival
  integer ( kind = 4 ) length
  character ( len = * ) s

  ierror = 0
  istate = 0
  isgn = 1
  ival = 0

  do i = 1, len_trim ( s )

    c = s(i:i)
!
!  Haven't read anything.
!
    if ( istate == 0 ) then

      if ( c == ' ' ) then

      else if ( c == '-' ) then
        istate = 1
        isgn = -1
      else if ( c == '+' ) then
        istate = 1
        isgn = + 1
      else if ( lle ( '0', c ) .and. lle ( c, '9' ) ) then
        istate = 2
        ival = ichar ( c ) - ichar ( '0' )
      else
        ierror = 1
        return
      end if
!
!  Have read the sign, expecting digits.
!
    else if ( istate == 1 ) then

      if ( c == ' ' ) then

      else if ( lle ( '0', c ) .and. lle ( c, '9' ) ) then
        istate = 2
        ival = ichar ( c ) - ichar ( '0' )
      else
        ierror = 1
        return
      end if
!
!  Have read at least one digit, expecting more.
!
    else if ( istate == 2 ) then

      if ( lle ( '0', c ) .and. lle ( c, '9' ) ) then
        ival = 10 * ival + ichar ( c ) - ichar ( '0' )
      else
        ival = isgn * ival
        length = i - 1
        return
      end if

    end if

  end do
!
!  If we read all the characters in the string, see if we're OK.
!
  if ( istate == 2 ) then
    ival = isgn * ival
    length = len_trim ( s )
  else
    ierror = 1
    length = 0
  end if

  return
end