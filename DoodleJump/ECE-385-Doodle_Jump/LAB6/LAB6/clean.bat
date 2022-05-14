@echo off
@echo --------------------------------------------------------------
@echo                Quartus系列工程代码垃圾清理程序
@echo --------------------------------------------------------------

setlocal enabledelayedexpansion

for /r . %%a in (db) do (  
  if exist %%a (
        del "%%a\*.ammdb"
        del "%%a\*.bpm"
        del "%%a\*.cdb"
        del "%%a\*.db_info"
        del "%%a\*.ddb"
        del "%%a\*.hdb"
        del "%%a\*.rdb"
        del "%%a\*.sci"
        del "%%a\*.qmsg"
        del "%%a\*.rvd"
        del "%%a\*.logdb"
        del "%%a\*.kpt"
        del "%%a\*.hif"
        del "%%a\*.hier_info"
        del "%%a\*.html"
        del "%%a\*.ipinfo"
        del "%%a\*.mif"
        del "%%a\*.xml"
        del "%%a\*_dump.txt"
        del "%%a\*_action.txt"
        del "%%a\*.lpc.txt"
        del "%%a\*.idb"
        del "%%a\*.tdb"
        del "%%a\*.syn_hier_info"
        del "%%a\*_heursitic.dat"
        del "%%a\*.tmw_info"
        del "%%a\*.bak"

        echo "delete" %%a
        rd "%%a"
)
)

for /r . %%a in (incremental_db) do (  
  if exist %%a (
        del "%%a\README"

        for /r . %%a in (compiled_partitions) do (  
            if exist %%a (
                del "%%a\*.sig"
                del "%%a\*.rcfdb"
                del "%%a\*.logdb"
                del "%%a\*.hdb"
                del "%%a\*.hb_info"
                del "%%a\*.dpi"
                del "%%a\*.dfp"
                del "%%a\*.db_info"
                del "%%a\*.cdb"
                del "%%a\*.kpt"
                del "%%a\*.ammdb"

                echo "delete" %%a
                rd "%%a"
        )
  )

        echo "delete" %%a
        rd "%%a"
)
)

for /r . %%a in (simulation) do (  
  if exist %%a (

        for /r . %%a in (modelsim) do (  
            if exist %%a (
                del "%%a\*.wlf"
                del "%%a\*.sdo"
                del "%%a\*.bak*"
                del "%%a\*.xrf"
                del "%%a\*.vo"
                del "%%a\*.sft"
                del "%%a\msim_transcript"
                del "%%a\*.ini"

                rd  /s /q "%%a\rtl_work"

                echo "delete" %%a
                rd "%%a"
        )
  )

        echo "delete" %%a
        rd "%%a"
)
)

for /r . %%a in (output_files) do (  
  if exist %%a (
        del "%%a\*.done"
        del "%%a\*.smsg"
        del "%%a\*.summary"
        del "%%a\*.jdi"
        del "%%a\*.smsg"

        echo "delete" %%a
        rd "%%a"
)
)

for /r . %%a in (*.rpt) do (  
  if exist %%a (
  echo "delete" %%a
  del "%%a"
)
)
@echo off
@echo --------------------------------------------------------------
@echo                           操作执行完成
@echo --------------------------------------------------------------
pause