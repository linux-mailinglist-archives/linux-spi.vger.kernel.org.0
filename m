Return-Path: <linux-spi+bounces-7646-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A0AA9229A
	for <lists+linux-spi@lfdr.de>; Thu, 17 Apr 2025 18:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CCB719E3677
	for <lists+linux-spi@lfdr.de>; Thu, 17 Apr 2025 16:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79EF4254867;
	Thu, 17 Apr 2025 16:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e7hcoEI1"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E811253944;
	Thu, 17 Apr 2025 16:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744906930; cv=none; b=Gr2e1Q0rtg5Ds4IrrLone6HMH5E2Q7GtpWGOdyrpGh6UlcP2i7GFp7ZmJA1LCF7X9xT+6etKfTXgiZX/y8einJysgH4TmtDAYiJ2J2wXnlf8BM8TSrMFLnLZf9ifA9hchBBDTPTAyk1WdNSmwgUtk5fvgX8DkPVkebk5ipHJ7Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744906930; c=relaxed/simple;
	bh=+tJVKOIu+gBSCFEwwsnlu5dV6AI8KsV8zFpj108Zr4o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=O6l/lFb59kpQJvuel32am8H1pMmI7B/RbCs2J+sDun1Jfkd0WnG+wCSs4zS2aY0A/dlei7NdcDTjwXRdeMtDl+1jS2QoYeztRTl2ABrLQ8qo5fH0j68guL5nHNeG/NRtW4oOzlbixFcPLMKrK1hEcageKJfFkceI0gYPYlg5Td8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e7hcoEI1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A355C4CEE4;
	Thu, 17 Apr 2025 16:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744906929;
	bh=+tJVKOIu+gBSCFEwwsnlu5dV6AI8KsV8zFpj108Zr4o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=e7hcoEI1K2N7tr2pPvAvyGf9F2OS0j6PilDcGIYecuC+tWybN1PsAfR/i1HPUXMoV
	 5dIH0NEUai+CFJeC5gkKpXo2g/WIqqkFRtSTEao/i/e28EpyWfGjY2V2QSIg1rMRof
	 Ux/w/fbqIyvS+fTcFPDMAwOZwTqKwcMnPsUiywa5Q5mpASAY63CbgFMxf594yLjFRS
	 kSxHLWbblcwy3YmhptglAY35iQ/TnzyvlEirtSpft+EEomL8naaEvil33ZvQExiwz0
	 rxi4wWP8ocVY5/4dQXCV5SmGxIBQzXGDs4yCDmJld52zduHnvNSxUrsw8KxT45ZZUK
	 Ep0J7+gOUDeJw==
From: Mark Brown <broonie@kernel.org>
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Tamura Dai <kirinode0@gmail.com>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250417011700.14436-1-kirinode0@gmail.com>
References: <20250417011700.14436-1-kirinode0@gmail.com>
Subject: Re: [PATCH] spi: spi-imx: Add check for spi_imx_setupxfer()
Message-Id: <174490692776.121478.4533295304176579175.b4-ty@kernel.org>
Date: Thu, 17 Apr 2025 17:22:07 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Thu, 17 Apr 2025 10:16:05 +0900, Tamura Dai wrote:
> Add check for the return value of spi_imx_setupxfer().
> spi_imx->rx and spi_imx->tx function pointer can be NULL when
> spi_imx_setupxfer() return error, and make NULL pointer dereference.
> 
>  Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
>  Call trace:
>   0x0
>   spi_imx_pio_transfer+0x50/0xd8
>   spi_imx_transfer_one+0x18c/0x858
>   spi_transfer_one_message+0x43c/0x790
>   __spi_pump_transfer_message+0x238/0x5d4
>   __spi_sync+0x2b0/0x454
>   spi_write_then_read+0x11c/0x200
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-imx: Add check for spi_imx_setupxfer()
      commit: 951a04ab3a2db4029debfa48d380ef834b93207e

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


