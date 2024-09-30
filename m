Return-Path: <linux-spi+bounces-5061-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2ABE98AF50
	for <lists+linux-spi@lfdr.de>; Mon, 30 Sep 2024 23:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 531171F23B00
	for <lists+linux-spi@lfdr.de>; Mon, 30 Sep 2024 21:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0623E18785C;
	Mon, 30 Sep 2024 21:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NHkrBs3E"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F4517BED0
	for <linux-spi@vger.kernel.org>; Mon, 30 Sep 2024 21:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727732524; cv=none; b=NN7kDAiZw7q0m7qwvPSLtT70iIw902iQF0Rp9esXm51ADwQZ8hpPujO8twpDjZEb3Fh0zT4qYik7hKe5RMp1x6Oa9upWSSOQPi/qFNwiMrUaFJZWKnmSeqZis5KrJywYkMtvYE4/aUb8Rt5Ro/UoS6yiq8jEopnZ5pZfCqGURLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727732524; c=relaxed/simple;
	bh=g8WeA5YSkgcKVpzrtlFUBL2RriqdSpAIXAxaNMpK9I8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VChd05Mbmt/vkLSnkBVs5e7DOS4pNuLE7unF6WeucUC8nayalYncaRDkojE+UqvgiH8rPvt2uy6/gdp6b8z5tvjX5/rof6F5Fm2LN5JgyYvoCpCK32XWKLQkp51KZefa519wA30x6A0UxyseCGkbffl3wmnRXFNNuKNws4YzX78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NHkrBs3E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28F52C4CED2;
	Mon, 30 Sep 2024 21:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727732524;
	bh=g8WeA5YSkgcKVpzrtlFUBL2RriqdSpAIXAxaNMpK9I8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=NHkrBs3Evyn8dtkmUCSORUdjm7O/GFzGWLhcegZ+F+bOvBDp7xKU6dg7Ad7Lg1ZgV
	 8a8dlWx/GiW0k2zeMnb/iC8S2IxfjrYyDL1EwsyfLmPY8gA+q+IG+cOYOGoXjBLUJq
	 frTaBaGt+wHHeNUMfGzZsMJmVAOlhfG18T3WEf/J7cpP0KGEj1Mm+NpXu/cx9vpZTO
	 I8VX7rT4OmkbuxGOrmxtQ4gOWFvqiKhVCVcmXPDO9lE7qG+GZapRCwxt3NNGDAG6FI
	 ROsAYNXZTkimwQ0n+vCoQ83pvbnzHbHr3Qoq2hGWctT0R3uKLobLFXUhiw3bJfRi+Z
	 0EjsUcpNGkiog==
From: Mark Brown <broonie@kernel.org>
To: Ray Liu <ray.liu@airoha.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Andy Shevchenko <andy@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>, 
 linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org, 
 upstream@airoha.com
In-Reply-To: <20240922-airoha-spi-fixes-v3-1-f958802b3d68@kernel.org>
References: <20240922-airoha-spi-fixes-v3-1-f958802b3d68@kernel.org>
Subject: Re: [PATCH v3] spi: airoha: do not keep {tx,rx} dma buffer always
 mapped
Message-Id: <172773252295.2210210.5351988965477676618.b4-ty@kernel.org>
Date: Mon, 30 Sep 2024 22:42:02 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Sun, 22 Sep 2024 19:38:30 +0200, Lorenzo Bianconi wrote:
> DMA map txrx_buf on demand in airoha_snand_dirmap_read and
> airoha_snand_dirmap_write routines and do not keep it always mapped.
> This patch is not fixing any bug or introducing any functional change
> to the driver, it just simplifies the code and improve code readability
> without introducing any performance degradation according to the results
> obtained from the mtd_speedtest kernel module test.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: airoha: do not keep {tx,rx} dma buffer always mapped
      commit: 7a4b3ebf1d60349587fee21872536e7bd6a4cf39

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


