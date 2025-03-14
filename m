Return-Path: <linux-spi+bounces-7148-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B06CA6155C
	for <lists+linux-spi@lfdr.de>; Fri, 14 Mar 2025 16:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEFCE462D61
	for <lists+linux-spi@lfdr.de>; Fri, 14 Mar 2025 15:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6688D20298B;
	Fri, 14 Mar 2025 15:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AhM+irCx"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C8A202963;
	Fri, 14 Mar 2025 15:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741967586; cv=none; b=nM9TCSMxIDAOi66GLy2zR9Zhf6DzSwK6RwxSkNHzIYF9Fl9qQQ0PrVwDTHoi0Wcof+C4U8++5bNwOkDz/3jVsbzId7eV0UhObUrHUxC4Eqb8KvTWt0iJx/jPQcmqdKNBTvFB3hVceBHS+e1aPB8vud4uab8NGHDQJuPEOGpeLXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741967586; c=relaxed/simple;
	bh=J+7FE7jUtWw2AkNGj7vXJdveBzqHGNZ5nLZnbOlg8Bo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Kwvz+0JZit478aNS7QwIehfMb18kurYaSU8K5aH3rmHXVt0VxWVQzjCZLISFcElVTb8BEbWJm8vRZIn41vCwVaIsh9N4pWMrky7RYEsxgYaBI5DY0nhQdVyDipg9mtFNCTNZ5G8GPlHAqsgAywMjQP9skoYQ3JGcWeLuf4K+8JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AhM+irCx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EF52C4CEE9;
	Fri, 14 Mar 2025 15:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741967585;
	bh=J+7FE7jUtWw2AkNGj7vXJdveBzqHGNZ5nLZnbOlg8Bo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=AhM+irCxXAaEjDCeEZLxG5c1Ms7aTmmFS9d+PQYBHJkboKQeHpTrEnSFYuX5xKFHT
	 HVO+frw/2i/ZMZXfdKqzZvNCacLqc6RKivRZMMHX4zoMQZw1dTSmUzEqgGNIHKwBoW
	 EkHAixH4eX2mizir1ao0e3xCU/b3x2t/oal8NDHo/07cnfQh8P/cZrzaf6RqMD8BPb
	 HolwUOjg/7HnEu0FLCOS6K0fcioq8ad8F5in8+1Cf3G/jzACgzvRrd6DGGKnQcfmMo
	 8IWiAhMPdYjUlz5eYMttVMRpnO2gTuty6YCiCHtQCnPdZZ4RVnzqQ40D4K9m0hbj3S
	 HLawMom/GDLKw==
From: Mark Brown <broonie@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Liu Ying <victor.liu@nxp.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Maud Spierings <maudspierings@gocontroll.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
In-Reply-To: <20250226-initial_display-v2-0-23fafa130817@gocontroll.com>
References: <20250226-initial_display-v2-0-23fafa130817@gocontroll.com>
Subject: Re: (subset) [PATCH v2 00/12] arm64: dts: freescale: Add support
 for the GOcontroll Moduline Display
Message-Id: <174196758090.19958.7850853709519472369.b4-ty@kernel.org>
Date: Fri, 14 Mar 2025 15:53:00 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Wed, 26 Feb 2025 15:19:11 +0100, Maud Spierings wrote:
> Add inital support for 2 variants of the Moduline Display controller.
> This system is powered by the Ka-Ro Electronics tx8p-ml81 COM, which
> features an imx8mp SoC.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[02/12] dt-bindings: vendor-prefixes: add GOcontroll
        commit: 5f0d2de417166698c8eba433b696037ce04730da
[03/12] dt-bindings: connector: Add the GOcontroll Moduline module slot bindings
        commit: 43fd4d2f4f9df4ae1f6493d51cdd2687f325a225
[06/12] MAINTAINERS: add maintainer for the GOcontroll Moduline module slot
        commit: 8f1cc5242544052e4be037861abc8bc2b89cabda
[12/12] spi: spidev: Add an entry for the gocontroll moduline module slot
        commit: 10254a6c6073b0be171d434a3aeeff0256e59443

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


