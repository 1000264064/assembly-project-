.model small

.data
x dw ?
y db ?
flag1 db ?
flag2 db 0
arr dw 256 dup(?)
msg db "=> Maximum number of elments is 256 & Element consists of 2 digits.", "$"
msg1 db 0ah,0dh,"Enter your elements : ", "$"
msg2 db 0ah,0dh,"your elements is already sorted.", "$"
nl db 0ah,0dh,"Elements after sorting =>", "$"

.code
    main proc far
        .startup
            ;Constrains 
            lea dx, msg
            mov ah, 09h
            int 21h
            
            lea dx, msg1
            mov ah, 09h
            int 21h
        
        
            
            lea bp, arr 
            mov cx, 0   ;CX => number of elemnts - 1 for Comparisons in Buuble sort
            ;Accept data from user
            Accept:
                mov ah, 01h
                int 21h
                
                cmp al, ' '
                je n
                
                cmp al, 13
                je i
                
                jmp j
                
            n:
                inc cx
                jmp Accept 
            
            j:
                mov [bp], al
                inc bp
                jmp Accept
            i:
                jmp Execution
     
            
            Execution:
                
                mov x, cx
                inc x      ;X => number of elements for print data
                
                mov bx, cx 
                mov di, cx
                
                call ExecuteBubbleSort
                
                lea bp, arr
                ;print new line
                lea dx, nl
                mov ah,09h
                int 21h
                
            print1:
                mov dl, ' '
                mov ah,02h
                int 21h
                mov y, 2
                
                print2:
                    mov dl,[bp]
                    mov ah,02h
                    int 21h
                    
                    dec y
                    inc bp
                    cmp y,0
                    jne print2
                    
                    dec x
                    cmp x,0
                    jne print1

        .exit
    main endp
    
    ExecuteBubbleSort proc near
        
         
        init:
            mov flag1, 0
            lea bp, arr
            mov cx, bx
        
        Cmp1:
            mov ax, [bp]
            cmp al, [bp + 2 ]
            jg Swap
            jl NoSwap
            jmp Cmp2
        
        NoSwap:
            add bp, 2
            
            dec cx
            jnz Cmp1
            jmp Check
            
        
        Swap:
            mov si, [bp + 2]
            mov word ptr [bp + 2], ax
            mov [bp], si
            add bp, 2
            
            inc flag1
            inc flag2
            dec cx
            jnz Cmp1
            jmp Check
        
        Cmp2:
            mov dx,[bp + 2]
            cmp ah, dh
            jle NoSwap
            jmp Swap      
           
        
        Check: 
            cmp flag2, 0
            je pri
            
            cmp flag1,0
            je end
             
            dec bx
            dec di
            jnz init
            jmp end
        
        pri:
            lea dx, msg2
            mov ah,09h
            int 21h
            ; Finish the program
            .exit 
        
        end:
            ret
    ExecuteBubbleSort endp
end main