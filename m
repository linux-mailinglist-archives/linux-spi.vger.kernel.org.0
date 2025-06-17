Return-Path: <linux-spi+bounces-8619-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 210E6ADC3C2
	for <lists+linux-spi@lfdr.de>; Tue, 17 Jun 2025 09:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B98531729B8
	for <lists+linux-spi@lfdr.de>; Tue, 17 Jun 2025 07:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D2128CF65;
	Tue, 17 Jun 2025 07:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="TIrRR1Rf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nyfchuHC"
X-Original-To: linux-spi@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED7C28D85C;
	Tue, 17 Jun 2025 07:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750146835; cv=none; b=S3Tj9N/J3ZiRxm7+JUTy/6VLpY2+C9/W/oOA8dfwndJf7fZt+VhQiFsQ82t94ZdrCRfr+V5GK2m1SpDf7jt86Jo1vSjGsYCSx77IJ3P8A6Fk9jl6tCVBgfyB3KT8U6FGL4XOloWxr9n/gEtx3c6Ov7cPjPPZaXa7yinTZF1ESag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750146835; c=relaxed/simple;
	bh=OqthscKnASx0MYwBa87Rhel76+HHnEy30Q7AuBEmizk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=AAOvwiWBQyUQDYeJzdy39c4D0xvSi3sY4qhPEmksbfdKPMayzJXMg6qkMmP/tABnJmPl0Z8IJpQD/99LBRuFWDGbQKbqJTU7WR4avheUPKXV1u62qmOx90cFyoj1hVbrjJsZ6Lt8JKJdGMxQAzHeKN5QOk8SbeGxxmIePyCLST4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=TIrRR1Rf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nyfchuHC; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 5D90D1380373;
	Tue, 17 Jun 2025 03:53:52 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Tue, 17 Jun 2025 03:53:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1750146832;
	 x=1750233232; bh=N/gVmKjkroaVRvbIjFt+q9mrEuWIbF/Y3kVfpO1Se9g=; b=
	TIrRR1Rf+lh8N6KUpnEMeoAf5nmqR19q1dPgtLddv+3d++6Zkl2OaVUtoHfVnC95
	njpNkJ5G9FRiHJ1O6IlymETlfHo0FCNLI3rALHcYifc1/YhM/cX/SnVsDXNB2YS+
	5sPmQdbM31lfqVY4iacsaUr1xYOr4PStOs/wSeay9WPeDIq7U/nfd8DYe67iNM5K
	BFBYCt9Bk0fhxPIqK1RpS31UB2M91p/28GEI9LM0fqPfrI9bTlf9Oze6PKjYkJmW
	EFHJOuMRj2VY25qZ7WOElEvUydRuonaJ0ENu7wvBPRdWVlBSEnJ/GkoIZD5EWufv
	EdQh3dvim9ZUsD/Zs5cVPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1750146832; x=
	1750233232; bh=N/gVmKjkroaVRvbIjFt+q9mrEuWIbF/Y3kVfpO1Se9g=; b=n
	yfchuHChhwk5xqx5dxSqe0nD3BGS++35HsbZpQonzuGUQytrh89pKLVpcoKHSLDe
	7VwfnzMVI48ZeYMq/ICoRR3LKCSwYjJ5sx6YujNNWmCMOENLC+9TqhlrDDR+4uvh
	MD9pf8+lTYjNkMxaJkZ7Gp6tdUCn49uHICEePjtdgcryHT4Nq+CVz0BNXZxiIwqu
	9ak9iuyZn5PN7N0CR3FAETsA50gTLzylo09LoN77kwP91FukiqUNlQO30WA00IB7
	cT2suWkM8c2k9YYrrMxlrgUAMWrIogP2Zl/rnJLcSfEKfSFsSVb4LStzzMPwCbg0
	CApThddOm5cgo3BJ4Irow==
X-ME-Sender: <xms:Dx9RaLiFYiW4kdhv9J5fhwzdxpuXkj55FXgvbvlsz5LFyY2PFHgLOA>
    <xme:Dx9RaIBbrIzpPEiZlDN0pEMbPUt_K5hlRE887MJau9botaxAQDz-HKfBPzc7K8af9
    mc-ln5JnZ71ZGZB3DA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddvkeekfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpeehjeejhfeftdfgieehleefleehgedugfevieei
    veeivedvudegheehudefkefhfeenucffohhmrghinhepphgrshhtvggsihhnrdgtohhmne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgu
    segrrhhnuggsrdguvgdpnhgspghrtghpthhtohepudegpdhmohguvgepshhmthhpohhuth
    dprhgtphhtthhopehrohgsihhnrdhmuhhrphhhhiesrghrmhdrtghomhdprhgtphhtthho
    peholhhtvggrnhhvsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhkphesihhnthgvlh
    drtghomhdprhgtphhtthhopegsrhhoohhnihgvsehkvghrnhgvlhdrohhrghdprhgtphht
    thhopehjrghmvghsrdgtlhgrrhhksehlihhnrghrohdrohhrghdprhgtphhtthhopehimh
    igsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepihhomhhmuheslhhishht
    shdrlhhinhhugidruggvvhdprhgtphhtthhopehovgdqkhgsuhhilhguqdgrlhhlsehlih
    hsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohephhgthheslhhsthdruggv
