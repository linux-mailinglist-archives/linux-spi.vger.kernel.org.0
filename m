Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C760035A309
	for <lists+linux-spi@lfdr.de>; Fri,  9 Apr 2021 18:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234157AbhDIQXw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 9 Apr 2021 12:23:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:60080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234163AbhDIQXu (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 9 Apr 2021 12:23:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 47A50610A7;
        Fri,  9 Apr 2021 16:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617985414;
        bh=NbcpexnX5iU7IgpviaFOjg2Yh5s9Xswwnh9WEJBh2L4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CZPlqqx/VRpFRuNe3kUipNgibH3Nzmt7PY5JTos9Vcxm3wkNNlYCll/mnSZpKiq+3
         CPkvkCeGeci8tHq3mBDiXBsZ1gu3i9CHNra4NkBbegegR6fuv3rT1tW/OVgjhE8ptb
         gzBJLbzVjcx8jkAFdPORvZVxr1XZ+SziJKK/DWr1M7bmQm2+QuLjVmwJqsmEw25MX4
         TVfS1MFQKUmszGZAYxP/hXN3IrdKT5WUFbZbmGpRe/BiJBbHcXKdYAUZrWP93D9TCR
         DPmWJPZ3huTgc3DH2q/M6HKwXATjNRcK0XBnZe+sAlRz++v5mc9qVLs7Il3MUhV2ZW
         qsJr6FNP3layw==
From:   Mark Brown <broonie@kernel.org>
To:     quanyang.wang@windriver.com,
        Michal Simek <michal.simek@xilinx.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/4] spi: spi-zynqmp-gpspi: fix some issues
Date:   Fri,  9 Apr 2021 17:22:45 +0100
Message-Id: <161798356989.48466.13500615762726622805.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210408040223.23134-1-quanyang.wang@windriver.com>
References: <20210408040223.23134-1-quanyang.wang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 8 Apr 2021 12:02:19 +0800, quanyang.wang@windriver.com wrote:
> This series fix some issues that occurs when the gqspi driver switches to spi-mem framework.
> 
> Hi Amit,
> I rewrite the "Subject" and "commit message" of these patches, so they
> look different from the ones which you reviewed before. I still keep
> your "Reviewed-by" and hope you will not mind.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/4] spi: spi-zynqmp-gqspi: use wait_for_completion_timeout to make zynqmp_qspi_exec_op not interruptible
      commit: a16bff68b75fd082d36aa0b14b540bd7a3ebebbd
[2/4] spi: spi-zynqmp-gqspi: add mutex locking for exec_op
      commit: a0f65be6e880a14d3445b75e7dc03d7d015fc922
[3/4] spi: spi-zynqmp-gqspi: transmit dummy circles by using the controller's internal functionality
      commit: 8ad07d79bd56a531990a1a3f3f1c0eb19d2de806
[4/4] spi: spi-zynqmp-gqspi: fix incorrect operating mode in zynqmp_qspi_read_op
      commit: 41d310930084502433fcb3c4baf219e7424b7734

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
