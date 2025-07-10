Return-Path: <linux-spi+bounces-9085-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02482B00041
	for <lists+linux-spi@lfdr.de>; Thu, 10 Jul 2025 13:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 852EA3B9AC0
	for <lists+linux-spi@lfdr.de>; Thu, 10 Jul 2025 11:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727382E4246;
	Thu, 10 Jul 2025 11:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U08VFb0P"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B3C288C22;
	Thu, 10 Jul 2025 11:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752146019; cv=none; b=dX6p5Y68eOZ2vwxcBbJ8gd47wfO0Ewuro0aDDeyXWSoccf57mcfMQI18b2kDbfQD4jiiTSssJL4N8twFf9i4RrYMYrh8oEMxw8uxbRhuhwHfg68fOaRPYyvomXF9uNZtF0nRfqtv0aAgSe4/RFdK+REdXXWyC1N316kb5SC0+QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752146019; c=relaxed/simple;
	bh=SZZVX33tFwYNmYwNQIz8wWvoVPtAObK+VTQZpsraHno=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WoUPjJDCChwFHe0jARSQRDFyrWP3sjolPugd8nFnZcg4jsRqAkpjqkcoCa58kQK7qprdzLHyQj2elI1eq+iCisQAiHxcPoyF0hXLS46l0EAdsNIFZttv2r3Ccp164vXGLi9c+V6X2HrCdssz3xvEOi6Dkby0iDEYZKB71Z17Uho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U08VFb0P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25130C4CEE3;
	Thu, 10 Jul 2025 11:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752146018;
	bh=SZZVX33tFwYNmYwNQIz8wWvoVPtAObK+VTQZpsraHno=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=U08VFb0PGv12oCg+IEi3gHYNYYjfd6OuNFYfM2RiuVvWnn3lTI1aIzCNVqHfuJ8Ue
	 TZOkuqqnGhwq+U92pkSC2y8OU53f+VLThAyI4+focLWz++kXtowQsAM11LK/a3yavu
	 HSOfBqUHFRJwMw+kE9Z4psynIyd7x0kysHx127ZgM4017jnru3c+p0W4nQDKuh4GNm
	 cWU4BQVrVoIUy86pTgn5E9fgcDLxbX2Jj5lSjr0aW6Dm9bLtLQD5Q387bTY0MNaChl
	 GZGuLLSzhVv7G2hfC4lQRgRAtYsInDlkinMeOMVcEWoZjjndVTIs44rJXvU2yMKCkY
	 21McYKUnd2kIA==
From: Mark Brown <broonie@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org
In-Reply-To: <0b64c1c3803e6d3eeb3ae9cd8921d4fe67f37118.1752087701.git.geert+renesas@glider.be>
References: <0b64c1c3803e6d3eeb3ae9cd8921d4fe67f37118.1752087701.git.geert+renesas@glider.be>
Subject: Re: [PATCH] spi: rspi: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
Message-Id: <175214601829.738213.12507654992746989151.b4-ty@kernel.org>
Date: Thu, 10 Jul 2025 12:13:38 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-07fe9

On Wed, 09 Jul 2025 21:02:09 +0200, Geert Uytterhoeven wrote:
> Convert the Renesas RSPI/QSPI driver from SIMPLE_DEV_PM_OPS() to
> DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr().  This lets us drop the
> check for CONFIG_PM_SLEEP without impacting code size, while increasing
> build coverage.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: rspi: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
      commit: 7d61715c58a39edc5f74fc7366487726fc223530

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


