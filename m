Return-Path: <linux-spi+bounces-2749-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B12A88BC506
	for <lists+linux-spi@lfdr.de>; Mon,  6 May 2024 03:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E39CC1C21089
	for <lists+linux-spi@lfdr.de>; Mon,  6 May 2024 01:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6693B43172;
	Mon,  6 May 2024 01:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VjQiM57t"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D15C42ABA;
	Mon,  6 May 2024 01:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714957497; cv=none; b=hmmZHka9G15Qkg1JfoA+Xo2wOSOM9xaCAFbAZrhpGEiCAJcqGtbymjdiTsGgVuAzD6KACaaOZ14dPipE7E5aBvMAdWkFzaSYp3nGlp2IBG+czwMHtRa1ikKkjKEXL4E98JIthLojb3f+uEgJfnaRfmtJcbBEVAR5DCZeyNO6x/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714957497; c=relaxed/simple;
	bh=yCzv3/EdBeET56o8dn/vi4hxjuZW2GPkb8RI1j70HHw=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Nq702epjUwJpI+4USTycIGlA3U5gKD/Hdeu1HuQkow6ID557GCJ0niT6LLOCLUWjNLQ1FYP4iXIKQkz6rIPRPm4sEm6yps50oL5k0ooiQqVZArFjkw3iihpfEJtRYQJEbZk+Y1yUpr9pbjeVqU5lV8qsa8lGFjRsxuvz8g3EMLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VjQiM57t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24BA1C113CC;
	Mon,  6 May 2024 01:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714957497;
	bh=yCzv3/EdBeET56o8dn/vi4hxjuZW2GPkb8RI1j70HHw=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=VjQiM57tzH+PjVQ6npl9Ez7wsE+ehVsQpGRjRrKKU7PQ2vKH6UOOsxCksuSO87LJ5
	 HNk7YUvzIYlOC55T+Fv65cjQcvkdR95/Ue2RVYPa8eAixbq8oJDSQFl40HFMYwnXaL
	 jGnV6izgZm3+qmR41tk9g8Qj0bQGGxetD65MDDPvhQ88fEjttoQ0EFKHYBrohxqiAF
	 tOqpWDwIR1956/MNb9/VMcOFzWLK3R1XrU0dohfQMRw0n/91IlWpP/M/KCFa2Ok3cR
	 gLgABw0zTYlkp8VYMTM0t55g5SHUgHSrM95XsQDM0W+fFEliDQqxG8FrKyis5OsYux
	 Bk9kiOPbTKTWw==
From: Mark Brown <broonie@kernel.org>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240502171518.2792895-1-andriy.shevchenko@linux.intel.com>
References: <20240502171518.2792895-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] spi: bitbang: Add missing MODULE_DESCRIPTION()
Message-Id: <171495749604.1941246.483886233584970643.b4-ty@kernel.org>
Date: Mon, 06 May 2024 10:04:56 +0900
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Thu, 02 May 2024 20:15:18 +0300, Andy Shevchenko wrote:
> The modpost script is not happy
> 
>   WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/spi/spi-bitbang.o
> 
> because there is a missing module description.
> 
> Add it to the module.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: bitbang: Add missing MODULE_DESCRIPTION()
      commit: 8ee46db14169fe1b028078767fda904d2fcbc04e

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


