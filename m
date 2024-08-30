Return-Path: <linux-spi+bounces-4462-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 303049662DC
	for <lists+linux-spi@lfdr.de>; Fri, 30 Aug 2024 15:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44BF91C23A3D
	for <lists+linux-spi@lfdr.de>; Fri, 30 Aug 2024 13:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED461AD5E8;
	Fri, 30 Aug 2024 13:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="deDDggdQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820051AD5CB;
	Fri, 30 Aug 2024 13:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725024373; cv=none; b=X6kNb1OWwc0jtg3LxC6S76/ChQk2k3OGiG1W5evyIVkmIuImhUjCjb7BuZGnWV5kDFyZLwCpX6PFjeXzLzy12Ni0zJypX0rv+cf5yhitT6yZrf1ISzzl/AqrHJ9hGVbHnkx2E/G7YL50OOI7iCeizw38YWGk+UlsBmRrqVrUf78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725024373; c=relaxed/simple;
	bh=L4eCi8g/8sbaBIlF5I2hBdINyrKvVCWBsopBUO5hyNo=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=juOGwoNmjcYot5G+BJkKYnz7bAVaL4Bm2DumlJ2HWcZqXAAtVYZ6afNwPAChsgFm6EOPKz1lYOy9WUDCj9YfnLpqceJGJQaiF6QdGa66SdOs7nq3q8yHnm41Cukhmteqr6XMt/KtMH85NttF17n476ZRIcfTkBWf6q+qeyT6fiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=deDDggdQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A54CFC4CEC5;
	Fri, 30 Aug 2024 13:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725024373;
	bh=L4eCi8g/8sbaBIlF5I2hBdINyrKvVCWBsopBUO5hyNo=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=deDDggdQU88s9ssYh7dPBpJ7FSpEe44rC9BmBZqwh+0QZbQys+9xpeR1qED3fqxLV
	 KS6TW9OfAL2gAL/8s/cYtRlakgFtUQZRfjQhidXES+MbtSW6JTBE66QZ8QoBtEcQeo
	 eeN5AlAghY6Q+WjfkIf0djcxVidjzVMB+eYQdunuIbS6Z6goYomMZ53wFcCvZUG2Kl
	 oxilDRunoUTnXtWsg7RSWsZV+XUfSTdGuZ8ONMQ6ZTQMxp2GGAVIJyba0dKfTCb2CT
	 wGjCmSCXOG29P/2hw8IsgvEjaDo5wdvcrBB5jfj/3Dz/nCLKl0ThJEZ4OaYnPLgT4h
	 /JBkE8h5wY3ZQ==
From: Mark Brown <broonie@kernel.org>
To: nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, 
 claudiu.beznea@tuxon.dev, linux-spi@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20240826125913.3434305-1-ruanjinjie@huawei.com>
References: <20240826125913.3434305-1-ruanjinjie@huawei.com>
Subject: Re: [PATCH -next 0/2] spi: atmel-quadspi: Fix uninitialized res
Message-Id: <172502437139.145364.3746826329610494771.b4-ty@kernel.org>
Date: Fri, 30 Aug 2024 14:26:11 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Mon, 26 Aug 2024 20:59:11 +0800, Jinjie Ruan wrote:
> Fix uninitialized res in probe function.
> 
> Jinjie Ruan (2):
>   spi: atmel-quadspi: Fix uninitialized res
>   spi: atmel-quadspi: Simplify with dev_err_probe()
> 
> drivers/spi/atmel-quadspi.c | 31 ++++++++++++++-----------------
>  1 file changed, 14 insertions(+), 17 deletions(-)
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: atmel-quadspi: Fix uninitialized res
      commit: 99311b8a9ea2b83413cbb80e17c4648a518e7486
[2/2] spi: atmel-quadspi: Simplify with dev_err_probe()
      commit: 2d3e6351a25de0ceef69aae415cb1e082f0382c7

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


