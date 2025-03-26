Return-Path: <linux-spi+bounces-7335-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE844A720F6
	for <lists+linux-spi@lfdr.de>; Wed, 26 Mar 2025 22:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 412BF188E58B
	for <lists+linux-spi@lfdr.de>; Wed, 26 Mar 2025 21:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4623D2AD02;
	Wed, 26 Mar 2025 21:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Nvlx3ZLj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UChe62aA"
X-Original-To: linux-spi@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20814217730;
	Wed, 26 Mar 2025 21:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743025581; cv=none; b=nPgDRF9TokEmHdaJjc+kO2fCr4GkCipI3SDzfq7ryVzeaSDfL6x15qyCUtXQfmgOCULPWMvcNcW3y1gTAz31hm9BI+bxJjfMF59ZXY7QNN5z0qFZVoBEeRwGV7qwmgYCqvZuaTE+kwZB2pGoLAtaJi35K5SJe/gwzEqolvgKx1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743025581; c=relaxed/simple;
	bh=u9R36/IsROu8bruoDQpXpqnhu//PolX8vPGtOhlbB9s=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ttrtEPfjgHmOvnQ5KnS5WCI6KmPIdv6dKHknMbng+BjBjVuEZjyIcuwg9uoUEzogqUWv11c3nF2R9F1Y+NrwZYTNcFDC8A/G81aJq9God0KvKpk7UpPrMv+fCjzmayWQ46V05rDK0CqB/J8aDMgnSXWWT1F05o9zLMh2Baow1Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Nvlx3ZLj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UChe62aA; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3FE3D1140156;
	Wed, 26 Mar 2025 17:46:18 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-07.internal (MEProxy); Wed, 26 Mar 2025 17:46:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1743025578;
	 x=1743111978; bh=9+8vkdLD5edBgu/Z6+0yI7pGtpzrZlbFrLN5LN5tBnU=; b=
	Nvlx3ZLjFTvblohn50tYZTmgLmcilzCDC/u7zuXQCwVzAQ6ClR1TcDXwegnt0QSg
	pa8SgUUUdmvRmPEMOjD54SCv6aOiILY2/fh74XgjKO/oDX0xjuEtkZacMnhHLqxt
	FIcDAXl1ui4BqEHudSO4ElA2+DktqrhgbKQidP3e6f8vuevwCNQFs4+GYHSWa7m/
	tjynPambIeV0whmVd7e0jJ2PD9V2MBX4YHfzXBp70yOQUvHXiDRM5MDH3tkduPNL
	4fd8vbQme4BdNTvI0y3GLFg/sLpjb/jCgQA9+XBdpQsdpEUDTh+eb/8HDHmKIdy3
	SzZx5ESnKeqH5O2LtDqEsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743025578; x=
	1743111978; bh=9+8vkdLD5edBgu/Z6+0yI7pGtpzrZlbFrLN5LN5tBnU=; b=U
	Che62aAMjPI9B+5C6jr53khkrnFNqD7Db/DZasnQzOkDVMla0hiwo3Ip0Y3Gcqqv
	Wha3DSf4ZzIJUAfAAL4GXZIeuM9D8vVf+1L4stDg4iFTIdpCSFcl/A4jjoXH8+y2
	yp8t5WII/qVlL2yDrIlf5p0Ayhxri6MmzGjYtkaLVsvLBRb933nK9CC2EwjJi7Tf
	UIE7MP1oPPtzFLREpQH4VF0l47wn6Wx+mAlbGBc0yPuGX46DVr+GCFn9M16qZ6OU
	/56by01VUINvLTpL8BxZXyjBldvorrcK+t+Va+wBwy9WEcwMdGDaVA6/UwJO4q2X
	+OqkRo0dSONHu686AnapA==
