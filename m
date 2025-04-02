Return-Path: <linux-spi+bounces-7395-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2A8A7920D
	for <lists+linux-spi@lfdr.de>; Wed,  2 Apr 2025 17:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91CA21893A67
	for <lists+linux-spi@lfdr.de>; Wed,  2 Apr 2025 15:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED68923C8B2;
	Wed,  2 Apr 2025 15:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FoBJxK2r"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D0C23C8A8;
	Wed,  2 Apr 2025 15:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743607232; cv=none; b=iAgpU8v8eyyVrch/de3ypI30GWTedChruENMidGFXLTvuj27LR7Mwsr1RzjNYkIUtQwJBgMmN0cvHpsyEVhNLM1vBFV5RPESld9T0GBYhmnt6LVLFH2OtJf3/5br4PFJfOEAqoHacYik8XGrO42RE9IT28vJz6dQpXz8ZHtUj8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743607232; c=relaxed/simple;
	bh=3klwY/13y3eX/XjL82BJOviHTrEYQAUzY4Y9RpKHRZ4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gh+LtPoJszfG2lAV/TsqP+2BVfQgI6CGBSFsVXeBhKcV7edPdxOpLWpgiUTyCYFUDNmFuf18+8vafkDcJ+Byg6qI0VEfiv4TvhJDRPCWu0JDPZXZgoz9z8dR9UrSrrREe/tDgpiDX9pIC9WPDfZIHA8eHj9oW5z3VduCQoKmW7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FoBJxK2r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FE1EC4CEDD;
	Wed,  2 Apr 2025 15:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743607231;
	bh=3klwY/13y3eX/XjL82BJOviHTrEYQAUzY4Y9RpKHRZ4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=FoBJxK2r4cGE5dlTh4rBu7MeILUjBBiBhUiou49P7bRTgWiEvokTB9ms1l53E9Pzb
	 q0zoBpo6FT+E4H55yt9Qjz9MZaSxSwegFZyRm+F1+gOYUnZ5LiVJ6vSMWl3Ilo99vX
	 RzruOvp74nMDWxiw24lu5b/FH/TlpHw+tK9vKLiZz66cbKp68LDjb6SF5GpO/EKwxT
	 IGDsAu0pgAtsdpwhEys50l2wwvZ7kvYki91URZqfNQpeyn4K+Bb08LTmHRYuWlrR5a
	 K2mK9U4GxQfyZqOYm1nznvDzzYvXCKuO7cR6pgswU7IsIu+6hlgyJE5UINOokQ5YPV
	 eRYMgI1JbOhYw==
From: Mark Brown <broonie@kernel.org>
To: linux-kernel@vger.kernel.org, 
 Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 linux-spi@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org
In-Reply-To: <20250401233603.2938955-1-florian.fainelli@broadcom.com>
References: <20250401233603.2938955-1-florian.fainelli@broadcom.com>
Subject: Re: [PATCH] spi: bcm2835: Restore native CS probing when
 pinctrl-bcm2835 is absent
Message-Id: <174360722920.71466.13412350626935947497.b4-ty@kernel.org>
Date: Wed, 02 Apr 2025 16:20:29 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Tue, 01 Apr 2025 16:36:03 -0700, Florian Fainelli wrote:
> The lookup table forces the use of the "pinctrl-bcm2835" GPIO chip
> provider and essentially assumes that there is going to be such a
> provider, and if not, we will fail to set-up the SPI device.
> 
> While this is true on Raspberry Pi based systems (2835/36/37, 2711,
> 2712), this is not true on 7712/77122 Broadcom STB systems which use the
> SPI driver, but not the GPIO driver.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: bcm2835: Restore native CS probing when pinctrl-bcm2835 is absent
      commit: e19c1272c80a5ecce387c1b0c3b995f4edf9c525

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


