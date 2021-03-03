Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41D5C32C6EF
	for <lists+linux-spi@lfdr.de>; Thu,  4 Mar 2021 02:09:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357397AbhCDAab (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 3 Mar 2021 19:30:31 -0500
Received: from mga12.intel.com ([192.55.52.136]:10027 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347077AbhCCPbE (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 3 Mar 2021 10:31:04 -0500
IronPort-SDR: J30wKRvOQPsszfdiLHSFv63gnQ/JNFLmYN/e93nV2JmrPy7Ef0OsNIt+LeeNsUip+QF460OUWT
 0IDzEKpnTdSQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9912"; a="166470328"
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; 
   d="scan'208";a="166470328"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 07:28:17 -0800
IronPort-SDR: OOj6IutRWMLCnYeCRsILydQ9Qd26V5PAR/QkI4SLvIF7uCpnENYTBxmELjLFK80GS2W48U9xo/
 M6QGnmQoiBdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; 
   d="scan'208";a="506827348"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 03 Mar 2021 07:28:16 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] spi: Add support for software nodes
Date:   Wed,  3 Mar 2021 18:28:11 +0300
Message-Id: <20210303152814.35070-2-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210303152814.35070-1-heikki.krogerus@linux.intel.com>
References: <20210303152814.35070-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Making it possible for the drivers to assign complete
software fwnodes to the devices instead of only the device
properties in those nodes.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/spi/spi.c       | 13 +++++++++++--
 include/linux/spi/spi.h |  5 ++++-
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index b08efe88ccd6c..9b46998ae2a44 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -686,6 +686,15 @@ struct spi_device *spi_new_device(struct spi_controller *ctlr,
 		}
 	}
 
+	if (chip->swnode) {
+		status = device_add_software_node(&proxy->dev, chip->swnode);
+		if (status) {
+			dev_err(&ctlr->dev, "failed to add softwade node to '%s': %d\n",
+				chip->modalias, status);
+			goto err_remove_props;
+		}
+	}
+
 	status = spi_add_device(proxy);
 	if (status < 0)
 		goto err_remove_props;
@@ -693,8 +702,7 @@ struct spi_device *spi_new_device(struct spi_controller *ctlr,
 	return proxy;
 
 err_remove_props:
-	if (chip->properties)
-		device_remove_properties(&proxy->dev);
+	device_remove_software_node(&proxy->dev);
 err_dev_put:
 	spi_dev_put(proxy);
 	return NULL;
@@ -719,6 +727,7 @@ void spi_unregister_device(struct spi_device *spi)
 	}
 	if (ACPI_COMPANION(&spi->dev))
 		acpi_device_clear_enumerated(ACPI_COMPANION(&spi->dev));
+	device_remove_software_node(&spi->dev);
 	device_unregister(&spi->dev);
 }
 EXPORT_SYMBOL_GPL(spi_unregister_device);
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 592897fa4f030..f47f94ea6fa99 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -20,6 +20,7 @@
 
 struct dma_chan;
 struct property_entry;
+struct software_node;
 struct spi_controller;
 struct spi_transfer;
 struct spi_controller_mem_ops;
@@ -1409,7 +1410,8 @@ static inline ssize_t spi_w8r16be(struct spi_device *spi, u8 cmd)
  * @modalias: Initializes spi_device.modalias; identifies the driver.
  * @platform_data: Initializes spi_device.platform_data; the particular
  *	data stored there is driver-specific.
- * @properties: Additional device properties for the device.
+ * @properties: Deprecated - use software node instead.
+ * @swnode: Software node for the device.
  * @controller_data: Initializes spi_device.controller_data; some
  *	controllers need hints about hardware setup, e.g. for DMA.
  * @irq: Initializes spi_device.irq; depends on how the board is wired.
@@ -1448,6 +1450,7 @@ struct spi_board_info {
 	char		modalias[SPI_NAME_SIZE];
 	const void	*platform_data;
 	const struct property_entry *properties;
+	const struct software_node *swnode;
 	void		*controller_data;
 	int		irq;
 
-- 
2.30.1

