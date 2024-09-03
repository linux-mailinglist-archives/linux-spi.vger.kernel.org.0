Return-Path: <linux-spi+bounces-4580-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 238A396AC87
	for <lists+linux-spi@lfdr.de>; Wed,  4 Sep 2024 00:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C70E51F26A8C
	for <lists+linux-spi@lfdr.de>; Tue,  3 Sep 2024 22:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9FB118733B;
	Tue,  3 Sep 2024 22:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jep7ba4A"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57791EC01E
	for <linux-spi@vger.kernel.org>; Tue,  3 Sep 2024 22:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725403842; cv=none; b=jDnFpPngwoMp4bVu+AB2SNuvu/sCCvpaBPcrN35SNuZtfvUvxxFkSPoC9ori7yYvEisEfFatgpfRgzWXyyFPsW43t4HCqb7351iQHMa01xtIYUtI1Ur9QBc7ZRC8hq3qt1rmJuVmuc1ImiObqJDb2q4E7AfQleEk/XNFyX34zNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725403842; c=relaxed/simple;
	bh=6mAgN1biFEHmMMzyNSjqj6enFEQZiumVgNQNoeAIMfc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LKp3ayAuG9zDxiPjueqYg3wmKAf/SITp1wvKLDEcihLDL1F3i5CSKOE631/mSur9R45GuOCV7gIsrCR7Dq9rzuLq9JeFJkp5KoRQWE/qqBTU817PLEnUaNaQKXl4OQR/cZnSvdQy4/DRRWK1SAZSv/hLvt+IsWjtvI89tbAjxd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jep7ba4A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E97E9C4CEC7;
	Tue,  3 Sep 2024 22:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725403842;
	bh=6mAgN1biFEHmMMzyNSjqj6enFEQZiumVgNQNoeAIMfc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Jep7ba4AiLr912ngPpWdL3ZE/AmqwE+jbgTcQG4MCWlYhWBFuhVRbCHDxKuL5pEl4
	 TrMlqSlxjNgehyJo/H/TcJaIk68d2JDbMSq1IIM9ntsp3tt4Q2ztkW/PjcV3R/Z4CV
	 Ata4Q5B1yk39v7XcFDu32D4Z29SYi7rHWG2QDR/gk51lh/8duJdWoQz2vMUsx7RGXT
	 /m8/0C/yo57LMEUk95bMSCp7UZl7SADiQFuVc9mytDsGqPLhYLKlPHuJ9Rl6ID2mJ8
	 IVHiWW+BZN3XLqoB961POcXyu3ZeM5VAG3VPOJtafn66MKAmkN3bc305yJLRCwUKJe
	 aqas1G+csfECA==
From: Mark Brown <broonie@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-spi@vger.kernel.org, Fabio Estevam <festevam@denx.de>
In-Reply-To: <20240902184655.932699-1-festevam@gmail.com>
References: <20240902184655.932699-1-festevam@gmail.com>
Subject: Re: [PATCH] spi: mxs: Switch to RUNTIME/SYSTEM_SLEEP_PM_OPS()
Message-Id: <172540384168.163782.16145308973939814655.b4-ty@kernel.org>
Date: Tue, 03 Sep 2024 23:50:41 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Mon, 02 Sep 2024 15:46:55 -0300, Fabio Estevam wrote:
> Replace SET_RUNTIME_PM_OPS()/SET SYSTEM_SLEEP_PM_OPS() with their modern
> RUNTIME_PM_OPS() and SYSTEM_SLEEP_PM_OPS() alternatives.
> 
> The combined usage of pm_ptr() and RUNTIME_PM_OPS/SYSTEM_SLEEP_PM_OPS()
> allows the compiler to evaluate if the runtime suspend/resume() functions
> are used at build time or are simply dead code.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: mxs: Switch to RUNTIME/SYSTEM_SLEEP_PM_OPS()
      commit: 02774b14439dd5a8982335e779b62628d85eb76b

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


