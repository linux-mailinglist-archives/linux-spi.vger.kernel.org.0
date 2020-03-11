Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BABAC1814A7
	for <lists+linux-spi@lfdr.de>; Wed, 11 Mar 2020 10:22:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbgCKJWX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Wed, 11 Mar 2020 05:22:23 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:59845 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbgCKJWX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 11 Mar 2020 05:22:23 -0400
X-Originating-IP: 90.89.41.158
Received: from xps13 (lfbn-tou-1-1473-158.w90-89.abo.wanadoo.fr [90.89.41.158])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 296831BF20B;
        Wed, 11 Mar 2020 09:22:20 +0000 (UTC)
Date:   Wed, 11 Mar 2020 10:22:19 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Chuanhong Guo <gch981213@gmail.com>
Cc:     Boris Brezillon <boris.brezillon@collabora.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Xiangsheng Hou <xiangsheng.hou@mediatek.com>,
        marek.vasut@gmail.com, linux-spi@vger.kernel.org,
        linux-mtd@lists.infradead.org, ryder.lee@mediatek.com,
        sean.wang@mediatek.com,
        "Benliang Zhao (=?UTF-8?B?6LW15pys5Lqu?=)" 
        <benliang.zhao@mediatek.com>,
        "Bayi Cheng (=?UTF-8?B?56iL5YWr5oSP?=)" <bayi.cheng@mediatek.com>,
        linux-mediatek@lists.infradead.org, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/3] spi: spi-mem: MediaTek: Add SPI NAND Flash
 interface driver for MediaTek MT7622
Message-ID: <20200311102219.419feb66@xps13>
In-Reply-To: <CAJsYDVJeZGpz6K2w1JuBVXM+zdFca9qp3+=PERTE2avehw6LXg@mail.gmail.com>
References: <1536716612-24610-1-git-send-email-xiangsheng.hou@mediatek.com>
        <1536716612-24610-4-git-send-email-xiangsheng.hou@mediatek.com>
        <20181023075247.004982c9@bbrezillon>
        <1540532796.24602.11.camel@mhfsdcap03>
        <20181026080833.2fedbd94@bbrezillon>
        <CAJsYDV+dAikBZ4gg_3u7z_jgV2ZehhyWyRQ709dNQV0XdDOUbQ@mail.gmail.com>
        <CAJsYDV+ACknTVAhVJ-R-8p7H0B3XdP9nnrRZ+erJ=vbqt_VeKw@mail.gmail.com>
        <20200311091813.41b55a97@collabora.com>
        <CAJsYDVJeZGpz6K2w1JuBVXM+zdFca9qp3+=PERTE2avehw6LXg@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Chuanhong,

Chuanhong Guo <gch981213@gmail.com> wrote on Wed, 11 Mar 2020 17:15:38
+0800:

