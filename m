Return-Path: <linux-spi+bounces-7439-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 323B1A7E64C
	for <lists+linux-spi@lfdr.de>; Mon,  7 Apr 2025 18:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B13BF189FD02
	for <lists+linux-spi@lfdr.de>; Mon,  7 Apr 2025 16:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B0720E006;
	Mon,  7 Apr 2025 16:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pkjS9qH4"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEC520CCFF;
	Mon,  7 Apr 2025 16:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744042550; cv=none; b=k1W4vhIzDlS+hk3CLcUSalBRI6RWSsK/mjv1r4uu7OCooswrQC155HMa8NnvIOhu+o79qKHIIearE/43LXw91Wf+VHXpVgrFD042Y0CvR3xJvYloYhz5+JGzfEg6gC/3KIhO56Ed6qf41n/H5xrjneDHgewkwN9ajxeOgCAfz24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744042550; c=relaxed/simple;
	bh=AOliGlUBKUzs+wxh5QtKoPWw1ILQLm9KsSgD9k74nnE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RLul3+XfnZ3SEPq7EsbvbykwXscNZDh3Vv4yEfjfQMkI8kESRPZ+J9HvyMl8AiaHSTOprWfU7ilh+3aRfuFnk03VMdktDP/K8mN0xv7xX7gm72ejbIiKNfXTTV1P+g/C7s3CP1eWJ0leZuW2m3PznBUGDBo/jKKbHe/6bd9cTZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pkjS9qH4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7390C4CEEA;
	Mon,  7 Apr 2025 16:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744042550;
	bh=AOliGlUBKUzs+wxh5QtKoPWw1ILQLm9KsSgD9k74nnE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=pkjS9qH4/KzEmPDmZA7tP8d/j8swZTT00bqM3aeohQZ7saHDn3J3s9cVH76EYaxYt
	 jhYHkuSMtBvPuFjdZNvFxPdZsGCynBMHilZYHKGgQR/tkSPHG6zsHVOFpBHouYVTKk
	 oTzAQi+IRwZSdBbKlJ7VjM7LSl1ngiaosJaquIDpeOawKnbx2tJjFZcVNvfPbu/h7K
	 FMQLrpf3Ejn+5wV7Uz3YTqY6Njgt2rl1Aq/2NZd3d58UeziZOrExTDiVJPvGlmZoVA
	 fCPpsoaDgUkwJKC+I4lFPv5K1ovaJ87HqrDbWmN7Lrf9kpCiyW8owpmBKjtAiElCqZ
	 zP+Cfuf8q8tvw==
From: Mark Brown <broonie@kernel.org>
To: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, 
 Raju Rangoju <Raju.Rangoju@amd.com>
Cc: Krishnamoorthi M <krishnamoorthi.m@amd.com>, 
 Akshata MukundShetty <akshata.mukundshetty@amd.com>
In-Reply-To: <20250402121514.2941334-1-Raju.Rangoju@amd.com>
References: <20250402121514.2941334-1-Raju.Rangoju@amd.com>
Subject: Re: [PATCH] spi: spi_amd: Add PCI-based driver for AMD HID2 SPI
 controller
Message-Id: <174404254940.780717.3439023568635859213.b4-ty@kernel.org>
Date: Mon, 07 Apr 2025 17:15:49 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Wed, 02 Apr 2025 17:45:14 +0530, Raju Rangoju wrote:
> Register a new driver(spi_amd_pci) for the HID2 SPI controller using the
> PCI ID of the LPC bridge device.
> 
> Add a new common probe function in spi_amd driver to encapsulate the
> code required for registering the controller driver. This function will be
> utilized by both the existing ACPI driver and the newly introduced
> PCI-based driver for the HID2 SPI controller. The MMIO register base
> address of the HID2 SPI controller can be obtained from the PCI LPC bridge
> registers.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi_amd: Add PCI-based driver for AMD HID2 SPI controller
      commit: b644c2776652671256edcd7a8e71161e212b59ac

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


