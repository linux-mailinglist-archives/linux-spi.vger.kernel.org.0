Return-Path: <linux-spi+bounces-2445-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09ADC8ADD18
	for <lists+linux-spi@lfdr.de>; Tue, 23 Apr 2024 07:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B1491C2150D
	for <lists+linux-spi@lfdr.de>; Tue, 23 Apr 2024 05:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E72F1C2AD;
	Tue, 23 Apr 2024 05:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VUs5HzCo"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A77E208A8
	for <linux-spi@vger.kernel.org>; Tue, 23 Apr 2024 05:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713849608; cv=none; b=BljtJRRmoSSkR3l+0S4Wy509IVwa4doVz7RfWwBdssGcBpD3A0FBoLoJ1VZ+xp17dELGVPNpRbGma77Q+sPBykNiewCBnirQ/woHz5M4FxSVbAYUjLxQ+sZ+StOL3aRwNVtBrNraWSsn1+zk4bsM1tTDC8xAKTTQJ5NAYMCCgog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713849608; c=relaxed/simple;
	bh=WNF2PwpiG44BNeqUTmpix/qVg9aJ9gN2rPMQ4Eu6kuA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VT7WAM7NnqJvbDzv4VbCkLMDZPCmtqCTwkCZZzt3D9oODOegPYcoVtD+J0nyxSL6srwSWDuU4qCvwKtrZkvQRkSpMNN4XsLwNEkgvokXEn5BqI9778qP/aQqH/Oxq+JRQLHJ93YdlvRI4HCCBauUgffDN5rNgdpsh4PabxNXYSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VUs5HzCo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EB4DC116B1;
	Tue, 23 Apr 2024 05:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713849607;
	bh=WNF2PwpiG44BNeqUTmpix/qVg9aJ9gN2rPMQ4Eu6kuA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=VUs5HzCodEiQRA1oG5LURiFwYRuZdXYDaxAHMiiux7LfFDsrKLERZi26e3A/qESfu
	 ne4NCamn/0d6q0NblAUenI+Pv/Xn7wx/d5K2PSXFalhpAHhg/e2HcpohbV/KV/mu3r
	 qXIae7K3D6aa7MkKCcX2sah6Kvsqtiez+soh0VJLaeFo6bd/5zpJM/5+1EPJWrDdrD
	 tKu2GdEybDmaAveAt58XhFuyCLFM757sVn00eaHTzuLfVN23gqYJcGUC3ol3vccbIL
	 lXPkHkMv/racpnoguvxnkpXj1ZY9hSlhWWNdfERVSJ2ajnNrnf9gDQ45u2R4VmIw3v
	 qMkxX3XCiPCTw==
From: Mark Brown <broonie@kernel.org>
To: Heikki Keranen <heikki.keranen@bittium.com>
Cc: linux-spi@vger.kernel.org, 
 Petri Tauriainen <petri.tauriainen@bittium.com>
In-Reply-To: <20240422114150.84426-1-heikki.keranen@bittium.com>
References: <20240422114150.84426-1-heikki.keranen@bittium.com>
Subject: Re: [PATCH] spi: mux: Fix master controller settings after mux
 select
Message-Id: <171384960622.1772257.1739617651787340386.b4-ty@kernel.org>
Date: Tue, 23 Apr 2024 14:20:06 +0900
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Mon, 22 Apr 2024 14:41:50 +0300, Heikki Keranen wrote:
> In some cases SPI child devices behind spi-mux require different
> settings like: max_speed_hz, mode and bits_per_word.
> 
> Typically the slave device driver puts the settings in place and calls
> spi_setup() once during probe and assumes they stay in place for all
> following spi transfers.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: mux: Fix master controller settings after mux select
      commit: 856d9e8e9d42759b7fe6c6e13a2d6ff325b65f91

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


