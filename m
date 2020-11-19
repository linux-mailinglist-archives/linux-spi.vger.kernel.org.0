Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F39182B8DEE
	for <lists+linux-spi@lfdr.de>; Thu, 19 Nov 2020 09:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725915AbgKSIvm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 19 Nov 2020 03:51:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgKSIvl (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 19 Nov 2020 03:51:41 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DBE1C0613CF
        for <linux-spi@vger.kernel.org>; Thu, 19 Nov 2020 00:51:41 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id l11so7146465lfg.0
        for <linux-spi@vger.kernel.org>; Thu, 19 Nov 2020 00:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=wER44k0LgCwqCBOSPc9JTt6FvmNY04IFTYn/N7lVgmk=;
        b=PI7qBlFIaO4QJnzcF1HfA09Si2n3NSrR98KAbHNt1EmSDafIJpq6R/UbG3I/m8yfqC
         LHHOYugmpXgr4kSPuh4AP3Mg24h7KbWVNtRhQmjtm5k+0+2NMXbmaendC6R7e/82yWTZ
         phgzkT7zKRcAjncTbfTxSq2TvgRUUFMp8u+kdEmN+nCgy+XgrQU7cAtn8fyPzRw+OZzQ
         vhRvGDGDt+5Sa4xkbOtAvoI3lCSifylPXTvbgNBxvxHYi18AaIhoUW6r4dvPFEWsoRoB
         xcAnBM3Vx0acQB/EOeSuIdH1AjqSonTK3IwQLfdvD4KjsrphWf9gCJxuG1qUruz7Ba10
         nYxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=wER44k0LgCwqCBOSPc9JTt6FvmNY04IFTYn/N7lVgmk=;
        b=TQH+NuPxH1nZLH6A2HWN5jD4cacPFlY7nFO+/wn/f5bqX2FYxZYCcg/S5PojyHcdJS
         WXP7Loh7Ei8iwR9PcYH4J0dn7oexz6yYgTOJYomUfXhljagfMnCLCF9ZqLjiPLXaKvNd
         ei1fYcz2wOalq3x5HRskKzBOrLzx3ibxiSxOby+upTx+2+6AwIksOA2KzXd6t1Q5wzMw
         9+w1qh27nEQsELViBNJbfwgOQx6jWUMU5U37A7f78H8INqyaVEE3g2k5mFji4akgOLcQ
         gs7hVucC0ziCMBoK9z37QjKnEIeSUCJhN1xTtzYM73qIl8aPpTA/aWYCY/5dU+XqMfff
         mysw==
X-Gm-Message-State: AOAM533B5eZMw34yfqHhEzqhi3TKZTPOyaBZetJNE/wqV/WpDWi3fzk4
        p/N50vk7eu7Tj300xjDAvs8=
X-Google-Smtp-Source: ABdhPJz5HwvHBwEkS/Gz8Ynt/C+QJUkj9ZUXmk1XNnKBqhaM5JRdjvJnLNrsjs20mED0T5HEIN+5lw==
X-Received: by 2002:a19:84c5:: with SMTP id g188mr6054593lfd.270.1605775899420;
        Thu, 19 Nov 2020 00:51:39 -0800 (PST)
Received: from mobilestation ([95.79.141.114])
        by smtp.gmail.com with ESMTPSA id r7sm3884536lfc.206.2020.11.19.00.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 00:51:38 -0800 (PST)
Date:   Thu, 19 Nov 2020 11:51:36 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "seanga2@gmail.com" <seanga2@gmail.com>
Subject: Re: [PATCH 04/32] spi: dw: Introduce polling device tree property
Message-ID: <20201119085136.sppfel7qbuj5jwpx@mobilestation>
References: <20201109195913.itgfj2ga5y7sr6zx@mobilestation>
 <58943f7988706497040cac6f6108336286e9d15f.camel@wdc.com>
 <20201115160146.efxcdjhm7f2nmivo@mobilestation>
 <BL0PR04MB65149D8B62167C11B26E0EA7E7E30@BL0PR04MB6514.namprd04.prod.outlook.com>
 <20201116215505.enelrzxaxb2457a6@mobilestation>
 <ea6a82e27a66600e7d4eb1668282d42dbaabf4b0.camel@wdc.com>
 <20201117182642.qz3il63x6lcx6owg@mobilestation>
 <3b81075dfc0b168631f3fc86c98cdd17caf85a8c.camel@wdc.com>
 <20201118151609.4bfvuoe6s6no5tcd@mobilestation>
 <bd1e3345c7414d0f6818d59be0e236b58a1f8ace.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bd1e3345c7414d0f6818d59be0e236b58a1f8ace.camel@wdc.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Nov 19, 2020 at 05:12:40AM +0000, Damien Le Moal wrote:
> On Wed, 2020-11-18 at 18:16 +0300, Serge Semin wrote:
> > On Wed, Nov 18, 2020 at 04:41:27AM +0000, Damien Le Moal wrote:
> > > On Tue, 2020-11-17 at 21:26 +0300, Serge Semin wrote:
> > > [...]
> > > > > Found the bug :)
> > > > > The fix is:
> > > > > 
> > > > > diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
> > > > > index e3b76e40ed73..b7538093c7ef 100644
> > > > > --- a/drivers/spi/spi-dw-core.c
> > > > > +++ b/drivers/spi/spi-dw-core.c
> > > > > @@ -828,7 +828,7 @@ static void spi_hw_init(struct device *dev, struct dw_spi
> > > > > *dws)
> > > > >                 }
> > > > >                 dw_writel(dws, DW_SPI_TXFTLR, 0);
> > > > >  
> > > > > 
> > > > > 
> > > > > 
> > > > > -               dws->fifo_len = (fifo == 1) ? 0 : fifo;
> > > > > +               dws->fifo_len = (fifo == 1) ? 0 : fifo - 1;
> > > > >                 dev_dbg(dev, "Detected FIFO size: %u bytes\n", dws->fifo_len);
> > > > >         }
> > > > > 
> > > > > Basically, fifo_len is off by one, one too large and that causes the RX FIFO
> > > > > overflow error. The loop above breaks when the written fifo value does not
> > > > > match the read one, which means that the last correct one is at step fifo - 1.
> > > > > 
> > > > > I realized that by tracing the transfers RX first, then TX in
> > > > > dw_spi_transfer_handler().I did not see anything wrong with tx_max() and
> > > > > rx_max(), all the numbers always added up correctly either up to transfer len
> > > > > or to fifo_len, as they should. It looked all good. But then I realized that RX
> > > > > FIFO errors would trigger 100% of the time for:
> > > > > 1) transfers larger than fifo size (32 in my case)
> > > > > 2) FIFO slots used for TX + RX adding up to 32
> > > > > After some tweaking, found the above. Since that bug should be affecting all
> > > > > dw-apb spi devices, not sure why it does not manifest itself more often.
> > > > > 
> > > > > With the above fix, the SD card is now running flawlessly at 1.2MB/s with
> > > > > maximum SPI frequency, zero errors no matter how hard I hit it with traffic.
> > > > 
> > > > Hm, what you've found is the clue to getting where the problem lies,
> > > > but I don't see fifo_len being calculated incorrectly in my HW. In my
> > > > case it equals to 64 and 8 bytes for two different controllers. Those
> > > > are the correct SSI_TX_FIFO_DEPTH/SSI_RX_FIFO_DEPTH parameters values
> > > > our controllers have been synthesized with.
> > > > 
> > > > But I've just realized that DW APB SSI controller can be synthesized
> > > > with Rx and Tx FIFO having different depths. (Synopsys, really, what
> > > > scenario did you imagine to provide such configuration?..). Anyway is
> > > > it possible that you've got a controller which (most likely by
> > > > mistake) has been synthesized with Rx_fifo_len != Tx_fifo_len? If so
> > > > then that will explain the problem you are having, but everyone else
> > > > isn't. The algorithm thinks that both FIFOs length match and equals to
> > > > the Tx FIFO length. If Rx FIFO length is smaller even with a single
> > > > byte, you'll end up with occasional overflows.
> > > > 
> > > > Note if you don't have a manual with the parameters selected for your
> > > > IP-core, you can just fix the fifo_len detection loop by replacing the
> > > > TXFTLR with RXFTLR. Then just print the detected Rx and Tx FIFO
> > > > lengths out. If they don't match, then, bingo, that's the root cause
> > > > of the problem.
> > > 
> > 
> > > Just checked: TX and RX fifo depth match and the maximum size I can see in both
> > > RXFTLR and TXFTLR is 31, when the fifo for loop stops with fifo=32. I checked
> > > the Synopsis DW apb_ssi v4 specs and for both RXFTLR and TXFTLR, it says:
> > > 
> > > "If you attempt to set this value greater than the depth of the FIFO,
> > > this field is not written and retains its current value."
> > > 
> > > So for a FIFO max depth of 32, as the K210 SoC documents (very poor spec sheet,
> > > but that information is written), the loop should stop for fifo=33 with the
> > > registers indicating 32. My fix should be correct.
> > 
> > v3.22a spec says "greater than or equal to the depth of the FIFO" for
> > TXFTLR and "greater than the depth of the FIFO" - for RXFTLR. In my
> > case both of the formulations make sense. Seeing the semantic of the
> > registers is different and recollecting how vague vendors can describe
> > the essence of regs, in both cases FIFO depth would be detected as
> > (MAX_value + 1). That is obvious for TXFTLR (in v3.22a formulation),
> > but isn't for RXFTLR. In the later case we need to keep in mind that
> > the controller internally increments (RXFTLR.RFT + 1) then compares it
> > with RXFLR.RXTFL. Most likely the RXFTLR description text means that
> > incremented value when says: "If you attempt to set this value greater
> > than the depth of the FIFO, this field is not written and retains its
> > current value." but not the actual value written into the register.
> > 
> > Regarding DW APB SSI v4 spec. I don't really know why the description
> > has changed for TXFTLR. I also don't have the v4 spec to better
> > understand what they really meant there. But if the TXFTLR/RXFTLR
> > registers semantic has changed, then I'd start to dig in the aspects
> > of that change and whether it affects the FIFO-depth calculation
> > algorithm...
> 
> I spent a lot of time reading the spec yesterday and did not see any text that
> conflicts with what the driver is doing. The semantic of TXFTLR and RXFTLR is
> still as you describe above for v3, the internal +1 increment for RXFTLR is
> still there.
> 
> > Anyway regarding your fix. Please see the next two commits, which have
> > already attempted to introduce a change proposed by you, but then
> > reverted it back:
> > d297933cc7fc ("spi: dw: Fix detecting FIFO depth")
> > 9d239d353c31 ("spi: dw: revisit FIFO size detection again")
> > 
> > I don't think Andy was wrong reverting the fix back, especially seeing
> > the current FIFO-depth detection algorithm implementation is correct
> > for both types of my controllers (with 8 and 64 words depths). I know
> > with what parameters the controllers have been synthesized and the
> > detected depths match them.
> 
> OK. Got it.
> 
> > 
> > > 
> > > However (I think this may be the catch), the spec also says:
> > > 
> > > "This register is sized to the number of address bits needed to access the
> > > FIFO."
> > > 
> > > So for a fifo depth of 32, the register would be 5 bits only, preventing it
> > > from ever indicating 32.
> > 
> > In accordance with the registers semantic we shall never write a
> > FIFO-depth value into them and actually we aren't able to do that.
> > First of all indeed there is no point in setting the FIFO-depth value
> > into the TXFTLR because that will cause the TXE-IRQ being constantly
> > generated (because the level of the Tx FIFO will be always less than
> > or equal to the FIFO-depth). There is no point in setting the
> > FIFO-depth into the RXFTLR because that will effectively disable the
> > RXF-IRQ (the level of the Rx FIFO will be never greater than
> > FIFO-depth + 1). Secondly the TXFTLR/RXFTLR registers width have been
> > defined as: TX_ABW-1:0 and RX_ABW-1:0 unlike the FIFO level registers
> > TXFLR/RXFLR: TX_ABW:0 and RX_ABW:0 . So we just literally can't set a
> > value wider than the register is.
> 
> Yep, understood.
> 
> > 
> > > I think that this spec clause takes precedence over
> > > the previous one, and for a fifo max depth that is a power of 2 (which I assume
> > > is the case on most synthesis of the device), the detection loop actually
> > > works. But it would be buggy (off by one) for any other value of the fifo max
> > > depth that is not a power of 2.
> > > 
> > > If the above is correct, and my SoC spec sheet is also correct, then all I can
> > > think of now is a HW bug. Because no matter what I do or how I look at it, the
> > > RX FIFO overflow always happen when the sum of TX bytes sent and RX bytes left
> > > to receive equals exactly 32. Sending 32B on TX fifo does nto seem to cause any
> > > problem, so the TX fifo seems to indeed be 32B deep. But on the RX side, it
> > > really look like 31 is the value to use.
> > 
> > Of course we shouldn't reject a possibility of having a HW bug here,
> > but that is always a last resort and needs to be firmly proved.
> > In your case we may assume one of two causes of the problem:
> > 1) There is the depths mismatch.
> >    But how come you still get the RXFLR to be filled with data of
> >    greater length than we think the Rx FIFO depth is?.. Anyway the
> >    weird behaviour still can be explained by the non-standard
> >    configuration especially if the depth isn't power of 2, that
> >    Synopsys might haven't even tested it, etc.
> 

