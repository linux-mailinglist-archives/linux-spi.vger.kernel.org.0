Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7540289B16
	for <lists+linux-spi@lfdr.de>; Mon, 12 Aug 2019 12:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727563AbfHLKNz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 12 Aug 2019 06:13:55 -0400
Received: from mga04.intel.com ([192.55.52.120]:59913 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727518AbfHLKNz (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 12 Aug 2019 06:13:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Aug 2019 03:13:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,377,1559545200"; 
   d="scan'208";a="175835873"
Received: from mylly.fi.intel.com (HELO mylly.fi.intel.com.) ([10.237.72.59])
  by fmsmga008.fm.intel.com with ESMTP; 12 Aug 2019 03:13:54 -0700
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
To:     linux-spi@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH] spi: dw-pci: Add support for Intel Elkhart Lake PSE SPI
Date:   Mon, 12 Aug 2019 13:13:44 +0300
Message-Id: <20190812101344.3975-1-jarkko.nikula@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add support for Intel(R) Programmable Services Engine (Intel(R) PSE) SPI
controller in Intel Elkhart Lake when interface is assigned to the host
processor.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 drivers/spi/spi-dw-pci.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/spi/spi-dw-pci.c b/drivers/spi/spi-dw-pci.c
index c1e2401cace0..4e3a4c317636 100644
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
@@ -123,6 +131,11 @@ static const struct pci_device_id pci_ids[] = {
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

