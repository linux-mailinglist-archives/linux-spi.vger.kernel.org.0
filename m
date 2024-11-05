Return-Path: <linux-spi+bounces-5620-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E46B9BC74C
	for <lists+linux-spi@lfdr.de>; Tue,  5 Nov 2024 08:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E223D282B2E
	for <lists+linux-spi@lfdr.de>; Tue,  5 Nov 2024 07:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F266C1FE105;
	Tue,  5 Nov 2024 07:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="T9gosV/O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TmIgENc4"
X-Original-To: linux-spi@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7791F282F1;
	Tue,  5 Nov 2024 07:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730793016; cv=none; b=jr32Xl13+LyyaZ0u0+5XAWYtq/4RAH8NH4fHr8Tz72YACxsTagpH1u92DtjINEIXed0yyS2UnX5jBt8FCrzpzWDb+bkXPabtrVuisbrEjGMbz9n8Hn7biBSu6rRMqAwhEanWnkSt7WZSQ3wBxTLP2ZhNrZV3/G2596t5ir35yFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730793016; c=relaxed/simple;
	bh=qAOB4Tys5t6tpZB/veCWrbZMv0vMqWXPzqNzaCQOZ+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oN7GT/ZYCpwv0iabg9J+IdeYeYiLr8SI31rcyjDN59GkDKcYdcSZyI6bHxml5tjhIgJUxfRXfJV9kYklV80WaaH+W7cVyVtGTKWoUKHLCjRa08NAGW/C6J4qh4GPuNGd+ICJ+dP9rekjy+7JEimTNRmfveJ1TjzRvTet8xgKcOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=T9gosV/O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TmIgENc4; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id A86B21380601;
	Tue,  5 Nov 2024 02:50:13 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 05 Nov 2024 02:50:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1730793013;
	 x=1730879413; bh=D6OCx3NzmrJdDDip+0qK9zMAnmCzPOYRXUxgWn1goh8=; b=
	T9gosV/O6KKn+nbmM0uE04aOhEHtzDt9NRv8YLMqJubADrKNYMP+wz8IVqKxQbvp
	/QZ94IbSeRF+2urkUBecDpSCqED4mKB3cDkBr4wjFGHJm71r1PocxpWsCHf/kLXo
	nuctPwor1kwoTdOnxmex61J4IPl2LrjjGUS7ZUZ9SfvrknKeR5jpSSLcnbqLi3tO
	SLkgiK4L/J0FR8/BgapBz/PF0aXeYvFeDkjt1vw7rJIv4mLUrbkE3/HSEiUfbr2P
	SGA2G34XN9oljawyTaX8XPl8AFXKVpMUeVSN1hoDNfpBagSgcrV1sbW++WHIput3
	fEEi7z6XiWMwCl/sc0cQOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730793013; x=
	1730879413; bh=D6OCx3NzmrJdDDip+0qK9zMAnmCzPOYRXUxgWn1goh8=; b=T
	mIgENc4DC3vg8e58XWWAlPPC+Q7U8v+QD+8CkhsocjVLSpaYLyScnXsaJvL/UpC4
	L95Ypm2lS0Z2oouUPuqaDqyzqPuDLGR2z3NZ3pKEufaxwTJHtN8ECMQDfeL/RDd3
	pGJStNFqyClN3XXPusEMqlFK0G5lhVio+pbqdEknxlGTY3izaYuzVn97rGkXu7jV
	R+iV3jmz0/eG3SmWKj9eq4C+Z8+X5vRJPbLdNUgmL9lLWbNsUrumr9vrvpdcYB21
	K7rZ+DsFlk3B8gxBUW4NcN2uiFbRMN66bdaPtJCDDmGYt2pROLffs2sJTmN9NLLy
	Sd7MZZF3WDTFlipO8Wy7A==
X-ME-Sender: <xms:Nc4pZ-3ECSKEE8XxIjWFt8cD9jqV6Wg5RtiOLlu7NLclo59Z7EuWfw>
    <xme:Nc4pZxHjh50Tm9SE-eom3h44vf4JnHnQ0x0s2brwdU9iyZuQpGBELCMEFb8Sz159G
    cZi99rawlcp05-xq8I>
