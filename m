Return-Path: <linux-spi+bounces-9115-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3159DB07C0C
	for <lists+linux-spi@lfdr.de>; Wed, 16 Jul 2025 19:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D0E83B7AD1
	for <lists+linux-spi@lfdr.de>; Wed, 16 Jul 2025 17:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4311DE8A3;
	Wed, 16 Jul 2025 17:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RIsPrqhy"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA741D8E1A;
	Wed, 16 Jul 2025 17:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752687062; cv=none; b=ej4jwfWtvCIAUK3/xoTgrulC2pbE5e6mQDzhbGyL7IwPoKX++9KfvRwzXp0ZeAaUeCUMgWny2pEpVEtqbfGpch3oLJoGNcUd9T6rSAvMXPOWQUdXfIz/d03U06pMZes+fpgIRXE6oMWhWiNKTssb0A2XO/KpoAffW/f9BCSud5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752687062; c=relaxed/simple;
	bh=PaXYTlyE1AmCd9f7kz8r4SkpNALOlTX1xFZrFy9kj0A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=t7I0qE4UpLN41MRdQW2O6jrNX857Zs2uFye0DyJjERNiAWkWlBVzYPt2SO20aOYsNO8sTL+0nWkO3MNZah+0vZTz7LbKXXjQgpLoFRqnVa8IIfSqYaXd5OQVP0bAQvZ9apXSZm7ZZwZUGlBO/J0WoD7IHxMNzltAewYFtoOpyDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RIsPrqhy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A44FDC4CEF0;
	Wed, 16 Jul 2025 17:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752687061;
	bh=PaXYTlyE1AmCd9f7kz8r4SkpNALOlTX1xFZrFy9kj0A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=RIsPrqhyv6e9Qxaf7h3jN09thDJp15IZQO/mwKshVTqYWa95vzhXZlSxH4erTUW1/
	 N1F+kqa3Fi0D3Jk5hEhCKwaEXoq64BRYzpY1gqHIcbdfCQWTOavi97qhqzxaEAYnwS
	 RoRevb3I2gJBTTmtwLo6Szt/gjD56GbFshfWMcfcEkOScawnBl1UvuHzTa4XhgJSGB
	 5yMeBlder1FV2bxGLHEqLTGSaY3GRInR3di0cjC2jMVct8LRagXyHbBusEth12UhoW
	 y2OXRTuDA82/dyb5XZ4CwPq4cRG/nOEI2E3sv0x2IQgX+lxtDgrbGBXrDfR/MayeLh
	 V1civMqJepi3Q==
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, linux-spi@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kernel-janitors@vger.kernel.org
In-Reply-To: <fb2a26a2-119b-4b5a-8d44-b29e2c736081@sabinyo.mountain>
References: <fb2a26a2-119b-4b5a-8d44-b29e2c736081@sabinyo.mountain>
Subject: Re: [PATCH next] spi: stm32-ospi: Fix NULL vs IS_ERR() bug in
 stm32_ospi_get_resources()
Message-Id: <175268705940.745920.11297005700076211217.b4-ty@kernel.org>
Date: Wed, 16 Jul 2025 18:30:59 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Tue, 15 Jul 2025 18:01:39 -0500, Dan Carpenter wrote:
> This code was changed from using devm_ioremap() which returns NULL to
> using devm_ioremap_resource() which returns error pointers.  Update
> the error checking to match.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: stm32-ospi: Fix NULL vs IS_ERR() bug in stm32_ospi_get_resources()
      commit: 951a6d8d41289b86a564ee5563ededa702b62b1b

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


