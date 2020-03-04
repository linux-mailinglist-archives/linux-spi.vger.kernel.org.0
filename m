Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90B0B178F71
	for <lists+linux-spi@lfdr.de>; Wed,  4 Mar 2020 12:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387751AbgCDLSC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 4 Mar 2020 06:18:02 -0500
Received: from mail-db8eur05on2117.outbound.protection.outlook.com ([40.107.20.117]:17953
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387488AbgCDLSB (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 4 Mar 2020 06:18:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nNkLO6okuSlfBblzjKHWxnSo4VrpIyYpfIKh8vgwQYsBG/t/HaLiwAINrZgoGfeoSe1hKdzcKzuZJTMdk8oNS0GXC/ciJrZJKfqjrOkP5YLuvRbVJuMhuwHrI78TSm+cvWpCju2uCN0Ha3oYWcO8TiOiO0OYfcdm+T7hzgUjEWTszbZej40ltEIl7gGXWHJSp8AcqXeok5rPTaKMwaaRREJtYzfvEHqZ+ERX5JLudeFTKZRFZIZKM0Tbi0/YBshR36enE8YBSKUsZgF3AEDIaz7b/my9pqxgkjDIUWdQWKe4Me5x5mhznVP0934bS9VnXUZcvGpFa5+2RmlZgHo+Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nRjKmxvKahZusgK/nxLKQ03jFcuBZyHmlBuOM4g34+8=;
 b=GFby5gV04QEIH6aQTzTuHFMcOAcWUeuQya/xL332VH8ooaF2YvwDEMZOb+gck+eBliPqVWieBei1uHD1i0LoiX6XIP8A7sF6zJ6JwsYHd9pOgZPtP4cjxaNMkO/IzJeknAzSa5FQMURWglDc395FMfWEP04oAJxZoJZFYkW1idw6QJNcpbJKXTET9oVZQcBzQjNhXrZZHF+sJI1HVcK/AZfRX5I4fm7b8QQHD9EKz4jgQZgjswAFlB/VnV6KvdEziS1r59pmxysDHlXFqX1SdxiFZGN3//VkqFoTG1MCgw97TWFFuCnACzNSuF28mQJ5JBx5sQt1KsMBoOcr4vSUwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nRjKmxvKahZusgK/nxLKQ03jFcuBZyHmlBuOM4g34+8=;
 b=BlKPKuyOOzaqKsHcnRgdaqWzYLBOVWWAk2lix+l+gaIUHpdW3qeizvy2O39HckM7W3ZkLRN6oWLv8gw9ZXQPReGR6bGlvbMeCtcITWooLlkqY4gLUeGPRHqZDTPcmy42KGfKc8IxGS/aiEt4VlvC894uHI0ZguemNK2tdCGgRQk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aaro.koskinen@nokia.com; 
Received: from VI1PR07MB6174.eurprd07.prod.outlook.com (20.178.9.83) by
 VI1PR07MB4000.eurprd07.prod.outlook.com (52.134.25.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.9; Wed, 4 Mar 2020 11:17:47 +0000
Received: from VI1PR07MB6174.eurprd07.prod.outlook.com
 ([fe80::7514:700c:669b:3c8f]) by VI1PR07MB6174.eurprd07.prod.outlook.com
 ([fe80::7514:700c:669b:3c8f%7]) with mapi id 15.20.2793.011; Wed, 4 Mar 2020
 11:17:47 +0000
From:   aaro.koskinen@nokia.com
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: [PATCH] spi: spi_register_controller(): free bus id on error paths
Date:   Wed,  4 Mar 2020 13:17:40 +0200
Message-Id: <20200304111740.27915-1-aaro.koskinen@nokia.com>
X-Mailer: git-send-email 2.11.0
Content-Type: text/plain
X-ClientProxiedBy: HE1PR0802CA0003.eurprd08.prod.outlook.com
 (2603:10a6:3:bd::13) To VI1PR07MB6174.eurprd07.prod.outlook.com
 (2603:10a6:803:a5::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ak-desktop.emea.nsn-net.net (131.228.2.28) by HE1PR0802CA0003.eurprd08.prod.outlook.com (2603:10a6:3:bd::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14 via Frontend Transport; Wed, 4 Mar 2020 11:17:46 +0000
X-Mailer: git-send-email 2.11.0
X-Originating-IP: [131.228.2.28]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6babef46-ed13-4e9a-4dac-08d7c02daac1
X-MS-TrafficTypeDiagnostic: VI1PR07MB4000:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR07MB4000335C7583E449E715A81EF4E50@VI1PR07MB4000.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1332;
X-Forefront-PRVS: 0332AACBC3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(39860400002)(136003)(396003)(346002)(376002)(199004)(189003)(316002)(81156014)(6506007)(5660300002)(1076003)(478600001)(107886003)(81166006)(66946007)(2616005)(956004)(2906002)(52116002)(8936002)(6486002)(8676002)(66556008)(86362001)(6512007)(26005)(36756003)(16526019)(186003)(66476007)(9686003)(6666004)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR07MB4000;H:VI1PR07MB6174.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PF+x1/4cHJcTkkkhq1QpuLUJwNDhquuo76Sat9SJ+KzULwCZxkL2h9rB7+IkqsamNfqJhPoNZ4/z8Elp7XkH7SlvQMFj2KmjLD9xkM1MUIMDAiQ2oiE6a9A8xrvTbhROGyJd1moLA+oD8zvNfu/SHR3MR+6SFBdOrgRBwpTk/BVMU9PtSV2QofWhu01io8T5nNn2nAkGfiSTlZBVAj6mYNQbMdu0ARHiFS1Gu4/Y0naqxq+ple/J/pL0P0BRvIOw5TFZ/tTwUDZineztDnYdpfSySI6pJ71FFw1fdJcigOikcdptky+y4q4TaD8PhLIe0LGrvoj7QpBSBo6kNNg6JprTUnQaqg1QbV1YFqQkzxHnUGjgBZ7ma8ciDF4c5FxJKpS6Z+4qnGftHZasUFHPIQD4QSOFDASNVIh+mP81C1lD+qkEru2pdyIiTgDlBuCi
X-MS-Exchange-AntiSpam-MessageData: dnllcsd9VJCrQAH4kDNH7cHsteKJ0jUpFJeaiM59i7sjp0vng4vHNNnyzIlmO6FIbBtPzuG4cvFR/VDCcPEOmMIqTtVswSJRsTmkY7CBACbCEHjYJyoEk9gXzOhs8wYayy8ZwyIu9AewQdXFWyChtQ==
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6babef46-ed13-4e9a-4dac-08d7c02daac1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2020 11:17:46.9349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SAoFH3NlF6PdlLL7ZHyS+svO4c1cZdZmq8PTC5Kt7Y94mo0T47XcGmSdhLoNCI3PerEJnINFU777OAqKpFvwPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB4000
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Aaro Koskinen <aaro.koskinen@nokia.com>

Some error paths leave the bus id allocated. As a result the IDR
allocation will fail after a deferred probe. Fix by freeing the bus id
always on error.

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
---
 drivers/spi/spi.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 38b4c78df506..755221bc3745 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2639,7 +2639,7 @@ int spi_register_controller(struct spi_controller *ctlr)
 		if (ctlr->use_gpio_descriptors) {
 			status = spi_get_gpio_descs(ctlr);
 			if (status)
-				return status;
+				goto free_bus_id;
 			/*
 			 * A controller using GPIO descriptors always
 			 * supports SPI_CS_HIGH if need be.
@@ -2649,7 +2649,7 @@ int spi_register_controller(struct spi_controller *ctlr)
 			/* Legacy code path for GPIOs from DT */
 			status = of_spi_get_gpio_numbers(ctlr);
 			if (status)
-				return status;
+				goto free_bus_id;
 		}
 	}
 
@@ -2657,17 +2657,14 @@ int spi_register_controller(struct spi_controller *ctlr)
 	 * Even if it's just one always-selected device, there must
 	 * be at least one chipselect.
 	 */
-	if (!ctlr->num_chipselect)
-		return -EINVAL;
+	if (!ctlr->num_chipselect) {
+		status = -EINVAL;
+		goto free_bus_id;
+	}
 
 	status = device_add(&ctlr->dev);
-	if (status < 0) {
-		/* free bus id */
-		mutex_lock(&board_lock);
-		idr_remove(&spi_master_idr, ctlr->bus_num);
-		mutex_unlock(&board_lock);
-		goto done;
-	}
+	if (status < 0)
+		goto free_bus_id;
 	dev_dbg(dev, "registered %s %s\n",
 			spi_controller_is_slave(ctlr) ? "slave" : "master",
 			dev_name(&ctlr->dev));
@@ -2683,11 +2680,7 @@ int spi_register_controller(struct spi_controller *ctlr)
 		status = spi_controller_initialize_queue(ctlr);
 		if (status) {
 			device_del(&ctlr->dev);
-			/* free bus id */
-			mutex_lock(&board_lock);
-			idr_remove(&spi_master_idr, ctlr->bus_num);
-			mutex_unlock(&board_lock);
-			goto done;
+			goto free_bus_id;
 		}
 	}
 	/* add statistics */
@@ -2702,7 +2695,12 @@ int spi_register_controller(struct spi_controller *ctlr)
 	/* Register devices from the device tree and ACPI */
 	of_register_spi_devices(ctlr);
 	acpi_register_spi_devices(ctlr);
-done:
+	return status;
+
+free_bus_id:
+	mutex_lock(&board_lock);
+	idr_remove(&spi_master_idr, ctlr->bus_num);
+	mutex_unlock(&board_lock);
 	return status;
 }
 EXPORT_SYMBOL_GPL(spi_register_controller);
-- 
2.11.0

