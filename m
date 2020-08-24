Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9576F24FCE7
	for <lists+linux-spi@lfdr.de>; Mon, 24 Aug 2020 13:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbgHXLpV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 24 Aug 2020 07:45:21 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:59842 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726611AbgHXLpT (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 24 Aug 2020 07:45:19 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 07OBj8To046466;
        Mon, 24 Aug 2020 06:45:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1598269508;
        bh=ylz2yEP7MNmFHxlW15UvscwqbJnFF/9ciAx038v5df0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=KhgJl73nvKfP0FUEZHVllgKaMVUa28jQXsIQhjiSMskfHwuFbIUjBdELvE0/chWKv
         0GvfctxAIt8BuiaykVbNakghsJIdpFvQb7EcE+bQHHKg/CxCeR0CMbDiA6pmjH2My3
         3qa+i3KMBqk8p+m6q+i/0j5XbLgiwradbP4HAYPA=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 07OBj8mn126368;
        Mon, 24 Aug 2020 06:45:08 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 24
 Aug 2020 06:45:07 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 24 Aug 2020 06:45:08 -0500
Received: from [10.250.235.166] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 07OBj4ck089288;
        Mon, 24 Aug 2020 06:45:04 -0500
Subject: Re: [RESEND PATCH v3 5/8] mtd: spi-nor: cadence-quadspi: Handle probe
 deferral while requesting DMA channel
To:     Jan Kiszka <jan.kiszka@web.de>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Mark Brown <broonie@kernel.org>
CC:     Boris Brezillon <bbrezillon@kernel.org>,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <simon.k.r.goldschmidt@gmail.com>,
        <dinguyen@kernel.org>, <marex@denx.de>
References: <20200601070444.16923-1-vigneshr@ti.com>
 <20200601070444.16923-6-vigneshr@ti.com>
 <6c8d9bff-3a67-0e6c-d4d1-36b7ed5007b9@web.de>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <8cebd31a-2366-4584-b1d1-faa30c18ed6a@ti.com>
Date:   Mon, 24 Aug 2020 17:15:03 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <6c8d9bff-3a67-0e6c-d4d1-36b7ed5007b9@web.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 8/22/20 11:35 PM, Jan Kiszka wrote:
> On 01.06.20 09:04, Vignesh Raghavendra wrote:
>> dma_request_chan_by_mask() can throw EPROBE_DEFER if DMA provider
>> is not yet probed. Currently driver just falls back to using PIO mode
>> (which is less efficient) in this case. Instead return probe deferral
>> error as is so that driver will be re probed once DMA provider is
>> available.
>>
>> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
>> Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>
>> ---
[...]
>>
>>  static const struct spi_nor_controller_ops cqspi_controller_ops = {
>> @@ -1269,8 +1274,11 @@ static int cqspi_setup_flash(struct cqspi_st *cqspi, struct device_node *np)
>>  			dev_dbg(nor->dev, "using direct mode for %s\n",
>>  				mtd->name);
>>
>> -			if (!cqspi->rx_chan)
>> -				cqspi_request_mmap_dma(cqspi);
>> +			if (!cqspi->rx_chan) {
>> +				ret = cqspi_request_mmap_dma(cqspi);
>> +				if (ret == -EPROBE_DEFER)
>> +					goto err;
>> +			}
>>  		}
>>  	}
>>
>>
> 
> This seem to break reading the SPI flash on our IOT2050 [1] (didn't test
> the eval board yet).
> 
> Without that commit, read happens via PIO, and that works. With the
> commit, the pattern
> 
> with open("out.bin", "wb") as out:
>     pos = 0
>     while pos < 2:
>         with open("/dev/mtd0", "rb") as mtd:
>            mtd.seek(pos * 0x10000)
>            out.write(mtd.read(0x10000))
>         pos += 1
> 
> gives the wrong result for the second block while

Interesting... Could you please explain wrong result? Is the data move
around or completely garbage?

Does this fail even on AM654 EVM? Could you share full script for me to
test locally?

What is the flash on the board?

> 
> with open("out2.bin", "wb") as out:
>     with open("/dev/mtd0", "rb") as mtd:
>         out.write(mtd.read(0x20000))
> 
> (or "mtd_debug read") is fine.
> 
> What could be the reason? Our DTBs and k3-am654-base-board.dtb had some
> deviations /wrt the ospi node, but aligning ours to the base board made
> no difference.
> 
> Jan
> 
> [1] https://github.com/siemens/linux/commits/jan/iot2050
> 
