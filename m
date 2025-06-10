Return-Path: <linux-spi+bounces-8422-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5CFAD304B
	for <lists+linux-spi@lfdr.de>; Tue, 10 Jun 2025 10:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 805D83AD1EA
	for <lists+linux-spi@lfdr.de>; Tue, 10 Jun 2025 08:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4D3220699;
	Tue, 10 Jun 2025 08:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="rXo78bJk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="az34+tl6"
X-Original-To: linux-spi@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9F828137F;
	Tue, 10 Jun 2025 08:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749544013; cv=none; b=u0mUGMlhmzXSyLL91o/AXuGydUKwACdxf+Y86TX89GgWfV9IoH0D+ICnzPrTtc21CoL8LRunbEmyQQP9nV3vXsvitG4fjs11RVw9poXgHp4nLeNT3tJAMWLV4CByt0GSIZbbtPJ0IrvmZwIazRxPh2+7P6HlEU7qG4v2EaCl+ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749544013; c=relaxed/simple;
	bh=jDhdLXBPgSGt6oRlbGs9cOp8/AQDYr5pxPRzrgiK+8k=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=qHuln0FO/8vosr31ioBS+y88y8DieGenheBRfqV2UkugvJfTG8mGsLBKiq2jKH2gDWrj0/KAF4rTb9WoEg6MccRJgjehzNMq8pjJZoVgvl/Mr1eNgdOZU+3T42akichiNP5mOJjHBzjRFyDij3DrvhbAb7oZYejBnrPbHmYPwfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=rXo78bJk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=az34+tl6; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 81B062540150;
	Tue, 10 Jun 2025 04:26:49 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Tue, 10 Jun 2025 04:26:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1749544009;
	 x=1749630409; bh=Zsf/amW9Z6SOQQ8AqKNeaHP1tfn0mldyK1FoWg2o0x8=; b=
	rXo78bJkWsapuiVOISzl0DtpeV6Pz0tERB+odlfUvvg2BZ2rqjt/L3qvvvRN2orf
	JpUboAJZaeHqFqcy6buVd/2Fm+fac5kRy3iQ4BoschLMISfbTt9BE5q4Q4gUuUdG
	nJUPVWNfOkNWytMgbGT1ibpe2LB5p2x0wl4b1GSdxtZR6FTgoaPMqe7Tm2Rbey1i
	UWu/1f1FUoZJfqPVG4G+klPijfUWQqbULTf+2VcW0zlovW6jhFYFDrVH79SzlFlU
	1sNVm4Q7oYJiZt1exctzcAtcPNsKCy+9qwbvQq+V0AANfhkzN/Ztfj3nbTMFJYo8
	98odcmbXPsiuwJH+tW4Vog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749544009; x=
	1749630409; bh=Zsf/amW9Z6SOQQ8AqKNeaHP1tfn0mldyK1FoWg2o0x8=; b=a
	z34+tl6t7Av4+T3zFyKBxHVPpEBM9lFx7VSkrk7z0M2AJ9SCb4brI65hSjeH8DAp
	nx9zli7+06P7NX1mencOXAGCQRIuQJh1wi3bmOxYIxvc/MDM+BIUUWTbx2ZKamDB
	XV+a50P+Fa3/znYfVSEJq4R/WL1Lh/VdWsqhdTqxK3idmajqhKLm6amDbJzKqYHT
	w5/bcqHaQy/FVkwqG/NMO0ykokE5UsuMvKSqYguUXi+fzmD6+Oh31lHS4c7gZDMJ
	JBRlO3S8QBenbRcSbVWSltc5HV6XiJ3mNVF3k7qvlDEzbn6XSbRgE6SQEpQiP6tG
	eoA9cos+cTrd6Oox2s8nw==
X-ME-Sender: <xms:SexHaNRe0LUD-K-YgB_fC0izq4_KzgOcyfzQbqx5IQyknhtZjx1XBQ>
    <xme:SexHaGz0UCq2Ld00OfCIOI3VPFYebjxD_GaDKSnaVBHsD2qigfKRDmPunxx4kdfnw
    5p-YGtuXD60ItmhkN8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddutdeglecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteef
    gffgvedugeduveelvdekhfdvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopeej
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeholhhtvggrnhhvsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepsghrohhonhhivgeskhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepjhgrmhgvshdrtghlrghrkheslhhinhgrrhhordhorhhgpdhrtghpthhtohepihhmgi
    eslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehvlhgrughimhhirhdrohhl
    thgvrghnsehngihprdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqshhpihesvhhgvghr
    rdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:SexHaC1yAbPVefVqCNiUSkTXxY2XxPbIQb9pW_-6ohHdILnQmHP0Kw>
    <xmx:SexHaFB3kRAeS8J-HYWoaouuiYsuHQKOiQDeQA7sSBXleszmnbbhXQ>
    <xmx:SexHaGhxJVkxiRU2rwGQadFZ7mybFUTSIM4EIOW4XbqHZsDEIAkllg>
    <xmx:SexHaJpVm9WuYgZB57VL66NTD62Dt2pPlxelsRJls_lzpN0mBKPTmw>
    <xmx:SexHaAp1ANxjI_D5_lui4d8maVF1RhQpDAfFWXRRAFDNQ9euaDwElp3->
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0A90D700062; Tue, 10 Jun 2025 04:26:49 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T7ec8a5524929d219
Date: Tue, 10 Jun 2025 10:26:20 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "James Clark" <james.clark@linaro.org>,
 "Vladimir Oltean" <olteanv@gmail.com>, "Mark Brown" <broonie@kernel.org>
Cc: "Vladimir Oltean" <vladimir.oltean@nxp.com>, linux-spi@vger.kernel.org,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org
Message-Id: <1c579729-4461-4666-ab1a-77f17a320ee9@app.fastmail.com>
In-Reply-To: <20250609-james-nxp-spi-dma-v1-2-2b831e714be2@linaro.org>
References: <20250609-james-nxp-spi-dma-v1-0-2b831e714be2@linaro.org>
 <20250609-james-nxp-spi-dma-v1-2-2b831e714be2@linaro.org>
Subject: Re: [PATCH 2/4] spi: spi-fsl-dspi: Use non-coherent memory for DMA
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Jun 9, 2025, at 17:32, James Clark wrote:
> Using coherent memory here isn't functionally necessary. Because the
> change to use non-coherent memory isn't overly complex and only a few
> synchronization points are required, we might as well do it while fixing
> up some other DMA issues.
>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: James Clark <james.clark@linaro.org>

This version looks good to me,

Acked-by: Arnd Bergmann <arnd@arndb.de>

I had reviewed an internal version originally and had some comment
on that, all of which are addressed now. You did not Cc me on the
other patches, so I looked them up in the archive, Patch 3 also
looks good to me and complements this one (i.e. you really want
the combination). I did not understand the logic in patch 4,
and it would be good if someone else can take a closer look
at that in order to Ack that.

      Arnd

