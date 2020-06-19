Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15643200A1A
	for <lists+linux-spi@lfdr.de>; Fri, 19 Jun 2020 15:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732706AbgFSN2r (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 19 Jun 2020 09:28:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:46202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732259AbgFSN2A (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 19 Jun 2020 09:28:00 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D858E20DD4;
        Fri, 19 Jun 2020 13:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592573280;
        bh=YpdfNUm60XZRpLiCg2ApF7cAEYbSiiMws4GRf6hk9yo=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=0kDpuucr+TobRCZk9B0E75UlrpOpcER5uN+QcqLOtDsfY0WIewKqZ4YTeg4LQPPKo
         nLG38vVbMczNBdDzJQTgvb5dpsoAR8vCDeF1sFPFCW0JOGsfSvl60D2Vqzsq7RoXp4
         XARdoVOq+QC6e6ORhl+wwdtSuyf8ce69xVrD3aqM=
Date:   Fri, 19 Jun 2020 14:27:58 +0100
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xu Yilun <yilun.xu@intel.com>
Cc:     matthew.gerlach@linux.intel.com, hao.wu@intel.com,
        russell.h.weight@intel.com, trix@redhat.com
In-Reply-To: <1592531021-11412-1-git-send-email-yilun.xu@intel.com>
References: <1592531021-11412-1-git-send-email-yilun.xu@intel.com>
Subject: Re: [RESEND PATCH v2 0/3] add regmap & indirect access support
Message-Id: <159257327821.5984.15184472386288306180.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 19 Jun 2020 09:43:38 +0800, Xu Yilun wrote:
> Updated the regmap & indirect access support for spi-altera.
> 
> Patch #1 is an 1:1 replacement of of readl/writel with regmap_read/write
> Patch #2 introduced a new platform_device_id to support indirect access as
>          a sub device.
> Patch #3 is a minor fix.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: altera: use regmap-mmio instead of direct mmio register access
      commit: 3c6519736eefebafdf8c82d46f64b214403b5260
[2/3] spi: altera: support indirect access to the registers
      commit: 3820061d38156d88443d32a9a6c701d281234746
[3/3] spi: altera: fix size mismatch on 64 bit processors
      commit: d9dd0fb0e197ae766f0f5e06d23f5f5e1888c511

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
