Return-Path: <linux-spi+bounces-4898-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB4597D3D0
	for <lists+linux-spi@lfdr.de>; Fri, 20 Sep 2024 11:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8424C1C21477
	for <lists+linux-spi@lfdr.de>; Fri, 20 Sep 2024 09:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F86757EA;
	Fri, 20 Sep 2024 09:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IjgKWoc0"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBF322066
	for <linux-spi@vger.kernel.org>; Fri, 20 Sep 2024 09:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726825256; cv=none; b=XSXyu4f+G/nHu6rqmna2RzWanL0MALTJrywHk7ofK11Yl6F4SpUWi+FQZJSuWrZUziihcjLPchuTG+KLHfjyAI3+MmFLEOamIiRe4ooggp8bkQtpcc7aEIBc3ls4HWtSkEi6xI5+Zym5Q3gzD2+/B2SOjBaoTWG/Nf85/6GDqJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726825256; c=relaxed/simple;
	bh=WADNKRXzEQM2/TGHsCPwjNMv9XFwPydOLmFHTr33LmM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lDKfbaiRllT803nhxU83SJpi3YRO246nvMhYhlyGXP/H6CQE5fA4ScE5BlqzAzef0bp9r9Y/MXLd4X99yEF3AZpt/MB2iTFAm0i1jcWQzSkxeRwLx5K6dVlU5XcAox2a3/GiHY6zyCpP9LOAbsNtJraEZ8eyoosBfpcqydoXbtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IjgKWoc0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30933C4CEC3;
	Fri, 20 Sep 2024 09:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726825255;
	bh=WADNKRXzEQM2/TGHsCPwjNMv9XFwPydOLmFHTr33LmM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=IjgKWoc0nVrAykgcRrhwyqrNVEngZB8H5M6cAGAEH3+OeHfgqaodFkvqX5yojAKMW
	 LxUsUgDz0FcSF4m6aQT+oDTm0/KdwiZck9wThBdVQJe0bR2Ce0MforFp7eUxOPs6oO
	 4JtSStvXPxTxML9ff2uslTPet1oGXlON/2beskR+8JemiO3JR9mRjdpgVnUcMm6nY7
	 5wn1KTileRVr6kQC2pU39QRMAjkUuYbKH6gX9aFRaTU+PK4J0+onWEt+ovV4ASNSco
	 vRzs0D27UJKoW+jL7Bhg7UyOy3B1BVA2CT6GJr/ichFUi17KC0sBZ2jYDv7ULooa+0
	 anLQy/y3l0Yyg==
From: Mark Brown <broonie@kernel.org>
To: Ray Liu <ray.liu@airoha.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Andy Shevchenko <andy@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>, 
 linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org, 
 upstream@airoha.com
In-Reply-To: <20240919-airoha-spi-fixes-v2-0-cb0f0ed9920a@kernel.org>
References: <20240919-airoha-spi-fixes-v2-0-cb0f0ed9920a@kernel.org>
Subject: Re: (subset) [PATCH v2 0/2] spi: airoha: Fix errors reported by
 mtd_test kernel modules
Message-Id: <172682525279.1868433.7364571402602588778.b4-ty@kernel.org>
Date: Fri, 20 Sep 2024 11:40:52 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Thu, 19 Sep 2024 18:57:15 +0200, Lorenzo Bianconi wrote:
> Fix errors detected running mtd_test kernel test modules.
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: airoha: remove read cache in airoha_snand_dirmap_read()
      commit: fffca269e4f31c3633c6d810833ba1b184407915

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


