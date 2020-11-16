Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 661682B53FE
	for <lists+linux-spi@lfdr.de>; Mon, 16 Nov 2020 22:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbgKPVzK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 Nov 2020 16:55:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbgKPVzK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 16 Nov 2020 16:55:10 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D36C0613CF
        for <linux-spi@vger.kernel.org>; Mon, 16 Nov 2020 13:55:09 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id h23so21847348ljg.13
        for <linux-spi@vger.kernel.org>; Mon, 16 Nov 2020 13:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9ldmHVwF5AbQNTkQjdLR+V21IMFJ9BkeyLgvAQjoAFg=;
        b=lRCZTzG6/LAItiL2Bw9ABpsjlvChBTrZ3kIvn/uNfdzW16m0ggHP3n5eMSGoWspm+q
         Bl1agKFFPkhLXu9or6ThIBC19e8CxWwxz9isw4b7LznGI5DSd6lpNE+Boq1CCld1MUeg
         tbBE5lPIaL5/lNvCo3LpgX6CZbeU9FLbpx4shQoh3N5DuHKt40YhPgx3o531VmLkjWdS
         bCDgmYtzqeT4yrdHz6NgfDfFKeDxFgXaAP/6Q8n6U8M00jfDt/gHZCubTxEwtdHjIy1e
         Piz9+IFxH+w2quRFsaZjKCilGE0oSKMkoLIDWEIiA9ucEgmA2EMH7skwH2Y5uu1yWEMH
         DA1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9ldmHVwF5AbQNTkQjdLR+V21IMFJ9BkeyLgvAQjoAFg=;
        b=Su5h5+M09gq0FOhltSb7ajBuSHUtIUa3zgNOsV1ip4gBXOzgfCjXJgeMWCSaQD4Vg1
         YCovLdEtIl8PGA0cyDWCuIU+EqAXsAPjil00avGM2zY+6BAa23GcEj5Mp1OXDDllWpIp
         hsIizORL4KTZZlptCyNcPmkFvvYLAkbFh5fbVR5PwlE1G6snnMRSMiq7Wj+evQfc/iV4
         Woqn8hvmgpxpKoedQHBeUv9o5EiNQZKtBnDUGrt96gN+mWyD/32EyOVUy3aGJnLBdjpt
         9t4g2vUTyPBYnvblBJkFXU+wz2fXigA/yAnSbsv7TXgi5Fa5lWGCdhF6xfor8GnukII9
         kWmA==
X-Gm-Message-State: AOAM5328ig1EYISxIfSPC01HsN2JYXX3RB6Sz7O+rKKeNITwjGhrZZeh
        SdShVRRN4AQO4f8Xth19wjWGC7ZxEBmnMQ==
X-Google-Smtp-Source: ABdhPJzwannpET41eVAX70in5C/JBvIsgw/RD1zyMfXhDVLzdTRVoW20IYc0wo17f6JPuZk14/gGPA==
X-Received: by 2002:a2e:884d:: with SMTP id z13mr569867ljj.88.1605563708223;
        Mon, 16 Nov 2020 13:55:08 -0800 (PST)
Received: from mobilestation ([95.79.141.114])
        by smtp.gmail.com with ESMTPSA id h21sm2842302ljc.4.2020.11.16.13.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 13:55:07 -0800 (PST)
Date:   Tue, 17 Nov 2020 00:55:05 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "seanga2@gmail.com" <seanga2@gmail.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: Re: [PATCH 04/32] spi: dw: Introduce polling device tree property
Message-ID: <20201116215505.enelrzxaxb2457a6@mobilestation>
References: <20201107081420.60325-1-damien.lemoal@wdc.com>
 <20201107081420.60325-5-damien.lemoal@wdc.com>
 <20201109195913.itgfj2ga5y7sr6zx@mobilestation>
 <58943f7988706497040cac6f6108336286e9d15f.camel@wdc.com>
 <20201115160146.efxcdjhm7f2nmivo@mobilestation>
 <BL0PR04MB65149D8B62167C11B26E0EA7E7E30@BL0PR04MB6514.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL0PR04MB65149D8B62167C11B26E0EA7E7E30@BL0PR04MB6514.namprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Nov 16, 2020 at 07:47:47AM +0000, Damien Le Moal wrote:
