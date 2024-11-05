Return-Path: <linux-spi+bounces-5617-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E45209BC731
	for <lists+linux-spi@lfdr.de>; Tue,  5 Nov 2024 08:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DA1EB21BCC
	for <lists+linux-spi@lfdr.de>; Tue,  5 Nov 2024 07:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCF81FE102;
	Tue,  5 Nov 2024 07:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="QWjcdGJW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CYKTbZJa"
X-Original-To: linux-spi@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515B02AF0B;
	Tue,  5 Nov 2024 07:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730792702; cv=none; b=tdSZcTQQ3/TEy6fwl+c2h8CnCY5xRJzFYcatvaLf/UCKmi8u30y8T+PWo1KH5YUfX+9A2hr9D9pExk7QY9I60UrtrzossFWanoPueGLQBrZT9voTvsOLgrGweHx5Vl885HT+asvnVpgwXzwDxuDJ4DKbxoJ1idy6PaXQWI80Z8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730792702; c=relaxed/simple;
	bh=miGbvf+/sqU0lRhQWVytjVytsWBjDMOz4kDCmq/yZCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H9J9iR4rUCtfvfei3afGgmxbWh1cUinH04IohCJlkPxbxBDvpYMhi0wjvLpm3Tm9ciI2kun4QerfhSfx04gRpUliJwPCGG0tOUUBNq6SKz/GNvkc0lLBAE0UA8UyzsdBUnHfzdTsgCBnd2tkhLGCaJ2DNrYSlW/CkkjTcxIVXDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=QWjcdGJW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CYKTbZJa; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 5CD6913802C1;
	Tue,  5 Nov 2024 02:44:59 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 05 Nov 2024 02:44:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1730792699; x=1730879099; bh=Ym7SjV/dcJ
	IjkJNBKLo9FclTtu+qxw9/1pp0hE1zJ/0=; b=QWjcdGJWR3sw5TQS86oG5vnUDb
	AbrlWa9Dj1I52K1momGP0qnUnz5QBIp/R7RJMkgXUGqwzrdaWo/KCyAP3gGivOIT
	7iTVlY1jYBqRQGTTwIDhdo6JgBpyAjSG/kw7H8mKtvxdoH/IxnbS1CafV/51HfQ/
	wmyye/HV8QJ7Lnnf7GLY+TXaP+6SOyQxFYixmfjob+TZ4HCPAZXiQ9IoMP1OrKJ/
	ZOPCmFN3C07/ZUGeEdtetimLFzUF7KJbsfmsRkYHDPLyrE/aHX5GfZxuNMnbaFyC
	6x2xEXdDYKnY6EvGzN0AemYSxCeaygnAfyzvO/p6I1EIVBOHVj/HE2Pj3f7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730792699; x=1730879099; bh=Ym7SjV/dcJIjkJNBKLo9FclTtu+qxw9/1pp
	0hE1zJ/0=; b=CYKTbZJaYJSl3jIzLRQ2OkGryMyNZEDPXMtJsDxzFjZNrSL2aW1
	XzAYkGgF2i63sLgBjYYPv0hZCwULacFWB59t415OLzF3cwvnpy+Nrs5T4byuVWv5
	BnIeGuyWQOLHmMGW3FBCmd1wCX4bPrW4/1vnXU2ExH5hekZsb/sFEsDiGDs88UUt
	Xy7xDb/xTpKSOWTVsfPLRKR2qEq6E2B57kDZLhti8B3TG7sJafJkYeVFZW8eUcno
	kggUhiMh+HOPc5jSD9VGjOMh11dhITtEQfwQXQ+ueqK/BGJbcv5/TZo6KDlLg9MA
	vuBjj6s68atpeiG9unY9rsYdT2VO1V9blxg==
X-ME-Sender: <xms:-cwpZ3wnCXyyr0lismuD8R6pXFOm3DrdmR4g3mcEsYrXT269jWtbwQ>
    <xme:-cwpZ_RTpT92to-LTJkXGFG29enfWR4MC8elbgbz0lP82stG_Vk0rR60GxHjcjxuC
    9sV4fKlPXQWT9RE7Sw>
