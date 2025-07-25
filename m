Return-Path: <linux-spi+bounces-9187-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66747B12220
	for <lists+linux-spi@lfdr.de>; Fri, 25 Jul 2025 18:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BA9A1CC7F46
	for <lists+linux-spi@lfdr.de>; Fri, 25 Jul 2025 16:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A872023AB90;
	Fri, 25 Jul 2025 16:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dFbqS958"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816A53BBF2;
	Fri, 25 Jul 2025 16:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753461406; cv=none; b=Nre5FNnHiEnriMXljSflooJJHdC3oYRK5KcacsVqmRsgKPF6epavF9U7dyNG4zTOVmWCbIfRMbbFhe6X5KHUDFbTIZZLL9vWLew2qHOnBZPOUU7imU1FuXMjz7/36YlIwSVFSPDvFSRIVAGld2vWmfDyAr2tiHOJSiSxL6j5SC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753461406; c=relaxed/simple;
	bh=0MJcY0iacLOwQpRsrB4iQLHcAHs0vWSaJn7nayTfEbo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=l9zX3TvYPuJc8wDr/cNRH18Y5j7g8pL+V9x1QkNtNSDw/2DGO2lCTxs1G9TuxXmjeyvhfcpQB82pF4Wc+wt6LOQoWmhgbsYccfYYdsHRZV+g0N0EpHakTD50DTySPp4U+vopLkaLAbkLNMSF/KaxxyzOWHPfvx1O5tpWaK/fYok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dFbqS958; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD685C4CEE7;
	Fri, 25 Jul 2025 16:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753461406;
	bh=0MJcY0iacLOwQpRsrB4iQLHcAHs0vWSaJn7nayTfEbo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=dFbqS958Ogbka7EyFAzYtGDyZQldNj6KLym1PLkGvpmPA2HBMo4Sha8k3pd7X2ifG
	 qtgqKUlwlk4HHTM5QvezPe+AOwVjlxhSY2UnEEBtrJiA/TzXAfmcxIY9qDETjt+kKE
	 QysgyDlP+TK+NvYKL39ANs0Rnqole4/fdC/wdEk4NXDe5mxSa2HHfIMdDzIzvqV2p+
	 hquO2KvsO0NgLup8xFaizmTjmbU7QpCduTTcicF6g+xbiGCcnp1vU14TQ7lfOMrQ6I
	 +vmSnRejdgV75o1djmYfQekCkhSb+b7sZk/K/fEWhURZh1bFzeRFLsrIKqZmtUx3O7
	 ERJV4HKe2dqzg==
From: Mark Brown <broonie@kernel.org>
To: Jakub Czapiga <czapiga@google.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, 
 Konrad Adamczyk <konrada@google.com>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250725122542.2633334-1-czapiga@google.com>
References: <20250725122542.2633334-1-czapiga@google.com>
Subject: Re: [PATCH v3] spi: intel: Allow writeable MTD partition with
 module param
Message-Id: <175346140458.1149754.12210062974828341845.b4-ty@kernel.org>
Date: Fri, 25 Jul 2025 17:36:44 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a9b2a

On Fri, 25 Jul 2025 12:25:42 +0000, Jakub Czapiga wrote:
> The MTD device is blocked from writing to the SPI-NOR chip if any region
> of it is write-protected, even if "writeable=1" module parameter is set.
> 
> Add ability to bypass this behaviour by introducing new module parameter
> "ignore_protestion_status" which allows to rely on the write protection
> mechanism of SPI-NOR chip itself, which most modern chips (since
> the 1990'+) have already implemented.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: intel: Allow writeable MTD partition with module param
      commit: 87aa3c8d8c4aa2e2567fe04126d14eb9fde815e5

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


