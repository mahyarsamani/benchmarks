#include "gups_kernels.h"

#include <stdlib.h>

#define POLY 7
#define PERIOD 1317624576693539401LL

uint64_t RNG(int64_t n)
{
  int i, j;
  uint64_t m2[64];
  uint64_t temp, ran;

  while (n < 0) n += PERIOD;
  while (n > PERIOD) n -= PERIOD;
  if (n == 0) return 0x1;

  temp = 0x1;
  for (i=0; i<64; i++) {
    m2[i] = temp;
    temp = (temp << 1) ^ ((int64_t) temp < 0 ? POLY : 0);
    temp = (temp << 1) ^ ((int64_t) temp < 0 ? POLY : 0);
  }

  for (i=62; i>=0; i--)
    if ((n >> i) & 1)
      break;

  ran = 0x2;
  while (i > 0) {
    temp = 0;
    for (j=0; j<64; j++)
      if ((ran >> j) & 1)
        temp ^= m2[j];
    ran = temp;
    i -= 1;
    if ((n >> i) & 1)
      ran = (ran << 1) ^ ((int64_t) ran < 0 ? POLY : 0);
  }

  return ran;
}

void doRandomAccess(TElement* __restrict__ table, const TIndex tableSize, const TIndex numUpdates, const TIndex numUpdatesPerBurst)
{
    TIndex* index = malloc(sizeof(TIndex) * numUpdatesPerBurst);
    for (TIndex i = 0; i < numUpdatesPerBurst; i++)
        index[i] = RNG((numUpdates/numUpdatesPerBurst) * i);
    for (TIndex i = 0; i < numUpdates / numUpdatesPerBurst; i++)
    {
        #pragma omp parallel for simd
        for (TIndex j = 0; j < numUpdatesPerBurst; j++)
        {
            index[j] = (index[j] << 1) ^ ((TSignedIndex) index[j] < 0 ? POLY : 0);
            table[index[j] & (tableSize-1)] ^= index[j];
        }
    }
    free(index);
}
