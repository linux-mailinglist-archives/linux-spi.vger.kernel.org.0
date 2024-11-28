Return-Path: <linux-spi+bounces-5852-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E14289DB3CC
	for <lists+linux-spi@lfdr.de>; Thu, 28 Nov 2024 09:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93D3A163ABA
	for <lists+linux-spi@lfdr.de>; Thu, 28 Nov 2024 08:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C12149C7B;
	Thu, 28 Nov 2024 08:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="cD13hdQ1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vfuHfLkV"
X-Original-To: linux-spi@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4542A13D8B0;
	Thu, 28 Nov 2024 08:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732782709; cv=none; b=HLwU3QS9eSkmSzvyb0aLyH1Lolp+pL1TKP9xCskhAm/i1RAdAXwTlxvZQzF00RuhFC6fMCe8qrANdxr6YZMYgq2GRHZn8go89EmeLOBAirVgHjLJ5PtpdOtmBMCd4U8AYgHOZeQwLGesfAidpNUYelEJCc/6dnnNRGA9mlYQVvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732782709; c=relaxed/simple;
	bh=+82ww8HaL+JrXjaF2z2qRjmLSOWvJk5vnPXZcbKsfm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eG16Oe9TFs4u+Nq+AMhHrRWSZWweFQ245rcSRGnkMIYRM/WsS+Qv4gy+5B9loF+THBVs6jVFTKeBaDakIipBSrcaA18Drh4CEKskt6O/3c+chf9H2T35uAINWTlkVlDvyyLEOekx4a71qxbM1MuHDLHIyYx4j8UMemak0Nu38gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=cD13hdQ1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vfuHfLkV; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2C6822540134;
	Thu, 28 Nov 2024 03:31:46 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 28 Nov 2024 03:31:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1732782706; x=1732869106; bh=+WtRgwkoqR
	vksdBwrK+9C+XcfQ8pm5qxMtRwdKGqLCI=; b=cD13hdQ1XUG0xRZYw6rnafmsZb
	wVFv4wwJflBlc9vEDTsSSVc1Ar3Zqn5dTAGZIeev1ilMR6VZ9ffQ07ldvc2WwPb2
	eVDW0sXBHkM81jjoyQUc1jP6VQ9kQnQSUFl0eOX9+If3DgipElYdXHcTtgsP06rG
	fdjJI/e5h4s+xwJNNHF5P5xM2gyqvfQ1oW+TmBJD6Z7l29cJbMgr/f45T0Mj+4bD
	r7BMn7KRkVpS4tdOP7RnaF3Id42ieDAC+K1eft+3tMqnXJXrmWXHKM0lxu5ZcsxR
	VqLMaXHOm/UwaqJ1lOZEdlWnUCXmx4HSQJEZJIhtHMkXAp8jICm8Fnq3rO6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732782706; x=1732869106; bh=+WtRgwkoqRvksdBwrK+9C+XcfQ8pm5qxMtR
	wdKGqLCI=; b=vfuHfLkV7f86qQdkEzPEEi+3JL/OM1IQGjFe/eeyoJidcCwIlQq
	3p+TuMXhpmu4+yY+uaZwpzhzQ2MMbUKSroDcdjanlgbinwkXdxRf+WOW8X8Ld+kq
	gLMFmq/tDCNoFRcV6/8/PLuMmxWgd3XSVy0Q0ggiPK6HTKuv+7c2+tIlIpnQJ13l
	Y//6lvjJd/UbU/TkFwdEINRhe72zWAPyGvnSGs206fU2N9W3DqnwG3iSzZcwxdJ+
	p1S4OCoBKGUrQwuZ13Mvsu9GxQ3kZ8kYHrJtPd8ceOPvA0fbyxYP8P2T5FfPzGAN
	rAVHFjb9LzyRPmwEEkY4rD27y4bXM976e+g==
X-ME-Sender: <xms:cCpIZ0xVALxos2msEFwsnZKR_4dfpYeR00fawAv7uORAen1ZJ0MYQg>
    <xme:cCpIZ4S1zCqVW84msn6KX8Y1eDmtD9mZ3Gd5vsvQpzD_YmOl03BL0gWBWdm_uhD_f
    xH-xHcKdm_rTd7295Y>
