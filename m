Return-Path: <linux-spi+bounces-8217-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3BBABD5D5
	for <lists+linux-spi@lfdr.de>; Tue, 20 May 2025 13:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFBF21B60540
	for <lists+linux-spi@lfdr.de>; Tue, 20 May 2025 11:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F2E26E14C;
	Tue, 20 May 2025 11:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gdQMgIOp"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B610826738B;
	Tue, 20 May 2025 11:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747739136; cv=none; b=VWGj80oIxwG7EJOIvRKJBrmCQj22DZSY6SyigJx7VtPgqPjKlsidc5LLhJpi5wQST7S/X7P/WXy/EQWfghwt4sIlMs+xRIEL8w43ZLLHuyCdGtB0as4o4uXU4lhHTcwj/qFwRkp79PKiKj3lzTbAdk3tfufC5tUCIcpRP9VNwzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747739136; c=relaxed/simple;
	bh=moJr557cLpcwfssxs4X6NO0Ta6elVHfYr4Rk4IzgEJU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iFwnfuvF6jsA9ZHPx0kcCdmLVYs8I8RhHR1AzxyoOUYrRWb44VVhek/PIamL+oVLPPK++1u1hFsEdyKTQFl+houEa3LYlKtcSl8Df5IaRBDJs1RHnaj+mYbQXIGuPUfUbfjN0W388Qx6ivqCoaPu0SawkciA65eSXYGSSS3aoBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gdQMgIOp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9A50C4CEEB;
	Tue, 20 May 2025 11:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747739136;
	bh=moJr557cLpcwfssxs4X6NO0Ta6elVHfYr4Rk4IzgEJU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=gdQMgIOpmMAyWGmvCDjPOQwDXR6RGsVp36+EM0AsuL7GUQLpbVcRPWQlUbaIWa0xE
	 x/7t3Yg+5cocNnBgvaVsz6VX+wxW4BuQO/kya5ZHuC+ocHQ1q/fOm4goHCUkxjwE3q
	 bgk78ESVWn28w1RR7vpv6QqF7pnjSmRKbKmO3f6wPx8bU4Hx0brmiRcsamyE9/v8ax
	 4XeOtaSHg9ThOy3/AZ64q3Cxj1cHBVvXsjYYZOYQJ8YdfCJyK8w5xFeayg2zqGKjws
	 BWmCfqV030Bpdi93s2LoSeE40cJ0VZBTNaFlwNDWsFJe1vDMZD4X3Iq+lM87ZZIxZT
	 s4gP7/4RUCVIw==
From: Mark Brown <broonie@kernel.org>
To: Raju Rangoju <Raju.Rangoju@amd.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 krishnamoorthi.m@amd.com, akshata.mukundshetty@amd.com
In-Reply-To: <20250516100658.585654-1-Raju.Rangoju@amd.com>
References: <20250516100658.585654-1-Raju.Rangoju@amd.com>
Subject: Re: [PATCH v2 0/3] spi: spi_amd: Add DMA write and Kconfig changes
Message-Id: <174773913545.45044.805296108345217999.b4-ty@kernel.org>
Date: Tue, 20 May 2025 12:05:35 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Fri, 16 May 2025 15:36:55 +0530, Raju Rangoju wrote:
> This series include following changes to spi_amd driver:
> - Changes to replace read{q,b} functions with direct memory copy logic on
>   DMA buffer.
> - Support for HID2 DMA single mode basic write operation for the HID2
>   SPI controller.
> - Changes to add missing Kconfig dependencies.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: spi_amd: Remove read{q,b} usage on DMA buffer
      commit: 8cd079e69dc51e707b0a7ce105b01f6dbb66ddc1
[2/3] spi: spi_amd: Add HIDDMA basic write support
      commit: a5733666c775eb852409261d7a6363883d97ff93
[3/3] spi: spi_amd: Update Kconfig dependencies
      commit: dbb79974193a2932e828ebbd216efb428c81dc63

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


