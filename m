Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 764032B5513
	for <lists+linux-spi@lfdr.de>; Tue, 17 Nov 2020 00:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729573AbgKPXeK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 Nov 2020 18:34:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:41492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbgKPXeJ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 16 Nov 2020 18:34:09 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0188E22314;
        Mon, 16 Nov 2020 23:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605569649;
        bh=jYfF/Df9sJgPWiehVRzemv1qkjlKpJfp3meLqrvQK6s=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=o0e08W1IMyTXEbl6IULFYskAlrpG2rKkfJNYBXos/b+6mXpdIePpUxP3AgqVp0blf
         nd3k3Aa/UQRRYHCCDuM5DELBo9uBTC3v8INL/u4fxtE9A9iQv5pMxBsdfUEySeXCXD
         oxtYv1iYMHxmFwWkD8ldP13x0zhioCE3udoFb+No=
Date:   Mon, 16 Nov 2020 23:33:50 +0000
From:   Mark Brown <broonie@kernel.org>
To:     tudor.ambarus@microchip.com,
        Zhihao Cheng <chengzhihao1@huawei.com>,
        vadivel.muruganx.ramuthevar@linux.intel.com,
        p.zabel@pengutronix.de, vigneshr@ti.com
Cc:     yi.zhang@huawei.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201116141836.2970579-1-chengzhihao1@huawei.com>
References: <20201116141836.2970579-1-chengzhihao1@huawei.com>
Subject: Re: [PATCH v2] spi: cadence-quadspi: Fix error return code in cqspi_probe
Message-Id: <160556963072.29969.15448651614213250723.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 16 Nov 2020 22:18:36 +0800, Zhihao Cheng wrote:
> Fix to return the error code from
> devm_reset_control_get_optional_exclusive() instaed of 0
> in cqspi_probe().

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: cadence-quadspi: Fix error return code in cqspi_probe
      commit: ac9978fcad3c5abc43cdd225441ce9459c36e16b

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
