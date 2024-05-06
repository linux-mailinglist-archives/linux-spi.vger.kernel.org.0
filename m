Return-Path: <linux-spi+bounces-2755-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2938BD0E9
	for <lists+linux-spi@lfdr.de>; Mon,  6 May 2024 16:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF26A284461
	for <lists+linux-spi@lfdr.de>; Mon,  6 May 2024 14:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56C71534E5;
	Mon,  6 May 2024 14:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iaXUcOHL"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942F115533B;
	Mon,  6 May 2024 14:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715007567; cv=none; b=sZv52ziJHdxGitrUwfJOcasad7oFmV0mDpVt4xBZh+EnGAwUXQJrtis+7d71uMGKaK9Lr8puSfo9ehAOVdlZ5xV1DWz2A6ejFwbaHOunyJp785lAgq3horev3F7u5mCCHHzlqHV+aJQuDaSXSijpLzTZnEiv5DY/ByWdiSkTBtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715007567; c=relaxed/simple;
	bh=KxKHwPONpxlyTxuBVbYali+qfHSPEz1mxTHsd0OxT7M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Sc7BjQByWry9i7FK4qWogZQyznXLzZqYIZblIFaBVNBWXnUPE384NgsKxDhutf1h8OgIaRbDST6w/elpHvD067gaLAsap0wkt1MUvfXbvXV+CaqLSpBzK8H+dvbH2c1nNYBLPR4j6diTVnYjXBaPXR4fQA+e07KAngo6AXJKClY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iaXUcOHL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 114FDC4AF66;
	Mon,  6 May 2024 14:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715007567;
	bh=KxKHwPONpxlyTxuBVbYali+qfHSPEz1mxTHsd0OxT7M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=iaXUcOHLV1fTJe84wqtLt9CrAkELBH0RLRYyIGW30ywNQ/jarUBRVFV+Cx8KMPcgz
	 yh3ja3ZeTvtsu+pJqsllyFVB1BPnU3xknpByptxATCcLFtS1ebxyOm+v/UBJUXhzrw
	 M6N3WkmRoaqHO1zTyE287W6chPELsF5yY35iELiVlGAzYsmBUVHxd0uunZer+iq1PF
	 rNyeDXdYYOnRdxDDN6NtVba11jaX4DJTUcbtNTVz5QGu7ZtA93eX8nhm7lZISlbzUI
	 9RSqByix3cQj4x2dQqDtAZ8iaGVxtJ+XUj6B0qe4+RB1Vx5t9PGp1eBUmHBsPNQ3Sy
	 mqXXWbDvzhIQA==
From: Mark Brown <broonie@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>, 
 Serge Semin <fancer.lancer@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240424150657.9678-1-fancer.lancer@gmail.com>
References: <20240424150657.9678-1-fancer.lancer@gmail.com>
Subject: Re: [PATCH RESEND v4 0/4] spi: dw: Auto-detect number of native CS
Message-Id: <171500756558.1968436.6929247618384278647.b4-ty@kernel.org>
Date: Mon, 06 May 2024 23:59:25 +0900
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Wed, 24 Apr 2024 18:06:41 +0300, Serge Semin wrote:
> The main goal of the short series is to provide a procedure implementing
> the auto-detection of the number of native Chip-Select signals supported
> by the controller. The suggested algorithm is straightforward. It relies
> on the fact that the SER register writable flags reflects the actual
> number of available native chip-select signals. So the DW APB/AHB SSI
> driver now tests the SER register for having the writable bits,
> calculates the number of CS signals based on the number of set flags and
> then initializes the num_cs private data field based on that, which then
> will be passed to the SPI-core subsystem indicating the number of
> supported hardware chip-selects. The implemented procedure will be useful
> for the DW SSI device nodes not having the explicitly set "num-cs"
> property. In case if the property is specified it will be utilized instead
> of the auto-detection procedure.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/4] spi: dw: Convert to using BITS_TO_BYTES() macro
      commit: 11ae2e63b2a517742d233c4e5b67b898c797973e
[2/4] spi: dw: Add a number of native CS auto-detection
      commit: e164be7e1e9373bd10e6b79924b0a6374752775e
[3/4] spi: dw: Convert dw_spi::num_cs to u32
      commit: 33c85972d1e4952a8c93ec260be2e6ff4470e619
[4/4] spi: dw: Drop default number of CS setting
      commit: 98d75b9ef282f6b9bfa1ea06d8a0824e0edaea97

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


