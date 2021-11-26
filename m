Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B04245EFB0
	for <lists+linux-spi@lfdr.de>; Fri, 26 Nov 2021 15:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377785AbhKZOQX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Fri, 26 Nov 2021 09:16:23 -0500
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:39707 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236190AbhKZOOX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 26 Nov 2021 09:14:23 -0500
X-Greylist: delayed 9101 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Nov 2021 09:14:22 EST
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 0AEA6FF807;
        Fri, 26 Nov 2021 14:10:59 +0000 (UTC)
Date:   Fri, 26 Nov 2021 15:10:59 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        linux-mtd@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        Xiangsheng Hou <Xiangsheng.Hou@mediatek.com>,
        Julien Su <juliensu@mxic.com.tw>,
        Jaime Liao <jaimeliao@mxic.com.tw>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 00/20] External ECC engines & Macronix support
Message-ID: <20211126151059.10c19ec7@xps13>
In-Reply-To: <YaDjDhOhpHMdxiqA@sirena.org.uk>
References: <20211126113924.310459-1-miquel.raynal@bootlin.com>
        <YaDjDhOhpHMdxiqA@sirena.org.uk>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark,

broonie@kernel.org wrote on Fri, 26 Nov 2021 13:37:18 +0000:

> On Fri, Nov 26, 2021 at 12:39:04PM +0100, Miquel Raynal wrote:
> 
> > As a first example, Macronix ECC engine can be used as an
> > external engine (takes the data, proceeds to the calculations, writes
> > back the ECC bytes) or as a pipelined engine doing on-the-fly
> > calculations (which is very common in the raw NAND world).  
> 
> The SPI bits of this look fine (most of the smarts are in the MTD
> code!), what's the plan for getting this merged?

Great! Thanks for the feedback.

If you acknowledge the SPI bits I believe I can carry the entire series
through the MTD tree. If you fear conflicts and need an immutable tag I
can also do that.

Thanks,
Miquèl