> On 2020/11/16 1:02, Serge Semin wrote:
> > On Fri, Nov 13, 2020 at 09:22:54AM +0000, Damien Le Moal wrote:
> >> On Mon, 2020-11-09 at 22:59 +0300, Serge Semin wrote:
> >>> On Sat, Nov 07, 2020 at 05:13:52PM +0900, Damien Le Moal wrote:
> >>>> With boards that have slow interrupts context switch, and a fast device
> >>>> connected to a spi master, e.g. an SD card through mmc-spi,
> >>>
> >>>> using
> >>>> dw_spi_poll_transfer() intead of the regular interrupt based
> >>>> dw_spi_transfer_handler() function is more efficient and
> >>>
> >>> I can believe in that. But the next part seems questionable:
> >>>
> >>>> can avoid a lot
> >>>> of RX FIFO overflow errors while keeping the device SPI frequency
> >>>> reasonnably high (for speed).
> >>>
> >>> No matter whether it's an IRQ-based or poll-based transfer, as long as a
> >>> client SPI-device is connected with a GPIO-based chip-select (or the
> >>> DW APB SSI-controller feature of the automatic chip-select toggling is
> >>> fixed), the Rx FIFO should never overrun. It's ensured by the transfer
> >>> algorithm design by calculating the rxtx_gap in the dw_writer()
> >>> method. If the error still happens then there must be some bug in
> >>> the code.
> >>>
> >>> It's also strange to hear that the polling-based transfer helps
> >>> to avoid the Rx FIFO overflow errors, while the IRQ-based transfer
> >>> causes them. Both of those methods are based on the same dw_writer()
> >>> and dw_reader() methods. So basically they both should either work
> >>> well or cause the errors at same time.
> >>>
> >>> So to speak could you more through debug your case?
> >>
> >> I did. And I have much better results now. Let me explain:
> > 
> >> 1) The device tree was setting up the SPI controller using the controller
> >> internal chip select, not a GPIO-based chip select. Until now, I could never
> >> get the GPIO-based chip select to work. I finally found out why: I simply
> >> needed to add the "spi-cs-high" property to the mmc-slot node. With that, the
> >> CS gpio is correctly driven active-high instead of the default active-low and
> >> the SD card works.
> > 
> > Yeap, that's the main problem of the standard DW APB SSI controller
> > released by Synopsys. Currently SPI-flash'es are the only SPI
> > peripheral devices which are capable to work with native DW APB SSI
> > chip-selects. I've fixed that for flashes recently by atomizing the
> > SPI memory operations (executing them with the local IRQs disabled)
> > and performing them on the poll-based basis. Alas the normal
> > SPI-transfers still can't be properly executed with native
> > chip-selects.
> > 
> >> 2) With this change using the GPIO-based CS, the patch "spi: dw: Fix driving
> >> MOSI low while receiving" became completely unnecessary. The SD card works
> >> without it.
> > 
> > Hm, that's weird. MOSI level has nothing todo with the chip-selects.
> > Are you sure the original problem has been connected with the Tx lane
> > level? On the other hand are you sure the problem has gone away after
> > all?
> 
> Not sure of anything here :) But removing the patch changing MOSI level did not
> prevent the SD card to be scanned & accessed correctly. Before (with native chip
> select), the first command would not even complete...
> 
> > Moreover I've just taken alook at the MMC SPI driver. Turns out it
> > has already been fixed to send ones to the MMC port when it's
> > required. So If you still experience the MOSI-level problem
> > then that fix might have been done incorrect at some extent...
> 

> OK. Thanks for the info. I need to rebase on the latest SPI tree then. However,
> scripts/get_maintainer.pl does not mention any. Where is that hosted ?

I meant the drivers/mmc/host/mmc_spi.c driver. See the "ones" buffer
being used as spi_transfer->tx_buf sometimes there? That's what is
supposed to fix the MOSI level problem. So if at some point the MMC
SPI driver performs an Rx-only SPI transfer with no ones-buffer
specified as the tx_buf one, but the MMC SPI protocol requires for an SD
card to receive ones, then the protocol problem will happen.

