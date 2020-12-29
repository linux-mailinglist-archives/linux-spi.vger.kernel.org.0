Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 356D32E716A
	for <lists+linux-spi@lfdr.de>; Tue, 29 Dec 2020 15:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgL2OeT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 29 Dec 2020 09:34:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:57698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726388AbgL2OeT (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 29 Dec 2020 09:34:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A60D720825;
        Tue, 29 Dec 2020 14:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609252419;
        bh=OM4yK2FWmzsUMhH7NnbeAd1mVNiGwmDdgVhLgqh66JY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=rfsMvOxCxGJn4Rkpjxyzw430gzV2Szbm3dl+rI1zJ63q/f4HhXxkPzdpAGVhs/0aj
         84MSPj7+Ff7fozUzlFMtqyb/69nUx+RNpQOpk09ixsNmF7BH75QA6p79fyjHmiKE4G
         M/hi6imFtb5lFasZSPuQwTKB+CfwL1PlnnqQhSXe4vBBkhK+/nUGPgjLbKCQJjHwrJ
         wTPJqFO4f3uQ4Grh1oNLQ5eM47t170f3p/GpdSEkyHslbPkAUz4p4j84OmQxn2nMi9
         PtLUS0zkAAGU9f2IDiTTAwlFTibHGcnjX0ZDj3FCoqWbjfQkuFq2V7dqEU17AbbM1e
         9ha1SmgSrgMiQ==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, Xu Yilun <yilun.xu@intel.com>
Cc:     matthew.gerlach@linux.intel.com, linux-kernel@vger.kernel.org,
        lgoncalv@redhat.com, trix@redhat.com, russell.h.weight@intel.com,
        hao.wu@intel.com
In-Reply-To: <1609219662-27057-1-git-send-email-yilun.xu@intel.com>
References: <1609219662-27057-1-git-send-email-yilun.xu@intel.com>
Subject: Re: (subset) [PATCH 0/2] fix the issue when xfer by spi-altera
Message-Id: <160925239795.47982.14921180945738212657.b4-ty@kernel.org>
Date:   Tue, 29 Dec 2020 14:33:17 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 29 Dec 2020 13:27:40 +0800, Xu Yilun wrote:
> When doing spi xfer by spi-altera, divide by 0 exception happens in
> spi_transfer_wait(), This is because the xfer->speed_hz is always
> clamped to 0 by spi->controller->max_speed_hz, the feature is
> introduced in:
> 
> commit 9326e4f1e5dd ("spi: Limit the spi device max speed to controller's max speed")
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: altera: fix return value for altera_spi_txrx()
      commit: ede090f5a438e97d0586f64067bbb956e30a2a31

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
