Return-Path: <linux-spi+bounces-5589-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8354B9B959D
	for <lists+linux-spi@lfdr.de>; Fri,  1 Nov 2024 17:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42AD128281B
	for <lists+linux-spi@lfdr.de>; Fri,  1 Nov 2024 16:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588DF1C876F;
	Fri,  1 Nov 2024 16:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="xMkhhGSh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oGFgaypw"
X-Original-To: linux-spi@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243781B4F2D;
	Fri,  1 Nov 2024 16:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730479187; cv=none; b=Jk9K5jCi5HypyCLo69ZNMIm++wt9LxMpuI2kAHEyGJJQivWDUaFqy5g/xUaZOX4gfVZR2cQkFvU3KVyqNXe9LyxkzdhgL6jJZw+TsVDMx/Tz98yroVnx+ZO7ZlmKXbFI+6ghF/tvosqrF1X3/4mOZFOQbSJmufiiFXbMYhR2BFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730479187; c=relaxed/simple;
	bh=6ZksvsPC7Vy3hSkS0uKVoumo3Pe1bbuPY9/Q0qJFJVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p6JqlRKetOgby6sD6Uj/mNBbS2cZDLZ153F+0jWlLU6vwqwH+Y/XnYJlJ1P7oHsQ0LaS5xyasMze/a+SI03IxxX/SZ5wsf29ojQOGilhseT0sVpQSvdg1MTvRLijQA8f5HuVLqLF7hgKQjMDSh+PA0pQcUcS+D+BLlwR4bbNl3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=xMkhhGSh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oGFgaypw; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 31A6F1140186;
	Fri,  1 Nov 2024 12:39:44 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Fri, 01 Nov 2024 12:39:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1730479184; x=1730565584; bh=JYVPEmwAUm
	doUxoWOzZktGM/4ECkeYtdHMXZnU62Ywg=; b=xMkhhGShkcvD81kye7d2wlEQ1K
	Pfp0tN5EylGJ/IH8N9YFBuhx9QkzZywWeHJOF7JxupDu3XcDstkD70olgYjkiDbW
	RJ4RcQlWqid0BthqNfUscRtUaQOEvlaIv+lyOGZB794ZqdGq4FLFj3iUigi27W/u
	X/K13wghn1xg8JAGFgOhTY+MUkOzfFCy7dKryRwv9FMoXb5gyv1Vog2TiurA4xUu
	DEcFZ2x0c9ZCauVQc6qyIozENf7PlygJX6y2g6gepYOOGGPualoibnco2ym+WsTn
	OL4EQG/pk1w2FfA4lz6GAWgOXfN1t8Q7B+TGo34199Icdnzeltq7Oi4rVr7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730479184; x=1730565584; bh=JYVPEmwAUmdoUxoWOzZktGM/4ECkeYtdHMX
	ZnU62Ywg=; b=oGFgaypwLSA/5OLbFe59kL9Wt/EFwbaVDOpD8RLF/LjPg65Gglg
	xj+bbNOJQE0+Oh5fk4mRS1NZvfqe81CAkEtZMiOW8GmiVLMKGu6y+LMMLOEo2StK
	QCxzoXzj3F+RYImvmCzM0CfyRR2v4Zh3Yg7PjbQklnuVbOVihTmx3vcL7toom0mJ
	7FB118uFEPyXws2DrMYSICL+kRjQrbd9bDxKqcqFzhKwiUWqhhFEwKDW0DJMdKiy
	1Mxmm84dgWrhvIcD+XSjtssWH8hsl7MqYsBI51p2NgDJ4ShBzy9oT84dlXBSqBGF
	x3CMUDFWMe2kB2yf4tLVzY1Hauht6Ox7PPQ==
X-ME-Sender: <xms:TwQlZw5UmeQpcZkHFla9X91K-8GmX6gcu8xEx-yq-j0kWXw8htN5ag>
    <xme:TwQlZx56q_8b4kmR4bA2R4fahT06zxMwKM-TGi9U7_1OO8_hcDTAw3pYQncvws64u
    w4NT-9-6-u7MfKcjpI>
X-ME-Received: <xmr:TwQlZ_dKwnqMHd8FClb7qRW45QTiK2wAVGoEl8Jhn28ZqhAzkhGdRjcABqA3M_5gL_DTDaYzl_QmA161TVQr9epPJz3mVscrGX4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekledgledtucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:TwQlZ1JBq2YiYm_DIN5t3eZZF5iwFNr1zSjLotPxL5MJws2qrWo0ng>
    <xmx:TwQlZ0JAdiOnfujS6omcPe4Jgg93Pdw7F7IbE7J0zfHzXftWIDXhGQ>
    <xmx:TwQlZ2xE01BvdFRJpksiS6W98PDFMb91iDYhwld5pLMZEwAplza3DQ>
    <xmx:TwQlZ4K7mmfbVPaOrA22-zK4YRHHas8N2DMoD4YDC95zDYRBeAHuuQ>
    <xmx:UAQlZ2CgVOHKN-RMwnKFnts-G4dAMh-iwHNS-QqBl3IdrKTtAhpBbrqH>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Nov 2024 12:39:43 -0400 (EDT)
Date: Fri, 1 Nov 2024 17:39:42 +0100
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
Message-ID: <20241101163942.GC194146@robin.jannau.net>
References: <20241101-asahi-spi-v2-0-763a8a84d834@jannau.net>
 <20241101-asahi-spi-v2-2-763a8a84d834@jannau.net>
 <e3008c6b-ba71-46cf-810b-053dbafe2cfb@sirena.org.uk>
 <20241101161905.GB194146@robin.jannau.net>
 <0b4901b4-8cb7-49e2-a411-a6c57b9edd97@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0b4901b4-8cb7-49e2-a411-a6c57b9edd97@sirena.org.uk>

On Fri, Nov 01, 2024 at 04:27:32PM +0000, Mark Brown wrote:
> On Fri, Nov 01, 2024 at 05:19:05PM +0100, Janne Grunau wrote:
> > On Fri, Nov 01, 2024 at 04:08:20PM +0000, Mark Brown wrote:
> > > On Fri, Nov 01, 2024 at 03:25:04PM +0100, Janne Grunau via B4 Relay wrote:
> 
> > > > +++ b/drivers/spi/spi-apple.c
> > > > @@ -0,0 +1,531 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/*
> > > > + * Apple SoC SPI device driver
> 
> > > Please make the entire comment block a C++ one so things look more
> > > intentional.
> 
> > I did after your the same comment in v1 but reverted that since
> > checkpatch.pl complained. See
> 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/scripts/checkpatch.pl?id=a674fefd1732#n3742
> 
> > The inconsistency between *.h and *.c is surprising. I'll change it and
> > ignore checkpatch.pl for v3. I'll address the other comemnts as well.
> 
> Did you make the comment block a C++ one or a C one?  The SPDX header
> does need to be a C++ comment (//) for the SPDX parsers so I'm saying
> make everything else also use //.  There's some constraints from tools
> that consume C headers but don't support the C++ syntax.

err, yes. parsing error on my part. Will change the whole comment to a
C++ style comment.

Janne

