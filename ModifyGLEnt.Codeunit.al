codeunit 50145 ModifyGLEnt
{
    Permissions = tabledata "G/L Entry"=rmd;

    trigger OnRun()var GLEnt: Record "G/L Entry";
    DimEntry: Record "Dimension Set Entry";
    DimVal: Record "Dimension Value";
    DimVendor: Text;
    begin
        GLEnt.SetFilter("Dimension Set ID", '>0');
        GLEnt.setfilter("Vendor Name", '=%1', '');
        if GLEnt.FindSet()then repeat DimVendor:='';
                DimEntry.SetFilter("Dimension Set ID", '%1', GLEnt."Dimension Set ID");
                if DimEntry.FindSet()then repeat if DimEntry."Dimension Code" = 'VENDOR' then begin
                            dimval.SetFilter(dimval.Code, '%1', DimEntry."Dimension Value Code");
                            if DimVal.FindFirst()then begin
                                DimVendor:=dimval.Name;
                            end;
                        end until DimEntry.Next() = 0;
                if DimVendor <> '' then begin
                    GLEnt."Vendor Name":=DimVendor;
                    GLEnt.Modify();
                end;
            until GLEnt.Next() = 0;
    end;
}
