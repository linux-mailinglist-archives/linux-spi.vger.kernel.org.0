Return-Path: <linux-spi+bounces-9304-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A5AB1C723
	for <lists+linux-spi@lfdr.de>; Wed,  6 Aug 2025 15:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5152018C3CB5
	for <lists+linux-spi@lfdr.de>; Wed,  6 Aug 2025 13:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC5D28C84B;
	Wed,  6 Aug 2025 13:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NWAr1d+d"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D3328C5DE
	for <linux-spi@vger.kernel.org>; Wed,  6 Aug 2025 13:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754488519; cv=none; b=jRbvSR6JOEgsl8fj3rPLZCCJrw3LqDZ79bbsr5fOAdr+KYGtbWhjl8tgUNAUcNo6LbAxrFTXh0Apc6E8m6N+7yQqQxvxXBRpCFH1xJYxKaLjR3Jxa60zpBlu9B4DzuSeesRliJTv9bLVoDHG674wRsDsnQv9LSGoceo6v8VZEig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754488519; c=relaxed/simple;
	bh=u59Nnz93furPfN7gRvaIcHOdCMdFr8CsKrbaj5EJZxI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=E3EyBkOj9PopksIbeT8FsXvhI6NC9Y20vkJMd6OOi/54A/OeOMoTZ94Wy6HyWDsaVh/ssG7ZoG8Y1DH1kTXtkHK4nhKaByDnAeOpaCJmDDjXuYmFmC8rjjFdpkJPHHs06GBTqnYRcqQF29NxE3nLZ2A/MwL7l2lmNUJOxnnRKGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NWAr1d+d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD74EC4CEE7;
	Wed,  6 Aug 2025 13:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754488516;
	bh=u59Nnz93furPfN7gRvaIcHOdCMdFr8CsKrbaj5EJZxI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=NWAr1d+dbqrT4Ngd3Yem2UfSh9/5jnEOA1/zgITN8mLd84MnJJwUFIwfBj/WrAZsW
	 sTDPLKcwpaiAjA08tHaYM9pwGZ3e8dmh+TieAQwbltGAchKwieFxknv5dOpfXjb4nw
	 sIfxS9eKTKbuZLBmwzFlsso6PTS+D+HXnmzRlkvO3X0jqC75Xeo0U3T+BlVb+UjYZW
	 UpCKQ8Vzn9rqEhCdj4IjjmJoo1QxBx4TWX5WtBNdrzdeZaa13XfUAA8dChQHNLtK3V
	 aYRRTbx18wI+GV6vLcXzhka8n0nZiKsRJ6CjZ1nRCotrdMxsdwCH5VUYGURMxh4sw4
	 Fr7AYEYeaCRjA==
From: Mark Brown <broonie@kernel.org>
To: Tianyu Xu <xtydtc@gmail.com>
Cc: linux-spi@vger.kernel.org, miquel.raynal@bootlin.com, 
 Tianyu Xu <tianyxu@cisco.com>
In-Reply-To: <20250805015403.43928-1-tianyxu@cisco.com>
References: <20250805015403.43928-1-tianyxu@cisco.com>
Subject: Re: [PATCH] spi: spi-mem: add spi_mem_adjust_op_freq() in
 spi_mem_supports_op()
Message-Id: <175448851563.67808.4818626808179553562.b4-ty@kernel.org>
Date: Wed, 06 Aug 2025 14:55:15 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Tue, 05 Aug 2025 09:54:03 +0800, Tianyu Xu wrote:
> The function spi_mem_adjust_op_freq() within spi_mem_exec_op() adjusts
> the op->max_freq, which will informs the SPI controller of the maximum
> frequency for each operation. This adjustment is based on combined
> information from the SPI device and the board's wiring conditions.
> Similarly, spi_mem_supports_op() will check the capabilities of the SPI
> controller. It also requires the combined information before it can
> accurately determine whether the SPI controller supports a given operation.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-mem: add spi_mem_adjust_op_freq() in spi_mem_supports_op()
      commit: a4f8e70d75dd11ab1a01894893e0b03f1d0b61fd

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