> Hi!
> 
> On Wed, Mar 11, 2020 at 4:18 PM Boris Brezillon
> <boris.brezillon@collabora.com> wrote:
> >
> > +Miquel who worked on the ECC engine abstraction [3] recently.
> >
> > Hello Chuanhong,
> >
> > On Wed, 11 Mar 2020 15:35:43 +0800
> > Chuanhong Guo <gch981213@gmail.com> wrote:
> >  
> > > Hi Boris!
> > >
> > > [resend to you because of the wrong mail address in previous one.]
> > >
> > > I'm about to pick this driver up and start upstream it in the future.
> > > So I'm answering
> > > your questions below and would like to get your further suggestions.
> > >
> > > On Fri, Oct 26, 2018 at 2:09 PM Boris Brezillon
> > > <boris.brezillon@bootlin.com> wrote:  
> > > > > > There's a fundamental issue with this driver: spi-mem was designed to be
> > > > > > memory agnostic, and you seem to have a SPI controller that supports
> > > > > > only SPI NANDs. Is that correct, or is it just that you developed the
> > > > > > driver with SPI NANDs in  mind?
> > > > > >  
> > > > > Yes, this driver supports only SPI NANDs.
> > > > > Actually, Mediatek's controller is designed for NAND specifically, which
> > > > > can support SPI NANDs and PARALLEL NANDs,and this driver is just for SPI
> > > > > NANDs.  
> > > >
> > > > Hm, I'm not so sure about that (I might be wrong though), it seems you
> > > > can send any command you want, not only SPI NAND related ones. Maybe the
> > > > controller is optimized for SPI NANDs but can do all kind of SPI
> > > > transfers.  
> > >
> > > You are correct here. This controller can perform generic spi-mem operations,
> > > and it has special routines for page cache R/W that utilize controller's ECC
> > > functionality.  
> >
> > Sounds similar to the way the MXIC controller works, and that's
> > actually what Miquel is trying to support with his ECC engine
> > abstraction series [3].
> >  
> > > I think the purpose of this is to provide better ECC capability
> > > for some SPI NANDs with worse ECC algorithm on chip.  
> >
> > Yep, or make it faster. Actually the reason doesn't matter, I think
> > we all agree that we'll have to support external ECC for SPI NANDs at
> > some point, hence the work Miquel has been doing.
> >  
> > >  
> > > > > > Don't know what's possible to do with your controller, and maybe it's
> > > > > > not able to execute random SPI memory operations, but in this case we
> > > > > > should consider a different solution to support this driver.
> > > > > >
> > > > > > Do you have a public datasheet I can look at?
> > > > > >  
> > > > > We do not have a public datasheet for Mediatek controller currently.  
> > > >
> > > > Unfortunately, there's not much I can do without a clear understanding
> > > > of how the controller works.
> > > >  
> > >
> > > I found a public datasheet [0] on wiki page for Banana Pi R64 [1].
> > > Register description is available under "NAND flash interface" section
> > > starting at page 592.
> > > There's a hackier version of this driver in OpenWrt [2] which checks
> > > opcode and use controller routine for page cache R/W.
> > >
> > > ECC part of this controller can also be used as a standalone ECC
> > > algorithm and perform ECC operations on data provided by CPU.  
> 
> The solution I'm referring to here is:
> 1. read uncorrected data to host directly from SPI NAND
> 2. start an ECC correction separately
> 
> > > But I think if it's implement this way, we wasted the page cache
> > > R/W routines in this controller.  
> >
> > Oh, you probably don't want the page cache to be active anyway. When
> > the framework reads a NAND page, it also checks the number of ECC
> > errors, if the page is held in some internal cache, you won't see
> > the evolution of this number. Note that the FS should do some caching,
> > so caching things at the HW level is probably useless.  
> 
> It doesn't cache anything in controller. The R/W routine I refer to is:
> When we issue a request to read page cache on SPI NAND:
> 1. host programs a DMA-able memory area for receiving data.
> 2. controller reads the page cache from SPI NAND
> 3. controller get the data and start ECC correction
> 4. corrected data will be sent back to host via DMA
> 5. host could check ECC status
> 
> writing of page cache goes similarly.
> There's no need for a separated ECC request comparing to previous
> one.
> 
> >  
> > >
> > > I have two other initial thoughts:
> > > 1. abstract some kind of ECC functionality in spi-mem interface
> > >     I haven't really learned ECC stuff so I don't know whether this is
> > >     possible and what kind of argument we needs for it.  
> >
> > Nope, spi-mem should stay focused on SPI transfers, nothing
> > memory-specific should leak there.
> >  
> > > 2. modify SPI-NAND core to add support for special SPI-NAND controller.
> > >     This limits controller's ability and adds extra burden for future extention
> > >     of SPI-NAND framework.  
> >
> > That doesn't work either as some ECC engines are shared between the
> > raw NAND and spi-mem IPs.
> >  
> > >
> > > Which way would you prefer and do you have other suggestions?  
> >
> > See [3]. I think you can already base your work on Miquel's series, but
> > maybe he has a more up-to-date version to share. I'll let you sync with
> > him.  

I am actively working on it, this series is adding an "ECC engine
framework" that could potentially fit any architecture. I am currently
working with a Macronix external ECC engine, I will "soon" send a new
version of it, I'll copy you.

Thanks,
Miquèl
