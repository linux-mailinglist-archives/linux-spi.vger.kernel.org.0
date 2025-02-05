Return-Path: <linux-spi+bounces-6628-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC3DA28AAA
	for <lists+linux-spi@lfdr.de>; Wed,  5 Feb 2025 13:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 947A9168F7F
	for <lists+linux-spi@lfdr.de>; Wed,  5 Feb 2025 12:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4F922DF85;
	Wed,  5 Feb 2025 12:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L/2y+5Pb"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2488222D4D5;
	Wed,  5 Feb 2025 12:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738759488; cv=none; b=BEup/b6nKpQk1BxBAdf8Llhy4eyTbzBkGTgycNZtPmLTzwGBdZh/mPFjo+IYU4j65WPMkrVuMKP+uLC50M8uSVcbyn5Qd9vfMPrwwZ5/4Gh8YxlXjSIubI9eAWdU+7m3ukp9sFt+UUX0NG1kHBZjfPpuHKuWlysg6US7Dc4RvNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738759488; c=relaxed/simple;
	bh=WjOWuwc31YAtptEAw9A+7e2wI1Rg1m7tf432kIXNr2M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JnsCRHASRz//H32u3kyuGc/TQRPTHafbk5wLOJ7Ocw+m6wiY3y3RkKEGnGoZaWlpTAsc50EfklEuQDiD0QHOkkKuuNyEJV7m7r6dUNBMhWuAEMM01IjINmH8RwaKgeEg/TyrPWl+6jSXaNkarKTE1EANerE9hVSv8MHR/6TZTyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L/2y+5Pb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 217F1C4CEE3;
	Wed,  5 Feb 2025 12:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738759487;
	bh=WjOWuwc31YAtptEAw9A+7e2wI1Rg1m7tf432kIXNr2M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=L/2y+5Pb3U2QLXrnI6glT2NEJ3qTFmWNgyGPbk5I8w8Z6TPjkZQAssidNpDtTlhVA
	 DSxHZbnAyukWeIx+QJbBAEHaPrTjtwP6pnO2WdLKOzJXa2++nmNcAwKqGZjgmY8Rrm
	 jf0hgtDcjgbiC9h9DV/UrIgeH+dR4qXMnUdxSOCgrPC4oVIDR7+OvrIJpYp68YNXeD
	 TyzP/dO0xBERzxvw5bbQ0QYQzBEiRxqDUwYnsTSTtc5PWQsLmh4nsdlbiJNjPQW4/E
	 WFPYtb9XLM4H7jyCaq9Yob6ewPLGmdivdovAU9WnsXm8y10yOVrbJXl/rj5POPLsVJ
	 TFL74Q2GfS6Lw==
From: Mark Brown <broonie@kernel.org>
To: linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Daniel Mack <daniel@zonque.org>, 
 Haojian Zhuang <haojian.zhuang@gmail.com>, 
 Robert Jarzmik <robert.jarzmik@free.fr>, Mark Lord <mlord@pobox.com>
In-Reply-To: <20250204174506.149978-1-andriy.shevchenko@linux.intel.com>
References: <20250204174506.149978-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] spi: pxa2xx: Fix regression when toggling chip
 select on LPSS devices
Message-Id: <173875948587.32625.7550036600044619684.b4-ty@kernel.org>
Date: Wed, 05 Feb 2025 12:44:45 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Tue, 04 Feb 2025 19:45:06 +0200, Andy Shevchenko wrote:
> The commit 78b435c9044a ("spi: pxa2xx: Introduce __lpss_ssp_update_priv()
> helper") broke speaker output on my ASUS UX5304MA laptop. The problem is
> in inverted value that got written in the private register.
> 
> Simple bug, simple fix.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: pxa2xx: Fix regression when toggling chip select on LPSS devices
      commit: aff2355d260e47e780cd96af127beaab18a664b1

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


