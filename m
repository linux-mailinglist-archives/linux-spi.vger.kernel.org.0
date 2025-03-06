Return-Path: <linux-spi+bounces-7061-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97186A5504E
	for <lists+linux-spi@lfdr.de>; Thu,  6 Mar 2025 17:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 072213A9924
	for <lists+linux-spi@lfdr.de>; Thu,  6 Mar 2025 16:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8671F2144BC;
	Thu,  6 Mar 2025 16:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JCqBfell"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B452211A2A;
	Thu,  6 Mar 2025 16:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741277442; cv=none; b=imrsCciLKZmHXYGNsXIo8i4EFlEEC09RVIAiq5Vkn83U9Nr4IWw+WWg3F6eCfnY4FRADj6lp0HO2iQQf2LwzRIu/L6iMj6vbPFyc0XwB8610IR/cbFSig7YvDeKPdx5j591LTqBGzQLqjoHOotv0ZNh2Ybo9tk0IzZOqe1ofhdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741277442; c=relaxed/simple;
	bh=dO5KuEHT5N6JPz0mZT1IGgNKs9grKUWa+Hx4+yx3kc4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tzq5kf39wsFuO3rKle4j8s8rfFBS8vg5tYGsxi6VsK4YyIualovMDnYSDvCmrvksughsCC0kx8FJKYtaiyZsE3FNuergUUDXvoj3bQ+yHJwLD//1ulDbRFU1PQCu6Kcbx7bfyLs3c/8J0RUaoNnOok4WoFQxHnGz0s04p7wIDCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JCqBfell; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11E12C4AF09;
	Thu,  6 Mar 2025 16:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741277441;
	bh=dO5KuEHT5N6JPz0mZT1IGgNKs9grKUWa+Hx4+yx3kc4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=JCqBfelle7bd3f+VaMdYkAAJYOLVyqPuRy+iagi9Fuw7JAId6/MsywpvuUBHTwnq1
	 KvNpYZCs3czm870bWeKDTn0jRE0gxCsoMYcIrC5aYwe5zx/2k9GYF0rw9epTuSDhUV
	 S0lLbFRV6Ur7yI9KI0CV5CJguD66+/7N1mtPAc6kcrNYarmwS6dTZSHWzB2SZhLc0f
	 Z+lCGPXOl3bMpSMFPt078zrZtRfxTWL2o3ldBZqMbFYKHtYm4jHknp88vi7GI+GY8V
	 BuL7zfDzeiyVfRUcZqHoX0TT6Yh8JmS0UYqTnAGpkX09C/tWXrJzOM7bg+FSs6SCkt
	 wmh0cJSryQ2bA==
From: Mark Brown <broonie@kernel.org>
To: Patrice Chotard <patrice.chotard@foss.st.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, linux-spi@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kernel-janitors@vger.kernel.org
In-Reply-To: <bc4c9123-df43-4616-962f-765801d30b4c@stanley.mountain>
References: <bc4c9123-df43-4616-962f-765801d30b4c@stanley.mountain>
Subject: Re: [PATCH next] spi: stm32-ospi: Fix an IS_ERR() vs NULL bug in
 stm32_ospi_get_resources()
Message-Id: <174127743980.139137.18227484559909848489.b4-ty@kernel.org>
Date: Thu, 06 Mar 2025 16:10:39 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Thu, 06 Mar 2025 12:48:34 +0300, Dan Carpenter wrote:
> The devm_ioremap() function returns NULL on error, it doesn't return
> error pointers.  Fix the check to match.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: stm32-ospi: Fix an IS_ERR() vs NULL bug in stm32_ospi_get_resources()
      commit: 7dfc9bdde9fa20cf1ac5cbea97b0446622ca74c7

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


