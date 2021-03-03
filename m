Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA63E32C6F4
	for <lists+linux-spi@lfdr.de>; Thu,  4 Mar 2021 02:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1451169AbhCDAaf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 3 Mar 2021 19:30:35 -0500
Received: from mga12.intel.com ([192.55.52.136]:9923 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1382291AbhCCPcz (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 3 Mar 2021 10:32:55 -0500
IronPort-SDR: Sr5U72FaFhAHhm35sbOm3TRTXJ0ZNDLk4NLeiOHPVNxXbuUI+WWRC6RnrdEjhG/F7UAAmmAInF
 Kv5nrx9zsC8g==
X-IronPort-AV: E=McAfee;i="6000,8403,9912"; a="166470333"
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; 
   d="scan'208";a="166470333"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 07:28:19 -0800
IronPort-SDR: 9TojOpu288DBEoJ1hIQQD7edse9fAKl+VRX8EUfAvWnbqN2vb6dbCTMtuJoyFJd8xWPdZkTItA
 PQFaACRwY2Kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; 
   d="scan'208";a="506827350"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 03 Mar 2021 07:28:18 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH 2/4] ARM: pxa: icontrol: Constify the software node
Date:   Wed,  3 Mar 2021 18:28:12 +0300
Message-Id: <20210303152814.35070-3-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210303152814.35070-1-heikki.krogerus@linux.intel.com>
References: <20210303152814.35070-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

When device properties are supplied to the devices, in
reality a software fwnode that holds those properties is
created which is then assigned to the device. If the device
properties are constant the software node can also be
constant.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Daniel Mack <daniel@zonque.org>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>
---
 arch/arm/mach-pxa/icontrol.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-pxa/icontrol.c b/arch/arm/mach-pxa/icontrol.c
index 151e26ec06968..04a12523cdee0 100644
--- a/arch/arm/mach-pxa/icontrol.c
+++ b/arch/arm/mach-pxa/icontrol.c
@@ -74,13 +74,17 @@ static const struct property_entry mcp251x_properties[] = {
 	{}
 };
 
+static const struct software_node mcp251x_node = {
+	.properties = mcp251x_properties,
+};
+
 static struct spi_board_info mcp251x_board_info[] = {
 	{
 		.modalias        = "mcp2515",
 		.max_speed_hz    = 6500000,
 		.bus_num         = 3,
 		.chip_select     = 0,
-		.properties      = mcp251x_properties,
+		.swnode		 = &mcp251x_node,
 		.controller_data = &mcp251x_chip_info1,
 		.irq             = PXA_GPIO_TO_IRQ(ICONTROL_MCP251x_nIRQ1)
 	},
@@ -89,7 +93,7 @@ static struct spi_board_info mcp251x_board_info[] = {
 		.max_speed_hz    = 6500000,
 		.bus_num         = 3,
 		.chip_select     = 1,
-		.properties      = mcp251x_properties,
+		.swnode		 = &mcp251x_node,
 		.controller_data = &mcp251x_chip_info2,
 		.irq             = PXA_GPIO_TO_IRQ(ICONTROL_MCP251x_nIRQ2)
 	},
@@ -98,7 +102,7 @@ static struct spi_board_info mcp251x_board_info[] = {
 		.max_speed_hz    = 6500000,
 		.bus_num         = 4,
 		.chip_select     = 0,
-		.properties      = mcp251x_properties,
+		.swnode		 = &mcp251x_node,
 		.controller_data = &mcp251x_chip_info3,
 		.irq             = PXA_GPIO_TO_IRQ(ICONTROL_MCP251x_nIRQ3)
 	},
@@ -107,7 +111,7 @@ static struct spi_board_info mcp251x_board_info[] = {
 		.max_speed_hz    = 6500000,
 		.bus_num         = 4,
 		.chip_select     = 1,
-		.properties      = mcp251x_properties,
+		.swnode		 = &mcp251x_node,
 		.controller_data = &mcp251x_chip_info4,
 		.irq             = PXA_GPIO_TO_IRQ(ICONTROL_MCP251x_nIRQ4)
 	}
-- 
2.30.1

