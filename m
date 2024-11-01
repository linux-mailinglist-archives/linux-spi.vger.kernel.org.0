Return-Path: <linux-spi+bounces-5587-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 040E59B951E
	for <lists+linux-spi@lfdr.de>; Fri,  1 Nov 2024 17:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6D5D2836AD
	for <lists+linux-spi@lfdr.de>; Fri,  1 Nov 2024 16:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A874D1A2C06;
	Fri,  1 Nov 2024 16:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="o7vpaOIO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RELjwy81"
X-Original-To: linux-spi@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBD51798C;
	Fri,  1 Nov 2024 16:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730477952; cv=none; b=bM2XmzLi7z9gQ9MZRFhp9p3yjup9Y3RiYbCqz3q/rLKSYrfDG9rqmq3jRwBzF0RuaitUUVykFVJyH6h8JNVxJi8Eukf351P9fIjl09wjvAP6ctPEYYqvySo72xq7PyABoo8zCmlZ00v/AGikEuYWEKF2UC5ZJq6ppdkkLEWtHrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730477952; c=relaxed/simple;
	bh=AKa2W0mpcQm+sAU/4P3gnENB8BRaZp1V1lnxvdVW4Js=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kZ69smGChCU9Mh+G7hBiXsRxfJAahk0knf27kXS6sb14qNW2jUswEJS2sh6FKLlFNtUt0X2axGSDk69Z5/L/FW22iGr9q3dCTOzzuy3p7GAsaRHb+vUIytXg/h64C191Yf36kme+ydd0mfdmk4U0BLEwNRklFZEHfcBLsEb9uD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=o7vpaOIO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RELjwy81; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 30E2B1140168;
	Fri,  1 Nov 2024 12:19:08 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 01 Nov 2024 12:19:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1730477948; x=1730564348; bh=GNHBMWzMD0
	NkocAqxwRh+MsZa3vWvxzvM3VdrJFfGM8=; b=o7vpaOIOMhBTDnnIBq4DTTS3TD
	mcTjIFbaCJEqHFrDXQgMFh1Kd9i3S18ndp02te6drKJjpfxGb2HlcMZtWnkJ5CHY
	MdDCQbM8MGrbkRs8JlELheLdFTY3RtaxP8ZWM+Th/ZO/Z3GRbxKR5bPlRBk7beLL
	2x1mZwUMNNXsUrmh/tcaPeG7vpSIQLkE4/ncMXnbdPdWMsntvDvHyKMbHaQkrcdL
	irTgt4ANrlJuYNcocoUtHZB/1eL+tGRTS/O4GVtcQz/mII0LbQ+/WUN33twm7llN
	LzR1e5m2/t6oq6Yw5LCCr+32mbMRA9rBc+6GyhCKLG764AdIwyRe58lUbARQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730477948; x=1730564348; bh=GNHBMWzMD0NkocAqxwRh+MsZa3vWvxzvM3V
	drJFfGM8=; b=RELjwy8121HB4CAmI/ikAW784AJyek7dbq6QmgxImiVB5Ghj3Lr
	h440rCbcwHnNnMGYTDcrzg4f4+8QZw0LGmFmJUFta6Co201DJVXrXqUQ9lg1OtyN
	PbQCfQ5gt+ajjQp2+ft4zVcIclb0HTTzgsXuf4oPatxqWEmYpaiALd5r2zLkYFwi
	Il0NfLjzrThh/K9pMjINt0v5lsVpRO5LYqZPebouABKnFZsyHozRMI+TF28PWYXx
	1p+Fbk3fQHbnFlqodaV2cKflUM1tolAWaZNN5nVqjngJR0gjSvTdBHZeu+U/tzQL
	ijUm3mD5mX0fWCRM+JyQxw3MPEljYtcadwg==
X-ME-Sender: <xms:e_8kZ8QprNSabMxxUFBd1mej28P07D3DYighSP-WUrVM6ZQzwy-ggw>
    <xme:e_8kZ5z8efst3Z5klllVV3zbueWAFRYUxAkbJj6fpdhIhTg6JPSKfYYsnpLq3PTgA
    glVtm-sYp2nsjVIvDc>
