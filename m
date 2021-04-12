Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B580F35D0B3
	for <lists+linux-spi@lfdr.de>; Mon, 12 Apr 2021 21:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236837AbhDLTBp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 12 Apr 2021 15:01:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:56390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236781AbhDLTBo (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 12 Apr 2021 15:01:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D180B61356;
        Mon, 12 Apr 2021 19:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618254086;
        bh=wgbZzfhm4HQr4rtiTGyBeEl37821JWgT1iYcHuDlc6M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MrwoeN8P6TCu3iuVNvKnNoom+Vy1QhBCcAIZlYufUcYGkgdjT7RpptEs68m8kxZ//
         z/hEiEFY85NwzdxnL/TODg1eAwFMvXZ2SFKZSDIo7KH2J9xZTuhT9ZUxkvV2AolgeJ
         S+UqqbjWBzFykJn84dZ9ALEjF3fCtEo4IBZDJUDZ0FyvIu7cJgg8V31hVdGHtPYTRy
         eJtE47Cpe28CfBDpetFPcIqU1cQNyCLTuX4HU58waH0boSulPSLII9JRVKpdw+mD9l
         24ouMANjyNkURiJUlLfNBGXs0IHKkJjcOCJ4DNQdgja9oeyl+m2IX2unuPduRQzmYG
         8IyKFmhWTAGlQ==
From:   Mark Brown <broonie@kernel.org>
To:     Quanyang Wang <quanyang.wang@windriver.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Hulk Robot <hulkci@huawei.com>, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] spi: spi-zynqmp-gqspi: Fix missing unlock on error in zynqmp_qspi_exec_op()
Date:   Mon, 12 Apr 2021 20:00:58 +0100
Message-Id: <161825405874.52313.7242174771524864608.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210412160025.194171-1-weiyongjun1@huawei.com>
References: <20210412160025.194171-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 12 Apr 2021 16:00:25 +0000, Wei Yongjun wrote:
> Add the missing unlock before return from function zynqmp_qspi_exec_op()
> in the error handling case.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-zynqmp-gqspi: Fix missing unlock on error in zynqmp_qspi_exec_op()
      commit: 6043357263fbe2df0bf0736d971ad5dce7d19dc1

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
