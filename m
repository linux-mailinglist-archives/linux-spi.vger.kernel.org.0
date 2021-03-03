Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C01A932C6F6
	for <lists+linux-spi@lfdr.de>; Thu,  4 Mar 2021 02:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382993AbhCDAah (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 3 Mar 2021 19:30:37 -0500
Received: from mga12.intel.com ([192.55.52.136]:10027 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1383742AbhCCPei (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 3 Mar 2021 10:34:38 -0500
IronPort-SDR: iLUVgTYScuyBvtvHIkb3AIQ4UWMdh5lHw3sDzOAvlY+kGpzHKbmqm3g822H/EXjTamSk0ELuhP
 Y3MCxcxNOqlA==
X-IronPort-AV: E=McAfee;i="6000,8403,9912"; a="166470335"
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; 
   d="scan'208";a="166470335"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 07:28:22 -0800
IronPort-SDR: RPt4lLlzu2fWIoJ14T40IJ8a65oWBlAzUlHbEBWqxWJX18Vw2WSdZLl2iWu2T/bgfWWTxE2LxV
 PZXGQiNdQ9OA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; 
   d="scan'208";a="506827357"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 03 Mar 2021 07:28:20 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH 3/4] ARM: pxa: zeus: Constify the software node
Date:   Wed,  3 Mar 2021 18:28:13 +0300
Message-Id: <20210303152814.35070-4-heikki.krogerus@linux.intel.com>
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
 arch/arm/mach-pxa/zeus.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-pxa/zeus.c b/arch/arm/mach-pxa/zeus.c
index b27fc7ac9ceab..97700429633ee 100644
--- a/arch/arm/mach-pxa/zeus.c
+++ b/arch/arm/mach-pxa/zeus.c
@@ -433,10 +433,14 @@ static const struct property_entry mcp251x_properties[] = {
 	{}
 };
 
+static const struct software_node mcp251x_node = {
+	.properties = mcp251x_properties,
+};
+
 static struct spi_board_info zeus_spi_board_info[] = {
 	[0] = {
 		.modalias	= "mcp2515",
-		.properties	= mcp251x_properties,
+		.swnode		= &mcp251x_node,
 		.irq		= PXA_GPIO_TO_IRQ(ZEUS_CAN_GPIO),
 		.max_speed_hz	= 1*1000*1000,
 		.bus_num	= 3,
-- 
2.30.1

