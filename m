Return-Path: <linux-spi+bounces-9177-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79932B1148E
	for <lists+linux-spi@lfdr.de>; Fri, 25 Jul 2025 01:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B776B5A50C6
	for <lists+linux-spi@lfdr.de>; Thu, 24 Jul 2025 23:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F63A23D2A1;
	Thu, 24 Jul 2025 23:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ypv9ArK+"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C39E5D8F0;
	Thu, 24 Jul 2025 23:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753400051; cv=none; b=PgYZP+Qs7SdM7zWUgkbg5U4QxHx8GcjFPUFpQJ4KttHDyw4wnPUfUqY9hsBiEh6in67UTTl+82xhx3L94RqJtX8eABXxCqsuxfU6gXqRYexFlb6IxF1d8mLVJTe53xc+M1+9B5r07L5tkThxP/cawtePUXebuKLF+WYkrnNOTPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753400051; c=relaxed/simple;
	bh=V/nVDfUDu3zSIVPxQrgq0fLEk+npFlmaZe5/m6YKPSc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=aG9V5y33qRGoJHhV4+OzOQ+8GHu5V3O8yNX/SQp0LIZ+jEBmnL4pKCsES8VFDWS6HmZABlzvmFNjiCxCHGDngB7+tacYbokkf/aE1qZaXE8e7lUVGv6sttH123LHktYvKElT3rfU095cZ/XMEN+dzgcXTtGDAjQUzrsSVlHXzsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ypv9ArK+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86D46C4CEEF;
	Thu, 24 Jul 2025 23:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753400050;
	bh=V/nVDfUDu3zSIVPxQrgq0fLEk+npFlmaZe5/m6YKPSc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Ypv9ArK+bgmMc8teMUqXtnSAPN0MNSo+G0YqQESAZ/g8tiixTe3dRHOOdLQZf3AUi
	 PaAebzgijsBynRI4Ii33DPDe0mT+d7eJn9KVTuP1BEnMcV/LSxamLMPXfNDy0bkr1h
	 I7Gmmkia+LNw4kXBZu/7wu3ZYOg+R2QC1U+2rA9GTq0d4iqdlrWzszngmQYQCoiX6E
	 OOpDoH24aknAi5Nl9yzeOCH1EVY5U9+DcFHtenrlAYgxO5SqANqpBcktfWgkxOPaOn
	 DwQ2438D5NC8W7RFOJpS6Dc/MxZxx7HyHJm8XGAAvy2+PtBxq/WZODctPMgD9dSwad
	 PzzSFFZ48DSDw==
From: Mark Brown <broonie@kernel.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Longbin Li <looong.bin@gmail.com>, 
 Zixian Zeng <sycamoremoon376@gmail.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 sophgo@lists.linux.dev, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 Conor Dooley <conor.dooley@microchip.com>
In-Reply-To: <20250720-sfg-spifmc-v4-0-033188ad801e@gmail.com>
References: <20250720-sfg-spifmc-v4-0-033188ad801e@gmail.com>
Subject: Re: (subset) [PATCH v4 0/4] spi: sophgo: Add SPI NOR controller
 for SG2042
Message-Id: <175340004627.192002.3302155786508203444.b4-ty@kernel.org>
Date: Fri, 25 Jul 2025 00:34:06 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Sun, 20 Jul 2025 16:31:42 +0800, Zixian Zeng wrote:
> Add support SPI NOR flash memory controller for SG2042, using upstreamed
> SG2044 SPI NOR driver.
> 
> Tested on SG2042 Pioneer Box, read, write operations.
> Thanks Chen Wang who provided machine and guidance.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/4] spi: dt-bindings: spi-sg2044-nor: Change SOPHGO SG2042
      commit: 7438379cfc47046f7507dfdb54906acf56288b9f
[2/4] spi: spi-sg2044-nor: Add configurable chip_info
      commit: 5653b4f8840801d9d141ba6a6c10e7cc15040c5b
[3/4] spi: spi-sg2044-nor: Add SPI-NOR controller for SG2042
      commit: f6b159431697c903da1418e70c825faa0cddbdae

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


