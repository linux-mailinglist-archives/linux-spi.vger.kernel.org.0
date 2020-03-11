Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3DF181454
	for <lists+linux-spi@lfdr.de>; Wed, 11 Mar 2020 10:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbgCKJPw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 11 Mar 2020 05:15:52 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46435 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbgCKJPv (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 11 Mar 2020 05:15:51 -0400
Received: by mail-ot1-f66.google.com with SMTP id 111so1151348oth.13
        for <linux-spi@vger.kernel.org>; Wed, 11 Mar 2020 02:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rg5doAsxx0kDjXaq8rnpBM3DNdZiB/RASH0KhpWMeD8=;
        b=AYzKh2vvwNCxLc3OMbxf8iKz3E05gHb1UaSIkycR5Y9i3RMr4JeYG3WrTgDOlAVdVR
         vJ/uy1d66aLqcGSIMvXocK7wYYI4Da4l7qj90C5Cx/Ph18fHl5XSe7aOXL7hgk8XyDJS
         //bx91P1SSQwDPIJ/TW8tClAssVikIqKIvFMKzUrDZ+D/tOd7hf7X4IXc6EN7Qp+wcaB
         zVKNFKNT7q+S4rKZCvwyM/76yj6LyYPhVN2n+r0cuYrqVbbSmB0YG+46lWGVbsRmBEs7
         CItapMLynuNfzG6Zq3ZlWPEOTx21pzAGkuUDXJf7N4V/zkB/0cm7Li700f6icO1AX3+i
         6Omw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rg5doAsxx0kDjXaq8rnpBM3DNdZiB/RASH0KhpWMeD8=;
        b=qhnUg1mFgcNA5O0GZgRorzH0OSSJkp00zJgN344jKmslzIsZR4xdzVHdYgaYonHFSI
         xuKd1R4OrlfMUN1yiX6423lxa15e+SGlibJJwRtz52qV+oo9huDOMIFLlDdLwlaaVUzS
         I0ifytxa9HqTebwkXHZ5Op1mHPJBYvab2akvKBQ1GiG8CMZ8eB2cMBSZfhQAglnzicjG
         xEENdbKowav7Enh8wr/2h49+VABuxDttQiOVXoAKtgVQE1K9fu8VgNknoZy/+9+jTN5/
         H0VNG+t40V/KjqZ61oYJY0dmbjo7d9BWhiOoMnSUTUv4O0EQNfWu8xe8wveKVAmIZQdg
         61jg==
X-Gm-Message-State: ANhLgQ38A2zdVy/y8QXhu6DKmantIzaxe5Lvw3AB+TvPpXaOi716Kn8s
        yrqM1hyk2zqwVRETu74mxIfJvrFvQYLS2/ikamU=
X-Google-Smtp-Source: ADFU+vu9qkU+R6sJ+nc8rfdSo1TQ+UrQP1U91Y+mxOsqDCA6ehChCNtCGfDG5L00aXQdYZLb2TD7rC+bsX4mw4WaPRI=
X-Received: by 2002:a9d:6655:: with SMTP id q21mr1506463otm.70.1583918149864;
 Wed, 11 Mar 2020 02:15:49 -0700 (PDT)
MIME-Version: 1.0
References: <1536716612-24610-1-git-send-email-xiangsheng.hou@mediatek.com>
 <1536716612-24610-4-git-send-email-xiangsheng.hou@mediatek.com>
 <20181023075247.004982c9@bbrezillon> <1540532796.24602.11.camel@mhfsdcap03>
 <20181026080833.2fedbd94@bbrezillon> <CAJsYDV+dAikBZ4gg_3u7z_jgV2ZehhyWyRQ709dNQV0XdDOUbQ@mail.gmail.com>
 <CAJsYDV+ACknTVAhVJ-R-8p7H0B3XdP9nnrRZ+erJ=vbqt_VeKw@mail.gmail.com> <20200311091813.41b55a97@collabora.com>
In-Reply-To: <20200311091813.41b55a97@collabora.com>
From:   Chuanhong Guo <gch981213@gmail.com>
Date:   Wed, 11 Mar 2020 17:15:38 +0800
Message-ID: <CAJsYDVJeZGpz6K2w1JuBVXM+zdFca9qp3+=PERTE2avehw6LXg@mail.gmail.com>
Subject: Re: [PATCH 3/3] spi: spi-mem: MediaTek: Add SPI NAND Flash interface
 driver for MediaTek MT7622
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Xiangsheng Hou <xiangsheng.hou@mediatek.com>,
        marek.vasut@gmail.com, linux-spi@vger.kernel.org,
        linux-mtd@lists.infradead.org, ryder.lee@mediatek.com,
        sean.wang@mediatek.com,
        =?UTF-8?B?QmVubGlhbmcgWmhhbyAo6LW15pys5LquKQ==?= 
        <benliang.zhao@mediatek.com>,
        =?UTF-8?B?QmF5aSBDaGVuZyAo56iL5YWr5oSPKQ==?= 
        <bayi.cheng@mediatek.com>, linux-mediatek@lists.infradead.org,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi!

On Wed, Mar 11, 2020 at 4:18 PM Boris Brezillon
<boris.brezillon@collabora.com> wrote:
>
> +Miquel who worked on the ECC engine abstraction [3] recently.
>
> Hello Chuanhong,
>
> On Wed, 11 Mar 2020 15:35:43 +0800
> Chuanhong Guo <gch981213@gmail.com> wrote:
>
> > Hi Boris!
> >
> > [resend to you because of the wrong mail address in previous one.]
> >
> > I'm about to pick this driver up and start upstream it in the future.
> > So I'm answering
> > your questions below and would like to get your further suggestions.
> >
> > On Fri, Oct 26, 2018 at 2:09 PM Boris Brezillon
> > <boris.brezillon@bootlin.com> wrote:
> > > > > There's a fundamental issue with this driver: spi-mem was designed to be
> > > > > memory agnostic, and you seem to have a SPI controller that supports
> > > > > only SPI NANDs. Is that correct, or is it just that you developed the
> > > > > driver with SPI NANDs in  mind?
> > > > >
> > > > Yes, this driver supports only SPI NANDs.
> > > > Actually, Mediatek's controller is designed for NAND specifically, which
> > > > can support SPI NANDs and PARALLEL NANDs,and this driver is just for SPI
> > > > NANDs.
> > >
> > > Hm, I'm not so sure about that (I might be wrong though), it seems you
> > > can send any command you want, not only SPI NAND related ones. Maybe the
> > > controller is optimized for SPI NANDs but can do all kind of SPI
> > > transfers.
> >
> > You are correct here. This controller can perform generic spi-mem operations,
> > and it has special routines for page cache R/W that utilize controller's ECC
> > functionality.
>
> Sounds similar to the way the MXIC controller works, and that's
> actually what Miquel is trying to support with his ECC engine
> abstraction series [3].
>
> > I think the purpose of this is to provide better ECC capability
> > for some SPI NANDs with worse ECC algorithm on chip.
>
> Yep, or make it faster. Actually the reason doesn't matter, I think
> we all agree that we'll have to support external ECC for SPI NANDs at
> some point, hence the work Miquel has been doing.
>
> >
> > > > > Don't know what's possible to do with your controller, and maybe it's
> > > > > not able to execute random SPI memory operations, but in this case we
> > > > > should consider a different solution to support this driver.
> > > > >
> > > > > Do you have a public datasheet I can look at?
> > > > >
> > > > We do not have a public datasheet for Mediatek controller currently.
> > >
> > > Unfortunately, there's not much I can do without a clear understanding
> > > of how the controller works.
> > >
> >
> > I found a public datasheet [0] on wiki page for Banana Pi R64 [1].
> > Register description is available under "NAND flash interface" section
> > starting at page 592.
> > There's a hackier version of this driver in OpenWrt [2] which checks
> > opcode and use controller routine for page cache R/W.
> >
> > ECC part of this controller can also be used as a standalone ECC
> > algorithm and perform ECC operations on data provided by CPU.

The solution I'm referring to here is:
1. read uncorrected data to host directly from SPI NAND
2. start an ECC correction separately

> > But I think if it's implement this way, we wasted the page cache
> > R/W routines in this controller.
>
> Oh, you probably don't want the page cache to be active anyway. When
> the framework reads a NAND page, it also checks the number of ECC
> errors, if the page is held in some internal cache, you won't see
> the evolution of this number. Note that the FS should do some caching,
> so caching things at the HW level is probably useless.

It doesn't cache anything in controller. The R/W routine I refer to is:
When we issue a request to read page cache on SPI NAND:
1. host programs a DMA-able memory area for receiving data.
2. controller reads the page cache from SPI NAND
3. controller get the data and start ECC correction
4. corrected data will be sent back to host via DMA
5. host could check ECC status

writing of page cache goes similarly.
There's no need for a separated ECC request comparing to previous
one.

>
> >
> > I have two other initial thoughts:
> > 1. abstract some kind of ECC functionality in spi-mem interface
> >     I haven't really learned ECC stuff so I don't know whether this is
> >     possible and what kind of argument we needs for it.
>
> Nope, spi-mem should stay focused on SPI transfers, nothing
> memory-specific should leak there.
>
> > 2. modify SPI-NAND core to add support for special SPI-NAND controller.
> >     This limits controller's ability and adds extra burden for future extention
> >     of SPI-NAND framework.
>
> That doesn't work either as some ECC engines are shared between the
> raw NAND and spi-mem IPs.
>
> >
> > Which way would you prefer and do you have other suggestions?
>
> See [3]. I think you can already base your work on Miquel's series, but
> maybe he has a more up-to-date version to share. I'll let you sync with
> him.

Thanks. I'll check it out.

>
> Regards,
>
> Boris
>
> P.S.: the discussion should probably happen in the open. There's
> nothing confidential here, so I'd recommend continuing the discussion
> on [3] or creating a new thread with the MTD ML in Cc.

I did send it to the public list by replying to that 2-year-old email. It has
your old bootlin address and was rejected so I send it again to you
only :)

>
> >
> > [0] https://drive.google.com/file/d/1cW8KQmmVpwDGmBd48KNQes9CRn7FEgBb/view?usp=sharing
> > [1] http://wiki.banana-pi.org/Banana_Pi_BPI-R64#Documents
> > [2] https://git.openwrt.org/?p=openwrt/openwrt.git;a=blob;f=target/linux/mediatek/patches-4.19/0306-spi-spi-mem-MediaTek-Add-SPI-NAND-Flash-interface-dr.patch;h=2370925372f69aed0566339a4808056580e88837;hb=HEAD
>
> [3]https://lore.kernel.org/linux-mtd/20190919193141.7865-1-miquel.raynal@bootlin.com/
>

-- 
Regards,
Chuanhong Guo
