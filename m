Return-Path: <linux-spi+bounces-12100-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB98CDA083
	for <lists+linux-spi@lfdr.de>; Tue, 23 Dec 2025 18:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CAABE302DB6B
	for <lists+linux-spi@lfdr.de>; Tue, 23 Dec 2025 17:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5662C346A1A;
	Tue, 23 Dec 2025 17:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="plPED//w"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E272346A18;
	Tue, 23 Dec 2025 17:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766509622; cv=none; b=QKTu5SPb3fGV0VqVEN7SGP5GhsKAALNCKpdDnaF7Dd7Me2HJRxagEetsPTQ6jxYS5mUyP9eEYH/kd5c4cYwYRH2FUnb617csIJmGbb5fcZ+XA9Qd5t2+9hywHjYItG/Vp2b1IMcJA3vY2p10sWrFizmlfOZGSzgdZEsUWkOrHKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766509622; c=relaxed/simple;
	bh=a7iKzo0baKsFuEJWlBvocLu5V2Z4KJqGciAOaeqgC5o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NyySW4sy4y7ZJfOlby/kRaGxEEcrOp5lxoXBYbPQGKdIH44EDzhSbye9AkoYKCQNxeJ3ykWidur+rjeOmHvo3fuDX3mhVf4Kcj9fA3IhLq0eVK1M5O2Yt7dZ28YfbzxnF2H4zHzTgXfxbOtfWsB93Ywf1h9jrbyBgHk6oz6WjVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=plPED//w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B96B6C116B1;
	Tue, 23 Dec 2025 17:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766509621;
	bh=a7iKzo0baKsFuEJWlBvocLu5V2Z4KJqGciAOaeqgC5o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=plPED//w7d4lv+r6pj5zz/Ps3e1L5XuYsxUj125N2+Ay4xgLaX8s04kmeFnqA9FRC
	 pteyHcoiv4CYi4jGAI9Gl2qmT78+wrlyQ6OInLRZMEUdqSRo+p2o6RT/wLAYA3Ho0I
	 f232rroTKK+QGzSv+kS6eZgEXOIe6pqCYd0LRrX7h8jZah5Xc5TSixC714HDMLTQtk
	 cnTz1eHAtY2jtxEPwDkMxsJ/1RueQ/n5312XXOmf8l7Cnq5nPcb5rK2zGNtrVWAJJb
	 08F0NmQDSU4LwAbAkIaO6RqFbRep0xXrGi28XVqK+3cJL53/LWRL+FJRIJ8Z9ISeoG
	 5V9h4B7fvoyLQ==
From: Mark Brown <broonie@kernel.org>
To: Anurag Dutta <a-dutta@ti.com>
Cc: grmoore@opensource.altera.com, nm@ti.com, francesco@dolcini.it, 
 s-vadapalli@ti.com, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 gehariprasath@ti.com, u-kumar1@ti.com
In-Reply-To: <20251212072312.2711806-1-a-dutta@ti.com>
References: <20251212072312.2711806-1-a-dutta@ti.com>
Subject: Re: [PATCH 0/2] spi: cadence-quadspi: Fix probe error path and
 logging
Message-Id: <176650961941.445350.999359537968542547.b4-ty@kernel.org>
Date: Tue, 23 Dec 2025 17:06:59 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773

On Fri, 12 Dec 2025 12:53:10 +0530, Anurag Dutta wrote:
> This series addresses issues in the cadence-quadspi driver's probe
> error path:
> 
> Patch 1 fixes a clock disable imbalance that occurs when probe fails
> after runtime PM is enabled, particularly when DMA request returns
> -EPROBE_DEFER.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] spi: cadence-quadspi: Add error logging for DMA request failure
      commit: b1f54d7143e0f527cca1091857a786e278d72184
[2/2] spi: cadence-quadspi: Fix clock disable on probe failure path
      commit: 1889dd2081975ce1f6275b06cdebaa8d154847a9

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


