Return-Path: <linux-spi+bounces-12240-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9B4D0AF1C
	for <lists+linux-spi@lfdr.de>; Fri, 09 Jan 2026 16:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E3F7530BEECD
	for <lists+linux-spi@lfdr.de>; Fri,  9 Jan 2026 15:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E3A313E19;
	Fri,  9 Jan 2026 15:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z4w1nxcc"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA158288505;
	Fri,  9 Jan 2026 15:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767972612; cv=none; b=OXm/gxV7ZaR6u2gt4z2tNSVXnFm4sQXdEYNh6F9m9Cs3wHu6QmJtJt3tA35015mDqZHtAK6qsNfmIapjB0KT6GklaSPUoF0ukYswt4FFcZLE6ux2u+/LfF5mX7I2lrfeSIPjKHYWHERR3ngyruysQC9uXf7n4m15jJwDbGLVVyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767972612; c=relaxed/simple;
	bh=CVMPOaxDs8+TNFQb6yWujrE4hu02VsB/ZEa3zMEvSfg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZhBhS8QZA7+YFx+jbdYrs3/V7J1/3LYyxVN6e+UzLO1Ldg4B9gkdS/65BJ7IiIyM++lQnY8+shHUlLEPT1j4kdEqQOn7jEZsPMUP6BkzAmSn7e94UjG/KJG11PSctoR2JEgwBMZdnfcnWafsQzRY140mShTfK5K1fo7CNy3HAnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z4w1nxcc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6165AC4CEF1;
	Fri,  9 Jan 2026 15:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767972612;
	bh=CVMPOaxDs8+TNFQb6yWujrE4hu02VsB/ZEa3zMEvSfg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Z4w1nxccMwDXZMUmWI9nQbpt7pozew5OuQm6gygdaRkuhBILy40StzF90aHnZ6Wn1
	 6um+2EEDPRXP4j18pcyokjZ03ysOzsS6zjTxmC+U5NSeNsxNh43U3LbtC1hmWzmT1T
	 mVkAni051WI+p95RNhNp4MnTbVy5IHOgNDS7HUxGRVjp+CgkJDBYx+3jIemfo8LB6Z
	 KHqfmP5wJrsUwjfh/TVtirswK/XGq1SvLfsyAYVlrnqnz/9E8vaeMhshRY3dsDnpJ+
	 5b2UTaRg7FZnz+1K4ljx8ZeF8F+N5676dIhE/eIBVeLosdyunmITxsisoql/QM7kNc
	 jVdm0xAWXs6bw==
From: Mark Brown <broonie@kernel.org>
To: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Conor Dooley <conor.dooley@microchip.com>
In-Reply-To: <20260108175100.3535306-1-andriy.shevchenko@linux.intel.com>
References: <20260108175100.3535306-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] spi: microchip-core: use XOR instead of ANDNOT
 to fix the logic
Message-Id: <176797261111.67850.5868118938886891604.b4-ty@kernel.org>
Date: Fri, 09 Jan 2026 15:30:11 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773

On Thu, 08 Jan 2026 18:49:40 +0100, Andy Shevchenko wrote:
> Use XOR instead of ANDNOT to fix the logic. The current approach with
> (foo & BAR & ~baz) is harder to process, and it proved to be wrong,
> than more usual pattern for the comparing misconfiguration using
> ((foo ^ baz) & BAR) which can be read as "find all different bits
> between foo and baz that are related to BAR (mask)". Besides that
> it makes the binary code shorter.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: microchip-core: use XOR instead of ANDNOT to fix the logic
      commit: 19a4505a7a5d4eea70f1a42d601c25d730922fdf

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


