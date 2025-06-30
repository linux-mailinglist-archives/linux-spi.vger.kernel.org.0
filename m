Return-Path: <linux-spi+bounces-8893-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA955AEDB68
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jun 2025 13:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0976189B6C3
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jun 2025 11:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F30266560;
	Mon, 30 Jun 2025 11:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XI98+6GF"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD2826560B;
	Mon, 30 Jun 2025 11:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751283655; cv=none; b=doYPVqfO5YdqEKxs4lPmXkNGB8iNLQCGz25CY76kI61531hDmmwXZl3TxL9FaLIhfwUW28WwVtum52XM4tr48sShc1tQGJ8B5+kGUa9T5nxkNpt1yXhbjl72gDAMt1VD7kSsFfhw/MmU9Ae3w5DMPvYtcyVtT70yoHG3cPdpYKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751283655; c=relaxed/simple;
	bh=v32/IgCkzDDCvndoXu75HLDruwhsWVIle5ausaYvQS4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Ggm7S4QXTwaoeYT4neYJJmwnC+ryY4qu9ef3/Sq7TljlHEZPEezK8T6oWyUtHhpZ8kXwqhtKWD6QYA+j9sGL+DUVhs5621+pttiWbbNDy4WjMTZu2z6kf7M5ZZBuwUkocyMLdOsz4x5fhFAtJAAH61zLA9ubRnwTjYiOYy5l+3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XI98+6GF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA4B7C4CEE3;
	Mon, 30 Jun 2025 11:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751283654;
	bh=v32/IgCkzDDCvndoXu75HLDruwhsWVIle5ausaYvQS4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=XI98+6GFt3X6VT+WIKJVOk3Ng4aJf5v+wtrKfsfSHJc4aOEOK9KJZgZEy5gANnUtW
	 8ZmilQuTYhtUzC4vItGr+wvRR8KbMzbEGdryxOehSV5ujvfFG3G8/d9/y8acFNsFmk
	 4q9B2mKWPaTWzElt1SnlPcGieG8ze1KQD1yPs1Dby7ctuvTJ3iqWUSIzMdrC9Ck++X
	 +GoVF25zi2BoV7MdNAOW16s4zZej/3VTynHRPdYy4kTBHkvSuA9cUU5QZGeAcHoo4B
	 A1gHDjZ2C6mjzqMc3mzUeFGko0FSvLHKgf12ek3lNLjezjSw6SZxHHElRuJIOeX4e8
	 +XplipFE2/aHg==
From: Mark Brown <broonie@kernel.org>
To: Vladimir Oltean <olteanv@gmail.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, Arnd Bergmann <arnd@arndb.de>, 
 Larisa Grigore <larisa.grigore@nxp.com>, Frank Li <Frank.li@nxp.com>, 
 Christoph Hellwig <hch@lst.de>, James Clark <james.clark@linaro.org>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250627-james-nxp-spi-dma-v4-0-178dba20c120@linaro.org>
References: <20250627-james-nxp-spi-dma-v4-0-178dba20c120@linaro.org>
Subject: Re: (subset) [PATCH v4 0/6] spi: spi-fsl-dspi: Target mode
 improvements
Message-Id: <175128365269.28911.6934091956026312551.b4-ty@kernel.org>
Date: Mon, 30 Jun 2025 12:40:52 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Fri, 27 Jun 2025 11:21:36 +0100, James Clark wrote:
> Improve usability of target mode by reporting FIFO errors and increasing
> the buffer size when DMA is used. While we're touching DMA stuff also
> switch to non-coherent memory, although this is unrelated to target
> mode.
> 
> The first commit is marked as a fix because it can fix intermittent
> issues with existing transfers, rather than the later fixes which
> improve larger than FIFO target mode transfers which would have never
> worked.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/6] spi: spi-fsl-dspi: Clear completion counter before initiating transfer
      commit: fa60c094c19b97e103d653f528f8d9c178b6a5f5

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


