Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00FD91811FB
	for <lists+linux-spi@lfdr.de>; Wed, 11 Mar 2020 08:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgCKHbo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 11 Mar 2020 03:31:44 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42761 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbgCKHbo (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 11 Mar 2020 03:31:44 -0400
Received: by mail-ot1-f66.google.com with SMTP id 66so912567otd.9
        for <linux-spi@vger.kernel.org>; Wed, 11 Mar 2020 00:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XqjRh4XcbIeWg34nWgx/BvCMLg6ufHpF8wfPSvWuHz0=;
        b=ha0QoGSg3KAv2R3HAXeMjIi1d2yifW/WkdBw5qGgsGm7I85pu+VvryoyW+Aixi5GgS
         qBKwqs0T7EDZzEjVgZRIwAdwLj45t2CJMcEoL0xIZbpMtIvWYAAGV7be+q3GmnOyW8K5
         QLSYJoGv+8aS2zAchGen7HEtn84ZcCGbGCNllJVOY9J0nMWntTKnlSDeiaT1OAcniVwM
         cTo9eU1CwGZzm22dU1Dhny9fJ04ox9whJynLlSjGu1dznihaf3W0/+hdHyuF54rs6QKy
         s6t+eLKwL0kzbjcE8i8UBesMf0/Jn/L3bsffHSqkwCHvOMZezEf+/mfkxQSIzS4WP8Rr
         EYkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XqjRh4XcbIeWg34nWgx/BvCMLg6ufHpF8wfPSvWuHz0=;
        b=m+/k9FrKrL1eLk+yKuDLH86YPKT6w1IAKEiRjSN4LNsZHUuFZFmXjpIcXHTKGXLKNm
         jzj3+F0qqaC8KKmZJNMqaO9Us5PkqfGsHSW9oVgYKDPd8/6+jxl/a7ITuY+w27O9Uexe
         t3uUslzhukuioslzg4C6wVbnCV7LJlf3pou53oIyjXGdFkY7G6J9WxKRWih8GTVK+6wQ
         MPwakHYGBFpoEcxBvNEZSnbF47bPtMI3cC6zXdsAQtxbdVg9pHaD7LLBrdneWiQN6iYB
         UAJGGT+izigFIR6DWc8DTB9HMYJ7SpvEnv99STDGyMG31n+cJ3ULPFBdreHWGeWspRiW
         BWxA==
X-Gm-Message-State: ANhLgQ1Vv0AnovC8L6bxCxOZgLKMsnGBo+5gxBSBFwqpKiGAdm68wBEN
        xjOQ/OKZtj3r+ZYE3IAlAgX2H1bBs1sQYTXWvMU=
X-Google-Smtp-Source: ADFU+vvWMFP54lh2YUrErXGIZ9ola/n/+/kwLa2LvSYzQozOfvkatAweuBFXM5bgscaPALmt8YeGtDcj7RXgUFalloY=
X-Received: by 2002:a05:6830:160c:: with SMTP id g12mr1329009otr.86.1583911901252;
 Wed, 11 Mar 2020 00:31:41 -0700 (PDT)
MIME-Version: 1.0
References: <1536716612-24610-1-git-send-email-xiangsheng.hou@mediatek.com>
 <1536716612-24610-4-git-send-email-xiangsheng.hou@mediatek.com>
 <20181023075247.004982c9@bbrezillon> <1540532796.24602.11.camel@mhfsdcap03> <20181026080833.2fedbd94@bbrezillon>
In-Reply-To: <20181026080833.2fedbd94@bbrezillon>
From:   Chuanhong Guo <gch981213@gmail.com>
Date:   Wed, 11 Mar 2020 15:31:29 +0800
Message-ID: <CAJsYDV+dAikBZ4gg_3u7z_jgV2ZehhyWyRQ709dNQV0XdDOUbQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] spi: spi-mem: MediaTek: Add SPI NAND Flash interface
 driver for MediaTek MT7622
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Xiangsheng Hou <xiangsheng.hou@mediatek.com>,
        marek.vasut@gmail.com, linux-spi@vger.kernel.org,
        linux-mtd@lists.infradead.org, srv_heupstream@mediatek.com,
        ryder.lee@mediatek.com, sean.wang@mediatek.com,
        xiaolei.li@mediatek.com,
        =?UTF-8?B?QmVubGlhbmcgWmhhbyAo6LW15pys5LquKQ==?= 
        <benliang.zhao@mediatek.com>,
        =?UTF-8?B?QmF5aSBDaGVuZyAo56iL5YWr5oSPKQ==?= 
        <bayi.cheng@mediatek.com>, linux-mediatek@lists.infradead.org,
        honghui.zhang@mediatek.com, Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Boris!

I'm about to pick this driver up and start upstream it in the future.
So I'm answering
your questions below and would like to get your further suggestions.

On Fri, Oct 26, 2018 at 2:09 PM Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
> > > There's a fundamental issue with this driver: spi-mem was designed to be
> > > memory agnostic, and you seem to have a SPI controller that supports
> > > only SPI NANDs. Is that correct, or is it just that you developed the
> > > driver with SPI NANDs in  mind?
> > >
> > Yes, this driver supports only SPI NANDs.
> > Actually, Mediatek's controller is designed for NAND specifically, which
> > can support SPI NANDs and PARALLEL NANDs,and this driver is just for SPI
> > NANDs.
>
> Hm, I'm not so sure about that (I might be wrong though), it seems you
> can send any command you want, not only SPI NAND related ones. Maybe the
> controller is optimized for SPI NANDs but can do all kind of SPI
> transfers.

You are correct here. This controller can perform generic spi-mem operations,
and it has special routines for page cache R/W that utilize controller's ECC
functionality. I think the purpose of this is to provide better ECC capability
for some SPI NANDs with worse ECC algorithm on chip.

> > > Don't know what's possible to do with your controller, and maybe it's
> > > not able to execute random SPI memory operations, but in this case we
> > > should consider a different solution to support this driver.
> > >
> > > Do you have a public datasheet I can look at?
> > >
> > We do not have a public datasheet for Mediatek controller currently.
>
> Unfortunately, there's not much I can do without a clear understanding
> of how the controller works.
>

I found a public datasheet [0] on wiki page for Banana Pi R64 [1].
Register description is available under "NAND flash interface" section
starting at page 592.
There's a hackier version of this driver in OpenWrt [2] which checks
opcode and use controller routine for page cache R/W.

ECC part of this controller can also be used as a standalone ECC
algorithm and perform ECC operations on data provided by CPU.
But I think if it's implement this way, we wasted the page cache
R/W routines in this controller.

I have two other initial thoughts:
1. abstract some kind of ECC functionality in spi-mem interface
    I haven't really learned ECC stuff so I don't know whether this is
    possible and what kind of argument we needs for it.
2. modify SPI-NAND core to add support for special SPI-NAND controller.
    This limits controller's ability and adds extra burden for future extention
    of SPI-NAND framework.

Which way would you prefer and do you have other suggestions?

[0] https://drive.google.com/file/d/1cW8KQmmVpwDGmBd48KNQes9CRn7FEgBb/view?usp=sharing
[1] http://wiki.banana-pi.org/Banana_Pi_BPI-R64#Documents
[2] https://git.openwrt.org/?p=openwrt/openwrt.git;a=blob;f=target/linux/mediatek/patches-4.19/0306-spi-spi-mem-MediaTek-Add-SPI-NAND-Flash-interface-dr.patch;h=2370925372f69aed0566339a4808056580e88837;hb=HEAD
-- 
Regards,
Chuanhong Guo
