Return-Path: <linux-spi+bounces-2785-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC3E8BFCE5
	for <lists+linux-spi@lfdr.de>; Wed,  8 May 2024 14:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B26C2824FF
	for <lists+linux-spi@lfdr.de>; Wed,  8 May 2024 12:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D46C839E4;
	Wed,  8 May 2024 12:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NC5Xd5Cf"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D2480C13;
	Wed,  8 May 2024 12:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715170097; cv=none; b=uzb1GsCs/Lum9jrzbcPyjXZyKzPKC26bLRmZBct6zo4EAAKyMAiyCUpMWDMCMGFpEma0Y+h2UZ9jckv2kQ6LQ3eCamPb1Ntj8mGyyNKbyfPb13DlmC+rJQ45axnkCsq2S1Le7/Uhwukibpg0NieL59yD+lvIPLqxtY3ql+jHQaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715170097; c=relaxed/simple;
	bh=F/Fq/N/68SnaZ8R4mJ1tyObNOmUjEpjh7AcSnPN0obA=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ASn+f2kL0ec32+yhTh8tJUbVU2flk8qkdyBIYOHQk3TTcWdfTjlwHJUm5MN264D1NU4lAFDJXomZ292J0Tpdr/KfZSw5oGmtuPm2DyQ3T9ri8UW6zPdgT2tc2P4M5BfWo1fhX7zW1ngU9ji+Ks+UPsigAiJYNlkFNwSkCFs7XWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NC5Xd5Cf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D6FFC113CC;
	Wed,  8 May 2024 12:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715170096;
	bh=F/Fq/N/68SnaZ8R4mJ1tyObNOmUjEpjh7AcSnPN0obA=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=NC5Xd5CfeOO+dJBMxiHw7QzfEb4/B3lVkd+5YHLC810wGeSOeteHhTWW9Z72wy2lH
	 mgTQYdiLYHiN0yt3+EH1ZZNHaI0iNvPd/N+HaoOnnzvQm1TSGu0XdNkLF+ZnRMBdzt
	 4uYN4UT3WRuqZUwWCBHv+qtfd9RRJmhK+7odClxYdXrpPJ0frNTkXcUQv7guUTKRg3
	 q6zYmCmxVELmRSz3ypLbwrnf2a5G76e5IESLwGXkU0qjJTinQseNLUX8LT6nGys1im
	 ifKCAQWrLzuUOwei2opUvIgjQFooHCtnzy1yL4MuWc/LvF1scm1cguS1zHwXFpX6Fj
	 candrmx61KD8A==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240507201028.564630-1-andriy.shevchenko@linux.intel.com>
References: <20240507201028.564630-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] spi: Remove unneded check for orig_nents
Message-Id: <171517009614.2014074.15995946356965034064.b4-ty@kernel.org>
Date: Wed, 08 May 2024 21:08:16 +0900
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Tue, 07 May 2024 23:10:27 +0300, Andy Shevchenko wrote:
> Both dma_unmap_sgtable() and sg_free_table() in spi_unmap_buf_attrs()
> have checks for orig_nents against 0. No need to duplicate this.
> All the same applies to other DMA mapping API calls.
> 
> Also note, there is no other user in the kernel that does this kind of
> checks.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: Remove unneded check for orig_nents
      commit: 8cc3bad9d9d6a4735a8c8998c6daa1ef31cbf708

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


