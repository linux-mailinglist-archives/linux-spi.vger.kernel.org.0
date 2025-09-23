Return-Path: <linux-spi+bounces-10230-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9BDB94F0B
	for <lists+linux-spi@lfdr.de>; Tue, 23 Sep 2025 10:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 331B53B4627
	for <lists+linux-spi@lfdr.de>; Tue, 23 Sep 2025 08:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89D93191A6;
	Tue, 23 Sep 2025 08:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K9sRTqk7"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEE831281E;
	Tue, 23 Sep 2025 08:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758615126; cv=none; b=Rvn1TnC0guWqZVoo9zyu1mEK5lkqzbEjx5FaFAVbsrlzTZOyRGNwTbhQAde7mMWLXFZ7PQE0dzCdF7Sxz3FA+muLuQg0ehRptqKZlyEy8PZ2ZPRouyj5oZOh6m73ITzMQgkg3rrKg5XmC/Y0UgFj5+1q5GSXVIfPx9AvZJUOy94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758615126; c=relaxed/simple;
	bh=566otoRWAnEBEEivKzD8NdegKSs9W4HSXaOAAZWA9CA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=m88LicDxAGYsPMaB7824J2aCqsJwvU9f7mgWyohA3Yu8MUKN5a1POTJuHkTNnrtfExZ8djkcsG1gm8zWCteAmjdwmai+0CVJqKea1I3oZ/k1os55sELQXy1dHeaQ8/ZkIVT8yOeQZj7pYhaHM720+k2J+H1Gf44hxbcWoByn0No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K9sRTqk7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0EAAC4CEF5;
	Tue, 23 Sep 2025 08:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758615126;
	bh=566otoRWAnEBEEivKzD8NdegKSs9W4HSXaOAAZWA9CA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=K9sRTqk7Bq11Phsy37SomLcDtRpxfIu0N5D0SszWNFZ/p9XLS0gT255Ewy1fPHKTb
	 +mD5GuiSF66F7LsK4daHhUj+z6L9XfnyXD31c0rh8dd8DYcEDanptJ12A/BFK5t+/j
	 g9LyAbthe1huyexHbA7GgmXRuLA1W597YufMVogg662zj6GAnGLGN5c230C+x8Q/iS
	 jcGXu73IMfitmv/rWj0QXi6eE4p6OSanCa1rVtDWJ6y4WkD6+1Y+gXt/AxsQbJWQlz
	 ku1sMqTMqbPYxYvOPaWiEEF0pghEfU4vjO+b2hOnM2dgfticanMue5E4ufgB0Q74jK
	 J6NCoVp2ldmyA==
From: Mark Brown <broonie@kernel.org>
To: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Pascal Eberhard <pascal.eberhard@se.com>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250912-omap-spi-fix-v1-1-f925b0d27ede@bootlin.com>
References: <20250912-omap-spi-fix-v1-1-f925b0d27ede@bootlin.com>
Subject: Re: [PATCH] spi: omap2-mcspi: drive SPI_CLK on transfer_setup()
Message-Id: <175861512446.967375.4560580577067542022.b4-ty@kernel.org>
Date: Tue, 23 Sep 2025 10:12:04 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a9b2a

On Fri, 12 Sep 2025 09:08:58 +0200, Bastien Curutchet (Schneider Electric) wrote:
> If the cached contents of the CHCONF register doesn't have the FORCE bit
> set, the setup() function failed to set the relevant idle state of the
> SPI_CLK pin. In such case, the SPI_CLK's idle state is reached later with
> set_cs(), but it's too late for the first SPI transfer which fails since
> the CS is asserted before the clock reaching its idle state.
> 
> Add a first write in setup() that always sets the FORCE bit.
> Keep the current write afterwards to ensure the FORCE bit won't stay in
> the cached contents of the CHCONF register unless it's intended.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: omap2-mcspi: drive SPI_CLK on transfer_setup()
      commit: 398a8a4e51dbd03e4103ea596ea4ea037fe67175

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


