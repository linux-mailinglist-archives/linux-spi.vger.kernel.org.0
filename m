Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F75D1A87A7
	for <lists+linux-spi@lfdr.de>; Tue, 14 Apr 2020 19:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440281AbgDNRhJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 14 Apr 2020 13:37:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:46700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440013AbgDNRhG (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 14 Apr 2020 13:37:06 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B6AE2054F;
        Tue, 14 Apr 2020 17:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586885825;
        bh=pxB7PEQPW1V54VIYFv6sK8pnridHakB4F+jcrfYRXEI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=U6IKUuuzHAzY+Gp3Q1wV6s3FgjSOMdPCHs8V0ZTc/H9vlQb/LKGsB17YqeoierW9q
         rzB6DOHNZXpuTXZmh7SiziVke47+wIgSRi7VPDBcVSa9G2ABkDgOdQa9n1o0Z1o/Ar
         nZd5ZMVUNHpYgEo7/k73xYqK+BPCEUaO7HuU2YXg=
Date:   Tue, 14 Apr 2020 18:37:03 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Aishwarya R <aishwaryarj100@gmail.com>
Cc:     aishwaryarj100@gmail.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "spi: spi-fsl-spi: Fix checkpatch error "foo * bar" should be "foo *bar"" to the spi tree
In-Reply-To:  <20200407122855.5531-1-aishwaryarj100@gmail.com>
Message-Id:  <applied-20200407122855.5531-1-aishwaryarj100@gmail.com>
X-Patchwork-Hint: ignore
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: spi-fsl-spi: Fix checkpatch error "foo * bar" should be "foo *bar"

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

From 7cb88afb42a49e5a6d51d458ffbb3d02e2c0755c Mon Sep 17 00:00:00 2001
From: Aishwarya R <aishwaryarj100@gmail.com>
Date: Tue, 7 Apr 2020 17:58:55 +0530
Subject: [PATCH] spi: spi-fsl-spi: Fix checkpatch error "foo * bar" should be
 "foo *bar"

This patch fixes checkpatch error "foo * bar" should be "foo *bar"

Signed-off-by: Aishwarya R <aishwaryarj100@gmail.com>
Link: https://lore.kernel.org/r/20200407122855.5531-1-aishwaryarj100@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-fsl-spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index 3b81772fea0d..67f022b8c81d 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -588,7 +588,7 @@ static void fsl_spi_grlib_probe(struct device *dev)
 	pdata->cs_control = fsl_spi_grlib_cs_control;
 }
 
-static struct spi_master * fsl_spi_probe(struct device *dev,
+static struct spi_master *fsl_spi_probe(struct device *dev,
 		struct resource *mem, unsigned int irq)
 {
 	struct fsl_spi_platform_data *pdata = dev_get_platdata(dev);
-- 
2.20.1

