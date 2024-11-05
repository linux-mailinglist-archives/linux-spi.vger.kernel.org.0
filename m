Return-Path: <linux-spi+bounces-5618-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2179B9BC73D
	for <lists+linux-spi@lfdr.de>; Tue,  5 Nov 2024 08:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C43C1C22254
	for <lists+linux-spi@lfdr.de>; Tue,  5 Nov 2024 07:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDD91FE0F6;
	Tue,  5 Nov 2024 07:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="i+Uy1IPw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZefMKQrX"
X-Original-To: linux-spi@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A101FCF41;
	Tue,  5 Nov 2024 07:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730792769; cv=none; b=ryefvxEMojS8YgF72a6X7lQ+SGEhtCATGRoEsshs/ZF04hIRRHNEzxjWwJIBAWbA7U4vKSePcykosMyBWLRLjNbor+ES2n0PWAYBu6NS8ORnH8ynTT7ZH/5bJwMyetlQRSGiRsmmItbv8cUyMf+/RRKqjbltK1j939oClvhTL2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730792769; c=relaxed/simple;
	bh=nEqA5houW+o27GUegzdk3C8MO76Lc0qt/xdTMSiDVxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r0rXpPafb0kszdgsXtWeRymgQXMBmXPCx6/H/RFvtouAHuVcubFmSCVTGXL8slKnW146B51FZx9pdBtd4Z4ibCMpaoK6Q0YievGu8S6QGUuEZqadRnvmIv1/DGuswTriSeghMTgalGoaXQi7D8wDG9KPV7Mqab45TWJYdtbGJ+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=i+Uy1IPw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZefMKQrX; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 387761140202;
	Tue,  5 Nov 2024 02:46:07 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 05 Nov 2024 02:46:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1730792767; x=1730879167; bh=zBA7bLE2mH
	qRkfZsK3UY/Q+ay2kNLXGkfRxWpEsue8U=; b=i+Uy1IPw+rQa2KHZvHvCCRN+po
	OSdEALT2ieuvZ0nyuDlrZdTxkf2Kd4bx/OiRlcV3c6eN5YZFK25ALK2mrg4mf+gQ
	/UhbqXvKVP8DjhuKWzPq9CugJ5qD645f4NcT02OB2KROQKah1i89fl51YxmVzFmP
	FWexC/2Q4cPi1Oujc8VDGeC8j2aNjVAbgQU96dYllErWLzDY2Y7WvtOKjMwwLnBn
	UvUZURq9Anmqh2SONMpFVtAbfSV7FnKAAW33p24e2up8coNnRF2g9BxLZgVWsyPC
	I13Wgujozbf5DQJQYyZILA6jQ4Sq4oPFh//xtI0EfYIRlwxxDSYrYSiP/A8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730792767; x=1730879167; bh=zBA7bLE2mHqRkfZsK3UY/Q+ay2kNLXGkfRx
	WpEsue8U=; b=ZefMKQrXFc5eXO0xpC8u0IR/tkQcs3lh7r8al+MW6vPy3aeayet
	7hD6Y+OAOOWttXSAIA/TjNXhJm5S54ea8icNIEZpG0RT1lDioej2mBoQ524PP0qI
	73RaszP0DReS6Xd3focsHE3a+0MsFBdLJy6s6OWAl3uirhyQlX8nsKAAwpEABwNC
	4s0QUZ9aI8s94Jv+Y1eH9G2bTuNh9hqT4dSjRPNf1NQizBN1JWPj7q1km6Qg0JfP
	yHrTz5UIBHPW5ZgGTFWYcZbqQX4UVBoLhdjcLGoMaH0AXBkoqAYarV3D4ZEnoQea
	DTxYiRjLOHyNLIftUX9ggmEnu0KeWeW44MA==
X-ME-Sender: <xms:Ps0pZ5YttRNoH-iZitAsODK8Ed47ShS1B-14pDxzqAV2cPbx9IvQNw>
    <xme:Ps0pZwZJV40ZXhMQbcn0QjX-7ZCcnshqTBR1uXtSg1wlD0wivlwbMtlkN1snky9Sg
    MYAk0dVgqIBu5dQtZQ>
X-ME-Received: <xmr:Ps0pZ7_TrRat-rMTcXXRoU2luraaF5BzmVKXt0fUt0RXbuXGEMbgRK3IqFcqeTdNDib1ffwFbNSrIebaeLDzptA1wzJIngAg-Dc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeljedguddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttdej
    necuhfhrohhmpeflrghnnhgvucfirhhunhgruhcuoehjsehjrghnnhgruhdrnhgvtheqne
    cuggftrfgrthhtvghrnhepgfdvffevleegudejfeefheehkeehleehfefgjefffeetudeg
    tefhuedufeehfeetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepjhesjhgrnhhnrghurdhnvghtpdhnsggprhgtphhtthhopedufedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtoheptghonhhorheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepmhgrrhgtrghnsehmrghrtggrnhdrshhtpdhrtghpthhtohepshhvvghnsehs
    vhgvnhhpvghtvghrrdguvghvpdhrtghpthhtoheprghlhihsshgrsehrohhsvghniiifvg
    highdrihhopdhrtghpthhtohepsghrohhonhhivgeskhgvrhhnvghlrdhorhhgpdhrtghp
    thhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheprghsrghhiheslhhishhtshdrlhhinhhugidruggvvh
X-ME-Proxy: <xmx:Ps0pZ3ouOO9r2fHILp75GBvr27RNiBKWDC6cqH73XVz5Y3mnCnbRSw>
    <xmx:Ps0pZ0oqaTVWRqBWF1wRLomqDTxlVJEZ_agc6C3K5on0CVvPJVRJGQ>
    <xmx:Ps0pZ9QZ5OKB6dhDwkP2eMt84DQPccruOmWX_WBS2xTeMFHCcwT4Fg>
    <xmx:Ps0pZ8oIYaRlI12mn8pzBO-ckFsbVZEuLOVK0NjhUMyTlnLFO2kgQA>
    <xmx:P80pZx7W8nbujgAr3hEXhDKtDiUxyJ8001pmZ61njQ9KvQK5R5tZCQmN>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Nov 2024 02:46:06 -0500 (EST)
Date: Tue, 5 Nov 2024 08:46:05 +0100
From: Janne Grunau <j@jannau.net>
To: Conor Dooley <conor@kernel.org>
Cc: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: spi: apple,spi: Add binding for
 Apple SPI controllers
Message-ID: <20241105074605.GB923511@robin.jannau.net>
References: <20241101-asahi-spi-v3-0-3b411c5fb8e5@jannau.net>
 <20241101-asahi-spi-v3-1-3b411c5fb8e5@jannau.net>
 <20241104-retract-wife-e1abe7425cc8@spud>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241104-retract-wife-e1abe7425cc8@spud>

On Mon, Nov 04, 2024 at 06:56:59PM +0000, Conor Dooley wrote:
> On Fri, Nov 01, 2024 at 08:26:12PM +0100, Janne Grunau via B4 Relay wrote:
> > +      spi: spi@39b104000 {
> 
> nit: the label here serves no purpose, and could be dropped. No need to
> respin for that obviously.

removed since there will be a respin for minor driver changes

> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

thanks
Janne

