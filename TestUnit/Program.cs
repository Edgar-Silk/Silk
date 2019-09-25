using System;
using SilkWrapper;


namespace TestUnit {
  class Program {

    public static PDF P = new PDF();
    static void Main(string[] args) {

      Console.WriteLine("Initializing Library...");

      //Native.FPDF_InitLibrary();

      string File = "C:/Users/edgar/PDFiumTest/Silk/TestUnit/bin/x64/Release";

      Console.WriteLine("\nOpen PDF file in: " + File);

      //IntPtr doc = Native.FPDF_LoadDocument(File, null);
      PDF.Load(File);

      Console.WriteLine("\nNumber of Pages:" + PDF.PageCount().ToString());

      var inf = PDF.GetInformation();
      Console.WriteLine("\nCreator: " + inf.Creator);
      Console.WriteLine("\nTitle: " + inf.Title);
      Console.WriteLine("\nAuthor: " + inf.Author);
      Console.WriteLine("\nSubject: " + inf.Subject);
      Console.WriteLine("\nKeywords: " + inf.Keywords);
      Console.WriteLine("\nProducer: " + inf.Producer);
      Console.WriteLine("\nCreationDate: " + inf.CreationDate);
      Console.WriteLine("\nModDate: " + inf.ModificationDate);

      Console.WriteLine("\nDestroying library...");


      //Console.ReadKey();

    }
  }
}
