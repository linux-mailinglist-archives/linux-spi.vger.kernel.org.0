Return-Path: <linux-spi+bounces-11382-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D023C73459
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 10:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1165A4E918A
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 09:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925FF3126B1;
	Thu, 20 Nov 2025 09:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sse2LlKd"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1923254BD;
	Thu, 20 Nov 2025 09:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763631641; cv=none; b=NBP0BEqBstqyTJjAE5Uhg1T4peFUV0kBSiPvxezB6BKl3ahNt8azwaI0/gFCps6gSJkW5tx+DrJZTOmLSrm2urFPAKPUSjGSKAxJyqKP92JNIAE6vSAG/WMDB6f6Hc8r1WzuGqhYwQr9SZPeo7x9etIRPH0hqeD9EmETCeaWrys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763631641; c=relaxed/simple;
	bh=no0VPyTw7icF2zOkFEwABDlOo/lI3S6IIIyj6ujTktY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FmASeeFcRlk6p6PMYRpOuK40noxwJuHwJZD4uO96/T5nld5cOKxp7u8tHeM0weOi5Nx2FrJJC1Gg3gkL8yMkFjRxIjSV+BMcdaAGpTYeOvz1lEXJz6wtjo037Hthcu6slqV+fnOO25Iw9Z0oCnH6uzPYy/0H6ceD6ybBnL87TnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sse2LlKd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9003BC116B1;
	Thu, 20 Nov 2025 09:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763631640;
	bh=no0VPyTw7icF2zOkFEwABDlOo/lI3S6IIIyj6ujTktY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=sse2LlKdtF2PIUw6SuvG0NQKkrLRzGH6K11yG5mjHxlj0oHOGvxcwPqoH1VOsJ6QB
	 FC6b14pG0ui5Ftdubjz+mn3c+fpHjX1nqKK8y6MJUHgZSHlDnVe5gmxRzNGRo8bSyB
	 UjOnoEEzXOjjq8wPcNqtAjouCSf00Eyoal7/6QSPttPyF7NFveo8WDEeB3jzK7OEah
	 BGleVya59i0NvgLlKLdKxsSGy5gbe1fIQgleum44wNF79NuKj/PK+Bk+p46oX5YBbf
	 +mGMGuzc1bVkEi6GlB5eMwc1rA1VDARCuDf0cX78jDdq2+GTQb5NAMQ1SSLPTy3k4K
	 uY3jgGC9ns0sw==
From: Mark Brown <broonie@kernel.org>
To: a-dutta@ti.com, Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, srk@ti.com
In-Reply-To: <20251119152545.2591651-1-s-vadapalli@ti.com>
References: <20251119152545.2591651-1-s-vadapalli@ti.com>
Subject: Re: [PATCH] spi: cadence-quadspi: Fix cqspi_probe() error handling
 for runtime pm
Message-Id: <176363163845.560683.16994547761881991962.b4-ty@kernel.org>
Date: Thu, 20 Nov 2025 09:40:38 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a6db3

On Wed, 19 Nov 2025 20:53:53 +0530, Siddharth Vadapalli wrote:
> Commit f1eb4e792bb1 ("spi: spi-cadence-quadspi: Enable pm runtime earlier
> to avoid imbalance") relocated code but missed updating the error handling
> path associated with it.
> 
> Prior to the relocation, runtime pm was enabled after the code-block
> associated with 'cqspi_request_mmap_dma()', due to which, the error
> handling for the same didn't require invoking 'pm_runtime_disable()'.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: cadence-quadspi: Fix cqspi_probe() error handling for runtime pm
      commit: 295fe8406a357bc0abb901a21d1a554fd4dd1d05

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


