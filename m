Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBD116574E
	for <lists+linux-spi@lfdr.de>; Thu, 20 Feb 2020 07:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbgBTGLZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 20 Feb 2020 01:11:25 -0500
Received: from bmailout2.hostsharing.net ([83.223.78.240]:57823 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbgBTGLZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 20 Feb 2020 01:11:25 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 2CC3D2800BD9A;
        Thu, 20 Feb 2020 07:11:23 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id B6878DAB72; Thu, 20 Feb 2020 07:11:22 +0100 (CET)
Date:   Thu, 20 Feb 2020 07:11:22 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Simon Han <z.han@kunbus.com>
Subject: Re: [PATCH] spi: spidev: Fix CS polarity if GPIO descriptors are used
Message-ID: <20200220061122.srkb663imntm4c6a@wunner.de>
References: <fca3ba7cdc930cd36854666ceac4fbcf01b89028.1582027457.git.lukas@wunner.de>
 <CACRpkdZmzL_bDRuiBehmd-QC93K_xJ5VHM0HaypCFXLU6sZvkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdZmzL_bDRuiBehmd-QC93K_xJ5VHM0HaypCFXLU6sZvkQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Feb 19, 2020 at 04:47:50PM +0100, Linus Walleij wrote:
> On Tue, Feb 18, 2020 at 1:08 PM Lukas Wunner <lukas@wunner.de> wrote:
> > Commit f3186dd87669 ("spi: Optionally use GPIO descriptors for CS GPIOs")
> > amended of_spi_parse_dt() to always set SPI_CS_HIGH for SPI slaves whose
> > Chip Select is defined by a "cs-gpios" devicetree property.
> >
> > This change broke userspace applications which issue an SPI_IOC_WR_MODE
> > ioctl() to an spidev:  Chip Select polarity will be incorrect unless the
> > application is changed to set SPI_CS_HIGH.  And once changed, it will be
> > incompatible with kernels not containing the commit.
> >
> > Fix by setting SPI_CS_HIGH in spidev_ioctl() (under the same conditions
> > as in of_spi_parse_dt()).
> 
> Nit: I would also insert a comment in the code to tell what is going on.

Fair enough, but the below should be clarified before I respin:


> > +                       if (ctlr->use_gpio_descriptors && ctlr->cs_gpiods &&
> > +                           ctlr->cs_gpiods[spi->chip_select])
> > +                               tmp |= SPI_CS_HIGH;
> 
> Should this be tmp ^= SPI_CS_HIGH?
> 
> If the device tree node for cs-gpios is actually active high, which
> happens, then you probably want the opposite of what was
> requested, right?

I don't quite follow.  Using an XOR here would seem to be inconsistent
with what you added to of_spi_parse_dt():  In that function, you
*always* set SPI_CS_HIGH if gpio_descs are used.  So if the polarity
is specified in the cs-gpios property, anything else is considered
irrelevant and ignored.

Applying the same logic to spidev_ioctl() means that if the user
specified SPI_CS_HIGH, it is likewise ignored because the polarity
in the cs-gpios property takes precedence.  Am I missing something?

TBH the way commit f3186dd87669 abuses SPI_CS_HIGH seems clumsy to me.
Would it not have been possible to just amend spi_set_cs() like this:

-	if (spi->mode & SPI_CS_HIGH)
+	if (spi->mode & SPI_CS_HIGH && !(ctlr->use_gpio_descriptors &&
+					 ctlr->cs_gpiods &&
+					 ctlr->cs_gpiods[spi->chip_select]))
		enable = !enable;

This would have avoided the regression fixed by my patch.
Also note that spi_setup() emits a dev_dbg() which now incorrectly
reports "cs_high" if a cs-gpios property is present. :-(

Thanks,

Lukas
