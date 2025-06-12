Return-Path: <linux-spi+bounces-8484-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9BBAD76C1
	for <lists+linux-spi@lfdr.de>; Thu, 12 Jun 2025 17:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 655AE18984AB
	for <lists+linux-spi@lfdr.de>; Thu, 12 Jun 2025 15:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD5526FDB6;
	Thu, 12 Jun 2025 15:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="4QeuTfF5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qvu9P7xE"
X-Original-To: linux-spi@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA0F1A265E;
	Thu, 12 Jun 2025 15:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749742856; cv=none; b=QjmhkHH9WNX2vRq+a3reoC8ixJrem2LCKBY121vE+WTWrFCFy4shFh4h3ACxZk7kR0RbWRVNrvVT4cT4BP5i5Pm5oRRhoTDuOuYcWYO83tV6glB5bqDSUTAA7Wd9aYvaSAecVTZSYMvMU+GyeYTjHp/ZtTac+9Ke0kNce8IysJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749742856; c=relaxed/simple;
	bh=id4ih60TuebeVY8xdlobeadCEqP8YfcnizOYCiHa1u0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=CDSxBuPMpnkTawTCeMsYaCix6Cx6dSpN9vd49cga0peZVDfbvs7M75gUw00c0UviIZCogwG7eOC+oPf2opI9KP6IjKPS61+gjZsBqrrOqZNyLVgVsRU51Z6sMhIRoAYhYCS5H6CiI36TW73d+8tEIi5S8Dic5npWpzLOr6WCPjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=4QeuTfF5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qvu9P7xE; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8384F1140250;
	Thu, 12 Jun 2025 11:40:54 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Thu, 12 Jun 2025 11:40:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1749742854;
	 x=1749829254; bh=sWelLnp2+cYiV77S4Yvo1Q6mYaqOKiPfdOyUWSK8nrk=; b=
	4QeuTfF5PcInrQBsM34KSDk2CeLuGSu2AIA5rYUy+wrTcXmhhvKu5ctBRJ6PJV6k
	J/a0ymN6VytkungiF+5mwf6I97I8LVCXYQ1fYHIcLOksONNi+dSj19yBUZ+KEzmN
	dZHD1YUcO0kGi/Sxi449AOVJk+r5lbHUYsvFYviyJHE26ZzGbB7LLACLiUK+CLlQ
	eyHREgOoBHWhJ+ZOstwsP2aoZ8RfqOyKG7B7vYpX6RqvILpluJ4DsBNDeAvZeEj4
	wix3WLwt6L0HOq8ntu/7p4vNP0m4opTocN+laKqpuG34D+pHo2FvyCUM74BUSw8R
	9NPh59rl/hn3cGn9JtlpUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749742854; x=
	1749829254; bh=sWelLnp2+cYiV77S4Yvo1Q6mYaqOKiPfdOyUWSK8nrk=; b=Q
	vu9P7xE0es4tN65mYdM2nVsmcOOXCKQ+rX4bT02kV1HFMLYfb4pNKvQkoD02qlVp
	El9ihjx46fB/X/MEQmDVrQUkqqG9+AwjkcbZOBfFrC+GGTtzfvNi+LYeMlO0scyp
	XAstAhZ0x3FRzCo6VuzxStn0dt+QAsLCYfSaolfyg1LZTZQAr2d6rP9q0XhIUUAu
	CDCEYZJM8InFaqGrtzQynWkNPrthDAeZXEXI396GBXOWRC3rciG5q7Rj1PGr/7Sn
	zorydElm7bbd+RhqyRv6CkaaisCLWeLEONOlS2MK0cFAelR5d4TzHocB8E0aYhZC
	5SdXpbQaY9P+SJGIP1Ujg==
