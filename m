Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 662CC361226
	for <lists+linux-spi@lfdr.de>; Thu, 15 Apr 2021 20:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233955AbhDOSeh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 15 Apr 2021 14:34:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:42022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233052AbhDOSeg (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 15 Apr 2021 14:34:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DDE896109D;
        Thu, 15 Apr 2021 18:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618511653;
        bh=Z7rlcf62/SeM90x3yXm6cxI0c7m0aB8KUv/uFZ4RNKM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EHok+Ml7HW5qRCjFV0UjOhOwESORXNHFxjxbQfAmrToF17zUp9G1JyKI0IdvSpmeG
         Eia+If0gp7lug8g4pDT574Z8ro+68h74JfGMHVG3prNXFbgC8/h9Y9v7G9xfpRauhb
         L8I1E8rSll0HcULpn6JGcBi3nJJ0nF9lSuGTtx6bMm4KLQRvK2NiLNQMEm/MLT6tG9
         XiQuMbYaDZdEMqWxWAZVAaR9hL1w1tuapPuWZ0BvJ8rHqyzoICbz3grkxBy2eif/Fx
         ijsXxWexN3Bx2YdCjMKm/w4p5Gd1T06zJ8N5tMv+thwkXd5QjviTqjbcM3F7dSGdZS
         B+5+lZAq4epeA==
From:   Mark Brown <broonie@kernel.org>
To:     kjlu@umn.edu, Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        quanyang.wang@windriver.com,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: Re: [PATCH] [v4] spi: spi-zynqmp-gqspi: Fix runtime PM imbalance in zynqmp_qspi_probe
Date:   Thu, 15 Apr 2021 19:33:41 +0100
Message-Id: <161851161878.23304.12649397818878323854.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210415074644.24646-1-dinghao.liu@zju.edu.cn>
References: <20210415074644.24646-1-dinghao.liu@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 15 Apr 2021 15:46:44 +0800, Dinghao Liu wrote:
> There is a PM usage counter decrement after zynqmp_qspi_init_hw()
> without any refcount increment, which leads to refcount leak.Add
> a refcount increment to balance the refcount. Also set
> auto_runtime_pm to resume suspended spi controller.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-zynqmp-gqspi: Fix runtime PM imbalance in zynqmp_qspi_probe
      commit: 58eaa7b2d07d3c25e1068b0bf42ca7e7464f4bca

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