> 
> 
> >> Now for testing, I also removed this polling change. Results are these:
> >> 1) With the same SPI frequency as before (4MHz), I can run the SD card at about
> >> 300 KB/s (read) but I am still seeing some RX FIFO overflow errors. Not a lot,
> >> but enough to be annoying, especially on boot as the partition scan sometimes
> >> fails because of these errors. In most cases, the block layer retry of failed
> >> read/writes cover and no bad errors happen, but the RX FIFO overflow error
> >> messages still pop up.
> >> 2) Looking into the code further, I realized that RXFLTR is set to half the
> >> fifo size minus 1. That sound reasonable, but as that delays interrupt
> >> generation until the RX fifo is almost full, I decided to try a value of 0 to
> >> get the interrupt as soon as data is available rather than waiting for a chunk.
> >> With that, all RX FIFO overflow errors go away, and I could even double the SPI
> >> frequency to 8MHz, getting a solid 650KB/s from the SD card without any error
> >> at all.
> >>
> > 
> > Please, see my last comment...
> > 
> >> My take:
> >> * This controller internal CS seems to be totally broken.
> > 
> > Native CS aren't broken, they just have been designed so it isn't that
> > easy to use them in the linux kernel. Linux kernel SPI-core expects
> > the chip-select being driven the way it needs at the certain moments,
> > while DW APB SSI toggles them automatically at the moment of the data
> > pushing/popping to/from the SPI bus. Some hardware vendors that bought
> > the DW APB SSI IP-core have fixed that by providing a way of direct
> > CS lane control (see spi-dw-mmio.c: Microsemi, Sparx5, Alpine
> > platforms).
> 
> OK. Thanks for the details.
> 
> >> * This SoC has really slow interrupts, so generating these earlier rather than
> >> later gives time to the IRQ handler to kick in before the FIFO overflows.
> > 
> > I am pretty sure that's not the reason. See my next comment.
> > 
> >>
> >> In the V2 series for SPI DW, I added a DW_SPI_CAP_RXFLTR_CLEAR capability flag
> >> to set RXFLTR to 0, always. That works well, but this is may be still similar
> >> to the "polling" hack in the sense that it is tuning for this SoC rather than a
> >> property of the controller. But I do not see any other simple way of removing
> >> these annoying RX FIFO overflow errors.
> > 
> > Alas no, RX-FIFO level value shouldn't affect the SPI-transfers
> > execution results. I'll try to explain it one more time. DW APB SSI
> > provides three modes of transfers (TMOD-es, see the chip manual for
> > details). One of them is TMOD=0x0 - Transmit and Receive. Simply
> > speaking the mode essence is if you push a byte of data to the Tx
> > FIFO you'll synchronously get a byte of data back in the Rx FIFO a bit
> > later from the internal shift register. The IRQ-based transfers have
> > been developed full based on that mode. So it's absolutely possible to
> > implement a stable algorithm, which would work without a risk of
> > getting the Rx FIFO overflow or the Tx FIFO overrun. Such algorithm
> > should just preserve a balance of sent data so the received data
> > wouldn't cause the Rx FIFO overrun. As you understand such algorithm
> > doesn't depend on the IRQes performance. No matter how slow the IRQs
> > handler is execute, as long as it's executed, the SPI transfers
> > procedure shall go on with no errors including the Rx FIFO overflows.
> 
> OK. I get it now.
> 
> > At least that's what the original DW APB SSI driver developer
> > implied when created the code and what I was trying to preserve in my
> > patches. If you still get the errors (you sure it's Rx FIFO overflows,
> > aren't you?), then something went wrong and either me or the original
> > author or someone else has broken the code.
> 

> Yep, 100% sure it is RX FIFO overflow error. The bit in the IRQ status is set.
> Checked it. And that is the trigger for the error message which exactly says
> that "RX FIFO overflow". So that would mean that too many bytes are being
> written to the TX FIFO, right ? Or rather, that when the TX FIFO is written, it
> writes more bytes than what is available in the RX FIFO ?

I'd say that in appliance to the implemented in the driver algorithm
the error has been indeed caused by writing too many bytes to the Tx
FIFO. But that in its turn implicitly caused the Rx FIFO overflow.

The error you see in the log specifically means that the Rx FIFO has
been full and there has been more data to receive, but due to not
having any free space in the Rx FIFO that data has been discarded. In
appliance to DW APB SSI driver, as I said, it means that there is a
mistake in the IRQ-based SPI-transfer execution procedure. We've
written too much data to the Tx FIFO so the balance between the sent
and received bytes has been violated. ISR couldn't handle the
interrupt on time and the Rx FIFO has got overrun. If the balance
wasn't violated or the ISR was executed on time we wouldn't have got
the overrun. Supposedly that's why the error hasn't been seen on my or
other platforms but only on yours and only with normal RXFTL register
value. The ISR is executed on time so the balance violation doesn't
affect the transfer that much as in your case. My guess that the
problem might be connected with the off-by-one bug. But that's just a
hypothesis.

> 
> If that is the case, then it seems to me that tx_max() should be modified a
> little: rx_len may be large (say a sector), in which case rxtx_gap overflows
> (becomes super large), with the result that tx_max() returns tx_room. But that
> may be larger than the free space in the RX FIFO, no ?

Yeah, I also considered the tx_max() method as a first place to blame.
But alas I failed to see what might be wrong there.

Let's analyze what tx_max() does. It may get us to a better
understanding what is going on during each send operation.

Here we calculate a free space in the Tx FIFO:
> tx_room = dws->fifo_len - dw_readl(dws, DW_SPI_TXFLR);
It can be within [0, fifo_len]. So if Tx FIFO is full there is no room
for new data to send. If it's empty we can send data up to of FIFO
length.

The next is a magic formulae, which makes sure the length of the sent data
always doesn't exceed the Rx FIFO length. In other words it preserve
the so called balance: (rx_len - tx_len <= fifo_len).
> rxtx_gap = dws->fifo_len - (dws->rx_len - dws->tx_len);
(rx_len - tx_len) gives us a number of data which has already been
written to the Tx FIFO, but the corresponding incoming data still
hasn't been read back from the bus. The formulae above works well
while the next statements are valid:
1) rx_len is always greater than or equal to tx_len. Indeed due to the
SPI nature first we write data to the Tx FIFO and decrement the tx_len
variable accordingly, then we read data from the Rx FIFO and decrement
the rx_len variable.
2) (rx_len - tx_len) is always less than or equal to fifo_len. I don't
really see when this could be incorrect, especially seeing we always
send and received data by no more than the FIFO length chunks and
make sure the difference between the sent and received data length
doesn't exceed the FIFO length. The reading is always done before
writing.

