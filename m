Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D375222997E
	for <lists+linux-spi@lfdr.de>; Wed, 22 Jul 2020 15:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732613AbgGVNpg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 22 Jul 2020 09:45:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:33532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726973AbgGVNpf (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 22 Jul 2020 09:45:35 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE0412065D;
        Wed, 22 Jul 2020 13:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595425535;
        bh=MbDUQq4hv3Bu6X+sTYr525LGt5TYNZVH+e4Nl8F8HUw=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=crHynl8qPWgWMFM1sysS1Lzf4/vaJFXwGmAgLxCJ7/VNz0TNRMSra9+4EiOf8H8bn
         +nDmxGgi5Na4yBPisRdlQleHtQ3ZZ73dGIFB0rj4Lt3UCtTR0AGriMA9V/itV9YrjZ
         wQ3nq3AZh4gPkOCQr3I6nF0lFKaKGDy5O1acR/F4=
Date:   Wed, 22 Jul 2020 14:45:22 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Clark Wang <xiaoning.wang@nxp.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20200714075251.12777-1-xiaoning.wang@nxp.com>
References: <20200714075251.12777-1-xiaoning.wang@nxp.com>
Subject: Re: [PATCH 0/5] Some bug fix for lpspi
Message-Id: <159542550175.19884.2603527315326091104.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 14 Jul 2020 15:52:46 +0800, Clark Wang wrote:
> This series mainly fixes some recently discovered problems about CS for
> LPSPI module.
> 
> And two patches to improve the reliability of the driver.
> 
> Regards,
> Clark
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/5] spi: lpspi: fix the imbalance of runtime pm function call
      commit: 2abbae5a0e4e1d81016f56a403b2daadfee314c3
[2/5] spi: lpspi: add NULL check when probe device
      (no commit info)
[3/5] spi: lpspi: fix kernel warning dump when probe fail after calling spi_register
      (no commit info)
[4/5] spi: lpspi: handle EPROBE_DEFER when get cs-gpios number
      (no commit info)
[5/5] spi: lpspi: fix using CS discontinuously on i.MX8DXLEVK
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
