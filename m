Return-Path: <linux-spi+bounces-2856-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D498C6CCB
	for <lists+linux-spi@lfdr.de>; Wed, 15 May 2024 21:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EAB11F21BAC
	for <lists+linux-spi@lfdr.de>; Wed, 15 May 2024 19:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F58A3C466;
	Wed, 15 May 2024 19:26:36 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from akranes.kaiser.cx (akranes.kaiser.cx [152.53.16.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6B33BBD4;
	Wed, 15 May 2024 19:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.53.16.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715801196; cv=none; b=YLpin8EZkPEQMmP+bqgjsu/cTO8UnmtOeKSpAxKOLkK4Y/O7+XE1mMxe+VMfyFivE6gaaCJIG7JQbiKo6NDksonj5ccw3EkoO00pHO+LBHfOTQB0cjO7HHwQDGTm223O+x8c4bP8H1Iv1s5/qHomgMRDHic5tjutQTN9B2w24rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715801196; c=relaxed/simple;
	bh=IAgAE0eqXr3rNuRmILxbMX+aXNGzE+QxcpG9M8Ep/SM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rzuWUfGDDcSnoBjcrAlIqtppF5UoBzG86aekg0dWomS4KSNWA/vXsPt6CQ3LDIjg4Fb+XlGHjDJzodkc004mKb68CYjSW3e7ITNAPFTBAI0jLFSpV2Nclfh/pbcNL+Rom0n24ts78sTBth6fA4icpurvznUH8l1Kh22O2p2Flu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaiser.cx; spf=pass smtp.mailfrom=kaiser.cx; arc=none smtp.client-ip=152.53.16.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaiser.cx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaiser.cx
Received: from martin by akranes.kaiser.cx with local (Exim 4.96)
	(envelope-from <martin@akranes.kaiser.cx>)
	id 1s7KGX-000R08-1x;
	Wed, 15 May 2024 21:26:17 +0200
Date: Wed, 15 May 2024 21:26:17 +0200
From: Martin Kaiser <martin@kaiser.cx>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: imx@lists.linux.dev, Alexander Stein <alexander.stein@ew.tq-group.com>,
	Fabio Estevam <festevam@gmail.com>,
	Sascha Hauer <s.hauer@pengutronix.de>, linux-spi@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Shawn Guo <shawnguo@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] spi: imx: Don't expect DMA for i.MX{25, 35, 50, 51, 53}
 cspi devices
Message-ID: <ZkUMWWcEpLvE3b-J@akranes.kaiser.cx>
References: <20240508095610.2146640-2-u.kleine-koenig@pengutronix.de>
 <ZjuB1Rjyu1ooYvDi@akranes.kaiser.cx>
 <a342h4qn2qkmeimbuanyqh6pxbpqvz7artmodnltcxtbzeo6qn@iyth4xit622f>
 <pof7t5skj6w7to75kynjtck5hh5whc2zm3k3cd3nsz6ogthxi3@2a6at3s4lfpy>
 <ZkDq73W7MuyQ4RLj@akranes.kaiser.cx>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkDq73W7MuyQ4RLj@akranes.kaiser.cx>
Sender: "Martin Kaiser,,," <martin@akranes.kaiser.cx>

Thus wrote Martin Kaiser (martin@kaiser.cx):

> > However this breaks SPI transfers, when I try to read out an MRAM I get:

> > 	root@ecu02:~ hexdump -C /dev/mtd4
> > 	[   71.813807] spi_imx 43fa4000.spi: I/O Error in DMA TX
> > 	[   71.819173] spi-nor spi0.2: SPI transfer failed: -110
> > 	[   71.829129] spi_master spi0: failed to transfer one message from queue
> > 	[   71.843962] spi_master spi0: noqueue transfer failed

> > So it would indeed be interesting if you ever managed to use DMA on
> > i.MX25.

> I believe so. Looking into my notes from 2016 (when I last tried this), I got
> the -110 error when the SMC bit in CONREG wasn't set. But this should now be
> done in mx31_prepare_transfer if DMA is used...

> I'll try to set up a test some time next week.

I can now reproduce the dma tx error. My test board uses a dummy spidev device
on cspi1 and configures loopback on the cspi1 controller (disabling loopback
makes no difference).

I'm relatively sure that this setup did work back in 2016/17.

Commit 24bb244e02a6 ("ARM: i.MX25: globally disable supervisor protect") was
required before any DMA transfers started working on imx25. As far as I can
see, this code is still present.

I'll look into this a bit more as time permits.

   Martin

