Return-Path: <linux-spi+bounces-9161-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C75B0F75D
	for <lists+linux-spi@lfdr.de>; Wed, 23 Jul 2025 17:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D31D816691C
	for <lists+linux-spi@lfdr.de>; Wed, 23 Jul 2025 15:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19FAC148;
	Wed, 23 Jul 2025 15:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQtwpykz"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7673E2E370E;
	Wed, 23 Jul 2025 15:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753285574; cv=none; b=ecCifr9moOBq4VW6Efq4ONKHOqaWqmqz15GskT/J0AYkZC1rrva37YZxDYMeGQV/g0v6xVEUr5RNRofeyfqvO6Oz1d/Ni+/Kxp7jTE89fBgp1k4OtcSq5pIoHa46WoDi57RzqVbidBoI+/1ZF0Zs6HvwXg/IZhOUm2sV+pdasS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753285574; c=relaxed/simple;
	bh=4w/DFJ98GqBXik4ktnB0SRascaFEgXt2MIn7gcFChYU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NgzQGSfxSndMQ9q3lH2oyRh9kNFUxl4bo+xfv73HNUBDLJ+CEHbr8bCNfxHwFpLc/8NX2OAi9WBsPwaF2/3EzLA5lwxdXhyIJ/5jyDjAqAZUhEHuV/WCPhqaa3mAm2y2c10JeY8ojpFEdCMDxyD6apqCe0+WZNkEdyuelkrHI9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQtwpykz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DAB2C4CEE7;
	Wed, 23 Jul 2025 15:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753285574;
	bh=4w/DFJ98GqBXik4ktnB0SRascaFEgXt2MIn7gcFChYU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=KQtwpykzYKBAPyRedO8oA60/BQztUEakB3SEMvcWNkLTVko5PQX+3z4id96rdb5zt
	 iiIUdqaVUu8/tb7UyqtHrF+mADIvxx68UPfpT2n1esR4ZrHHx1/NrmSadOM5FceXbR
	 ifbmkjahdVe35RT9HmOHNKnkAYS8EEPpLAVCKPrVNeQYk9dqaXfNNbFu7itHJbREWw
	 SFeJkhia+u0NX/WQ4lv5Sqz7UEld3Tph8kK5kJreFpDKeAmaSpE5F/BIUv7ogwXbwx
	 PRARSDr4tuYXragutpamxpNM0OtankWNCL4yb5N0OaHkYr7MEHXaprn9W05OqPKUqf
	 ztM/4H2/QwoLQ==
From: Mark Brown <broonie@kernel.org>
To: Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Md Sadre Alam <quic_mdalam@quicinc.com>, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 Gabor Juhos <j4g8y7@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250723-qpic-snand-fix-steps-v1-1-d800695dde4c@gmail.com>
References: <20250723-qpic-snand-fix-steps-v1-1-d800695dde4c@gmail.com>
Subject: Re: [PATCH] spi: spi-qpic-snand: don't hardcode ECC steps
Message-Id: <175328557230.71989.15440098582685138436.b4-ty@kernel.org>
Date: Wed, 23 Jul 2025 16:46:12 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Wed, 23 Jul 2025 10:06:43 +0200, Gabor Juhos wrote:
> NAND devices with different page sizes requires different number
> of ECC steps, yet the qcom_spi_ecc_init_ctx_pipelined() function
> sets 4 steps in 'ecc_cfg' unconditionally.
> 
> The correct number of the steps is calculated earlier in the
> function already, so use that instead of the hardcoded value.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-qpic-snand: don't hardcode ECC steps
      commit: f820034864dd463cdcd2bebe7940f2eca0eb4223

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


