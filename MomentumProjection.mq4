#property strict
#property indicator_separate_window
#property indicator_buffers 2
#property indicator_color1 Purple
#property indicator_color2 Black
#property indicator_width1 1
#property indicator_width2 1
#property indicator_level1 0.0
#property indicator_levelcolor Black
#property indicator_levelstyle STYLE_DOT

input int Per       = 14;
input int DrawShift = 14;
input int MaPeriod  = 34;

double SignalBuffer[];
double MABuffer[];

int OnInit()
{
   SetIndexBuffer(0, SignalBuffer);
   SetIndexStyle(0, DRAW_LINE, STYLE_SOLID, 1);
   SetIndexLabel(0, "Signal(" + IntegerToString(Per) + ")");
   SetIndexShift(0, DrawShift);

   SetIndexBuffer(1, MABuffer);
   SetIndexStyle(1, DRAW_LINE, STYLE_SOLID, 1);
   SetIndexLabel(1, "MA(" + IntegerToString(MaPeriod) + ")");
   SetIndexShift(1, DrawShift);

   IndicatorShortName("MomentumProjection (" +
                      IntegerToString(Per) + " " +
                      IntegerToString(DrawShift) + " " +
                      IntegerToString(MaPeriod) + ")");
   return INIT_SUCCEEDED;
}

int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
{
   double point = MarketInfo(Symbol(), MODE_POINT);
   if(point <= 0) point = Point;

   int limit = rates_total - prev_calculated;
   if(prev_calculated == 0) limit = rates_total - Per - 1;

   for(int i = limit; i >= 0; i--)
   {
      double imp = 0;
      for(int j = i; j >= i - Per + 1; j--)
      {
         if(j < 0) continue;
         imp += (close[j] - open[j]) / point;
      }
      SignalBuffer[i] = imp;
   }

   for(int i = limit; i >= 0; i--)
   {
      double sum   = 0;
      int    count = 0;
      for(int j = i; j <= i + MaPeriod - 1; j++)
      {
         if(j >= rates_total) continue;
         sum += SignalBuffer[j];
         count++;
      }
      MABuffer[i] = (count > 0) ? sum / count : 0;
   }

   return rates_total;
}
