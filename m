Return-Path: <linux-spi+bounces-4057-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D7893F9B6
	for <lists+linux-spi@lfdr.de>; Mon, 29 Jul 2024 17:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A73F228331A
	for <lists+linux-spi@lfdr.de>; Mon, 29 Jul 2024 15:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9793115A4B5;
	Mon, 29 Jul 2024 15:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dZ0MMTIm"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A3E16B725;
	Mon, 29 Jul 2024 15:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722267604; cv=none; b=NpHDPDCHA5VEzl1I9O5VZShy+4Bnvnir78WaDrxDc8gGMmuCCXNfKrveECeRIPC4o2ImQiEwjWzhoxYOQdl14fbKz00Hc3RFE0rIptPOFDj0BUmiXixVSRrmrq67kAxnfQsEvFCwpicD7WyqG/O24zuNj458v7qSshd+0dmlnr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722267604; c=relaxed/simple;
	bh=wKdj3CdUMZhq1FC2Rcs2NuHX4NE/37Pw0kuRGmZ5Acw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=l+3tuT+doplAr0sVYvwHTOflyRyD7tVzShw2u12uU7LptNIzbxLcrWqTxQqGStgfM+MPCgUSUbcyVlm68fid2M0FU1tbsYkrkBo04We3IExI81YI0IzXybDMbnfCKBBYXuEftBg4wzIjQG0VJMpI1OFc9Nbu08/u23gaKMYgXhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dZ0MMTIm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D483BC32786;
	Mon, 29 Jul 2024 15:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722267604;
	bh=wKdj3CdUMZhq1FC2Rcs2NuHX4NE/37Pw0kuRGmZ5Acw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=dZ0MMTImS5D2SilE9nR8Y+aTcLd6ndmPnVpA24sgTvKpN1bXkrKTjAUrDspUlBNKS
	 3csDMyVO/0589HMRccSu/UVf6GEGUEMwkgualwy7MhsqCeBFy8jxD2IcgnRoFV4X/L
	 1bRDW5vMCUZd0fRyiGgvI1L22ER8dP6cskRRmVm6BHj6xPAiq8DvsOqBRKovyjD09g
	 Fl15lgRCiOh2DaKGyn4XOipbQWzKsj3IGOIHsq7O+SpsMbKkCwDgQzgDTyNljeCnhr
	 oBrFjrcxFh6+iZUVJugr+UWQ4nSFK6FkBXcr+51RfPhgvXcT5rlSIpoH9kxZen5ziu
	 x16pheBIZwrgQ==
From: Mark Brown <broonie@kernel.org>
To: neil.armstrong@linaro.org, khilman@baylibre.com, jbrunet@baylibre.com, 
 martin.blumenstingl@googlemail.com, yixun.lan@amlogic.com, 
 sunny.luo@amlogic.com, Chen Ni <nichen@iscas.ac.cn>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240716091151.1434450-1-nichen@iscas.ac.cn>
References: <20240716091151.1434450-1-nichen@iscas.ac.cn>
Subject: Re: [PATCH] spi: meson-spicc: convert comma to semicolon
Message-Id: <172226760159.71144.8527591939775545472.b4-ty@kernel.org>
Date: Mon, 29 Jul 2024 16:40:01 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Tue, 16 Jul 2024 17:11:51 +0800, Chen Ni wrote:
> Replace a comma between expression statements by a semicolon.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: meson-spicc: convert comma to semicolon
      commit: dc58d15ae7f247f642ea4751a276914eefa31865

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


