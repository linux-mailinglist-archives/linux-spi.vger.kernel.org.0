Return-Path: <linux-spi+bounces-5640-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2AE29BF823
	for <lists+linux-spi@lfdr.de>; Wed,  6 Nov 2024 21:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DFD728136B
	for <lists+linux-spi@lfdr.de>; Wed,  6 Nov 2024 20:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B6120C322;
	Wed,  6 Nov 2024 20:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sCQjTB3J"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4086617B439;
	Wed,  6 Nov 2024 20:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730925723; cv=none; b=HS7TVYIPfuDB/3hF8crS039DnLaWZ/b04+pG/abaLAs9Bl4y6JNZNEOjHHjDjlIBaLA7fzXZSibCBI/QHFOnKcZmzMOU8qKw/eY2jnrpSaClDPMeJofm9eneSYhyCKDJUkuvk/h8isB5GCOFIj8Ml9B77sAMRlkaz2Lwvwp6g5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730925723; c=relaxed/simple;
	bh=6xZxZRX9pJzYRY60SdV8AMMfsLpXD2gY5VSstB6NEdA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sETRbD5ugOKL309KLbBIhh0MaxKhmGYYCUuCKNRFsA231OKEGb9aB62yua7ngEROIuISH6HzHwh0AlfzC+XhCj2ufFn0KtMWejFf5qeoFz9i/CstVqSm8+XAsEAEGo6r5tHvUkBL0lkKUBizvvVnIRa1Bj8KTuNkS4IxAv558No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sCQjTB3J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22910C4CECD;
	Wed,  6 Nov 2024 20:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730925722;
	bh=6xZxZRX9pJzYRY60SdV8AMMfsLpXD2gY5VSstB6NEdA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=sCQjTB3J8wNAnJdCpp6NFeQ5m+qOYAnC7uz0jN9RD9r4ZDEM5gh/gdpwKuh0WnvK6
	 6luotJKNV4CjOiMtEsLhkj1xdFDI+2hOj/SKcdroRHZ5yPedI4t08aQ1IQn/Kk0d48
	 PbqUf56xfLmt8NCXp3G04vXlKBDErRNqvreVJrkCA4UbnJB1tmkNZu5ARxXJ5WoR/J
	 OyqTAvnmQuL2cvVO3+F8dtWcXC8//eOzIk0RSWRcOucgfLl33PGd0w8+3PLNW/9VyB
	 th0cStjpArlhtd6NHCVt8dlcs/U97CigsreexapnYxLfgY6Dg4bXE6KpBAxgoOOgom
	 Mip9aKOsYV4Rw==
From: Mark Brown <broonie@kernel.org>
To: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Janne Grunau <j@jannau.net>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Nick Chan <towinchenmi@gmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>
In-Reply-To: <20241105-asahi-spi-v4-0-d9734f089fc9@jannau.net>
References: <20241105-asahi-spi-v4-0-d9734f089fc9@jannau.net>
Subject: Re: (subset) [PATCH v4 0/3] Apple SPI controller driver
Message-Id: <173092571984.200222.14602988312951678347.b4-ty@kernel.org>
Date: Wed, 06 Nov 2024 20:41:59 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Tue, 05 Nov 2024 09:08:28 +0100, Janne Grunau wrote:
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

[1/3] dt-bindings: spi: apple,spi: Add binding for Apple SPI controllers
      (no commit info)
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


