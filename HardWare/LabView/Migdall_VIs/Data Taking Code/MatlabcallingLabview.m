e=actxserver('LabVIEW.Application');
%vipath='c:\Documents and Settings\mwolfson.REDSHIFT\Desktop\testx.vi';
vipath='X:\Alazar\SimpleWaitABit.vi';

vi=invoke(e,'GetVIReference',vipath);
vi.SetControlValue('Numeric',10)
vi.Run
a=vi.GetControlValue('msoutput')