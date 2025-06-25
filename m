Return-Path: <linux-spi+bounces-8768-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3C3AE805A
	for <lists+linux-spi@lfdr.de>; Wed, 25 Jun 2025 12:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8822F4A59AE
	for <lists+linux-spi@lfdr.de>; Wed, 25 Jun 2025 10:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038702C0313;
	Wed, 25 Jun 2025 10:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="IviJ/koI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hmBVKdb2"
X-Original-To: linux-spi@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C9B2BEFF9;
	Wed, 25 Jun 2025 10:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750848865; cv=none; b=hABnj6qhK1Mf77NLTDo8l0MNlkPjojHqstNvDa6I55SR6obIbyUylw3IKgVJt53R/G19zMhrES0W9PEOfhRWsQjyk2fN6DZ8xPoBjR9heOIfnIys3SJjfqBM42NW3z8nIaCjEYw4aJg+ukkfhIYZFWXyESsn+meJ426iw8+cLXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750848865; c=relaxed/simple;
	bh=QrX85Qk8+fEb6NVTU9wtJF8ZOywbTwF2zcUmByN2bvc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=qw7lu2FV4ub1jINJnQ4H2aPpe3P4T2uWiO4/uCHtyXJLY5Hd4NVqj6Z6vFcxqcuW+gwISVDpHKjJ06s//DXvaWYuF2Sm5jGVvog7zuxQpmyzfc/V1+RYwy0s9WYhxA6qWh/5eUCWMttwa2OnrLpg4RQqu5BmnzhLDEkVHSFcHGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=IviJ/koI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hmBVKdb2; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 182227A0178;
	Wed, 25 Jun 2025 06:54:23 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Wed, 25 Jun 2025 06:54:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1750848862;
	 x=1750935262; bh=Q5dyaO3jSBoJfpd1LXwtd5ZZDDPtXRhCCAifrLMtgYI=; b=
	IviJ/koIrcB8hPHAZrglLq1oI90x4D5pgi6phAXBeDVtKK4ntPx+cM27UyZX70Jh
	zKL+yH0ZaZHTOxkvU61I7BcvL/f70FgUlQlQjS5lXvdbzzsquI1MAsCcyDFpUptO
	+6tbMsm3P1ePCGMTJt8TyPIJ0DvD/2hO4PSpdOxXUgDYOKLTsHAUKPAbZUbdfMfv
	nm5nuiUHaGea76co97MAxu5l4vdztm5YiuTVEpQnTnYER0NxDIMqWwCMJg88Dkux
	udr+KUyZJBaiRkSdB3kMz+iTSVf5KMFmi4w2p+OZ+cE6Q8e/+JHJ2MzzCI9aq2rr
	UYBmY647rUjCctUCUnNqzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1750848862; x=
	1750935262; bh=Q5dyaO3jSBoJfpd1LXwtd5ZZDDPtXRhCCAifrLMtgYI=; b=h
	mBVKdb2EGEVl9P/hu6cVlskdKonc6kBTr5iO+fl8VkDuEodtZYpy9fCVOAttkFkl
	wf/pz1qRzXkwf+9iya+Dn8dbcKZIlR5l8jq6erDs+JUDz1eZdDECqJxwfI5QnlJf
	Z/+GYeJHTqo0UlMMOY+5Oj9HNwyXKwzyKbKz6BLKG2Y2PdaHmSOsxPPmZyeNVeXR
	sJiLpiWwRa1FWtaxVOQWHOy4TGsPidrL40fJXLBO38HX99q8B3xuFX04f4Y/yhhl
	ei8296LW/2mJUgII2fH0xwnCAlqz5GfQtl7SHIY/p2y7RWCH9YnVh5Vh78ADZuV6
	3Juz57yTaCp5AwU0nIQ2g==
