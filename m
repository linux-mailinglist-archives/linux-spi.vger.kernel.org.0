Return-Path: <linux-spi+bounces-10170-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6496B8A7C3
	for <lists+linux-spi@lfdr.de>; Fri, 19 Sep 2025 18:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33C3B3AF08C
	for <lists+linux-spi@lfdr.de>; Fri, 19 Sep 2025 16:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA7531E884;
	Fri, 19 Sep 2025 16:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qHIUoG5I"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EB031E0EF;
	Fri, 19 Sep 2025 16:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758297813; cv=none; b=c9MXCIhTsRpUgDIZlcRklwxck6S8n1hfTfnmZAhvr5GwP9VB0Rxk5NNu9GGTC4FTcchEh8HyX5D6u7ZUX0KHzgCF43uUTtsl7HRqTFr0KVMVHtCkZwD/uZQ/X5+NK4GW6RMwf/vjwdQ2QZ3HtJWeWcUJamsIPifDR5UNy+dAwjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758297813; c=relaxed/simple;
	bh=GvnqDnWIKf8bdAkEc9f6iDS6tA/AxRcZVSoMZ2CD1mk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=q6DNV/xy85e8gUiFuIA/1m9/BH0CRQZ7GrXF8s2Ksrhdjf0scW8zGdRMQKsELX+83VTc2u7W8KfP6fqihjwnf4UVMCcJe8R/bvfX8BRD1pajFsn2fWDCWofsOBsVmraJHI0KiwN2BjkXuzvd3WNFDwIWUoKSZvXs+u3UKp+muqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qHIUoG5I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C427DC4CEF0;
	Fri, 19 Sep 2025 16:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758297813;
	bh=GvnqDnWIKf8bdAkEc9f6iDS6tA/AxRcZVSoMZ2CD1mk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=qHIUoG5I7IDeVsUXeHXVI1sSPkiNeIbJv8lx0rSrR4n2o1VRmP5hBQi8TnbXKivAl
	 /M3v62MpnO5NmdelbAQGDQ1ktZuTX6sjcf0GGyhl5vN9ZUw8YWBgWfKu6bKtgF5DIV
	 8CQGI0+UUsV9LVinSIfYYsQGFsMSvnRXQkXwjZ7/oQiZwXoC10T6QwStPfPL6op1FD
	 B9HvSQ0T301zyEurSLWvkJ9z9nz8kO2tzhroB62lA0vv1ViZ5YgiALl32LIaFG6fZ3
	 VWTe5x+/BxGuxxtPDQbmRPV5Nx+Mk9qJQFJ5liEbiT6WQZZkdy1byrelL0GDtnfJIJ
	 i+t1W8BsEZ2aA==
From: Mark Brown <broonie@kernel.org>
To: Han Xu <han.xu@nxp.com>, Yogesh Gaur <yogeshgaur.83@gmail.com>, 
 Frank Li <frank.li@nxp.com>, Haibo Chen <haibo.chen@nxp.com>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
In-Reply-To: <20250917-flexspi-ddr-v2-0-bb9fe2a01889@nxp.com>
References: <20250917-flexspi-ddr-v2-0-bb9fe2a01889@nxp.com>
Subject: Re: [PATCH v2 0/5] spi: spi-nxp-fspi: add DTR mode support
Message-Id: <175829781053.161854.17379770923486529628.b4-ty@kernel.org>
Date: Fri, 19 Sep 2025 17:03:30 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-56183

On Wed, 17 Sep 2025 15:27:05 +0800, Haibo Chen wrote:
> this patch set add DTR mode support for flexspi.
> For DTR mode, flexspi only support 8D-8D-8D mode.
> 
> Patch 1~2 extract nxp_fspi_dll_override(), prepare for adding the DTR mode.
>         in nor suspend, it will disable DTR mode, and enable DTR mode back
> 	in nor resume. this require the flexspi driver has the ability to
> 	set back to dll override mode in STR mode when clock rate < 100MHz.
> Patch 3 Add the DDR LUT command support. flexspi use LUT command to handle
> 	the dtr/str mode.
> Patch 4 add the logic of sample clock source selection for STR/DTR mode
> 	STR use the default mode 0, sample based on the internal dummy pad.
> 	DTR use the mode 3, sample based on the external DQS pad, so this
> 	board and device connect the DQS pad.
> 	adjust the clock rate for DTR mode, when detect the DDR LUT command,
> 	flexspi will automatically div 2 of the root clock and output to device.
> Patch 5 finally add the DTR support in default after the upper 4 patches's
> 	prepareation. Since lx2160a do not implement DQS pad, so can't support
> 	this DTR mode.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/5] spi: spi-nxp-fspi: extract function nxp_fspi_dll_override()
      commit: 614180a54d5f21ccb4f60042d19744694d31d3f8
[2/5] spi: spi-nxp-fspi: set back to dll override mode when clock rate < 100MHz
      commit: a9888b3222ec73d055447a39cf9a0118f67497f4
[3/5] spi: spi-nxp-fspi: Add the DDR LUT command support
      commit: 3c1000e15fd0eb387fcca420c9fb36ae07887782
[4/5] spi: spi-nxp-fspi: add the support for sample data from DQS pad
      commit: c07f270323175b83779c2c2b80b360ed476baec5
[5/5] spi: spi-nxp-fspi: Add OCT-DTR mode support
      commit: 0f67557763accbdd56681f17ed5350735198c57b

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


