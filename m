Return-Path: <linux-spi+bounces-3573-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D40AE916649
	for <lists+linux-spi@lfdr.de>; Tue, 25 Jun 2024 13:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DB2E1F22B42
	for <lists+linux-spi@lfdr.de>; Tue, 25 Jun 2024 11:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8206214C59C;
	Tue, 25 Jun 2024 11:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RUX4QIWA"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE7514BF98;
	Tue, 25 Jun 2024 11:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719315255; cv=none; b=brKp6jLPJoK1KouQegzWoZsltjLYjEzeYzpZGrNsq7qRIu6ijvevV3QBxXGv+EQrliQaamwEaWkcS83+G6wNe0/zUGlihaXxRk3xDoZqOCKPYmN1+di8LArn5cV1t917VGVODQ3w5pM9elO1vsmIBePLIB0qSkOwU9jdEMCtp5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719315255; c=relaxed/simple;
	bh=NouGFcuOua729I814AHnnARTJV2fpjUJpj0FtKSwIyU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Sl4wJ4k+McAF/CUB1oyDJ0qE3kv0L1UsAppxCcc7fqfOT/AHE9rSQW3aqukAR5K8BCKYxIdEwVbK0RoxOxKCdyYROqjQbwvmj026o35o17B8hLa3zyjGsi/QtEK50PWiKHYkX7sN89tFGD8z1AeYj7/b9m6A0oyK+ffQzax/YAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RUX4QIWA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B93DC32781;
	Tue, 25 Jun 2024 11:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719315255;
	bh=NouGFcuOua729I814AHnnARTJV2fpjUJpj0FtKSwIyU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=RUX4QIWA7XM42SPtOgUSUd1vh2zbIfP9Yr2V9lhNhtOXE7nMv0JY3YlQ7SiUaXkYZ
	 YcITbpq5GIN3zEKf1STKt3Ah09aw+E1HHsAUrUjld7URaNubmO7rv3iWN3pYZSKQQl
	 fetwEPtZNScl41atfCgVNernOtDEcisJ6aD0QDNWaH7uy6BczIhNDWtHSNmawYNywv
	 L7AJB0KAMkiuODP6waJ0pJ+iI3TcuZeyWTRVSbnSDawsxYb3laECr+7yOPBDAXM9ez
	 qDiclITwpXLrpzkcnv+5PRIq2L/M/LFNhq4WQac+nVGZ+w7qNxhe0PYaBUdUQC8X0X
	 DwcrdZbxJ11Cw==
From: Mark Brown <broonie@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240620-spi-axi-spi-engine-fix-sleep-time-v1-1-b20b527924a0@baylibre.com>
References: <20240620-spi-axi-spi-engine-fix-sleep-time-v1-1-b20b527924a0@baylibre.com>
Subject: Re: [PATCH] spi: axi-spi-engine: fix sleep calculation
Message-Id: <171931525390.64438.17593023139078720275.b4-ty@kernel.org>
Date: Tue, 25 Jun 2024 12:34:13 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Thu, 20 Jun 2024 11:43:58 -0500, David Lechner wrote:
> The sleep calculation was not taking into account increased delay when
> the SPI device is not running at the maximum SCLK frequency.
> 
> Rounding down when one SCLK tick was the same as the instruction
> execution time was fine, but it rounds down too much when SCLK is
> slower. This changes the rounding to round up instead while still
> taking into account the instruction execution time so that small
> delays remain accurate.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: axi-spi-engine: fix sleep calculation
      commit: 40b3d0838a1ff242e61f341e49226074bbdd319f

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


