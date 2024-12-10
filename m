Return-Path: <linux-spi+bounces-5991-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB1F9EB195
	for <lists+linux-spi@lfdr.de>; Tue, 10 Dec 2024 14:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D698716BAE5
	for <lists+linux-spi@lfdr.de>; Tue, 10 Dec 2024 13:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33A31AA1E5;
	Tue, 10 Dec 2024 13:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GdS6iRor"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7741B85D4;
	Tue, 10 Dec 2024 13:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733835655; cv=none; b=cdhxrhIwAWvCSRwPk+H06qGLu+WTOKOqxT10nVcz8XsHpoN97JpRuZYi0YB8ae5TKuWzkoSQjrwhEcGFPP/Kjbw8yJlyF/K0IsgxfKXLiy7AkF5uyDG02qfW6Rf/N1Gesl8M6SLNTvOEDDs23+w2KQGwkQFIku8Geo4NKlFju3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733835655; c=relaxed/simple;
	bh=w/ontMIclNaG+gytLgn0uR87w5kq+wV6ujyQIHeHOXk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lkE5UcAh8boeiM2pA2grbslxZvF7z48InwVfIq+kYfQSnlYHrPtQg7bS7xDF/wLz+nBBv6/c1TK4zltXH0pKl43nTkubIzHAH0fnDuyC02DD9QJEHVXBOSF+noVLDFGOFmuLuXL9RG7E43GsUTILnwVcx4mc6sA3EgabhetfVMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GdS6iRor; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2E07C4CEDF;
	Tue, 10 Dec 2024 13:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733835655;
	bh=w/ontMIclNaG+gytLgn0uR87w5kq+wV6ujyQIHeHOXk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=GdS6iRorN0uTR2iyLNz7xg2WFhwhII4g+dxImwCBRgvXdcsk3ReyjvmpppPyi1D0y
	 k1HZ4yBNDHg/0Xc4OqQQvcrpDlJUkAVcJQcC+xC+vCyVC0AG6Fz7jZTkB5/p2OW5GL
	 IrF278DKexZrhvd5JzE7JZCyL01vBXim90xhq8lYXG61HmwMWe8f6eikshb8LouQwB
	 g+1XVFRGgdOv/YW9EuJIw6yX4bg4UeWFbvBLwFBHhZf7guU4I7IFNxYPhfVOpx6V/Z
	 wdZ8QN4JxCpVwuG8aIra/kdR2fKiPejHO5ZQ7LOPrVNOH8bjPY8g955t/f9/F0VA4y
	 Rw6FRaStz7YxQ==
From: Mark Brown <broonie@kernel.org>
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Stefan Wahren <wahrenst@gmx.net>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org
In-Reply-To: <20241209111316.4767-1-wahrenst@gmx.net>
References: <20241209111316.4767-1-wahrenst@gmx.net>
Subject: Re: [PATCH] spi: mxs: support effective_speed_hz
Message-Id: <173383565340.34030.7139873956151908430.b4-ty@kernel.org>
Date: Tue, 10 Dec 2024 13:00:53 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Mon, 09 Dec 2024 12:13:16 +0100, Stefan Wahren wrote:
> Setting spi_transfer->effective_speed_hz in transfer_one_message so that
> SPI client driver can use it.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: mxs: support effective_speed_hz
      commit: a17162f0b2dc97aa2dedfde8a7226fb9b5210534

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