X-ME-Proxy: <xmx:Dx9RaLFN-BDF7HlEnZmoG3h2MWfQtBwN0hEg2LqmPxJOBQH61u9mTQ>
    <xmx:Dx9RaISGlbGoQBTDdDAu4eCxm4KVvLeMTUcQ94U9E0MvMOCNlXeRlQ>
    <xmx:Dx9RaIyieKngvGlAlYEjkdIq7Rftt-f01NPrGMNX74Lt06v6oktVbQ>
    <xmx:Dx9RaO6ZXUy5vZq_o8DTkzT9MUkMvB-lWT-nMH69GPhby5l22aQ_QQ>
    <xmx:EB9RaFjLe8GzAum3dkhpQU2-pcdJYSDXSQFoI6gh02h0xGoLujEGqrlB>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3C946700065; Tue, 17 Jun 2025 03:53:51 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T4808b90e09d8ad4f
Date: Tue, 17 Jun 2025 09:53:22 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Christoph Hellwig" <hch@lst.de>
Cc: "James Clark" <james.clark@linaro.org>, "Mark Brown" <broonie@kernel.org>,
 "Vladimir Oltean" <olteanv@gmail.com>, oe-kbuild-all@lists.linux.dev,
 "Larisa Grigore" <larisa.grigore@nxp.com>, "Frank Li" <Frank.li@nxp.com>,
 linux-spi@vger.kernel.org, imx@lists.linux.dev, linux-kernel@vger.kernel.org,
 "kernel test robot" <lkp@intel.com>,
 "Marek Szyprowski" <m.szyprowski@samsung.com>,
 "Robin Murphy" <robin.murphy@arm.com>, iommu@lists.linux.dev
Message-Id: <5de445aa-048b-4f60-9045-df5d45341436@app.fastmail.com>
In-Reply-To: <20250617044833.GE1824@lst.de>
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
Subject: Re: [PATCH] dma-mapping: Stub out dma_{alloc,free,map}_pages() API
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Jun 17, 2025, at 06:48, Christoph Hellwig wrote:
> On Mon, Jun 16, 2025 at 03:48:50PM +0200, Arnd Bergmann wrote:
>> As far as I can tell, the difference here is that the
>> dma_alloc_coherent()/dma_free_coherent() calls all get stubbed
>> out, so the 827 drivers using those can all build cleanly on
>> mk68knommu, shnommu and UML, while dma_alloc_noncoherent()/
>> dma_free_noncoherent() are only used on 15 files that are all
>> guarded by some other Kconfig dependency at the moment and won't
>> build on the those platforms.
>
> Yes, dma_alloc_coherent is from a time where stubbing out was
> still very common.
>
>> I agree that it would be best to treat the coherent/noncoherent
>> cases the same, and I also think the existing stubs are a bit
>> silly, but just removing them would likely require fixing
>> hundreds of drivers with added Kconfig or IS_ENABLED() checks.
>
> I doubt it's that many, as most drivers and even subsystems simply
> depend on DMA.  There's probably at most a few dozen drivers
> supporting DMA but not requiring it.

I checked again, and the actual number is 263 modules for a j2
allmodconfig with the DMA stubs removed, see
https://pastebin.com/raw/4PFcEe04

This is helped a lot by PCI being unavailable on all four
targets without DMA. If I force-enable PCI, I see 610 modules
in allmodconfig that link to one of the dma-mapping helper
functions but are missing a dependency on CONFIG_HAS_DMA.

>> Maybe we can actually remove CONFIG_NO_DMA/CONFIG_HAS_DMA
>> entirely and remove all the checks for CONFIG_HAS_DMA? 
>> My guess is that this would only lead to a small code size
>> increase on the affected targets, but since they are not
>> actually trying to do DMA, and they all have a very limited
>> set of drivers they actually use, it won't break existing
>> code.
>
> Except for uml, the CONFIG_NO_DMA configs are usually very resource
> constraint, so I don't think that's a good idea.

The J2 Turtleboard has 256MB of RAM, which is not too
constrained either.

Between SH72xx/SH76xx, SUN3 and M68328, I believe the
supported machines are all limited to between 1MB and 32MB in
the maximum configuration, which is obviously extremely
tight. On the other hand, I really don't think anyone cares
any more: all three platforms are between 25 and 40 years
old, kernel support is very minimal and nobody has really
spent time improving them in at least 15 years. It also
appears that all three do support DMA in some form, so if
anyone was serious about using them, they would probably
want to use the dma-mapping interface for it as well,
like we do for similarly constrained nommu platforms
(coldfire, cortex-m3, xtensa)

      Arnd

