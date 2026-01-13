Return-Path: <linux-spi+bounces-12342-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5404CD196D4
	for <lists+linux-spi@lfdr.de>; Tue, 13 Jan 2026 15:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2C3E3302523A
	for <lists+linux-spi@lfdr.de>; Tue, 13 Jan 2026 14:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC52828725D;
	Tue, 13 Jan 2026 14:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Zzw326CS"
X-Original-To: linux-spi@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013003.outbound.protection.outlook.com [40.93.196.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F417D280309;
	Tue, 13 Jan 2026 14:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768313854; cv=fail; b=AL5g8EIrfTb4V2TVcQTU1qjIpd9KpjAaQa46jYvGzZhuCflzcP5AEW49s1merW2L3v23KWgsriaXxkp3MsPW/m0YeekTsvObZb6diaoZLIULVINvhVi4rlXGHCnc7PP+aarpQoRoea2iqyakn/LEc/k1EIrhYavVgGDA/L/V/GY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768313854; c=relaxed/simple;
	bh=P3XakldvgKigYee2SW1+/M6GX6OjkSCjFkjlqpsqsfc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YGunCWpSRXb6jxIg9wkDyki/ftyIHhYjs+Z9f45vG9OvZSdeOFMb1Phz+Fhfzj8H/CYVes2HGYon0MP/ELfp5usStMcpCXCMVtW/+3dF1B/6n4EmVumcadt3uiXZA1FspdNvvZO/m/gpdJVUP8OS4mnkXnlPrJZojvzKUip4F7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Zzw326CS; arc=fail smtp.client-ip=40.93.196.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TnlmG5zDak7WssMx0AF+KgGJeEkr+FC0/7BKYdxD8p9beDlZVMw+ecZy0OjEUadXMeKaCz1IXlq3rbyNPNXdVZ3RDYQDO+2ApXyVV74ryOHBarAFXnw5f/GwaLldZpnnEnmoeQ55Ru7XrQnN5x+SXzHePhQy0Gp8lstCOxPR4PgFM7dvqeoLy7CJ6bisPpNGqJ3RYKQ0NWFqM6oe6d8n7bSZbZ1fC8hFFNvBuJPYe3lyxYLWeSW6r8sbtx0RL7xQl/rndY3HMYPjUzZa4hVzw18BqxL6C9P18Wz4BOHtRDTIpxdJb2xu/8r5JZ7x8cI3IbMBxRHLKFus52+vam9ERQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RUfWWNih7uQhjMpH4ZTdRpYb3Mzceyg+d0OFDFILlbI=;
 b=ZsVrXYTw4NbETcYh96OIst+MrlxJPoy9Z4xCl+HdQMa20lFYkL/cvaNgGZ8+MMPuHgwZn2SxUREInkeH+C5Uo9ggYiEexNRlzTOr9N3Dk1lZLiTF6ahcnOH2MsUL4UZRWNvNVZxuuIvUx4D4+F9dV2xgS3zBLSC3UD6LqIQ78kIxE1m3wIBR+bgp3pZ+VtiS3sRVbpDdTFggd4SeVZI+SOYxAhNN8CqApVsrvaLRrNfwZGz460Z5cgGrFaa8nH1eJKP3tpvJMxRouVSNw3M86r1ZpKqiorBSX99fRuYAcqd9rxGDGksPaqMsCOUENjsgmNcxeqslXhuYYqTAlEkZWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RUfWWNih7uQhjMpH4ZTdRpYb3Mzceyg+d0OFDFILlbI=;
 b=Zzw326CSa6avt8L2rpW7/p9yMBYrDBv+LT1OkoCNz8h0EKKCqhRXPHjmRk17X3AUdUZocEoaxHTGlczhfZLB1jRcbEoFkAzl4LMRAVmoTavrpF2kKoTUDwE0eFpP3zH+w76nKOCof0YIxGbOpFaf2wdPP8z3Mt6T04k3KaG4vZg=
Received: from BLAP220CA0023.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::28)
 by BY5PR10MB4321.namprd10.prod.outlook.com (2603:10b6:a03:202::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 14:17:18 +0000
Received: from BL6PEPF00022573.namprd02.prod.outlook.com
 (2603:10b6:208:32c:cafe::35) by BLAP220CA0023.outlook.office365.com
 (2603:10b6:208:32c::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Tue,
 13 Jan 2026 14:17:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BL6PEPF00022573.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Tue, 13 Jan 2026 14:17:17 +0000
Received: from DFLE215.ent.ti.com (10.64.6.73) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 13 Jan
 2026 08:16:56 -0600
Received: from DFLE211.ent.ti.com (10.64.6.69) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 13 Jan
 2026 08:16:56 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 13 Jan 2026 08:16:56 -0600
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [172.24.233.254])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60DEGLoo2381510;
	Tue, 13 Jan 2026 08:16:51 -0600
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
	<vigneshr@ti.com>, <tudor.ambarus@linaro.org>, <pratyush@kernel.org>,
	<mwalle@kernel.org>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
	<praneeth@ti.com>, <u-kumar1@ti.com>, <p-mantena@ti.com>, <a-dutta@ti.com>,
	<s-k6@ti.com>
Subject: [RFC PATCH v2 05/12] mtd: spi-nor: perform controller tuning during probe
Date: Tue, 13 Jan 2026 19:46:10 +0530
Message-ID: <20260113141617.1905039-6-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260113141617.1905039-1-s-k6@ti.com>
References: <20260113141617.1905039-1-s-k6@ti.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022573:EE_|BY5PR10MB4321:EE_
X-MS-Office365-Filtering-Correlation-Id: 047575b6-92a1-4418-795f-08de52ae74d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|34020700016|82310400026|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?znvdjdsAa/3w8IAK9aewr63Be1rwWQV2U+lYct3saVTlV1lJtMLGE8cuLhns?=
 =?us-ascii?Q?H65sBrQgCzWFowDTLvCNwim5CD6JcPUq4SQyLGvi7p5JBk4L8noCyiYH7aAX?=
 =?us-ascii?Q?BR9hXPBX138045Au+FgSjitJMFFe72tsjIFIZVFSc7o4xLQYfvevR7w5+0We?=
 =?us-ascii?Q?9Z5Yt0Jo7xK3cBC7X+YfENeGe6MT41UeOaYDeTOJiqruxPFEwgTAL+9IeY1a?=
 =?us-ascii?Q?8BDRM/qcu5srQ2gxxH8QWdsOQvvZgI5Mo22hlwQfmxO/etmhrNFxOZ2EGHdh?=
 =?us-ascii?Q?fuivWzA1HR11uYHOvACX7G0MstOlmkKsOd53nkw2efhS9R+j1lnxknfphJ0R?=
 =?us-ascii?Q?fxjwAZAzqbMTXlflcZOGPno3ylu7i7qPmvQoN1Df4lr2TJoQQZDFJr06T1+z?=
 =?us-ascii?Q?Lv+Z3bjT5wACW74YOa40UILBSSfFedog8YOP9eggEhyJOd1jelpMIqibZbyA?=
 =?us-ascii?Q?CeG6LKfOsgY29uiA4DwvZ9zP4KoxjjESok+84fZjGfP3qdX95nNCH6F7UFJV?=
 =?us-ascii?Q?78IakgxR3IcAEtdzpoZabsqU+DoBUKeO/7PvCXeN3tNVtqo1edRZd13IG/fJ?=
 =?us-ascii?Q?xjBXRfG0UAFh7yvFSsZOWn/e2iJT5oEUZoUk4HFepjehbe+kznBCR+FkwGXH?=
 =?us-ascii?Q?3EGBqtGzInu8mOy6XEfr2dhfpzx8plMqdbrCgqaJdCVc2MMub0kP9rnT89qc?=
 =?us-ascii?Q?7Mq0TNjHl3ELUUGcIKbuzAO6tOJZTWYkqtnFhYfEAQchmE8fa5F6UF79JM+W?=
 =?us-ascii?Q?r8RC8YRIyQcMVJn2lS4hsqWfey9HEPKUhnnFMTSA2Fv6shzsesE6c+HM1NQ8?=
 =?us-ascii?Q?M+K1Lr68P/+qg0Ye/WfLk5zpAgBxzStNL+29tbq5yzuNg9mXlkwgkvwsE8tV?=
 =?us-ascii?Q?+ljOdDXhFs/05QLBwfGYdBXSmgKJe2fN9ykqL8ty0WoPhuACcGxmC2ZCQSEf?=
 =?us-ascii?Q?AKM9NTvZ3MWG4M9q62JxM5yt5S+V2FXoEQ+qNbiF5eWsN5Lma7s9fTDeFsm7?=
 =?us-ascii?Q?aYsbYxyTf+ZWLV4PzgtMumOE/n6feIpErvAShspneDd/035lxEu+nRLIs8Hc?=
 =?us-ascii?Q?gHelMlZVutAlEw5Kp4xuulyw/KKBRYDjKcdgih7A+ErA+tqJmvu5lxbMfwMv?=
 =?us-ascii?Q?3BwKHZZonxGxgpqiAyZaS2S8OPJJQ8fk3L6+F3dNysOwYhZQUH1hKDg7gTVT?=
 =?us-ascii?Q?Jh20BJUHmhNXPsh1ndtjhJ2QhaMFgmt3W0+ZYCDcDUbCWqrJiyn8n+YRju0Q?=
 =?us-ascii?Q?vEbWqjfrkV9eqg0MO1RzNU6mx0Hs0thrPzj07zNRm8QH8msfRB6EBwCO2yiE?=
 =?us-ascii?Q?XoDQgEm4ft25pSlhdCxgtI53SYboRILgkpsKHxAE2AqCgO8IBQO2dGj6LWzq?=
 =?us-ascii?Q?UGeDyGayYcrEl3RP+GApvHstPQShGjnLUPzFdM86p87PLbqEOR0XhoFks6tw?=
 =?us-ascii?Q?xgbwxw6ZQxL/aflBiNb/YkKaUFBa1O19yJgT26j+UEJACyM1oE8v7bBUDFjz?=
 =?us-ascii?Q?NibnNLgpRjz7u1TY1hhU6EylDx86Xx4rW2A1e3o7MC2vpiFv/AX311jVZxfE?=
 =?us-ascii?Q?yqI+sZX522u/Ja8TMGNGDxdqye+3Q9fF5b1kzFvq?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700013)(34020700016)(82310400026)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 14:17:17.0137
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 047575b6-92a1-4418-795f-08de52ae74d9
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022573.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4321

