Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5DCF362514
	for <lists+linux-spi@lfdr.de>; Fri, 16 Apr 2021 18:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235953AbhDPQCl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 16 Apr 2021 12:02:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:35178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236696AbhDPQCk (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 16 Apr 2021 12:02:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E524A6113D;
        Fri, 16 Apr 2021 16:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618588935;
        bh=QcthwwJiMvVbK9IsIluy83Ialj889l/+NGpd6dpLfGU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R7Ex9Fan5fo/F7GycbAWxy2T8HgYUeJQcrAA6QkXDKG7RcGwfIHzEdyv8T+Zt/LcD
         GL7zCFZ2FT4TT6iz+g577vyExyR5cmyJjvH//tmxCvvaLGuu9KzkMbaZGb1P9lfKUk
         Roca3AxJenfGhIoS/b0kLJX14v63xo8hG9WVSQU1mJC+iqrO0d4sZbrgL/y3yZoCfz
         7F74xE/DDrX6TsvXJJBQztloJcnH1jwJ1nWf8GjKZNfe9urBEqd5twKinDGfi+FPpY
         Z3KbtWPsP4+wtyQsK7VBKEee7BywN86Z/75QEakw6IDDUr1uHyUk62YJND5KfzdUwo
         iI0FZ7MHeX3UA==
From:   Mark Brown <broonie@kernel.org>
To:     Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        quanyang.wang@windriver.com, Michal Simek <michal.simek@xilinx.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH 0/5] spi: spi-zynqmp-gqspi: fix spi issues
Date:   Fri, 16 Apr 2021 17:01:46 +0100
Message-Id: <161858883110.29027.5432599534762847384.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210416142047.6349-1-quanyang.wang@windriver.com>
References: <20210416142047.6349-1-quanyang.wang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 16 Apr 2021 22:20:42 +0800, quanyang.wang@windriver.com wrote:
> V2:
> Remove all "Fixes:" tags since they base on some patches are not
> with "Fixes:".
> 
> V1:
> This series fix some issues that occurs in spi-zynqmp-gqspi.c.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/5] spi: spi-zynqmp-gqspi: fix clk_enable/disable imbalance issue
      commit: c6bdae08012b2ca3e94f3a41ef4ca8cfe7c9ab6f
[2/5] spi: spi-zynqmp-gqspi: fix hang issue when suspend/resume
      commit: 799f923f0a66a9c99f0a3eaa078b306db7a8b33a
[3/5] spi: spi-zynqmp-gqspi: Resolved slab-out-of-bounds bug
      commit: 2530b3df4326023a171977ab46fdfeac0340f5b2
[4/5] spi: spi-zynqmp-gqspi: fix use-after-free in zynqmp_qspi_exec_op
      commit: a2c5bedb2d55dd27c642c7b9fb6886d7ad7bdb58
[5/5] spi: spi-zynqmp-gqspi: return -ENOMEM if dma_map_single fails
      commit: 126bdb606fd2802454e6048caef1be3e25dd121e

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