X-ME-Received: <xmr:Nc4pZ25M6TGHJzJasOsDM7YAoDrwhxU0M-8h8VHOVAawJrZX1qzzOTYvE8BHdf21tesvrSN6TzaVLkU5lEAwcNEcfD8J8uIn1Nk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeljedguddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddt
    jeenucfhrhhomheplfgrnhhnvgcuifhruhhnrghuuceojhesjhgrnhhnrghurdhnvghtqe
    enucggtffrrghtthgvrhhnpeevfeekuedutedtvdffvefhvedvkefhgfevheefhfffheef
    tefgteffuefgveefhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehjsehjrghnnhgruhdrnhgvthdpnhgspghrtghpthhtohepudegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegthhhrihhsthhophhhvgdrjhgrihhllhgvth
    esfigrnhgrughoohdrfhhrpdhrtghpthhtohepuggvvhhnuhhllhdojhdrjhgrnhhnrghu
    rdhnvghtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrshgrhhhisehlihhsthhsrd
    hlihhnuhigrdguvghvpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehl
    ihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqshhpih
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeguvghvihgtvghtrhgvvges
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlh
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmrghrtggrnhesmhgrrhgt
    rghnrdhsthdprhgtphhtthhopehsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:Nc4pZ_3KS_ljVMmTlx3iWxMco4k3hhmRZ_NyMqBy1Z2cCLZBwK9Jvw>
    <xmx:Nc4pZxGAJAFf6jqQo0MNohbbYF1WA22ckV8ur5ZbkxNT4uHdz9yn3w>
    <xmx:Nc4pZ49pLJaX10Rw7OTYV2qav_Wltpptfqkle33erLrAdYpE0OtDrQ>
    <xmx:Nc4pZ2n9MJzEklKJt5lkLPbGFqoFAcmtM4EWss9TldUKHy23GcdRHA>
    <xmx:Nc4pZ-dm3BU-dKHsi2K66keV3bFCqxzPVu6XA7UvxuqJoD0cGTlScUMZ>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Nov 2024 02:50:12 -0500 (EST)
Date: Tue, 5 Nov 2024 08:50:12 +0100
From: Janne Grunau <j@jannau.net>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>,
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v3 2/3] spi: apple: Add driver for Apple SPI controller
Message-ID: <20241105075012.GC923511@robin.jannau.net>
References: <20241101-asahi-spi-v3-0-3b411c5fb8e5@jannau.net>
 <20241101-asahi-spi-v3-2-3b411c5fb8e5@jannau.net>
 <ff82c5bf-c757-4496-83ac-c3b257ef476c@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ff82c5bf-c757-4496-83ac-c3b257ef476c@wanadoo.fr>

On Mon, Nov 04, 2024 at 08:16:25PM +0100, Christophe JAILLET wrote:
> Le 01/11/2024 à 20:26, Janne Grunau via B4 Relay a écrit :
> > From: Hector Martin <marcan-WKacp4m3WJJeoWH0uzbU5w@public.gmane.org>
> > 
> > This SPI controller is present in Apple SoCs such as the M1 (t8103) and
> > M1 Pro/Max (t600x). It is a relatively straightforward design with two
> > 16-entry FIFOs, arbitrary transfer sizes (up to 2**32 - 1) and fully
> > configurable word size up to 32 bits. It supports one hardware CS line
> > which can also be driven via the pinctrl/GPIO driver instead, if
> > desired. TX and RX can be independently enabled.
> > 
> > There are a surprising number of knobs for tweaking details of the
> > transfer, most of which we do not use right now. Hardware CS control
> > is available, but we haven't found a way to make it stay low across
> > multiple logical transfers, so we just use software CS control for now.
> > 
> > There is also a shared DMA offload coprocessor that can be used to handle
> > larger transfers without requiring an IRQ every 8-16 words, but that
> > feature depends on a bunch of scaffolding that isn't ready to be
> > upstreamed yet, so leave it for later.
> > 
> > The hardware shares some register bit definitions with spi-s3c24xx which
> > suggests it has a shared legacy with Samsung SoCs, but it is too
> > different to warrant sharing a driver.
> > 
> > Signed-off-by: Hector Martin <marcan-WKacp4m3WJJeoWH0uzbU5w@public.gmane.org>
> > Signed-off-by: Janne Grunau <j@jannau.net>
> > ---
> 
> Hi,
> 
> > diff --git a/drivers/spi/spi-apple.c b/drivers/spi/spi-apple.c
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..1a3f61501db56d0d7689cc3d6f987bf636130cdb
> > --- /dev/null
> > +++ b/drivers/spi/spi-apple.c
> > @@ -0,0 +1,531 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +//
> > +// Apple SoC SPI device driver
> > +//
> > +// Copyright The Asahi Linux Contributors
> > +//
> > +// Based on spi-sifive.c, Copyright 2018 SiFive, Inc.
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/bits.h>
> > +#include <linux/clk.h>
> > +#include <linux/module.h>
> 
> Move a few lines below to keep alphabetical order?

done

> > +#include <linux/interrupt.h>
> > +#include <linux/io.h>
> > +#include <linux/of.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/spi/spi.h>
> 
> ...
> 
> > +static int apple_spi_probe(struct platform_device *pdev)
> > +{
> > +	struct apple_spi *spi;
> > +	int ret, irq;
> > +	struct spi_controller *ctlr;
> > +
> > +	ctlr = devm_spi_alloc_master(&pdev->dev, sizeof(struct apple_spi));
> > +	if (!ctlr)
> > +		return -ENOMEM;
> > +
> > +	spi = spi_controller_get_devdata(ctlr);
> > +	init_completion(&spi->done);
> > +	platform_set_drvdata(pdev, ctlr);
> 
> Is it needed?
> There is no platform_get_drvdata()

no, it is not used anymore. It's a leftover from v1 which used
platform_get_drvdata() in apple_spi_remove() which is gone now.

thanks, I'll send a v4 shortly
Janne

