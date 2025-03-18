Return-Path: <linux-spi+bounces-7208-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B10BCA67C7A
	for <lists+linux-spi@lfdr.de>; Tue, 18 Mar 2025 20:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9CDD19C31ED
	for <lists+linux-spi@lfdr.de>; Tue, 18 Mar 2025 19:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F011D63CD;
	Tue, 18 Mar 2025 19:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Mc/Of9Zt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bNwThTXK"
X-Original-To: linux-spi@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605261531E1;
	Tue, 18 Mar 2025 19:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742324431; cv=none; b=DhZXbhlRpsiG9BEdTZVZLmlN6Luw1YFoRHJmuTCkXCvbkOftKwbWcPH+etLQpGMU55R5FwrRfArDbpBhXMiDcyPwA7OtOMk6ag/OPSxO76e5ArUIrqcj2XWBQ7WFO1M2GlGKpkEc9tcaKtNM+N6QMnryd/KpI4har/cC64zX9ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742324431; c=relaxed/simple;
	bh=cgk55InILhtLB9t3QF4V9pMJKTwljv/A3WuG52Scxi8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Nn7GW1l1US3YQ8UKGqrkfjlTtjfaMLf0RFl+1ieAsw5X35TiyrlhJDpoeDUZcejrsEM2qkpsNMS924eeJY30CosyOz5qm9VCoGANClIepyhZr+Jqo1G3DskQ6yXD9Jj1aitrswMAUNPfLi7bh7fYwCUoEIA4jSxkxk3QQVwdRXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Mc/Of9Zt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bNwThTXK; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4CACB1140206;
	Tue, 18 Mar 2025 15:00:27 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-07.internal (MEProxy); Tue, 18 Mar 2025 15:00:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1742324427;
	 x=1742410827; bh=yjMyRl4RpOThDnjibhG8CaMinr6uxQHbj7Pp+a6/SUc=; b=
	Mc/Of9ZtNe63d+fv8oSNLRPpDRdZLeKyzXR27g0TGTK8U3VNbs0CJFPL1dH1+pDJ
	sOM3oaEKSXXP0zmxcK6KiWfaaaI1xDffoVIuO/ld5QQ0URhZlGbBKecCdHkWdBJP
	gR1VvBiN0KIqEYeYViNNk7YDU7DZLyzRaf655h1omHw2ORHVL96wttbgFvXglBSl
	MTLnrfTPY5nL0wLNFyuYUgra+9MSq//sjAA1Nrlg58jA4WsFLOmGyDsuNvltakV9
	5W5TjHaS8feyZ3RK5UThZ7JpIojj83AoUDZXGid8emBwkwoRkxkn2w7QVp+oG+tY
	OVVzVt3Kc1m4nVYmd2ohig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742324427; x=
	1742410827; bh=yjMyRl4RpOThDnjibhG8CaMinr6uxQHbj7Pp+a6/SUc=; b=b
	NwThTXKbSWDN7wR93dtaAQciDr4/XCaFpkP70ADq0NQAPgdqKkbdA1kSG+nXZqOg
	u2+6NLt2XrYJ7ltzbLRn5egBUpwMyoS/yw53VNuHIUab1uwmY+w7e0rcxyxG/ZIf
	OItWWsMkMVSrHRKdv8jsd6TAfGOVnHZnl3RVZQcHihyP6qua0h5ePH4mkFOcBCeg
	acV+m3Q4W+bEfKtOL5airVGm4g6aZ3wZTZPBbvv8wMTKTnEF+ezZaQsMqaXsUFyh
	ki89VYliblvE7wvg3+F5okpC+cSjlKQx4kHYis65BdtouKtkTGk82d3CWGjbToXt
	KVXn2jXTTW8Sgls2pr9VQ==
X-ME-Sender: <xms:ysLZZ4xTrz0_b_jyHV72-9ikFDuUqR_zYe2Pa3robS6OKYdJwuVbxA>
    <xme:ysLZZ8R2vH2oGKKuJdIhJLIZbR7QziksXwaKhaeanrQrf-ZJJecDzU6kPOiihSasW
    ZCqCgrIipjhxiPRaSw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeefvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnug
    gsrdguvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeet
    fefggfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohep
    udeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsrhhoohhnihgvseguvggsih
    grnhdrohhrghdprhgtphhtthhopehlvghithgrohesuggvsghirghnrdhorhhgpdhrtghp
    thhtohepnhhoohgulhgvshesvggrrhhthhdrlhhipdhrtghpthhtohepthhhihgvrhhrhi
    drrhgvughinhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvthgvrhhhuhgvfigv
    sehgmhigrdguvgdprhgtphhtthhopehjrghrkhhkoheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghp
    thhtohepkhgvrhhnvghlqdhtvggrmhesmhgvthgrrdgtohhmpdhrtghpthhtoheprhhmih
    hkvgihsehmvghtrgdrtghomh
