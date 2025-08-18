Return-Path: <linux-spi+bounces-9517-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4659B2B284
	for <lists+linux-spi@lfdr.de>; Mon, 18 Aug 2025 22:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E468B5E6DE5
	for <lists+linux-spi@lfdr.de>; Mon, 18 Aug 2025 20:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1437E22759C;
	Mon, 18 Aug 2025 20:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jNvtiu9B"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0D32264B7;
	Mon, 18 Aug 2025 20:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755549351; cv=none; b=Q8AHL/qBmR3I1LZZYBOmUEafo4RY1R0hqUNzIDgC2w0a0oWFC2KaKuENENpUagSpg5KanK+iMmI42+FsyRnfMmW1cx1lDVSLj9QpF2MFAPGbFfkziiS0twGOkWasXBA9nn0WqN8JA9fGuWv6u0bZH3KJxtPFJ4HxqIty4i58X3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755549351; c=relaxed/simple;
	bh=3FNIrSrbsu9RaCaylgRfhBY+Szb1MReX33guiAuehuo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IA9hMCQA+poUlhDaw3CJPvuTJFWX5CFOcron+qlmYQ7ySt4tyO3EWCuyLQLz+ItsCwOBJcHmsdBzITvpl5/9sQv974Ck1NRj8qXNGnGGYid5w+NHLBsSA7bob9iDsV/5CcMDtDuDN06ui913vOozsRInTcQJXVzfnzR+1IyyUYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jNvtiu9B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E02DAC4CEF1;
	Mon, 18 Aug 2025 20:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755549350;
	bh=3FNIrSrbsu9RaCaylgRfhBY+Szb1MReX33guiAuehuo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=jNvtiu9B3MuJ5D7mhTFU0Swy4KJjmFclyJpTn3tNbUrpoGIgZx/5YXQMa/YhHP6Fe
	 eeQnunZ+7NcZIX18JVE+R/UhTw5wsN4CtNN9MtaqoPId3npim4+Z830RwDMW+x75xy
	 i+oHrFpYjE7OBQeAiXQYX2IVeqjuyQMBZYYKOlIn+YJjuAkBmWQACPGn2Kf96huwj2
	 PQ588iYEIypaCVyScz+dWYeANunxNvd0628s+e7DVELaIgbmOSx0FmCNT0nDKlxs6c
	 oPWp1NUrb/pR+g1LA1sjerH9YyZCDAWoUMIsIrQjmom4VWWauon1U+Oveb/+8xcKhY
	 35nEvCrshL56A==
From: Mark Brown <broonie@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
In-Reply-To: <20250815-spi-offload-trigger-followup-v1-0-8ec5413a8383@baylibre.com>
References: <20250815-spi-offload-trigger-followup-v1-0-8ec5413a8383@baylibre.com>
Subject: Re: [PATCH 0/2] spi: offload-trigger: followup
Message-Id: <175554934965.130972.12428240326020215093.b4-ty@kernel.org>
Date: Mon, 18 Aug 2025 21:35:49 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Fri, 15 Aug 2025 11:43:59 -0500, David Lechner wrote:
> This cleans up a few loose ends from the series that added the ADI Util
> Sigma-Delta SPI driver [1].
> 
> [1]: https://lore.kernel.org/linux-spi/20250701-iio-adc-ad7173-add-spi-offload-support-v3-0-42abb83e3dac@baylibre.com/
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] MAINTAINERS: merge TRIGGER SOURCE sections
      commit: 07826c02eda9da406524bd50cd3fd321be8c9447
[2/2] spi: offload trigger: adi-util-sigma-delta: clean up imports
      commit: 0056b410355713556d8a10306f82e55b28d33ba8

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


