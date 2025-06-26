Return-Path: <linux-spi+bounces-8781-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A3FAE9A4A
	for <lists+linux-spi@lfdr.de>; Thu, 26 Jun 2025 11:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20CF13A30F3
	for <lists+linux-spi@lfdr.de>; Thu, 26 Jun 2025 09:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E4E2BDC11;
	Thu, 26 Jun 2025 09:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="ZegFrSP6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QgnrhQzn"
X-Original-To: linux-spi@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58C0224B0D;
	Thu, 26 Jun 2025 09:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750930750; cv=none; b=QMnspDAmtbfhHrSFHvTdzRVHxaFa5Kw1AOu4ZYaT6o+p1aMzye0n5gR5Btps74mNAoek7+HAfSl5UpwNwCL3HzQwu9WQLxXjBuhfDmvW57JetMUQvpsbXU/XI3s+RkpvolwAwxUBv3oQfoKiOxDVdIi5w/9tDPdFIh67iKXYCHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750930750; c=relaxed/simple;
	bh=o8daXcWZ65Dq/4eEwQX7ZOVyxDaHlvht91ZhpLNM6gU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ex3ofQMs2tkYIs4Io3v5BFOOBvTswsVZSQKfn/MaR8Dc77FAMQYgUBPFrYJbUMwy+OBlRyzctUHWQXDqC0B3QObeNJ2dt61Rn7hWIl2CyEIvF0WJXgKsNhV5uCniVHpKrAQZ0q1o6IUYaYDR4XydmBcFAuzQyZII+3/y4uKxJ08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=ZegFrSP6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QgnrhQzn; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D9B1B1400027;
	Thu, 26 Jun 2025 05:39:07 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Thu, 26 Jun 2025 05:39:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1750930747;
	 x=1751017147; bh=o7PyZ2b1nxKZYN5a00rll4tLEFf+nfT8KJoh1Zsbzgw=; b=
	ZegFrSP6ge0nK92ZfDkIed/4FfgcOvZE84ouT+7AWC1v/QzU3pAgPsaGCbsT09IY
	3+o4+sHge9vbftXuBCWPc/UGgvyto9xU21cl6UVsJ8XhIXUlBRXna0WKs5mbTjI/
	Kf5gY8u7kbi2PxGCXtlA6PHXwhsPIzKlSjdpj+D1m87JaAoq7vqkZZ80bkwpDth2
	3ZEoIsDPXNm98kyM0FzyfHf9T3XR4mm3mxfWl0ioTKXR+SX7SEXfQcq4UmeV8mvb
	QyKMXomDw3o/8U82th88wcQTk88s9UHlayMLa5Ny40kW6s/4hr45oEw/f3Ib6Rrj
	QuvqnpXtaUPiyqMqrTV46Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1750930747; x=
	1751017147; bh=o7PyZ2b1nxKZYN5a00rll4tLEFf+nfT8KJoh1Zsbzgw=; b=Q
	gnrhQznIWRmfajF5jGYo2wV44X2xUQTJp3fqhLDJD2eZp7NFOyYz6SHOtTDVTj0H
	Yyj+6TJYdT/wUgXFx0Ev9LF3RRQ+ggnS5j79djWSWZIyijTRmnwIHbOmlJk7EzXg
	rZInHQ/rXAqsOaNa2RNkDwSjoce2AUCsJB3dJWcaVzglG2+l725pqwUlJw6yUG7J
	wTAUagAVsa+hV83ZBPj4ogqBIfPNlEnEUa2RtUphIM9+LuV/9ih+jBj2ZSKwnyya
	9iPuqiJqtG5HXZdYjA666xsqITpIlFpAY9eS8KzcADX97vtvXPRXWh/A+5Qz5KR+
	ua2NgMhJ6vnrh7ojb48+Q==
