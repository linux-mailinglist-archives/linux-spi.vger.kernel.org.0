Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E77F32C6F9
	for <lists+linux-spi@lfdr.de>; Thu,  4 Mar 2021 02:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1451181AbhCDAal (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 3 Mar 2021 19:30:41 -0500
Received: from mga12.intel.com ([192.55.52.136]:10465 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1383743AbhCCPei (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 3 Mar 2021 10:34:38 -0500
IronPort-SDR: a5x7xISIZ7A1od43xUYuCE0HaZemxu5tg91va1k9zoia4DxZ+EzfcpV4phC0VRjzyF3JP/aLbc
 58bvKRksfdkw==
X-IronPort-AV: E=McAfee;i="6000,8403,9912"; a="166470337"
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; 
   d="scan'208,223";a="166470337"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 07:28:23 -0800
IronPort-SDR: ph8uCsay7bjJrAPSVOsWq5l1PtQYGp4S7d3qIclCiWv3Uv8Yf1/t2julLJj4Rv7rdh6oVC8o21
 PLZOfudync7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; 
   d="scan'208,223";a="506827370"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 03 Mar 2021 07:28:22 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] spi: Remove support for dangling device properties
Date:   Wed,  3 Mar 2021 18:28:14 +0300
Message-Id: <20210303152814.35070-5-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210303152814.35070-1-heikki.krogerus@linux.intel.com>
References: <20210303152814.35070-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From now on only accepting complete software nodes.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/spi/spi.c       | 24 +++---------------------
 include/linux/spi/spi.h |  4 ----
 2 files changed, 3 insertions(+), 25 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 9b46998ae2a44..016bbfbce90b7 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -676,34 +676,23 @@ struct spi_device *spi_new_device(struct spi_controller *ctlr,
 	proxy->controller_data = chip->controller_data;
 	proxy->controller_state = NULL;
 
-	if (chip->properties) {
-		status = device_add_properties(&proxy->dev, chip->properties);
-		if (status) {
-			dev_err(&ctlr->dev,
-				"failed to add properties to '%s': %d\n",
-				chip->modalias, status);
-			goto err_dev_put;
-		}
-	}
-
 	if (chip->swnode) {
 		status = device_add_software_node(&proxy->dev, chip->swnode);
 		if (status) {
 			dev_err(&ctlr->dev, "failed to add softwade node to '%s': %d\n",
 				chip->modalias, status);
-			goto err_remove_props;
+			goto err_dev_put;
 		}
 	}
 
 	status = spi_add_device(proxy);
 	if (status < 0)
-		goto err_remove_props;
+		goto err_dev_put;
 
 	return proxy;
 
-err_remove_props:
-	device_remove_software_node(&proxy->dev);
 err_dev_put:
+	device_remove_software_node(&proxy->dev);
 	spi_dev_put(proxy);
 	return NULL;
 }
@@ -764,7 +753,6 @@ static void spi_match_controller_to_boardinfo(struct spi_controller *ctlr,
  *
  * The board info passed can safely be __initdata ... but be careful of
  * any embedded pointers (platform_data, etc), they're copied as-is.
- * Device properties are deep-copied though.
  *
  * Return: zero on success, else a negative error code.
  */
@@ -784,12 +772,6 @@ int spi_register_board_info(struct spi_board_info const *info, unsigned n)
 		struct spi_controller *ctlr;
 
 		memcpy(&bi->board_info, info, sizeof(*info));
-		if (info->properties) {
-			bi->board_info.properties =
-					property_entries_dup(info->properties);
-			if (IS_ERR(bi->board_info.properties))
-				return PTR_ERR(bi->board_info.properties);
-		}
 
 		mutex_lock(&board_lock);
 		list_add_tail(&bi->list, &board_list);
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index f47f94ea6fa99..7cb3194d5ba59 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -19,7 +19,6 @@
 #include <uapi/linux/spi/spi.h>
 
 struct dma_chan;
-struct property_entry;
 struct software_node;
 struct spi_controller;
 struct spi_transfer;
@@ -1410,7 +1409,6 @@ static inline ssize_t spi_w8r16be(struct spi_device *spi, u8 cmd)
  * @modalias: Initializes spi_device.modalias; identifies the driver.
  * @platform_data: Initializes spi_device.platform_data; the particular
  *	data stored there is driver-specific.
- * @properties: Deprecated - use software node instead.
  * @swnode: Software node for the device.
  * @controller_data: Initializes spi_device.controller_data; some
  *	controllers need hints about hardware setup, e.g. for DMA.
@@ -1444,12 +1442,10 @@ struct spi_board_info {
 	 *
 	 * platform_data goes to spi_device.dev.platform_data,
 	 * controller_data goes to spi_device.controller_data,
-	 * device properties are copied and attached to spi_device,
 	 * irq is copied too
 	 */
 	char		modalias[SPI_NAME_SIZE];
 	const void	*platform_data;
-	const struct property_entry *properties;
 	const struct software_node *swnode;
 	void		*controller_data;
 	int		irq;
-- 
2.30.1