X-ME-Sender: <xms:qXXkZ01Y7gUoJK_ZW0qbwJAGzxOBGL6LDzQHe4vCfPCZ8eDo_fhwnA>
    <xme:qXXkZ_Hiwh5jhQXfFuURl3oFPIBJv1-wWpwnyTIIKXTl_hS5Way6_brzbTD7zZAQD
    6dSfKxk6c7gt_pCHZo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieeiieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnug
    gsrdguvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeet
    fefggfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohep
    hedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsghrohhonhhivgeskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepghhrrghnthdrlhhikhgvlhihsehsvggtrhgvthhlrggs
    rdgtrgdprhgtphhtthhopehpthgvshgrrhhikhesshhushgvrdgtohhmpdhrtghpthhtoh
    eplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheplhhinhhugidqshhpihesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:qXXkZ85-a1wQZtPFTAHAhnOYIdDuxyLbIEt1bGM47Navssz0yaTarQ>
    <xmx:qXXkZ919fbw2MCa8wprph6htnqfQ9_Q1UzIulXk-7sWQVrY4j0cuZA>
    <xmx:qXXkZ3HpguqUsxOgR_LEdn9FF1Ijj02P_CZHdSMzRP2yPqY_p8JpJQ>
    <xmx:qXXkZ2-Hiyq-Yn9sGkFTVMAi5PJzwMLKafeSkX0n0fsBTIShhN1UuA>
    <xmx:qnXkZ7gUraxPEjKrJNbXdUMQLjrHeAcsiHJkp-Pwe_kXb9ADTJbwuphi>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id BC4852220072; Wed, 26 Mar 2025 17:46:17 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T6af0c8f44e761c09
Date: Wed, 26 Mar 2025 22:45:57 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Mark Brown" <broonie@kernel.org>
Cc: "Petr Tesarik" <ptesarik@suse.com>,
 "Grant Likely" <grant.likely@secretlab.ca>, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org
Message-Id: <92817727-d0f2-4d91-8fef-84ee92ab42e7@app.fastmail.com>
In-Reply-To: <8ff02f5a-fa66-4403-b193-a18c23879e0d@sirena.org.uk>
References: <20130205142128.2E28D3E1265@localhost>
 <20250320124330.480d652d@mordecai.tesarici.cz>
 <ca70e24d-57b6-4250-bd0d-7f5c72e1d282@sirena.org.uk>
 <b37480a4-5344-4cf4-8fd1-400e2588fc28@app.fastmail.com>
 <db36bbf0-0ad5-4c37-bfcc-917508805eba@sirena.org.uk>
 <efe910db-77d0-4ddf-8fc2-df4955e7b9f3@app.fastmail.com>
 <06435855-531b-4a3b-9f2e-1a5caea0d65b@sirena.org.uk>
 <38fe54d2-bd8a-4655-863d-cd1c482ac9a8@app.fastmail.com>
 <Z917hRQM2ZhSwvFx@finisterre.sirena.org.uk>
 <6a3a4b10-f51b-43e2-8281-057f6751424b@app.fastmail.com>
 <8ff02f5a-fa66-4403-b193-a18c23879e0d@sirena.org.uk>
Subject: Re: [PATCH] spi: Ensure memory used for spi_write_then_read() is DMA safe
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Mar 26, 2025, at 17:20, Mark Brown wrote:
> On Fri, Mar 21, 2025 at 08:42:12PM +0100, Arnd Bergmann wrote:
>> Using dma_alloc_noncoherent() should make the implementation
>> much nicer than GFP_DMA in the past, so we could add a bus
>> specific helper for SPI that checks if the controller actually
>> wants to do DMA and whether the buffer is problematic at all,
>> and then decides to either allocate a bounce buffer and
>> fill the sg table with the correct DMA address, map the
>> existing buffer, or pass it without mapping depending on
>> what the device needs.
>
> That query feels a lot like spi_optimize_message().  Which should
> possibly then just do the bouncing if it's needed.

Would that require attaching the temporary buffer to the message
or could that be a permanent bounce buffer?

The idea I had come up with was to have one or two pages
permanently allocated in the spi_controller, the spi_device
or the regmap and then use appropriate serialization to
ensure only one transfer uses it at a time, similar to
how spi_controller->dummy_tx gets allocated, or how
spi_write_then_read() uses its small global buffer.

The advantage of using a permanent buffer is that it
avoids both the kmalloc and the iommu mapping in the fast
path and only needs to do the dma_sync_single_()
for cache management, which should be faster for small
transfers.

The downside would be a higher memory usage and the
need for a mutex.

      Arnd

