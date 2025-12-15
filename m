Return-Path: <linux-spi+bounces-11889-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A167FCBE9B2
	for <lists+linux-spi@lfdr.de>; Mon, 15 Dec 2025 16:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0E5933035A2E
	for <lists+linux-spi@lfdr.de>; Mon, 15 Dec 2025 15:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ABDB32BF5B;
	Mon, 15 Dec 2025 13:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CSlevxOy"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7452132BF51;
	Mon, 15 Dec 2025 13:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765807160; cv=none; b=knUl76mErd3mtR2JG5YeP6fBDYmVfvT6vUwfMyp0/PdnggeoFXnVV4nKcfDEJX5W1eRb/uJg2/7i+wZ7v4vLIV0GCEqn4SHNCfCvEKUuKtc9zNpwnNjYYKz6qXGqS0U4EpG9e0Fciu/oi7/l92ZkNR9/MxIQGPjxQgYPvyDxi7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765807160; c=relaxed/simple;
	bh=/OojgQQEHFpwodZB5vESN5ImwNRR5aNLMCdbYxQXbKg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Xl+EmQ6fUzcGpuSc0kzrT4TDZHL91DelokQ+gUUtORlIvY2n4MhExCcDdkYGSTaS1Jqss0hwqcFh+08HC4igBCwJC4KdG9ZllorsyZWvgFi4tbDiptSEOP9sDkX3svuZ90zf471LhhikIntsky8l2MGXnZ3RNz5akxPbPJXNMyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CSlevxOy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49437C4CEF5;
	Mon, 15 Dec 2025 13:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765807160;
	bh=/OojgQQEHFpwodZB5vESN5ImwNRR5aNLMCdbYxQXbKg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=CSlevxOyDZ9hObHyFh3Uvd4eoUUaHdjoOmLWOt+2zykrTvqzdcVuoNsE6xq5qOB82
	 apkIDV6UT4oK3ofHuIjDz3PgTR0JDE+vMUcg1eYgb1peA+3t4DuVCc3KNT5gqR2rK9
	 CeETq0a12lIJxC9iIFxvbQVKV/5+5nbN3e2xB7I8qQGlSnY17z4ys9Yjg4chgzPBx2
	 97HeeMiavJRpwS49Fn/e7GIPR4QHOT3jAV2T1QX0s5X178W1Nub8OBYMdazZtDYpOf
	 B+95f3EX8AJOuG1793wwOzvq02NTIs2ND/5U7tgU0Fmr+7Q0RUnHWrH0VYn+1smMyo
	 AU/opUL9+pNFg==
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Christophe Leroy <chleroy@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "florent . trinh-thai @ cs-soprasteria . com" <florent.trinh-thai@cs-soprasteria.com>, 
 Alexander Sverdlin <alexander.sverdlin@gmail.com>
In-Reply-To: <07d1ea39a0e9b56846395d79d489a5153206ff5c.1762714267.git.christophe.leroy@csgroup.eu>
References: <07d1ea39a0e9b56846395d79d489a5153206ff5c.1762714267.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] spi: fsl-cpm: Check length parity before switching to
 16 bit mode
Message-Id: <176580715873.161463.2257663574111550019.b4-ty@kernel.org>
Date: Mon, 15 Dec 2025 22:59:18 +0900
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773

On Sun, 09 Nov 2025 19:55:50 +0100, Christophe Leroy wrote:
> Commit fc96ec826bce ("spi: fsl-cpm: Use 16 bit mode for large transfers
> with even size") failed to checkout that the size is really even before
> switching to 16 bit mode. Until recently the problem went unnoticed
> because kernfs uses a pre-allocated bounce buffer of size PAGE_SIZE for
> reading eeprom.
> 
> But commit 8ad6249c51d0 ("eeprom: at25: convert to spi-mem API")
> introduced an additional dynamically allocated bounce buffer whose size
> is exactly the size of the transfer, leading to a buffer overrun in
> the fsl-cpm driver when that size is odd.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: fsl-cpm: Check length parity before switching to 16 bit mode
      commit: 1417927df8049a0194933861e9b098669a95c762

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


