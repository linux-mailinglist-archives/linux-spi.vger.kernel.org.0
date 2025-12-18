Return-Path: <linux-spi+bounces-11995-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F930CCAB23
	for <lists+linux-spi@lfdr.de>; Thu, 18 Dec 2025 08:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BFB413019BD2
	for <lists+linux-spi@lfdr.de>; Thu, 18 Dec 2025 07:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964652DA76F;
	Thu, 18 Dec 2025 07:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kcN6a30L"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC40263F34;
	Thu, 18 Dec 2025 07:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766043409; cv=none; b=CRliT9vcQibk9g/CHJLmkIB3aOMg2iBTQJsMO/1RdlMLy/fpZZoZPmRhuUGHRo560blHgNFH++ChT55FgvfwpU5CQiXcDiN1P7s32apIn+/g89zmahdxr/RfTYNLj+KCpqX/jRHZwkyAybSMcfjw63hK10UDzkejbSpQJ3VMQX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766043409; c=relaxed/simple;
	bh=Myo3pfKSHU9k4vKcvA+AYZGJnvyzp12VBtwF9l+GFXg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mmMWC3XfbOjrPwSQpu9EbKMVq6AR4Akg1piihKc7i699f6h9hx07IVc+DKZ8S/E/9SD11swOPxjqscaqW0ZRgW5KHFN8aHIbZq9ebu1I/vlrc3qL+Oe+AGX0Axv8WDkUMHCMuxPkjftYNGmSwQscPMIVXhHcyrnGlGlLavPi1i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kcN6a30L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A679CC4CEFB;
	Thu, 18 Dec 2025 07:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766043408;
	bh=Myo3pfKSHU9k4vKcvA+AYZGJnvyzp12VBtwF9l+GFXg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=kcN6a30L1eSbVADy9jTxh1uGcZHWlRsfo0CYxfijipH4wEsGsUdBZ4qF2kDb2FFAQ
	 TkMbzRN8oQYHLeGs88LPRK9ZlKBfyTuFRRxTsWchnnYJMXbEz4qzP+3IEMX+kvRQwX
	 QwnfEjN+XAkpMU1nq0QnEU/xAVul3myq7N+40PTrCwlazQCwiwLlke664q7ZkCZtkt
	 64rXxusgg6ykN2sMQnnAToRLNiYJZBuUqnSCm70ppe/A0y+EVNhIRTuDxFsRMbqu+x
	 oOXipKL1/YXSIGhHEv8RjGacr1Wo0aFuVuyopQCgQLUs7OQCf43Y+rg4aPDiDleddF
	 Q1U7jW5SgfwAQ==
From: Mark Brown <broonie@kernel.org>
To: Fei Shao <fshao@chromium.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, linux-spi@vger.kernel.org
In-Reply-To: <20251217101131.1975131-1-fshao@chromium.org>
References: <20251217101131.1975131-1-fshao@chromium.org>
Subject: Re: [PATCH] spi: mt65xx: Use IRQF_ONESHOT with threaded IRQ
Message-Id: <176604340641.24947.388406077684218935.b4-ty@kernel.org>
Date: Thu, 18 Dec 2025 07:36:46 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773

On Wed, 17 Dec 2025 18:10:47 +0800, Fei Shao wrote:
> This driver is migrated to use threaded IRQ since commit 5972eb05ca32
> ("spi: spi-mt65xx: Use threaded interrupt for non-SPIMEM transfer"), and
> we almost always want to disable the interrupt line to avoid excess
> interrupts while the threaded handler is processing SPI transfer.
> Use IRQF_ONESHOT for that purpose.
> 
> In practice, we see MediaTek devices show SPI transfer timeout errors
> when communicating with ChromeOS EC in certain scenarios, and with
> IRQF_ONESHOT, the issue goes away.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: mt65xx: Use IRQF_ONESHOT with threaded IRQ
      commit: 8c04b77f87e6e321ae6acd28ce1de5553916153f

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