X-ME-Sender: <xms:XtVbaGsW2vsBl-CUeudkQbooqUKrAFFLaMMa0worurSJ3RALyS1DYQ>
    <xme:XtVbaLfJmeiJG2rchMmRHWnbPCTc7RGWwZA8_rDCIgmOCDKBnM6OlkuG7b1IY13sL
    gf6DPhuFKlefMUdUKQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvvdehlecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:XtVbaBylydIhWBMIDzwS7NgF-ok3CrK0h5mJKkOcCq9Oa2KV84lAyw>
    <xmx:XtVbaBPh5ayWHdjhaHdE_Cc0X2eu7Nq7J4CoSekFy51qfAbo9k4yGg>
    <xmx:XtVbaG-r31mxLpOHBCCFm-LasbaMmwUxqw3zZsgNXLCQLW3k8WXtgQ>
    <xmx:XtVbaJVUfAVFcPntLalkbFh5NZLavbapYMMLOV4jGMF-1e1RjwaXHg>
    <xmx:XtVbaBp2SfdOSv5Okgh2WLL6JrNgVhTc_-YwW38zyk9lZkV4RH4gDfo3>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A2792700063; Wed, 25 Jun 2025 06:54:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T588a20d0ffbb3e40
Date: Wed, 25 Jun 2025 12:54:02 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "James Clark" <james.clark@linaro.org>, "Frank Li" <Frank.li@nxp.com>
Cc: "Vladimir Oltean" <olteanv@gmail.com>, "Mark Brown" <broonie@kernel.org>,
 "Vladimir Oltean" <vladimir.oltean@nxp.com>,
 "Larisa Grigore" <larisa.grigore@nxp.com>, "Christoph Hellwig" <hch@lst.de>,
 linux-spi@vger.kernel.org, imx@lists.linux.dev, linux-kernel@vger.kernel.org
Message-Id: <82824032-26d4-42a6-8a92-3e4a410741c5@app.fastmail.com>
In-Reply-To: <884e86be-112b-44dd-a827-30355a5fdba6@linaro.org>
References: <20250624-james-nxp-spi-dma-v3-0-e7d574f5f62c@linaro.org>
 <20250624-james-nxp-spi-dma-v3-3-e7d574f5f62c@linaro.org>
 <aFrSgJ5xZfccEX9x@lizhi-Precision-Tower-5810>
 <290fc244-e88f-47a3-8dd3-0ec27eb5c60b@app.fastmail.com>
 <0c6c78da-575a-4d29-a79a-3903aa801b42@linaro.org>
 <0f904f12-295c-48fe-96c7-c64c461cdbbd@app.fastmail.com>
 <884e86be-112b-44dd-a827-30355a5fdba6@linaro.org>
Subject: Re: [PATCH v3 3/6] spi: spi-fsl-dspi: Stub out DMA functions
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Jun 25, 2025, at 12:19, James Clark wrote:
> On 25/06/2025 11:00 am, Arnd Bergmann wrote:
>> On Wed, Jun 25, 2025, at 11:19, James Clark wrote:
>>> On 24/06/2025 6:16 pm, Arnd Bergmann wrote:
>
> Wouldn't that allow someone to break it by disabling (or not enabling) 
> that option? The driver won't fall back to the other modes if DMA isn't 
> configured, it just won't work. In this case it seems like it's better 
> to depend directly on DMA_ENGINE because that fixes the randconfig 
> issues, which is the whole reason for the discussion.

It would be the same as disabling DMA_ENGINE today when running on an
SoC that supports DMA mode in DSPI. Ideally that should fall back
to non-accelerated mode. I see a lot of checks for
trans_mode == DSPI_DMA_MODE, and I it's probably best to change
them to a function call like

static inline bool dsp_dma_mode(struct fsl_dspi *dspi)
{
     if (!IS_ENABLED(CONFIG_DMA_ENGINE)) // or CONFIG_FSL_DSPI_USE_DMA
          return false;

     return dspi->devtype_data->trans_mode == DSPI_DMA_MODE;
}

> Would someone really want an option to disable compilation of two 
> functions if their DSPI device is one that doesn't use DMA? Seems like 
> this option would always be on anyway.

It's probably mainly relevant if they want to completely turn off
CONFIG_DMA_ENGINE, which is substantially bigger. Using a check
for that symbol in the driver is certainly simpler for the user,
as they can't accidentally turn it off the custom symbol.

In theory you may also want to turn off DMA mode for testing,
which is supported by at least the DW_DMA driver.

I see that SPI_TEGRA114 has a dependency on TEGRA20_APB_DMA,
which is yet another variation. This is clearly done for
usability purposes since that SPI driver only ever works with
the specific DMA driver in practice, but it seems worse
conceptually.

     Arnd

