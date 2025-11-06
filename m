Return-Path: <linux-spi+bounces-11101-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 566B4C3DE89
	for <lists+linux-spi@lfdr.de>; Fri, 07 Nov 2025 00:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B54734EB587
	for <lists+linux-spi@lfdr.de>; Thu,  6 Nov 2025 23:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5625834FF54;
	Thu,  6 Nov 2025 23:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="czVbaEl1"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA7B357702;
	Thu,  6 Nov 2025 23:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762473275; cv=none; b=lDlCJNJQsCJlWRMCSE8P0pvIusfu/7QGj2uXU7CCWbrMqxeeYzb8z/080gaQm6aBESO48pegUOf7mRTbH6sRg9x3ZEZo+slnqHuJdCMrh7+qjypWYlfBq8+5sGYGVvSzlQkwua/b0rqyogdaIy7vnRoJnZ2IQdw8JdDytXpsq3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762473275; c=relaxed/simple;
	bh=vacWDoP23+KxKASrx7w9Nsp0tGfB2QguzpyvMEsdfY0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=A7yf/dYzpXlcs0ZHwMz3uplEdv/9uWgtR3gLTFRUe4CHPOLrUPFI836en5bKSS2ObXyDhFyWmoZnoJ6CS427aEfeGRyxg9QK25j2fkKorKyBkyJAIKkPz8y23+7XKmVYlmgNhgWxsNQDcLzPRYIf2ntQLav2tS4s20LH83TOaic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=czVbaEl1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 453E6C113D0;
	Thu,  6 Nov 2025 23:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762473274;
	bh=vacWDoP23+KxKASrx7w9Nsp0tGfB2QguzpyvMEsdfY0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=czVbaEl1cdTwLn5JGM1WjRnyLDcWhzrZxliIBEs5C63XByratweg7kp/XwWDXbkpE
	 Lk7qI/hHnI7e5ASO6JWJ66I66+/3LXofbXPmO9W5OabHAxUTxuxQGCfp5I5P/oDgKs
	 SmekLxjueUZTpohjAgvQcl/Lo8yp0KJ3q4hEJPqdorr/1qosw+GZiDDW3eQja0thKv
	 YtXl8/yAOpmYichNsZ7XxpRcg3MEnAS0NsRSMYr02v9Wpip1wZGvdGBRSbrAXmYQWb
	 0I9EEkKo970N372vaePr6TXuMOjO35ovZ6hODCgzy67OlghzAfkZvVfEYCHdz1OzCe
	 rNfRiAlsgeSFQ==
From: Mark Brown <broonie@kernel.org>
To: frank.li@nxp.com, shawnguo@kernel.org, s.hauer@pengutronix.de, 
 kernel@pengutronix.de, festevam@gmail.com, carlos.song@nxp.com
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251024055320.408482-1-carlos.song@nxp.com>
References: <20251024055320.408482-1-carlos.song@nxp.com>
Subject: Re: [PATCH] spi: imx: keep dma request disabled before dma
 transfer setup
Message-Id: <176247327113.2483158.8547481870212835167.b4-ty@kernel.org>
Date: Thu, 06 Nov 2025 23:54:31 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a6db3

On Fri, 24 Oct 2025 13:53:20 +0800, carlos.song@nxp.com wrote:
> Since sdma hardware configure postpone to transfer phase, have to disable
> dma request before dma transfer setup because there is a hardware
> limitation on sdma event enable(ENBLn) as below:
> 
> "It is thus essential for the Arm platform to program them before any DMA
>  request is triggered to the SDMA, otherwise an unpredictable combination
>  of channels may be started."
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: imx: keep dma request disabled before dma transfer setup
      commit: 86d57d9c07d54e8cb385ffe800930816ccdba0c1

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


