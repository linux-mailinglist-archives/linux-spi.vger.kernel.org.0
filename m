Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3733526E4EC
	for <lists+linux-spi@lfdr.de>; Thu, 17 Sep 2020 21:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgIQS7g (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 17 Sep 2020 14:59:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:60104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726496AbgIQS72 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 17 Sep 2020 14:59:28 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFF73206A1;
        Thu, 17 Sep 2020 18:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600369168;
        bh=5j+4R+6a1Y3ohIw1PIgcrqZxCypD7KxxGmhRmqZL/Fg=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=HPB6FD/6HUNAs5vvh1Qgf3EhgdioIthOFzGxeyk/tv+uslRdvfJ4nV230EabcI8BC
         Q8m+MW+/YNioIWG/4+TzFmtw+v3F020+110SMdS10GiXYYk1PCBWcThv6B92AaAime
         eeabj2HzPK/LeYS8EnWg9uY3YRUx69RKfy49tB5M=
Date:   Thu, 17 Sep 2020 19:58:38 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Ricardo Ribalda <ribalda@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20200915112936.320647-1-ribalda@kernel.org>
References: <20200915112936.320647-1-ribalda@kernel.org>
Subject: Re: [PATCH] spi: xilinx: Fix info message during probe
Message-Id: <160036909795.20353.17587960090458836310.b4-ty@kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 15 Sep 2020 13:29:36 +0200, Ricardo Ribalda wrote:
> The info message was showing the mapped address of the device. To avoid
> security problems, all virtual addresses are converted to __ptrval__, so
> the message was useless/ugly:
> 
> [    2.304949] xilinx_spi b0010000.spi-flash: at 0xB0010000 mapped to 0x(____ptrval____), irq=37
> 
> Use %pR instead:
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: xilinx: Fix info message during probe
      commit: 985be7ebfbf79767bc3705eee7de635edd4eba7d

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
