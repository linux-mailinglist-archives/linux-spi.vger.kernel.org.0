Return-Path: <linux-spi+bounces-7943-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAAF7AAD3A5
	for <lists+linux-spi@lfdr.de>; Wed,  7 May 2025 04:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DD9F466DE8
	for <lists+linux-spi@lfdr.de>; Wed,  7 May 2025 02:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245F513D8B1;
	Wed,  7 May 2025 02:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BEipz76b"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A5279E1;
	Wed,  7 May 2025 02:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746586654; cv=none; b=mKLe+lK8TFMHPOAtpSMRKnbKRVLqdIA3My8rUigx7RVZrm/IlmW3uNAnmJhYlBxb93Cl3xMnZ4rV2sbYrCBW6U4PmsbU01LglAM5xhhhJO7DYpw7tnAaksbEwBrijmA28gaGM6BqiX2A9863IZbieW1ejya0bkxHjM/akMR6HgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746586654; c=relaxed/simple;
	bh=/vzEubHwuNMF2pBidBwkQbCA050os6rVvYI9/KUiFKE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=I5S5T1Wr8YNWf2jbSeKqCDq2NjYyhpXjSHRkeAnl5FQEkCoTYs/JtgiwEKEsCqhgssLHdspcVtRdPGGeQOQIjHAUSf3JQEyX37XiDUI8+krpwpYGkTyBmlw/2cNOQiv7yNP3MURpdkUkJg0A54AVliqGdtGl+zvKVhpcjP0+1GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BEipz76b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01EE8C4CEE4;
	Wed,  7 May 2025 02:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746586653;
	bh=/vzEubHwuNMF2pBidBwkQbCA050os6rVvYI9/KUiFKE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=BEipz76b/Y9YZ5H3MlR3LfGbsb7JeKII4hi8g/2UiDGI5l9iwkl0puYFCIZoNuqGl
	 RxiAPXJ2/7sId8yJ6Q1lljj+LxjoUOEHY6BwjZtRYebAq3xoaJ1NwGuP5wJvdj6j+v
	 0hGatneKfnfV52pskxPRiHXFESjzqqhKS2Ov6WYpZOgn3Jg7t3kk3ApTRejFcIhCy2
	 1F6qij6Q4t+l+vU3vmWXLe6RceCBB/8XUoaXO4IdPQjq5655dngicDWw5Yh3n0CK3q
	 zavMzcpyh7HmMe2I1nYhIt/9UkEw1EYPVVd5kEgFvWe4LHEUCm11+R+GN3/zLK1LtQ
	 vQDy1LzcVv+Lw==
From: Mark Brown <broonie@kernel.org>
To: Han Xu <han.xu@nxp.com>, Yogesh Gaur <yogeshgaur.83@gmail.com>, 
 Haibo Chen <haibo.chen@nxp.com>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250428-flexspipatch-v3-0-61d5e8f591bc@nxp.com>
References: <20250428-flexspipatch-v3-0-61d5e8f591bc@nxp.com>
Subject: Re: [PATCH v3 0/5] This patch set did some clean up and add
 runtime pm support for flexspi driver
Message-Id: <174658665186.4165102.13950594775211534528.b4-ty@kernel.org>
Date: Wed, 07 May 2025 11:57:31 +0900
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Mon, 28 Apr 2025 18:06:42 +0800, Haibo Chen wrote:
> PATCH1/3/4 to clean up the code, make the code more readable
> PATCH2 add the runtime pm support
> PATCH5 use devm_add_action_or_reset() to replace remove() callback, this can avoid
>        oops when do bind/unbind test
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/5] spi: spi-nxp-fspi: remove the goto in probe
      commit: 48900813abd2730a35c6e3afd1609bafac5271cc
[2/5] spi: spi-nxp-fspi: enable runtime pm for fspi
      commit: 97be4b919a609fc8c4bd1118502b5d26cc2f77c4
[3/5] spi: spi-nxp-fspi: use guard(mutex) to simplify the code
      commit: 93be516f819dcb1fdac035566381d8899d4b389c
[4/5] spi: spi-nxp-fspi: remove the unchecked return value for nxp_fspi_clk_disable_unprep
      commit: e0558eb74c6e082b60e03981eb7cbf0fc3780ef4
[5/5] spi: nxp-fspi: use devm instead of remove for driver detach
      commit: 9f7cd1bcb6363368abc954ff4e727b579813c697

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


