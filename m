Return-Path: <linux-spi+bounces-8384-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 143DFAD1A48
	for <lists+linux-spi@lfdr.de>; Mon,  9 Jun 2025 11:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AB833A3EC6
	for <lists+linux-spi@lfdr.de>; Mon,  9 Jun 2025 09:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC795246769;
	Mon,  9 Jun 2025 09:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mqb8fdfU"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3FE1D5CF2;
	Mon,  9 Jun 2025 09:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749460052; cv=none; b=ng6PQgvKoy/6FcgmX0n7kqC6YA2ntKymGonTYzLfhJtSKAyjWbwG/EghDTQNbpHJx8xuTwqgPsy03+zuMgGDKtuy+yj2HoPj9BmEnPaGzhbX4XCsVGwX3b1ujBnjbrBXQygHCntCxuCmatr2oqg0oyK4ixneH8w36l/Y+8yq5ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749460052; c=relaxed/simple;
	bh=erCWTv1iBu+zhino5X8lqV0NnPCfncKslxTm/LttBO4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=b/AWWINMStwszDojSMLrwb6N2dn3zKnW6Bw0tiGq43HCnC0NOOLXDWNo0kXJDcwAuiTP1w2uzhgldSDEG81c1bC8w43opADlHEtai0F2mv/FFiLfez2mep6tJlQFZH6XzY7BYlevOQ8r4VWHoKGwqes4lN+7E//xU9CsNIBYXZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mqb8fdfU; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A8E3B4326B;
	Mon,  9 Jun 2025 09:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1749460048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=erCWTv1iBu+zhino5X8lqV0NnPCfncKslxTm/LttBO4=;
	b=mqb8fdfUAPmh1nGlznkXqcy65DTSqmBNVTK2jEWW+sZy/L4Mwn72e1BDiJ6cNad6U5dhco
	u2tGJQquy5bw3+kHVVdCbRKfHfSnzViq+cQDLYETVOvMuFONiHdKYsOexHM9Wtq5TlUA27
	Wq6EQAHizzOUgD/5vnR/JKaEAE9T6g0f+lVPjJLQmVUJ7c33S2FZ74WRNQJywTAYKrGQVk
	fSKxOTK0HsojuD7X2IAULVVy80JhHB4I6IhrxTD2EO/Jy5eiufVse+maoLpEn6h5EHezDB
	jnD8xN55kzjPhIwMon0UA42cRqfRK4brNShFTyzymTAVg6aNocx8YOUgeY/CTQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Alexey Charkov <alchark@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,  Rob Herring <robh@kernel.org>,
  Mark Brown <broonie@kernel.org>,  Krzysztof Kozlowski
 <krzk+dt@kernel.org>,  Conor Dooley <conor+dt@kernel.org>,  Tudor Ambarus
 <tudor.ambarus@linaro.org>,  Pratyush Yadav <pratyush@kernel.org>,
  Michael Walle <mwalle@kernel.org>,  Richard Weinberger <richard@nod.at>,
  Vignesh Raghavendra <vigneshr@ti.com>,  linux-spi@vger.kernel.org,
  devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-mtd@lists.infradead.org,  linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] dt-bindings: spi: Add VIA/WonderMedia serial flash
 controller
In-Reply-To: <CABjd4YxRMfi3ZFQxhB__6U4Rm3KQ7bm6J=wQLWAkpb++61ddEg@mail.gmail.com>
	(Alexey Charkov's message of "Fri, 6 Jun 2025 13:06:22 +0400")
References: <20250510-wmt-sflash-v1-0-02a1ac6adf12@gmail.com>
	<20250510-wmt-sflash-v1-1-02a1ac6adf12@gmail.com>
	<20250514204159.GA2988411-robh@kernel.org>
	<CABjd4Yz3w75PtkRk_edzD5yf6b2xPuf20gopbm8ygddgCBfpkw@mail.gmail.com>
	<2b520ae5-eb0d-40eb-ba73-cc18759f33b9@kernel.org>
	<CABjd4YxRMfi3ZFQxhB__6U4Rm3KQ7bm6J=wQLWAkpb++61ddEg@mail.gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Mon, 09 Jun 2025 11:07:27 +0200
Message-ID: <87y0u1z3jk.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdeltdelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeffgefhjedtfeeigeduudekudejkedtiefhleelueeiueevheekvdeludehiedvfeenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduiedprhgtphhtthhopegrlhgthhgrrhhksehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhriihksehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghrohhonhhivgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdpr
 hgtphhtthhopehtuhguohhrrdgrmhgsrghruhhssehlihhnrghrohdrohhrghdprhgtphhtthhopehprhgrthihuhhshheskhgvrhhnvghlrdhorhhg
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Alexey,

>> > Happy to reference the spi-controller.yaml binding if so.
>>
>> SPI NOR flashes are still child devices of an SPI controller. You can
>> look at other examples - aren't they all using spi-controller? Why this
>> would be different? Unless you found some cases that are different, but
>> then which ones?
>
> No strong opinions here, and no expectation of any special treatment
> :) Just wanted to consult on what's most appropriate.
>
> My (subjective and perhaps unfounded) expectation when seeing
> something advertise itself as an SPI controller was that it would be a
> general purpose SPI master, to which one can e.g. connect an SPI
> driven LCD screen and get it to work with generic Linux SPI
> infrastructure - which would not be possible with this single-purpose
> NOR-only flash controller. Given that I don't know how flexible or
> restrictive other examples are in terms of driving arbitrary SPI
> devices, I thought it's better to just ask.
>
> What I'm getting from this exchange here is that I'd better use the
> spi-controller binding and respective node names regardless of the
> fact that this controller cannot drive arbitrary SPI devices beyond
> NOR flash (which, as I'm getting, is irrelevant after all).

Just for information, there are several SPI controllers which are
optimized for flash handling (not only NOR, though) and for that we have
a spi-mem layer which allows to reference a set of SPI memory "only"
callbacks. On the description side though, these controllers are like
all other SPI controllers, so the same controller bindings may apply.

Thanks,
Miqu=C3=A8l

