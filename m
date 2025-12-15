Return-Path: <linux-spi+bounces-11892-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 442F9CBEDEF
	for <lists+linux-spi@lfdr.de>; Mon, 15 Dec 2025 17:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09730302AB8D
	for <lists+linux-spi@lfdr.de>; Mon, 15 Dec 2025 16:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69FA330B37;
	Mon, 15 Dec 2025 13:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oFEXrMMp"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E5B330B2D;
	Mon, 15 Dec 2025 13:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765807165; cv=none; b=KbCx/2iqIBxjt/Afujl0TTuxnDOMNoo+A3pwA9EsKG9ePLtOOxHjtch9ST3NBhzfg2PTe6dU0lxtsCykbhOv15X0PfO1YiKuu2/62fu2sgVAODBhrEVrhvPK/ZYiPr3HdkunyM2YcN4WoHT1IBRZ/EBsdWtXPBobxC9WCzSA0tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765807165; c=relaxed/simple;
	bh=JITlun+LUxfRZs2r1MFqhuMlKLc42EgEPR3agL6aR7s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qzUEcGkHDO2QpsZ0tmVKFzTuk/+hwd9Bz6LwHsaeMC+XEvvQ/FdeReJBVlosZrYqcqqARepr/TzS+VHJA3KS2pqKoboPAPj7TRFM1ZRMmC++b3QAP5GutjS0nUlTJy5FqqbQS7+EPhuIJN3I6STOeElRxIs4cMuw6PQAN+TR9RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oFEXrMMp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A386C4CEFB;
	Mon, 15 Dec 2025 13:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765807165;
	bh=JITlun+LUxfRZs2r1MFqhuMlKLc42EgEPR3agL6aR7s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=oFEXrMMpeRORmI9dPoX79JDKsQD7TGn9JkW7QuEgnobHYeWJXj1VLD3iQV9vjkBxj
	 JPo5OCU2EGs7EpSVQlSehcdPF/TnDVLXrCPWbs2iOoKPwDTOZrPi+DajEznhS3bR8p
	 UlUSTfBoH9Uv73Uy6OvDHaJmYCy2r5XTY69qchLIf22xpAkgeYsYPxeFKFMYjAkByR
	 Aa7eKiEd5DhEDTsciXgcEv8j3S2ReF1gW6wbP2seqvj3Hc+TPriS9BvO1SQfDXvS4a
	 /ukIlaeMNUl27NEDg2UyipbQW577TdNIlGr6lu3bo6X89bhRqKoM3+71YEmbLHlxge
	 enr/skcKpjwNQ==
From: Mark Brown <broonie@kernel.org>
To: frank.li@nxp.com, mkl@pengutronix.de, shawnguo@kernel.org, 
 s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
 kees@kernel.org, gustavoars@kernel.org, Carlos Song <carlos.song@nxp.com>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-hardening@vger.kernel.org
In-Reply-To: <20251202075503.2448339-1-carlos.song@nxp.com>
References: <20251202075503.2448339-1-carlos.song@nxp.com>
Subject: Re: [PATCH v2 0/6] Support ECSPI dynamic burst feature for DMA
 mode
Message-Id: <176580716285.161463.10166271924842509723.b4-ty@kernel.org>
Date: Mon, 15 Dec 2025 22:59:22 +0900
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773

On Tue, 02 Dec 2025 15:54:57 +0800, Carlos Song wrote:
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


