Return-Path: <linux-spi+bounces-10681-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F215BE0390
	for <lists+linux-spi@lfdr.de>; Wed, 15 Oct 2025 20:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9048C1A2214F
	for <lists+linux-spi@lfdr.de>; Wed, 15 Oct 2025 18:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7F424DD0E;
	Wed, 15 Oct 2025 18:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MEchDQXs"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357EB325494;
	Wed, 15 Oct 2025 18:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760553644; cv=none; b=Eucz5kO7dcQF3hiVwB3KczzBFrmcb7ww+Ds2v7iWc2BAPttXJcMdpU62Fmne11aNyoNfjlPnBrUzrU2Bs225ODiIV+T3DVvoO4HEOzickMoptdVsmwLwjJgH+io3Y5llclreVm2hqADC10bHQqXBIOsdagyYJxnhDHbNFZTel54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760553644; c=relaxed/simple;
	bh=H0LK3jf58lHqeQSZDBy/bGvSR2+1yiWmpq9cIX0g0yM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=maMSE7H4jjtnYQip4OKLnwnr/mlSdQ+UuXbyxFDa6Nt81BWXlGKm79wTLBJV3oSjFSg4jbqaQXfwB06BMxeH4nFMG6WETtteZc7UbK85NNjHGxtbcQLFyyW8VyLHbH1oMhE72oGctFfpFf6VxQUVt5DoA8mmxRbt9+XLX0RHIQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MEchDQXs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F4B3C4CEF8;
	Wed, 15 Oct 2025 18:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760553643;
	bh=H0LK3jf58lHqeQSZDBy/bGvSR2+1yiWmpq9cIX0g0yM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=MEchDQXsLQPsMXfoG1lbrsBUKoQBou/7BZs5sd9mxgkrzpATNpdaoLyp4mgTZ9DCE
	 ov8yw3FCsnCDYz6RsqM4nyqS9s0FnP/6lbn9Im/xet1blK/nnOyRBqlmLN31vEAxiH
	 sXg5lWfhp4YA7gxna4aj4tdLYKOca58rHxnsDqMKHCTWHFA1H76hc2CbrctceGWIYN
	 DaLoNsjlPzOJaRtXTq1j/pZKi6Xy0BY0/yPBmposyHTqfNwq0lKQO4O3cqRXKOVh71
	 jBaMVFC/T3MiT9RAoLpklEDe5wyE799oSecjZbBUamr2qs7BvYHZFi1V5K7iPFgl1O
	 GOGSH2O9SlhJQ==
From: Mark Brown <broonie@kernel.org>
To: Liang Yang <liang.yang@amlogic.com>, Feng Chen <feng.chen@amlogic.com>, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc: linux-amlogic@lists.infradead.org, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20251015-fix-spifc-a4-v1-1-08e0900e5b7e@amlogic.com>
References: <20251015-fix-spifc-a4-v1-1-08e0900e5b7e@amlogic.com>
Subject: Re: [PATCH] spi: amlogic: fix spifc build error
Message-Id: <176055364173.227902.13691115706455809982.b4-ty@kernel.org>
Date: Wed, 15 Oct 2025 19:40:41 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-2a268

On Wed, 15 Oct 2025 15:36:59 +0800, Xianwei Zhao wrote:
> There is an error building when
> Compiler version: gcc (GCC) 14.3.0
> Assembler version: GNU assembler (GNU Binutils) 2.44
> "
>  Error log:
>  WARNING: modpost: missing MODULE_DESCRIPTION() in arch/arm/probes/kprobes/test-kprobes.o
>  ERROR: modpost: "__ffsdi2" [drivers/spi/spi-amlogic-spifc-a4.ko] undefined!
> "
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: amlogic: fix spifc build error
      commit: 6b6e03106163458716c47df2baa9ad08ed4ddb0e

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


