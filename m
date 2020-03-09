Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A47217E7AC
	for <lists+linux-spi@lfdr.de>; Mon,  9 Mar 2020 19:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbgCIS7k (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Mar 2020 14:59:40 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:36437 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbgCIS7k (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 Mar 2020 14:59:40 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id ED43923EDA;
        Mon,  9 Mar 2020 19:59:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1583780378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BkQ/ZHD6JsNsvO3doo7+ZUkvgs/ybgertXmKICwW9bo=;
        b=pOs5z5oJ8tmhxI7vFxpE2YkZHgPJVg+Ho0tPVpdQMRJT1hzxSMFJNj0Axr77WIi7XX5tda
        ZT386cNAlX+8nhwJ5f2zBkog3RUdOLSm5Zu9mwAc9LIQEY8nbDOHQbN8okimTDNAqwtZt2
        YitqqrjUSWNjSSSD4tyoNTUDSg1Ed6Y=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 09 Mar 2020 19:59:37 +0100
From:   Michael Walle <michael@walle.cc>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Esben Haabendal <eha@deif.com>,
        angelo@sysam.it, andrew.smirnov@gmail.com,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Wei Chen <weic@nvidia.com>, Mohamed Hosny <mhosny@nvidia.com>,
        peng.ma@nxp.com
Subject: Re: [PATCH 0/6] NXP DSPI bugfixes and support for LS1028A
In-Reply-To: <CA+h21hopP2XTx55iu_pG=xBx-TSPRBbdmoU7T2F0Gc9Qt=CsSQ@mail.gmail.com>
References: <20200309145624.10026-1-olteanv@gmail.com>
 <f530a0740f34b2cf26a8055d4eae2527@walle.cc>
 <CA+h21hrSezjwKJDCd1wN8qk5koWfPmwT0Mx+sR7fHxo1sCGcjw@mail.gmail.com>
 <6da04c9a17fa9e6259a462cb52312930@walle.cc>
 <CA+h21hopP2XTx55iu_pG=xBx-TSPRBbdmoU7T2F0Gc9Qt=CsSQ@mail.gmail.com>
Message-ID: <0b1da58b9d34b6bdb7617f5340d341ac@walle.cc>
X-Sender: michael@walle.cc
User-Agent: Roundcube Webmail/1.3.10
X-Spamd-Bar: +
X-Spam-Level: *
X-Rspamd-Server: web
X-Spam-Status: No, score=1.40
X-Spam-Score: 1.40
X-Rspamd-Queue-Id: ED43923EDA
X-Spamd-Result: default: False [1.40 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[15];
         NEURAL_HAM(-0.00)[-0.536];
         FREEMAIL_TO(0.00)[gmail.com];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,arm.com,deif.com,sysam.it,gmail.com,embeddedor.com,nvidia.com,nxp.com];
         MID_RHS_MATCH_FROM(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Am 2020-03-09 19:48, schrieb Vladimir Oltean:
> On Mon, 9 Mar 2020 at 20:31, Michael Walle <michael@walle.cc> wrote:
>> 
>> Am 2020-03-09 19:14, schrieb Vladimir Oltean:
>> > On Mon, 9 Mar 2020 at 20:03, Michael Walle <michael@walle.cc> wrote:
>> >> Am 2020-03-09 15:56, schrieb Vladimir Oltean:
>> >> > From: Vladimir Oltean <vladimir.oltean@nxp.com>
>> >> >
>> >> > This series addresses a few issues that were missed during the previous
>> >> > series "[PATCH 00/12] TCFQ to XSPI migration for NXP DSPI driver", on
>> >> > SoCs other than LS1021A and LS1043A. DMA mode has been completely
>> >> > broken
>> >> > by that series, and XSPI mode never worked on little-endian
>> >> > controllers.
>> >> >
>> >> > Then it introduces support for the LS1028A chip, whose compatible has
>> >> > recently been documented here:
>> >> >
>> >> > https://lore.kernel.org/linux-devicetree/20200218171418.18297-1-michael@walle.cc/
>> >>
>> >> If it is not compatible with the LS1021A the second compatible string
>> >> should be removed. Depending on the other remark about the endianess,
>> >> it might still be compatible, though.
>> >>
>> >
>> > Please feel free to remove it. I wasn't actually planning to add it in
>> > the first place, but now it that it's there it doesn't really bother
>> > anybody either.
>> 
>> But it won't work if the endianess depends on the compatible string ;)
>> 
> 
> True.

So another reason to not have the endianess (read the CMD/TX register 
offset)
depends on the compatible string. Because then it should work also with 
the
ls1021a version, correct?

-michael


> 
>> >>
>> >> > The device tree for the LS1028A SoC is extended with DMA channels
>> >> > definition, such that even though the default operating mode is XSPI,
>> >> > one can simply change DSPI_XSPI_MODE to DSPI_DMA_MODE in the
>> >> > devtype_data structure of the driver and use that instead.
>> >>
>> >> wouldn't it make more sense, to use DMA is the dma node is present
>> >> in the device tree? otherwise use XSPI mode? I don't think it is
>> >> really handy to change the mode inside the driver.
>> >>
>> >
>> > Let's keep it simple. The driver should configure the hardware in the
>> > most efficient and least buggy mode available. Right now that is XSPI.
>> > The hardware description (aka the device tree) is a separate topic. If
>> > there ever arises any situation where there are corner cases with XSPI
>> > mode, it's good to have a fallback in the form of DMA mode, and not
>> > have to worry about yet another problem (which is that there are 2
>> > sets of device tree blobs in deployment).
>> 
>> Point taken. But this is not how other drivers behave, which uses the
>> DMA if its given in the device node.
>> 
> 
> Also true.
> 
>> Btw. do other SoCs perform better with DMA?
>> 
> 
> Not that I know of.
> My general rule of thumb for this controller is: if it supports XSPI
> then use that, otherwise use DMA. Luckily there is just one controller
> that supports none of those, and that would be Coldfire, which uses
> the braindead EOQ mode. I don't have the hardware to do testing on
> that, but in principle if I did, I would have converted that as well
> to the more functional but less efficient TCFQ mode (now removed).
> 
>> -michael
>> 
>> > TL;DR: These DMA channels don't really bother anybody but you never
>> > know when they might come in handy.
>> >
>> >> -michael
>> >>
>> >> >
>> >> > For testing, benchmarking and debugging, the mikroBUS connector on the
>> >> > LS1028A-RDB is made available via spidev.
>> >> >
>> >> > Vladimir Oltean (6):
>> >> >   spi: spi-fsl-dspi: Don't access reserved fields in SPI_MCR
>> >> >   spi: spi-fsl-dspi: Fix little endian access to PUSHR CMD and TXDATA
>> >> >   spi: spi-fsl-dspi: Fix oper_word_size of zero for DMA mode
>> >> >   spi: spi-fsl-dspi: Add support for LS1028A
>> >> >   arm64: dts: ls1028a: Specify the DMA channels for the DSPI
>> >> > controllers
>> >> >   arm64: dts: ls1028a-rdb: Add a spidev node for the mikroBUS
>> >> >
>> >> >  .../boot/dts/freescale/fsl-ls1028a-rdb.dts    | 14 +++++
>> >> >  .../arm64/boot/dts/freescale/fsl-ls1028a.dtsi |  6 +++
>> >> >  drivers/spi/spi-fsl-dspi.c                    | 54 +++++++++++++++----
>> >> >  3 files changed, 64 insertions(+), 10 deletions(-)
>> >
>> > Thanks,
>> > -Vladimir
> 
> -Vladimir