> I have never seen RXFLR being larger than 32, which is the assumed TX and RX
> fifo depth. However, the spec do mention that in case of overrun, the extra
> bytes are dropped, so I do not think seeing RXFLR being larger than fifo depth
> is possible. When the RX fifo overrun error occur, RXFLR always indicate 32. I
> thought of the following possibilities as potential bugs:
> a) the trace shows that the driver is not trying to ask for more bytes than the
> fifo can hold, so the controller may be trying to push one more byte than was
> requested.
> b) The RX fifo depth is in fact 31 instead of the documented & detected 32.
> c) The RX fifo is indeed 32, but the overrun trigger is off-by-one and triggers
> when RXFLR == 32 instead of when RXFLR == 32 && one more byte was requested.
> 
> (b) and (c) being kind-of equivalent. For (a), I thought the MOSI line drive
> high or low (txw = 0 or txw = 0xffff in dw_writer()) may matter, but that does
> not seem to be the case. Changing txw init value has no effect. So I kind of
> ruled (a) out.

I am more inclined in thinking of what we having is either b) or c)
here. Who knows how synopsys implemented Tx/Rx FIFOs infrastructure
in hardware? It might be that depths mismatch just makes the both
FIFOs having the same size like max(SSI_TX_FIFO_DEPTH,
SSI_RX_FIFO_DEPTH) but will cause the Rx FIFO overrun interrupt in
case of the overflow. We can only guess in this matter. On the other
hand if there is no mismatch it might be just a bug in the IP-core. In
that case the problem must be fixed by the vendor in further IP-core
releases. But the current revision needs to be worked around in
software anyway.

