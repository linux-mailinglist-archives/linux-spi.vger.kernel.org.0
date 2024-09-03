Return-Path: <linux-spi+bounces-4523-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E15969C0D
	for <lists+linux-spi@lfdr.de>; Tue,  3 Sep 2024 13:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72A8E2852F2
	for <lists+linux-spi@lfdr.de>; Tue,  3 Sep 2024 11:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB061CB52B;
	Tue,  3 Sep 2024 11:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vO5xzU8W"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81D61A42D8;
	Tue,  3 Sep 2024 11:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725363417; cv=none; b=MkBNvLfG2il+ATSF1NijZzkHAtkB6neh1LTKqAUKOj8iZQ3x0yLMStnlIqMpjERA68yzcQAGAU8JUplg2c4QNEugj33+sHcLni/buMnR0PpajMezPQ/0z0kNI0e8do99FNJrY3EsQXh8r/FdLhyTnTTyBmGgGnwPslQye0wxSM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725363417; c=relaxed/simple;
	bh=qPPJ/d71tP/kr7j7f0x/ahsJLWH9Tv1FTb7UnmvEFvc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=uCxuAu6aDH4GKxarB7NwuxmpowKhhFbGNerToIoB1RMi3tB4cRBjaPneNQuvHB6KIvaoCKg+ao2t8NeEVlp3fPGbpBCYyPFpNlIqJzV9BxCt5BdVPSzU7KR5EvDAkJNXiNmTFFyfVSPLNs1q997BdYI3YE7CA9nBQuURY1R19HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vO5xzU8W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 171E4C4CEC4;
	Tue,  3 Sep 2024 11:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725363417;
	bh=qPPJ/d71tP/kr7j7f0x/ahsJLWH9Tv1FTb7UnmvEFvc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=vO5xzU8WpgSTwUYQ+OEMQlb4pLnS1zkYEfHeCj1OpArx3Wi4Mn7RJlx2AaRWYo/EK
	 Ks3JEsOUIlQ/9dMxjVP+0SstbA1Lvlk2D8AZgJ+eA2vLSW6iPgGl+umM+XL7HGYMt1
	 cmJ9pyNaMILXSw76/lY3vRac+PmMltOysdPX5F8w9DbabY6lQXyiWSuTuJ2+Rr/Wo/
	 Hqc6eQj1zDp9VilWadQbMOcgnbgUpuZxEyu3jmcMXSQVyKgGHpdSnWpf0zo6j8g8Dy
	 tkFmFJjIaDGSYBCEdXlYwEtwSUvU6CNzQwrtEoH3MwpxgT+kQbvYfhPZRlCywGeMkb
	 o87BwojZSWocg==
From: Mark Brown <broonie@kernel.org>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: Michal Simek <michal.simek@amd.com>, 
 Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, linux-spi@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240814192839.345523-1-visitorckw@gmail.com>
References: <20240814192839.345523-1-visitorckw@gmail.com>
Subject: Re: [PATCH] spi: zynq-qspi: Replace kzalloc with kmalloc for
 buffer allocation
Message-Id: <172536341582.28645.16590176643988144585.b4-ty@kernel.org>
Date: Tue, 03 Sep 2024 12:36:55 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Thu, 15 Aug 2024 03:28:39 +0800, Kuan-Wei Chiu wrote:
> In zynq_qspi_exec_mem_op(), the temporary buffer is allocated with
> kzalloc and then immediately initialized using memset to 0xff. To
> optimize this, replace kzalloc with kmalloc, as the zeroing operation
> is redundant and unnecessary.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: zynq-qspi: Replace kzalloc with kmalloc for buffer allocation
      commit: f626a0cd07ddb13f146e52adb4b534da40bb1ff7

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


