Return-Path: <linux-spi+bounces-3517-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 040709112B6
	for <lists+linux-spi@lfdr.de>; Thu, 20 Jun 2024 22:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B25382836DA
	for <lists+linux-spi@lfdr.de>; Thu, 20 Jun 2024 20:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BAC44F218;
	Thu, 20 Jun 2024 20:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uWVfraYr"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322C7171A5;
	Thu, 20 Jun 2024 20:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718913868; cv=none; b=Ax8K8YBaum8/1sUkcwszmb/OWZth2PrmpVTsn1sQ7sTBvmV2tR+TrzrF8JOM7kH3nI1V8nBvBDOBoEwHfyhKzZe7dbEeCzVlR05ZHp4FmIE+0mGQtTYjYMcvrQybtDnf+I/o5AVkl2ZpSEneAQYd0a5rcFrFhx98ixdECp8572A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718913868; c=relaxed/simple;
	bh=i1+lFti4q62gs06dv0Dq9S7mXtSlBrfDTt60vscmQ14=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=R0C9U+OiEd6CnXWB+1mXqZHc2ijg5XTdDrmpJppk4ggjaDqAIsC/rri/34XfoITAc/ZIUS9EkET6mkEZu489ulAlfqJir7wamhD/9fQrYMfTVg2LnSPGxe4+7W9qi2r6QwHysOgQGBLoVMLxyKD7Bi8P+F3vhKuYIOY6kpy/mmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uWVfraYr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AADD9C2BD10;
	Thu, 20 Jun 2024 20:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718913867;
	bh=i1+lFti4q62gs06dv0Dq9S7mXtSlBrfDTt60vscmQ14=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=uWVfraYrMvoBDRrb5/hLmNgYb0aekbpkXsma6j3QGJXlcxgZ2tKPyhVHA7Ta+Shh0
	 ZPjrHGz/+FIQpsi1sTQ+kWuWWblKoLuXcumnHrLg3vDHil5hiTqB9YTqnSK3aK+Hkk
	 TgN46GdowUal/9JpQMUuarlWHXPEIoHEQgBgys7M0KZUprnQL1agUMouKP6vdVurAW
	 Gjghht4K3obDNiicBry6zN5/la8lGcHWhLciGbrvzoM1zFbTCu5tfjtUhBkVbKiWdx
	 pTdwT1obJCCzR2daexWMHpo5BBv0yDLsiT+QtuOs1wN01EzAfsNsiX/CHAGBCGYyoS
	 M2MlCF9rQNaog==
From: Mark Brown <broonie@kernel.org>
To: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, git@amd.com, 
 amitrkcian2002@gmail.com
In-Reply-To: <20240617153837.29861-1-amit.kumar-mahapatra@amd.com>
References: <20240617153837.29861-1-amit.kumar-mahapatra@amd.com>
Subject: Re: [PATCH 1/1] spi: spi-cadence: Enable spi refclk in slave mode
Message-Id: <171891386642.202395.16718359762665726069.b4-ty@kernel.org>
Date: Thu, 20 Jun 2024 21:04:26 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Mon, 17 Jun 2024 21:08:37 +0530, Amit Kumar Mahapatra wrote:
> When spi-cadence is configured as a slave, it requires the SPI refclk to
> detect the synchronization start condition while communicating with the
> master. However, the spi-cadence driver never enables the SPI refclk in
> slave mode, causing the refclk to remain disabled if the
> "clk_ignore_unused" kernel parameter is not passed through bootargs.
> As a result, the slave cannot detect data sent by the master, leading to
> communication failure. Update driver to enable the SPI refclk in both
> master and slave configurations.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-cadence: Enable spi refclk in slave mode
      commit: 78b05172b42d14a4c6fc6b75b31590b8977900dc

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


