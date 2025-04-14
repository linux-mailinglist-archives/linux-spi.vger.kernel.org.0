Return-Path: <linux-spi+bounces-7575-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83549A885A5
	for <lists+linux-spi@lfdr.de>; Mon, 14 Apr 2025 16:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 258A3190581A
	for <lists+linux-spi@lfdr.de>; Mon, 14 Apr 2025 14:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB69127F74B;
	Mon, 14 Apr 2025 14:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KyP9D3Nv"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8676C27F73A;
	Mon, 14 Apr 2025 14:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744640728; cv=none; b=G4vP7eL853s1u1MZqqObSVnMbXxbZtm8whLA/bo8HS6nQ4L//j2eywgwps3gLPYUclw5kDBhzwKoa7xaFuWLEpxQh23k07sLhsaHJYMmbjWsB70AevaoKQA7W5KcPtkEDtrvYRq/f30O/1h4hsUxN1ygR/5my0xJJ+KSpa/fBt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744640728; c=relaxed/simple;
	bh=3daDj0mcIsp68OogGpd0fzNPIdyotvmgnk6RkCbuVWc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cnU2LjeRg4GC6PpCA5TF8rPtfH6dP1nGMMTMadO4ddvb8JY2RpRiasQu74338fPKLs1+lnt5T6fQsSEgj9VLLqPkhK/GDh7gWUPVa/PUNVYm6DnpHAUawpDBVtdj+vzfGKns2wn++R6yIFw2TYByQHnwoSedy0MOxnGCIG8llpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KyP9D3Nv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FE2DC4CEE2;
	Mon, 14 Apr 2025 14:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744640727;
	bh=3daDj0mcIsp68OogGpd0fzNPIdyotvmgnk6RkCbuVWc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=KyP9D3Nvl9VPs4Y+adIbgJ/kWDV8oOJFDl25SW4Z8E3+fC5MdUg2iVjQ3ngxK6IHd
	 xveMv/ctz4aIS3rkjZhiFXun4FauYhVpTc2nNHA4xMvq6kV4ZiXWvPE8melIYiWUd5
	 WyGC28M9iH2WBh+W4SvBqfKeGzMPFqTKT7rNVN8Sl0KmrJ+8iuyGjqxdvXf11M1So3
	 bYcp2JgZBOB5D553M4LCbhOyqODMDAxOKOCe8jJj0cRJvhNAuI3A2Docv8DbQn/jS9
	 Hu3nE2pUhk3iL5f667EVFF7Ns2T2KTRFl8m6EvMW4c6HiwJsh4+D8qw7O8nW5iH2aW
	 d7RuK1wsCPezQ==
From: Mark Brown <broonie@kernel.org>
To: Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Mans Rullgard <mans@mansr.com>
Cc: Pan Nan <pannan@allwinnertech.com>, Maxime Ripard <mripard@kernel.org>, 
 linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20250410115303.5150-1-mans@mansr.com>
References: <20250410115303.5150-1-mans@mansr.com>
Subject: Re: [PATCH] spi: sun4i: add support for GPIO chip select lines
Message-Id: <174464072481.99542.17446384569030524351.b4-ty@kernel.org>
Date: Mon, 14 Apr 2025 15:25:24 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Thu, 10 Apr 2025 12:53:03 +0100, Mans Rullgard wrote:
> Set use_gpio_descriptors to true so that GPIOs can be used for chip
> select in accordance with the DT binding.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: sun4i: add support for GPIO chip select lines
      commit: 36ff6c3f5084f2dbb6cd89d15b78cf734e9abfa6

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


