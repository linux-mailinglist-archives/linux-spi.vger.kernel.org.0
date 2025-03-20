Return-Path: <linux-spi+bounces-7253-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56082A6A9A6
	for <lists+linux-spi@lfdr.de>; Thu, 20 Mar 2025 16:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B913C189688A
	for <lists+linux-spi@lfdr.de>; Thu, 20 Mar 2025 15:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421CE1E5B61;
	Thu, 20 Mar 2025 15:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uNDIFuk7"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD6D1E570D
	for <linux-spi@vger.kernel.org>; Thu, 20 Mar 2025 15:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742483951; cv=none; b=UWSuzxtUZawx2aGT4L1JWGpJBg7fdhr5/Bj7GPLIDDH0b714ppMcFPNe3kQo45QGLKK7ZkDs9Y6T37ka3JfTkgqtcMQF6wM65VLJHRasP8NZEo1jtt+xVbYbkqfJdEcVdpLHFz17FT9AS+wOQidbX+LqmQsiJJdQWpUY6eugb7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742483951; c=relaxed/simple;
	bh=qb5dLKIrfE/3SIP/jCYUnPGXb75Ce06vY+B+cKEJ0Ic=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WIHNxV+l6nNi5VX/2irqcwGJ+fZZadUdhGpP2bevDQ4H5ydrkOABdlww9A75XmCaXZ4cxu3dzl6PSu/RYoJqJdLBZOgAXHzp5x2va8HTx2oe5ZneNlFIijRxuWFfkQWNlPfLqYm8lLOT2dmmGZVbFtx3kAbrYbJY/Qqw0JLxc7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uNDIFuk7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E66F3C4CEDD;
	Thu, 20 Mar 2025 15:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742483950;
	bh=qb5dLKIrfE/3SIP/jCYUnPGXb75Ce06vY+B+cKEJ0Ic=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=uNDIFuk73iVzhG7OfjLqHxdVaSqXMAmSh/ZJ/eY8c7/QzVEjIGq2imP3jK4mYe9v0
	 tS/Brm4ZsGoq8ngZcwPn+k8XKP1NY6Wh9GeOzsq8n2NP3+rElU5kkPfRf2YeT4oLXW
	 QD1LV1V9486TA0wn5C28RGUhd1Auj6pLLPpUfZDeTU7zmvO+XHj5zynQE9YcxO7WKb
	 dfZAw5N66jtlG0oA5ZkoW2ek6V+jHB3ozDb+IIrPIvMBd4woBHFR2nb+wgVyI9EUdM
	 G3sSAmWRZkS4dyv7nhfVavpxNdnSL553/UmIdRsVJizaceRHddE0c5Whjnl0TihqZJ
	 selvCPtF49D3Q==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <michael@walle.cc>, 
 linux-mtd@lists.infradead.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
In-Reply-To: <20250320115644.2231240-1-miquel.raynal@bootlin.com>
References: <20250320115644.2231240-1-miquel.raynal@bootlin.com>
Subject: Re: [PATCH v2] spi: spi-mem: Introduce a default ->exec_op() debug
 log
Message-Id: <174248394868.69458.14767560574685655973.b4-ty@kernel.org>
Date: Thu, 20 Mar 2025 15:19:08 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Thu, 20 Mar 2025 12:56:44 +0100, Miquel Raynal wrote:
> Many spi-mem controller drivers have a very similar debug log at the
> beginning of their ->exec_op() callback implementation. This debug log is
> effectively useful, so let's create one that is complete and concise
> enough, so developers no longer need to write their own. The verbosity
> being high, VERBOSE_DEBUG will be required in this case.
> 
> Remove the debug log from individual drivers and propose a common one.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-mem: Introduce a default ->exec_op() debug log
      commit: ad4488845193e81549c11903a5083b4c9cc19785

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


