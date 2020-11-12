Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 079BF2B0E35
	for <lists+linux-spi@lfdr.de>; Thu, 12 Nov 2020 20:40:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgKLTj5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 12 Nov 2020 14:39:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:40648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726831AbgKLTj4 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 12 Nov 2020 14:39:56 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6EEA12223F;
        Thu, 12 Nov 2020 19:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605209996;
        bh=feL8pMp1Iq9U9ess70IeUSs3C+afPL8bt+RMvuEgMqk=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=ejyHFne8UvWXKyPosO8Pp95EWWCkvd0qkZts12CQJbJ4gs+IDfH5LsBn+hNArOM8N
         PXBsWjyM2JTvzIVVu6CEb7NZZVWJ9aLp9GxcbQIKAjLhdLoNum4Yunq5ig3AD0XQBN
         7TQjEPKAhFbpCVodg4qLZ2VDf5tScVl6yWa8P2Cg=
Date:   Thu, 12 Nov 2020 19:39:40 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-spi@vger.kernel.org, Han Xu <han.xu@nxp.com>
In-Reply-To: <ab3c0b18bd820501a12c85e440006e09ec0e275f.1604874488.git.lukas@wunner.de>
References: <dd060534490eca5e946eb9165916542b01a9358d.1604874488.git.lukas@wunner.de> <ab3c0b18bd820501a12c85e440006e09ec0e275f.1604874488.git.lukas@wunner.de>
Subject: Re: [PATCH] spi: lpspi: Fix use-after-free on unbind
Message-Id: <160520996935.38820.15816205676377338250.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sun, 8 Nov 2020 23:41:00 +0100, Lukas Wunner wrote:
> Normally the last reference on an spi_controller is released by
> spi_unregister_controller().  In the case of the i.MX lpspi driver,
> the spi_controller is registered with devm_spi_register_controller(),
> so spi_unregister_controller() is invoked automatically after the driver
> has unbound.
> 
> However the driver already releases the last reference in
> fsl_lpspi_remove() through a gratuitous call to spi_master_put(),
> causing a use-after-free when spi_unregister_controller() is
> subsequently invoked by the devres framework.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: lpspi: Fix use-after-free on unbind
      commit: 4def49da620c84a682d9361d6bef0a97eed46fe0

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
