Return-Path: <linux-spi+bounces-10764-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 717F8BF826C
	for <lists+linux-spi@lfdr.de>; Tue, 21 Oct 2025 20:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA0E2541631
	for <lists+linux-spi@lfdr.de>; Tue, 21 Oct 2025 18:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628C734FF71;
	Tue, 21 Oct 2025 18:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F411smwq"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2985334A3D4;
	Tue, 21 Oct 2025 18:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761072742; cv=none; b=Rx3KgA1aWeZ4/OG0xt62N/eGAjai7F3wxEJhWNwfU7htKM3bXA6CLmOh9AGvz7+vIjKMeYHE3GV+HvjdIHjyz1g0WAkYiGqoafR+ysJEmZxc8yI5tfZczybpRSnXuVRLJG7Bt/ds7H8toy165pV3BBOsBXvHb06eyxnY1Lc1k3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761072742; c=relaxed/simple;
	bh=/CjlmkvSVehb9uKQ22ITRCOwatYs4Z+DyN9C4O9799g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Mxb1X7JRuY5nNUPbvvk26lWAZPpnkMN/eZjW0tYjJEPWCKw5Eob7xEsJyPKCikckBifEM7fL8Xk1gp3WZSxi1Zv6oPWN7VIHdHswCVJ/cWOG2dLAM2nlwl5tgt3o7TBLMhWrQjxFkcQHrW+KlbExrU/15r9PY+8ZNgM0fQik8lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F411smwq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAADFC4CEF5;
	Tue, 21 Oct 2025 18:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761072739;
	bh=/CjlmkvSVehb9uKQ22ITRCOwatYs4Z+DyN9C4O9799g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=F411smwqWcOG0d2J5NZJxXys/QHFqMqfadrXHqCOrLNcMA8WW8cRWSk5m/BcXF9zx
	 jZCozPqw0LLbKMe9Xg/7Q/5qNkvpUcFxLmVtHtolTatemNDXN1nSJTjrUI9VuvXwq7
	 WKFwmr+7x/pp0G6AK4RBsvqGwJnVh2cymY/fGszwyWytaKA9KDj4sVfS+KG78BgSZY
	 bcEELUX1vIfLE0lvoGBje+ts88QjDTQ9wZrrgDSKAnoSPNtxc3GvyBNpQxBQo8hSIt
	 06Xj4Zp0li6SsLoBTKYt5YN1COKgyPPPWPNwy3+TOWEwT4Yde6TiJdiW4MfOXFPNpO
	 KQR4u8ujsV9Eg==
From: Mark Brown <broonie@kernel.org>
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
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Maxime Ripard <mripard@kernel.org>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Rob Herring <robh@kernel.org>, Samuel Holland <samuel@sholland.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, 
 Srinivas Kandagatla <srini@kernel.org>
In-Reply-To: <20251020060951.30776-6-wsa+renesas@sang-engineering.com>
References: <20251020060951.30776-6-wsa+renesas@sang-engineering.com>
Subject: Re: (subset) [PATCH 0/4] dt-bindings: treewide: don't check node
 names
Message-Id: <176107273462.196841.10566474992325623883.b4-ty@kernel.org>
Date: Tue, 21 Oct 2025 19:52:14 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-2a268

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

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[3/4] ASoC: dt-bindings: don't check node names
      commit: 6a4f29bc66294d44d61a294e5bdc623eae74587b

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark


