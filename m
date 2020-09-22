Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA04F27405F
	for <lists+linux-spi@lfdr.de>; Tue, 22 Sep 2020 13:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgIVLG6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Sep 2020 07:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbgIVLG6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 22 Sep 2020 07:06:58 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0036C061755
        for <linux-spi@vger.kernel.org>; Tue, 22 Sep 2020 04:06:57 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1kKg8L-0008Hj-CD; Tue, 22 Sep 2020 13:06:53 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1kKg8K-0006UQ-Pc; Tue, 22 Sep 2020 13:06:52 +0200
Date:   Tue, 22 Sep 2020 13:06:52 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-spi@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        kernel@pengutronix.de, Vladimir Oltean <olteanv@gmail.com>,
        Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH 1/6] spi: fsl-dspi: Use devm_spi_register_controller()
Message-ID: <20200922110652.GC25328@pengutronix.de>
References: <20200922093228.24917-1-s.hauer@pengutronix.de>
 <20200922093228.24917-2-s.hauer@pengutronix.de>
 <20200922094437.GL4792@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922094437.GL4792@sirena.org.uk>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 12:13:02 up 215 days, 17:43, 151 users,  load average: 0.21, 0.27,
 0.28
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Sep 22, 2020 at 10:44:37AM +0100, Mark Brown wrote:
> On Tue, Sep 22, 2020 at 11:32:23AM +0200, Sascha Hauer wrote:
> 
> > @@ -1440,9 +1440,6 @@ static int dspi_remove(struct platform_device *pdev)
> >  	struct spi_controller *ctlr = platform_get_drvdata(pdev);
> >  	struct fsl_dspi *dspi = spi_controller_get_devdata(ctlr);
> >  
> > -	/* Disconnect from the SPI framework */
> > -	spi_unregister_controller(dspi->ctlr);
> > -
> >  	/* Disable RX and TX */
> >  	regmap_update_bits(dspi->regmap, SPI_MCR,
> >  			   SPI_MCR_DIS_TXF | SPI_MCR_DIS_RXF,
> 
> Is this fix safe - what happens if we start another transaction between
> disabling RX/TX and the unregistration taking effect?  Similar concerns
> apply to some of the other patches.

I asked myself the same question until I saw that a dozen of other drivers
also do it like this.

I don't think it's safe. Currently we only have spi_unregister_controller()
which both unregisters child SPI devices and frees the SPI controller along
with the driver data.
There are many drivers have something in their remove function like
disabling the hardware, clocks, freeing interrupts. They do it either
before calling spi_unregister_controller(), in which case messages may be
queued on a teared down hardware, or they do it after calling
spi_unregister_controller(), in which case they operate on already freed
data. IMO this only works when all drivers are fully managed with devm_*
functions and runtime pm so that the remove functions for all drivers
become empty.  Until this happens spi_unregister_controller() has to be
split up in a function actually unregistering the controller and another
one freeing the resources.

Sascha


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
