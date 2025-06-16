Return-Path: <linux-spi+bounces-8594-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 998ECADB28B
	for <lists+linux-spi@lfdr.de>; Mon, 16 Jun 2025 15:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 341273A6650
	for <lists+linux-spi@lfdr.de>; Mon, 16 Jun 2025 13:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825A52877CA;
	Mon, 16 Jun 2025 13:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Z4uIJC/a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SWV475mM"
X-Original-To: linux-spi@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DDE22097;
	Mon, 16 Jun 2025 13:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750081754; cv=none; b=gFY89z+fjpDNDMH2pg3UFCKT1cNVQ5WaqNyxvPhjOvNMJ/zyvAw4DlnwmzET9xCqwxg0lOpYy4hT17rq1Gl96mYIVKeJnhxiqhuVb04PC16y/ar8q3PvD4KGdDhwFcXjuSvVlPbtF3YMiJyejqtiE2+RKdVqZ6s/mxXiBi60c0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750081754; c=relaxed/simple;
	bh=lIoE9gcdwJ3ykhVZ65gPKl4QqyXImX16Y6imO4XoKpo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Yoc5cCUJwq6t05M7abjWfF9HD2/o6jk2JfM+SpF/Zn9mvhnXpwNXD6BbxpiACspV9T3FOzE9LHOIth/L4DSQexIncUYAtAsSvqszopc5AbkU2TsNdYDmwNWlbQLoyfMmUXiL1BBCbE6eNFUmAbNXRYRSYYVICZ/dauN5y0TG2b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Z4uIJC/a; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SWV475mM; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A7B9211402B7;
	Mon, 16 Jun 2025 09:49:11 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Mon, 16 Jun 2025 09:49:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1750081751;
	 x=1750168151; bh=8qsrTRHcvOAd2c9i2pGiJI5TDC5V+Z/Uoi8ty2RR4eU=; b=
	Z4uIJC/aCJl5TCM7IJcxdppiQeF9UinlgJ2FAyHxVkhcbrEisiiFz6bUlWGEeZXd
	/d5wIDHzl+uT+3Zn1PimRM7erbMWjE0B6lgEglmMpgNW8BJ/CrLM1wrixtFzEVmN
	kcUbY5GkddT9ORS9T5vTVBNefyf1Hm8cgrk5ClP8fXWtCkwghqO95Cc5kW+iCGzD
	taBqRXfX2aCqKTT4gmrm6ZaJOugD/3+yABMtAjV9GHv9PDH3nAbdhnDVnwOvCk1M
	1it0uzJGhC1lKG9AO5hF0CXdRZUbA6pw7zcdtsEqaKApoS0U+JAILj41qfCidCMe
	PKvPm2ujwVvhL71oKEM3Kw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1750081751; x=
	1750168151; bh=8qsrTRHcvOAd2c9i2pGiJI5TDC5V+Z/Uoi8ty2RR4eU=; b=S
	WV475mMLO7x4A5sZtbebmxvM8OcaNLnVCtokq8g6gTNSCzQBy4s025IKdGXzlnfc
	T7N0xGe8eeZpfQCa3gK1yt3CpZgatrJ+Y/VqbkpCn4BF/ZHybXzF0SiP3tm9j3zC
	9TYsF5kvNUfT4YDBhPxJsGkJ2qDt91JmaJ1FzBEH6yY6hN6a/YilWxajwkf7ONEC
	cKXnkQj2sqK5bjPm9qyRx7tTdrawXLK5kgcz5J9zsytUuN6C8eaNAKkzFtvbge+3
	7+YpUYa0T+fwb1mYR2yyK/0q2BBunr595MFRJPDqzGYJX4PiPzjkOTtY8hvfYOg6
	YdWcjeLIrBV/zATgtPzpg==
X-ME-Sender: <xms:1iBQaJovrZfMAJmFVtahyuzCOC3jdKDplIkMzJtu7T1-Vridmdy1CA>
    <xme:1iBQaLq8b-MxDM4GeGqxtFEGrppMWOXAax4vZH-AGalSjHJp3JJFDCtDSBYVGAhyP
    seZ43u0GUSxV_1ttno>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddvieejgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteef
    gffgvedugeduveelvdekhfdvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedu
    gedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhhosghinhdrmhhurhhphhihse
    grrhhmrdgtohhmpdhrtghpthhtohepohhlthgvrghnvhesghhmrghilhdrtghomhdprhgt
    phhtthhopehlkhhpsehinhhtvghlrdgtohhmpdhrtghpthhtohepsghrohhonhhivgeskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepjhgrmhgvshdrtghlrghrkheslhhinhgrrhho
    rdhorhhgpdhrtghpthhtohepihhmgieslhhishhtshdrlhhinhhugidruggvvhdprhgtph
    htthhopehiohhmmhhusehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepohgv
    qdhksghuihhlugdqrghllheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhope
    hhtghhsehlshhtrdguvg
