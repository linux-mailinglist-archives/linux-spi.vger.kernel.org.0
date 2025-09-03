Return-Path: <linux-spi+bounces-9885-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 412D0B42AA5
	for <lists+linux-spi@lfdr.de>; Wed,  3 Sep 2025 22:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0F49683B87
	for <lists+linux-spi@lfdr.de>; Wed,  3 Sep 2025 20:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23FB03680B2;
	Wed,  3 Sep 2025 20:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o3Fhw1mR"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F343629AC;
	Wed,  3 Sep 2025 20:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756930820; cv=none; b=R2ViVTS7cSnpiBKCbOGyTQC3aypeqoKRzsFkI3i/bTA9zhoR+/7+18+hjFKtzoh/4pqHxMCw8mJEajDg5J1Yp1GsTmfrsmrLah3A8Oy2Ea//DyHbmm/cmvDl4DkyepQAoXdKYVnF1r8BgyEk2HElOxArZi42chSyBb2NtPjUYXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756930820; c=relaxed/simple;
	bh=RPuGsCOsJ79vwxs7SXTFNlHZ0c9FPmykN4F3Ke/Hb9U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JV/eaSrJxbO+mIFbiZUF+ImOi8rri1cn2AtcNgHoQUbh4ZoVH4Sn2FuEQT4NpkEGDPKTfFfHTJ7gS26lnQmsZKa9dermp2ChGh4BbwRsZkY/+k9H/PjdgEzgvSFgR9SesdFuG7PVG+YntckIyhA6OOS/mHN8dLxgnyyAo/n7+dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o3Fhw1mR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D89D1C4CEF5;
	Wed,  3 Sep 2025 20:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756930819;
	bh=RPuGsCOsJ79vwxs7SXTFNlHZ0c9FPmykN4F3Ke/Hb9U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=o3Fhw1mRoS+aAmxbPer0M0Ynginrs6977JNnfsOqbxiuX67SViYLefE9rJrm1adXY
	 pKTX0CsBtunwHky38vp5oRKe4KvlfKBDIYMAuWxMnl5jvlo3w12+Pr3TVVdjFonZHA
	 HGWYYThSoNal5rVCvy1l22wrfGE/xMX9bDvIs0CyO2R/TLa7cbQz8TWawrPvD9TnaP
	 0VENw+d7b3WIxtiiGMGvJZp1MjSInrWVf6WUNgTZrmah+2pJWL1Z0k9iv3SpNqGmAV
	 HFbBbIVATSiajCBinhGwbcLGbRNkxx0RKqb8G2hzinoFENt91M2U+qEOrMfrjSNUWP
	 vM3ZngFD5bZWw==
From: Mark Brown <broonie@kernel.org>
To: Vladimir Oltean <olteanv@gmail.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, Arnd Bergmann <arnd@arndb.de>, 
 Larisa Grigore <larisa.grigore@nxp.com>, Frank Li <Frank.li@nxp.com>, 
 Christoph Hellwig <hch@lst.de>, James Clark <james.clark@linaro.org>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
In-Reply-To: <20250902-james-nxp-spi-dma-v6-0-f7aa2c5e56e2@linaro.org>
References: <20250902-james-nxp-spi-dma-v6-0-f7aa2c5e56e2@linaro.org>
Subject: Re: [PATCH v6 0/7] spi: spi-fsl-dspi: Target mode improvements
Message-Id: <175693081764.280569.13929402032627119802.b4-ty@kernel.org>
Date: Wed, 03 Sep 2025 21:20:17 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-dfb17

On Tue, 02 Sep 2025 13:44:52 +0100, James Clark wrote:
> Improve usability of target mode by reporting FIFO errors and increasing
> the buffer size when DMA is used. While we're touching DMA stuff also
> switch to non-coherent memory, although this is unrelated to target
> mode.
> 
> With the combination of the commit to increase the DMA buffer size and
> the commit to use non-coherent memory, the host mode performance figures
> are as follows on S32G3:
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/7] spi: fsl-dspi: Avoid using -EINPROGRESS error code
      commit: bfddd34d67a0402c0476b36fc1b1f373cd5b0054
[2/7] spi: fsl-dspi: Store status directly in cur_msg->status
      commit: 5484440aa0a98b76e7829cd06dda33cf62830d73
[3/7] spi: spi-fsl-dspi: Stub out DMA functions
      commit: 4850f158c06eeaf4997fc65c47544f2c82ad5a45
[4/7] spi: spi-fsl-dspi: Use non-coherent memory for DMA
      commit: 36db0b03d3745700aca4fced26f6eb624f6ea4bc
[5/7] spi: spi-fsl-dspi: Use whole page for DMA buffers
      commit: fbb618e11fa7976c5295facb28afbf1a08393f51
[6/7] spi: spi-fsl-dspi: Increase target mode DMA buffer size
      commit: 7d9baf1e530930e28b45805e3855a4a465a9e36e
[7/7] spi: spi-fsl-dspi: Report FIFO overflows as errors
      commit: 5cc49b5a36b32a2dba41441ea13b93fb5ea21cfd

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


