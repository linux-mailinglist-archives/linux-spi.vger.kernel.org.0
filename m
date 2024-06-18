Return-Path: <linux-spi+bounces-3445-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB4F90DCF9
	for <lists+linux-spi@lfdr.de>; Tue, 18 Jun 2024 22:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A0E11C239CA
	for <lists+linux-spi@lfdr.de>; Tue, 18 Jun 2024 20:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880EB15E5BC;
	Tue, 18 Jun 2024 20:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k/+jn9Bm"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA2528DCC;
	Tue, 18 Jun 2024 20:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718740849; cv=none; b=MvAoOvwNxQ8Ws0KFC5iJ6cpCa/cEjda2nn3fd0r8aom6L/YKDIsTWp7V1eSviwm2Vp1GSkKSnb9bmzeZIiDPbI4yAkalBDLdPo7vM7T1PkD8cN3PNwt1nopv7XWaQs98B/K6pjv6w3kteIQnGI0QrNwB24RgKoLQv1nBAQcDGSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718740849; c=relaxed/simple;
	bh=fAhiLVURfgay222nRJe4+GfOvxzl6P/qliqGaISmi6o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=L6ah/XCI3qJKmVO3NhW202/Tk5H7nObHEsNrqrEkRtVVZHGyitLDWaIS2eTpYBgy2PThkpVCMbjEhatEtp3ScOZWAgSNe5rZx3OjOCnD/k36kaVttnNNymUYyUiIh9bH1OJ1AWk7ONrN3+2okfi8LrjiCvvXCUpwVDbDsHhtqK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k/+jn9Bm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC022C3277B;
	Tue, 18 Jun 2024 20:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718740849;
	bh=fAhiLVURfgay222nRJe4+GfOvxzl6P/qliqGaISmi6o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=k/+jn9BmLRHP49qv6veutBe42+CoigaB41DD3vIzqtznwjPDHmxPL0lxZyJq4ocXB
	 U2yriGLN6gYLfLyEG0Le5P3Q0jMFzRk41ssCFR+pH9YUJEL4xP8aeMBL0omD0SPnr0
	 TosWu/EsHyKnd/XPvk2B8nX9BKL1w8gh+2dHPcE+XODRg77Zm+XYdq6P4bBstrKurf
	 5EDOAcq1U8Dle4axeJVrKBKAxJ8JxaHqUfOvx+6VgArq9UFnYGR8Embf92i6PyWxVe
	 GEFsFiCRfiI+ak5kK+6QkBm8ZyfSL/yV99+bCNIddJlSnUn9MyOe0RcdeINLkiH8/Q
	 bfSu6ZhYLOn/A==
From: Mark Brown <broonie@kernel.org>
To: patrice.chotard@foss.st.com
Cc: linux-spi@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 christophe.kerello@foss.st.com
In-Reply-To: <20240618132951.2743935-1-patrice.chotard@foss.st.com>
References: <20240618132951.2743935-1-patrice.chotard@foss.st.com>
Subject: Re: (subset) [PATCH 0/3] spi: OCTAL mode fixes
Message-Id: <171874084769.162949.15399594588029522021.b4-ty@kernel.org>
Date: Tue, 18 Jun 2024 21:00:47 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Tue, 18 Jun 2024 15:29:48 +0200, patrice.chotard@foss.st.com wrote:
> During tests performed using spidev_test in OCTAL mode with spi-stm32-qspi.c,
> several issues has been found :
>   _ OCTAL mode wasn't supported in spi.c
>   _ CCR register wasn't set correctly when OCTAL mode is set in spi-stm32-qspi.c.
>   _ Fix dual flash mode sanity test in spi-stm32-qspi.c
> 
> Patrice Chotard (3):
>   spi: stm32: qspi: Fix dual flash mode sanity test in
>     stm32_qspi_setup()
>   spi: stm32: qspi: Clamp stm32_qspi_get_mode() output to CCR_BUSWIDTH_4
>   spi: add OCTAL mode support
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: stm32: qspi: Fix dual flash mode sanity test in stm32_qspi_setup()
      commit: c2bd0791c5f02e964402624dfff45ca8995f5397
[2/3] spi: stm32: qspi: Clamp stm32_qspi_get_mode() output to CCR_BUSWIDTH_4
      commit: 63deee52811b2f84ed2da55ad47252f0e8145d62
[3/3] spi: add OCTAL mode support
      commit: d6a711a898672dd873aab3844f754a3ca40723a5

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


