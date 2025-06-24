Return-Path: <linux-spi+bounces-8745-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F1DAE6D65
	for <lists+linux-spi@lfdr.de>; Tue, 24 Jun 2025 19:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF1E93B3E7C
	for <lists+linux-spi@lfdr.de>; Tue, 24 Jun 2025 17:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E067B2E3B16;
	Tue, 24 Jun 2025 17:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="J/vRH/+B";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Obj2wfVK"
X-Original-To: linux-spi@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843E629E11A;
	Tue, 24 Jun 2025 17:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750785388; cv=none; b=InmasqXGIFRn8AvhfEqkkpN8UcmHuf4FPAdhHDwcKzE/UW/3PL3sOioqzgcdgsGo73pjfDJmGJfw8X9KfrSz2hoAdFAx1mhsLYUwsXH7cJw4hb0/IwBSuIvZ05Dffzmc2i4g6K4zlAfNSodfE9lau0e6o52c9s6oAjODksBJH7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750785388; c=relaxed/simple;
	bh=Rjqlr72DkilY+EySouYneYmVIUMYqgPm965OFc1l1Ro=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=QqorSmhdJOZjxR4vPbCTFdX5EjD+qFpBv1BpzJzxpN3a1WGaaBwUDpdf/DWrJUwtLts/SIMDJElwgxne8s14JZ+OIxS6k/z1Elxx+MBC0dK67f+cVbsX7fozbBtgMu0Um6A0urEpNPvmphDWJKCX1Re3q8QM6YT5gVQFsWDvVeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=J/vRH/+B; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Obj2wfVK; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6F60E7A007E;
	Tue, 24 Jun 2025 13:16:25 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Tue, 24 Jun 2025 13:16:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1750785385;
	 x=1750871785; bh=fctDsDMWHBR/t5waMvZ9RXnK1n58vAkyAk91dxqNlRI=; b=
	J/vRH/+B8R02a+FvhcVUMNBKlgaeL5+P9Xk2PSTSvXq2ibL8165LyWTrAj55L604
	erpe0O4BqzRL0GclKDU623GFgdtDZAMtNnV2N2YKYl/zgOg5XtFEb6BhDOtEmbu1
	8pkdCFnCpiEXFWH+2eHzYyQhso2Lmj1p/0g6LZitcoH3c3hvBg+E5fjZ3TE2RE8C
	whKJ/78y7lQWpPFqjS0TS/V7F9ZfhB49ekSWvlNIayDy3QR5ErzQNe7K7QOrztOo
	y7zl9zQ+MyjJZFIKhHodSQGC2FiQj/+CpTvusT0zNn9knmFmGUp/f19ii6FxZvIz
	Ity3zz6XLtE/Hao34Zge7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1750785385; x=
	1750871785; bh=fctDsDMWHBR/t5waMvZ9RXnK1n58vAkyAk91dxqNlRI=; b=O
	bj2wfVKUmfYRuVVsYtFm1ikgl1DbcvQ2OvqySPl1qRHrTf3dgd3KeiXzE6sj665a
	KxN0gM46dQPZcGZYlAvKEH6/4UH3A1/mK4owct21w/mh0DScuiA6ZeZ7B5rF23Cq
	6KHW+KrW/dSh8LsUGtgfXe9ADN8ty8Q/BUGz4ntLhP8uw8fktD75ubEuX8evUElz
	m6a5g3WBx54Icbr2CKXHpb7M+qOyPinCqDSvoMwDVtnkiw+hAFGJzCxIKnB+QR4o
	xRkgIeQ1W/wtGctOfj+xP5d4vq14VaEh2C7EmuREarsP+Yh2L/VP/2xxQ0D7QkPJ
	iMBIdV91kCeMd2gtt0HRw==
X-ME-Sender: <xms:aN1aaKF-va6G3DxzgjEzE95S7xDTEuGvyZ1OunDS8txdPT01f0D1GQ>
    <xme:aN1aaLWs1Ui1kAyMmK7TAbJ6i83_Gq_CbI3Ael58AOZ8EdY9HgRxvbIUryjoBRF-c
    8GSQF30QfoVT3ntD0g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvtdegiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdvieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepohhlthgvrghnvhesghhmrghilhdrtghomhdprhgtphhtthhopegsrh
    hoohhnihgvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjrghmvghsrdgtlhgrrhhk
    sehlihhnrghrohdrohhrghdprhgtphhtthhopehimhigsehlihhsthhsrdhlihhnuhigrd
    guvghvpdhrtghpthhtohephhgthheslhhsthdruggvpdhrtghpthhtohepfhhrrghnkhdr
    lhhisehngihprdgtohhmpdhrtghpthhtoheplhgrrhhishgrrdhgrhhighhorhgvsehngi
    hprdgtohhmpdhrtghpthhtohepvhhlrgguihhmihhrrdholhhtvggrnhesnhigphdrtgho
    mhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:aN1aaEJ_YSCskkwPh85OvNsuU4L1V4fXX-wBhoNc72LdkR2Ebu5bfw>
    <xmx:aN1aaEHnkzPmCJrrqgv5VgPtvZCsS6jWraLvZke1fJiW8COaZH7O5g>
    <xmx:aN1aaAWh7aHfPn6hBdw23I634XZkdbbfnSlw5gDjuMgnxwm9SptVAg>
    <xmx:aN1aaHOpWrikzgBx6W-q4KTd8cdbJefcL1caipgAhObjUFgjPuw4-Q>
    <xmx:ad1aaCgMcdFbG-8fjZ1iAQJGCtUh-6AdBbj6_EYekY8R3fWjFTrewGbX>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id CD1C1700068; Tue, 24 Jun 2025 13:16:24 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T588a20d0ffbb3e40
Date: Tue, 24 Jun 2025 19:16:04 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Frank Li" <Frank.li@nxp.com>, "James Clark" <james.clark@linaro.org>
Cc: "Vladimir Oltean" <olteanv@gmail.com>, "Mark Brown" <broonie@kernel.org>,
 "Vladimir Oltean" <vladimir.oltean@nxp.com>,
 "Larisa Grigore" <larisa.grigore@nxp.com>, "Christoph Hellwig" <hch@lst.de>,
 linux-spi@vger.kernel.org, imx@lists.linux.dev, linux-kernel@vger.kernel.org
Message-Id: <290fc244-e88f-47a3-8dd3-0ec27eb5c60b@app.fastmail.com>
In-Reply-To: <aFrSgJ5xZfccEX9x@lizhi-Precision-Tower-5810>
References: <20250624-james-nxp-spi-dma-v3-0-e7d574f5f62c@linaro.org>
 <20250624-james-nxp-spi-dma-v3-3-e7d574f5f62c@linaro.org>
 <aFrSgJ5xZfccEX9x@lizhi-Precision-Tower-5810>
Subject: Re: [PATCH v3 3/6] spi: spi-fsl-dspi: Stub out DMA functions
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Jun 24, 2025, at 18:29, Frank Li wrote:
> On Tue, Jun 24, 2025 at 11:35:33AM +0100, James Clark wrote:
>> This will allow the build to succeed with !CONFIG_HAS_DMA, either due to
>> a randconfig build test or when the target only uses one of the non-DMA
>
> I supposed you met kbuild error. If yes, can you add kbuild build report
> tags.

Actually I would suggest making it a dependency on CONFIG_DMA_ENGINE
instead of CONFIG_HAS_DMA, since that is the more relevant symbol.

It would also be simpler to enforce this in Kconfig if we only
care about users that use the DMA support. 

      Arnd

