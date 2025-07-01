Return-Path: <linux-spi+bounces-8948-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A75AEFDA9
	for <lists+linux-spi@lfdr.de>; Tue,  1 Jul 2025 17:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DB453BA460
	for <lists+linux-spi@lfdr.de>; Tue,  1 Jul 2025 15:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CCF277C81;
	Tue,  1 Jul 2025 15:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Rt2TPPRy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VFvbRjkU"
X-Original-To: linux-spi@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5820127604B;
	Tue,  1 Jul 2025 15:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751382602; cv=none; b=bgg2sqrHf7o8z4mcZo0Yb4/Ph3/312hmMm4A5CmpVyT4PPiqAXrZgDzCqPsz9sq3Lo0YgmS38jl+tuGbcrVE1fZsz9TpyHtEUtTjAyDS/U+xMDwLSdGJaD5ITlsmUic3BCZhdKK514XnykmIxXAXO6hJUyZ6jk4mbTvlEQmXteA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751382602; c=relaxed/simple;
	bh=tq51FWZ6LRnCw0poQmdAKux9bba7qb9IciudrlcRk6I=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=t/2r0ncJYF7fPQI4ifR9AfrveRZ0/Ai5vD3KYsuKLvKlz2pW3r6G2nEt8MYYT0Sn3jzZrrgc5L2e2yde9HhLfHaZvnbJareM6u4Y6Sb7gKOFgyJcwGyToBzIGe41gilngDFfJ44oL4CaGdGiOHj9W4QLy2qcGAg1HiET5kcyD/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Rt2TPPRy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VFvbRjkU; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7222914001F2;
	Tue,  1 Jul 2025 11:09:59 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Tue, 01 Jul 2025 11:09:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1751382599;
	 x=1751468999; bh=i7BfwuCIxdJ8HKosFakEihEWeIhXIYL0aH/Wik8d84A=; b=
	Rt2TPPRyQUtUu7V73QTJjUOh11RcAY1GA/CxfkzGY8msEBPfgyrq4ZN2L2At+eFH
	AsWcUjyo/y9piPMTw9p9CMbZEoj3RtxA30PZTvsw6LFWdiFuOu2q3VcPJsDBLztx
	FbgzourQKoZjdorWo1j4fQ4CR4spPG/IEQ3QA77Ce6Nlt3r2w1ETsYgKfojwAwAM
	HIVAyY5P+ZWDPeJwcoh13uDz8W58VehnIDoDv+4lhUJ7hnNvEr6yaxyrH96X9SML
	C2xFdxkfKmRXhCFnq0j+5IBQ7QuAV/bNPtFxYOzKuufQbC8+oy++fm6U3rl2b/qZ
	wFRNBWtiA1+hbTtzEH0Fpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751382599; x=
	1751468999; bh=i7BfwuCIxdJ8HKosFakEihEWeIhXIYL0aH/Wik8d84A=; b=V
	FvbRjkUM9hcY6uYQRmhIvcnd68K1I0LpCdSusOCUGEeJJtO/Y6pQ7b3JEhpHwVxi
	H8faImMQ2+OoaxGpvXYwU5r2ftgHFXHR8a2xHBISReZvpzACWhz7tsoOLvVnkfdZ
	GRSfwCHhBIaSGtEe3CpSGiMAtABXNolfSQrBlF96VgM3Oo3ETBjrSVlobhTu4wTx
	eC0NejFDw2HwQsST0QLdZWyxLmFR12iMF55U+ITrD1UxxmRS0vAjMyRAO5y9Fn+p
	Wk0xCzQM0KNd7WoEk4q1hEnPrpGe0VcK2odTgqSKMT19IQTYY8vwsY5LSToVDStW
	4XvDotp0R7P+xIM8n/2dw==
X-ME-Sender: <xms:RvpjaKETliO7x_PQbNHxU4oMcYkt6cI-LLy5bmIS1srbTLl7eJ-ZjA>
    <xme:RvpjaLUd6_oxn8IkSTBCl93eDBxgpSRzJHIc_ziK0bzGjRjof_Bv8tGYy3FChtavK
    2GziQgBTlkPmWYvG3M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeekgecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:RvpjaEKcCGOlgLzgusbghuPrGQc7bh3E1CKqm8w_r2Iv6YQf-2bJSA>
    <xmx:RvpjaEFAyXROcu433CRAkaKV_dx6GWFTtEXTvvubiUIOJp6alFZ30Q>
    <xmx:RvpjaAWGml-iFf7xIw_UO95xG5rlcelea7g0_B9pMHE1kwBoyPrpiQ>
    <xmx:RvpjaHMqtuwKKiE7grUXu3p99NIDSTk1TsGL9ArklfTDc4iclN0j2A>
    <xmx:R_pjaCh1TeEd1f1ebQE7cpGyHrkwPMdCdPRDBGCCm11OxdrhfoVMu6EK>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id AA9B7700063; Tue,  1 Jul 2025 11:09:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T05562b91942fdb87
Date: Tue, 01 Jul 2025 17:09:38 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Vladimir Oltean" <vladimir.oltean@nxp.com>,
 "James Clark" <james.clark@linaro.org>
Cc: "Vladimir Oltean" <olteanv@gmail.com>, "Mark Brown" <broonie@kernel.org>,
 "Larisa Grigore" <larisa.grigore@nxp.com>, "Frank Li" <Frank.li@nxp.com>,
 "Christoph Hellwig" <hch@lst.de>, linux-spi@vger.kernel.org,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org
Message-Id: <047a79cd-a1eb-45ff-88c4-15b69f5449e4@app.fastmail.com>
In-Reply-To: <20250701144711.hfcgk7hhk5w4jmvf@skbuf>
References: <20250627-james-nxp-spi-dma-v4-0-178dba20c120@linaro.org>
 <20250627-james-nxp-spi-dma-v4-5-178dba20c120@linaro.org>
 <20250701144711.hfcgk7hhk5w4jmvf@skbuf>
Subject: Re: [PATCH v4 5/6] spi: spi-fsl-dspi: Increase DMA buffer size
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Jul 1, 2025, at 16:47, Vladimir Oltean wrote:
> On Fri, Jun 27, 2025 at 11:21:41AM +0100, James Clark wrote:

>> +	}
>> +
>> +	return PAGE_SIZE;
>> +}
>
> The other question is: what's fundamentally different between the host
> and target operating modes, such that we return different values? Why
> not the same?

In host mode, the driver is able to split up a transfer into smaller
chunks, while in target mode the length of the transfer is determined
by the remote host and can be larger than whatever default buffer
size we pick.

Using PAGE_SIZE as the default host buffer makes sense since that
is the smallest underlying size for dma_alloc_noncoherent, and
larger buffers would be fairly wasteful.

Endpoint mode should only be enabled if it's actually being used
and in that case the allocation is as large as possible.

       Arnd

