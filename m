Return-Path: <linux-spi+bounces-9163-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E23FFB0F996
	for <lists+linux-spi@lfdr.de>; Wed, 23 Jul 2025 19:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D22EB1C8443C
	for <lists+linux-spi@lfdr.de>; Wed, 23 Jul 2025 17:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC142153D4;
	Wed, 23 Jul 2025 17:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZfI4synB"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09D81EE03B;
	Wed, 23 Jul 2025 17:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753293063; cv=none; b=RZbm8dgeXzVB7Hl2gudqeVd8SDkN9vVpI36YQVPd6FnKA0OUXTk/V77yYe06cd6WAIEE5Fhwsx+p7fL8/a8HyWh7GMd8rvOaL2mPUCOX9kM8ml8wouJ4wa7Khp+W1RaWDf09wYVwsEbfoH1tCnI+MnJtW5+7MQshmTFq8xRt6Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753293063; c=relaxed/simple;
	bh=5++JICrxyrrls/0LDehom1H9z6DxPjc/dsMtzPXB6og=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=loh3vzPHm3KzWY6UjkJGySwF1ywFvXXClOvAqiD99ToSIjOy4CVRb4c4L78DLnmsTco5cGiOYFMW6nwY6DU86OMC6KrLAsfKV5h7tHjxNOPpKihW5oAj7xgT3A/Jt0OJCR9BjR+qvNEl1EXSQxUa1bCBRqDHF9tKtvw+2GQot2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZfI4synB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AF6DC4CEE7;
	Wed, 23 Jul 2025 17:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753293062;
	bh=5++JICrxyrrls/0LDehom1H9z6DxPjc/dsMtzPXB6og=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ZfI4synBiJ+1SE1A7h4IaQz2Hx+pHElH+/Sa5QEBmr/DbPxp+2tlCu+M8/FDb5Q1n
	 QZIZ86hVx2CIaeble8IqGmUcNG8CxfYmkQj801ysJj17UuWx9Wos0GBORHFkSK4kle
	 pRlsMPb8LmkV5Hwo2EtxLTRUnpJfLyTRBFwxjUQYX4mEM3si1/odzt4Wqmd6prFtSP
	 F1y4RkaGGcoT7zOuRIun3SDy1/904Z8+B7T3SxaorasIdVZ1q2M/5XgDF3XoHiHmiA
	 muq2FIpRMloy+PZ54Wo65QpPSbgb/SyHo1bcVDwl5h6MwWWcvcXABR0EWao0KQ8dfW
	 mLa2tjYX+MXIw==
From: Mark Brown <broonie@kernel.org>
To: Gabor Juhos <j4g8y7@gmail.com>
Cc: Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Md Sadre Alam <quic_mdalam@quicinc.com>, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250711-qpic-snand-simplify-bbm-copy-v1-1-dd2608325f72@gmail.com>
References: <20250711-qpic-snand-simplify-bbm-copy-v1-1-dd2608325f72@gmail.com>
Subject: Re: [PATCH] spi: spi-qpic-snand: simplify bad block marker
 duplication
Message-Id: <175329306112.97598.14632012143610727616.b4-ty@kernel.org>
Date: Wed, 23 Jul 2025 18:51:01 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Fri, 11 Jul 2025 18:32:52 +0200, Gabor Juhos wrote:
> Due to the expectations of the SPINAND code, the driver duplicates
> the bad block markers during raw OOB reads.
> 
> It has been implemented by using two if statements, and due to the
> opposite conditions one of conditional codepaths always runs. Since
> the effect of both codepaths is the same, remove the if statements
> and use a single line solution instead.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-qpic-snand: simplify bad block marker duplication
      commit: 1f590fa4b93dd7c7daaa4e09d8381ac2aab3853c

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


