Return-Path: <linux-spi+bounces-5082-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F7D98CA18
	for <lists+linux-spi@lfdr.de>; Wed,  2 Oct 2024 02:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F95828689B
	for <lists+linux-spi@lfdr.de>; Wed,  2 Oct 2024 00:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813C315D1;
	Wed,  2 Oct 2024 00:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V885n1mc"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC2A391;
	Wed,  2 Oct 2024 00:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727829540; cv=none; b=nFtd96Xa2Hm/fd+AxbPCmTw4DxyDM1lJ18UUOabtyz05hyCz0D6Y1IsNJdZmbAerKzX+y6UdpHZP1mfkpTaA9vJ4ZPH2h5IvWemmtW5/YzGjRXKp14pawniGEE66QhlHzwwMZPmhCmL1OENG4W/G05s6DTSFuBcCVT5bA62N8OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727829540; c=relaxed/simple;
	bh=n244WwV63ADRuTUWmaRFdZXMoVsMzNrC8vWHzlymnmc=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lGSE4niJKV1mVXYJiKD0t4wja5A2PvrsuUhrLMRRr5siBriKZQdhI/RQQDIgYNbOe8dBXWvEIthCcji4aAZyd03uOQgTFKOchFavVPOfTeiSkY+yXDAS/3oUkyP5nOsMuGLUkX2InTDs+WvfdFVmn8JVXSUXDUhaUbxDtd60YIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V885n1mc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE589C4CEC6;
	Wed,  2 Oct 2024 00:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727829538;
	bh=n244WwV63ADRuTUWmaRFdZXMoVsMzNrC8vWHzlymnmc=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=V885n1mcvuvIN1lsO+nle4gyXXpUx5j3b2XdsWJunFBBKfzdLFgPuNS/0I5aLcNlZ
	 n0RoAtYpY0T5Hj5VxLEEhV/p2DZh1BKaWRyt0o+DJK2UoINS/Wrzy3zPT5g2ruW83H
	 BxQ82hzTlCwSPN1Dnt30Dpfc8lU9N76oUzcYGMXAJQJSc2dXlJd2K0Kh9DFQsfQRMF
	 O8sC18ChsLkw1CCzokHbMUE11kQwZdxjYWdGf7VejgbGn//WdaOFPYwrJXw83cpuxj
	 pbt22K+kBUGsLRLQhJrI6iGH+T7zZWlpe47XSshj+FzP2vgIivf2Qofvo9DlVpNGxd
	 HjmanGuyQtCsg==
From: Mark Brown <broonie@kernel.org>
To: shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
 festevam@gmail.com, shubhrajyoti.datta@xilinx.com, srinivas.goud@amd.com, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20240923040015.3009329-1-ruanjinjie@huawei.com>
References: <20240923040015.3009329-1-ruanjinjie@huawei.com>
Subject: Re: [PATCH 0/3] spi: Fix pm_runtime_set_suspended() with runtime
 pm enabled
Message-Id: <172782953505.2314893.17571389802894032721.b4-ty@kernel.org>
Date: Wed, 02 Oct 2024 01:38:55 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Mon, 23 Sep 2024 12:00:12 +0800, Jinjie Ruan wrote:
> Fix pm_runtime_set_suspended() with runtime pm enabled, and fix the missing
> check for spi-cadence.
> 
> Jinjie Ruan (3):
>   spi: spi-imx: Fix pm_runtime_set_suspended() with runtime pm enabled
>   spi: spi-cadence: Fix pm_runtime_set_suspended() with runtime pm
>     enabled
>   spi: spi-cadence: Fix missing spi_controller_is_target() check
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: spi-imx: Fix pm_runtime_set_suspended() with runtime pm enabled
      commit: b6e05ba0844139dde138625906015c974c86aa93
[2/3] spi: spi-cadence: Fix pm_runtime_set_suspended() with runtime pm enabled
      commit: 67d4a70faa662df07451e83db1546d3ca0695e08
[3/3] spi: spi-cadence: Fix missing spi_controller_is_target() check
      commit: 3eae4a916fc0eb6f85b5d399e10335dbd24dd765

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


