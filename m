Return-Path: <linux-spi+bounces-9884-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB046B42AA1
	for <lists+linux-spi@lfdr.de>; Wed,  3 Sep 2025 22:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEC9D546748
	for <lists+linux-spi@lfdr.de>; Wed,  3 Sep 2025 20:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267162E7F1A;
	Wed,  3 Sep 2025 20:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RT6qb/t9"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DB92E3716;
	Wed,  3 Sep 2025 20:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756930818; cv=none; b=tsK//BSkjHWvm745UFd1to1AMBdfdh0T7xX3rv2oaRfpx4fjH7gAuvbEae2Kp1VHrlQhyWViWVtvGktQ2lKecXynO0T09HyHiP9UCgucQRff7zgIqoofojhKZzkf5nl2asFzckO9+oHbaqYvOym/FP7unzOpjqeog+IA1zKT/Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756930818; c=relaxed/simple;
	bh=49+4uYtFX1QMJbxzSswGEGQCDnZWGMG/+guZnJI0h88=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VYXyRF2bz6DQvC08v7emuVQoSK4ss6K9WcY08pxEUtQltCH/NLr1hX7sTfrxHGSrkHfM2OQMeHlhGEGWREEk+L14vkbVooPs/hC+A7DtYUF66Fjml1vYofeGxxhzOWyGvCX/KCB4pXMoUdXy0zc7TRmxX9Q/d2/CzTmEQXn+1DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RT6qb/t9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3DFCC4CEE7;
	Wed,  3 Sep 2025 20:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756930817;
	bh=49+4uYtFX1QMJbxzSswGEGQCDnZWGMG/+guZnJI0h88=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=RT6qb/t9B6J06t3tkRoM6uZL1bJFe0R4Q99BJw553PFaESTKtBu3XHcUL4sbheHQt
	 7lkjpOUHn9OpcOJm1IPsa2H7ErwQv1pAOe23CMNJd6KCJs2hq6DYFk1Gq4XZUGiPyJ
	 +M5zEFDCbASpxD2lzOpiRYmoZWMy4+n7KRC0insh9iF+o/WLoHqUovPJSTSCQoDHCT
	 kEv4h+cuZI+1vJpgDerNcGMSYxSwd/YKdGt9DOBIb9xW3zGKpk7AR+74FLft4zpOoR
	 01NIxLMgtZIQ3w60GtEbZerwiilBb/vv7z7FzVj9EOc3VZuJakWWuhYg/j6sBF01cc
	 eA9ZW7P0LEHYQ==
From: Mark Brown <broonie@kernel.org>
To: Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Md Sadre Alam <quic_mdalam@quicinc.com>, Gabor Juhos <j4g8y7@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250903-qpic-snand-unregister-ecceng-v1-1-ef5387b0abdc@gmail.com>
References: <20250903-qpic-snand-unregister-ecceng-v1-1-ef5387b0abdc@gmail.com>
Subject: Re: [PATCH] spi: spi-qpic-snand: unregister ECC engine on probe
 error and device remove
Message-Id: <175693081575.280569.13359616771206407047.b4-ty@kernel.org>
Date: Wed, 03 Sep 2025 21:20:15 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-dfb17

On Wed, 03 Sep 2025 13:56:24 +0200, Gabor Juhos wrote:
> The on-host hardware ECC engine remains registered both when
> the spi_register_controller() function returns with an error
> and also on device removal.
> 
> Change the qcom_spi_probe() function to unregister the engine
> on the error path, and add the missing unregistering call to
> qcom_spi_remove() to avoid possible use-after-free issues.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-qpic-snand: unregister ECC engine on probe error and device remove
      commit: 1991a458528588ff34e98b6365362560d208710f

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


