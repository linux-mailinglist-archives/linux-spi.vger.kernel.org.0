Return-Path: <linux-spi+bounces-10445-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BFDCBC1062
	for <lists+linux-spi@lfdr.de>; Tue, 07 Oct 2025 12:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CEB83ADE78
	for <lists+linux-spi@lfdr.de>; Tue,  7 Oct 2025 10:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665D8221FA0;
	Tue,  7 Oct 2025 10:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JAn+B7qf"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417B2E55A
	for <linux-spi@vger.kernel.org>; Tue,  7 Oct 2025 10:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759833270; cv=none; b=XRxx+C9hkfASKAIqe+EVwqzDjt9tU3bIC+RInAiqtH4umO7uOQPtuaCcjBhX3n4P34S9iZgwruh5nWQY+oMQxCAPvZKnVzsMDmCBdPRewmBg3FtPEVHKClqfFRSPpU2RN60HEXXVVQUqqum74XBMkWvkn62219VehYXkeCIeERQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759833270; c=relaxed/simple;
	bh=7Rt85khc37Bm9T7CKb1rV4PLnxTB6FWq7ZxOkALG9ZI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kzdha9NOX3+X9tQzl0EFEV9KmKm3cW6BKRssKVdTyEWpbxQzqHSE9bkJEjUt266IzJ8rpJ6fYieCWs4pPP82cwyeKK5kCq4Z9OU6i/6tjzbNgr0rs2iPye71yud9vwNo5zvWkpFD4hkrpO8l6Z9zasAldGerVFkGB39B+wzrlUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JAn+B7qf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4387CC4CEF1;
	Tue,  7 Oct 2025 10:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759833269;
	bh=7Rt85khc37Bm9T7CKb1rV4PLnxTB6FWq7ZxOkALG9ZI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=JAn+B7qfHQdWfiiC8w8s2OQL9CJpYx34jLg9echSC8zElKWHI6dKXn25NrrMvHjrh
	 f28dAFKVgopFpgvWbuREH1oYDfyeiLDZetSJkxotiVK/xZDY555dih3DMbzWhC18fl
	 w8LywxryXYs7JHl85+Uvi99j0fIPIb+d20IoAIfQdv6muUpyogbJ/+Z22yH9MNYiLP
	 iR0LPagKSxSv3/kRGp/03XdRoLZ+emoteTMEjb/emr6OOQHFyA/h6gfY5sh6Y0LFu2
	 sqWqSPWcyqFjxfnrzm6WJKEGEQu3oEIOE5tvFGvb2TtxOSAAcYT7yLvw8n0DJFhHPq
	 0089ZXkmuzZEg==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Heiko Stuebner <heiko@sntech.de>, Jon Lin <jon.lin@rock-chips.com>
In-Reply-To: <20251003114239.431114-1-m.szyprowski@samsung.com>
References: <20251003114239.431114-1-m.szyprowski@samsung.com>
Subject: Re: [PATCH] spi: rockchip-sfc: Fix DMA-API usage
Message-Id: <175983326786.12762.6647270709519748185.b4-ty@kernel.org>
Date: Tue, 07 Oct 2025 11:34:27 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-56183

On Fri, 03 Oct 2025 13:42:39 +0200, Marek Szyprowski wrote:
> Use DMA-API dma_map_single() call for getting the DMA address of the
> transfer buffer instead of hacking with virt_to_phys().
> 
> This fixes the following DMA-API debug warning:
> ------------[ cut here ]------------
> DMA-API: rockchip-sfc fe300000.spi: device driver tries to sync DMA memory it has not allocated [device address=0x000000000cf70000] [size=288 bytes]
> WARNING: kernel/dma/debug.c:1106 at check_sync+0x1d8/0x690, CPU#2: systemd-udevd/151
> Modules linked in: ...
> Hardware name: Hardkernel ODROID-M1 (DT)
> pstate: 604000c9 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : check_sync+0x1d8/0x690
> lr : check_sync+0x1d8/0x690
> ..
> Call trace:
>  check_sync+0x1d8/0x690 (P)
>  debug_dma_sync_single_for_cpu+0x84/0x8c
>  __dma_sync_single_for_cpu+0x88/0x234
>  rockchip_sfc_exec_mem_op+0x4a0/0x798 [spi_rockchip_sfc]
>  spi_mem_exec_op+0x408/0x498
>  spi_nor_read_data+0x170/0x184
>  spi_nor_read_sfdp+0x74/0xe4
>  spi_nor_parse_sfdp+0x120/0x11f0
>  spi_nor_sfdp_init_params_deprecated+0x3c/0x8c
>  spi_nor_scan+0x690/0xf88
>  spi_nor_probe+0xe4/0x304
>  spi_mem_probe+0x6c/0xa8
>  spi_probe+0x94/0xd4
>  really_probe+0xbc/0x298
>  ...
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: rockchip-sfc: Fix DMA-API usage
      commit: ee795e82e10197c070efd380dc9615c73dffad6c

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


