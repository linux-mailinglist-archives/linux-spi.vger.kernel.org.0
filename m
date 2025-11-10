Return-Path: <linux-spi+bounces-11139-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBB4C453D5
	for <lists+linux-spi@lfdr.de>; Mon, 10 Nov 2025 08:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE6C03A9C6D
	for <lists+linux-spi@lfdr.de>; Mon, 10 Nov 2025 07:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B5A2EBBB2;
	Mon, 10 Nov 2025 07:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SkY1ybXw"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A11218AB0;
	Mon, 10 Nov 2025 07:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762760526; cv=none; b=cxRFnIkP6oWaACV4IvKuQM7mnmG0vg5rXeetNvLCy1r7Dp8tCLpD6EmClFIN4LPUrxIfzRyQhtyg+5EDpBC5dY3fbSOBqjVfyNC3ApnHFW5ZV8YBTjwCxpFJYd0wAPpyWxhhUZfmdH5rfGxif/v0TA75huy+WhL/XvQlve1qU9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762760526; c=relaxed/simple;
	bh=eoQpss3r6FYo/VoSTS5AtWz2fEfHuakzCuCNoTPYihE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Gknpk9+eShB4ukjLeSRkytqvAVF8Uoiug6Ot4IkH/dzhrjW+MPNXSALckh47IwzZBG+eW4kOTNsMUlKsh8fwIUQxhqbKjup0sITDg/69ajuBminYFd9N3Fx/FJ8zZHdnWiAbwAyj1eUHfbKLpT0juqXykohhyNRjd4KjJ/hdM2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SkY1ybXw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20230C116B1;
	Mon, 10 Nov 2025 07:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762760525;
	bh=eoQpss3r6FYo/VoSTS5AtWz2fEfHuakzCuCNoTPYihE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=SkY1ybXw4AE6CFT9Tnb2fjXUIAbi+gLXED5B4FtiMQLdokuofcghcxD+xY8/DB3dJ
	 RsFOoMuXNQq3d5SOBbdv5jiaHYA5OLCtdNUvt1z1m1Cfg0fR6V8suAOhTd7pG+PJlt
	 mgyglzWBw2jENzcWsjico9PyLr+Y+XkjC7+xTM9+tplbMS+EV9IAIe56PThbWWCukY
	 2dSGCF9Ip5CDKH+ldtwdtxsvV8pavZqjVHWAST1KoYe7bzXRRpYAvYCUY/8Y7iMYpx
	 z/6yPHa9cE79YCuAb2g/xvHnjCKsj4bj9ba/mmWaFKT0WkrJS/k1D54JNUOK67LcBG
	 HHreGSjFECDgA==
From: Srinivas Kandagatla <srini@kernel.org>
To: devicetree@vger.kernel.org, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Chen-Yu Tsai <wens@csie.org>, Conor Dooley <conor+dt@kernel.org>, 
 Fabio Estevam <festevam@gmail.com>, 
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>, 
 Gatien Chevallier <gatien.chevallier@foss.st.com>, imx@lists.linux.dev, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org, 
 linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org, 
 linux-spi@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-sunxi@lists.linux.dev, Liu Ying <victor.liu@nxp.com>, 
 Mark Brown <broonie@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Maxime Ripard <mripard@kernel.org>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Rob Herring <robh@kernel.org>, Samuel Holland <samuel@sholland.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>
In-Reply-To: <20251020060951.30776-6-wsa+renesas@sang-engineering.com>
References: <20251020060951.30776-6-wsa+renesas@sang-engineering.com>
Subject: Re: (subset) [PATCH 0/4] dt-bindings: treewide: don't check node
 names
Message-Id: <176276050899.18134.7729831344719556570.b4-ty@kernel.org>
Date: Mon, 10 Nov 2025 07:41:48 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Mon, 20 Oct 2025 08:09:49 +0200, Wolfram Sang wrote:
> Node names are already and properly checked by the core schema. No need
> to do it again.
> 
> These are all occurrences I found in linux-next as of 20251015. I did
> run dt_bindings_check successfully. I haven't done a way to run
> dtbs_check yet because I would need to identify the proper architecture
> first, right? Is there some tool which tests all DTs of a certain
> binding? At least build bot is happy, I don't know if it checks DTs as
> well, though.
> 
> [...]

Applied, thanks!

[2/4] dt-bindings: nvmem: don't check node names
      commit: 65c1bc002b27d1ac398e37ce031a45d59999cb13

Best regards,
-- 
Srinivas Kandagatla <srini@kernel.org>


