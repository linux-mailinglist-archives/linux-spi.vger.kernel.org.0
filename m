Return-Path: <linux-spi+bounces-47-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C20AE7FA6CE
	for <lists+linux-spi@lfdr.de>; Mon, 27 Nov 2023 17:48:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E55D41C20DCB
	for <lists+linux-spi@lfdr.de>; Mon, 27 Nov 2023 16:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA192D04E;
	Mon, 27 Nov 2023 16:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JqLdNP3D"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF8836AEF;
	Mon, 27 Nov 2023 16:48:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FCF4C433C9;
	Mon, 27 Nov 2023 16:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701103706;
	bh=ZF5IoXyR+ygbWYthHSnW9fxYoYbbvQNyhDhZySyIW7M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=JqLdNP3DGt+Nd93zMjsBGZgXuEpfv2BfSL+yOud9znBngZo0qZB0XIiRYNFuVuy/o
	 PSjzk+oDm1uTak2AkWgpAYaw2be6gt1l8GM3QNiT0uoc4q8kbzN2k/vTTNXWJunZHB
	 RJkRJ4PqEBHp1rquP5ztX6wd+QeAEP9vcOUX8n0oTKiNMfxmg9JKa0N7MERtkhFLJx
	 D3rBeAXzl2EDelDb63r72gpUf6eXdbvnvkQb1dSUh72xUJpkkFypW2E+//46gk29Un
	 Ac/8wTZmAld3TkHanqcLBafl/QPFzUuca2IzZHl9awFwehASEXfS4PqfmJbcHVDRFJ
	 yjOAVcB6sjHcg==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Ryan Wanner <ryan.wanner@microchip.com>, stable@vger.kernel.org, 
 Ronald Wahl <ronald.wahl@raritan.com>
In-Reply-To: <20231127095842.389631-1-miquel.raynal@bootlin.com>
References: <20231127095842.389631-1-miquel.raynal@bootlin.com>
Subject: Re: [PATCH 1/2] spi: atmel: Do not cancel a transfer upon any
 signal
Message-Id: <170110370490.2695086.9828571679436620959.b4-ty@kernel.org>
Date: Mon, 27 Nov 2023 16:48:24 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c

On Mon, 27 Nov 2023 10:58:41 +0100, Miquel Raynal wrote:
> The intended move from wait_for_completion_*() to
> wait_for_completion_interruptible_*() was to allow (very) long spi memory
> transfers to be stopped upon user request instead of freezing the
> machine forever as the timeout value could now be significantly bigger.
> 
> However, depending on the user logic, applications can receive many
> signals for their own "internal" purpose and have nothing to do with the
> requested kernel operations, hence interrupting spi transfers upon any
> signal is probably not a wise choice. Instead, let's switch to
> wait_for_completion_killable_*() to only catch the "important"
> signals. This was likely the intended behavior anyway.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] spi: atmel: Do not cancel a transfer upon any signal
      commit: 595d2639451d3490c545c644ece726a0410ad39b
[2/2] spi: atmel: Drop unused defines
      commit: 28d8051efae17b6d83544f3c1cf06f6a71677e91

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