SPI controllers may need tuning for reliable high-speed operation.
Without it, controllers use conservative timing that limits performance.

Call spi_mem_execute_tuning() during probe to optimize timing for
the device's read operation. Failures are non-fatal as controllers
fall back to default timing.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/mtd/spi-nor/core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 63f3051d7a6b..d69cb8eaad83 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -3704,6 +3704,7 @@ static int spi_nor_probe(struct spi_mem *spimem)
 	struct device *dev = &spi->dev;
 	struct flash_platform_data *data = dev_get_platdata(dev);
 	struct spi_nor *nor;
+	struct spi_mem_op read_op;
 	/*
 	 * Enable all caps by default. The core will mask them after
 	 * checking what's really supported using spi_mem_supports_op().
@@ -3773,6 +3774,16 @@ static int spi_nor_probe(struct spi_mem *spimem)
 	if (ret)
 		return ret;
 
+	read_op = spi_nor_spimem_get_read_op(nor);
+	ret = spi_mem_execute_tuning(spimem, &read_op, NULL);
+	if (ret && ret != -EOPNOTSUPP) {
+		dev_warn(dev, "Failed to execute PHY tuning: %d\n", ret);
+		/*
+		 * Tuning failure is non-fatal; the controller falls back to
+		 * default timing, reducing speed but ensuring operation.
+		 */
+	}
+
 	return mtd_device_register(&nor->mtd, data ? data->parts : NULL,
 				   data ? data->nr_parts : 0);
 }
-- 
2.34.1


