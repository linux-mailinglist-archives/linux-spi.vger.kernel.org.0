Return-Path: <linux-spi+bounces-5257-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E63A29A4839
	for <lists+linux-spi@lfdr.de>; Fri, 18 Oct 2024 22:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1840B1C21040
	for <lists+linux-spi@lfdr.de>; Fri, 18 Oct 2024 20:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3672B209F5A;
	Fri, 18 Oct 2024 20:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SGbUTABL"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FEA206962;
	Fri, 18 Oct 2024 20:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729283752; cv=none; b=aNP94IPd84weu4jAenzvuJDo9xtgezp4WP82UI8+80NarCUEclZOzyiONJCFetHVRMHdzAt1XrTjLLR0vE3Phk0vRvMWCHFy4PPc3STl3w3wwLq5nAQj3BIO35qNsz6hBcqSU/do7X55eTqssI8DNiY1Ee9lpeAQNNSOaAnkw/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729283752; c=relaxed/simple;
	bh=BAQ5z9sS+Ko94We0Rfy803/2ls8WHnKVBHA4vcGpjw0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oPa0zesvku4GxGh76W0MwTKSpSb+jf9LROVRUjTgJwihzbyvNtL7RrR2+HxlwUSZP9jEDTSg9oOzu50KEkjGXA0fDdkewUehUHkciNV0xZ9hJdjDbAOV6cHFtHoG78fHMfxH2QzFhCulAy0vVeA7kS85DrucOgM3Ab4qLOUz19k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SGbUTABL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC4EFC4CEC3;
	Fri, 18 Oct 2024 20:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729283751;
	bh=BAQ5z9sS+Ko94We0Rfy803/2ls8WHnKVBHA4vcGpjw0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=SGbUTABLh9rtaPjCXa/9C31Yks1XvRmyu/XgfimxEF19F3upvPfbONJF1CG5UIoVp
	 XFEosaaRdy/e3CXNH4a9pU0dmbXFj8MX5i42JnYkikV4sX/W6S2H3RpORMOoEGmqZM
	 TwG6GeDVon8u2Fma8OtVjoMPGsIUSUbkySYa/bmXNM/CBEAAJkxr8/BNV92CQz5+NX
	 ZiGa5dmj/gyRE06AjzhAddUMe7OBiYFF0VUKq/YXbmLVud+VQzJCjP2lV1d3M42I0G
	 mWrAVB5i1Jyli9oE4S5SJRlQoJXryx4OSQTOblMh7OCzibKkHjgZDERU0P0MNq5ud9
	 Q2+NvdKphsaEQ==
From: Mark Brown <broonie@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
In-Reply-To: <20241018122437.64275-1-brgl@bgdev.pl>
References: <20241018122437.64275-1-brgl@bgdev.pl>
Subject: Re: [PATCH] spi: make class structs const
Message-Id: <172928375050.197370.6422486622315269849.b4-ty@kernel.org>
Date: Fri, 18 Oct 2024 21:35:50 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Fri, 18 Oct 2024 14:24:37 +0200, Bartosz Golaszewski wrote:
> The two instances of struct class are only used here in functions that
> take const pointers and so can too be made constant.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: make class structs const
      commit: 36dbe4521a381fd4d2561a90200ae4a2a3efb222

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


