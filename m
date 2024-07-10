Return-Path: <linux-spi+bounces-3831-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D6492D77A
	for <lists+linux-spi@lfdr.de>; Wed, 10 Jul 2024 19:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D697281EE3
	for <lists+linux-spi@lfdr.de>; Wed, 10 Jul 2024 17:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1EFF192483;
	Wed, 10 Jul 2024 17:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qKJN0R27"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A8F191F8E;
	Wed, 10 Jul 2024 17:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720632641; cv=none; b=de7N+jWX/KRuDT9sNRSJI1O1itPkvDhWuYxaiH2TJOPsY1JSfI18QrS1i6w8WJ1hd39RFtVNwaP3LwHZcOvqeIOLozXMcnBw1vzA5pkxaOilLa8FDedT6cSOxMyxYtbxxZXkJqjkYUtQekSTa1FEuncQikQ0zb87gY5SK8MaZ6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720632641; c=relaxed/simple;
	bh=Di4N2+cqCl7OWvZju80WUQzsEksScl5VdjNETIMG00w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=K+STRmnxm2tMX3DCegQ3lel0LHxZKB2zV5nAWrNLDYsnawZQ2DyF2WnseHPDojAnlS207W1PuPBl1C3yFZzanNPEO34JP2WOHCpogzs/rq1j2o+HdiE/G4RYtlVL0gi8NgpBuEan58nxc5Y3cebjkb0ASswAzFbzKFo/lHJuPsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qKJN0R27; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34303C32781;
	Wed, 10 Jul 2024 17:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720632641;
	bh=Di4N2+cqCl7OWvZju80WUQzsEksScl5VdjNETIMG00w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=qKJN0R27Xog5Tz7/XAEJvxQO76CdTZFxbmPuehklH9ZM4+2fKHaVVUGNIaMmEt6TH
	 hLdQjVB0zt9oq71N5UswCoNIQLnGh2rayodHhe9SdPew6weL4+NDO9LqJHMwVDSfBq
	 XFKldJqsbowAgDEyeerjO9E9tiSvp0wYvEj1NqFDZgzrPDzTv4l+i0Q0hqcwRoJNEO
	 /ghUYe23bbMfKr7NGcSL4sJrJzd+FMxacPyFu0gD9jB4NqOz2IhNHB4y0A77mVECDW
	 zQ9DjFAANqmPnzsFEehx6AriQBS296Uriwms8vRAJrjY13APvIxPVlZeO67icHv3rh
	 F/I+vbpcsT5lg==
From: Mark Brown <broonie@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240708-spi-mux-fix-v1-0-6c8845193128@baylibre.com>
References: <20240708-spi-mux-fix-v1-0-6c8845193128@baylibre.com>
Subject: Re: [PATCH 0/3] spi: fix spi-mux/spi_optimize_message()
 compatibility
Message-Id: <172063263994.22861.3909751860412680134.b4-ty@kernel.org>
Date: Wed, 10 Jul 2024 18:30:39 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Mon, 08 Jul 2024 20:05:27 -0500, David Lechner wrote:
> Since the spi-mux controller driver is doing unusual things with SPI
> messages, it needs special handling with regard to spi_optimize_message
> and friends.
> 
> The main fix along with a detailed explanation is in the second patch.
> 
> The first patch is another unrelated general fix that I noticed while
> working on this.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: don't unoptimize message in spi_async()
      commit: c86a918b1bdba78fb155184f8d88dfba1e63335d
[2/3] spi: add defer_optimize_message controller flag
      commit: ca52aa4c60f76566601b42e935b8a78f0fb4f8eb
[3/3] spi: mux: set ctlr->bits_per_word_mask
      commit: c8bd922d924bb4ab6c6c488310157d1a27996f31

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