> 
> > 2) There is a HW bug, due to which the RXO interrupt is generated even
> >    though there is no actual overrun.
> > Let's try to prove or disprove them.
> > 
> > Let's assume that there is indeed the depths mismatch here:
> > (SSI_TX_FIFO_DEPTH = 32) != (SSI_RX_FIFO_DEPTH = 31), and for some
> > reason (due to for instance the TXFTLR/RXFTLR semantic change or
> > the HW bug or etc) we can't detect the Rx FIFO depth by the algorithm
> > in the driver. If so we can't rely on the depth detection loop and
> > need to try to prove the depths mismatch somehow else. It would be
> > also better to exclude the driver code from the problem equation...
> > 
> > Since we are sure the Rx FIFO depth must be smaller than the Tx FIFO
> > depth (otherwise you wouldn't be getting the Rx FIFO overflows), then
> > we can just try to manually execute a small SPI transfer of the Tx FIFO
> > depth length. If the mismatch takes place or an HW bug with false RXO,
> > then we'll get the Rx FIFO overflow flag set.
> > 
> > I've created a small shell-script (you can find it in the attachment)
> > which runs a single SPI transfer of the passed length by manually
> > setting a DW APB SSI controller up with help of the devmem utility.
> > In our case the length is supposed to be equal to the FIFO depth.
> > Here is what happens if I run it on my hardware (depth equals to 64
> > and the controller registers physical address is 0x1f04e000):
> > 
> > root@msbt2:~# ./check_mismatch.sh 64 0x1f04e000
> > 1. Tx FIFO lvl 0, Rx FIFO lvl 0, RISR 0x00000000
> > 1. Tx FIFO lvl 64, Rx FIFO lvl 0, RISR 0x00000000
> > 2. Tx FIFO lvl 0, Rx FIFO lvl 64, RISR 0x00000011
> > 
> > See, after sending and receiving all the data the status register
> > detects the normal TXE and RXF interrupts. But if our assumptions are
> > correct in your case it shall be something like 0x00000019 also
> > presenting the RXO interrupt.
> > 
> > * Note AFAIU you might need to fix the script a bit to set the DFS
> > * field at the correct place of CTRLR0...
> 

> After adjusting for the CTRLR0 32 bits format, I get this:
> 
> For DEPTH = 32:
> 
> 1. Tx FIFO lvl 0, Rx FIFO lvl 0, RISR 0x00000000
> 1. Tx FIFO lvl 32, Rx FIFO lvl 0, RISR 0x00000000
> 2. Tx FIFO lvl 0, Rx FIFO lvl 32, RISR 0x00000019
> 
> Et voila: RX overrun which matches what I was seeing with the driver trace.
> 
> Now for DEPTH = 31:
> 
> 1. Tx FIFO lvl 0, Rx FIFO lvl 0, RISR 0x00000000
> 1. Tx FIFO lvl 31, Rx FIFO lvl 0, RISR 0x00000000
> 2. Tx FIFO lvl 0, Rx FIFO lvl 31, RISR 0x00000011
> 
> Normal transfer...

Yeap, that proves the assumption of having either the depths mismatch
or a HW bug.

> 
> > If after running the attached script you get the RXO status set, then
> > indeed there is either the depths mismatch or there is a HW bug. If
> > the TXFTLR/RXFTLR semantic hasn't changed in spec v4, then the
> > mismatch or a HW bug don't let us to detect the Rx FIFO depth by means
> > of the algorithm implemented in the driver. Then we have no choice but
> > to manually set the FIFO depth for the K210 SPI controller.
> 
> I do not have the older v3 specs on hand now, but I can get them. I will and
> compare but from reading the v4 specs yesterday, I have not seen anything that
> does not match the driver behavior.
> 
> > 
> > > 
> > > Here is a trace for a 64B transfer (errors happen only for transfers larger
> > > than 32 B):
> > > 
> > > IRQ(1):
> > > [    1.062978] spi_master spi1: ## RX: used 0/0, len 64 -> rx 0
> > > [    1.068533] spi_master spi1: ## TX: used 0/0, room 32, len 64, gap 32 -> tx
> > > 32
> > > 
> > > IRQ(2):
> > > [    1.076052] spi_master spi1: ## RX: used 16/15, len 64 -> rx 15
> > > [    1.081647] spi_master spi1: ## TX: used 0/17, room 32, len 32, gap 15 -> tx
> > > 15
> > > 
> > > IRQ(3):
> > > [    1.088932] spi_master spi1: RX FIFO overflow detected
> > > [    1.094053] spi_master spi1: ## TX/RX used 0/32, len 17/49
> > > 
> > > Each pair of line correspond to one execution of dw_spi_transfer_handler() on
> > > an IRQ occurrence. The first line is what rx_max() sees when dw_reader() is
> > > called, the second line is what tx_max() sees when dw_writer() is executed. The
> > > "used x/y" part of the messages shows TXFLR/RXFLR values.
> > > 
> > > (1) After setup of the transfer and enabling the controller, IRQ(1) occurs,
> > > nothing to receive yet, TX fifo all empty, 32 B are written. All expected. OK.
> > > (2) More than fifo_len / 2 - 1 (as RXFTLR is set in dw_spi_irq_setup) become
> > > available and IRQ(2) trigger, 15 Bytes are received. When dw_writer() runs, it
> > > sees the rxtxgap at 15B (17B still to receive from the previous 32B written),
> > > so writes only 15B. All good, again expected. Note that when dw_writer() runs,
> > > the remaining 17B to be received are already available, but that is likely due
> > > to the delay from the pr_info() message print.
> > > (3) Next IRQ(3) is the error, showing that all TX bytes have been processed and
> > > that the RX fifo is full with 32B.
> > > 
> > > If the RX fifo max depth is indeed 32, I do not understand why the overflow
> > > error is triggered at step (3). There are no more than 32B that can possibly be
> > > received. Putting back the "drive MOSI lne high" patch does not change
> > > anything. Same behavior.
> > 
> > The log you've sent indeed looks weird. I'd one more time performed
> > the next steps:
> > 1) Study the spec paying special attention to the TXFTLR/RXFTLR and
> >    TXFLR/RXFLR registers descriptions. Mostly we need to make sure
> >    that nothing has changed since the older controller revisions and
> >    what the driver implements is correct for your controller.
> > 2) Try to find an internal doc with the DW APB SSI IP-core parameters
> >    initialized during the controller synthesize. Try to find the
> >    SSI_TX_FIFO_DEPTH/SSI_RX_FIFO_DEPTH parameters value.
> > 3) Try to find an errata doc for your controller revision and make
> >    sure it doesn't have anything about the problem you are getting
> >    here.
> 