X-ME-Received: <xmr:e_8kZ50OFcvBsBwTWnV3fXB7iY_CgLNSz4M3DKokepl1TnDAbnhpYr2lxEVwrLktuvEipQ6xwxWZOHak8ctOQImirbRzTwxWST0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekledgkeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtjeen
    ucfhrhhomheplfgrnhhnvgcuifhruhhnrghuuceojhesjhgrnhhnrghurdhnvghtqeenuc
    ggtffrrghtthgvrhhnpefgudeuffelfeekgeeukedtheekjeettdfftddujefhvdehtefg
    iefgledtueefjeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhesjhgrnhhnrghurdhnvght
    pdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsg
    hrohhonhhivgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrrhgtrghnsehmrghr
    tggrnhdrshhtpdhrtghpthhtohepshhvvghnsehsvhgvnhhpvghtvghrrdguvghvpdhrtg
    hpthhtoheprghlhihsshgrsehrohhsvghniiifvghighdrihhopdhrtghpthhtoheprhho
    sghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlh
    drohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghp
    thhtoheprghsrghhiheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehlih
    hnuhigqdgrrhhmqdhkvghrnhgvlheslhhishhtshdrihhnfhhrrgguvggrugdrohhrgh
X-ME-Proxy: <xmx:e_8kZwCzt0aws-_lwbhVUfa6KB1UiP_CRfzPP0vBfYKP7dXnJBOe6g>
    <xmx:e_8kZ1j7TGefpKR_BbVS2p5Bc1dkR6PFYEpogrJDiHymD4RbdGAKAg>
    <xmx:e_8kZ8qwnquqlBZ21pLj2iAb5m5BH68sQkghrs4I8vHZNWiFrxVXsg>
    <xmx:e_8kZ4hTPD5nHLRGQ16g22C4ZdzMT3b98fG92fFs58TOm1o1hmiBIg>
    <xmx:fP8kZ-ZFRMagDDBxQVcs4uxML9aDGlKW1K-V7ozF0gcFTD8CSPuzOUV4>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Nov 2024 12:19:06 -0400 (EDT)
Date: Fri, 1 Nov 2024 17:19:05 +0100
From: Janne Grunau <j@jannau.net>
To: Mark Brown <broonie@kernel.org>
Cc: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] spi: apple: Add driver for Apple SPI controller
Message-ID: <20241101161905.GB194146@robin.jannau.net>
References: <20241101-asahi-spi-v2-0-763a8a84d834@jannau.net>
 <20241101-asahi-spi-v2-2-763a8a84d834@jannau.net>
 <e3008c6b-ba71-46cf-810b-053dbafe2cfb@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e3008c6b-ba71-46cf-810b-053dbafe2cfb@sirena.org.uk>

On Fri, Nov 01, 2024 at 04:08:20PM +0000, Mark Brown wrote:
> On Fri, Nov 01, 2024 at 03:25:04PM +0100, Janne Grunau via B4 Relay wrote:
> 
> > transfer, most of which we do not use right now. Hardware CS control
> > is available, but we haven't found a way to make it stay low across
> > multiple logical transfers, so we just use software CS control for now.
> 
> It is extremely common for hardware CS control to not support multiple
> transfers, I wouldn't be surprised if it's simply not possible.  We
> could potentially use it with compatible messages it seems dubious that
> it'd be worth the time/effort of checking and using it only some of the
> time.
> 
> > +++ b/drivers/spi/spi-apple.c
> > @@ -0,0 +1,531 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Apple SoC SPI device driver
> > + *
> 
> Please make the entire comment block a C++ one so things look more
> intentional.

I did after your the same comment in v1 but reverted that since
checkpatch.pl complained. See

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/scripts/checkpatch.pl?id=a674fefd1732#n3742

The inconsistency between *.h and *.c is surprising. I'll change it and
ignore checkpatch.pl for v3. I'll address the other comemnts as well.

Thanks,
Janne