X-ME-Received: <xmr:-cwpZxVPIpd0lC2-hIr36Pem1OjmZOxHZZW_-osf83gPsKF4LSp-z3pSJkDSeFu5u-YxziHQucORPECYitCIbSOIV9tdzcAoCpw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeljedgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttdej
    necuhfhrohhmpeflrghnnhgvucfirhhunhgruhcuoehjsehjrghnnhgruhdrnhgvtheqne
    cuggftrfgrthhtvghrnhepgfduueffleefkeegueektdehkeejtedtffdtudejhfdvheet
    gfeigfeltdeufeejnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjsehjrghnnhgruhdrnhgv
    thdpnhgspghrtghpthhtohepudefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hkrhiikheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrrhgtrghnsehmrghrtggr
    nhdrshhtpdhrtghpthhtohepshhvvghnsehsvhgvnhhpvghtvghrrdguvghvpdhrtghpth
    htoheprghlhihsshgrsehrohhsvghniiifvghighdrihhopdhrtghpthhtohepsghrohho
    nhhivgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghsrghhiheslh
    hishhtshdrlhhinhhugidruggvvh
X-ME-Proxy: <xmx:-cwpZxj2545d2OzQOOOUm1nZrHGqKOdUqUx2V-2KvLycigdo2M64bA>
    <xmx:-cwpZ5AcQSoMG4KKssg82ubxwnXY8srKjgRrqrQIKm1tqODhCmZcBw>
    <xmx:-cwpZ6IlCTOSJXlUDnBNXoxahGKUggkCuUuNfpX-0UZa7yHAPvzVog>
    <xmx:-cwpZ4AjqpLsJfHtxa2rItJ0sz2ddGV50LhWJPSeu4HPiq0vaEHBiw>
    <xmx:-8wpZxyVsuz5RqA6v3Yo3gXt_V7f7Q6Ph83nKqvveNkJq14M50Gq1dU4>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Nov 2024 02:44:57 -0500 (EST)
Date: Tue, 5 Nov 2024 08:44:55 +0100
From: Janne Grunau <j@jannau.net>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] Apple SPI controller driver
Message-ID: <20241105074455.GA923511@robin.jannau.net>
References: <20241101-asahi-spi-v3-0-3b411c5fb8e5@jannau.net>
 <vzulq4ewdbrk7qdurtypxpaoe4jsswddfprtdbudoxipf6d3ya@4gnbmr722pig>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <vzulq4ewdbrk7qdurtypxpaoe4jsswddfprtdbudoxipf6d3ya@4gnbmr722pig>

On Sat, Nov 02, 2024 at 02:11:51PM +0100, Krzysztof Kozlowski wrote:
> On Fri, Nov 01, 2024 at 08:26:11PM +0100, Janne Grunau wrote:
> > Hi all,
> > 
> > This updated series address the review comments from the original
> > submission in 2021 [1]. It adds a new SPI controller driver for Apple
> > SoCs and is based on spi-sifive. It has been tested with the generic
> > jedec,spi-nor support and with a downstream driver for an Apple specific
> > HID over SPI transport.
> > 
> > As usual, I'm splitting off the MAINTAINERS and DT binding changes.
> > We would rather merge the MAINTAINERS change through the Asahi-SoC
> > tree to avoid merge conflicts as things trickle upstream, since
> > we have other submissions touching that section of the file.
> > 
> > The DT binding change can go via the SPI tree or via ours, but it's
> > easier if we merge it, as then we can make the DT changes to
> > instantiate it without worrying about DT validation failures depending
> > on merge order.
> > 
> > This is mostly Hector's work with a few minor changes to address review
> > comments from me.
> > 
> > [1] https://lore.kernel.org/linux-spi/20211212034726.26306-1-marcan@marcan.st/
> > 
> > v2:
> > - removed '#address-cells' and '#size-cells' from the bindings and added
> >   Rob's Rb:
> 
> Where?

Apparently only in my mind. fixed for v4

thanks,
Janne

