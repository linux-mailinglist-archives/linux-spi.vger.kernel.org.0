Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91BF124FE0A
	for <lists+linux-spi@lfdr.de>; Mon, 24 Aug 2020 14:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgHXMts (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 24 Aug 2020 08:49:48 -0400
Received: from goliath.siemens.de ([192.35.17.28]:53242 "EHLO
        goliath.siemens.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgHXMts (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 24 Aug 2020 08:49:48 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 07OCnNt2009655
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Aug 2020 14:49:24 +0200
Received: from [167.87.131.75] ([167.87.131.75])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 07OCnIUn004790;
        Mon, 24 Aug 2020 14:49:20 +0200
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
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <dbba9f0c-4621-2d58-8fb8-4cbe788558f9@siemens.com>
Date:   Mon, 24 Aug 2020 14:49:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <8cebd31a-2366-4584-b1d1-faa30c18ed6a@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 24.08.20 13:45, Vignesh Raghavendra wrote:
> 
> 
> On 8/22/20 11:35 PM, Jan Kiszka wrote:
>> On 01.06.20 09:04, Vignesh Raghavendra wrote:
>>> dma_request_chan_by_mask() can throw EPROBE_DEFER if DMA provider
>>> is not yet probed. Currently driver just falls back to using PIO mode
>>> (which is less efficient) in this case. Instead return probe deferral
>>> error as is so that driver will be re probed once DMA provider is
>>> available.
>>>
>>> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
>>> Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>
>>> ---
> [...]
>>>
>>>  static const struct spi_nor_controller_ops cqspi_controller_ops = {
>>> @@ -1269,8 +1274,11 @@ static int cqspi_setup_flash(struct cqspi_st *cqspi, struct device_node *np)
>>>  			dev_dbg(nor->dev, "using direct mode for %s\n",
>>>  				mtd->name);
>>>
>>> -			if (!cqspi->rx_chan)
>>> -				cqspi_request_mmap_dma(cqspi);
>>> +			if (!cqspi->rx_chan) {
>>> +				ret = cqspi_request_mmap_dma(cqspi);
>>> +				if (ret == -EPROBE_DEFER)
>>> +					goto err;
>>> +			}
>>>  		}
>>>  	}
>>>
>>>
>>
>> This seem to break reading the SPI flash on our IOT2050 [1] (didn't test
>> the eval board yet).
>>
>> Without that commit, read happens via PIO, and that works. With the
>> commit, the pattern
>>
>> with open("out.bin", "wb") as out:
>>     pos = 0
>>     while pos < 2:
>>         with open("/dev/mtd0", "rb") as mtd:
>>            mtd.seek(pos * 0x10000)
>>            out.write(mtd.read(0x10000))
>>         pos += 1
>>
>> gives the wrong result for the second block while
> 
> Interesting... Could you please explain wrong result? Is the data move
> around or completely garbage?

It looks like some stripes contain data from other parts of the flash or
kernel RAM. It's not just garbage, there are readable strings included.

> 
> Does this fail even on AM654 EVM? Could you share full script for me to
> test locally?

The scripts are complete (python). Just binary-diff the outputs.

I'll try on the EVM later.

> 
> What is the flash on the board?

Le, could you answer that more precisely than I could?

Thanks,
Jan

> 
>>
>> with open("out2.bin", "wb") as out:
>>     with open("/dev/mtd0", "rb") as mtd:
>>         out.write(mtd.read(0x20000))
>>
>> (or "mtd_debug read") is fine.
>>
>> What could be the reason? Our DTBs and k3-am654-base-board.dtb had some
>> deviations /wrt the ospi node, but aligning ours to the base board made
>> no difference.
>>
>> Jan
>>
>> [1] https://github.com/siemens/linux/commits/jan/iot2050
>>

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
