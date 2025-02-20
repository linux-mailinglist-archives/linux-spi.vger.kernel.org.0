Return-Path: <linux-spi+bounces-6882-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86DB0A3E770
	for <lists+linux-spi@lfdr.de>; Thu, 20 Feb 2025 23:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6108B19C367D
	for <lists+linux-spi@lfdr.de>; Thu, 20 Feb 2025 22:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE60264F92;
	Thu, 20 Feb 2025 22:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sbYUjhw8"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DEB1EF0AB;
	Thu, 20 Feb 2025 22:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740090083; cv=none; b=qPK343z7qXFBIKyWeKn0+v9p98GYWM0z9uPCtnLPHH5FZxwNsAlTorv4F8+fUGr6OCk8JB1zTsjIMOzOS2FDOIGcASBUyN860kY5To9Ot7NibqnZsxVOt8TP5pCr2fhBqyf9K+RWloIysBp7KKMiz+0KVY0ajdYYlw3KzTZ0mss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740090083; c=relaxed/simple;
	bh=PCbQ6HbDTInruM4BIyqBxIseWP7a49RQq0CiHZU/rko=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NXagT0xmLJmb8W/c2tXkXC90rYZw+7h+gecS2C2QpZ4UlcxE2i7luT7ehfAKcJbS2T36zz6HDGRbrQmnYvgcU6/8Y034tsFIRt5hcKL7ghS3JgPKTdzKEpA1tHATmWCKj4bxY1CZG9995Iwo4ap5EwIpectw1C6MwYtFZ4YuAYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sbYUjhw8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 339D2C4CED1;
	Thu, 20 Feb 2025 22:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740090082;
	bh=PCbQ6HbDTInruM4BIyqBxIseWP7a49RQq0CiHZU/rko=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=sbYUjhw85Wag0mD8KuU8uT94WThO9oHRXcKEOQ708AyMUh6W4AaKe72F5DdoyaMSF
	 GSe0aLGwxdofOfPFLAiPUTFBohrxDegZw1vUx8kszEcXmbS8nKhn3tkqq7AuzIfV1V
	 L+r2rd4RLuqBypB4bIUGaAoshADPuMEVZ8w+QEe3DQDBpz8uhkUMQa8mhR2C3vvZGs
	 aQQvY4jfVwnK/c/jJ9bjN7Tp476dVhH2u3ZDQQq3/DK3k7XvV9Jw9diapwRcEOyXM5
	 M3GmAOxSZL47aFZZmkDSM0GmLwLC9XyokKXtNbTLy5MuuRB7m4PLitG28jEy9QuxiV
	 gptEZl+1uLYSw==
From: Mark Brown <broonie@kernel.org>
To: Andi Shyti <andi.shyti@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Denzeel Oliva <wachiturroxd150@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, linux-spi@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250214-spi-s3c64xx-fifo-depth-v1-1-e1b1915e3ee7@linaro.org>
References: <20250214-spi-s3c64xx-fifo-depth-v1-1-e1b1915e3ee7@linaro.org>
Subject: Re: [PATCH] spi: s3c64xx: extend description of compatible's
 fifo_depth
Message-Id: <174009008001.2293629.11288334722745710549.b4-ty@kernel.org>
Date: Thu, 20 Feb 2025 22:21:20 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-42535

On Fri, 14 Feb 2025 07:32:51 +0000, Tudor Ambarus wrote:
> The FIFO depth specified with the compatibles's data is used where all
> the instances of the IP define the same FIFO depth. It naturally has
> higher precedence than the FIFO depth specified via DT. Specifying FIFO
> depth in DT becomes superfluous in this case. Extend comment about
> compatible's FIFO depth.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: s3c64xx: extend description of compatible's fifo_depth
      commit: cb15abd47806b449e853caf43f41573c4c82fed3

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


