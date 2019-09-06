<?xml version='1.0' encoding='UTF-8'?>
<Project Type="Project" LVVersion="16008000">
	<Item Name="My Computer" Type="My Computer">
		<Property Name="server.app.propertiesEnabled" Type="Bool">true</Property>
		<Property Name="server.control.propertiesEnabled" Type="Bool">true</Property>
		<Property Name="server.tcp.enabled" Type="Bool">false</Property>
		<Property Name="server.tcp.port" Type="Int">0</Property>
		<Property Name="server.tcp.serviceName" Type="Str">My Computer/VI Server</Property>
		<Property Name="server.tcp.serviceName.default" Type="Str">My Computer/VI Server</Property>
		<Property Name="server.vi.callsEnabled" Type="Bool">true</Property>
		<Property Name="server.vi.propertiesEnabled" Type="Bool">true</Property>
		<Property Name="specify.custom.address" Type="Bool">false</Property>
		<Item Name="AD9959controlAS1_B1.vi" Type="VI" URL="../../../AD9959/AD9959controlAS1_B1.vi"/>
		<Item Name="getWavelengthDisp.vi" Type="VI" URL="../../../Wavemeter/getWavelengthDisp.vi"/>
		<Item Name="getWavelengthNoDisp.vi" Type="VI" URL="../../../Wavemeter/getWavelengthNoDisp.vi"/>
		<Item Name="Dependencies" Type="Dependencies">
			<Item Name="vi.lib" Type="Folder">
				<Item Name="Beep.vi" Type="VI" URL="/&lt;vilib&gt;/Platform/system.llb/Beep.vi"/>
				<Item Name="Check if File or Folder Exists.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/libraryn.llb/Check if File or Folder Exists.vi"/>
				<Item Name="Error Cluster From Error Code.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Error Cluster From Error Code.vi"/>
				<Item Name="ex_CorrectErrorChain.vi" Type="VI" URL="/&lt;vilib&gt;/express/express shared/ex_CorrectErrorChain.vi"/>
				<Item Name="NI_AALBase.lvlib" Type="Library" URL="/&lt;vilib&gt;/Analysis/NI_AALBase.lvlib"/>
				<Item Name="NI_FileType.lvlib" Type="Library" URL="/&lt;vilib&gt;/Utility/lvfile.llb/NI_FileType.lvlib"/>
				<Item Name="NI_PackedLibraryUtility.lvlib" Type="Library" URL="/&lt;vilib&gt;/Utility/LVLibp/NI_PackedLibraryUtility.lvlib"/>
				<Item Name="subFile Dialog.vi" Type="VI" URL="/&lt;vilib&gt;/express/express input/FileDialogBlock.llb/subFile Dialog.vi"/>
				<Item Name="subTimeDelay.vi" Type="VI" URL="/&lt;vilib&gt;/express/express execution control/TimeDelayBlock.llb/subTimeDelay.vi"/>
				<Item Name="Write Delimited Spreadsheet (DBL).vi" Type="VI" URL="/&lt;vilib&gt;/Utility/file.llb/Write Delimited Spreadsheet (DBL).vi"/>
				<Item Name="Write Delimited Spreadsheet (I64).vi" Type="VI" URL="/&lt;vilib&gt;/Utility/file.llb/Write Delimited Spreadsheet (I64).vi"/>
				<Item Name="Write Delimited Spreadsheet (string).vi" Type="VI" URL="/&lt;vilib&gt;/Utility/file.llb/Write Delimited Spreadsheet (string).vi"/>
				<Item Name="Write Delimited Spreadsheet.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/file.llb/Write Delimited Spreadsheet.vi"/>
				<Item Name="Write Spreadsheet String.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/file.llb/Write Spreadsheet String.vi"/>
			</Item>
			<Item Name="AD9959 Register Table.vi" Type="VI" URL="../../../AD9959/SubVIs/AD9959_USB.llb/AD9959 Register Table.vi"/>
			<Item Name="Bits to Byte String.vi" Type="VI" URL="../../../AD9959/SubVIs/AD9959_USB.llb/Bits to Byte String.vi"/>
			<Item Name="ChannelASF.vi" Type="VI" URL="../../../AD9959/SubVIs/ChannelASF.vi"/>
			<Item Name="CLDevIFace.dll" Type="Document" URL="../../../Wavemeter/x32/CLDevIFace.dll"/>
			<Item Name="DataFileCreator_MR.vi" Type="VI" URL="../../../../../Misc/DataFileCreator_MR.vi"/>
			<Item Name="DoWrite.vi" Type="VI" URL="../../../AD9959/SubVIs/DoWrite.vi"/>
			<Item Name="FallTimeInterval.vi" Type="VI" URL="../../../AD9959/SubVIs/FallTimeInterval.vi"/>
			<Item Name="FreqWord.vi" Type="VI" URL="../../../AD9959/SubVIs/FreqWord.vi"/>
			<Item Name="Initialize.vi" Type="VI" URL="../../../AD9959/SubVIs/Initialize.vi"/>
			<Item Name="IOUpdate.vi" Type="VI" URL="../../../AD9959/SubVIs/IOUpdate.vi"/>
			<Item Name="lvanlys.dll" Type="Document" URL="/&lt;resource&gt;/lvanlys.dll"/>
			<Item Name="MasterReset.vi" Type="VI" URL="../../../AD9959/SubVIs/MasterReset.vi"/>
			<Item Name="ProfilePins.vi" Type="VI" URL="../../../AD9959/SubVIs/ProfilePins.vi"/>
			<Item Name="TimeInterval.vi" Type="VI" URL="../../../AD9959/SubVIs/TimeInterval.vi"/>
			<Item Name="USB Bulk Write.vi" Type="VI" URL="../../../AD9959/SubVIs/AD9959_USB.llb/USB Bulk Write.vi"/>
		</Item>
		<Item Name="Build Specifications" Type="Build"/>
	</Item>
</Project>
