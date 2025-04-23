Return-Path: <linux-spi+bounces-7724-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F2CA988D1
	for <lists+linux-spi@lfdr.de>; Wed, 23 Apr 2025 13:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7EE544507F
	for <lists+linux-spi@lfdr.de>; Wed, 23 Apr 2025 11:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF35F26FA62;
	Wed, 23 Apr 2025 11:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KUwF4t6t"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A385B26F444;
	Wed, 23 Apr 2025 11:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745408667; cv=none; b=OYmALDYU3dU0HjCFQVlp3+fA6Uifd9POOEF7bQRx1VBhlibTi8x9G3h1Xp84bIINRNrWQ4YgatP2bzeaCVA0sxNbQGiDMWpyqz6d7P/SJ493eSITltBEx/5Rry+PFj+v52efMvQcL0/pkl7kcNPU2YQo5SUKUJ2c6KVxjoE52uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745408667; c=relaxed/simple;
	bh=5cQQ2k3EMTyhmzUp7//r0VkHXfsAWm3XNAjUaKxYfeQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HPCVynFomGc6blN3pnoTSqeAv42eYqzbAtirg2NmCiBGa3G7bvDRvf+k81qiPfSfnp5wZeeQVgGc2wPCUR5I3OXLT3c2TugOOfaCYiRR70a+MKFi74Ict1u8cFJJQw7AqFMAzSw9Iqvf1n20Ese181/Z/c0/mnpt6J95z/w7qNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KUwF4t6t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A09BC4CEE2;
	Wed, 23 Apr 2025 11:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745408667;
	bh=5cQQ2k3EMTyhmzUp7//r0VkHXfsAWm3XNAjUaKxYfeQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=KUwF4t6t487uwT0ohnuanuQXtWNurrxiMBebUH6vxSwX5yH0Tw2/KTnMxUDmHBki7
	 nbKsWGXM6N2YMMhZ/01UNvhT+W/vhKfCCsf356vtSTOilONszEn/yvXP+KNNrLSahd
	 EMPy5RawgUx7sTFvBsGjSaWGI3gI6F1xy1xaKy2lgbe6xoCNhmmJ3k3Vw8yqx2LbaG
	 uBMCNyho0hRJXJSr1DZGo1Xp96zUQf3iTX6T5RPXlSU/uzFhY40tZ995cJ0svqMqdN
	 0cF3vqjjvdT8shUAEJIBofeEg6b5ZEaOPqOBKcW0K/sa2OJJEg6zz1PYmGE68ydWms
	 Y0i9IX+SDeacQ==
From: Mark Brown <broonie@kernel.org>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
 linux-spi@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org
In-Reply-To: <2674c8df1d05ab312826b69bfe9559f81d125a0b.1744975624.git.christophe.jaillet@wanadoo.fr>
References: <2674c8df1d05ab312826b69bfe9559f81d125a0b.1744975624.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] spi: stm32-ospi: Fix an error handling path in
 stm32_ospi_probe()
Message-Id: <174540866515.26715.3420851726467928798.b4-ty@kernel.org>
Date: Wed, 23 Apr 2025 12:44:25 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Fri, 18 Apr 2025 13:27:53 +0200, Christophe JAILLET wrote:
> If an error occurs after a successful stm32_ospi_dma_setup() call, some
> dma_release_channel() calls are needed to release some resources, as
> already done in the remove function.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: stm32-ospi: Fix an error handling path in stm32_ospi_probe()
      commit: 460b14b0929fa9f658a7e159ef646ce456962ab0

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


