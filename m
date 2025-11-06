Return-Path: <linux-spi+bounces-11074-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 39707C3A99A
	for <lists+linux-spi@lfdr.de>; Thu, 06 Nov 2025 12:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 89F264FE688
	for <lists+linux-spi@lfdr.de>; Thu,  6 Nov 2025 11:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B63A30F948;
	Thu,  6 Nov 2025 11:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oX66K/1+"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA9C2F5319;
	Thu,  6 Nov 2025 11:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762428863; cv=none; b=eLmAGnKPlV2MGerzWFmABpsmX8HGRlpb8pNw33tJW/vp+Cts5tSxJBHsnbl1ZoOIy0uAwzepniqf6lsQh0MRbiOg5D5i860q2VVk31gZ4gGt82gJhlZ09DtwS/XPBUSBQ65T3U8YBdh2oW3lSu5sZNycR1AdqaCy8rc/eQG6QbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762428863; c=relaxed/simple;
	bh=T2e1CEeBC86g0hAUrEO/6mII8tHJpPR0/B+Jl0WARfo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=u5NnjqKpVujNdHDcv7XeIa58BUCBZ1wGHxVVSTNO/sXrxBIM61zKw3Rb+Ac0w7Hq7sCTdIwXY1g78MYQNobR8WaTjnDTGXDEl186V1KOAnpEziR1qi5K4sCH7ZxO1sysdsZd+emVe2CUZuQ/PjGVI3uRW3f5H9xKSUzZ368sBRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oX66K/1+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADF56C19422;
	Thu,  6 Nov 2025 11:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762428862;
	bh=T2e1CEeBC86g0hAUrEO/6mII8tHJpPR0/B+Jl0WARfo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=oX66K/1+OBYJl6YhTqbrqUycfpsMNYq5Tzl9/YhUJ3NiRnctVdThOKshdshkqcQQz
	 wBYuynXyZzqnJkcaGqKBSy1NB/FoCvSUyLbb722rLcAIokk+sSYOMx03pkEm0bDbhu
	 vChzuanK8+00Of0HlgeZAhvJL/w9EkImthQ3eoWmqTeogE2nRv/rEn1cFQ+BoWW8+p
	 qZkG73nWrIewsJeo64BvHUGCyT70Jnupp6YNBp2BMaCszqb3SxTS74m0ZQ5ibniOEN
	 OQUdYv5McHs1ebZhN3b0rBWYHKRcw0H1XyMGe9T9nJixe9/o5+/n1pKTR8uUenXwfZ
	 SSA4rTebHxPEg==
From: Mark Brown <broonie@kernel.org>
To: Hans de Goede <hansg@kernel.org>
Cc: Andy Shevchenko <andy@kernel.org>, linux-spi@vger.kernel.org, 
 linux-acpi@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20251102190921.30068-1-hansg@kernel.org>
References: <20251102190921.30068-1-hansg@kernel.org>
Subject: Re: [PATCH] spi: Try to get ACPI GPIO IRQ earlier
Message-Id: <176242886085.2357454.1138821772017853306.b4-ty@kernel.org>
Date: Thu, 06 Nov 2025 11:34:20 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a6db3

On Sun, 02 Nov 2025 20:09:21 +0100, Hans de Goede wrote:
> Since commit d24cfee7f63d ("spi: Fix acpi deferred irq probe"), the
> acpi_dev_gpio_irq_get() call gets delayed till spi_probe() is called
> on the SPI device.
> 
> If there is no driver for the SPI device then the move to spi_probe()
> results in acpi_dev_gpio_irq_get() never getting called. This may
> cause problems by leaving the GPIO pin floating because this call is
> responsible for setting up the GPIO pin direction and/or bias according
> to the values from the ACPI tables.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: Try to get ACPI GPIO IRQ earlier
      commit: 3cd2018e15b3d66d2187d92867e265f45ad79e6f

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


