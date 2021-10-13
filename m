Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDAD42C361
	for <lists+linux-spi@lfdr.de>; Wed, 13 Oct 2021 16:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233699AbhJMOgF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Wed, 13 Oct 2021 10:36:05 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:47207 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237694AbhJMOgE (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 13 Oct 2021 10:36:04 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 346201BF208;
        Wed, 13 Oct 2021 14:33:58 +0000 (UTC)
Date:   Wed, 13 Oct 2021 16:33:57 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Richard Weinberger <richard@nod.at>, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, linux-mtd@lists.infradead.org,
        kernel@pengutronix.de
Subject: Re: [PATCH v2 13/20] mtd: dataflash: Warn about failure to
 unregister mtd device
Message-ID: <20211013163357.41c7471d@xps13>
In-Reply-To: <20211013140835.olo2dxdno6zlom7n@pengutronix.de>
References: <20211012153945.2651412-1-u.kleine-koenig@pengutronix.de>
        <20211012153945.2651412-14-u.kleine-koenig@pengutronix.de>
        <20211013144429.65b294e5@xps13>
        <20211013140835.olo2dxdno6zlom7n@pengutronix.de>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Uwe,

u.kleine-koenig@pengutronix.de wrote on Wed, 13 Oct 2021 16:08:35 +0200:

> On Wed, Oct 13, 2021 at 02:44:29PM +0200, Miquel Raynal wrote:
> > Hi Uwe,
> > 
> > u.kleine-koenig@pengutronix.de wrote on Tue, 12 Oct 2021 17:39:38 +0200:
> >   
> > > When an spi driver's remove function returns a non-zero error code  
> > 
> > Should we s/an spi/a SPI/?  
> 
> My (German) knowledge about the English Grammar claims that independent
> of how you spell SPI, it must be "an" because when I say it, it's
> [ɛspi:aɪ] (unless you call it [spaɪ]?)

I (personally) pronounce it [spaɪ] with my French background and it
looks wrong to my eyes to use "an" before SPI because of that, but this
is biased and possibly wrong as well so please keep it your way, it's
fine.

> In my eyes "spi" is right, because SPI is the protocol and "spi" is
> the kernel framework. But I don't feel strong here and you're already
> the second who suggests something similar.

I get it. Indeed I always use uppercase letters when I use acronyms
(such as SPI or MTD) and it's the first time I hear that the lowercase
letter refers to the framework more than the protocol, but TBH the
explanation kind of seduces me :)

> > > nothing happens apart from emitting a generic error message. Make
> > > this error message more device specific and return zero instead.
> > > 
> > > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > > ---
> > >  drivers/mtd/devices/mtd_dataflash.c | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/mtd/devices/mtd_dataflash.c
> > > b/drivers/mtd/devices/mtd_dataflash.c index
> > > 9802e265fca8..2691b6b79df8 100644 ---
> > > a/drivers/mtd/devices/mtd_dataflash.c +++
> > > b/drivers/mtd/devices/mtd_dataflash.c @@ -919,7 +919,10 @@ static
> > > int dataflash_remove(struct spi_device *spi) status =
> > > mtd_device_unregister(&flash->mtd); if (status == 0)
> > >  		kfree(flash);
> > > -	return status;
> > > +	else
> > > +		dev_warn(&spi->dev, "Failed to unregister mtd
> > > device (%pe)\n",
> > > +			 ERR_PTR(status));
> > > +	return 0;  
> > 
> > As part of a recent NAND cleanup series we ended up adding
> > WARN_ON() [1] to make it very clear that if this happens, it's not
> > expected at all (it was Boris' advice).
> > 
> > I don't think there is only one good solution but perhaps its best
> > to keep it sync'ed with the other drivers in MTD?  
> 
> Well, if WARN_ON or dev_warn is the right thing is subjective. Your
> subjective counts more as you're an MTD maintainer. Can rework
> accordingly for v3.

Then let's all use WARN_ON() for now.

Thanks,
Miquèl
