Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 054F6173F86
	for <lists+linux-spi@lfdr.de>; Fri, 28 Feb 2020 19:25:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgB1SZt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 28 Feb 2020 13:25:49 -0500
Received: from foss.arm.com ([217.140.110.172]:42672 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726917AbgB1SZt (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 28 Feb 2020 13:25:49 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE13D31B;
        Fri, 28 Feb 2020 10:25:48 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 518663F7B4;
        Fri, 28 Feb 2020 10:25:48 -0800 (PST)
Date:   Fri, 28 Feb 2020 18:25:46 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Thommy Jakobsson <thommyj@gmail.com>
Cc:     broonie@kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, michal.simek@xilinx.com
Subject: Applied "spi/zynqmp: remove entry that causes a cs glitch" to the spi tree
In-Reply-To:  <20200224162643.29102-1-thommyj@gmail.com>
Message-Id:  <applied-20200224162643.29102-1-thommyj@gmail.com>
X-Patchwork-Hint: ignore
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi/zynqmp: remove entry that causes a cs glitch

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

From 5dd8304981ecffa77bb72b1c57c4be5dfe6cfae9 Mon Sep 17 00:00:00 2001
From: Thommy Jakobsson <thommyj@gmail.com>
Date: Mon, 24 Feb 2020 17:26:43 +0100
Subject: [PATCH] spi/zynqmp: remove entry that causes a cs glitch

In the public interface for chipselect, there is always an entry
commented as "Dummy generic FIFO entry" pushed down to the fifo right
after the activate/deactivate command. The dummy entry is 0x0,
irregardless if the intention was to activate or deactive the cs. This
causes the cs line to glitch rather than beeing activated in the case
when there was an activate command.

This has been observed on oscilloscope, and have caused problems for at
least one specific flash device type connected to the qspi port. After
the change the glitch is gone and cs goes active when intended.

The reason why this worked before (except for the glitch) was because
when sending the actual data, the CS bits are once again set. Since
most flashes uses mode 0, there is always a half clk period anyway for
cs to clk active setup time. If someone would rely on timing from a
chip_select call to a transfer_one, it would fail though.

It is unknown why the dummy entry was there in the first place, git log
seems to be of no help in this case. The reference manual gives no
indication of the necessity of this. In fact the lower 8 bits are a
setup (or hold in case of deactivate) time expressed in cycles. So this
should not be needed to fulfill any setup/hold timings.

Signed-off-by: Thommy Jakobsson <thommyj@gmail.com>
Reviewed-by: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Link: https://lore.kernel.org/r/20200224162643.29102-1-thommyj@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-zynqmp-gqspi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index 60c4de4e4485..7412a3042a8d 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -401,9 +401,6 @@ static void zynqmp_qspi_chipselect(struct spi_device *qspi, bool is_high)
 
 	zynqmp_gqspi_write(xqspi, GQSPI_GEN_FIFO_OFST, genfifoentry);
 
-	/* Dummy generic FIFO entry */
-	zynqmp_gqspi_write(xqspi, GQSPI_GEN_FIFO_OFST, 0x0);
-
 	/* Manually start the generic FIFO command */
 	zynqmp_gqspi_write(xqspi, GQSPI_CONFIG_OFST,
 			zynqmp_gqspi_read(xqspi, GQSPI_CONFIG_OFST) |
-- 
2.20.1

