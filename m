Return-Path: <linux-spi+bounces-11903-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A40A2CBE747
	for <lists+linux-spi@lfdr.de>; Mon, 15 Dec 2025 16:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 959BD3002527
	for <lists+linux-spi@lfdr.de>; Mon, 15 Dec 2025 15:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED72D33344C;
	Mon, 15 Dec 2025 13:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hUTYKqxB"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D31332EBA;
	Mon, 15 Dec 2025 13:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765807181; cv=none; b=qxuG1bEk26I+ohJuPMXSqbq6rbdpZUKWhPUUNRbO98lg9BC4KIFGL5WowYxhBLEb13srFOpFWNkbPpII+LelM0B1YhWqwFE4KgWvm3T6TWkJmNBRRBH/lV/u6IIVDP/zoBwlSnaJdtRsYBMoY32tQLVc2xfBkmuGuxOWfdhkCP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765807181; c=relaxed/simple;
	bh=5eem6RTNlLH12noLpL9NhGFqVN6Q7ME2s/r1bRS4ujc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=T4EuRv4zZhixPfB0NJD25SWf2Zq+O5ccBfAibfg9hC60cVzlsooR6PURVouyiILjTYtq63vFNQHOwHttcbNniY43TFSw3LBg9tFDZi3SiCc6W1WNJYhjbF26staF0y+98Zh7n/XNIczHqxponsPj4XQ2i3Z7Ihlpkc/r4bULH38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hUTYKqxB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC46FC4CEFB;
	Mon, 15 Dec 2025 13:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765807181;
	bh=5eem6RTNlLH12noLpL9NhGFqVN6Q7ME2s/r1bRS4ujc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=hUTYKqxB+q5KW/v3sivABrCtDgyb8iBt9k86lse6VHMrU9ialeaHt5QMYXlzzRObP
	 kTKVTzcK8x2quqDjSeZET9VZz61hADVOzj9DO71yvipw4fGCq1Kx6l4h9Se/Pd/5kY
	 wQ7WMmXOmnbgS8ock0+558Ui2psEp18eRrjrpUcQZtPY4NH8PSW00/Qk+xlpkD3EMB
	 IrlU9/Jz4MWmagAUt1xJWFGGpqtZFzS+fVIJcWucBNN3BuIuSgOZ017axXo5pydhxw
	 rNJFv22TkKdX8tdu7zWRU3vqdP2tu/iX4aHCQsROp7iKJqdjPfWCc1MAAT6p+sEyWA
	 oWCUWYx1r47ow==
From: Mark Brown <broonie@kernel.org>
To: Frank.Li@nxp.com, daniel.baluta@nxp.com, david.laight@runbox.com, 
 andriy.shevchenko@intel.com, Carlos Song <carlos.song@nxp.com>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, David Laight <david.laight.linux@gmail.com>
In-Reply-To: <20251210105001.3891776-1-carlos.song@nxp.com>
References: <20251210105001.3891776-1-carlos.song@nxp.com>
Subject: Re: [PATCH v3] spi: spi-fsl-lpspi: convert min_t() to simple min()
Message-Id: <176580717933.161463.8943775097474993061.b4-ty@kernel.org>
Date: Mon, 15 Dec 2025 22:59:39 +0900
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773

On Wed, 10 Dec 2025 18:50:01 +0800, Carlos Song wrote:
> Current min() has supported comparison by normal integer promotion rules,
> so explicit type casts or min_t() are not needed.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-fsl-lpspi: convert min_t() to simple min()
      commit: b884e34994ca41f7b7819f3c41b78ff494787b27

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


