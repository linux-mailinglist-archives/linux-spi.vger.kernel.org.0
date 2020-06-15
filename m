Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29E9F1F8F4B
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jun 2020 09:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbgFOHTh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Jun 2020 03:19:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:37906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728417AbgFOHTg (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 15 Jun 2020 03:19:36 -0400
Received: from localhost (unknown [171.61.66.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3B20206D7;
        Mon, 15 Jun 2020 07:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592205575;
        bh=sUsoYboFQvARlrHTsUiM3cD/BcO9o1B8GEAGyFExK74=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hX5i481ti5uYsYfjR/Sys+++2YWQBXqKyMhY/nyXTZJa7t1hCPaq5YJrQbzTkKRF/
         77ipSxJq9l/mLcTdE6/Qa8hj7e3xFezC0EhH1hgmKtR7uTTBgAJLdh6w0LPf35xvvP
         2qAqtlDOGdeHKH/hC+vYmb0SZDCN0s/5y4Ux1Du0=
Date:   Mon, 15 Jun 2020 12:49:31 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     Mark Brown <broonie@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "matthias.schiffer@ew.tq-group.com" 
        <matthias.schiffer@ew.tq-group.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 RFC 1/2] spi: introduce fallback to pio
Message-ID: <20200615071931.GK1393454@vkoul-mobl>
References: <1591880310-1813-1-git-send-email-yibin.gong@nxp.com>
 <1591880310-1813-2-git-send-email-yibin.gong@nxp.com>
 <20200611134042.GG4671@sirena.org.uk>
 <VE1PR04MB66383245FAD2AE33CFEA76F789810@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <20200612101357.GA5396@sirena.org.uk>
 <VE1PR04MB66384013797FE6B01943F2A889810@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <20200612141611.GI5396@sirena.org.uk>
 <VE1PR04MB6638B43E3AC83286946DABCD899F0@VE1PR04MB6638.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VE1PR04MB6638B43E3AC83286946DABCD899F0@VE1PR04MB6638.eurprd04.prod.outlook.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 14-06-20, 13:04, Robin Gong wrote:
> On 2020/06/12 22:16 Mark Brown <broonie@kernel.org> wrote: 
> > On Fri, Jun 12, 2020 at 01:48:41PM +0000, Robin Gong wrote:
> > > On 2020/06/12 18:14 Mark Brown <broonie@kernel.org> wrote:
> > 
> > > > Please look at the formatting of your e-mails - they're really hard
> > > > to read.  The line length is over 80 columns and there's no breaks between
> > paragraphs.
> > 
> > > Sorry for that, seems my outlook format issue, hope it's ok now this
> > > time :)
> > 
> > Yes, looks good thanks!
> > 
> > > > Client could enable this feature by choosing SPI_MASTER_FALLBACK
> > > > freely without any impact on others.
> > 
> > > > SPI_MASTER_FALLBACK.  If this works why would any driver not enable
> > > > the flag?
> > 
> > > Just make sure little impact if it's not good enough and potential
> > > issue may come out after it's merged into mainline. TBH, I'm not sure
> > > if it has taken care all in spi core. Besides, I don't know if other spi client need
> > this feature.
> > 
> > It's not something that's going to come up a lot for most devices, it'd be a
> > mapping failure due to running out of memory or something, but your point
> > about that being possible is valid.
> > 
> > > > > Any error happen in DMA could fallback to PIO , seems a nice to
> > > > > have,
> > > > because it could
> > > > > give chance to run in PIO which is more reliable. But if there is
> > > > > also error in
> > 
> > > > PIO, thus may loop here, it's better adding limit try times here?
> > 
> > > > An error doesn't mean nothing happened on the bus, an error could
> > > > for example also be something like a FIFO overrun which corrupts data.
> > 
> > > Do you mean fallback to PIO may cause FIFO overrun since some latency
> > > involved so that this patch seems not useful as expected?
> > 
> > No, I mean that the reason the DMA transfer fails may be something that
> > happens after we've started putting things on the bus - the bit about FIFOs is
> > just a random example of an error that could happen.
> > 
> Sorry Mark for that I can't get your point... The bus error such as data corrupt
> seems not the spi core's business since it can only be caught in spi controller
> driver or upper level such as mtd driver (spi-nor) which know what's the failure
> happen at spi bus HW level or what's the correct data/message. In other words,
> spi core can't detect such error by transfer_one().
> 
> > > > It *could* but only in extreme situations, and again this isn't just
> > > > handling errors from failure to prepare the hardware but also
> > > > anything that happens after it.
> > 
> > > Okay, understood your point. You prefer to some interface provided by
> > > dma engine before dmaengine_prep_slave_sg so that can_dma() can know
> > > if this dma channel is ready indeed. But unfortunately, seems there is no
> > one....
> > 
> > Well, this is free software and everything can be modified!  The other option
> > would be framework changes in SPI that allowed us to indicate from the driver
> > that an error occured before we started doing anything to the hardware (like
> > happens here) through something like a special error code or splitting up the
> > API.
> Yes, but both assume spi controller driver could detect such dma failure before
> dmaengine_prep_*(). Let's wait Vinod's comment for that if dmaengine_slave_config
> could keep direction.

The direction is already in the prep_ call, so sending in
dmaengine_slave_config is not required, pls pass it in the prep_ call

> But despite of that case, do you think this patch is valid for transfer_one() failue
> in dma and fallback to pio?

-- 
~Vinod
