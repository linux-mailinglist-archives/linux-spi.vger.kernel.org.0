Return-Path: <linux-spi+bounces-7772-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A0BA9D5F7
	for <lists+linux-spi@lfdr.de>; Sat, 26 Apr 2025 01:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D936A7AF763
	for <lists+linux-spi@lfdr.de>; Fri, 25 Apr 2025 22:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E45242D80;
	Fri, 25 Apr 2025 23:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BTLOmcjZ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3543D21770C;
	Fri, 25 Apr 2025 23:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745622007; cv=none; b=J9WbRka57vl4qF5GO2MqsNG6FHqatYpDfRtwrInGRsKG2H55yLURPV6lPFsEm5t/Rfqqo7nXAsiHzLoSpnCFigvzNiEnZmn6VZep4Ih1cDE2/emg33/M1HVJZILD3h3AcmNZe+Dly5ZUI2kZ1BfVA66rWAQifwBVDcQfOS9Kcd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745622007; c=relaxed/simple;
	bh=/bRJ1TosTwWc07Gu44FOUKRyH9x1FUl0wV2GXEtu9Bw=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=aMtnYmaiDZnJr1zSrH7DdznF/xh1mOfNi7cUbuIBF1PaU/Y9UMShybet9HNxasgYI/U8ZrBcpQf2oYExvCWbFIlMRUmFq0dAIOCsfDt4wUOQmU9rEEyZqlp1pB5iClJiAMRin4CMp4eTLnDnZssUrvRfmpIjNzVOJsTOvg9MAXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BTLOmcjZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A96D0C4CEE4;
	Fri, 25 Apr 2025 23:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745622006;
	bh=/bRJ1TosTwWc07Gu44FOUKRyH9x1FUl0wV2GXEtu9Bw=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=BTLOmcjZdXzEn8z5qOerh47Ehfu3VX9yrQ3lbcY7KFxeU8+Z8rci7MVHhRfaTLRKO
	 mHxaElLVaMHz+sOIMvA7OEbIjdzRiI/IJxnKb7qKaNwJqLokd8O3otoPlPhJgOeOgd
	 bwFHs8AP89LwLAnQbAlJxoAzrPZE4tV6n1LaDQTkln21uY0Sg64b/NB9B0hTAyDKIy
	 lnngbK2IkEIi8t+eSn19bX2HwCvWmLRDkxBz3sqfsPfdBWnSMiiDyt/iaOL1UR4hKT
	 VeRoIZWxntPc0/Qi8Z/tLNGPTBolQiFsqLYqHj6LwRIeHJLZnozofzW5p09eqFZcyY
	 4pbybWu78T2wA==
From: Mark Brown <broonie@kernel.org>
To: thierry.reding@gmail.com, jonathanh@nvidia.com, skomatineni@nvidia.com, 
 ldewangan@nvidia.com, linux-spi@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kyarlagadda@nvidia.com, smangipudi@nvidia.com, Vishwaroop A <va@nvidia.com>
In-Reply-To: <20250416110606.2737315-1-va@nvidia.com>
References: <20250416110606.2737315-1-va@nvidia.com>
Subject: Re: (subset) [PATCH v3 0/6] Configure Clocks, Add Internal DMA
 support
Message-Id: <174562200441.302167.12352642386794751784.b4-ty@kernel.org>
Date: Sat, 26 Apr 2025 00:00:04 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Wed, 16 Apr 2025 11:06:00 +0000, Vishwaroop A wrote:
> This series introduces QSPI clock configuration and internal DMA
> support for Quad SPI controller. The patches have been reorganized
> for better logical flow and review comments from v2 have been addressed.
> 
> Vishwaroop A (6):
>   spi: tegra210-quad: Fix X1_X2_X4 encoding and support x4 transfers
>   spi: tegra210-quad: remove redundant error handling code
>   spi: tegra210-quad: modify chip select (CS) deactivation
>   arm64: tegra: Configure QSPI clocks and add DMA
>   spi: tegra210-quad: Update dummy sequence configuration
>   spi: tegra210-quad: Add support for internal DMA
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/6] spi: tegra210-quad: Fix X1_X2_X4 encoding and support x4 transfers
      commit: dcb06c638a1174008a985849fa30fc0da7d08904
[2/6] spi: tegra210-quad: remove redundant error handling code
      commit: 400d9f1a27cc2fceabdb1ed93eaf0b89b6d32ba5
[3/6] spi: tegra210-quad: modify chip select (CS) deactivation
      commit: d8966b65413390d1b5b706886987caac05fbe024
[5/6] spi: tegra210-quad: Update dummy sequence configuration
      commit: c283fcdc4e2b89678c171691fd26f576139fc256
[6/6] spi: tegra210-quad: Add support for internal DMA
      (no commit info)

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


