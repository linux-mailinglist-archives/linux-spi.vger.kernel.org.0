Return-Path: <linux-spi+bounces-11891-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7118CBE396
	for <lists+linux-spi@lfdr.de>; Mon, 15 Dec 2025 15:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 499E530322BC
	for <lists+linux-spi@lfdr.de>; Mon, 15 Dec 2025 14:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56252330324;
	Mon, 15 Dec 2025 13:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XUK+XdN8"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD2133030A;
	Mon, 15 Dec 2025 13:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765807163; cv=none; b=EblXayIzWk9PvgiDlZOY1+FfJcqdnZCzDnQRylT197Q7ZO6ITFpdnnoVQvHQYGE3avEnkeJrI1hs4ycGIh+1cMKDz/6w6r8KtXNRVmXjibniMFgArQ70V6JplG9au+1rqdWv6I+rEY5YFry7MjNFkFPXrO0NJVyCwrcA2lpskHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765807163; c=relaxed/simple;
	bh=aCAKHeRz0R1Pp79NnKo9Pw2t9f3vwIJOW1wBLc3sFv8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=r3DWJb+ECF3uKOYvX+9563OzrIWqnwcudY57j0L55YDyp6Kt2NZvVlt+q39v8eu/cbT/w5WS40wvyRi1r4IKg39AqlX6jNluk7UL6J7pA88U5Gg7CujgwoBNWTuoeW7i2R0JmRjIKVgrjz5h3rpFjwySDbtB0JboY6UcEEX4cxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XUK+XdN8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1225C4CEF5;
	Mon, 15 Dec 2025 13:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765807163;
	bh=aCAKHeRz0R1Pp79NnKo9Pw2t9f3vwIJOW1wBLc3sFv8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=XUK+XdN8VUJ/wmD7y7N6QNnA34TyypFdS29JvTN/YGUNcI4c7vdL8gka52RXgnwLv
	 K8mNzrvmdgPLTaXXd+oqdHpksRcE2Od1s2qx6g0cWz+5IYrl7N3ZVyIVDN9PkLjMCk
	 /yxWNE2o6Qt/tiDpcCZaqGzkPuLjWumIDPfjmXM1SZHY6RFOtV50zDfq4zhECOYTs7
	 j4eLQ3dZ0p9EnNSpGxukd3vVE7PdwvQZQVn/kyRP3+9ejEK8Zqs7+sxzn3HuQ/6nZd
	 aC04MkhkJ8XBTKzBz6eThK8aPobIWV1Hdc1Q7KKV2GouYgNI19V24VkFtntT/O9ZOe
	 0S/dwYZwXIyoQ==
From: Mark Brown <broonie@kernel.org>
To: Gabor Juhos <j4g8y7@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Md Sadre Alam <quic_mdalam@quicinc.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 linux-mtd@lists.infradead.org, linux-arm-msm@vger.kernel.org
In-Reply-To: <20251129-qpic-snand-superfluous-readloc-v1-1-b84ca17095d9@gmail.com>
References: <20251129-qpic-snand-superfluous-readloc-v1-1-b84ca17095d9@gmail.com>
Subject: Re: [PATCH] spi: spi-qpic-snand: remove superfluous
 qcom_spi_set_read_loc() calls
Message-Id: <176580716116.161463.15413695989499192950.b4-ty@kernel.org>
Date: Mon, 15 Dec 2025 22:59:21 +0900
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773

On Sat, 29 Nov 2025 11:29:27 +0100, Gabor Juhos wrote:
> Before configuring the registers related to page read, both the
> qcom_spi_read_page_ecc() and the qcom_spi_read_page_oob() functions
> are calling qcom_spi_set_read_loc() to set the read location for the
> first codeword.
> 
> However the qcom_spi_set_read_loc() function puts the passed value
> into the register write cache only, from where those gets written
> to the corresponding register later via DMA.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-qpic-snand: remove superfluous qcom_spi_set_read_loc() calls
      commit: cde4e63e847b4d41f017c2beb119c2668106a88a

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