Finally we get to select an allowed number of data to send. It's
the minimum of the Tx data length, Rx FIFO free space and the length
of the data which doesn't let the Rx FIFO to oveflow:
> return min3((u32)dws->tx_len, tx_room, rxtx_gap);

Alas currently I don't see at what point the algorithm could be
incorrectly implemented...

> 
> I think I need to do a round of debug again, tracing these values to figure out
> what is going on. I can reproduce the errors very easily (I just need to crank
> up the SPI frequency).

Yeap, that what I would have been doing if I had the problem
reproducible.

-Sergey

> 
> > What we currently need is to carefully analyze at what moment you get
> > the overflows, what really caused them and fix the problem in the
> > code. The capabilities flag isn't an option in this case. I've tried
> > to reproduce the errors by slowing the system down, executing the
> > SPI-transfers of various length, but with no lick. So it's only you
> > for now who observes and can try to debug the problem.
> 
> OK. Will do.
> 
> > Anyway after we get to fix it, you'll be able to run the MMC port with
> > speed as fast as it's possible.
> 
> That is my current goal :)
> 
> > 
> > ---
> > One more thing about MMC SPI. Please note, that using MMC SPI and
> > DMA-based DW APB SSI transfers might not work well. The thing is that
> > the DMA-part of the MMC SPI driver relies on the legacy
> > spi_message->is_dma_mapped interface. It performs some specific
> > DEV-to-MEM and MEM-to-DEV DMA-buffers splitting and synchronizations.
> > In its turn the DMA-part of the DW APB SSI driver uses the generic
> > SPI-core and the DMA-engine interface to execute the SPI-transfers.
> > Since the SPI-core performs the DMA buffers synchronizations
> > internally at the moment of the buffers mapping, in case if the DMA
> > accesses aren't coherent on your platform, the data buffers might get
> > synchronized/flushed with/by caches incorrectly corrupting a part of
> > actual data. At least that's what we observed in kernel 4.9... So for
> > now I'd suggest to use either the poll- or the IRQ-based DW APB SSI
> > transfers.
> 
> The K210 has a DW DMA engine, but I do not have it enabled. I tried that too to
> be frank, but it fails to initialize the DMA rx/tx channels. I have not dig into
> that one since DMA is not at all required for this board given the devices on it.
> 
> Thanks for all the help !
> 
> 
> -- 
> Damien Le Moal
> Western Digital Research