> The K210 documentation is extremely poor. All that is available is here:
> 
> https://s3.cn-north-1.amazonaws.com.cn/dl.kendryte.com/documents/kendryte_datasheet_20181011163248_en.pdf

That's just a datasheet. It can't be used to find the reason of the
problem.

> 
> And as you can see, that is all very high level. The best source of information
> is the SDK code here:
> 
> https://github.com/kendryte/kendryte-standalone-sdk
> 
> In that code, TX fifo length is clearly hard-coded at 32, but the RX fifo depth
> is not clear as the code always sets RXFTLR to 0 and the code is rather trivial
> doing a loop up to RXFLR to receive bytes.
> 
> > 4) Run the attached script to make sure that the problem isn't
> >    connected with a bug in the driver, but either with the depths
> >    mismatch or with an HW bug.
> 
> Since applying the fifo depth detection loop to RXFLTR leads to the same result
> (max register value = 31, meaning a fifo depth of 32), it really looks like an
> off-by-one HW bug on the trigger for the RX overrun status. 
> > 
> > > 
> > > I am out of ideas at this point and can only think that I am facing a HW bug
> > > that needs a quirk somewhere.
> > > 
> > > Thoughts ? Do you think it is OK to add a quirk flag for this SoC to have
> > > fifo_len reduced by one ? Adding a DT property to manually force a value for
> > > fifo_len would work too.
> > 
> > So if none of the steps above gives us an answer, then we need to dig
> > dipper into the driver code and we missing something. If 2) - 4) proves the
> > depths mismatch or a HW bug, then you can patch the spi-dw-mmio.c code to set
> > a custom fifo_len for the K210 SPI controller.
> > 
> > Anyway I don't think a quirk flag would be a good solution here because
> > the problem seems very specific to your controller...
> 

