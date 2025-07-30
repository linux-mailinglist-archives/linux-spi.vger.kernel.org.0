Return-Path: <linux-spi+bounces-9220-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2014B15B47
	for <lists+linux-spi@lfdr.de>; Wed, 30 Jul 2025 11:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E05043B12FE
	for <lists+linux-spi@lfdr.de>; Wed, 30 Jul 2025 09:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5046126B2AD;
	Wed, 30 Jul 2025 09:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kEEee4le"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F1E1DF738;
	Wed, 30 Jul 2025 09:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753866841; cv=none; b=MdqJGPookNQx3zv1L7eU34lWvQ7WAYS73Wo10WOSE+MhbgbjomuosOvVjBWze6q0x6jTB0ihlMLjeNLLIHF4mXkwVsg/KXgcDbd71AlimkekzavsLPJappmNFPH9CyyvmAqGygC89k3ajU/RQikZiVqXOWi+/hfW7vbrtjgETto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753866841; c=relaxed/simple;
	bh=v5Gq+UU6lzNM72f0gFV01nFK80A3tFu70CZXtuMyWAk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PKGNnILRC2UloRrgqb7PwdAvgEbc9V4yhRIU4wRlliam1Zz2p08R9hGDpQTzMrnvfeUp+n+MSdmjGx09f9Gx9CfOrhY2hS97DgfK7jfw+nICpjbYXL7lzUzpRmiUv2URIcdERPhm1oSdNtD1V2hiO7pI75OZa4NasFZuCPr6CNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kEEee4le; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DBFCA43176;
	Wed, 30 Jul 2025 09:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1753866830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8j+HOjEuqgjt4NUWrWNaCZst/RjQqcT8RPfplsJswCc=;
	b=kEEee4leBC7lJw3lub0jiNnKM2ew0eiIj1TFbv3AQvcgjpRX39xF5r0xc8mST69AMFr1U4
	0HAzfNYxoxMRWL38ejUzlwyWS323col+nZHChT8CJOumLJH/zuK/mQV7g6cxa28c3DDPUv
	O26DBh8mcsY1Lmx7mGrInves6eBu5PJSr0+AptIY7qV1FjAVwkUowO4lyOPwyG8fdeA0Sw
	mzaysIS5YIiKdYsgN5poLzVvCe2gF7sJ9O82Go3uhbnOxAIw5B6iUXX8ztmPKa0TN+pmqx
	VbDznpl2yfrltj/KLkH4Wr89xpH5L1pEPp2dMnuRhCKChc+Frwo1WSbzk9eMMw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Yogesh S <yogeshs@ti.com>,  Santhosh Kumar K
 <s-k6@ti.com>,  Steam Lin <STLin2@winbond.com>,  Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,  linux-spi@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-mtd@lists.infradead.org
Subject: Re: [PATCH 0/8] Enhance Winbond SPI NAND support
In-Reply-To: <20250618-winbond-6-16-rc1-octal-phy-upstream-v1-0-513202126013@bootlin.com>
	(Miquel Raynal's message of "Wed, 18 Jun 2025 14:14:17 +0200")
References: <20250618-winbond-6-16-rc1-octal-phy-upstream-v1-0-513202126013@bootlin.com>
User-Agent: mu4e 1.12.7; emacs 30.1
Date: Wed, 30 Jul 2025 11:13:49 +0200
Message-ID: <87v7nam46q.fsf@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeljeehgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffgffkfggtgfgsehtqhertddtreejnecuhfhrohhmpefoihhquhgvlhcutfgrhihnrghluceomhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepleevteeiudefudfgjeevheevgfevgfdvheelfeekudettdffvefhgeejgefgkeeknecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedutddprhgtphhtthhopegsrhhoohhnihgvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrihgthhgrrhgusehnohgurdgrthdprhgtphhtthhopehvihhgnhgvshhhrhesthhirdgtohhmpdhrtghpthhtohephihoghgvshhhshesthhirdgtohhmpdhrtghpthhtohepshdqkheisehtihdrtghomhdprhgtphhtthhopefuvffnihhnvdesfihinhgso
 hhnugdrtghomhdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopehlihhnuhigqdhsphhisehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: miquel.raynal@bootlin.com

Hello,

On 18/06/2025 at 14:14:17 +02, Miquel Raynal <miquel.raynal@bootlin.com> wr=
ote:

> Both w25n**jw and w35n**jw chips have a "normal" and a "high speed"
> mode. In order to use the high speed modes, we need to configure
> internal registers and adapt the number of dummy cycles. The benefits
> are too interesting for not paying attention to this little extra
> configuration. In particular, it is an important building block for the
> introduction of PHY calibration on TI SPI controllers. With these
> changes combined, the frequency used on these chips can be bumped from
> ~25MHz up to 166MHz.
>
> This series was tested on TI AM62A SK with a W35N01JW and on Nuvoton
> MA35D with a W25N01JW. At low speeds, this series does not bring any
> improvement. However when enabling high speed modes (on TI's platform),
> the difference is outstanding:
>
> W35N*JW running in 1S-8S-8S @ 25MHz:
>
> 	 eraseblock read speed is 9552 KiB/s
> 	 page read speed is 9516 KiB/s
> 	 2 page read speed is 9552 KiB/s
>
> W35N*JW running in 1S-8S-8S @ 166MHz:
>
> 	eraseblock read speed is 35555 KiB/s
> 	page read speed is 33684 KiB/s
> 	2 page read speed is 35068 KiB/s
>
> Enabling high speeds currently requires applying extra patches from TI
> to enable PHY calibration. They are currently in the upstreaming process.
>
> Link: https://github.com/miquelraynal/linux/tree/winbond/6.16-rc1/octal-p=
hy
>
> In order to introduce all these variants and derive the quickest one, I
> had to improve a bit the helper deriving the time an ops would
> take. These changes can go through the spi tree, the other patches do
> not depend on them and the performance hit is rather acceptable without.
>
> While at adding maximum operation frequencies, I realized I got myself
> confused with the macro parameters due to some of them being
> optional (with variable arguments in macros). I decided it was too error
> prone so I propose to add these values on all READ_FROM_CACHE
> variants (where they are often relevant).
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
> Miquel Raynal (8):
>       spi: spi-mem: Use picoseconds for calculating the op durations
>       spi: spi-mem: Take into account the actual maximum frequency
>       mtd: spinand: Fix macro alignment
>       mtd: spinand: Add a frequency field to all READ_FROM_CACHE variants
>       mtd: spinand: Add a ->configure_chip() hook
>       mtd: spinand: winbond: Enable high-speed modes on w25n0xjw
>       mtd: spinand: winbond: Enable high-speed modes on w35n0xjw
>       mtd: spinand: winbond: Add comment about the maximum frequency

Series applied to nand/next after fixing conflicts due to some fixes.

Thanks,
Miqu=C3=A8l

