Return-Path: <linux-spi+bounces-11902-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3D2CBE915
	for <lists+linux-spi@lfdr.de>; Mon, 15 Dec 2025 16:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 292EB304C5FD
	for <lists+linux-spi@lfdr.de>; Mon, 15 Dec 2025 15:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D18332EDC;
	Mon, 15 Dec 2025 13:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dmFXi6G4"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83E2332ED1;
	Mon, 15 Dec 2025 13:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765807179; cv=none; b=lxI4re80vwAnFyhke9DGhICLNE7To0Ix7PZfcej9XDkTCt7KnfZxod+S0p6HIn8ZD/NLrnogVAwURgv4XjWzLKj7x/j5VNHXGqMXeTk5godDGO9fv4ilx+3+EBTOO2Hqx+bN2dTXJXsF6KU/RL+uQnvppT2UZzd1xjHfICcOnNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765807179; c=relaxed/simple;
	bh=HSeF/yIT4YYKt0JjeqG3v9sQm1v8R3qlOCfKip7MIWA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pMdpPwY6nvoO8osa42UFVRxN1IGA4UMkbNOGT/EuPtlnvSGqPzjwDZGNFJFbXGOhaSje1dKhCJYMw3f5tds9UCaA+wvTT7UD01pim38h+MgN2L9FC5r6LhiXAX3OaOJyPq0CFx3VcFUAFikI1bIRmwhCqR7NTG1JVEb1byD5434=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dmFXi6G4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C301C4CEF5;
	Mon, 15 Dec 2025 13:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765807179;
	bh=HSeF/yIT4YYKt0JjeqG3v9sQm1v8R3qlOCfKip7MIWA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=dmFXi6G4MeFEAUqvqplrCbe02Vhgac4FjX1Rhd3MwCLJdbUb7R+8+x1vAktZ5bgpH
	 W7hK9qMm9THCDX4FuDfn1w7xG5OREZSJEDG+6j5923Q9dkKy39jAOMX5dXvHpqe9IZ
	 LqGWoLQNkbDKn563l1+ZQnKuQoEzy30fFItvSJWGXv0FneJOmCOe8RQtiq26y+hMM2
	 49kK3S05YfwzUgw5PnedhpKe45Pdv5aRlwnxK+iEZdoF76/Zb8NoKgnItfIrNNacV9
	 2A8ThrlJ5+K49yqSlJVlAksLItzfbo3hka32ozXAer2cnKhnISnG7kzPTeKrU9L6zm
	 TOwJpTaw2OJJg==
From: Mark Brown <broonie@kernel.org>
To: Frank.Li@nxp.com, daniel.baluta@nxp.com, david.laight@runbox.com, 
 andriy.shevchenko@intel.com, Carlos Song <carlos.song@nxp.com>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20251210074115.3883180-1-carlos.song@nxp.com>
References: <20251210074115.3883180-1-carlos.song@nxp.com>
Subject: Re: [PATCH v2] spi: spi-fsl-lpspi: convert min_t() to simple min()
Message-Id: <176580717793.161463.11173004262284730987.b4-ty@kernel.org>
Date: Mon, 15 Dec 2025 22:59:37 +0900
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773

On Wed, 10 Dec 2025 15:41:15 +0800, Carlos Song wrote:
> Current min() has supported comparison by normal integer promotion rules,
> so explicit type casts or min_t() are not needed.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-fsl-lpspi: convert min_t() to simple min()
      commit: b884e34994ca41f7b7819f3c41b78ff494787b27

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


