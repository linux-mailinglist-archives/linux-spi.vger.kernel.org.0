Return-Path: <linux-spi+bounces-10235-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF77EB95A1A
	for <lists+linux-spi@lfdr.de>; Tue, 23 Sep 2025 13:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90DA77ADB23
	for <lists+linux-spi@lfdr.de>; Tue, 23 Sep 2025 11:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270A83218DA;
	Tue, 23 Sep 2025 11:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tw5vRHUX"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7B43218CD;
	Tue, 23 Sep 2025 11:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758626723; cv=none; b=R0u9jTUm8wM811dlI1+Ctz+uM6TBUGlpK9XlTul2ITGPTRtcA+hI9ck5jfQIjs3ZCve4IOlCrn/kC7HwOZa+OCAUZAcL2FPVTcRZL1FuEmd6q9cOnEl49TyrYvbneB9ZqAtpQ9zSg7bh2hd6LObociGNU65w3GsMTxmWLVZefH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758626723; c=relaxed/simple;
	bh=ckJ5qrBoifVEYYEnucY/QAUXxf4QBtucPxuic3k1dv4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nyiOXKhd0GzrIkesPVBi0aNTx5l/7gSiCXsoHMvBYSt4/jQsaFhnhQEUGTcQBgAd5sv5UpiUOJKxsf7p/R20NSvLIWEivbzEhkMun3bx48Lq4gKEoQWxskI6b5Okph6x+FKLZVwSopiU8EojO7PS2hkqAzB5W+azRon1Z5xqThw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tw5vRHUX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64AFEC4CEF5;
	Tue, 23 Sep 2025 11:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758626722;
	bh=ckJ5qrBoifVEYYEnucY/QAUXxf4QBtucPxuic3k1dv4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Tw5vRHUXdFDU8DE8VAuy+szMTcud744f9aKS2tnAkSnzsTBF2qAB9HHYv1hyuFVWt
	 yKuHAb1JFLhFWXpSK6AicDW2oiyTpi4/XTZ/FWkiJLtNq05kB15JNaOSJTctQ5R93m
	 JBis/8AzzRBA2wNAVjXq8WuNUek1XTRITPd1eDktwK3OWqYDOskaF6wZWpFCWT4LEi
	 gJtEOVy/ryB3+aZTkDPYB+NNi8r60ZQQj/srteq/U/wCncSsyl+FHkv43uuEOW1JPT
	 3YcZQFNa8veYDdkGylh/+FJ+3Wa+aJxEJUbgA95V3Ljsj215ziHUI/Zpnci4VlRgSv
	 Ese+ibn4AnzEA==
From: Mark Brown <broonie@kernel.org>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Biju Das <biju.das.au@gmail.com>, linux-renesas-soc@vger.kernel.org
In-Reply-To: <20250921112649.104516-1-biju.das.jz@bp.renesas.com>
References: <20250921112649.104516-1-biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 0/2] spi: rpc-if: Add resume support for RZ/G3E
Message-Id: <175862672007.1039628.355731344831251638.b4-ty@kernel.org>
Date: Tue, 23 Sep 2025 13:25:20 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a9b2a

On Sun, 21 Sep 2025 12:26:44 +0100, Biju Das wrote:
> On RZ/G3E using PSCI, s2ram powers down the SoC. After resume,
> reinitialize the hardware for SPI operations.
> 
> Also Replace the macro SIMPLE_DEV_PM_OPS->DEFINE_SIMPLE_DEV_PM_OPS macro
> and use pm_sleep_ptr(). This lets us drop the check for CONFIG_PM_SLEEP
> and __maybe_unused attribute from PM functions.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: rpc-if: Drop deprecated SIMPLE_DEV_PM_OPS
      commit: 81ef2022b311c7c4f29011f778442635acfaba90
[2/2] spi: rpc-if: Add resume support for RZ/G3E
      commit: 2bfb20b65d9bc1d0de58f8c28ca9d6f1d27bbc01

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


