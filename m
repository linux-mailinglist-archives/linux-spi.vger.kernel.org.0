Return-Path: <linux-spi+bounces-4461-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED92B9662DA
	for <lists+linux-spi@lfdr.de>; Fri, 30 Aug 2024 15:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C6821C21B90
	for <lists+linux-spi@lfdr.de>; Fri, 30 Aug 2024 13:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90561ACDE8;
	Fri, 30 Aug 2024 13:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g0ilzp/3"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926A3199952;
	Fri, 30 Aug 2024 13:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725024371; cv=none; b=DIxbskL7dO2YsiJV/zASrJRxaipFlGQRWjIBZxJrdtNBapv0T6ZSbqcnxZ9DnVJ/eEaFUH4dfxj0/7bh8c1/P8AcOOhgg5zkl7G3V4Rv4ymOSNBkyr3S4DrOOgOSbVLWuBcfk6tXr7XP2CN45U6hmxLa09VvWK25+RqvvUmAgSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725024371; c=relaxed/simple;
	bh=hhLF6zJUZmiXd4ASLdaosjDIG/vFcF9iV3YTaokVuKA=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hiic3V+fZIq6NJl3jQUX+av6lvfA+5qJAuQW82WJ4CV5W9aFVbR/Gh0jixAh//JSdWfHVohljgi6usDdIH3+WnLBJSjzB/d2NQGJbPocA0Z4ADo6mJ92zA12jcWFKD0DbXNjt8EanxuBNKduBaHuV8D/bxuIGXKQysXwd7ATdFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g0ilzp/3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18A1DC4CEC2;
	Fri, 30 Aug 2024 13:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725024371;
	bh=hhLF6zJUZmiXd4ASLdaosjDIG/vFcF9iV3YTaokVuKA=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=g0ilzp/3Q0SyHw5De1u388CUAzRXQnhdeE2O7bp1731bCG47HDctzewVk/E3FFZNQ
	 mtqwUWqeS8GF65HBAcy4d3b3jfc+WBqQNOJrzjGdX8TfzLdNIqgHmHvVkzc+JaLAAU
	 cTYc6y3Coch/yuqcoMNowQODoCTuHoI31pNQIeu9WiP8GlWxrXZN3i767ByQkAOB1U
	 Y9RJiiaQY7nybFDaXINtTIx11fGiHfnJ8/mM8zUnNXI+GaOTBwz+LWmvCsHAL2pLBg
	 5I2jeKdmuKlisu4O5X30byp56ZHb/tU49Nr8LAfe6N+gbKQFkYSGNMQdmpE0SecRo4
	 0btWMsm19Ke3g==
From: Mark Brown <broonie@kernel.org>
To: william.zhang@broadcom.com, kursad.oney@broadcom.com, 
 jonas.gorski@gmail.com, bcm-kernel-feedback-list@broadcom.com, 
 anand.gore@broadcom.com, florian.fainelli@broadcom.com, rafal@milecki.pl, 
 linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20240826124903.3429235-1-ruanjinjie@huawei.com>
References: <20240826124903.3429235-1-ruanjinjie@huawei.com>
Subject: Re: [PATCH -next 0/2] spi: bcmbca-hsspi: Fix missing
 pm_runtime_disable()
Message-Id: <172502436875.145364.3026467217364191403.b4-ty@kernel.org>
Date: Fri, 30 Aug 2024 14:26:08 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Mon, 26 Aug 2024 20:49:01 +0800, Jinjie Ruan wrote:
> Fix missing pm_runtime_disable().
> 
> Jinjie Ruan (2):
>   spi: bcmbca-hsspi: Fix missing pm_runtime_disable()
>   spi: bcmbca-hsspi: Use devm_spi_alloc_host()
> 
> drivers/spi/spi-bcmbca-hsspi.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: bcmbca-hsspi: Fix missing pm_runtime_disable()
      commit: 11543f534adf7436239da26e5efa495adb47615d
[2/2] spi: bcmbca-hsspi: Use devm_spi_alloc_host()
      commit: deb269e0394f2c75e1735132e29fa2f5181e107a

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


