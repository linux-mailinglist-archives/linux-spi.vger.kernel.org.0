Return-Path: <linux-spi+bounces-6610-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9FCA25F58
	for <lists+linux-spi@lfdr.de>; Mon,  3 Feb 2025 16:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AE39164B88
	for <lists+linux-spi@lfdr.de>; Mon,  3 Feb 2025 15:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547A820A5C2;
	Mon,  3 Feb 2025 15:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J4nNDT13"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A551209F5C;
	Mon,  3 Feb 2025 15:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738598263; cv=none; b=qaoVOZ13J04BuwF31s5xAicZl15tH8LS7Qwud2TfaVmUwana7fVGCrk/l0qsOqVvRsr+w4qgBNxKXyi9tqyLuzSJw0OrSkjCK69rTiwf+IdCLf2ksTfAM26iVKqpYNQPgypS4PYP0VQiop+20QQcqd94Mqr4E6cW1LE8z+vYYDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738598263; c=relaxed/simple;
	bh=5fDGmhub7kgFaJWNzLMa64HxzMW4rz3YnPY6BA2o8bQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GnvK8I2AUHZ9WZGTo7/p69DdpfRHor7IHdiqDikCKOhXAuJBoxFf4dWYHwOHMcf904sijXOZmFTQ0rHGPFDCMC5NmacU07qOngTdvKwT+isQ9EeOHPsbZM1RZl/FsonaW4rxoMYdNEtmcedcxA4gWK9854ba024bcUdv3QaG3T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J4nNDT13; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FB52C4CED2;
	Mon,  3 Feb 2025 15:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738598263;
	bh=5fDGmhub7kgFaJWNzLMa64HxzMW4rz3YnPY6BA2o8bQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=J4nNDT13iycal9wwQ8iR0xlMm3uIg4mgGyb93cOd/oz3CjidGfKUiHyJBrAFMYVXA
	 7zihPZisRRVdWoi+dSgWbi/NlIN4fKvp0mE+XFn1qIzAr1AmbO1BAZK0hj5sD19TE3
	 T8CaDMiunBCrqeEMgG+sI05lO2KNWZjT1CntiiINZB8tR2LrODMgSUv59PGsqZdHp3
	 duRbkLRHwl0BQ5GMpVEAwmFK4ci2kTlSYo3ZvY1EXIRCTR02/TZl0i39ICX4w3E4gy
	 AXquFzG6Oh0Gl/ekMHYNJKawXYBYQd2OfOO/qRRLC7Q4iFL3BGYvNxLso1YK1f0EXU
	 TblOtIlmA398g==
From: Mark Brown <broonie@kernel.org>
To: Michal Simek <michal.simek@amd.com>, linux-spi@vger.kernel.org, 
 Sean Anderson <sean.anderson@linux.dev>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20250116224130.2684544-1-sean.anderson@linux.dev>
References: <20250116224130.2684544-1-sean.anderson@linux.dev>
Subject: Re: [PATCH 0/5] spi: zynqmp-gqspi: Clean up the driver a bit
Message-Id: <173859826117.375082.6233589403904038828.b4-ty@kernel.org>
Date: Mon, 03 Feb 2025 15:57:41 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Thu, 16 Jan 2025 17:41:25 -0500, Sean Anderson wrote:
> Here are a few mostly independent cleanups I came up with while writing
> some other patches. Feel free to apply them in piecemeal if you like.
> 
> 
> Sean Anderson (5):
>   spi: zynqmp-gqspi: Reformat long line
>   spi: zynqmp-gqspi: Add some more debug prints
>   spi: zynqmp-gqspi: Add helpers for enabling/disabling DMA
>   spi: zynqmp-gqspi: Clean up fillgenfifo
>   spi: zynqmp-gqspi: Always acknowledge interrupts
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/5] spi: zynqmp-gqspi: Reformat long line
      commit: d61009bd578ee7381a3cce5c506190ecb8f9d6e8
[2/5] spi: zynqmp-gqspi: Add some more debug prints
      commit: ba54629287f58b22c1d37f80f1875373e4b51ea6
[3/5] spi: zynqmp-gqspi: Add helpers for enabling/disabling DMA
      commit: d2ead60d853189f8e5ec6b301fac1e60e0b4b47d
[4/5] spi: zynqmp-gqspi: Clean up fillgenfifo
      commit: 9b32c86e40da792544c53076f5ec43f115e56687
[5/5] spi: zynqmp-gqspi: Always acknowledge interrupts
      commit: 89785306453ce6d949e783f6936821a0b7649ee2

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


