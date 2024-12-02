Return-Path: <linux-spi+bounces-5883-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0C39E0A30
	for <lists+linux-spi@lfdr.de>; Mon,  2 Dec 2024 18:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A7AF1623F1
	for <lists+linux-spi@lfdr.de>; Mon,  2 Dec 2024 17:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4769B1DE2CC;
	Mon,  2 Dec 2024 17:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b19kVneh"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C91A1DE2A6;
	Mon,  2 Dec 2024 17:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733161002; cv=none; b=KRi9LBCy8t7qX075KD8McZNjKvfCRZZjmsa9wL3dTwHs8LWh6Jpp+WMzRkUn0low6GuXZfVC8EZ8J+PS36xqnFpGplUXl1/yuVoBd5DjFp5xsQaLlhHWWZBcBIql10cbX4m0GdaS/8/xse/OcckhwtKkvm2sTMLFbCIcMrMrGGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733161002; c=relaxed/simple;
	bh=omTd30O7il1d2T+mDSNJwSln23SjccFOcva3lTl0BNM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=D6sOXGBCS5RnMaW6Ej9Wj3krG/fm82c7W+FAyMgqh+5qViHZ2IUx96wL7TxR7wV5k4vQzSAB09pmZsLJLaNG0AUDHGkzS/r+c1ZPFDsuXjErSVpTJg1cHpdPF5IvZY49Ooc7O7saXshYcoJQxHyDomTP/JLkH7SxynTfvpuL/Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b19kVneh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 304DFC4CED1;
	Mon,  2 Dec 2024 17:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733161001;
	bh=omTd30O7il1d2T+mDSNJwSln23SjccFOcva3lTl0BNM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=b19kVnehK87/IHsaAlnext5C0DLQu+oMKO/RGC3yE1KO7I4S7YiSqBP4ixcBu7T7V
	 pslBw3IDuEShQYa+q7Hc59fYzDmjm+kdKmCv/vmAOy3KR2tXLJqetTbpGuKY14PMte
	 FWckDfSmTUhObsvxRgQc90zg/WAG5ffooD3PuW32t/w4W89r3inzfCTvJ0EbUI5s5b
	 u1LRi5G42x1MN8Dss5s8NnkAbor0+O4GYcbwuYBk16D58T5S9JenhHmDti4kOrb3jb
	 FZCS0sRSEvo2GUs2cMjOMK9Z45Tx7l50x6swtErPlK6Kc1uZpKqDPYiwCRPWXMhChQ
	 B/Mj/LxzFO0Ew==
From: Mark Brown <broonie@kernel.org>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 vaishnav.a@ti.com, Srikanth Boyapally <srikanth.boyapally@amd.com>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, git@amd.com, srinivas.goud@amd.com, 
 radhey.shyam.pandey@amd.com, srikanthboyapally2016@gmail.com, 
 sai.krishna.potthuri@amd.com
In-Reply-To: <20241120120951.56327-1-srikanth.boyapally@amd.com>
References: <20241120120951.56327-1-srikanth.boyapally@amd.com>
Subject: Re: [PATCH 0/3] spi: cadence-quadspi: Add support for device reset
Message-Id: <173316099889.156452.1327566549326122960.b4-ty@kernel.org>
Date: Mon, 02 Dec 2024 17:36:38 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Wed, 20 Nov 2024 17:39:48 +0530, Srikanth Boyapally wrote:
> Add support for device reset via OSPI on Versal Gen 2 platform.
> 
> Srikanth Boyapally (3):
>   dt-bindings: qspi: cdns,qspi-nor: Add compatible string to support
>     OSPI controller on Versal Gen2 platform
>   spi: cadence-quadspi: Use quirks to set dma_set_mask instead of
>     compatible string for 64-bit DMA support
>   spi: cadence-quadspi: Support for device reset via OSPI controller
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] dt-bindings: qspi: cdns,qspi-nor: Add compatible string to support OSPI controller on Versal Gen2 platform
      commit: 707080d4fea8f6b8319ceead569f34c2be5bf1d5
[2/3] spi: cadence-quadspi: Use quirks to set dma_set_mask instead of compatible string for 64-bit DMA support
      commit: 2e4d9f5111a3b3c24550e34710efa690c03b3ea1
[3/3] spi: cadence-quadspi: Support for device reset via OSPI controller
      commit: 27cf57f65bea55d985f0ad0dc1737ce1d01f05dc

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