X-ME-Received: <xmr:cCpIZ2U5TumEAhkXx8TB4q5aj3CDd3xPH-YiDRFGhP9hFE7A-ZkK5q5C3lFwVi4ZXhHNy-T1axJOpcfjWDCl99lplPnLq_wwVmo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrhedtgdduudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtjeen
    ucfhrhhomheplfgrnhhnvgcuifhruhhnrghuuceojhesjhgrnhhnrghurdhnvghtqeenuc
    ggtffrrghtthgvrhhnpefgvdffveelgedujeeffeehheekheelheefgfejffeftedugeet
    hfeuudefheefteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehjsehjrghnnhgruhdrnhgvthdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepfhhnkhhlrdhkvghrnhgvlhesghhmrghilhdrtghomh
    dprhgtphhtthhopegsrhhoohhnihgvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehm
    rghrtggrnhesmhgrrhgtrghnrdhsthdprhgtphhtthhopehsvhgvnhesshhvvghnphgvth
    gvrhdruggvvhdprhgtphhtthhopegrlhihshhsrgesrhhoshgvnhiifigvihhgrdhiohdp
    rhgtphhtthhopehlihhnuhigqdhsphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheprghsrghhiheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehl
    ihhnuhigqdgrrhhmqdhkvghrnhgvlheslhhishhtshdrihhnfhhrrgguvggrugdrohhrgh
    dprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:cCpIZyia3mF4fBMsfu8O1EF91KcPpuX4JaCfnWs2kefFcuXDT2fPaw>
    <xmx:cCpIZ2BXa7MsELBiMvDJMEk9eQCSMMqgegOWzHG9buNzpAk0PSLLOA>
    <xmx:cCpIZzIQmyI9nnK8WpJ1uZ_1Ed2uzHeNhK_Z85MCo1_nSNDvhobTtw>
    <xmx:cCpIZ9BiSMnh9AmdqF8S5WI40eShpkDtR5AbsIzqE7iMbReKlb0Xww>
    <xmx:cipIZ-uU7o1W9WbkfADtT7LHpJQh8yMR85QKSI1KWopOCFw3gbjeL3xY>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Nov 2024 03:31:44 -0500 (EST)
Date: Thu, 28 Nov 2024 09:31:42 +0100
From: Janne Grunau <j@jannau.net>
To: fnkl.kernel@gmail.com
Cc: Mark Brown <broonie@kernel.org>, Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, linux-spi@vger.kernel.org,
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: apple: Set use_gpio_descriptors to true
Message-ID: <20241128083142.GB3782493@robin.jannau.net>
References: <20241127-gpio-descs-v1-1-c586b518a7d5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241127-gpio-descs-v1-1-c586b518a7d5@gmail.com>

On Wed, Nov 27, 2024 at 11:18:29PM +0100, Sasha Finkelstein via B4 Relay wrote:
> From: Sasha Finkelstein <fnkl.kernel@gmail.com>
> 
> There is at least one peripheral that is attached to this
> controller and can not use native CS. Make it possible to use
> a GPIO instead.
> 
> Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
> ---
>  drivers/spi/spi-apple.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/spi/spi-apple.c b/drivers/spi/spi-apple.c
> index d4b126c8701a67083e7247d1c82fb56f1725d9cb..6273352a2b2861c9da0976a46ec2adbc4c71d3d2 100644
> --- a/drivers/spi/spi-apple.c
> +++ b/drivers/spi/spi-apple.c
> @@ -493,6 +493,7 @@ static int apple_spi_probe(struct platform_device *pdev)
>  	ctlr->prepare_message = apple_spi_prepare_message;
>  	ctlr->set_cs = apple_spi_set_cs;
>  	ctlr->transfer_one = apple_spi_transfer_one;
> +	ctlr->use_gpio_descriptors = true;
>  	ctlr->auto_runtime_pm = true;
>  
>  	pm_runtime_set_active(&pdev->dev);
> 

Reviewed-by: Janne Grunau <j@jannau.net>

Janne