X-ME-Proxy: <xmx:1iBQaGPP-njiVQWYcMzKqfN8lWKt9KF-S1wtG_wm6kPw_gxZUfGVFg>
    <xmx:1iBQaE6rRCeVI14O_0cd-8ltlcUvcT-2wBWXWvZmHREULi8sUN979w>
    <xmx:1iBQaI7IUDY9acNm7MIkvYwTI1PPa3BRqYfGOWPARWICCfoy8ytxkw>
    <xmx:1iBQaMiUYzyNEksn2mo2FifTqnPgZNYfQAh_z6slzGqt4lIDho2R7A>
    <xmx:1yBQaCJ-8dPrB2ejqDv-iCGGYbucZDq8lQpAyVmE_WAP8eNfUxFTF9Ap>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id CFC38700062; Mon, 16 Jun 2025 09:49:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T4808b90e09d8ad4f
Date: Mon, 16 Jun 2025 15:48:50 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "James Clark" <james.clark@linaro.org>, "Christoph Hellwig" <hch@lst.de>
Cc: "Mark Brown" <broonie@kernel.org>, "Vladimir Oltean" <olteanv@gmail.com>,
 oe-kbuild-all@lists.linux.dev, "Larisa Grigore" <larisa.grigore@nxp.com>,
 "Frank Li" <Frank.li@nxp.com>, linux-spi@vger.kernel.org,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org,
 "kernel test robot" <lkp@intel.com>,
 "Marek Szyprowski" <m.szyprowski@samsung.com>,
 "Robin Murphy" <robin.murphy@arm.com>, iommu@lists.linux.dev
Message-Id: <9788991a-ac37-4fde-81db-c55035d00f27@app.fastmail.com>
In-Reply-To: <f723d490-c228-42d5-9f9f-158df54a092d@linaro.org>
References: <20250616111749.316413-1-james.clark@linaro.org>
 <20250616112927.GA21689@lst.de>
 <5f1ca0ac-b66c-4b92-8f69-027c2468b117@sirena.org.uk>
 <20250616120832.GA24959@lst.de>
 <2d62254e-5cbe-4174-95d8-e80cae4f4543@sirena.org.uk>
 <20250616121444.GA25443@lst.de>
 <7cfcf919-3c7d-4f0c-911f-697ea3141080@linaro.org>
 <20250616131346.GB29838@lst.de>
 <83855c1a-c128-4762-9d6b-e17f2c4c8820@linaro.org>
 <d16bdc40-20d6-49db-bf41-18bb9b8e01fd@linaro.org>
 <20250616131944.GA30260@lst.de>
 <f723d490-c228-42d5-9f9f-158df54a092d@linaro.org>
Subject: Re: [PATCH] dma-mapping: Stub out dma_{alloc,free,map}_pages() API
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Jun 16, 2025, at 15:23, James Clark wrote:
> On 16/06/2025 2:19 pm, Christoph Hellwig wrote:
>> On Mon, Jun 16, 2025 at 02:15:56PM +0100, James Clark wrote:
>>>> Yes it does, it has a few modes that don't require it. Presumably we can't
>>>> just add a depends into the kconfig for all devices because they might not
>>>> be using DMA.
>>>
>>> *for all the different variants of spi-fsl-dpsi devices I mean
>> 
>> This is drivers/spi/spi-fsl-dspi.c?
>> 
>> Yes, looks like it is one of those rare devices supporting a DMA and
>> non-DMA mode.  But everything seems nicely guarded off using
>> "dspi->devtype_data->trans_mode == DSPI_DMA_MODE" checks there.  So
>> wrap them into a little helper using IS_ENABLED(CONFIG_HAS_DMA) and
>> everything should be sorted out.
>
> Sure, I don't mind doing it.
>
> But separately to that, I still think making the stubs consistent would 
> save people a lot of time diagnosing build failures if they switch 
> existing code to any of those 3 functions. Principle of Least 
> Astonishment and all that.

As far as I can tell, the difference here is that the
dma_alloc_coherent()/dma_free_coherent() calls all get stubbed
out, so the 827 drivers using those can all build cleanly on
mk68knommu, shnommu and UML, while dma_alloc_noncoherent()/
dma_free_noncoherent() are only used on 15 files that are all
guarded by some other Kconfig dependency at the moment and won't
build on the those platforms.

I agree that it would be best to treat the coherent/noncoherent
cases the same, and I also think the existing stubs are a bit
silly, but just removing them would likely require fixing
hundreds of drivers with added Kconfig or IS_ENABLED() checks.

Maybe we can actually remove CONFIG_NO_DMA/CONFIG_HAS_DMA
entirely and remove all the checks for CONFIG_HAS_DMA? 
My guess is that this would only lead to a small code size
increase on the affected targets, but since they are not
actually trying to do DMA, and they all have a very limited
set of drivers they actually use, it won't break existing
code.

    Arnd

