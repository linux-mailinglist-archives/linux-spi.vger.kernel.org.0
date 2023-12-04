Return-Path: <linux-spi+bounces-129-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F318803920
	for <lists+linux-spi@lfdr.de>; Mon,  4 Dec 2023 16:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A04C11C20B64
	for <lists+linux-spi@lfdr.de>; Mon,  4 Dec 2023 15:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F502CCB0;
	Mon,  4 Dec 2023 15:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eVBuxpU6"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35C92C18A;
	Mon,  4 Dec 2023 15:47:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73C05C433C9;
	Mon,  4 Dec 2023 15:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701704839;
	bh=5eZTulHwFBdceuxLyWHIoBO+ijzONNAGMBWXJpumtaA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=eVBuxpU6gm0NDTiIG6kHWFhu+c2UQ1HerP5Qg8FlZD9bVZ/oJ0/eKWnfxvEgNJhNQ
	 yOUBI8hmP7DHuuChrslor7nY4HVCZLj5+I6htkmMn32TrYi9CQgDoSUjNm7eTN/ftl
	 cj6ZcIC2ldQ37FZ19RZNe019UdoiLx6zJfRvhmXKMMiQAs5+kdzQOgLVj1uK/GLaWV
	 ZHEclJ9VwDEez8QYWe8GXY5Tjqbo8OzwZTTYGLJA+oAj2qLnARktshZNWmJAqnxbhu
	 m3VcFYGKJ18Io59NCCkmiShDxawFWlMwJGfyMdvZoww18WH2HpU0YEJSuY0zMpvluQ
	 VfZ0EdRpiO+jg==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Ryan Wanner <ryan.wanner@microchip.com>, stable@vger.kernel.org, 
 Ronald Wahl <ronald.wahl@raritan.com>
In-Reply-To: <20231127095842.389631-1-miquel.raynal@bootlin.com>
References: <20231127095842.389631-1-miquel.raynal@bootlin.com>
Subject: Re: [PATCH 1/2] spi: atmel: Do not cancel a transfer upon any
 signal
Message-Id: <170170483818.64566.8507170365277129346.b4-ty@kernel.org>
Date: Mon, 04 Dec 2023 15:47:18 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066

On Mon, 27 Nov 2023 10:58:41 +0100, Miquel Raynal wrote:
> The intended move from wait_for_completion_*() to
> wait_for_completion_interruptible_*() was to allow (very) long spi memory
> transfers to be stopped upon user request instead of freezing the
> machine forever as the timeout value could now be significantly bigger.
> 
> However, depending on the user logic, applications can receive many
> signals for their own "internal" purpose and have nothing to do with the
> requested kernel operations, hence interrupting spi transfers upon any
> signal is probably not a wise choice. Instead, let's switch to
> wait_for_completion_killable_*() to only catch the "important"
> signals. This was likely the intended behavior anyway.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: atmel: Do not cancel a transfer upon any signal
      commit: 1ca2761a7734928ffe0678f88789266cf3d05362
[2/2] spi: atmel: Drop unused defines
      commit: 49d8575ca6135a533218e40ddcb85462fd9ff1d2

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


