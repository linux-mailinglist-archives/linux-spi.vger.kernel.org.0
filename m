Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5E932B1E44
	for <lists+linux-spi@lfdr.de>; Fri, 13 Nov 2020 16:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgKMPIl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 13 Nov 2020 10:08:41 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:45720 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbgKMPIl (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 13 Nov 2020 10:08:41 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0ADF8dvV081370;
        Fri, 13 Nov 2020 09:08:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605280119;
        bh=m8nFFmLVv2WbpY2yr/S4nVTy31Elh4nzvbCxMh6vqpM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=T8jbroIEFrSXMFM71HRv3nbjaO/eVqs7oH6KT9vJZKEcUNwSUZ8+SAYUFIjNh3qOh
         iiSE//pymTd5IimpSGNiXsswcZLhuyP8F1f2lYQR51UJU4olbiczhPWp/ULqZDv2bG
         02XisS4JgxSRqbxrSTBlLdCGcpB0Ggb3oUOOHuzY=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0ADF8dXL023459
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 13 Nov 2020 09:08:39 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 13
 Nov 2020 09:08:38 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 13 Nov 2020 09:08:38 -0600
Received: from [10.250.233.179] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0ADF8bTR004583;
        Fri, 13 Nov 2020 09:08:37 -0600
Subject: Re: Linux SPI Slave fails to respond under high load on BeagleBone
 Black
To:     Glenn Schmottlach <gschmottlach@gmail.com>
CC:     <linux-spi@vger.kernel.org>, <broonie@kernel.org>
References: <CAMS2kBHyempbPTT5dnJ8Vb+FMop4-BjyKa4A=tB+U-cS4h7aDw@mail.gmail.com>
 <1ef36838-81f1-5b64-bcf5-69c1bb1ff082@ti.com>
 <CAMS2kBFmr3s8Y=ssyFGcZTNFRg3rAS_23X6UyxEYWSr8ere+wQ@mail.gmail.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <8f2b3cd4-83ab-cf74-9109-501525d52d0f@ti.com>
Date:   Fri, 13 Nov 2020 20:38:36 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAMS2kBFmr3s8Y=ssyFGcZTNFRg3rAS_23X6UyxEYWSr8ere+wQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 11/13/20 1:18 AM, Glenn Schmottlach wrote:
> On Tue, Nov 10, 2020 at 2:06 AM Vignesh Raghavendra <vigneshr@ti.com> wrote:
> 
>> Could you trace how much of data is left in TX FIFO using MCSPI_CHSTAT_0
>> and MCSPI_XFERLEVEL registers?
>>
> 
> When the SPI slave is no longer responding to the SPI master the
> following was observed on the SPI slave:
> 
> devmem2 0x48030130 w    (CHSTAT_0)
> Read at address  0x48030130 (0xb6f5c130): 0x0000004F
> 
> So  0x4F means:
>       RXFFF=1 (FIFO RX buffer is full)
>       TXFFE=1 (FIFO transmit buffer is empty)
>       EOT=1 (Set to 1 at end of SPI transfer)
>       TXS=1 (TX register status: register is empty)
>       RXS=1 (RX register status: register is full)
> 
> So it appears there is data ready to be read from the SPI master and
> there is no data scheduled to be sent.
> 
> devmem2 0x4803017C w  (XFERLEVEL)
> Read at address  0x4803017C (0xb6fd717c): 0x00000000
> 
> So WCNT = 0 and it appears no words are scheduled to be transferred on
> the channel.
> 

Does the transfer resume if you manually updated WCNT field to a 
value > 32 using devmem2 when slave appears to be "stuck"? 

> Again, the SPI slave appears to be "stuck"
> 
[...]
> 
> At this point it's waiting for a completion that appears to never come.
> 
>> One possible reason may be that driver sets up  MCSPI_XFERLEVEL WCNT and
>> enables channel before setting up TX DMA. So if there a master that is
>> continuously requesting data, then there is a possibility that WCNT goes
>> down to 0 (due to shifting of 0s) before DMA had chance to put actual
>> the data into the FIFO.
>>
>> Does it help if you move the programming of WCNT field to
>> omap2_mcspi_tx_dma()?
>>
> 
> That sounds plausible and I *attempted* to move this code but I
> must've implemented it incorrectly because the driver stopped
> functioning. It's likely my implementation and/or interpretation of
> your suggestion is wrong. If you could provide a more explicit
> description of the changes or a patch I would certainly be willing to
> attempt it again.
> 
>> Main intention of adding SPI slave support was to support limited
>> usecase where master and slave exchange very small known messages of
>> predetermined length such as to support at sparse interval (such as dead
> 
> I was hoping to pass high-speed/bandwidth telemetry data from the SPI
> slave to the SPI master. Apparently my use case may not match the one
> described. With that said, I think it may still be achievable with
> tweaking by someone with more experience with the McSPI driver. I
> introduced a "usleep()" inside spi-pipe() just after the SPI transfer
> on the SPI master application. With a long enough delay between
> transfers (~2-10 msec) the SPI master/slave succeeds indefinitely and
> the SPI slave never gets "stuck". Unfortunately, this kills my
> telemetry throughput. So, there is likely some kind of race condition
> in the SPI slave controller code.
> 
> Any additional suggestions or patches to try would be very
> appreciated. I think the potential to work reliably under load is
> there but it still needs a few changes. Hopefully these are small
> changes, localized to a single file, and don't require a big refactor.
> 


Could you see if below diff helps? This delays enabling of channel
until TX DMA is queued so that WCNT does not decrement


diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index d4c9510af393..bf8c6526bcd7 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -426,6 +426,8 @@ static void omap2_mcspi_tx_dma(struct spi_device *spi,
        }
        dma_async_issue_pending(mcspi_dma->dma_tx);
        omap2_mcspi_set_dma_req(spi, 0, 1);
+       if (spi_controller_is_slave(master))
+               omap2_mcspi_set_enable(spi, 1);
 }
 
 static unsigned
@@ -1194,7 +1196,9 @@ static int omap2_mcspi_transfer_one(struct spi_master *master,
                    master->can_dma(master, spi, t))
                        omap2_mcspi_set_fifo(spi, t, 1);
 
-               omap2_mcspi_set_enable(spi, 1);
+               /* For slave TX, enable after DMA is queued */
+               if (!spi_controller_is_slave(master) || !t->tx_buf)
+                       omap2_mcspi_set_enable(spi, 1);
 
                /* RX_ONLY mode needs dummy data in TX reg */
                if (t->tx_buf == NULL)
