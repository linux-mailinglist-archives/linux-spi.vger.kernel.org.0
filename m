Return-Path: <linux-spi+bounces-9370-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F61B22560
	for <lists+linux-spi@lfdr.de>; Tue, 12 Aug 2025 13:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D4C81B66D54
	for <lists+linux-spi@lfdr.de>; Tue, 12 Aug 2025 11:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50CB22F0C7B;
	Tue, 12 Aug 2025 11:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YlAWtlfE"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EFF2F0C78;
	Tue, 12 Aug 2025 11:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754996755; cv=none; b=CXqrrdt4wtYBtJd5Fq0FAUY7LZ8I2xX7Q3SI48HYsP6JRECQVtLOzsODhvURJNgAWuT/ir5+pckp5mhDlM0B3XqOz05V9LSYsq8alzUisbOxWYf2EBvzshNICi8l1dxHmLDRR+nlWYU3tnzo1qCP4r+k2zN4OMV5kyNKqP/Lapc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754996755; c=relaxed/simple;
	bh=icvcw5cv/S5/az+HE51QdY3T0VQNqa7tt7aAOoOvsE4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ni3pu8PYKaPZd7l3rmn8Cy2/KjIJqUfxRQaawKYtUN9LLxBJDJ2wxaDtxEY4bORPlAo1/NgU6DqAbeCpummgAnY91Yj8JeTH3jPOOoS05HMVubv2gYvlAOaTv0kmJmfSnsLNZtqZJAuxkB61Oyzi2EEQgxOk5fOlWV3S5B6oQwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YlAWtlfE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BAE2C4CEF7;
	Tue, 12 Aug 2025 11:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754996754;
	bh=icvcw5cv/S5/az+HE51QdY3T0VQNqa7tt7aAOoOvsE4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=YlAWtlfEslP2PGZn6APs4vKN9yEYWT/W2YvMcySyEYzTwOiNH8S+PpUgxShzxPRpN
	 reSn6km4vm2RhWgDzbE223EQiPNnqwUYx5hR5eW1Z3GpenjWQ7ID8ggjDuUXBE04rr
	 a6WU1ZBMC/mVoC6jXet9NXJlQF6KuHGo1sq3LjPtz4ma3qci4+Ti9Yl0Jyia8k3El+
	 7rVCIieUDHYSpUoabO2vpumg0nVZlQ4Q+rzGzj4Rp40+ZCNaQTrFCgV86AbyI+Btg7
	 B9ePf5t54RWPQhIknY4/nSi0cy1NrPfGOCj52Igd68ZrKutjkI8qFLd/OkPvsUpoLq
	 BLSs18olNmdjw==
From: Mark Brown <broonie@kernel.org>
To: Han Xu <han.xu@nxp.com>, Haibo Chen <haibo.chen@nxp.com>, 
 Yogesh Gaur <yogeshgaur.83@gmail.com>, Waqar Hameed <waqar.hameed@axis.com>
Cc: kernel@axis.com, linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org
In-Reply-To: <pndqzxqkt8u.a.out@axis.com>
References: <pndqzxqkt8u.a.out@axis.com>
Subject: Re: [PATCH v2] spi: nxp-fspi: Remove error print for
 devm_add_action_or_reset()
Message-Id: <175499675297.16293.7078791692637397052.b4-ty@kernel.org>
Date: Tue, 12 Aug 2025 12:05:52 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Tue, 05 Aug 2025 11:33:37 +0200, Waqar Hameed wrote:
> When `devm_add_action_or_reset()` fails, it is due to a failed memory
> allocation and will thus return `-ENOMEM`. `dev_err_probe()` doesn't do
> anything when error is `-ENOMEM`. Therefore, remove the useless call to
> `dev_err_probe()` when `devm_add_action_or_reset()` fails, and just
> return the value instead.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: nxp-fspi: Remove error print for devm_add_action_or_reset()
      commit: 692abf80ce8443a4ded8cade25a1acf772436293

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


