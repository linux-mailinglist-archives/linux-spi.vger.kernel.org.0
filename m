Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84535434B0B
	for <lists+linux-spi@lfdr.de>; Wed, 20 Oct 2021 14:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbhJTMVZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Wed, 20 Oct 2021 08:21:25 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:39503 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbhJTMVU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 20 Oct 2021 08:21:20 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 6C1CD100005;
        Wed, 20 Oct 2021 12:18:56 +0000 (UTC)
Date:   Wed, 20 Oct 2021 14:18:55 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Boris Brezillon <boris.brezillon@collabora.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Michael Walle <michael@walle.cc>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Lima <mauro.lima@eclypsium.com>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <linux-mtd@lists.infradead.org>, <linux-spi@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] mtd: spi-nor: intel-spi: Convert to SPI MEM
Message-ID: <20211020141855.75f0314d@xps13>
In-Reply-To: <20211020115913.uzo3ogkmrltnb26y@ti.com>
References: <20211013114432.31352-1-mika.westerberg@linux.intel.com>
        <20211013114432.31352-3-mika.westerberg@linux.intel.com>
        <20211020114153.0f99c5df@collabora.com>
        <20211020115913.uzo3ogkmrltnb26y@ti.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Pratyush,

p.yadav@ti.com wrote on Wed, 20 Oct 2021 17:29:15 +0530:

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

->exec_op() should be implemented by controller drivers, there is a
check_only flag to verify that the operation is supported by the
controller, the entire operation is provided so that the controller
driver knows exactly where we are going and does not try to guess
anything. There is also a parser in the core that allows
"complicated"/"constrained" drivers to just give a number of patterns
they support and the parser will do the job of finding how the
operation should be split.

I believe this was what Boris referred to. If not, please correct me.

Thanks,
Miquèl
