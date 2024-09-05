Return-Path: <linux-spi+bounces-4671-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E9596DBA1
	for <lists+linux-spi@lfdr.de>; Thu,  5 Sep 2024 16:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FBDF1C23734
	for <lists+linux-spi@lfdr.de>; Thu,  5 Sep 2024 14:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C5EC8FE;
	Thu,  5 Sep 2024 14:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VcMOobK7"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485F8C8C7;
	Thu,  5 Sep 2024 14:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725546007; cv=none; b=BZh38uxtMP7/e0yEfTSfSWGMVCwaGh/VdFFmyKYVYsLXxpVyCFq87nqQ3YfPioZrq+hJvmyFdN7UAZMFi7wFvWdaGY0Zsj86hQ8+dwLyeeD2nJ6FRTYrxsG2V0BL34Zn80FnbPaN36X6i5B4K8YWMYgIkjze0B+Fi+AumiMf4q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725546007; c=relaxed/simple;
	bh=JLmnfGEr0maK8jBZ3NMXsxiaogkrXjr/iLHcWhssSdc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tdf503wnfEC+JBsQPYKguVHM3Nk3MTNLGpmxa8U5K21BC1BEoP415IeQ3JsCfdc0HwOfphei5ACRTDMwbiOPQvklqbwBXKXuqLFawplRUdzNR5/gNXIPKimbdQXpw7Sk8QUanG1r/x6Gs+4zUpasCuk0Qvh3JFgHgCjb0usj258=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VcMOobK7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3539EC4CEC3;
	Thu,  5 Sep 2024 14:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725546006;
	bh=JLmnfGEr0maK8jBZ3NMXsxiaogkrXjr/iLHcWhssSdc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=VcMOobK7aiLCfigUmSU3PLDef4YBgH7OC+kGvqA0oOjaQ1AgnkFMrccQRR8PCu0Cy
	 VTKyT+vjVVsfyhcNfV6NsSSkx6YmD0wLEcL6mo5oeThj8+f3X/75xHCIWtPhYeU5AN
	 ACjyx+Ml5fbfW8Vi5MvmFLG7vXQZPkQktsT/FSg9xjP6Axhv7aMdsHO+i+Z50HhDRN
	 zJVmj46YXnwvexA1FjDsleK8LSVgrQWX1gbMHtr0/VwuCS6YOTo5EOZGDPsfHsXkxO
	 mToNIRLA0G1HJ7J/3rB1uAWxRqo9BTe4mjlbJen+UDsedB6O1/mOJQHuTyzQveMWeN
	 svIoaQ9zjcSsA==
From: Mark Brown <broonie@kernel.org>
To: Carlos Song <carlos.song@nxp.com>, Fabio Estevam <festevam@gmail.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Stefan Wahren <wahrenst@gmx.net>
Cc: linux-spi@vger.kernel.org, 
 "imx @ lists . linux . dev" <imx@lists.linux.dev>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>
In-Reply-To: <20240905111537.90389-1-wahrenst@gmx.net>
References: <20240905111537.90389-1-wahrenst@gmx.net>
Subject: Re: [PATCH] spi: spi-fsl-lpspi: Fix off-by-one in prescale max
Message-Id: <172554600492.45992.13352749090830569980.b4-ty@kernel.org>
Date: Thu, 05 Sep 2024 15:20:04 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Thu, 05 Sep 2024 13:15:37 +0200, Stefan Wahren wrote:
> The commit 783bf5d09f86 ("spi: spi-fsl-lpspi: limit PRESCALE bit in
> TCR register") doesn't implement the prescaler maximum as intended.
> The maximum allowed value for i.MX93 should be 1 and for i.MX7ULP
> it should be 7. So this needs also a adjustment of the comparison
> in the scldiv calculation.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-fsl-lpspi: Fix off-by-one in prescale max
      commit: ff949d981c775332be94be70397ee1df20bc68e5

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


