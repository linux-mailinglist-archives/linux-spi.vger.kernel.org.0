Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86BC6256613
	for <lists+linux-spi@lfdr.de>; Sat, 29 Aug 2020 10:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbgH2Ib0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 29 Aug 2020 04:31:26 -0400
Received: from verein.lst.de ([213.95.11.211]:44101 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726083AbgH2Ib0 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sat, 29 Aug 2020 04:31:26 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0EAD668C4E; Sat, 29 Aug 2020 10:31:21 +0200 (CEST)
Date:   Sat, 29 Aug 2020 10:31:21 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Rich Felker <dalias@libc.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Christoph Hellwig <hch@lst.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH 09/10] sh: don't allow non-coherent DMA for NOMMU
Message-ID: <20200829083121.GA7851@lst.de>
References: <20200714121856.955680-1-hch@lst.de> <20200714121856.955680-10-hch@lst.de> <20200828020045.GT3265@brightrain.aerifal.cx> <20200828021152.GU3265@brightrain.aerifal.cx> <20200828042422.GA29734@lst.de> <CAPDyKFrKJrUN8mJ94g0+0Vs3aT1uq9MmHWfvzcVaoA5efaYPmQ@mail.gmail.com> <20200828150942.GV3265@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828150942.GV3265@brightrain.aerifal.cx>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Aug 28, 2020 at 11:09:43AM -0400, Rich Felker wrote:
> > However, by looking at the code, one get the feeling that the DMA
> > support is somewhat prepared to be made optional. I guess it has never
> > been really tested, as the Kconfig option has "depends on HAS_DMA"  -
> > and it's been like that as long as I can remember.
> 
> It always worked on our "byte-banged" SPI controller, with no DMA
> controller present, before Christoph's changes in this patch series,

Before that nommu sh builds provided a DMA mapping implementation
that even worked for the streaming side (dma_map_*), but would corrupt
data if you used dma_alloc_coherent memory to communicate with the
device. 

> and seems to be working now (although I have some other, hopefully
> unrelated regressions to debug) with #ifdef CONFIG_HAS_DMA around the
> if (spi->master->dev.parent->dma_mask) block in mmc_spi_probe. That's
> probably not the right fix though -- why isn't it checking
> host->dma_dev instead and only attempting DMA setup if dma_dev is
> non-null?

I don't think dma_dev can be NULL right now.  dma_dev is assigned here:

	if (spi->master->dev.parent->dma_mask) {
		struct device   *dev = spi->master->dev.parent;

		host->dma_dev = dev;

but for any OF or real bus device dma_mask never is zero (it actually is
a pointer), and the value of it also is initialized to 32-bit by default,
making this effectively an "if (1) {".  The driver needs some way to
communicate if a given device actually is DMA capable or not. Or is that
purely a factor of the platform which would be a little strange.

In which case we should do something like:


diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
index 39bb1e30c2d722..3b0cc9a70e6432 100644
--- a/drivers/mmc/host/mmc_spi.c
+++ b/drivers/mmc/host/mmc_spi.c
@@ -1374,7 +1374,7 @@ static int mmc_spi_probe(struct spi_device *spi)
 	if (!host->data)
 		goto fail_nobuf1;
 
-	if (spi->master->dev.parent->dma_mask) {
+	if (IS_ENABLED(CONFIG_HAS_DMA)) {
 		struct device	*dev = spi->master->dev.parent;
 
 		host->dma_dev = dev;
