Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 634BE1D5F43
	for <lists+linux-spi@lfdr.de>; Sat, 16 May 2020 08:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725867AbgEPG4J (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 16 May 2020 02:56:09 -0400
Received: from bmailout2.hostsharing.net ([83.223.78.240]:34037 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgEPG4J (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 16 May 2020 02:56:09 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 6EAF02802D298;
        Sat, 16 May 2020 08:56:07 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 39528144DB0; Sat, 16 May 2020 08:56:07 +0200 (CEST)
Date:   Sat, 16 May 2020 08:56:07 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Martin Sperl <kernel@martin.sperl.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/5] spi: bcm2835: Fix controller unregister order
Message-ID: <20200516065607.zrqwlh5ayoth37y4@wunner.de>
References: <cover.1589557526.git.lukas@wunner.de>
 <2397dd70cdbe95e0bc4da2b9fca0f31cb94e5aed.1589557526.git.lukas@wunner.de>
 <20200515162903.GH5066@sirena.org.uk>
 <20200515164404.bev4zjzcmx4nwzhi@wunner.de>
 <CAHp75Vfs=gc9c2h2amhu0eb3ux8jJAuC7CRY8fLrFiBsTwtSYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vfs=gc9c2h2amhu0eb3ux8jJAuC7CRY8fLrFiBsTwtSYQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, May 16, 2020 at 12:33:00AM +0300, Andy Shevchenko wrote:
> On Fri, May 15, 2020 at 7:45 PM Lukas Wunner <lukas@wunner.de> wrote:
> > On Fri, May 15, 2020 at 05:29:03PM +0100, Mark Brown wrote:
> > > On Fri, May 15, 2020 at 05:58:02PM +0200, Lukas Wunner wrote:
> > > > Fix by using the non-devm variant spi_register_controller().  Note that
> > > > the struct spi_controller as well as the driver-private data are not
> > > > freed until after bcm2835_spi_remove() has finished, so accessing them
> > > > is safe.
> > >
> > > Why not use managed allocations of clocks and DMA channels?  This is a
> > > standard issue with the devm APIs, if you're using them you basically
> > > need to use them for *everything* up to the point where you start using
> > > them.
> >
> > There is no devm version of clk_prepare_enable(), dma_request_chan()
> > and various other functions invoked on ->probe() by spi-bcm2835.c.
> > So tearing down DMA channels, disabling clocks etc needs to happen
> > in the ->remove() hook and consequently devm_spi_register_controller()
> > cannot be used.
> 
> There is devm_add_action_or_reset (IIRC the name). It does a trick.

Interesting, thanks.

However there are currently four actions performed by bcm2835_spi_remove():

	bcm2835_debugfs_remove(bs);

	/* Clear FIFOs, and disable the HW block */
	bcm2835_wr(bs, BCM2835_SPI_CS,
		   BCM2835_SPI_CS_CLEAR_RX | BCM2835_SPI_CS_CLEAR_TX);

	clk_disable_unprepare(bs->clk);

	bcm2835_dma_release(ctlr, bs);

So I think I'd have to add four functions to perform these devm actions,
which would add a lot more code than just the single line added by my
patch.  It also seems doubtful that the teardown code will still be easy
to follow.  And small patches like the ones I've submitted lend themselves
better to backporting to stable.

Mark, please provide guidance as to which variant you'd prefer:
Switching to the non-devm variant of spi_register_controller() as I've
done here or adding devm calls for all the existing teardown steps.

Thanks,

Lukas
