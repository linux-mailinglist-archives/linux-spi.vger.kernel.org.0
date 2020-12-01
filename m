Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA38B2CA4BB
	for <lists+linux-spi@lfdr.de>; Tue,  1 Dec 2020 15:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391521AbgLAN73 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 1 Dec 2020 08:59:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:45646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391444AbgLAN71 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 1 Dec 2020 08:59:27 -0500
Received: from localhost (cpc102334-sgyl38-2-0-cust884.18-2.cable.virginm.net [92.233.91.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15A60208FE;
        Tue,  1 Dec 2020 13:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606831126;
        bh=vFGMacmga0jPQFovA/dgAN/hI21uqG0vo1aBfUhTb1A=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=QzEl5S6gYwWHuQih0xzJY77Fxks6iqnwUrTZOSTd3xL47g0X5+1vPweLp8U6mQA0S
         ckha8CYVPuTphRNJ3aV5uwEkqYsWupHqtCEyOTMFCucVCkiXumh6Z8pSOKy4JOixzR
         434ryf9DzX7Ck/E6Lc86Y7BhTzrZm3akooTiLy5Y=
From:   Mark Brown <broonie@kernel.org>
To:     bbrezillon@kernel.org,
        Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
        robh+dt@kernel.org, joel@jms.id.au, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, clg@kaod.org,
        linux-kernel@vger.kernel.org, andrew@aj.id.au,
        linux-aspeed@lists.ozlabs.org
Cc:     BMC-SW@aspeedtech.com
In-Reply-To: <20201105120331.9853-1-chin-ting_kuo@aspeedtech.com>
References: <20201105120331.9853-1-chin-ting_kuo@aspeedtech.com>
Subject: Re: [v3 0/4] Porting ASPEED FMC/SPI memory controller driver
Message-Id: <160683107675.35139.15332656159104751022.b4-ty@kernel.org>
Date:   Tue, 01 Dec 2020 13:57:56 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 5 Nov 2020 20:03:27 +0800, Chin-Ting Kuo wrote:
> This patch series aims to porting ASPEED FMC/SPI memory controller
> driver with spi-mem interface. Adjust device tree setting of SPI NOR
> flash in order to fit real AST2600 EVB and new SPI memory controller
> driver. Also, this patch has been verified on AST2600-A1 EVB.
> 
> v2: Fix sparse warnings reported by kernel test robot <lkp@intel.com>.
> v3: Fix build warnings with x86 allmodconfig.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] dt-bindings: spi: Add binding file for ASPEED FMC/SPI memory controller
      (no commit info)
[2/2] spi: aspeed: Add ASPEED FMC/SPI memory controller driver
      (no commit info)

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
