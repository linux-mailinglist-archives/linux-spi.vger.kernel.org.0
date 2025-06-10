Return-Path: <linux-spi+bounces-8431-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0744AD3DDF
	for <lists+linux-spi@lfdr.de>; Tue, 10 Jun 2025 17:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E58F31888332
	for <lists+linux-spi@lfdr.de>; Tue, 10 Jun 2025 15:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2110C2367C3;
	Tue, 10 Jun 2025 15:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="nfo7s0PC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MtHlk1cv"
X-Original-To: linux-spi@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882A8235354;
	Tue, 10 Jun 2025 15:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749570543; cv=none; b=Me7ZqfzV+YFslFG0s2AvUdITUTboCgANLZOar34M7bYfdeOsvAMt9l3CoAOb1VfbJcRTJfQ5/dJowPv/zRjPsuNmlvCs4yxFFn9ybEGpIMr2CYhLiPJMqKdX+UnmhKfE3gp8q2ZcglF0sDDe0Zzs53PzZIcj/AIMawxvg5qi2kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749570543; c=relaxed/simple;
	bh=CF9pirNlJKKWScnB4iiSz1km2xm1OOfVg1OY6MAlK2g=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ubpyqRvL127xpDZNfTqF3xHFU710X38aVg7HxVVTGlblePf96mHwH6Bl3U7Pen7WQRMzhbClPBaZL+uhhrEcX9mrye5FrkIU3BqINWIMlmob7RoyRKTWa5b9tcIlBvPCmUyCS0IiRRa51TLVPZQGCTJLjTN4Hpli6nxE88n0wU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=nfo7s0PC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MtHlk1cv; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A664F1140138;
	Tue, 10 Jun 2025 11:49:00 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Tue, 10 Jun 2025 11:49:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1749570540;
	 x=1749656940; bh=qhJ9rARWvXH6b5vxwlzrrjHa4TjKQAJ9KOsyecEZi9E=; b=
	nfo7s0PC49ZuvoHue2elR1gN/qUizRRv4/TanVsoMDbmQzZuuJtdze6W49VVIKsv
	ffjp4PjFwaFrRMKm+0IkgsT2RF5Jf6WhYuXRwFWg8z27ALbtpTcLCOGCb6YqzUPO
	bMJ9dG/DM5zRg7Ks/YzbsQ8uLp8rv+F90DfzLhdj9hnhg/OtKlA3Dafho8wwNo/V
	DRRtOJB0qKfFs31OL1arC9ChQhQzDE9hGWM2cYm9i17Ftt61AM5xGwKB5lsCZABd
	4hV2oZfQ3gVyWXgqpysyXE0DGIN7B6x3dxrvk6K/s9LG5wLgYill/GiNZqiL15zc
	PAv2vD/+r0WSszR5QRtcsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749570540; x=
	1749656940; bh=qhJ9rARWvXH6b5vxwlzrrjHa4TjKQAJ9KOsyecEZi9E=; b=M
	tHlk1cv3uHHa7tzhq9qZNaeOGsv0m3F5ek6RcNRS8OTlWVT7G03rkMDF/EO9x0WV
	g0TdHvJiWl36NK0SIpl+2yeG4LyM978stB/C6CSReNr5yYWnVtwCxVGBd4xskHW6
	ZU/kwcWjGAOvrqvZAeN9k3iMV6h2dySTx0DSx4eBlRuVaYlqfGXG1SMdbobLembn
	vzotDckXCSSylaJv0Cx4p4K5ndDS3dOUwJyAj1CVSall/+fjkFM8e98cfAwfjBWL
	LCZuUye1vfTbfNHEA7Y9Ht+QGtx+i+f096RwzPzoq01yrUi8uQQRWhztNjiRHk3B
	9dj6OBFf1bA/CbxkoYAzQ==
X-ME-Sender: <xms:7FNIaOHmiIFc-0Wuv2T1zFxgTWE3Rz0prZabT7hv5y_LhFll7iKURg>
    <xme:7FNIaPWPGmSSNGNpmvTVgAiSSnSwNihmwhMOYjgbVoSTYCzr2AIWydqOy-FUr_pYL
    L-j0Lfz08lmOTMUxwg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddutdelgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteef
    gffgvedugeduveelvdekhfdvieenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopeek
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeholhhtvggrnhhvsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepsghrohhonhhivgeskhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepjhgrmhgvshdrtghlrghrkheslhhinhgrrhhordhorhhgpdhrtghpthhtohepihhmgi
    eslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehfrhgrnhhkrdhlihesnhig
    phdrtghomhdprhgtphhtthhopehvlhgrughimhhirhdrohhlthgvrghnsehngihprdgtoh
    hmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheplhhinhhugidqshhpihesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:7FNIaILB4Z-8DwwtSD2OhuQlPMfNz-w2_MJdKTjR6akamWZ6M8mzqQ>
    <xmx:7FNIaIGctUtbNIXeFHjIcC82ILcjDwVEUXOilZrHDguuXuFrOu9bAQ>
    <xmx:7FNIaEVNH8jjMQjI0ilB-7LT84YJs4SWUuIWGbAdQ0fdDRwiN1HqdA>
    <xmx:7FNIaLOAQue49TFOnnQn7ToPemc5EAcW47ipu0h86tbl70leKFDtrQ>
    <xmx:7FNIaPP2yl9vHD5X6Lul_tdRoUhkhSJ_5_dFn5f6dqjeageOmTYtm_1g>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6AE6D700061; Tue, 10 Jun 2025 11:49:00 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T7ec8a5524929d219
Date: Tue, 10 Jun 2025 17:48:40 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Frank Li" <Frank.li@nxp.com>, "James Clark" <james.clark@linaro.org>
Cc: "Vladimir Oltean" <olteanv@gmail.com>, "Mark Brown" <broonie@kernel.org>,
 "Vladimir Oltean" <vladimir.oltean@nxp.com>, linux-spi@vger.kernel.org,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org
Message-Id: <de7142ac-f1a3-412f-9f00-502222b20165@app.fastmail.com>
In-Reply-To: <aEhMBsqlx9I4XqJS@lizhi-Precision-Tower-5810>
References: <20250609-james-nxp-spi-dma-v1-0-2b831e714be2@linaro.org>
 <20250609-james-nxp-spi-dma-v1-2-2b831e714be2@linaro.org>
 <aEhMBsqlx9I4XqJS@lizhi-Precision-Tower-5810>
Subject: Re: [PATCH 2/4] spi: spi-fsl-dspi: Use non-coherent memory for DMA
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Jun 10, 2025, at 17:15, Frank Li wrote:
> On Mon, Jun 09, 2025 at 04:32:39PM +0100, James Clark wrote:
>> Using coherent memory here isn't functionally necessary.
>> Because the
>> change to use non-coherent memory isn't overly complex and only a few
>> synchronization points are required, we might as well do it while fixing
>> up some other DMA issues.
>
> Any beanfit by use on-coherent memory here?

The driver copies data in and out of a coherent buffer by default. This is
fine if the buffer is only a few bytes in size, but for large transfers
this is quite slow because this bypasses the cache for any DMA master
that is marked as not "dma-coherent" in devicetree.

Patch 3/4 changes the size from a few bytes to many pages of memory,
so it's access the buffer in cache first and manually maintain
coherency.

     Arnd

