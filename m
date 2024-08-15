Return-Path: <linux-spi+bounces-4198-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 481F3952F79
	for <lists+linux-spi@lfdr.de>; Thu, 15 Aug 2024 15:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6FE8B23C47
	for <lists+linux-spi@lfdr.de>; Thu, 15 Aug 2024 13:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71071A01B4;
	Thu, 15 Aug 2024 13:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FgRBVf1P"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE0619EED2;
	Thu, 15 Aug 2024 13:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723728770; cv=none; b=gcfqJVkm1lX9McTWu7+oL5H0GhgGFJnHmAZM7q5r57mba7xbdXjhWtwWsNUE75aO28XFBg/4JtkT5og0+zkMi4lOXlHgMV1wywyAiCTdmOYD6T9QsWgPv6h/eMf9ypfQDUWPKXzU/WfWsZre9jD7uii0Zr5L4iXGk4i3pc4wO+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723728770; c=relaxed/simple;
	bh=mVX5OYbpa91M8rkpcs62GtOx+E1ln6bs4bihvgAv/rY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=t7YNIaGuJEMaUZkIXcuGjmDZFBN9bKQXQvZy9avbL9gweYumqioA4n4sPesTDbFj2+QlGoaJyhgY8d4Cvm+SfJ510F6knLD2jUhNxhueGGepWx5jT/YxV38vxl+VsK657D3W7qUGi70kSppmMIu2GczrxJZ7kx1WxX5FSC4QTcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FgRBVf1P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7A11C4AF0C;
	Thu, 15 Aug 2024 13:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723728770;
	bh=mVX5OYbpa91M8rkpcs62GtOx+E1ln6bs4bihvgAv/rY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=FgRBVf1PHpBeqP8jW11R1tHRROnO7nmvkoukQIgkKDEgphN4qLfj03mB4OpPF6mm6
	 gi0Q4yRX4MpymnVhpPZSg5M+3kw1CQ0imQfcJrtwSQfu7R9HrVAg490aXf+AM3y1M4
	 /1iBe7JGQ+vMB4HTStkjSyQuLO483GF6baTAxDXV0cQk4uAygFL1ge11tkUU9FKiRU
	 ihcrarANWd1MoI3feOQd5tfxxdmZlUEaJOH6HRrQ49IdPRGmgfvuYZaVFmJniPH2vc
	 QszQJMBSqJ25LGMWW/vQ2M4RyM8+tfYw48G33Tvq1Vs/bt/46ko2bdlQODIYw9WhL7
	 TxpRiClj2RYwQ==
From: Mark Brown <broonie@kernel.org>
To: Vignesh Raghavendra <vigneshr@ti.com>
Cc: theo.lebrun@bootlin.com, d-gole@ti.com, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20240814151237.3856184-1-vigneshr@ti.com>
References: <20240814151237.3856184-1-vigneshr@ti.com>
Subject: Re: [PATCH] spi: spi-cadence-quadspi: Fix OSPI NOR failures during
 system resume
Message-Id: <172372876860.37632.10724090127376087246.b4-ty@kernel.org>
Date: Thu, 15 Aug 2024 14:32:48 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Wed, 14 Aug 2024 20:42:37 +0530, Vignesh Raghavendra wrote:
> Its necessary to call pm_runtime_force_*() hooks as part of system
> suspend/resume calls so that the runtime_pm hooks get called. This
> ensures latest state of the IP is cached and restored during system
> sleep. This is especially true if runtime autosuspend is enabled as
> runtime suspend hooks may not be called at all before system sleeps.
> 
> Without this patch, OSPI NOR enumeration (READ_ID) fails during resume
> as context saved during suspend path is inconsistent.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-cadence-quadspi: Fix OSPI NOR failures during system resume
      commit: 57d5af2660e9443b081eeaf1c373b3ce48477828

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


