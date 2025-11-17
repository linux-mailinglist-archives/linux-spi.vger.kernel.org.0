Return-Path: <linux-spi+bounces-11263-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A37C6591B
	for <lists+linux-spi@lfdr.de>; Mon, 17 Nov 2025 18:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F28C0360F71
	for <lists+linux-spi@lfdr.de>; Mon, 17 Nov 2025 17:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852692C08B6;
	Mon, 17 Nov 2025 17:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vOS3x4hR"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5520F231A23;
	Mon, 17 Nov 2025 17:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763400529; cv=none; b=JELcfvXHixwon4PUXGcQR7iu4R9r1JSFoGwa3P+ccmP83k7Ani6z3oVmxbwI8M0AR5S4QSZIHxYmWioxxSQcgcitQjJ36sdbm6SMcdkmg9hy2SkWSmtPNwlwv1yCOBKkPCnuW54sC+qAwR3WXj1p7SG8YiWqhShJCHEKqS8z4iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763400529; c=relaxed/simple;
	bh=MgbIIUbUxj9zMOkcIyD6nSDIJ5miWnGr9erFlMlxtFs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rrjvUF+z3i7al5xe4ctlo0DRex6MeLM4mgkmGurZSAKrDxc3dDRYJVaPfT5iosyB3EnBZVb6pFBTD0s9mUYUi0KWxr9VBPyAlJoOPr54SIxYuBDjAIXebZsprpOJh26UZWJ8382H5EkYRSHlXGd67FtJeOIJs5TRCBSkbrrGG6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vOS3x4hR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7883C2BC9E;
	Mon, 17 Nov 2025 17:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763400528;
	bh=MgbIIUbUxj9zMOkcIyD6nSDIJ5miWnGr9erFlMlxtFs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=vOS3x4hRyZjugl/gy5aRs421rAmk++d8xLk5MntI6as+4cjF8ONX8y8mHKfGk9Zhg
	 R2ykgqabxB/fNmLcdzWVQ6lp0g1ZYG+bLkYcdZAXWxgyTCF+xkGWjPp2+01ADN8+6m
	 3TfOp6vDHkVzTn7kDlewkoX4j9aRRSJcxB1U2Rj2oWrASaApY8PaekHWYaIntHZhWG
	 dDjXohlL8gOwJtYX4+tBleUZb/RmBAgrCtwW7M+3IR9sSYgjSbiVLELbTm2HzCXCtJ
	 Gmk8HifTUtKuzAy7zhhwiW4MjPUHyVXWrMJ7RZa3dm5Gfuj9TLjMh7nw9ZM7nJwfEe
	 FNtyLsz1NX6Pw==
From: Mark Brown <broonie@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>, 
 Grant Likely <grant.likely@secretlab.ca>, 
 Tanguy Bouzeloc <tanguy.bouzeloc@efixo.com>, 
 Jonas Gorski <jonas.gorski@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251116093334.17423-1-jonas.gorski@gmail.com>
References: <20251116093334.17423-1-jonas.gorski@gmail.com>
Subject: Re: [PATCH] spi: bcm63xx: drop wrong casts in probe()
Message-Id: <176340052633.498214.1833802594119426475.b4-ty@kernel.org>
Date: Mon, 17 Nov 2025 17:28:46 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a6db3

On Sun, 16 Nov 2025 10:33:34 +0100, Jonas Gorski wrote:
> Both bs->regs and bs->{rx,tx}_io are tagged __iomem, so we shouldn't
> cast them to anything else.
> 
> Silences the following sparse warning:
> 
> drivers/spi/spi-bcm63xx.c:571:22: warning: cast removes address space '__iomem' of expression
> drivers/spi/spi-bcm63xx.c:571:19: warning: incorrect type in assignment (different address spaces)
> drivers/spi/spi-bcm63xx.c:571:19:    expected unsigned char [noderef] [usertype] __iomem *tx_io
> drivers/spi/spi-bcm63xx.c:571:19:    got unsigned char [usertype] *
> drivers/spi/spi-bcm63xx.c:572:22: warning: cast removes address space '__iomem' of expression
> drivers/spi/spi-bcm63xx.c:572:19: warning: incorrect type in assignment (different address spaces)
> drivers/spi/spi-bcm63xx.c:572:19:    expected unsigned char const [noderef] [usertype] __iomem *rx_io
> drivers/spi/spi-bcm63xx.c:572:19:    got unsigned char const [usertype] *
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: bcm63xx: drop wrong casts in probe()
      commit: 118eb2cb97b8fc0d515bb0449495959247db58f0

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


