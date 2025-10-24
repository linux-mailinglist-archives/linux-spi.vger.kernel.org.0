Return-Path: <linux-spi+bounces-10818-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7E1C0590D
	for <lists+linux-spi@lfdr.de>; Fri, 24 Oct 2025 12:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CF4C3B9D96
	for <lists+linux-spi@lfdr.de>; Fri, 24 Oct 2025 10:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00B530F957;
	Fri, 24 Oct 2025 10:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MRDUWkaZ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D4C2F7AD3;
	Fri, 24 Oct 2025 10:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761301453; cv=none; b=RQL8QelSMOgtimfS0ChdWCzPWUZDa28CqEWKPfngrmaC3Z5LuM2h5BPSXmWOWpRpKJuHh2jv0cBnrX7JJptNEkHjGft2DecWmjNXfDhBJulhFSl79QvfxX2x9IbB71XAF8Pkpa74uQxiqjirq7pHKmkaGpfJTq56zlOD9qzwf9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761301453; c=relaxed/simple;
	bh=mP6SmCP7woCF8wcDSk+2F5q73XTTlR0r8Zgwb35TMho=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ALNR76p0rFL7+2PyeE5hziCazx/4Lre4vgZ9rllLOnAEbw4FbQKcOFvNaI/QyR+TzQO0CtKMugI36O5VN4ESnRq4A5nGWSTVsVP3yQIFUL/P4n91I6uLd1AvUSlyqJ8nOw729cpUtwJw6zqfWXEOb00oFrY2nwuKcYN9uyHBbRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MRDUWkaZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AE23C4CEF1;
	Fri, 24 Oct 2025 10:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761301453;
	bh=mP6SmCP7woCF8wcDSk+2F5q73XTTlR0r8Zgwb35TMho=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=MRDUWkaZavqJ8zqtZrN8TV+fbecejBQ6lfljI8HBEI5ozMc9cDeHm+Imy9BNGtmbi
	 QvJmOk1jPfARrhjR8RcuhKHZxCcArwZDFjKtKBaYI278DpExcwQ8RGurp0lq7oN9TE
	 alfagv9VzcQSzlK/WJr3FjD30zNCda9PiX1xPHIfwZTspN0mgnUdZmvEQC5njCWZYQ
	 5gLINhyXbo8FRwx+doWTZz4Kem6Gca+vhAGY0cZxFyDGwAkBmObRim4YtjI1hRTD3f
	 LxTbFtFnHYLDx7Fpz1kSeVyb54KMoqacr8w35rBTpSIzvicn9kZO1zPmpZk4xJctu7
	 G61H8R3sQwZsw==
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
Message-Id: <176130144489.10577.5538260652511597774.b4-ty@kernel.org>
Date: Fri, 24 Oct 2025 11:24:04 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-88d78

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

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[4/4] dt-bindings: spi: don't check node names
      commit: 7c69694cec869e3bf7c810fd94f860253aeb8053

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


