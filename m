Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46C6D2C6953
	for <lists+linux-spi@lfdr.de>; Fri, 27 Nov 2020 17:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730603AbgK0QUz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 27 Nov 2020 11:20:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:45632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730324AbgK0QUz (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 27 Nov 2020 11:20:55 -0500
Received: from localhost (cpc102334-sgyl38-2-0-cust884.18-2.cable.virginm.net [92.233.91.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57B3E2224B;
        Fri, 27 Nov 2020 16:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606494054;
        bh=fc0Foz/mCFCHJCyel1C/TtiaoBx8riiFUcTYhjjC5Mw=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=XRIcOHYrg50TFFthw34uB8o7O5WiQvuhLIikMIVKZijC67UUCLjjp9NLKSNxaroQm
         pQozCvzXQY49gajTxANT44v3ujNx5kZXP3FOsS5rS4zBCp9uTpE6K3+EB2kILx0ozc
         cvaLpGAh4HRHbk9H0SNz+PLMlFlh/y4gQcyovOGs=
Date:   Fri, 27 Nov 2020 16:20:29 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
Cc:     linux-spi@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201127144612.4204-1-Sergey.Semin@baikalelectronics.ru>
References: <20201127144612.4204-1-Sergey.Semin@baikalelectronics.ru>
Subject: Re: [PATCH v2] spi: dw-bt1: Fix undefined devm_mux_control_get symbol
Message-Id: <160649402991.52141.6145560992188736394.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 27 Nov 2020 17:46:11 +0300, Serge Semin wrote:
> I mistakenly added the select attributes to the SPI_DW_BT1_DIRMAP config
> instead of having them defined in SPI_DW_BT1. If the kernel doesn't have
> the MULTIPLEXER and MUX_MMIO configs manually enabled and the
> SPI_DW_BT1_DIRMAP config hasn't been selected, Baikal-T1 SPI device will
> always fail to be probed by the driver. Fix that and the error reported by
> the test robot:
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: dw-bt1: Fix undefined devm_mux_control_get symbol
      commit: 7218838109fef61cdec988ff728e902d434c9cc5

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
