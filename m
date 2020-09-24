Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E227F277081
	for <lists+linux-spi@lfdr.de>; Thu, 24 Sep 2020 14:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbgIXMBO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 24 Sep 2020 08:01:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:39174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727437AbgIXMBO (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 24 Sep 2020 08:01:14 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F69E2344C;
        Thu, 24 Sep 2020 12:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600948873;
        bh=ryaBH5oGdAnh2acPFTb+k+zUl7lCvR8a8asSUhj4dVg=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=XiOFQNOaX4QW0htReMlV4VUBwSqUFfSf3AJ97zSWL/d7OSoJ5pV5NXvxxDukmBwg4
         PWFfPyE7OTmzaXgObV+ia21uyoWA4yTvtyUUge9X0j7ylFcuSVobKTIF9ufP4yPJt+
         nGLGpaB/vYJ9aREM5bQrUxl4xuvkgXFIKvyLG4Ns=
Date:   Thu, 24 Sep 2020 13:00:19 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        amit.kumar-mahapatra@xilinx.com, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, git@xilinx.com
In-Reply-To: <cover.1600931476.git.michal.simek@xilinx.com>
References: <cover.1600931476.git.michal.simek@xilinx.com>
Subject: Re: [RESEND v2 PATCH 0/3] spi: spi-zynqmp-gqspi: Update driver to use spi-mem framework
Message-Id: <160094881929.50579.14016203179713810994.b4-ty@kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 24 Sep 2020 09:11:16 +0200, Michal Simek wrote:
> I am resending this series instead of Amit because his patches are broken
> in lore. Mark has reported the issue with it and I clearly see that patch
> is broken in lore.
> For example:
> https://lore.kernel.org/linux-spi/20200922164016.30979-2-amit.kumar-mahapatra@xilinx.com/raw
> 
> There is additional = which shouldn't be there.
> @@ -183,7 +184,7 @@ static u32 zynqmp_gqspi_read(struct zynqmp_qspi *xqspi,=
> u32 offset)
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: spi-zynqmp-gqspi: Fix kernel-doc warnings
      commit: 91af6eb04a6bbdb8bec8ed6d8ac7850a26604bad
[2/3] spi: spi-zynqmp-gqspi: Update driver to use spi-mem framework
      commit: 1c26372e5aa9e53391a1f8fe0dc7cd93a7e5ba9e
[3/3] spi: spi-zynqmp-gqspi: Fix incorrect indentation
      commit: f09a433b1e4057e6379b7e1207548fff30d5dca3

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
