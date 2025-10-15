Return-Path: <linux-spi+bounces-10669-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 82DAFBDE6AC
	for <lists+linux-spi@lfdr.de>; Wed, 15 Oct 2025 14:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4D4704EB561
	for <lists+linux-spi@lfdr.de>; Wed, 15 Oct 2025 12:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58EB8326D44;
	Wed, 15 Oct 2025 12:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o/X8KPLm"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CCA29CE1;
	Wed, 15 Oct 2025 12:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760530446; cv=none; b=iuktIL7v53yI2rwFHdo+JXS7v0kqCDOus4NSz2ovnY2s99r5RH1px9KJ/uC/NAg98r4ky9oQ6qq/YLeYCX+hdWLWA/nXjMjY5uhC+Xq0G8b0n/tFqlV/TwkQRHxcw/lJnInwTcoduJSI4vAkRCB6C7ogf+piIxD/gSD6ncDA8Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760530446; c=relaxed/simple;
	bh=U0qBfTAoLQ2lXuxhHDpAiZcucUrXqzfYam7mxeAjgzM=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XaejaYF6JHZIKQdh1CMUq/TUC3H0HtNB9RqwmSXwRqtHcECcJtZ1DE1BOQbPGo1arurLMjP0IGd6xsJ4FOHfyYoNy2KeL2u5Aw5DjnTfV61Oxc1g9AVWHKP66fXQrgdiK2Zykaqaiu4HM0C/XjbrOYelP+lGoSCWqqUc6wnVARU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o/X8KPLm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F30FBC116B1;
	Wed, 15 Oct 2025 12:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760530444;
	bh=U0qBfTAoLQ2lXuxhHDpAiZcucUrXqzfYam7mxeAjgzM=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=o/X8KPLmQwvaZ/4jk3aNbggMUsmUtSiTRQlSMl2XJzeWcdxeAHYCVUEkxd4xyQRUM
	 lm9j3UxOz9eAQqeEiw4KJtqK6D9JhqFpzt824g1F5aOEiD9IDRQTb4jnryGTQEKfOs
	 iAlvzz2RFp1CxWICKQO4xi1XyoRewABj3vRnEl7xWHSRMxzN0SpSnDF43LOvksIYR3
	 ACtYefsh+xgYcs1L5mX2EWAr4I/iNRCtLcWAjJJMe7vdTvlm8DBDul72BwYuelziYo
	 OjknTg03VXAm8mwyc8gDIxE4bHcrkdHE7kiuKHSn2QefE+Gc9U5X0I+y7ygwupdVFi
	 /eyOx9e5W702g==
From: Mark Brown <broonie@kernel.org>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 joel@jms.id.au, andrew@codeconstruct.com.au, clg@kaod.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 openbmc@lists.ozlabs.org, linux-spi@vger.kernel.org, BMC-SW@aspeedtech.com, 
 Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
In-Reply-To: <20251001112605.1130723-1-chin-ting_kuo@aspeedtech.com>
References: <20251001112605.1130723-1-chin-ting_kuo@aspeedtech.com>
Subject: Re: [PATCH 0/6] spi: aspeed: Improve clock, timing and address
 decoding logic
Message-Id: <176053044168.105519.1540910122531672579.b4-ty@kernel.org>
Date: Wed, 15 Oct 2025 13:14:01 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-96507

On Wed, 01 Oct 2025 19:25:59 +0800, Chin-Ting Kuo wrote:
> This patch series introduces several improvements to the
> ASPEED SPI driver, targeting better stability, compatibility
> and, flexibility across multiple ASPEED platforms.
> 
> Key changes include:
> 
> * Clock selection strategy update
>   Improves fallback logic when timing calibration is skipped or
>   fails, ensuring reliable boot behavior.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/6] spi: aspeed: Update clock selection strategy
      commit: 31dcc7e1f8a9377d8fd9f967f84c121c5ba8f89c
[2/6] spi: aspeed: Improve timing calibration algorithm for AST2600 platform
      commit: efb79de36e947d136517bac14c139d494fcc72fa
[3/6] spi: aspeed: Force default address decoding range assignment for each CS
      commit: 630a185fd06109193574d10f38b29812986c21de
[4/6] spi: aspeed: Centralize address decoding region management
      commit: b546e0023a203e7edf9377ac8f4f490a6965afd6
[5/6] spi: aspeed: Add per-platform adjust_window callback for decoding range
      commit: 0586b53d4a0c7c5a132629f99da934cc674ea4cd
[6/6] spi: aspeed: Only map necessary address window region
      commit: 64d87ccfae3326a9561fe41dc6073064a083e0df

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