> Indeed. So what about this:
> 
> diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
> index d0cc5bf4fa4e..17c06039a74d 100644
> --- a/drivers/spi/spi-dw-mmio.c
> +++ b/drivers/spi/spi-dw-mmio.c
> @@ -222,6 +222,21 @@ static int dw_spi_keembay_init(struct platform_device
> *pdev,
>         return 0;
>  }
>  
> +static int dw_spi_canaan_k210_init(struct platform_device *pdev,
> +                                  struct dw_spi_mmio *dwsmmio)
> +{
> +       /*
> +        * The Canaan Kendryte K210 SoC DW apb_ssi v4 spi controller is
> +        * documented to have a 32 words deep TX and RX FIFO, which
> +        * spi_hw_init() detects. However, when the RX FIFO is filled up to
> +        * 32 entries (RXFLR = 32), an RX FIFO overrun error occurs. Avoid this
> +        * problem by force setting fifo_len to 31.
> +        */
> +       dwsmmio->dws.fifo_len = 31;
> +
> +       return 0;
> +}
> +
>  static int dw_spi_mmio_probe(struct platform_device *pdev)
>  {
>         int (*init_func)(struct platform_device *pdev,
> @@ -335,6 +350,7 @@ static const struct of_device_id dw_spi_mmio_of_match[] = {
>         { .compatible = "snps,dwc-ssi-1.01a", .data = dw_spi_dwc_ssi_init},
>         { .compatible = "intel,keembay-ssi", .data = dw_spi_keembay_init},
>         { .compatible = "microchip,sparx5-spi", dw_spi_mscc_sparx5_init},
> +       { .compatible = "canaan,k210-spi", dw_spi_canaan_k210_init},
>         { /* end of table */}
>  };
>  MODULE_DEVICE_TABLE(of, dw_spi_mmio_of_match);
> 
> No added capability flag and problem solved: no RX overrun errors and the SD
> card is running at 1.2 MB/s.

Looks good to me. Let's fix it this way and be done with it seeing the
problem is indeed in the k210 SPI controller peculiarity.)

-Sergey

> 
> -- 
> Damien Le Moal
> Western Digital
