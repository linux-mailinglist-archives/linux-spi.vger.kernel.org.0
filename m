Return-Path: <linux-spi+bounces-3395-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE4F90784B
	for <lists+linux-spi@lfdr.de>; Thu, 13 Jun 2024 18:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3A16283AB6
	for <lists+linux-spi@lfdr.de>; Thu, 13 Jun 2024 16:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EDDE381B0;
	Thu, 13 Jun 2024 16:30:55 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from akranes.kaiser.cx (akranes.kaiser.cx [152.53.16.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F0B12EBD7;
	Thu, 13 Jun 2024 16:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.53.16.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718296255; cv=none; b=PcW6+H6nxOJgIlbTSG6EtbNhyFEdRGZSWFXLRFxD5ih8PLpiet1+++Hx0x+z8C3KDXRA9pFl9uyQXwutQtu1+xA45yQimIBq8b8qg3zkqD6vZzKfyQwXIxnHeQp01afAMpWjCyt56r4wSpJ4wVyWvY9lIsUX1GJsUcVIE4oeFMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718296255; c=relaxed/simple;
	bh=CPnWHwYnGbtOANd/gqnYJzF+AdtChj9v/G7JGCbbXGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vBpSq46k7i6jgoCM6mFxS0ecMnicXbG2Cg6yXoo9mWuVr29h+K6RlFszh88gVOUmtumN7rPsQ2w4iNIHDGQKFibpaVkcYghzVxfcerHAhGzVXTBIrtUwEXbXBRfEnZcf7zVMuP+p32JMgR4l1lwfYlPvs3+CLg04DRQsLlBWMAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaiser.cx; spf=pass smtp.mailfrom=kaiser.cx; arc=none smtp.client-ip=152.53.16.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaiser.cx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaiser.cx
Received: from martin by akranes.kaiser.cx with local (Exim 4.96)
	(envelope-from <martin@akranes.kaiser.cx>)
	id 1sHn2k-001onM-2U;
	Thu, 13 Jun 2024 18:11:18 +0200
Date: Thu, 13 Jun 2024 18:11:18 +0200
From: Martin Kaiser <martin@kaiser.cx>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: u.kleine-koenig@baylibre.com, imx@lists.linux.dev,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Fabio Estevam <festevam@gmail.com>,
	Sascha Hauer <s.hauer@pengutronix.de>, linux-spi@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Shawn Guo <shawnguo@kernel.org>,
	linux-arm-kernel@lists.infradead.org, T.Scherer@eckelmann.de
Subject: Re: [PATCH] spi: imx: Don't expect DMA for i.MX{25, 35, 50, 51, 53}
 cspi devices
Message-ID: <ZmsaJnASSkO3I19t@akranes.kaiser.cx>
References: <20240508095610.2146640-2-u.kleine-koenig@pengutronix.de>
 <ZjuB1Rjyu1ooYvDi@akranes.kaiser.cx>
 <a342h4qn2qkmeimbuanyqh6pxbpqvz7artmodnltcxtbzeo6qn@iyth4xit622f>
 <pof7t5skj6w7to75kynjtck5hh5whc2zm3k3cd3nsz6ogthxi3@2a6at3s4lfpy>
 <ZkDq73W7MuyQ4RLj@akranes.kaiser.cx>
 <ZkUMWWcEpLvE3b-J@akranes.kaiser.cx>
 <20240612-rebel-thick-chital-2f7bfa-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612-rebel-thick-chital-2f7bfa-mkl@pengutronix.de>
Sender: "Martin Kaiser,,," <martin@akranes.kaiser.cx>

Hello Marc,

Thus wrote Marc Kleine-Budde (mkl@pengutronix.de):

> Hello Martin,

> On 15.05.2024 21:26:17, Martin Kaiser wrote:
> > Thus wrote Martin Kaiser (martin@kaiser.cx):

> > > > However this breaks SPI transfers, when I try to read out an MRAM I get:

> > > > 	root@ecu02:~ hexdump -C /dev/mtd4
> > > > 	[   71.813807] spi_imx 43fa4000.spi: I/O Error in DMA TX
> > > > 	[   71.819173] spi-nor spi0.2: SPI transfer failed: -110
> > > > 	[   71.829129] spi_master spi0: failed to transfer one message from queue
> > > > 	[   71.843962] spi_master spi0: noqueue transfer failed

> > > > So it would indeed be interesting if you ever managed to use DMA on
> > > > i.MX25.

> > > I believe so. Looking into my notes from 2016 (when I last tried this), I got
> > > the -110 error when the SMC bit in CONREG wasn't set. But this should now be
> > > done in mx31_prepare_transfer if DMA is used...

> > > I'll try to set up a test some time next week.

> > I can now reproduce the dma tx error. My test board uses a dummy spidev device
> > on cspi1 and configures loopback on the cspi1 controller (disabling loopback
> > makes no difference).

> > I'm relatively sure that this setup did work back in 2016/17.

> > Commit 24bb244e02a6 ("ARM: i.MX25: globally disable supervisor protect") was
> > required before any DMA transfers started working on imx25. As far as I can
> > see, this code is still present.

> > I'll look into this a bit more as time permits.

> have you found the time to look into this?

I did have another look but couldn't get DMA to work :-(

I got to the point where tx seemed to work and rx failed. The tx callback
function was called from the dma core and rx timed out. However, looking at
the mosi, miso and clk signals, there was no clock and no data transmission on
the bus.

The dev_dbg prints in imx-sdma didn't show anything that looked wrong...

I'll have another go some time soon. In the meantime, feel free to merge this
patch and disable DMA on imx25.

Best regards,
Martin

