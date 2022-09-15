pageextension 50144 GLEExt extends "General Ledger Entries"
{
    layout
    {
        addafter("Global Dimension 2 Code")
        {
            field("Vendor Name";"Vendor Name")
            {
                ApplicationArea = all;
                Visible = true;
                Editable = true;
            }
        }
    }
    actions
    {
        addlast(processing)
        {
            action("Update Vendor Name")
            {
                Caption = 'Update Vendor Name';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()begin
                    Codeunit.Run(Codeunit::ModifyGlEntries);
                end;
            }
        }
    }
    trigger OnOpenPage()begin
        Codeunit.Run(Codeunit::ModifyGLEnt);
    end;
}
