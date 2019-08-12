Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06C0E89F44
	for <lists+linux-spi@lfdr.de>; Mon, 12 Aug 2019 15:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728724AbfHLNKZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 12 Aug 2019 09:10:25 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40886 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728880AbfHLNKT (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 12 Aug 2019 09:10:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=Ds2HZcbtnxHYnhfwZpFOVMikdP1uPxKConW1giV0NuU=; b=gvcpqwbUhRvg
        FHlOZ0EDNT3tywc/b9yjVmypJJEGEF18RhKz20H0VfDEZgVcqilglqSPtt16sq0FLut9c/14t0QL0
        6j/rKn24vLW46PBmbgmchr20ZT75u3sssCG/oYi4undeMmREnSP4JmnTdju6J41uqeVzpZQFj9G2G
        KRhHM=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hxA5X-0001S6-1u; Mon, 12 Aug 2019 13:10:15 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 5B7332740CB7; Mon, 12 Aug 2019 14:10:14 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "spi: dw-pci: Add support for Intel Elkhart Lake PSE SPI" to the spi tree
In-Reply-To: <20190812101344.3975-1-jarkko.nikula@linux.intel.com>
X-Patchwork-Hint: ignore
Message-Id: <20190812131014.5B7332740CB7@ypsilon.sirena.org.uk>
Date:   Mon, 12 Aug 2019 14:10:14 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: dw-pci: Add support for Intel Elkhart Lake PSE SPI

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

From 52718908c3f44b939a9934ef624e68457b21704f Mon Sep 17 00:00:00 2001
From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Date: Mon, 12 Aug 2019 13:13:44 +0300
Subject: [PATCH] spi: dw-pci: Add support for Intel Elkhart Lake PSE SPI

Add support for Intel(R) Programmable Services Engine (Intel(R) PSE) SPI
controller in Intel Elkhart Lake when interface is assigned to the host
processor.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Link: https://lore.kernel.org/r/20190812101344.3975-1-jarkko.nikula@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-dw-pci.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/spi/spi-dw-pci.c b/drivers/spi/spi-dw-pci.c
index 9651679ee7f7..e9ba63814548 100644
--- a/drivers/spi/spi-dw-pci.c
+++ b/drivers/spi/spi-dw-pci.c
@@ -19,6 +19,7 @@ struct spi_pci_desc {
 	int	(*setup)(struct dw_spi *);
 	u16	num_cs;
 	u16	bus_num;
+	u32	max_freq;
 };
 
 static struct spi_pci_desc spi_pci_mid_desc_1 = {
@@ -33,6 +34,12 @@ static struct spi_pci_desc spi_pci_mid_desc_2 = {
 	.bus_num = 1,
 };
 
+static struct spi_pci_desc spi_pci_ehl_desc = {
+	.num_cs = 1,
+	.bus_num = -1,
+	.max_freq = 100000000,
+};
+
 static int spi_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	struct dw_spi *dws;
@@ -65,6 +72,7 @@ static int spi_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (desc) {
 		dws->num_cs = desc->num_cs;
 		dws->bus_num = desc->bus_num;
+		dws->max_freq = desc->max_freq;
 
 		if (desc->setup) {
 			ret = desc->setup(dws);
@@ -125,6 +133,11 @@ static const struct pci_device_id pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0x0800), (kernel_ulong_t)&spi_pci_mid_desc_1},
 	/* Intel MID platform SPI controller 2 */
 	{ PCI_VDEVICE(INTEL, 0x0812), (kernel_ulong_t)&spi_pci_mid_desc_2},
+	/* Intel Elkhart Lake PSE SPI controllers */
+	{ PCI_VDEVICE(INTEL, 0x4b84), (kernel_ulong_t)&spi_pci_ehl_desc},
+	{ PCI_VDEVICE(INTEL, 0x4b85), (kernel_ulong_t)&spi_pci_ehl_desc},
+	{ PCI_VDEVICE(INTEL, 0x4b86), (kernel_ulong_t)&spi_pci_ehl_desc},
+	{ PCI_VDEVICE(INTEL, 0x4b87), (kernel_ulong_t)&spi_pci_ehl_desc},
 	{},
 };
 
-- 
2.20.1

