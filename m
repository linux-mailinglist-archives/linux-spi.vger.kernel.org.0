Return-Path: <linux-spi+bounces-9086-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB8EB00045
	for <lists+linux-spi@lfdr.de>; Thu, 10 Jul 2025 13:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2F984E29BD
	for <lists+linux-spi@lfdr.de>; Thu, 10 Jul 2025 11:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB71A2E541B;
	Thu, 10 Jul 2025 11:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KEVvT92Y"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31962E5413;
	Thu, 10 Jul 2025 11:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752146020; cv=none; b=gPkVXOAiyNUTiAi3tu3njpiuq+cjeQjevJmXPOdUhI84FmrXL5YGPfgALcYZLKR1aOorJZVGeWWe63pUkIvaMcNZOohNfddo4mwF/BFEIpem9hjJC5FVaVtP/dhM2LycHztYq3buftNIbBxY3OKl7c+dh7iFwN5VE7C2+GkfhqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752146020; c=relaxed/simple;
	bh=4X1k08I+1szAcBSWdpAKN7Ue+/El+sGr31sFWEzkxWc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=A2viPaYG3SdgvOWYjjKGSKmA37GZNxvl3uZ7H1Njyi9CD/QXpoNKYwp08LwwvWGH+4t7e9OfwM0+jwz1GNf6H6a1KAjcL+Ss2JFjuJuoe4dAJJGOBaEOKfoYFckmDxAOGR7Qp4+GXMVwDKKMj+yogVEXI+ze830wag5BlMLIwOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KEVvT92Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53391C4CEF6;
	Thu, 10 Jul 2025 11:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752146020;
	bh=4X1k08I+1szAcBSWdpAKN7Ue+/El+sGr31sFWEzkxWc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=KEVvT92YtU3y/9hW3AqIzx6gbrl1RIaPZgvONU1PcAzANyh2LaGLMiRw0/ZGZHGfD
	 zF4xu0/ilx/zNaEqUGcvctuOHwxQKUoCKfCsszruoDxRBN9+pRmEIWEjXqP+2EjaAo
	 REk/6Val8txaVSlfChnUC+b871RyVraG20gIdsBxwpwr5l7VSkLK6WlWlnB7ci6pnk
	 BqcKVtDtPkL15kRByXdfZoAZugWXec0DKdN3Gj2mV6DB+fmda0UQaOsEw4qvOtrfYx
	 gajShB97Il86/1B8BE41R33nUcF+suTXixwX/SNrx25WU896lViVMSPNz9YK6QTi7t
	 VMfDib130ZYLA==
From: Mark Brown <broonie@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org
In-Reply-To: <108c136f2cab9aa8bc8ac90d14a05e66fb87deb0.1752087740.git.geert+renesas@glider.be>
References: <108c136f2cab9aa8bc8ac90d14a05e66fb87deb0.1752087740.git.geert+renesas@glider.be>
Subject: Re: [PATCH] spi: sh-msiof: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
Message-Id: <175214601951.738213.15635248057516377289.b4-ty@kernel.org>
Date: Thu, 10 Jul 2025 12:13:39 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-07fe9

On Wed, 09 Jul 2025 21:02:33 +0200, Geert Uytterhoeven wrote:
> Convert the Renesas SuperH MSIOF driver from SIMPLE_DEV_PM_OPS() to
> DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr().  This lets us drop the
> check for CONFIG_PM_SLEEP without impacting code size, while increasing
> build coverage.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: sh-msiof: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
      commit: 3106db4ead939a70d332a66214eccce6805b991f

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


