Return-Path: <linux-spi+bounces-105-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92AD67FF1A1
	for <lists+linux-spi@lfdr.de>; Thu, 30 Nov 2023 15:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 336FDB210E7
	for <lists+linux-spi@lfdr.de>; Thu, 30 Nov 2023 14:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699B6495FD;
	Thu, 30 Nov 2023 14:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BgEI/lwg"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0D93BB56
	for <linux-spi@vger.kernel.org>; Thu, 30 Nov 2023 14:19:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17432C433C9;
	Thu, 30 Nov 2023 14:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701353998;
	bh=QDL1PaO7K7mLVf0K1HVNsqEPDe8kw6NvsEJ0X7bDfWk=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=BgEI/lwgmmGylsQSkxMkaEcz8mgHCqZAyiAXQdIAxWOuxNTvOGSUdxji6Ca1Kbp+Z
	 UE+Z8gDb5OYXiuAjahCzQqyRBFcu+qcNVuWggjtQQqMrqoi8+6wLkGxuyCnhU8NymR
	 HRO3h8+HGOpLrHXxkJT3KixyVdVeEkRtFVbEUTsWcdZezKjYj1/Iz8OU5IO8k0RzxL
	 uaeHMlSsu7bqBZeQwlpAW8yo1lZb8zG7ompN79D9X9t2vp+wgF4WaRsgxLy17MkGfK
	 uMyQsPbsdR4NG6leef22iiWOBCiq/lilMIOZaBkC9o21ZL31B0diqWC3Ha8UDElujr
	 YsG0/1g7e0EGA==
From: Mark Brown <broonie@kernel.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <michael@walle.cc>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Mika Westerberg <mika.westerberg@linux.intel.com>, 
 Dhruva Gole <d-gole@ti.com>, linux-mtd@lists.infradead.org, 
 Kamal Dasu <kamal.dasu@broadcom.com>, 
 =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, 
 Mario Kicherer <dev@kicherer.org>, Chuanhong Guo <gch981213@gmail.com>, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 AceLan Kao <acelan.kao@canonical.com>
In-Reply-To: <20231129064311.272422-1-acelan.kao@canonical.com>
References: <20231129064311.272422-1-acelan.kao@canonical.com>
Subject: Re: [PATCH v7 1/2] spi: Unify error codes by replacing -ENOTSUPP
 with -EOPNOTSUPP
Message-Id: <170135399481.77996.14013825490187287215.b4-ty@kernel.org>
Date: Thu, 30 Nov 2023 14:19:54 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c

On Wed, 29 Nov 2023 14:43:10 +0800, AceLan Kao wrote:
> This commit updates the SPI subsystem, particularly affecting "SPI MEM"
> drivers and core parts, by replacing the -ENOTSUPP error code with
> -EOPNOTSUPP.
> 
> The key motivations for this change are as follows:
> 1. The spi-nor driver currently uses EOPNOTSUPP, whereas calls to spi-mem
> might return ENOTSUPP. This update aims to unify the error reporting
> within the SPI subsystem for clarity and consistency.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: Unify error codes by replacing -ENOTSUPP with -EOPNOTSUPP
      commit: cff49d58f57e5667c10a0db85d7461790bb85cf8
[2/2] mtd: spi-nor: Stop reporting warning message when soft reset is not suported
      commit: 7a030abc0185b30a3fd19a7431347c6f5a82c588

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


