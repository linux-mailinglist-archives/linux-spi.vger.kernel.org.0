Return-Path: <linux-spi+bounces-8764-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F03E1AE7E5E
	for <lists+linux-spi@lfdr.de>; Wed, 25 Jun 2025 12:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67B157B0502
	for <lists+linux-spi@lfdr.de>; Wed, 25 Jun 2025 10:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134C529ACDD;
	Wed, 25 Jun 2025 10:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="aSO5IlNj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eKaE3kNN"
X-Original-To: linux-spi@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25CC239E75;
	Wed, 25 Jun 2025 10:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750845673; cv=none; b=qRcip1a5cRV1o9n+HacNbjLZXp1ovTG5+HriFK06Exi3stVlxjczn/Q+dfSYU4ukRhZkGDkq0I8Wy6qyUH7Q+c0LD8Z7d7zQvCOAQx+QTESTYfDwyHrgNJihz6+IFXca+FtFykayBLJsVfG9k3509FgNkr3QNh5aG8SjUIbKA4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750845673; c=relaxed/simple;
	bh=okf+uhv/zJ5RP4VyNn9+JcXWCFO9Ssru835UGwlg64I=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=PT2/6OmzHaRSAhvjdJ+iDXj+eq40Lap5aR4+/kHAEXGbnI6x72jkzwyFikrGITDIDegVEAGxJEp7t0EX0Y86vWz5lzWJO9hzzsvOj2gYI0h+BVVnEWPZ7+0LABVnHcutOPo4jmiFCubk28sNS9ZoRO0WJfrtApqFafXfOLXzHFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=aSO5IlNj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eKaE3kNN; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id ABEDC7A0033;
	Wed, 25 Jun 2025 06:01:09 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Wed, 25 Jun 2025 06:01:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1750845669;
	 x=1750932069; bh=EfvRO+VLg3uMgXOHdRqJ5eu4+EMuM3Jf+0bB1Ld8A/4=; b=
	aSO5IlNjFL/Xvlv9qEsBqBxGZ5d588t6Aw9UbV6KLH+3iZFUh47nom9d+qvjl1wM
	NVCzpr/Fgz+avB975g7UEjvJbr1QAVj7yAbQtiTbr+w9fTIToUpYuilnF+9nAaBA
	cxGfbDmeVAEymtlhcX3pA+Vp1/FqV5ac6jJNxoI3kL3F+EwhBJid25ojPbQESJbk
	mS4BUEH+qE/1XPQ8ZFlj4BtY3R7OHMTji7B2KItH7kn2t1CKnzhrbLvreBZNQuL9
	w1NgZQDlN1Y8L+P98WGBtOBgueCmxQpu+AFkIM/ihvzNLVWweqrps4gnCR+mnQ7M
	tWbpuH51L+nRDfcq6+bB5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1750845669; x=
	1750932069; bh=EfvRO+VLg3uMgXOHdRqJ5eu4+EMuM3Jf+0bB1Ld8A/4=; b=e
	KaE3kNN7HJIEic2k6+1G+GF7ePJP0nA/wonf850w3ykY+yDhtpw8XzOy85ddKHGN
	dRNBEF8LyT0T5ppzl9DnYIivWnXabW+dmG5Mo7yfFpUsDM9e7TCj3w9Bbh0yh0Ql
	KaeU3/nM8aSw31Vvk5IDCnOviPbg+EeYu6m+S8Mz2D+g9ETAoXm2m/95JzFLlNSZ
	+1lksCRxw8X5CckHAmtaZtdSwZ9ss6Fp0ZsWZw66v49OyR7YGkvUpp4kuTeMowDs
	Qfnux7FQFoGH1Jh6OGwpNDEh2F8w34htIdmlTkhQq04klFvOx/eiWZc9yE/JOfdk
	iFP0O4wap2QfVTEi3tUkA==
X-ME-Sender: <xms:5chbaFjfUD7_TUCLeMDpbNYagpx7O4d5Eplfh9DQvs6dtn3I71GoPA>
    <xme:5chbaKBELq7w4GfHsksQm6F2re8rNtyuZP0RoSg5U9wswKxH_CKby5Mca4AgpGMZG
    eKnOOSVLX8najO_cgU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvvdegkecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:5chbaFFQO7awfCCnnjw9iCd3Gcw0yCmXlgAjmFW579u_osew0f6aJA>
    <xmx:5chbaKRk-W492bLzwwrvLbkWVLAvc8DXnIbHHyCnI81cNazNZuswmg>
    <xmx:5chbaCz2Dox169bEa-9sajgmj7jwvO6gVRUi4MgobpMS8Qfrd_4ruw>
    <xmx:5chbaA71AK2aKmG56pTEbT2dczGklsfAR4mv0duP7W7bkFJ5XvCsrQ>
    <xmx:5chbaDt4N_OcTNTD9DXLvhC-vrZzFR55wrgZf0KKO6J6C9ZmgnT7AfZK>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0DD83700065; Wed, 25 Jun 2025 06:01:09 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T588a20d0ffbb3e40
Date: Wed, 25 Jun 2025 12:00:38 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "James Clark" <james.clark@linaro.org>, "Frank Li" <Frank.li@nxp.com>
Cc: "Vladimir Oltean" <olteanv@gmail.com>, "Mark Brown" <broonie@kernel.org>,
 "Vladimir Oltean" <vladimir.oltean@nxp.com>,
 "Larisa Grigore" <larisa.grigore@nxp.com>, "Christoph Hellwig" <hch@lst.de>,
 linux-spi@vger.kernel.org, imx@lists.linux.dev, linux-kernel@vger.kernel.org
Message-Id: <0f904f12-295c-48fe-96c7-c64c461cdbbd@app.fastmail.com>
In-Reply-To: <0c6c78da-575a-4d29-a79a-3903aa801b42@linaro.org>
References: <20250624-james-nxp-spi-dma-v3-0-e7d574f5f62c@linaro.org>
 <20250624-james-nxp-spi-dma-v3-3-e7d574f5f62c@linaro.org>
 <aFrSgJ5xZfccEX9x@lizhi-Precision-Tower-5810>
 <290fc244-e88f-47a3-8dd3-0ec27eb5c60b@app.fastmail.com>
 <0c6c78da-575a-4d29-a79a-3903aa801b42@linaro.org>
Subject: Re: [PATCH v3 3/6] spi: spi-fsl-dspi: Stub out DMA functions
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Jun 25, 2025, at 11:19, James Clark wrote:
> On 24/06/2025 6:16 pm, Arnd Bergmann wrote:
>> On Tue, Jun 24, 2025, at 18:29, Frank Li wrote:
>
>> It would also be simpler to enforce this in Kconfig if we only
>> care about users that use the DMA support.
>
> But most of the devices supported by the driver don't do any DMA. That 
> was the reason to stub them out rather than add the Kconfig depends.

Ah right. So even when running on SoCs that have a DMA engine,
you can end up not using it?

In this case you could have an extra Kconfig symbol to configure
DMA support for this driver and use that in the source code:

config SPI_FSL_DSPI_DMA
      bool "Use DMA engine for offloading Freescale DSPI transfers"
      depends on SPI_FSL_DSPI && DMA_ENGINE
      help
         ....


     Arnd

