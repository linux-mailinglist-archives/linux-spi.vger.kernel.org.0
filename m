Return-Path: <linux-spi+bounces-11896-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E79CBE97C
	for <lists+linux-spi@lfdr.de>; Mon, 15 Dec 2025 16:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7C0F302CF63
	for <lists+linux-spi@lfdr.de>; Mon, 15 Dec 2025 15:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7EF3314D1;
	Mon, 15 Dec 2025 13:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XWs4oT2i"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60063314C2;
	Mon, 15 Dec 2025 13:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765807170; cv=none; b=b4QMidIydICbHewUzOvvibY3aqDD4kXCv3FG4YAkoqsnZrG4YeksFFfvjon+51+DEF9IjSNLTLHFkLmaiLYydzrhPNy2/eSwy0rZJHDGykzRfEHAyOJ+bp4gkHUtJNbRZlhI55tIUhWQdvUsp1Mgvx5CNRloj7qXLHCV3ZzESk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765807170; c=relaxed/simple;
	bh=IuiIygsKUZ0UuNkx13gsxBmP8a+v9qO1VwX9cWyX0+k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=I/gyWoOdYWimFWfm3HnuoDY1jkYyBdU+2MjtAW0oWIDksK+Fprvf1yNrnGWdhaE+NeArdTBa4rW4rGqajUlFLnSie/MTcHE5kH7yPL9LQaizV90XyJc3rphtkVUzWv38569l0+Lkc+9yLNtMmKab6wnufeO/QXSn3oR1NXVIHRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XWs4oT2i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 125D3C4CEF5;
	Mon, 15 Dec 2025 13:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765807170;
	bh=IuiIygsKUZ0UuNkx13gsxBmP8a+v9qO1VwX9cWyX0+k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=XWs4oT2i6BYFD4FSVU/vt0vjikHA24HoE3gKg2TeKQWCCDJm80zCDL9gfni77+3qM
	 m9t1OgNM+Q3629Qh29//lQ3oOtoqpzIMSCjJYc3945xoSUXtf74uqm8n/2Yy1fEmSl
	 CxenF2AYHOjUaiPb5CaZ9z7688LTpDyK+7e5cWL+4wcvO87MQtiExqwR3ij6Wm+nV7
	 6vUs9CuT+swHvUt9BlpJaXo5rFzct/H4NJkLz7hJS8d9ka7FVxhcoUuAWCCICuZ1wd
	 G6uz8/Kvs1/NzN3kgBU76gv6y4MrLCkXQJ/2aHT2KEu0FIaR7WvHxNpZ8DZ4zqgCVk
	 7nfvpeBd5MXZw==
From: Mark Brown <broonie@kernel.org>
To: linux-arm-msm@vger.kernel.org, Jonathan Marek <jonathan@marek.ca>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251120211204.24078-1-jonathan@marek.ca>
References: <20251120211204.24078-1-jonathan@marek.ca>
Subject: Re: [PATCH 1/5] spi-geni-qcom: remove manual CS control
Message-Id: <176580716950.161463.18012619677965135620.b4-ty@kernel.org>
Date: Mon, 15 Dec 2025 22:59:29 +0900
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773

On Thu, 20 Nov 2025 16:11:58 -0500, Jonathan Marek wrote:
> The GPI_DMA mode already uses automatic CS control, to use automatic CS
> control for non-GPI case all that's needed is to set the FRAGMENTATION flag
> using the same logic as setup_gsi_xfer(). (note clearing SPI_TRANS_CFG's
> CS_TOGGLE bit enables automatic CS control, the comment was wrong)
> 
> spi_geni_set_cs() is slow, so this is a big performance improvement.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/5] spi-geni-qcom: remove manual CS control
      commit: b99181cdf9fa0247dda3ba1228b4578286ab7ecd
[2/5] spi-geni-qcom: don't set max clock in setup_fifo_params
      commit: 7ba2e0edb18b3ccee7339315be47080832a3c355
[3/5] spi-geni-qcom: use xfer->bits_per_word for can_dma()
      commit: fb2bbe3838728f572485706677590e4fc41eec5c
[4/5] spi-geni-qcom: initialize mode related registers to 0
      commit: 739062a9f1e9a77a9687c8fd30f8e5dd12ec70be
[5/5] spi-geni-qcom: rework setup_fifo_params
      commit: 781c3e71c94c80e1b33a7d84b970907dd32abc10

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


