Return-Path: <linux-spi+bounces-11654-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CAEC92DE7
	for <lists+linux-spi@lfdr.de>; Fri, 28 Nov 2025 19:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DE20634A61D
	for <lists+linux-spi@lfdr.de>; Fri, 28 Nov 2025 18:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678D033345E;
	Fri, 28 Nov 2025 18:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r073bm1g"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EF4333433;
	Fri, 28 Nov 2025 18:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764352911; cv=none; b=Swx86SiYFrCLfcrEJhze6RjkG24G5HD2crY4Xtt/TDceCoHySiNtAQC6Q8UoN3FP8CodVs8h2B5CsELVasxCyU7eZZjKpoW1y5N5OT5WvnZDW5Ic6UfEukbPg821JPGG/vBV4ECb2wi+vNI5NxUMdz3YO+pN+A0s2dyKz7Rbyvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764352911; c=relaxed/simple;
	bh=nIj9GJmGmm3gXhpfSVqDemdTm6aqHnRhp8OrHb0ZB7g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fDmHiQtbUbDIZfqYmlelCXzkguq82zJbi2gyvifYGrimM/EvUt6yxdFZg0aqKjb3ILQT+z9pH/AW/gAdtnboqE6vhQFpQ18nkFHtrQDJbb50853Lcqxhri3pya38S5r3ougc62jWlclnX6bD+Z6/DIBzwq0jq3fXJARuoLoj6MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r073bm1g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F0F9C113D0;
	Fri, 28 Nov 2025 18:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764352910;
	bh=nIj9GJmGmm3gXhpfSVqDemdTm6aqHnRhp8OrHb0ZB7g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=r073bm1gqwBPK++bFhBOo0wlAwGMh4Xgwso6K9UQd3weuyitiugQDvmoPcq4jNjQ+
	 kozgUj4eCY0crFAO+LxIYdnNgMzX/qpLPu6u1bdP85g8+qIE8+GDwDPUjie3erJEvW
	 ISKv27Pujoqi0UOWof2eA1d0i3m9VPl8caO2GJnFuAfaKrJftml+Ud5SNevmEj7BIn
	 XNb0pXygVtSb/uhF9DeRAuU86qXCZlufx2CcZAxqgvQhauEz1lbv5KTttthvtVaDwi
	 v7VFH1hXTRUgPVXMiEBKLEYl+xWJd+co3w3y5AT2rxhLZpsHVV3b4rqe8inDcmvZno
	 zHy7qURKZHl7w==
From: Mark Brown <broonie@kernel.org>
To: Tianchu Chen <tianchu.chen@linux.dev>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 gregkh@linuxfoundation.org
In-Reply-To: <20251128160630.0f922c45ec6084a46fb57099@linux.dev>
References: <20251128160630.0f922c45ec6084a46fb57099@linux.dev>
Subject: Re: [PATCH] spi: ch341: fix out-of-bounds memory access in
 ch341_transfer_one
Message-Id: <176435290978.114164.11348727837075094329.b4-ty@kernel.org>
Date: Fri, 28 Nov 2025 18:01:49 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-88d78

On Fri, 28 Nov 2025 16:06:30 +0800, Tianchu Chen wrote:
> Discovered by Atuin - Automated Vulnerability Discovery Engine.
> 
> The 'len' variable is calculated as 'min(32, trans->len + 1)',
> which includes the 1-byte command header.
> 
> When copying data from 'trans->tx_buf' to 'ch341->tx_buf + 1', using 'len'
> as the length is incorrect because:
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: ch341: fix out-of-bounds memory access in ch341_transfer_one
      commit: 545d1287e40a55242f6ab68bcc1ba3b74088b1bc

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


