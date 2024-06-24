Return-Path: <linux-spi+bounces-3548-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D14C7915314
	for <lists+linux-spi@lfdr.de>; Mon, 24 Jun 2024 18:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89F4E2817C2
	for <lists+linux-spi@lfdr.de>; Mon, 24 Jun 2024 16:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1741428E2;
	Mon, 24 Jun 2024 16:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fkSlrzaq"
X-Original-To: linux-spi@vger.kernel.org
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E694C637;
	Mon, 24 Jun 2024 16:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719244898; cv=none; b=MuDbxXjv1L1mFEvBNW3NvMr520nTOQKhGqviLI2q4FlTucUiG3IMaQvxaLMtehFRPq4uiC0b//Bwz8lIc3GhHGpoaeyymulJhkIpZpkwoI1eKUWZuJHuhT62NRAZbU47OZ26ny79YbwyG+Gm+OJyDTkAf1K1+DdlSzAw2l2tglg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719244898; c=relaxed/simple;
	bh=eUZ497IKUTiEZRXQIx9KyELVsWkmyvORF+kN4fWI2m8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dzG5etGK0bPuwOnEvUAsVivhozlPwFu+rmJSaYp0OytqJ8tiboC0kmENXIWN6rVPvvzbcZNAK6qARsS6ekCiGft8YbHaDPYxaQhvSrQ2SKM2THVifBMwSlfdM48CszEse3k1Nt5pTmJWCBN6Za9iei3QvvgxzQBNoZEUVu2W+Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fkSlrzaq; arc=none smtp.client-ip=217.70.178.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay3-d.mail.gandi.net (unknown [217.70.183.195])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id A8A3EC6D88;
	Mon, 24 Jun 2024 15:57:45 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 72EDA60004;
	Mon, 24 Jun 2024 15:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1719244657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iXxpqBP/kXN/wMkaImlR9s1zvlek3VuYbSbXjgAh4UM=;
	b=fkSlrzaqErIejEv0bRSvz4p63dCyq63rzLVrG0NqgsMcRJhqCXcMJZNGn+Ih4mo8nWErrT
	z6Oo21vzzE70h0iKDqV9Pz+yN5o1dXdpB/USXdMz/IEZr6iOxrbC78xamIgYvhIVhxlsyL
	InkWvE8gUP+XrYalXcbSceATtwpl8+jpsB38yWB9c3TpCfxFKubu30r361tpd796qwBkS/
	MVuB+qsEdnGK8BTm/J1jbP455dtMsoS2PMk+4KLbSWJgi9PlVSkBJCcebM7gqZ6OURSGOQ
	X2pxDYoLBIt+AhO72xfjxYBa6a+fpTdmWALXmre6fznR8TxZwWYWMZbjnckcUA==
Date: Mon, 24 Jun 2024 17:57:36 +0200
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: =?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <jpaulo.silvagoncalves@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Vaishnav Achath <vaishnav.a@ti.com>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, joao.goncalves@toradex.com
Subject: Re: [REGRESSION] spi: omap2-mcspi: not working with kernel v6.10
Message-ID: <ZnmXcNoPsPtjMuuF@louis-chauvet-laptop>
Mail-Followup-To: Linux regressions mailing list <regressions@lists.linux.dev>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <jpaulo.silvagoncalves@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Vaishnav Achath <vaishnav.a@ti.com>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, joao.goncalves@toradex.com
References: <20240612170030.3qatttsgrwjg2m5s@joaog-nb>
 <1b9852d1-4454-4f62-bd8a-fb6167dc0576@leemhuis.info>
 <20240617195358.v3ewnsu4jgkygvby@joaog-nb>
 <c11dc5f8-2638-40bf-b562-fa5cf8bf40fe@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c11dc5f8-2638-40bf-b562-fa5cf8bf40fe@leemhuis.info>
X-GND-Sasl: louis.chauvet@bootlin.com

Le 18/06/24 - 09:22, Linux regression tracking (Thorsten Leemhuis) a écrit :
> On 17.06.24 21:53, João Paulo Gonçalves wrote:
> > 
> > On Mon, Jun 17, 2024 at 11:29:05AM +0200, Thorsten Leemhuis wrote:
> >> In that case the thing that really
> >> helps would be if you could use a git bisection to find the change that
> >> causes this.
> > 
> > For me, spi stopped working in commit d153ff4056cb ("spi: omap2-mcspi:
> > Add support for MULTI-mode").
> 
> Hmmm, Louis (which already was in the CC) posted a patch with a Fixes:
> tag referencing that commit more than a month ago:
> 
> spi: omap2-mcspi: Ensure that CS is correctly asserted when switching
> from MULTI mode to SINGLE mode
> https://lore.kernel.org/all/20240506-fix-omap2-mcspi-v2-1-d9c77ba8b9c7@bootlin.com/
> 
> Unless I'm missing something, that patch did not make much progress
> since then. But I wonder if that might help. Louis? FWIW, this thread
> starts here with João problem description:
> https://lore.kernel.org/all/20240612170030.3qatttsgrwjg2m5s@joaog-nb/
> 
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.

Hello everyone,

First of all, sorry for the delay, I was sick last week.

Regarding the timeout problem, it is probably solved by [1], can you try 
this? I will send a v3 to apply Miquel's comments.

For the other problem (spi not asserted properly at the end of the 
message), I think I know how to solve it, I misunderstood the 
property cs_change (which doesn't have the same meaning for the last 
transfer). I will test it tomorrow and if it works I will send a patch.

Louis Chauvet

-- 
Louis Chauvet, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

