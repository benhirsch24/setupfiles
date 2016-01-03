if exists("did_load_filetypes")
   finish
else
   augroup filetypedetect
      au! BufRead,BufNewFile *.mm setfiletype objc
   augroup END
endif
