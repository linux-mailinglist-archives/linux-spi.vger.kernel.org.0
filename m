Return-Path: <linux-spi+bounces-10236-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFFF4B95A21
	for <lists+linux-spi@lfdr.de>; Tue, 23 Sep 2025 13:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F92C174300
	for <lists+linux-spi@lfdr.de>; Tue, 23 Sep 2025 11:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8BD832252F;
	Tue, 23 Sep 2025 11:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B1VMOtdR"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A067F321F22;
	Tue, 23 Sep 2025 11:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758626724; cv=none; b=LWYkG44kR2wSQ0BvlwTJ0j6Gbl3uFd5Oc+IhKc8TgMF7Zb2zOn2xvKdJyG15Tra4F1f/j2uXw8znG+82EHadnB2dOTT3yJ8s8VwmBzTO4R7nyf+giHHjaB/nsSAfcQBbM9zJ+lr7ukDI5RF8YaKcarZYGPbgq4dtNLl77C76C5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758626724; c=relaxed/simple;
	bh=Z/vyvFvY22fhqPX4IzbFZBx+2HernhT4aAxg9Ryujko=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Q4/tNtGhtJ1pt+48R4u5wRax4vVLwMWEIK3VyhlNuCZa4fazdy0xqIaJ98A1+TS7k03b/A73KG5xvL95sgU9+Og5A94USmiWSlPDjraD9DySslKMq5xNSwm/S/YlkLoO8ipIpxmOiEdBAH8CZTEy7k1YvUyl7LSD2Bn6AEIzo7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B1VMOtdR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC284C113D0;
	Tue, 23 Sep 2025 11:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758626724;
	bh=Z/vyvFvY22fhqPX4IzbFZBx+2HernhT4aAxg9Ryujko=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=B1VMOtdRAEzsoZCxpDYWRM5i4bA9PT3OR8RsXx2AxxRlv31MD7I/2dNiEUpODakKw
	 4LkKz3fahLHgmX/J5elq/PqTVwKUBybWUSqDRIBnMhKAwhTdfLrJuEmESsJtDluY6Z
	 qJ41q4LkQo1LC4FIPeLKHZq03ZCF9fsot9xugP1Yb1XHNx3VAoPHIbiO3HdmDK1hLc
	 XslWRA0E9zkrDWltdFtCIR9zw+sexzlyAVeLHj/qy+cMW4+IWxFguZ7VIYW8HFcVLl
	 d0uyvys4F7AKplZky6bwIpPrbaT76oq8Pd/BR+PIIKBLoXJCqOpm6D+yzuOleWXKjB
	 hS1BdIEJMFggg==
From: Mark Brown <broonie@kernel.org>
To: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>, 
 Jonas Gorski <jonas.gorski@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>
In-Reply-To: <20250915183725.219473-1-jonas.gorski@gmail.com>
References: <20250915183725.219473-1-jonas.gorski@gmail.com>
Subject: Re: [PATCH v2 0/7] spi: multi CS cleanup and controller CS limit
 removal
Message-Id: <175862672270.1039628.11616279717463508641.b4-ty@kernel.org>
Date: Tue, 23 Sep 2025 13:25:22 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a9b2a

On Mon, 15 Sep 2025 20:37:18 +0200, Jonas Gorski wrote:
> This series aims at cleaning up the current multi CS parts and removing
> the CS limit per controller that was introduced with the multi CS
> support.
> 
> To do this, store the assigned chip selects per device in
> spi_device::num_chipselects, which allows us to use that instead of
> SPI_CS_CNT_MAX for most loops, as well as remove the check for
> SPI_INVALID_CS for any chip select.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/7] spi: fix return code when spi device has too many chipselects
      commit: 188f63235bcdd207646773a8739387d85347ed76
[2/7] spi: keep track of number of chipselects in spi_device
      commit: 099f942182e3695554cba44e4bafb08a4111b50f
[3/7] spi: move unused device CS initialization to __spi_add_device()
      commit: 1c923f624439b26b6740cdd2a9f7a12b1968f3f3
[4/7] spi: drop check for validity of device chip selects
      commit: f3982daccf42cefcd80218c76a6b5dd134fe97e3
[5/7] spi: don't check spi_controller::num_chipselect when parsing a dt device
      commit: 83c522fb642384aef43697aa5c7686363e9e92dd
[6/7] spi: reduce device chip select limit again
      commit: 08fda410bae41cc8dde9697f9104da525be53153
[7/7] spi: rename SPI_CS_CNT_MAX => SPI_DEVICE_CS_CNT_MAX
      commit: e336ab509b43ea601801dfa05b4270023c3ed007

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


