Return-Path: <linux-spi+bounces-127-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB44B80391D
	for <lists+linux-spi@lfdr.de>; Mon,  4 Dec 2023 16:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 674DE280F52
	for <lists+linux-spi@lfdr.de>; Mon,  4 Dec 2023 15:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22732C878;
	Mon,  4 Dec 2023 15:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TxiIuVVK"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B412C18A
	for <linux-spi@vger.kernel.org>; Mon,  4 Dec 2023 15:47:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89B1FC433C7;
	Mon,  4 Dec 2023 15:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701704836;
	bh=SV1RU8ee4fCCMXy3htxPUI++mi4cBu8pJeHdam1A5CY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=TxiIuVVKTwiTDv/SBIwYP9YKKRpB2Y3moNQwrHJmVpAwRt6CfF20HTElE3Rq0XIgs
	 /6fRTX1YVM56ANrUmcknIlObGKhJtXxJLHAXJQBlZYE70Jk7s8I3Ljw4xBUeJXn2sd
	 z+JyMmPus1EqABLQR/RUdOY2Aer0/sqKFR8+52z9BJz/IK1s1+/0eG5R8Vmx8YyUPB
	 GRq0SL0shS6yjtbBilivlhwcZjoDIkIEPBw7PYezG9BhbZFR2dRyM5Hz+/hlCVbyfZ
	 g/2/TwItPcKxfkO5dureY9ZnM4zteT2oUl+GkEtBUC8MyAz4HCQj8qoETUlhEK4XRd
	 ZCn4Ubkiv10Gg==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, Yang Yingliang <yangyingliang@huawei.com>
Cc: william.qiu@starfivetech.com, hal.feng@starfivetech.com
In-Reply-To: <20231129081147.628004-1-yangyingliang@huawei.com>
References: <20231129081147.628004-1-yangyingliang@huawei.com>
Subject: Re: [PATCH] spi: cadence-quadspi: add missing
 clk_disable_unprepare() in cqspi_probe()
Message-Id: <170170483527.64566.11498835032846477642.b4-ty@kernel.org>
Date: Mon, 04 Dec 2023 15:47:15 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066

On Wed, 29 Nov 2023 16:11:47 +0800, Yang Yingliang wrote:
> cqspi_jh7110_clk_init() is called after clk_prepare_enable(cqspi->clk),
> if it fails, it should goto label 'probe_reset_failed' to disable
> cqspi->clk.
> 
> In the error path after calling cqspi_jh7110_clk_init(),
> cqspi_jh7110_disable_clk() need be called.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: cadence-quadspi: add missing clk_disable_unprepare() in cqspi_probe()
      commit: 5cb475174cce1bfedf1025b6e235e2c43d81144f

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


