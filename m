Return-Path: <linux-spi+bounces-7668-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0192A9316C
	for <lists+linux-spi@lfdr.de>; Fri, 18 Apr 2025 07:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D2EC19E4430
	for <lists+linux-spi@lfdr.de>; Fri, 18 Apr 2025 05:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE87257440;
	Fri, 18 Apr 2025 05:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u5nK0vmI"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32250209663;
	Fri, 18 Apr 2025 05:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744953946; cv=none; b=DbOHmHDBTFbFBOESyMOU6q+4o+rQfwKGJrp1BdbIF/zbDaeBuvgIhOomR5+7XhdgBYlPhlS7zbfHrN+E5EM0XG6Zo6glZtz9mWbVoaWI4Zfawj06Xps41gOOPfbi87pRPP8BDDUnq3m0TldrXGH+WtOiPfbfHulmiTABfujofK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744953946; c=relaxed/simple;
	bh=/8f4vxtYyB/V+kCm6aqTnsXvFS9dcZnLjfZIW2krjdo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GtbpSeNgiwd6zpidk5FkHAq0zfVN/lcOxKImzm5O9J1BVBOJFi5B+C3QLpFwVWOKYHwQm4IQw5PjrMNHQe0yqoK/SKh8clljMK5B9yU0mThxcm6uAhb66l/efWwb1qUK35VYjLTIK5b/anh7WTBTvD3rnQfT3u1BWQlu3LPm4GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u5nK0vmI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7CF8C4CEE2;
	Fri, 18 Apr 2025 05:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744953945;
	bh=/8f4vxtYyB/V+kCm6aqTnsXvFS9dcZnLjfZIW2krjdo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=u5nK0vmI2O/pNFd1RpoMbWc0WlRhbvgqrgC8EcFvdwmXeB08RAmuab2fMIpVMM1f+
	 +aXQT8lHGcWi0r8aRg/DrfR+6acHG6hHWfZWrqENZs1eiFQKEj/AEr+tr6PqhRtHpO
	 EsaYn67w4L3SeOMYuoanK7EZrFTAk5GACxJBE99DXoswz4QKV2NevsFN6ZhOn3E3Jt
	 E1tTssfgQs0HI+l7VeL2KiRiDGBxBMuNHHBTKS5vfoZHJ0EEvlJh+LH3OMiey4BO0b
	 uzbyawAgp6SbFQQy9GXJ4y162VhNicZDEEPg8SnDOzz6WRuWHfpYUN3YGHsLbhjYOa
	 01gILpvyZb19A==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250416062013.1826421-1-andriy.shevchenko@linux.intel.com>
References: <20250416062013.1826421-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 0/2] spi: Introduce and use spi_bpw_to_bytes()
Message-Id: <174495394455.356683.9927646118751664689.b4-ty@kernel.org>
Date: Fri, 18 Apr 2025 06:25:44 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Wed, 16 Apr 2025 09:16:33 +0300, Andy Shevchenko wrote:
> Recently in the discussion with David the idea of having
> a common helper popped up. The helper converts the given
> bits per word to bytes. The result will always be power-of-two
> (e.g. for 37 bits it returns 8 bytes) or 0 for 0 input.
> 
> This mini-series introduces it and replaces current users
> under drivers/spi and we expect more (and possibly some lurking
> in other subsystems).
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: Add spi_bpw_to_bytes() helper and use it
      commit: 163ddf1fea590229c30a8dc4c29ff4febfb895c3
[2/2] spi: dw: Use spi_bpw_to_bytes() helper
      commit: e30b7a75666b3f444abfabed6a144642fa9994d8

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


