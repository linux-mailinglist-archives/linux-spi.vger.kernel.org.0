Return-Path: <linux-spi+bounces-3581-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5803F916FED
	for <lists+linux-spi@lfdr.de>; Tue, 25 Jun 2024 20:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00BE21F21D18
	for <lists+linux-spi@lfdr.de>; Tue, 25 Jun 2024 18:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C0D179972;
	Tue, 25 Jun 2024 18:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fAA7IUYc"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E301179967
	for <linux-spi@vger.kernel.org>; Tue, 25 Jun 2024 18:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719339156; cv=none; b=CX6VsK837Fo4R1p2zEWjqc/zfzkXVE7YwsQbaDr6xarQ52sBzazbkATFpcIERvzooUBLAkxKrGXljI8FRJCxD/gtReBxDlOc7BFxtgQyW83s0GqDyez0LBUC4to3vIYa+s7wnfjUnPBmGOGAe03MoJHFbxeldIG8L8AFgfHdnJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719339156; c=relaxed/simple;
	bh=o9bvOySEP9nS2PUlj7rOfSDk+4nM2ywpbxR+tw1czjQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZDDj+7rvGb9l545hd/q1D3yEcQOVhqOm4/cGS+CYo3zp1c4JI7iuQa8mkKBo2n6Rp0ImyDT+GybzIEDl45Z3AleHcu6gTXjkYFEEtMhzQgyLF/DiVtyUPk+yL1f1HU19+C7aMU+jvie2RUz4Y73z17H/WbR/h/E8Wxm5IDDwnkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fAA7IUYc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0832BC32781;
	Tue, 25 Jun 2024 18:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719339155;
	bh=o9bvOySEP9nS2PUlj7rOfSDk+4nM2ywpbxR+tw1czjQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=fAA7IUYcgRrXlbQB2XXPdyxlmsexdMQ6G2eHSXibJJ4iqpRv2TWDCZa8Y+eS8jbyJ
	 gulcyQrMe1Toq3alvDPS6J12XkynZczEzrK3irexSpAj0pG6aZJLmTeRV2q9mVyKb9
	 1ZoX0ShyqzM31KHYhaarYBQivEkTQRhSnMlY9yDAvannhQiT9Ojm0CvZCYN10WIglq
	 4Ag84oUDnoxHXBCUjBD2Q/vataLzybRe8jnBB1XjZ1WOcrF6xU0xLwKQGORFmIw8Vx
	 fIia5KFI0fccH8NPWPLmIEs24+x6HNBH9WRo9qQVq98O9avhFih3C0F+MDapgs/U0O
	 brrhvzfHpUizg==
From: Mark Brown <broonie@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-spi@vger.kernel.org, Fabio Estevam <festevam@denx.de>
In-Reply-To: <20240625002023.228235-1-festevam@gmail.com>
References: <20240625002023.228235-1-festevam@gmail.com>
Subject: Re: [PATCH 1/2] spi: spi-imx: Switch to
 RUNTIME_PM_OPS/SYSTEM_SLEEP_PM_OPS()
Message-Id: <171933915475.1078311.10439532819634651237.b4-ty@kernel.org>
Date: Tue, 25 Jun 2024 19:12:34 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Mon, 24 Jun 2024 21:20:22 -0300, Fabio Estevam wrote:
> Replace SET_RUNTIME_PM_OPS()/SET SYSTEM_SLEEP_PM_OPS() with their modern
> RUNTIME_PM_OPS() and SYSTEM_SLEEP_PM_OPS() alternatives.
> 
> The combined usage of pm_ptr() and RUNTIME_PM_OPS/SYSTEM_SLEEP_PM_OPS()
> allows the compiler to evaluate if the runtime suspend/resume() functions
> are used at build time or are simply dead code.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: spi-imx: Switch to RUNTIME_PM_OPS/SYSTEM_SLEEP_PM_OPS()
      commit: a93f089ccf823dcb9cf678969e127047762a1473
[2/2] spi: spi-fsl-lpspi: Switch to SYSTEM_SLEEP_PM_OPS()
      commit: 6765e859fac9acdc1265b6f16ed33f42317ed30e

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


