Return-Path: <linux-spi+bounces-5641-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FEF9BF825
	for <lists+linux-spi@lfdr.de>; Wed,  6 Nov 2024 21:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FC071C21B6E
	for <lists+linux-spi@lfdr.de>; Wed,  6 Nov 2024 20:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849D620CCD6;
	Wed,  6 Nov 2024 20:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eXtGBP3R"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522D117B439;
	Wed,  6 Nov 2024 20:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730925727; cv=none; b=cG2LUit3Jg3hfUlLkPAhqm8xi14f9Wr9F0iWC3W8+BzmeQ12LBtszTOliWOiWcuLm4aqHKe7KIdheWQD4cnjhJxxKn9LvMV8yvNmn1fAq/x4+eumtmtD8bvanGmEk2FWjsvwvA5JbR+AE7UgRA6291nPX3FuP+P9rQp8PYgCaY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730925727; c=relaxed/simple;
	bh=MyX3vKLdgoNWgBlUZe2r+I4QjJHT+W6zplpfpZ/F1mI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MTnirQAjpkKHE79DcGSZ0XWwCSmA56mogKsRpe0fEd25dOjGf1RkS5unSvtIv9GkCGaCc0mfanXiSYxTD2gxvcKx7bIaV4zDtCuSdzeq0AJ5SC7TqpwA7ONz/M7N99ncdz7S9d/YZ9v7eryfJ7mOH7Bl84IXb5qql5p4dYNCRCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eXtGBP3R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37867C4CED4;
	Wed,  6 Nov 2024 20:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730925726;
	bh=MyX3vKLdgoNWgBlUZe2r+I4QjJHT+W6zplpfpZ/F1mI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=eXtGBP3RqH+IvKcwi1Qkk5Nw4s/pFWZCpftB/e9XRwrImO+4M6CBJ/1FLRHVamJiw
	 PYfL5Cv+2PD+Lx/L0ZDxEM+WaHbjUmpykx1KtaojE3Mgq+Q0rUZ/0NX9gYBvkOFILR
	 pZb4RiAVTmbul7B1gdaQI0KY9DXdbEa+hQLTUStC/ZDBVaKf5TAiXxZgj5sTt9V3DR
	 FVe7EdJM9EUUvdpHZWm0IbBKzWnZOukok6no1tk7CzST35iECYGHIPueU/3zgPEZam
	 NQdbe23z/9fiv+ShgEUNohUnq4uWnYOBk9SP06edwf8wEs1Drl7WetqrDDGHzxfld1
	 xfklhGblZVLaw==
From: Mark Brown <broonie@kernel.org>
To: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Janne Grunau <j@jannau.net>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Nick Chan <towinchenmi@gmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>
In-Reply-To: <20241106-asahi-spi-v5-0-e81a4f3a8e19@jannau.net>
References: <20241106-asahi-spi-v5-0-e81a4f3a8e19@jannau.net>
Subject: Re: (subset) [PATCH v5 0/3] Apple SPI controller driver
Message-Id: <173092572295.200222.12076711239744365643.b4-ty@kernel.org>
Date: Wed, 06 Nov 2024 20:42:02 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Wed, 06 Nov 2024 08:53:59 +0100, Janne Grunau wrote:
> This updated series address the review comments from the original
> submission in 2021 [1]. It adds a new SPI controller driver for Apple
> SoCs and is based on spi-sifive. It has been tested with the generic
> jedec,spi-nor support and with a downstream driver for an Apple specific
> HID over SPI transport.
> 
> As usual, I'm splitting off the MAINTAINERS and DT binding changes.
> We would rather merge the MAINTAINERS change through the Asahi-SoC
> tree to avoid merge conflicts as things trickle upstream, since
> we have other submissions touching that section of the file.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: dt-bindings: apple,spi: Add binding for Apple SPI controllers
      commit: 18096d339206de6cdb48500b2c3ad5ad0b48aad7
[2/3] spi: apple: Add driver for Apple SPI controller
      commit: c36212b2610d09eb42142beb0d5613c70206c658

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


