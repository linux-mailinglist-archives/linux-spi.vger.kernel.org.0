Return-Path: <linux-spi+bounces-9096-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B52C2B04528
	for <lists+linux-spi@lfdr.de>; Mon, 14 Jul 2025 18:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D38C1712C9
	for <lists+linux-spi@lfdr.de>; Mon, 14 Jul 2025 16:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB02F25EF97;
	Mon, 14 Jul 2025 16:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mDpEy7jr"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E19725E471;
	Mon, 14 Jul 2025 16:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752509607; cv=none; b=tRshpW8n89PWfiycleaRD508l4kVwiMBkoZSBLcEMM1LKoBXCwAvCgwRfgy/sF4zM2TGQ5XOPaptENARjGvTau4VXpH1a/bS9gC1N63qaQRMK2ay33maf1GTwWL/4hzpYDWFp+WZbhovCzT/4hO7SVvLY8yZtfeKGUhjplYK6/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752509607; c=relaxed/simple;
	bh=S39ERRybIfk2qPLUFR2f8uGX0bsCR8Fp/3rwEa7oUng=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=s4e+ZEjaBOC0Xs/yy95VC+x1iFQV/P/9X0+MOJOcoBNoEvBxanILpvbW9AJBrxQAOEMDXOBVheLPQRf5uwMvRAJcFTfUPa8mtff3uDkFkseAhWqLfJj6Q59sbW7LzXVkzF/MHwWGiYBW2CjQsZt8R0D+Z8l5q6RDMQxqbt4TVb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mDpEy7jr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8970EC4CEED;
	Mon, 14 Jul 2025 16:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752509606;
	bh=S39ERRybIfk2qPLUFR2f8uGX0bsCR8Fp/3rwEa7oUng=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=mDpEy7jrMJa1iR2iVDl8XSizJ1MNFgIIBgaRqq4YVU5xJ1ODlQ9ad4nSeYcx3wszb
	 d5wpNLHtQJHniVEIMgHJjrulfhFDPFgFI1qlyuQNdHzzZOfQa+kPFLu3/Km5VjnZsN
	 Q4MVbY/2ehsgZgxD+9YJb7eRhCx5EViL+7NjxguIJtHCiSbHCrfK62HW0uZIUdS8WK
	 pP03j0VJtornf0XW2TTsrnmORfLRD4Yxd71DPJx66XVUMs+bs74oogVfGnXIxhs8pJ
	 jVr6bg8AdUxhgod7YMEGn/wMc4fyfxN20NvUvC0GxBhCjfGb0Tv1Q96//gHBOD6uk0
	 8nod865Mmzqaw==
From: Mark Brown <broonie@kernel.org>
To: Cheng Ming Lin <linchengming884@gmail.com>
Cc: patrice.chotard@foss.st.com, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, alvinzhou@mxic.com.tw, 
 Cheng Ming Lin <chengminglin@mxic.com.tw>, stable@vger.kernel.org
In-Reply-To: <20250714031023.504752-1-linchengming884@gmail.com>
References: <20250714031023.504752-1-linchengming884@gmail.com>
Subject: Re: [PATCH] spi: Add check for 8-bit transfer with 8 IO mode
 support
Message-Id: <175250960429.84734.11907940601016863610.b4-ty@kernel.org>
Date: Mon, 14 Jul 2025 17:13:24 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Mon, 14 Jul 2025 11:10:23 +0800, Cheng Ming Lin wrote:
> The current SPI framework does not verify if the SPI device supports
> 8 IO mode when doing an 8-bit transfer. This patch adds a check to
> ensure that if the transfer tx_nbits or rx_nbits is 8, the SPI mode must
> support 8 IO. If not, an error is returned, preventing undefined behavior.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: Add check for 8-bit transfer with 8 IO mode support
      commit: 710505212e3272396394f8cf78e3ddfd05df3f22

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


