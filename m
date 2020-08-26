Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA35252FFC
	for <lists+linux-spi@lfdr.de>; Wed, 26 Aug 2020 15:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730340AbgHZNcp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 26 Aug 2020 09:32:45 -0400
Received: from lizzard.sbs.de ([194.138.37.39]:59674 "EHLO lizzard.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730288AbgHZNcZ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 26 Aug 2020 09:32:25 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 07QDVu6R019658
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Aug 2020 15:31:56 +0200
Received: from [167.87.242.222] ([167.87.242.222])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 07QDVsHP027829;
        Wed, 26 Aug 2020 15:31:54 +0200
Subject: Re: [RESEND PATCH v3 5/8] mtd: spi-nor: cadence-quadspi: Handle probe
 deferral while requesting DMA channel
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        "Jin, Le (RC-CN DF FA R&D)" <le.jin@siemens.com>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, simon.k.r.goldschmidt@gmail.com,
        dinguyen@kernel.org, marex@denx.de
References: <20200601070444.16923-1-vigneshr@ti.com>
 <20200601070444.16923-6-vigneshr@ti.com>
 <6c8d9bff-3a67-0e6c-d4d1-36b7ed5007b9@web.de>
 <8cebd31a-2366-4584-b1d1-faa30c18ed6a@ti.com>
 <dbba9f0c-4621-2d58-8fb8-4cbe788558f9@siemens.com>
 <eff1b49e-e392-8887-b3a0-3caedc5b81cc@siemens.com>
 <8995f5c5-bd6a-c0e5-1e4f-1744aedd2bcd@siemens.com>
 <5e215c3c-5603-a796-9dea-13b7c2840ed0@ti.com>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <c090b23a-488f-6eb3-206b-a7678b70a4e2@siemens.com>
Date:   Wed, 26 Aug 2020 15:31:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <5e215c3c-5603-a796-9dea-13b7c2840ed0@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 26.08.20 14:18, Vignesh Raghavendra wrote:
> 
> 
> On 8/26/20 3:42 PM, Jan Kiszka wrote:
>> On 24.08.20 19:20, Jan Kiszka wrote:
>>> On 24.08.20 14:49, Jan Kiszka wrote:
>>>> On 24.08.20 13:45, Vignesh Raghavendra wrote:
>>>>>
>>>>>
>>>>> On 8/22/20 11:35 PM, Jan Kiszka wrote:
>>>>>> On 01.06.20 09:04, Vignesh Raghavendra wrote:
>>>>>>> dma_request_chan_by_mask() can throw EPROBE_DEFER if DMA provider
>>>>>>> is not yet probed. Currently driver just falls back to using PIO mode
>>>>>>> (which is less efficient) in this case. Instead return probe deferral
>>>>>>> error as is so that driver will be re probed once DMA provider is
>>>>>>> available.
>>>>>>>
>>>>>>> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
>>>>>>> Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>
>>>>>>> ---
>>>>> [...]
>>>>>>>
>>>>>>>  static const struct spi_nor_controller_ops cqspi_controller_ops = {
>>>>>>> @@ -1269,8 +1274,11 @@ static int cqspi_setup_flash(struct cqspi_st *cqspi, struct device_node *np)
>>>>>>>  			dev_dbg(nor->dev, "using direct mode for %s\n",
>>>>>>>  				mtd->name);
>>>>>>>
>>>>>>> -			if (!cqspi->rx_chan)
>>>>>>> -				cqspi_request_mmap_dma(cqspi);
>>>>>>> +			if (!cqspi->rx_chan) {
>>>>>>> +				ret = cqspi_request_mmap_dma(cqspi);
>>>>>>> +				if (ret == -EPROBE_DEFER)
>>>>>>> +					goto err;
>>>>>>> +			}
>>>>>>>  		}
>>>>>>>  	}
>>>>>>>
>>>>>>>
>>>>>>
>>>>>> This seem to break reading the SPI flash on our IOT2050 [1] (didn't test
>>>>>> the eval board yet).
>>>>>>
>>>>>> Without that commit, read happens via PIO, and that works. With the
>>>>>> commit, the pattern
>>>>>>
>>>>>> with open("out.bin", "wb") as out:
>>>>>>     pos = 0
>>>>>>     while pos < 2:
>>>>>>         with open("/dev/mtd0", "rb") as mtd:
>>>>>>            mtd.seek(pos * 0x10000)
>>>>>>            out.write(mtd.read(0x10000))
>>>>>>         pos += 1
>>>>>>
>>>>>> gives the wrong result for the second block while
>>>>>
>>>>> Interesting... Could you please explain wrong result? Is the data move
>>>>> around or completely garbage?
>>>>
>>>> It looks like some stripes contain data from other parts of the flash or
>>>> kernel RAM. It's not just garbage, there are readable strings included.
>>>>
>>>>>
>>>>> Does this fail even on AM654 EVM? Could you share full script for me to
>>>>> test locally?
>>>>
>>>> The scripts are complete (python). Just binary-diff the outputs.
>>>>
>>>> I'll try on the EVM later.
>>>
>>> Done so now, could reproduce.
>>
>> ..."could *not* reproduce" there. Sorry if that caused confusion.
>>
> 
> Oh, thanks! I was wondering why I cannot see this issue on AM654 EVM at my end...
> 
>>>
>>> But the OSPIs are definitely different. EVM reports
>>>
>>> spi-nor spi0.0: mt35xu512aba (65536 Kbytes)
>>>
>>> with 4K erase size. Our our board, we have
>>>
>>> spi-nor spi7.0: w25q128 (16384 Kbytes)
>>>
>>> with 64K erase size.
>>>
>>> Here is some extract of the hex-diffs between out.bin and out2.bin (the 
>>> latter being the good one):
>>>
>>> --- /dev/fd/63  2020-08-24 17:16:58.776409282 +0000
>>> +++ /dev/fd/62  2020-08-24 17:16:58.776409282 +0000
>>> @@ -6,18 +6,18 @@
>>>  00000050  0f 30 0d 06 03 55 04 07  0c 06 44 61 6c 6c 61 73  |.0...U....Dallas|
>>>  00000060  31 27 30 25 06 03 55 04  0a 0c 1e 54 65 78 61 73  |1'0%..U....Texas|
>>>  00000070  20 49 6e 73 74 72 75 6d  65 6e 74 73 20 49 6e 63  | Instruments Inc|
>>> -00000080  84 8b 96 2c 0c 12 18 03  01 05 05 04 01 02 00 00  |...,............|
>>> -00000090  07 06 44 45 20 01 0d 14  2a 01 00 32 05 24 30 48  |..DE ...*..2.$0H|
>>> -000000a0  60 6c 30 14 01 00 00 0f  ac 04 01 00 00 0f ac 04  |`l0.............|
>>> -000000b0  01 00 00 0f ac 02 0c 00  2d 1a 6f 18 17 ff ff ff  |........-.o.....|
>>> +00000080  6f 72 70 6f 72 61 74 65  64 31 13 30 11 06 03 55  |orporated1.0...U|
>>> +00000090  04 0b 0c 0a 50 72 6f 63  65 73 73 6f 72 73 31 13  |....Processors1.|
>>> +000000a0  30 11 06 03 55 04 03 0c  0a 54 49 20 73 75 70 70  |0...U....TI supp|
>>> +000000b0  6f 72 74 31 1d 30 1b 06  09 2a 86 48 86 f7 0d 01  |ort1.0...*.H....|
>>>  000000c0  09 01 16 0e 73 75 70 70  6f 72 74 40 74 69 2e 63  |....support@ti.c|
>>>  000000d0  6f 6d 30 1e 17 0d 32 30  30 37 32 32 31 31 30 30  |om0...2007221100|
>>>  000000e0  30 30 5a 17 0d 32 30 30  38 32 31 31 31 30 30 30  |00Z..20082111000|
>>>  000000f0  30 5a 30 81 9d 31 0b 30  09 06 03 55 04 06 13 02  |0Z0..1.0...U....|
>>> -00000100  00 00 27 a4 00 00 42 43  5e 00 62 32 2f 00 b4 96  |..'...BC^.b2/...|
>>> -00000110  24 44 0c 00 c6 00 43 0a  00 00 0b f0 43 a5 2a 01  |$D....C.....C.*.|
>>> -00000120  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
>>> -*
>>> +00000100  55 53 31 0b 30 09 06 03  55 04 08 0c 02 54 58 31  |US1.0...U....TX1|
>>> +00000110  0f 30 0d 06 03 55 04 07  0c 06 44 61 6c 6c 61 73  |.0...U....Dallas|
>>> +00000120  31 27 30 25 06 03 55 04  0a 0c 1e 54 65 78 61 73  |1'0%..U....Texas|
>>> +00000130  20 49 6e 73 74 72 75 6d  65 6e 74 73 20 49 6e 63  | Instruments Inc|
>>>  00000140  6f 72 70 6f 72 61 74 65  64 31 13 30 11 06 03 55  |orporated1.0...U|
>>>  00000150  04 0b 0c 0a 50 72 6f 63  65 73 73 6f 72 73 31 13  |....Processors1.|
>>>  00000160  30 11 06 03 55 04 03 0c  0a 54 49 20 73 75 70 70  |0...U....TI supp|
>>>
>>> [...]
>>>
>>>  000017a0  02 8a e5 06 c8 8c e2 14  c2 8a e5 7c 01 00 ea ed  |...........|....|
>>>  000017b0  1f 8f e2 66 02 00 ea 5b  45 72 72 6f 72 5d 20 52  |...f...[Error] R|
>>> -000017c0  69 64 20 55 54 43 20 49  44 21 21 21 0a 00 00 5b  |id UTC ID!!!...[|
>>> -000017d0  45 72 72 6f 72 5d 20 49  6e 76 61 6c 69 64 20 50  |Error] Invalid P|
>>> -000017e0  65 65 72 20 43 68 61 6e  6e 65 6c 20 4e 75 6d 62  |eer Channel Numb|
>>> -000017f0  65 72 21 21 21 0a 00 41  73 73 65 72 74 69 6f 6e  |er!!!..Assertion|
>>> +000017c0  4d 20 41 6c 6c 6f 63 20  54 58 20 43 68 20 66 61  |M Alloc TX Ch fa|
>>> +000017d0  69 6c 65 64 21 21 21 0a  00 00 00 73 72 63 2f 75  |iled!!!....src/u|
>>> +000017e0  64 6d 61 5f 63 68 2e 63  00 00 00 75 74 63 49 6e  |dma_ch.c...utcIn|
>>> +000017f0  66 6f 20 21 3d 20 4e 55  4c 4c 5f 50 54 52 00 75  |fo != NULL_PTR.u|
>>>  00001800  74 63 49 64 20 3c 3d 20  55 44 4d 41 5f 4e 55 4d  |tcId <= UDMA_NUM|
>>>  00001810  5f 55 54 43 5f 49 4e 53  54 41 4e 43 45 00 00 72  |_UTC_INSTANCE..r|
>>>
>>
>> I've done [1] for now in order to make the OSPI usable again here. It
>> looks like reading an mtd device in one chunk (single read syscall) is
>> fine, ie. "dd if=/dev/mtd3 of=content2 bs=<sizeof-mtd3>", while reading
>> it in multiple chunks is problematic, e.g. "dd if=/dev/mtd3 of=content2
>> bs=4096". Interestingly, the deviation is already on the first block,
>> which may speak against a setup issue for a second transfer.
> 
> I cannot think of a reasonable explanation for this. I wonder how the first chunk 
> gets affected when reading in multiple chunks.
> 
>>
>> The content I've seen in the corrupted output may come from other parts
>> of the memory. I've found my WIFI SSID there, which is definitely not
>> part of our OSPI image.
>>
> 
> Hmm, one guess it that QSPI on IoT board is 16MB and hence 

It is 16M, true.

> does not support 4 byte addressing vs the OSPI on AM654 EVM. 
> There could be bug around that case.
> 
> So, could you apply diff [1] on linux-next and then execute 
> falling testcase and post the register dump printed?
> 
> [1]:
> 

Apparently always this:

[  197.602226] cadence-qspi 47040000.spi: REG off 0:  val 80083881
[  197.608181] cadence-qspi 47040000.spi: REG off 1:  val 3
[  197.613512] cadence-qspi 47040000.spi: REG off 2:  val 2
[  197.618833] cadence-qspi 47040000.spi: REG off 3:  val a0a0a0a
[  197.624677] cadence-qspi 47040000.spi: REG off 4:  val 5
[  197.629998] cadence-qspi 47040000.spi: REG off 5:  val 101002
[  197.635759] cadence-qspi 47040000.spi: REG off 6:  val 80
[  197.641165] cadence-qspi 47040000.spi: REG off 7:  val 0
[  197.646488] cadence-qspi 47040000.spi: REG off 8:  val 0
[  197.651809] cadence-qspi 47040000.spi: REG off 9:  val 0

> 
> ---><8---
> 
> 
> diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
> index 508b219eabf80..b9739ae919340 100644
> --- a/drivers/spi/spi-cadence-quadspi.c
> +++ b/drivers/spi/spi-cadence-quadspi.c
> @@ -907,6 +907,10 @@ static int cqspi_direct_read_execute(struct cqspi_flash_pdata *f_pdata,
>         struct dma_async_tx_descriptor *tx;
>         dma_cookie_t cookie;
>         dma_addr_t dma_dst;
> +       int i;
> +
> +       for (i = 0; i < 10; i++)
> +               dev_err(dev, "REG off %x:  val %x\n", i, readl(cqspi->iobase + (i << 2)));
>  
>         if (!cqspi->rx_chan || !virt_addr_valid(buf)) {
>                 memcpy_fromio(buf, cqspi->ahb_base + from, len);
> 
>  
> Also, there seems to be DMA mapping related issue, that was always present in 
> older driver as well. Could you see if diff [2] fixes the issue?
> 
> [2] Use DMA device for mapping:
> 
> ---><8---
> 
> 
> diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
> index b9739ae919340..a546aa4598758 100644
> --- a/drivers/spi/spi-cadence-quadspi.c
> +++ b/drivers/spi/spi-cadence-quadspi.c
> @@ -901,6 +901,7 @@ static int cqspi_direct_read_execute(struct cqspi_flash_pdata *f_pdata,
>  {
>         struct cqspi_st *cqspi = f_pdata->cqspi;
>         struct device *dev = &cqspi->pdev->dev;
> +       struct device *ddev = cqspi->rx_chan->device->dev;
>         enum dma_ctrl_flags flags = DMA_CTRL_ACK | DMA_PREP_INTERRUPT;
>         dma_addr_t dma_src = (dma_addr_t)cqspi->mmap_phys_base + from;
>         int ret = 0;
> @@ -917,8 +918,8 @@ static int cqspi_direct_read_execute(struct cqspi_flash_pdata *f_pdata,
>                 return 0;
>         }
>  
> -       dma_dst = dma_map_single(dev, buf, len, DMA_FROM_DEVICE);
> -       if (dma_mapping_error(dev, dma_dst)) {
> +       dma_dst = dma_map_single(ddev, buf, len, DMA_FROM_DEVICE);
> +       if (dma_mapping_error(ddev, dma_dst)) {
>                 dev_err(dev, "dma mapping failed\n");
>                 return -ENOMEM;
>         }
> @@ -952,7 +953,7 @@ static int cqspi_direct_read_execute(struct cqspi_flash_pdata *f_pdata,
>         }
>  
>  err_unmap:
> -       dma_unmap_single(dev, dma_dst, len, DMA_FROM_DEVICE);
> +       dma_unmap_single(ddev, dma_dst, len, DMA_FROM_DEVICE);
>  
>         return ret;
>  }
> 

That seems to help! Wasn't able to reproduce the issue with this applied
so far.

Thanks,
Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
