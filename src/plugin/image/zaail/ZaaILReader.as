package plugin.image.zaail 
{
	import flash.utils.ByteArray;
	import plugin.image.utils.IDataReader;
	import cmodule.zaail.CLibInit;
	
	/**
	 * ...
	 * @author Gary Paluk - http://www.plugin.io
	 */
	public class ZaaILReader implements IDataReader
	{
		
		protected var lib:Object;
		protected var loader:CLibInit;
		
		private var _data:ByteArray;
		
		public function ZaaILReader( data:ByteArray ) 
		{
			_data = data;
			loader = new CLibInit();
			lib = loader.init();
			loader.supplyFile(ref.name, fileContents);
			
			lib.ilInit();
			lib.ilOriginFunc(ZaaILInterface.IL_ORIGIN_UPPER_LEFT);
			lib.ilEnable(ZaaILInterface.IL_ORIGIN_SET);
			
			if(lib.ilLoadImage(ref.name) != 1)	// 1 means successful load
			{
				trace("Error: Unable to parse the loaded file.");
			}
			
			var width:int = lib.ilGetInteger(ZaaILInterface.IL_IMAGE_WIDTH);
			var height:int = lib.ilGetInteger(ZaaILInterface.IL_IMAGE_HEIGHT);
			var depth:int = lib.ilGetInteger(ZaaILInterface.IL_IMAGE_DEPTH);
			lib.ilGetPixels(0, 0, 0, width, height, depth, _data);
			_data.position = 0;
		}
		
	}

}