X-ME-Proxy: <xmx:ysLZZ6UBA0jiTr9m9KYQCeWBDtpb8EIOo7yruLfrtE-v-o-IIeZTSg>
    <xmx:ysLZZ2hdwTugqRQqMmKVMti45EqVDngNMEmWhi22BsjWoGazVIAQLQ>
    <xmx:ysLZZ6D5Y7Oeli2C1HvyDtNssmGYB2TVmyVXC79IabxhXpxaKUkvcg>
    <xmx:ysLZZ3KlPZTau6hs8zvLnuWUo-YsXNq04PpBhfhjmFObatYXWttIjQ>
    <xmx:y8LZZwSGDPZU2zj8kIValPGmVD0ZGN_TivRm6zHN-SAdblX6XiLgrvq2>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9134B2220072; Tue, 18 Mar 2025 15:00:26 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Tce50d14c41957055
Date: Tue, 18 Mar 2025 20:00:05 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Breno Leitao" <leitao@debian.org>, "Mark Brown" <broonie@debian.org>
Cc: "Thierry Reding" <thierry.reding@gmail.com>,
 "Jon Hunter" <jonathanh@nvidia.com>,
 "Sowjanya Komatineni" <skomatineni@nvidia.com>,
 "Laxman Dewangan" <ldewangan@nvidia.com>, linux-tegra@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, rmikey@meta.com,
 kernel-team@meta.com, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 noodles@earth.li, "Jarkko Sakkinen" <jarkko@kernel.org>,
 "Peter Huewe" <peterhuewe@gmx.de>, jgg@ziepe.c
Message-Id: <b3da27ce-161b-4462-a608-c36f4b0696ce@app.fastmail.com>
In-Reply-To: <20250318-psychedelic-thundering-guppy-22bba2@leitao>
References: <20250317-tegra-v1-0-78474efc0386@debian.org>
 <20250317-tegra-v1-1-78474efc0386@debian.org>
 <22ffa8f5-6590-4602-853d-ceffed580f22@sirena.org.uk>
 <20250317-solemn-debonair-sambar-f04fa7@leitao>
 <f3e47d12-f6be-4bb5-b87b-84aa0037e1ef@sirena.org.uk>
 <20250318-cuddly-translucent-teal-e2ac2d@leitao>
 <6355bbb3-a4b1-4fdc-8a97-d81bc5e1cf65@sirena.org.uk>
 <20250318-furry-piquant-orca-da28c2@leitao>
 <47c40ec0-291c-4664-a66e-d76bd6360c0d@sirena.org.uk>
 <20250318-boisterous-adorable-chowchow-cea03b@leitao>
 <20250318-psychedelic-thundering-guppy-22bba2@leitao>
Subject: Re: [PATCH 1/3] spi: tegra210-quad: use device_reset_optional() instead of
 device_reset()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Mar 18, 2025, at 19:32, Breno Leitao wrote:
> On Tue, Mar 18, 2025 at 11:29:26AM -0700, Breno Leitao wrote:
>> On Tue, Mar 18, 2025 at 05:34:55PM +0000, Mark Brown wrote:
>> 
>> Summary of the proiblem: tpm_tis is trying to read random numbers
>> through a dead SPI controller. That causes infinite amounts of warnings
>> on the kernel, given that the controller is WARNing on time outs (which
>> is being fixed in one of the patches in this patchset).
>> 
>> Question: Should tpm_tis be aware that the underneath SPI controller is
>> dead, and eventually get unplugged?
>
> Adding Arnd to the email.

Hi Breno,

That does sound like the easiest answer: if the spi controller driver
knows that it needs a reset but there is no reset controller, shutting
itself down and removing its child devices seems like the least
offensive action.

No idea if there are other spi controllers that do something like this.

      Arnd

