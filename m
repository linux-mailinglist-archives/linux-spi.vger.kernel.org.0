Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D98592616FD
	for <lists+linux-spi@lfdr.de>; Tue,  8 Sep 2020 19:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729296AbgIHRXa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 8 Sep 2020 13:23:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:57046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731805AbgIHRVr (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 8 Sep 2020 13:21:47 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8E3420936;
        Tue,  8 Sep 2020 17:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599585706;
        bh=fMphHg3tFmgcGef0toxwTPwTGQB1KyRmuWuLqVwJWr4=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=dWZoWs9xsmWYDORBN/QMZA3E7NtSueytNv9FBBhz6C54vuJIvN4ZEWWv/iCKB2twk
         khaghQsRzhVa9my4DPFBPTpEkRKTCU1QYctzalzdpUXwPg6oBzFKEkU49xkKYteXhb
         1/oukxZa1by3Y0hhqPRjF+M+ptScDgTpvfklVdc4=
Date:   Tue, 08 Sep 2020 18:21:02 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Pratyush Yadav <p.yadav@ti.com>,
        Jan Kiszka <jan.kiszka@siemens.com>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20200831130720.4524-1-vigneshr@ti.com>
References: <20200831130720.4524-1-vigneshr@ti.com>
Subject: Re: [PATCH v2] spi: spi-cadence-quadspi: Fix mapping of buffers for DMA reads
Message-Id: <159958565716.16771.5696508114648193658.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 31 Aug 2020 18:37:20 +0530, Vignesh Raghavendra wrote:
> Buffers need to mapped to DMA channel's device pointer instead of SPI
> controller's device pointer as its system DMA that actually does data
> transfer.
> Data inconsistencies have been reported when reading from flash
> without this fix.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-cadence-quadspi: Fix mapping of buffers for DMA reads
      commit: 83048015ff7710b46e7c489458a93c6fe348229d

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
