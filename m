Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8FFA35EF
	for <lists+linux-spi@lfdr.de>; Fri, 30 Aug 2019 13:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbfH3Lph (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 30 Aug 2019 07:45:37 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42800 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728202AbfH3Lpg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 30 Aug 2019 07:45:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=VVUyMIxhZ1ehZPN1k1ho1QT9EgeKAQK1J3B7SnHdiAg=; b=w0B+itdm3BZO
        MtncTd5vMSG1WzkiROd8AndYqxe8ae32AFX0N1QHxTCsxH82nBX/Dcwr96EUv1+lmekAXG/Ov6jc1
        VKbggsyoGg2cd9xnly0Uu9nUzdKdBQekbIRBlY/GK2mOYLhNS1chD6Stm7eB/qP4EfMIM4s4CQN8e
        1L1Gk=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i3fLQ-0006KU-VE; Fri, 30 Aug 2019 11:45:33 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 74D5C2742B61; Fri, 30 Aug 2019 12:45:32 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "spi: dw-pci: Add MODULE_DEVICE_TABLE" to the spi tree
In-Reply-To: <20190829125000.26303-1-jarkko.nikula@linux.intel.com>
X-Patchwork-Hint: ignore
Message-Id: <20190830114532.74D5C2742B61@ypsilon.sirena.org.uk>
Date:   Fri, 30 Aug 2019 12:45:32 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: dw-pci: Add MODULE_DEVICE_TABLE

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.3

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

From 94e9c0f522142e47348486f98916cb0b16e72571 Mon Sep 17 00:00:00 2001
From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Date: Thu, 29 Aug 2019 15:50:00 +0300
Subject: [PATCH] spi: dw-pci: Add MODULE_DEVICE_TABLE

MODULE_DEVICE_TABLE is missing from the PCI part of the driver. Add it
so userspace can autoload the the driver when it is built as module.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Link: https://lore.kernel.org/r/20190829125000.26303-1-jarkko.nikula@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-dw-pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-dw-pci.c b/drivers/spi/spi-dw-pci.c
index e9ba63814548..90e7b789da3b 100644
--- a/drivers/spi/spi-dw-pci.c
+++ b/drivers/spi/spi-dw-pci.c
@@ -140,6 +140,7 @@ static const struct pci_device_id pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0x4b87), (kernel_ulong_t)&spi_pci_ehl_desc},
 	{},
 };
+MODULE_DEVICE_TABLE(pci, pci_ids);
 
 static struct pci_driver dw_spi_driver = {
 	.name =		DRIVER_NAME,
-- 
2.20.1