X-ME-Sender: <xms:BvVKaO4sczhyK7B8_T1rKSioG-PMJreKeelislgf2dbmvEWfze2I-w>
    <xme:BvVKaH4RxposRIUuwLQg7RMjyb3SfICpCr4AjnPMHX2QAwkAuHONW8PcSPAoefUsC
    -OlKpAazzWMqlBSk7I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduheeghecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteef
    gffgvedugeduveelvdekhfdvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopeek
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeholhhtvggrnhhvsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepsghrohhonhhivgeskhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepjhgrmhgvshdrtghlrghrkheslhhinhgrrhhordhorhhgpdhrtghpthhtohepihhmgi
    eslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehfrhgrnhhkrdhlihesnhig
    phdrtghomhdprhgtphhtthhopehvlhgrughimhhirhdrohhlthgvrghnsehngihprdgtoh
    hmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheplhhinhhugidqshhpihesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:BvVKaNf-lDV226O4SxCItt11pByKUOXkXVxwpMakcaqssbnnX9DV6g>
    <xmx:BvVKaLIXfVITFPBjbJ4aDbf5jti0-uDXCt1asfxJ06HYMd0SuSqJvg>
    <xmx:BvVKaCLH6PJ0SSkRDpV6BfUUGguMkrNHBMVd4Ywr0yK40EJOoMskKg>
    <xmx:BvVKaMzxQyBts5JxAz1C9MIDV6_bVLXqDTPtsWAf0-39s-3lsubdhA>
    <xmx:BvVKaNyeL7nRYyg0pQ0kawOd1LbaMh6GRmW7-lG890m_c_NGdIvjjKaB>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3D9A8700062; Thu, 12 Jun 2025 11:40:54 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T7ec8a5524929d219
Date: Thu, 12 Jun 2025 17:40:33 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "James Clark" <james.clark@linaro.org>,
 "Vladimir Oltean" <vladimir.oltean@nxp.com>
Cc: "Frank Li" <Frank.li@nxp.com>, "Vladimir Oltean" <olteanv@gmail.com>,
 "Mark Brown" <broonie@kernel.org>, linux-spi@vger.kernel.org,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org
Message-Id: <b9ae3ee9-1296-4a0d-b6e2-97aaf551482c@app.fastmail.com>
In-Reply-To: <ad7e9aa7-74a3-449d-8ed9-cb270fd5c718@linaro.org>
References: <20250609-james-nxp-spi-dma-v1-0-2b831e714be2@linaro.org>
 <20250609-james-nxp-spi-dma-v1-2-2b831e714be2@linaro.org>
 <aEhMBsqlx9I4XqJS@lizhi-Precision-Tower-5810>
 <de7142ac-f1a3-412f-9f00-502222b20165@app.fastmail.com>
 <aEhVsrEk0qv+38r3@lizhi-Precision-Tower-5810>
 <20250611090107.t35zatn47vetnvse@skbuf>
 <c65c752a-5b60-4f30-8d51-9a903ddd55a6@linaro.org>
 <20250612111514.rfb3gpmlilznrfxs@skbuf>
 <ad7e9aa7-74a3-449d-8ed9-cb270fd5c718@linaro.org>
Subject: Re: [PATCH 2/4] spi: spi-fsl-dspi: Use non-coherent memory for DMA
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Jun 12, 2025, at 16:14, James Clark wrote:
> On 12/06/2025 12:15 pm, Vladimir Oltean wrote:
> This leads me to realise a mistake in my original figures. My head was 
> stuck in target mode where we use DMA so I forgot to force DMA in host 
> mode to run the performance tests. The previous figures were all XSPI 
> mode and the small difference in performance could have been just down 
> to the layout of the code changing?
>
> Changing it to DMA mode gives figures that make much more sense:
>
> Coherent (4096 byte transfers): 6534 kbps
> Non-coherent:                   7347 kbps
>
> Coherent (16 byte transfers):    447 kbps
> Non-coherent:                    448 kbps

Ok, good. The improvement from the patch is less than I had hoped
for, but it does sound like at least it doesn't get worse for
small transfers.

     Arnd

