Return-Path: <linux-spi+bounces-9375-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B4DB228DF
	for <lists+linux-spi@lfdr.de>; Tue, 12 Aug 2025 15:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1090456136C
	for <lists+linux-spi@lfdr.de>; Tue, 12 Aug 2025 13:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB60285042;
	Tue, 12 Aug 2025 13:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lb/sRMoH"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F4828507F;
	Tue, 12 Aug 2025 13:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755005494; cv=none; b=r6I4n3G5n3r5DEmsFj/eduJUBBU9NSAic3k2Ad3y6F6J7U8hF5rmSJq71MKu4fU2eCMDyFiQuTi7Ly+pRM+dCiQoxI7N9BFeggqSZHR/UUvwoN08HSvo5rIjYtuwftL1rywyKkobTKz6Jju0jSpJV5kAyKAC2b0Dup5QFk2cdJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755005494; c=relaxed/simple;
	bh=K8lzBB9/Bh3jP/7LMg8a5TAR/9M1qucruuqKpFB7wz4=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GMJ8d5d7zqBhF1AGXLYdEcruk2MbHQxhJl1yUs1NL1SeEEsN7YYyDqOMMzLkTubrX60VSFeUIV2BkEM384s6tziG2b0J/U0eziisZ6CUbAGmYAdxdAEbwsiQ9k3AUGj+NL6ACUbfvd3SpYgq9I0MsoyJLTB/13J468bTAJKGM5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lb/sRMoH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2481C4CEF0;
	Tue, 12 Aug 2025 13:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755005493;
	bh=K8lzBB9/Bh3jP/7LMg8a5TAR/9M1qucruuqKpFB7wz4=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=lb/sRMoHaDv+Vq/LarNyxaysxQc7MLWzPtxUuJtQ+k5oOp6r3aRjDQ1WpShIRb0Lh
	 ngC4YYsw/g7XBY6A/CXs/GUkpBsz5/F/be3+bDMRlDiEx9gliV/nK1W/qJMaQNzStX
	 P2taRk5Wn6j2d9r4okncraoZiSDbJbn4LUq7MOrEUJp8IDmtkxcS5M8Y70LSK18QCz
	 Vw9PMvUcl2hDohXiOOVuImNHE0IIAd9dxuaLMS/HpMmYTfXRPESZ47zxTJ+jmQWds1
	 AaWzV0LkBtoMOgmRS53eEuxJWmStnut1B6VOGzfsccOhwPzyki0A83e/SI46jDtb3N
	 0baqdca9yYL2w==
From: Mark Brown <broonie@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Martin Sperl <kernel@martin.sperl.org>, Chuanhong Guo <gch981213@gmail.com>, 
 linux-spi@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, Liao Yuanhong <liaoyuanhong@vivo.com>
In-Reply-To: <20250812033817.487565-1-liaoyuanhong@vivo.com>
References: <20250812033817.487565-1-liaoyuanhong@vivo.com>
Subject: Re: [PATCH 0/2] spi: Remove redundant semicolons
Message-Id: <175500549067.70594.14172853876781002627.b4-ty@kernel.org>
Date: Tue, 12 Aug 2025 14:31:30 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Tue, 12 Aug 2025 11:38:15 +0800, Liao Yuanhong wrote:
> Clean up the code by removing redundant semicolons.
> 
> Liao Yuanhong (2):
>   spi: bcm2835: Remove redundant semicolons
>   spi: mtk-snfi: Remove redundant semicolons
> 
> drivers/spi/spi-bcm2835.c  | 2 +-
>  drivers/spi/spi-mtk-snfi.c | 1 -
>  2 files changed, 1 insertion(+), 2 deletions(-)
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: bcm2835: Remove redundant semicolons
      commit: 0ecc0e17f05bbb953b6ea3812e78bab224f08595
[2/2] spi: mtk-snfi: Remove redundant semicolons
      commit: 528a813a5d98702cc6fd51983484cf7eec9ebcac

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


