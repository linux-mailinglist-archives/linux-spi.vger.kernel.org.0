Return-Path: <linux-spi+bounces-5598-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5789B9DE9
	for <lists+linux-spi@lfdr.de>; Sat,  2 Nov 2024 09:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFB87282AAD
	for <lists+linux-spi@lfdr.de>; Sat,  2 Nov 2024 08:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DFD8156228;
	Sat,  2 Nov 2024 08:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="TAJdI5nA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HuP631SA"
X-Original-To: linux-spi@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1AA149013;
	Sat,  2 Nov 2024 08:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730536577; cv=none; b=kI/AvFziHzRjqRJz7d41zqDzWiUlyjRU2Ep8wXoVDCUyLM9C8LRiBR41WzyfAHffLCUC1T/LyZF7IB4D3PdaUxbEJo5aicmNuI88ALc+yZsvgx6esDzE2PW36sYSNCIdbjiqWyfgcHcx0zNMT5c3RB5Z3abpEt5LurHmI+SHnBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730536577; c=relaxed/simple;
	bh=D+Mijo0FL6xpK9EOLFIwHY+A29Y47n3svW0py42hJ8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bpO8UtdIsL7+txSEljgBj15IhQmXcMX+Nj2f8NHxwsQLXcvA/eGyJyIOCw+89AZ/Bj7fJ8+jtv8vNB7Nt07MuateApylFV/kgeqen8rszGGQ5br57LlHWz9ywi7ad1y13A0++i0iJlKS7EvpuH+CoQTQg4jLFLYXbUWteXqRRTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=TAJdI5nA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HuP631SA; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id B17BE1140113;
	Sat,  2 Nov 2024 04:36:13 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Sat, 02 Nov 2024 04:36:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1730536573; x=1730622973; bh=CxnydXbwJ5
	eq9YUDX/EDzhIGvXa8fKehgoMmewXSQHs=; b=TAJdI5nAD6q3HluHLkaBXGD9f6
	gHJCALc9zMPzV0vRb8UB2lYzPr979fqIkVsoqGYkPuKKDo9X9K8s2NJnNu4UH6Up
	Kq2jUJ0GAsU98bTEUM/jXcRw95wkorCLioREZthUv0yPOFO8ooCSv0fem9SIcRP/
	ANX9Wv+pStJ0ogH/8TmuOVnFPNyeW705fsPZWlfq09+hHf6x+rgYLp2ZABl5RyI7
	6awdEkvJKk3Spnb7XTYYUTlDxkturI5Yn/8sMBY1tZWkKZ+NqIzlkpfvU1s2jDih
	JcR3MIhw4ZHa91k/sSLaXnCQDfXerIcKCR8ltgLt64BugfEjuUti/rgI1HSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730536573; x=1730622973; bh=CxnydXbwJ5eq9YUDX/EDzhIGvXa8fKehgoM
	mewXSQHs=; b=HuP631SAvyeeZHWs+JrtVJWwL00bMZ0gi+cQns6gFZM2gu4S1PK
	rV3ly0VRs9LsvpZhQ+coufByMgCmiWjyOJHtBITCHPJ+z1qjP9RU0jdbULCYzAGC
	DefaDb6KMwPKbQeAEO4GyYU9zGOPKDAWJMkxTWK4a5Y2pPMTRquoPP+N1/ussHth
	CwG0dC4V6RNJPV82sgl4+ZJkfjzHzfS+m4N0zRdGLtjhTgyJAPnvY3cQuLqEIv8Y
	+GrwkLniHAnafbIyQ6qbDDAGiS7ChdDqPsF7+VBPkSRM4vSGm4tQ4UqExJqV4EDx
	tJrKqPUW3/pysECFCqFnjvEzAEYAdpKKTLg==
X-ME-Sender: <xms:e-QlZ_a9_L_-1qdndBi9EyVE1RfvY0h-Gb_COzmZPWrKvuXouquq0g>
    <xme:e-QlZ-YBBowAHMAQ_SE73I4PT1VdvHrDj1RNu70FpMsnicmu4P3WIH-POWueb9Ka_
    S5h-Vnt3YqVtP0SbVs>
X-ME-Received: <xmr:e-QlZx_Lqy8r4Z5fAiv39L3BOYL7MpJL_hUn7GUl6K-1kcUMjVABIUxQEsu0-fhZVtvGN0BmI4lyJhL_0qYObFVjQnWzyrznrT8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeltddguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttdej
    necuhfhrohhmpeflrghnnhgvucfirhhunhgruhcuoehjsehjrghnnhgruhdrnhgvtheqne
    cuggftrfgrthhtvghrnhepgfduueffleefkeegueektdehkeejtedtffdtudejhfdvheet
    gfeigfeltdeufeejnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjsehjrghnnhgruhdrnhgv
    thdpnhgspghrtghpthhtohepudefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    htohifihhntghhvghnmhhisehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrrhgtrghn
    sehmrghrtggrnhdrshhtpdhrtghpthhtohepshhvvghnsehsvhgvnhhpvghtvghrrdguvg
    hvpdhrtghpthhtoheprghlhihsshgrsehrohhsvghniiifvghighdrihhopdhrtghpthht
    ohepsghrohhonhhivgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosghhsehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprg
    hsrghhiheslhhishhtshdrlhhinhhugidruggvvh
X-ME-Proxy: <xmx:e-QlZ1rCGgyYwIm0MvtZUxAbZcABlPTgAHcfvQTlzJqOAJ4-tgx_Yg>
    <xmx:e-QlZ6pgPaU9Pjm19b883M6R3UeFUufranZFbUrX4Uon-jJBw0Fp9w>
    <xmx:e-QlZ7SAmYmre5LCDI_AdOFSS1T3dfKMYdJ4RDnD04sOy_ONYOexIA>
    <xmx:e-QlZyoWi7B9Q94K7a402vdT3F8InxhnTcuPL2dc_bFRvQGospOBOw>
    <xmx:feQlZ_7_vg1vU6QchmWwft0O504JlUpp_2PPFt47138o039zjUeq9ck_>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 2 Nov 2024 04:36:10 -0400 (EDT)
Date: Sat, 2 Nov 2024 09:36:08 +0100
From: Janne Grunau <j@jannau.net>
To: Nick Chan <towinchenmi@gmail.com>
Cc: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: spi: apple,spi: Add binding for
 Apple SPI controllers
Message-ID: <20241102083608.GA308136@robin.jannau.net>
References: <20241101-asahi-spi-v3-0-3b411c5fb8e5@jannau.net>
 <20241101-asahi-spi-v3-1-3b411c5fb8e5@jannau.net>
 <46b31874-9fe2-4534-9777-816765a265b1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <46b31874-9fe2-4534-9777-816765a265b1@gmail.com>

On Sat, Nov 02, 2024 at 10:36:56AM +0800, Nick Chan wrote:
> 
> 
> On 2/11/2024 03:26, Janne Grunau via B4 Relay wrote:
> 
> [...]
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - apple,t8103-spi
> > +          - apple,t8112-spi
> > +          - apple,t6000-spi
> > +      - const: apple,spi
> Apple A7-A11 SoCs seems to use a Samsung SPI block, so apple,spi is too
> generic. Fallback to something like apple,t8103-spi instead.

Have you looked at it? This one still seems to be somehow Samsung
related. See the previous discussion at
https://lore.kernel.org/linux-devicetree/d87ae109-4b58-7465-b16e-3bf7c9d60f1f@marcan.st/

Even the A7-A11 SPI controllers are not compatible "apple,spi" doesn't
prevent us from using something like "apple,s5l-spi" for those.

Janne

