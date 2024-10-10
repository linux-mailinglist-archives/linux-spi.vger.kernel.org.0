Return-Path: <linux-spi+bounces-5191-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DD699849E
	for <lists+linux-spi@lfdr.de>; Thu, 10 Oct 2024 13:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C692328252D
	for <lists+linux-spi@lfdr.de>; Thu, 10 Oct 2024 11:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835891C331C;
	Thu, 10 Oct 2024 11:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H8/9AZtn"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B931C3310;
	Thu, 10 Oct 2024 11:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728558872; cv=none; b=lrYaWBOK3VpMuxuhyiqsUpU1goTbjBBIweqtOIZ8BV8SF7wpDiM7eRkEfbNN747VZ68BzentCnuP0NHRDWMf8iAzkMx2YrfzpwK8ojpBJ1aQWUYwiCsWD28UBjvm0cpM0BZieuDHtepx5+9ruAJK6JlsGBARAXFdFYgeBKLRmCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728558872; c=relaxed/simple;
	bh=faasR6xzN3h6q9heHvMNzaWStXw8OeeUNOIeaDVDmnA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ssUY6AxcMK+R4AYorcMBsOab50JWm95h3j5Y9tkdRC+9zq42qpPDGcUKg1wLkl9YE6bQAANXq+SuYhFNvMUfwLKKHsm3+V7s9hi2JqBwGCkUZK5JVSInJI3tlWV8GlVFRNSJlFfWO4nrYvdemQ0sGUnVAEbMt7Raj08SOsn9k3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H8/9AZtn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85748C4CEC5;
	Thu, 10 Oct 2024 11:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728558871;
	bh=faasR6xzN3h6q9heHvMNzaWStXw8OeeUNOIeaDVDmnA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=H8/9AZtnQcDTJFKDFeuufNmkW5gabUoy4BG2i7O43q90IwQz1EsqgPIzIuUudL3Cq
	 Y7Ok/dCi+HCPLPaFzfSsnduNNX9Fs0CEBu5Hrne8rIiudAHFMjciPY1RPCebCau0G4
	 fzXlmorIcIQ4kWe9o2MlptmVilY6j3805XFLnmnbTj3N4Yb/RRyFA7pDSA/VkAiC5h
	 NyYu3MrRsoas3FzLKzcbNj4LLaY7nRfbM/QXAZwVLR6ov//JLkN/T/BmDK4BGfQb52
	 mMopOajU05W6Wiy+kICiC6YmjKHJRv6ZTARe/gE3VVfc1m3AkpWQ/5NqUIvLy3pvqY
	 IfCQzzpxZp2QA==
From: Mark Brown <broonie@kernel.org>
To: olteanv@gmail.com, frank.li@nxp.com, shawnguo@kernel.org, 
 Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, linux-spi@vger.kernel.org, 
 imx@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org
In-Reply-To: <20241008055644.4900-1-hardevsinh.palaniya@siliconsignals.io>
References: <20241008055644.4900-1-hardevsinh.palaniya@siliconsignals.io>
Subject: Re: Fix Sparse warnings
Message-Id: <172855886823.3260167.4815619322285709475.b4-ty@kernel.org>
Date: Thu, 10 Oct 2024 12:14:28 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Tue, 08 Oct 2024 11:25:44 +0530, Hardevsinh Palaniya wrote:
> Change in v2:
> 
> in patch 2/2:
> 	- Use ioread32be instead of readl
> 	- Use iowrite32be instead of writel
> 
> Note: Drop 2 patches(patch 2/4 & 4/4) from the last version
> link to v1: https://lore.kernel.org/linux-spi/20240927132944.19285-1-hardevsinh.palaniya@siliconsignals.io/T/#t
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: spi-fsl-dspi: Fix casting warnings
      commit: 66c1c4175bbdfcf1cb1411b1ea62e7e0b5571594
[2/2] spi: spi-imx: Fix casting warnings
      commit: f3a59ab98cfc18c7b2fb1d8164bedbb1569a7e76

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


