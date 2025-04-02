Return-Path: <linux-spi+bounces-7389-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D35E4A78D54
	for <lists+linux-spi@lfdr.de>; Wed,  2 Apr 2025 13:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9EDD18973D5
	for <lists+linux-spi@lfdr.de>; Wed,  2 Apr 2025 11:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF58238D22;
	Wed,  2 Apr 2025 11:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tZJIdwOA"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13B2236456;
	Wed,  2 Apr 2025 11:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743594030; cv=none; b=uBOubf1Cc1vnVgCbMA6c9nOV/4GuKe9ApHJVVBg/9+c8wE86kqJ80PUC4yEyYWSyRDAgQiw2lX1y4QdGxUX6DHKt7lQy172rFX8CEUfpp37Qy2o9Lp20L+0xymqc7jEkU4323eXlhK8xPZF6wmLM11hd9fGsFQjWwrqm9/2rw7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743594030; c=relaxed/simple;
	bh=rWw1nvdooHXL1b328RODRK4t6uLOG2YbVobjGz1PYjk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Lu0HzTuJJuXn6lT+dQkSuGyEfiicDGBStTaUbli5WfSKisLCNiXDb/mU4Wc4Xd+IvJkSqZfvcKtw99AMwnQwgLuIkNXkBtIs39I/Dl/A2HRNTwVLGVw6D1zeK002/++/HRBWBfIBv6YxtFNC4mNKD0lOHh7ij4ksKY/0SDsoHcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tZJIdwOA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DDF1C4CEDD;
	Wed,  2 Apr 2025 11:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743594030;
	bh=rWw1nvdooHXL1b328RODRK4t6uLOG2YbVobjGz1PYjk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=tZJIdwOAq6sWLw00g3WJOxMk/ZXoFvX4Wxd8pQ93qwiGzqrHP5GI4mmTboQsW2H+e
	 brSJ5kE5PSCbW2/TZWNDlb6C9XkHsb6pNVCG66yweM43NkpkH7JztqUVzV+boquyNn
	 5/3GlRbyh/CmVRHoXrDw3VvoUHDEra3+uX/DwzhZENoB7SQARbEbQRfNiB5AjfC1jo
	 rJOrLVfXnqbnOmW9AZT1Xi/dUylVeyLRj5uv6bJO0Y2Ib6uBH2ONqN4D8kDKr08lUW
	 tJUED4We9ySNj9wx+HORMiOd5LMrUH1ANbZW4piJWAPzCuMUrmBcHaHRHnSBgg8OL1
	 wBG+sQv1wz9Rw==
From: Mark Brown <broonie@kernel.org>
To: linux-kernel@vger.kernel.org, 
 Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 linux-spi@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org
In-Reply-To: <20250401224238.2854256-1-florian.fainelli@broadcom.com>
References: <20250401224238.2854256-1-florian.fainelli@broadcom.com>
Subject: Re: [PATCH] spi: bcm2835: Do not call gpiod_put() on invalid
 descriptor
Message-Id: <174359402811.29241.11140395458491844797.b4-ty@kernel.org>
Date: Wed, 02 Apr 2025 12:40:28 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Tue, 01 Apr 2025 15:42:38 -0700, Florian Fainelli wrote:
> If we are unable to lookup the chip-select GPIO, the error path will
> call bcm2835_spi_cleanup() which unconditionally calls gpiod_put() on
> the cs->gpio variable which we just determined was invalid.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: bcm2835: Do not call gpiod_put() on invalid descriptor
      commit: d6691010523fe1016f482a1e1defcc6289eeea48

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


