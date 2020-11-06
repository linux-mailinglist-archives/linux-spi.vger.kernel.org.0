Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6DA92A9214
	for <lists+linux-spi@lfdr.de>; Fri,  6 Nov 2020 10:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbgKFJFp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Fri, 6 Nov 2020 04:05:45 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:59210 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgKFJFo (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 6 Nov 2020 04:05:44 -0500
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 2CDA51F4679D;
        Fri,  6 Nov 2020 09:05:42 +0000 (GMT)
Date:   Fri, 6 Nov 2020 10:05:39 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
Cc:     =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        BMC-SW <BMC-SW@aspeedtech.com>
Subject: Re: [v3 4/4] spi: aspeed: Add ASPEED FMC/SPI memory controller
 driver
Message-ID: <20201106100539.62fc5249@collabora.com>
In-Reply-To: <HK0PR06MB2786DAC99A56EA302EE969CAB2ED0@HK0PR06MB2786.apcprd06.prod.outlook.com>
References: <20201105120331.9853-1-chin-ting_kuo@aspeedtech.com>
        <20201105120331.9853-5-chin-ting_kuo@aspeedtech.com>
        <fd8fa472-53bb-c992-3dc2-5a984a439c07@kaod.org>
        <20201105161132.37eb3265@collabora.com>
        <HK0PR06MB2786DAC99A56EA302EE969CAB2ED0@HK0PR06MB2786.apcprd06.prod.outlook.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 6 Nov 2020 08:58:23 +0000
Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com> wrote:

> Hi Boris,
> 
> Thanks for your quick reply.
> 
> > -----Original Message-----
> > From: Boris Brezillon <boris.brezillon@collabora.com>
> > Sent: Thursday, November 5, 2020 11:12 PM
> > To: Cédric Le Goater <clg@kaod.org>; robh+dt@kernel.org
> > Cc: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>; broonie@kernel.org;
> > joel@jms.id.au; andrew@aj.id.au; bbrezillon@kernel.org;
> > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
> > linux-aspeed@lists.ozlabs.org; linux-spi@vger.kernel.org; BMC-SW
> > <BMC-SW@aspeedtech.com>
> > Subject: Re: [v3 4/4] spi: aspeed: Add ASPEED FMC/SPI memory controller
> > driver
> > 
> > Hi,
> > 
> > On Thu, 5 Nov 2020 15:09:11 +0100
> > Cédric Le Goater <clg@kaod.org> wrote:
> >   
> > > Hello Chin-Ting,
> > >
> > > Thanks for this driver. It's much cleaner than the previous and we
> > > should try adding support for the AST2500 SoC also. I guess we can
> > > keep the old driver for the AST2400 which has a different register layout.
> > >
> > > On the patchset, I think we should split this patch in three :
> > >
> > >  - basic support
> > >  - AHB window calculation depending on the flash size
> > >  - read training support  
> > 
> > I didn't look closely at the implementation, but if the read training tries to read
> > a section of the NOR, I'd recommend exposing that feature through spi-mem
> > and letting the SPI-NOR framework trigger the training instead of doing that at
> > dirmap creation time (remember that spi-mem is also used for SPI NANDs
> > which use the dirmap API too, and this training is unlikely to work there).
> > 
> > The SPI-NOR framework could pass a read op template and a reference pattern
> > such that all the spi-mem driver has to do is execute the template op and
> > compare the output to the reference buffer.
> >   
> 
> I agree it. Before, I were not able to find a suitable location to implement read training feature.
> I think that I can add a SPI timing training function in "spi_controller_mem_ops" struct and
> call it by a wrapper function called at the bottom of spi_nor_probe() in spi-nor.c.
> Maybe, SPI-NOR framework does not need to pass reference buffer since calibration
> method depends on each SoC itself and buffer size may be variant.
> The detail calibration method may be implemented in each SoC SPI driver.

That's a real problem IMO. What makes this pattern SoC specific? I can
see why the location in flash could be *board* specific, but the
pattern should be pretty common, right? As for the spi-mem operation to
be executed, it's definitely memory specific (I can imagine some flash
vendors providing a specific command returning a fixed pattern that's
not actually stored on a visible portion of the flash).

> 
> Besides, I am thinking about the possibility for adding a "spi_mem_post_init" function in
> spi-mem framework sine for some SoCs, SPI controller needs to adjust some settings
> after getting SPI flash information.

I don't think that's a good idea. The spi-mem interface should stay
memory-type agnostic and doing that means we somehow pass NOR specific
info. What is it that you need exactly, and why?
