Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B482434AF1
	for <lists+linux-spi@lfdr.de>; Wed, 20 Oct 2021 14:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbhJTMQS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 20 Oct 2021 08:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbhJTMQR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 20 Oct 2021 08:16:17 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3AAC06161C
        for <linux-spi@vger.kernel.org>; Wed, 20 Oct 2021 05:14:03 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 305651F440BF;
        Wed, 20 Oct 2021 13:14:01 +0100 (BST)
Date:   Wed, 20 Oct 2021 14:13:57 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Lima <mauro.lima@eclypsium.com>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <linux-mtd@lists.infradead.org>, <linux-spi@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] mtd: spi-nor: intel-spi: Convert to SPI MEM
Message-ID: <20211020141357.3559ca95@collabora.com>
In-Reply-To: <20211020115913.uzo3ogkmrltnb26y@ti.com>
References: <20211013114432.31352-1-mika.westerberg@linux.intel.com>
        <20211013114432.31352-3-mika.westerberg@linux.intel.com>
        <20211020114153.0f99c5df@collabora.com>
        <20211020115913.uzo3ogkmrltnb26y@ti.com>
Organization: Collabora
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 20 Oct 2021 17:29:15 +0530
Pratyush Yadav <p.yadav@ti.com> wrote:

> On 20/10/21 11:41AM, Boris Brezillon wrote:
> > On Wed, 13 Oct 2021 14:44:31 +0300
> > Mika Westerberg <mika.westerberg@linux.intel.com> wrote:
> >   
> > > The preferred way to implement SPI-NOR controller drivers is through SPI
> > > subsubsystem utilizing the SPI MEM core functions. This converts the
> > > Intel SPI flash controller driver over the SPI MEM by moving the driver
> > > from SPI-NOR subsystem to SPI subsystem and in one go make it use the
> > > SPI MEM functions. The driver name will be changed from intel-spi to
> > > spi-intel to match the convention used in the SPI subsystem.
> > >   
> > 
> > I skimmed over the driver changes, and I'm skeptical about this "let's
> > convert all spi-nor controller drivers into spi-mem drivers even if
> > they don't fit the spi-mem model" strategy. Clearly, the intel
> > controller is much more limited than any other spi-mem controller (I
> > mean feature-wise not perf-wise of course). The fact that you have to
> > check the opcode to decide whether the operation is supported or not,
> > or the way you deduce when to issue an erase vs a regular read/write is
> > kind of hack-ish. Not saying we shouldn't support this case in spi-mem,
> > but it should at least be done in a more controlled way. Maybe with an
> > explicit array of supported spi_mem operations, and driver specific
> > hooks for each of these operations so anything falling outside is
> > clearly identified and rejected (we have this sort of things in the raw
> > NAND framework).  
> 
> I am curious about how we can solve this. Any pointers to 
> functions/drivers in raw NAND framework that follow this model?

It's not quite what you'd need, but nand_op_parser_pattern follows the
same philosophy: describe a pattern and attach a hook to be executed
when this pattern is found. Then you pass this pattern table to a helper
that tries to match the operation against the supported patterns. If it
finds one that matches, the operation is reported as supported and/or
executed, otherwise it's rejected.

In this particular case, the pattern must be very specific:

* matching opcode
* matching direction
* matching number of address cycles
* matching number of dummy cycles?
* max/min number of data cycles?
