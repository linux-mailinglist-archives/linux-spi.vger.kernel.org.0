Return-Path: <linux-spi+bounces-8620-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 807F0ADC4BA
	for <lists+linux-spi@lfdr.de>; Tue, 17 Jun 2025 10:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A3F03B1256
	for <lists+linux-spi@lfdr.de>; Tue, 17 Jun 2025 08:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA6D28FABE;
	Tue, 17 Jun 2025 08:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="JrMdTAX9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TiaGR9+6"
X-Original-To: linux-spi@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517F528ECC0;
	Tue, 17 Jun 2025 08:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750148835; cv=none; b=mgUZjXMoTBpxnLOUqH71Lj2q47isEOfchhXDVUyZptSHP/GA9NAhQZh5ZWSjO3lEPfvJcJNlK2/MSmTdjqQIxRl1fPAQqXBSRjNlzai8WdQpdq9nyqfLULen4r2C1zca9NqUL3leDQLPzlLVmb2mtQbwBt/D2Z7vln5y/YjRs4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750148835; c=relaxed/simple;
	bh=p+OBljdaXw+ZNWtuzpzHmw1IKToyT5gfg5mlshVql+U=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=YZhLupDcp5W5o8QGB9nDlAEMXjL0039QRzazAQZEXejI3AgKE85wZX9ZsG+7RdH6dOIzZlgxGnBYFKc81UMk6WNCcTi9Lfj5+mQk+fZ9PtF36uDc+t7w5PJz8r+7yBkO0p6KTGdk7vrzw2UaHnCzTORkW1cHHr396BZ+rXyudc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=JrMdTAX9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TiaGR9+6; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7F1431140132;
	Tue, 17 Jun 2025 04:27:12 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Tue, 17 Jun 2025 04:27:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1750148832;
	 x=1750235232; bh=AapnD22KoJa7oOuX3gAhhYqhmyCztWp6yYLSnan63Qg=; b=
	JrMdTAX9qEcDetAUa8gdNPNggBZ0VX3PM6DceesLGYw2IrORWf27TSzqkmnGQASq
	d4q0/aFTlgN+j151YjXwetWhqU++1gNAAM3/wJcrVezjZbNtokh0wXywUqJnYjWl
	V22CGr1zRtIchMPQM3uY5QGFYsy8VxPqtJhmDukYplIMKRPF7UNfOUq6FSAKx77s
	7Dp0nGj3nPCx711tOuHSN9n826eUz0LKOZ5BA3M8lWfA8unAo75XpoNe/xhBHq+L
	HnYYc6he0p3/8CbJ/guwfDc6Ds4FMOieTbAJDhstQj25DiDaWVdvt6f3dPmxHEzK
	w9JSCIsZ9NeULOzGArtRzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1750148832; x=
	1750235232; bh=AapnD22KoJa7oOuX3gAhhYqhmyCztWp6yYLSnan63Qg=; b=T
	iaGR9+6KZg4HEiv45FneefPIinNWlBL01WyxEpIk/KeYNg8Csu5vZXBc8lHwFaZZ
	1Gl4XEIaaiL2dKuGmHgLNYV2JcSDMbMqz8km5xLM4Hu+C6AfqSaIDjUURtBt3Nfk
	I4gL8viWhaog930ranXn34kuMaMkVyoYxoYtXgtl5ANlPmDs2VWQ7H3YuUokkZhH
	jYs6thLDTkH2Csy9qczXpbsYSTThicDoruFnMXciVUIn6I6OedUaksxm12ibgrQ/
	dgP3eliOh4PgtQUhuBrz1LGxlGpmpy3yw+Fj6ykioPGQ9b2z//BBowcB12eu6Dwe
	P0rpq26f5aX2j9QtAbWtg==
X-ME-Sender: <xms:4CZRaE87h-nRftsg_6kNXBmMHLJq0HBhc0K1KAq5etLTTfRG0nqD0g>
    <xme:4CZRaMtWp2Q2rX18Kmb_pYH-BmF7S8Xwm6yhQ4ZlllvofuxN_b0W995PZ9kLgWEZc
    WV2JFrJwj_OBih0GYs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddvkeekjecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:4CZRaKCuvjcZvNREdfFxg7iIlgpJRLaX9h2AZfDfVY1s02hVY8zVBg>
    <xmx:4CZRaEeGdw1nk2-e77DoTV2ERy4elO4vkVOcQw0mJ0KZa4FHKtkn-g>
    <xmx:4CZRaJO6P7aes_EnrNS8eMslf1FGeHJ1r8MzJsuZNsXD7hZuTGSX5Q>
    <xmx:4CZRaOkeLdWNP6cyzVOuqYSq4wEESZMugGAQ2r2vHEWLkjFEkGhByg>
    <xmx:4CZRaDTJrF_knVLInAnOd3RLFGXBxbBKmsQhFSvAGN7vnQ00aANYMEWt>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 23FDD700062; Tue, 17 Jun 2025 04:27:12 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T4808b90e09d8ad4f
Date: Tue, 17 Jun 2025 10:26:51 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Christoph Hellwig" <hch@lst.de>
Cc: "James Clark" <james.clark@linaro.org>, "Mark Brown" <broonie@kernel.org>,
 "Vladimir Oltean" <olteanv@gmail.com>, oe-kbuild-all@lists.linux.dev,
 "Larisa Grigore" <larisa.grigore@nxp.com>, "Frank Li" <Frank.li@nxp.com>,
 linux-spi@vger.kernel.org, imx@lists.linux.dev, linux-kernel@vger.kernel.org,
 "kernel test robot" <lkp@intel.com>,
 "Marek Szyprowski" <m.szyprowski@samsung.com>,
 "Robin Murphy" <robin.murphy@arm.com>, iommu@lists.linux.dev
Message-Id: <76a8c896-d7ea-4471-99a2-34b3a7ac9804@app.fastmail.com>
In-Reply-To: <5de445aa-048b-4f60-9045-df5d45341436@app.fastmail.com>
References: <20250616120832.GA24959@lst.de>
 <2d62254e-5cbe-4174-95d8-e80cae4f4543@sirena.org.uk>
 <20250616121444.GA25443@lst.de>
 <7cfcf919-3c7d-4f0c-911f-697ea3141080@linaro.org>
 <20250616131346.GB29838@lst.de>
 <83855c1a-c128-4762-9d6b-e17f2c4c8820@linaro.org>
 <d16bdc40-20d6-49db-bf41-18bb9b8e01fd@linaro.org>
 <20250616131944.GA30260@lst.de>
 <f723d490-c228-42d5-9f9f-158df54a092d@linaro.org>
 <9788991a-ac37-4fde-81db-c55035d00f27@app.fastmail.com>
 <20250617044833.GE1824@lst.de>
 <5de445aa-048b-4f60-9045-df5d45341436@app.fastmail.com>
Subject: Re: [PATCH] dma-mapping: Stub out dma_{alloc,free,map}_pages() API
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Jun 17, 2025, at 09:53, Arnd Bergmann wrote:

> Between SH72xx/SH76xx, SUN3 and M68328, I believe the
> supported machines are all limited to between 1MB and 32MB in
> the maximum configuration, which is obviously extremely
> tight.

I checked the exact numbers we're talking about here: enabling
CONFIG_HAS_DMA on rsk7269_defconfig adds 10KB of extra vmlinux
size, which doesn't seem too bad:

   text	   data	    bss	    dec	    hex	filename
3295084	1111396	 112264	4518744	 44f358	vmlinux-before
3302836	1113652	 112264	4528752	 451a70	vmlinux-after

      Arnd

