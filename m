Return-Path: <linux-spi+bounces-8473-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E34D9AD7081
	for <lists+linux-spi@lfdr.de>; Thu, 12 Jun 2025 14:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBE901885E32
	for <lists+linux-spi@lfdr.de>; Thu, 12 Jun 2025 12:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4FAD286A9;
	Thu, 12 Jun 2025 12:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uzy2FMc7"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57782F432A;
	Thu, 12 Jun 2025 12:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749731610; cv=none; b=GItq5DDxRlsJEG3esghpltlH4jXEhg5ql9hod273tDGdnMfPBZqhimkNiivppDgaEeBzL7OiPdwWkBQazwUrgVJrBBYZG7toCijakxgzO7W6hpjFp0R4GfX2+OmisI+lIpLIZJAjON5NhKUYSWKJrtaVYMwJciqfwarJbUcnXdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749731610; c=relaxed/simple;
	bh=XHmQstvfanfzC7FHLXlVhn+/xiU+w0Rr72xmTwR0M/0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WttVojjXsAtD+0P0+XfiYWC72WyeJ6fQC3mGIU7HWf3o5TuQqIzS54avCoOoVVKSRW3H3F9J0KlYha3+G8mjoqq9CDCat8e2AzPQySSFht2mGIEObY4+DPEGAYYv9cqmKnDygh9S+eIIBK51gWDukOzTUiTfpRpQG1fXLKlwxwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uzy2FMc7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FC6BC4CEEA;
	Thu, 12 Jun 2025 12:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749731610;
	bh=XHmQstvfanfzC7FHLXlVhn+/xiU+w0Rr72xmTwR0M/0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=uzy2FMc79vbPGrR43FVIRsW3RKK2BWPs5tvdvyhHo3bDQ9dYV1OHot8dEKGiUkv5i
	 Vqd0z7T4DoLAo0ylOfrW6XYtXff+4qksm5pM3IlbUma2a4N6zgutsOVo0gcn4BxX4P
	 wZhj86qHv1QQJaiAPvNRQxw9YGjrzkiRp0jyXX1mjZ38k0/buFdv72Gj3J6YtwdeYW
	 076BPvDjjiFIua3RTBbG+piMmTiimVwTcf26gBMTxO/YIobw71ZckdQmWjWvoaAHwy
	 XXN4WEJU6aRr80V42EPitKowp3AuPZPS9nFYBQtBNu3i9hI2yu3LUOOxDxvwvzracR
	 dDU2DcbQC2NXw==
From: Mark Brown <broonie@kernel.org>
To: Patrice Chotard <patrice.chotard@foss.st.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, linux-spi@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kernel-janitors@vger.kernel.org
In-Reply-To: <aEmAGTUzzKZlLe3K@stanley.mountain>
References: <aEmAGTUzzKZlLe3K@stanley.mountain>
Subject: Re: [PATCH next] spi: stm32-ospi: clean up on error in probe()
Message-Id: <174973160798.39704.11177150841033836429.b4-ty@kernel.org>
Date: Thu, 12 Jun 2025 13:33:27 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Wed, 11 Jun 2025 16:09:45 +0300, Dan Carpenter wrote:
> If reset_control_acquire() fails, then we can't return directly.
> We need to do a little clean up first.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: stm32-ospi: clean up on error in probe()
      commit: 83f066fac3c231e58e9adf3b307e96fee172dfb3

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


