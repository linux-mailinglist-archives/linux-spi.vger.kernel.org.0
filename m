Return-Path: <linux-spi+bounces-9211-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D95B14EEE
	for <lists+linux-spi@lfdr.de>; Tue, 29 Jul 2025 15:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E66BF4E7117
	for <lists+linux-spi@lfdr.de>; Tue, 29 Jul 2025 13:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1EA433D9;
	Tue, 29 Jul 2025 13:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="INg87RHD"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDCA1B85F8;
	Tue, 29 Jul 2025 13:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753797520; cv=none; b=uFKLNEuAkarZ108EBdZgnayf0t82V2aLZoyiU5Y9bi33edCa8sy2o0VyNJ2TQW0QFD2r2SpGHdmYuqzfsJwSnhmAiRDWAg5ezvfUf/NRSQXgnQsouReYgDjBo4SjNUQz8ukEhxeZs9DrwR/QZ9f+JKAwhhakY4YxojLmexXNEw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753797520; c=relaxed/simple;
	bh=Vmk0X4v9TuzKQs2y29LDBHbFF70S0TrKZzabTsmH0/U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ih8hL10EHUgI9zkCxhmA69yXLDfFzeVNc3fjIDH9fduYzGivTC7gyv2Ddm7FRESyeCL1LIrHcuJJFcjsA5sYcdyQ2r3s8jEi9dU4o2OSKlXlDWtQUdRDzGUVqiKK1EfbXTaNEyV/1wOIvIrvW4Qfmu2msIbZZ3DcTz5X1fi2//4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=INg87RHD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F24EC4CEF5;
	Tue, 29 Jul 2025 13:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753797520;
	bh=Vmk0X4v9TuzKQs2y29LDBHbFF70S0TrKZzabTsmH0/U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=INg87RHDonV2H5zzjYfmn2iHil0d8rBFqQ0y6cX0L2RfyiCrort0+vmFKqUr4hzp7
	 vA3hX6RLt2QP4q+ZhS/QjfOstWQfSlds6hJzJsfGSf+E54cQ9bad3FLtjCTUT/Ej5h
	 UbmjMgV9sTkQ0i4jtsoNb3mFkJHzc+gyWnge+VEazRe3heZMZP6/t3XYgpksIPMBOv
	 FOjM2T9dSP+zpmbcNIqGYwuQYOv4NGeVFSXtCs//kvpFETKTFdSqPTTVTRkG2zOAh6
	 AbXvst04uUg36qPN4Lh76ozGjsA6CU+k+yK+BGJl5v+S0rVc40Ci9klB67H0fN5oiS
	 TtHc/wPTcXuKA==
From: Mark Brown <broonie@kernel.org>
To: Jakub Czapiga <czapiga@google.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, 
 Konrad Adamczyk <konrada@google.com>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250717152851.3709744-1-czapiga@google.com>
References: <20250717152851.3709744-1-czapiga@google.com>
Subject: Re: [PATCH v2] spi: intel: Allow writeable MTD partition with
 module param
Message-Id: <175379751917.39520.16059284404442886769.b4-ty@kernel.org>
Date: Tue, 29 Jul 2025 14:58:39 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Thu, 17 Jul 2025 15:28:51 +0000, Jakub Czapiga wrote:
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