X-ME-Sender: <xms:OxVdaNw_PYfK9AAHYJfQZW7YcZX69X3kYPms8Pik_I-K2zOU0wrI7g>
    <xme:OxVdaNT0OYvr9aMycvHotFG8fUvXJYGUWhrf6o3EEOyaGNCG6cqVb6XUrRZMnN3Zm
    KhRSUjfZAM544lMGdw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvheeftdcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:OxVdaHUOdNyMhWBQ6z7f0trSQ8MgYjAR_otszf0Vjitl6mcSx1r6hQ>
    <xmx:OxVdaPixJjGn_JKn5lMsFQARuPv6gyHifMnW_C5ltrmrHvBCpixIFg>
    <xmx:OxVdaPBaQg7OZSjE_wSHO3RGF-zqE8JANU52FLDM3t4l8XsPyR1kZQ>
    <xmx:OxVdaIL0GiZ82VhKnRM_c2-oiyxH_MxjEh_k33YgK70MzIANMGLtDw>
    <xmx:OxVdaM8IePQ425zVd2U10o0gZaAJwFYmShKAHmsnRDg8RBJuawWsbs23>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3DAB1700063; Thu, 26 Jun 2025 05:39:07 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T5f36973fc3fda5d5
Date: Thu, 26 Jun 2025 11:38:46 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "James Clark" <james.clark@linaro.org>, "Frank Li" <Frank.li@nxp.com>
Cc: "Vladimir Oltean" <olteanv@gmail.com>, "Mark Brown" <broonie@kernel.org>,
 "Vladimir Oltean" <vladimir.oltean@nxp.com>,
 "Larisa Grigore" <larisa.grigore@nxp.com>, "Christoph Hellwig" <hch@lst.de>,
 linux-spi@vger.kernel.org, imx@lists.linux.dev, linux-kernel@vger.kernel.org
Message-Id: <a7c71ee8-0931-4af3-a68f-3f21fea840d3@app.fastmail.com>
In-Reply-To: <6fe9eebc-b050-4b12-a28b-e2f0bcc707e2@linaro.org>
References: <20250624-james-nxp-spi-dma-v3-0-e7d574f5f62c@linaro.org>
 <20250624-james-nxp-spi-dma-v3-4-e7d574f5f62c@linaro.org>
 <aFrUqW0ijRt7CJzw@lizhi-Precision-Tower-5810>
 <228fc6f7-52c2-48a8-af7e-6f2cfa7b9168@linaro.org>
 <aFwQCL0tQh9peb7x@lizhi-Precision-Tower-5810>
 <6fe9eebc-b050-4b12-a28b-e2f0bcc707e2@linaro.org>
Subject: Re: [PATCH v3 4/6] spi: spi-fsl-dspi: Use non-coherent memory for DMA
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Jun 26, 2025, at 11:14, James Clark wrote:
> On 25/06/2025 4:04 pm, Frank Li wrote:
>>
>> The cover letter will be lost after patch merge. When someone run git log
>> after some year later, they need know why need this change , what purpose ...
>> 
> I somewhat disagree with this. Usually maintainers add a 'Link:' to the 
> mailing list when applying patches, so the cover letter shouldn't be 
> lost. And these particular performance test results are short lived, in 
> several years time other things may have changed. The performance is 
> related to a specific device and the state of the rest of the kernel at 
> this time. Additionally, I mentioned that it's the combination of two 
> commits. In order to put figures on this commit message I would have to 
> run another set of tests with only this commit and not the one to 
> increase the buffer size which comes after. I did consider reversing the 
> order of them to do this, but it wasn't straightforward, and I really 
> didn't think it was worth the effort when I can just put the figures on 
> the cover letter.

If you submit your changes as a pull request for inclusion, the
common solution is to put the cover letter into the signed tag,
which then gets used as both the description in 'git request-pull'
and in the merge commit.

See e.g. commit 5b31d2d81a4b ("spi: sh-msiof: Transfer size
improvements and I2S") for how a similar series on another driver
shows up in the git log.

    Arnd

