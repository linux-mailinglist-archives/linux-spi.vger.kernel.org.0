Return-Path: <linux-spi+bounces-5606-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E1A9BB71D
	for <lists+linux-spi@lfdr.de>; Mon,  4 Nov 2024 15:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C66161C229A9
	for <lists+linux-spi@lfdr.de>; Mon,  4 Nov 2024 14:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82EEF2E634;
	Mon,  4 Nov 2024 14:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kcTn19Qo"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BD179FD;
	Mon,  4 Nov 2024 14:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730729219; cv=none; b=tf0iPo4/m6f97YEboyELsm+T6lapknNO+BmaVaqkIKaRPIbTWm5lgETSxz1MMMgr4g89oYwrsrVy+DAerewwtiXlzz6QpigCLx8TcSly+ORGkPfOjNqxhXMkD7+thWIXHpo10tVt2Yi9YdocOcByx5CRwruLWN/IUzH28UGAEXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730729219; c=relaxed/simple;
	bh=cHw5WjtOXh0me9VqJiV7HdyADOxP6s53il3edf42Mt4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LtgiWayFT3Nmw9Wi+QqMtz7hG6y0scnUpKQEdLKI6KfE/bMu8VI7fke/CBZ9NFjAwzaOrHkxwBQ0dJeyoV+EgjIXZ2lCAwhHtZ6MXWnDNUApUWmKxpHfGR4kvQUmE3XoBLMhvFYkCwkq8J3Vq/wM6lRwFvs8PaLze/Cqg4xm9SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kcTn19Qo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEEABC4CECE;
	Mon,  4 Nov 2024 14:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730729218;
	bh=cHw5WjtOXh0me9VqJiV7HdyADOxP6s53il3edf42Mt4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=kcTn19QoOZ8N3noXn3Xf0+pBYAE6lsela1cTKFNWrGKTQSmpsaMtschIea2WiPnae
	 I/OGGgjNCHCzRKy07B42miiBULfDs+10DVGDdPNwbzX8pn98sFBLxAAIlslDj6rkhW
	 8ZGtT3CBKixMm7gWTz6betED4jmRhn3PZxfN2IohbPyqJLUIpvPS+p5X4ITIBrkC2j
	 THEZtvjHDOsXVpTH9Sn8M+UIwEpLZUGHCtL+R4KDHdyDLjGiGG7l9DUfitoegWuX7A
	 w1pLAGLE6LRDl/7V1zEpJL4IUnYENCQyCJ/gU7r1TKh6wtUy//tiWx2ivMf3UXzhkc
	 aI08pXU+9iC2w==
From: Mark Brown <broonie@kernel.org>
To: miquel.raynal@bootlin.com, 
 Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20241030194920.3202282-1-chris.packham@alliedtelesis.co.nz>
References: <94ffb58b-3242-4ab4-b09a-686116ced781@alliedtelesis.co.nz>
 <20241030194920.3202282-1-chris.packham@alliedtelesis.co.nz>
Subject: Re: [PATCH v2] spi: spi-mem: rtl-snand: Correctly handle DMA
 transfers
Message-Id: <173072921657.32316.5006858752359296486.b4-ty@kernel.org>
Date: Mon, 04 Nov 2024 14:06:56 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Thu, 31 Oct 2024 08:49:20 +1300, Chris Packham wrote:
> The RTL9300 has some limitations on the maximum DMA transfers possible.
> For reads this is 2080 bytes (520*4) for writes this is 520 bytes. Deal
> with this by splitting transfers into appropriately sized parts.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-mem: rtl-snand: Correctly handle DMA transfers
      commit: 25d284715845a465a1a3693a09cf8b6ab8bd9caf

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


