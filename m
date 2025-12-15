Return-Path: <linux-spi+bounces-11894-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 05EB8CBE9C7
	for <lists+linux-spi@lfdr.de>; Mon, 15 Dec 2025 16:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E29D309191E
	for <lists+linux-spi@lfdr.de>; Mon, 15 Dec 2025 15:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33EDD33120F;
	Mon, 15 Dec 2025 13:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OdV9YeSs"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EB0331202;
	Mon, 15 Dec 2025 13:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765807169; cv=none; b=pASUxFxdXLkhDp+pSUYH2KONQbBiFh+iZT/Yc0Rt9x6xmLwzhhfsbXJzddOnNXTHanJFZQHbjDehez83BDVS94js3M+dJcucmVcqjsneMM6Ywi5missIMkuES6F0CFEJ98bMB3Rmo0+iQukhDnY/C+0vcX0QNjQ2n9LAmgEyUcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765807169; c=relaxed/simple;
	bh=cfJDm4wYiGitWnngtHNxkthZHqnlQgjzwLU69mBly90=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HvxX6lnMYMtzQt2GSYuo8JVhhiHPsAkxGzmUruQkV/NIf17i+N3Oa6lBpNa4IaOzbwTroitBr01lmihu779vKaOcUDpAcXlpDX9jRL0s+/2TJsnerSfbuduUAl8+BdI7RQLPPl9039tDqPYBbroVzLRpzeTC219HEscKfKbAvsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OdV9YeSs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEE3BC4CEF5;
	Mon, 15 Dec 2025 13:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765807167;
	bh=cfJDm4wYiGitWnngtHNxkthZHqnlQgjzwLU69mBly90=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=OdV9YeSsdQmu7/bQcVmD8XlVXOq3y/rwXUDJUbHHLgin2Oo8ssgtvwDFQ9n1/6Fjd
	 AKc1xgWoASmNyybhSks9k6oDzfiiaj8iy8Y9uLuDbpmf0wWJ/nWT5PQfq7XlCfP1rG
	 vae+9jtWehpPHxlLiX4Y46vVMfZoO/+560L0Yhof29O3RYHURNzDsl4EXv/Kcg8e0T
	 TGTXx30ZWIfvhJPusm7xLeuV5/o3G8cthFfb7NGf+jUnd/IBHU9xCI95psT4oTqJjr
	 ZfLJw7hivwWdRJlLyB9oUGBwmFTBl3X36/NFj7HTJr2OR8NbBt7CcHbO1rV4CUB5Rr
	 6QuvKgv7j2haQ==
From: Mark Brown <broonie@kernel.org>
To: frank.li@nxp.com, mkl@pengutronix.de, shawnguo@kernel.org, 
 s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
 kees@kernel.org, gustavoars@kernel.org, Carlos Song <carlos.song@nxp.com>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org
In-Reply-To: <20251203085949.2922166-1-carlos.song@nxp.com>
References: <20251203085949.2922166-1-carlos.song@nxp.com>
Subject: Re: [PATCH v3 0/6] Support ECSPI dynamic burst feature for DMA
 mode
Message-Id: <176580716540.161463.10558713364568567703.b4-ty@kernel.org>
Date: Mon, 15 Dec 2025 22:59:25 +0900
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773

On Wed, 03 Dec 2025 16:59:43 +0800, Carlos Song wrote:
> ECSPI has a low throughput because of no dynamic burst support, it
> transfers only one word per frame in DMA mode, causing SCLK stalls
> between words due to BURST_LENGTH updates.
> 
> This patch set is to support ECSPI dynamic burst feature to help improve
> the ECSPI DMA mode performance.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/6] spi: imx: group spi_imx_dma_configure() with spi_imx_dma_transfer()
      commit: c64f62b036aed30626cb30fa82d3ec4a13fa83df
[2/6] spi: imx: introduce helper to clear DMA mode logic
      commit: 5395bb7f7c361310d0f329c8169d2190809b05c1
[3/6] spi: imx: avoid dmaengine_terminate_all() on TX prep failure
      commit: a5f298581d454c5ea77c5fb6f4ee1bff61eb2b2c
[4/6] spi: imx: handle DMA submission errors with dma_submit_error()
      commit: a450c8b77f929f5f9f5236861761a8c5cab22023
[5/6] spi: imx: support dynamic burst length for ECSPI DMA mode
      commit: faa8e404ad8e686cb98c51dc507fdcacfb8020ce
[6/6] spi: imx: enable DMA mode for target operation
      commit: ba9b28652c75b07383e267328f1759195d5430f7

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


