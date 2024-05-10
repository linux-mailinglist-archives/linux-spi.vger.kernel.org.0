Return-Path: <linux-spi+bounces-2804-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF018C1E05
	for <lists+linux-spi@lfdr.de>; Fri, 10 May 2024 08:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F4881F21D26
	for <lists+linux-spi@lfdr.de>; Fri, 10 May 2024 06:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7011649D5;
	Fri, 10 May 2024 06:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sfyjna89"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355701649CF
	for <linux-spi@vger.kernel.org>; Fri, 10 May 2024 06:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715322144; cv=none; b=CUuIo6/IjRuaoTIfdhoK66NUPy3rVl30+fsTR64XP6QH9N4ot2d93Ytpb3yL4OmP3HzLt0QLtF9bDjMFGFBUlGww+zR1+XRDnmVxNKOt1osDnCApFEIT97T2JFVswhWC+tx0BJyOe/jaG8a5JGyTnieF6YaqNQ+EdFOOSz3J4aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715322144; c=relaxed/simple;
	bh=xFguaEWyaETK2RV8z9U0a9HeqXIyYdw2kUrz3RbknPk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lvT+iy/PjTbg53wPQz3iPtI5xYsok1yT0viEba66oSWMi6+AJ4fK5VJs4D6adbYJTd4lwkxHlhBTIg3o0trfAUnx7wwG6yRBRaxy//LBDDLOyu4mtzTN3BrDNZJvQ+sVjjAYwwVG159+2Y/bgxNzm8mkxIw2pSh1okFaW5v1mJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sfyjna89; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8E73C2BD11;
	Fri, 10 May 2024 06:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715322144;
	bh=xFguaEWyaETK2RV8z9U0a9HeqXIyYdw2kUrz3RbknPk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Sfyjna89V5KvSwhiyV2Ucv8DLnTnxCQGruxWwnR2sZ86K7kJyL0RiB/+SC+GxSVzd
	 DvL/HrFac9OoWkuvtbqwm0IIBRoOYjAsI7XOG5n2AxxJ2XmvJeG6S93UI2tOIPDh3U
	 C+rmQBfVsMYo5sGZzZCEaxfpBE2fpRRncSKciTLB6yW1ijqKcM80wYKlDhfDIR965e
	 aEhP9eYsSZN6eE6SNNS0gJ+yowt/NhbbURlcHAvcXkoft0XkaZTpujgvSw32A6b8jR
	 +6SNIwa5jWhTxNw3khBE9R7c3t+3Pf9V4NSO4GXOHUHKmQvT+yYbFJh7KLEYskA+4I
	 Oy0nE1jcHqX7g==
From: Mark Brown <broonie@kernel.org>
To: Serge Semin <fancer.lancer@gmail.com>, 
 Damien Le Moal <dlemoal@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-spi@vger.kernel.org, linux-riscv@vger.kernel.org
In-Reply-To: <7ae28d83bff7351f34782658ae1bb69cc731693e.1715163113.git.geert+renesas@glider.be>
References: <7ae28d83bff7351f34782658ae1bb69cc731693e.1715163113.git.geert+renesas@glider.be>
Subject: Re: [PATCH] spi: dw: Bail out early on unsupported target mode
Message-Id: <171532214242.2045088.11788291541393680824.b4-ty@kernel.org>
Date: Fri, 10 May 2024 07:22:22 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Wed, 08 May 2024 12:20:27 +0200, Geert Uytterhoeven wrote:
> Currently, the DesignWare SPI controller driver supports only host mode.
> However, spi2 on the Kendryte K210 SoC supports only target mode,
> triggering an error message on e.g. SiPEED MAiXBiT since commit
> 98d75b9ef282f6b9 ("spi: dw: Drop default number of CS setting"):
> 
>     dw_spi_mmio 50240000.spi: error -22: problem registering spi host
>     dw_spi_mmio 50240000.spi: probe with driver dw_spi_mmio failed with error -22
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: dw: Bail out early on unsupported target mode
      commit: d6e7ffd4820f8894eb865890c96852085d3640e1

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


