Return-Path: <linux-spi+bounces-10335-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B33BA87EA
	for <lists+linux-spi@lfdr.de>; Mon, 29 Sep 2025 10:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23ED9189D497
	for <lists+linux-spi@lfdr.de>; Mon, 29 Sep 2025 09:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C642C2359;
	Mon, 29 Sep 2025 08:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="OOOFs7ke"
X-Original-To: linux-spi@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11020113.outbound.protection.outlook.com [52.101.46.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E714238175;
	Mon, 29 Sep 2025 08:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759136323; cv=fail; b=glbDHst1c7j8+1Sg8E5WgN0VN/I+2kCGNkrC+S8ZSGepaD9p4TcwSa1YV1hMARkZW3It7x3/0yN8q3gHx7on3Ib6frtg42FipwKamrIyLd9VeIXXjBllGgyH03/PvkwrOq9j8oxmyEF9cmghQCnvXjHEfD8xG9F6SwLJ/W4KCro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759136323; c=relaxed/simple;
	bh=emVIYs6RKFop3XhOs+dTvVea6UlNKQsQa3c87T0ycCE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O/uEOqG8ZBaf2+FuRaTiGLu0LIPudfHmvUxdgfCAphnnazZDtQS14TuPnn0P9baYRTsAKaVsymMHC0RhF6+wqz9TJT61UG6QAM9p83+jLRI7mO97EyPwxFBELzXJioj+Y9DJ8s9MV1riTkZgGQYnLLFfm45mvsVNhpvuI6GbX7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=OOOFs7ke; arc=fail smtp.client-ip=52.101.46.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tuPkKTGhDdpZI2gHIIUNJG3pwQJKkHrfmUTytGFEs8Kr8CyooXa2DkG2pqGxksvZRynprlXMsaW97TVPxAR9t09BhEfJDL5wqwcZ7iTgFG+2odyo0OsDOeqyA0DZfbRKskkvS5W+i9WGN87oe8NMaB2kG8bH1nGn4qIbZmMxiCc1PAmrgZxoME/jzotq9pJxfqtOj4TiZQTr0Eo6QqY5SeOQUwwNf/oDJEQntdg3RkG1KlOpdkgl/Qsq6rOPiuTcEGMe5j+C20irwQ2pBRNbUqymuAC/Pfxn0uiYPHYadHHKg1ZKixQn0pHP8EGmLSzZsfw0ExSGiT9RXyy6/9T0Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yXJzzMlgD5R09KT692YcsjDku0hOA+/hOlkX7ZhJFjs=;
 b=xRW6DPJIRMxj2An4d600o24C6B8aer0beyB0tlTAH2dh/ch+69rgnQ8A6kaGDTi7e+e5tTLRqq9NILggGf++adOd9Ye3Gn3HM+e50P+FBXdocXueVExxxZzpzKa/qMjy1c20ewVdv4IWWvS2JLdTtB69p4FeZjVsgTVoHGdPH3J0WkeV3iug2aUbV4EMO4+GKZFJzX+Rkv1BOid4feGLDLNnvqKO8UZWqtBCI2JIKQNmAYaBFEwTbIsdPFjyYPN5XA5DpXtAOYWTkKQOyV5Dj64Xs/HL+GL5ubZNmIEWYyFcVvw2JMAbXnN63EnmuIfrxXO8RBvw6ZK9r6mD+OyDAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 50.233.182.194) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=axiado.com; dmarc=none action=none header.from=axiado.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yXJzzMlgD5R09KT692YcsjDku0hOA+/hOlkX7ZhJFjs=;
 b=OOOFs7kec+/2e/RVwHHb+Ziud97FGtNDYtJAQcxb9wWPUN96OlNFtSDNYbvWRwnajNK3XH5pwTtF0Vf31QG3ZhotF/7BpHCeJRZoKohTRim6SEa2mMSW4Jxn4+h7FDMLUWpOVwYABhxSiTPZ2sDjuGB13COHc1Frd0jtdA3B9yltAiGe1TVxbIo5u84wu9iMfid8V/CUZi+siv0wBTOCgTOWBrqHM02dX1cQJdeVIw0raL5Ez5uTRUI3WLriGo9iFo8H2BrPevqnneUDce7SNklghMZdrJsyDmEmpBJgvD/bw7/8QGBvPyOBoN0SKTsu5Km6M7wLnaTpujONea/GHg==
Received: from BYAPR07CA0080.namprd07.prod.outlook.com (2603:10b6:a03:12b::21)
 by PH0PR18MB4765.namprd18.prod.outlook.com (2603:10b6:510:cd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Mon, 29 Sep
 2025 08:58:35 +0000
Received: from SJ5PEPF000001E9.namprd05.prod.outlook.com
 (2603:10b6:a03:12b:cafe::be) by BYAPR07CA0080.outlook.office365.com
 (2603:10b6:a03:12b::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.17 via Frontend Transport; Mon,
 29 Sep 2025 08:58:34 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 50.233.182.194)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 50.233.182.194 as permitted sender)
 receiver=protection.outlook.com; client-ip=50.233.182.194;
 helo=vm-swbuild15.axiadord;
Received: from vm-swbuild15.axiadord (50.233.182.194) by
 SJ5PEPF000001E9.mail.protection.outlook.com (10.167.242.197) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.9
 via Frontend Transport; Mon, 29 Sep 2025 08:58:34 +0000
From: Vladimir Moravcevic <vmoravcevic@axiado.com>
Date: Mon, 29 Sep 2025 01:58:02 -0700
Subject: [PATCH v2 2/3] spi: axiado: Add driver for Axiado SPI DB
 controller
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250929-axiado-ax3000-soc-spi-db-controller-driver-v2-2-b0c089c3ba81@axiado.com>
References: <20250929-axiado-ax3000-soc-spi-db-controller-driver-v2-0-b0c089c3ba81@axiado.com>
In-Reply-To: <20250929-axiado-ax3000-soc-spi-db-controller-driver-v2-0-b0c089c3ba81@axiado.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>, 
 Tzu-Hao Wei <twei@axiado.com>, 
 Axiado Reviewers <linux-maintainer@axiado.com>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Vladimir Moravcevic <vmoravcevic@axiado.com>, 
 Prasad Bolisetty <pbolisetty@axiado.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759136313; l=40355;
 i=vmoravcevic@axiado.com; s=20250904; h=from:subject:message-id;
 bh=emVIYs6RKFop3XhOs+dTvVea6UlNKQsQa3c87T0ycCE=;
 b=GtEwUmFn2036xYzMQt7l+SEb1vN1Y5Hom5AJHhVNUJJxwOixAqfR5dlh4MN7XPQ2yXInzdB6f
 AVa+7SUOPpWCMs/XvhTkCUJoJhaRzbWhn7B3ePmTTLtcetRO5mEqzhZ
X-Developer-Key: i=vmoravcevic@axiado.com; a=ed25519;
 pk=iiyhWhM1F4HlCbbW3I3qKZhPCE8JsCrDQMgCBRg4YMA=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E9:EE_|PH0PR18MB4765:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b6b76aa-2345-418a-8717-08ddff365f54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZUpaRWhMS2lheURHYys4RUFZVXd1V0l6RWhaLzdvTXJvR3JYcmVvTzBjalVt?=
 =?utf-8?B?R2NoazRYclhFaHlzM2JxcTVPTCtBRVFodmVQZkk5aitaV045eURtSEhQQjh5?=
 =?utf-8?B?S0E2Yk1QaTBYNHBMOFBoQ21tV2ZJUzdvK21kK2Rmcis5SXVDb3M2Z3hPZ2ln?=
 =?utf-8?B?SUZCWENRQTg5b1ZQRnZyaUJ5RTBTVFk1amovTVIweDZKQlJoRXQ3MUl3OGRN?=
 =?utf-8?B?MFN4ZDgvUFEvZ1puQWRwdVJWOEYyNlhHeE1hNXpXUGZ1L0EvZVpXOERBUXZR?=
 =?utf-8?B?elpJKzlKQUZlVWpZekt4UmxvbFArT1dmTXFoMGdTUEtuVDBhenF2UFVaY0RH?=
 =?utf-8?B?b25wZnVrM05mbERYSHUzSThwOXNrbDVJd2pROFJVRExaYmd4a3NTdWZDLzIr?=
 =?utf-8?B?K1BmcGFtbkg5QXoxZ2o1RFI1UENiNlFITkhtallJbXcrTTM2cVMxeXJSbFpa?=
 =?utf-8?B?SDNGKzR0SEhUUUJWdUpuY1Vid0NqazVUbENVKzY4dFpwaFJ6SnRGY1lIYWxP?=
 =?utf-8?B?VUNvdXFPMW4wZ3REb0JzeitSV1gwbllOTDE0NHg5UElyRFlVWGUxamZWV1ho?=
 =?utf-8?B?L2dBbjNnY3JnMjlWbjBxNnFMaDdGOVM3MllBSmV3V1BuUk1Da3ZsQ3RydGda?=
 =?utf-8?B?cVN2aHJ3UWNYWlF3dDY2N2lORzJieUtSbHdJTU10RmdRVXU2bkg2ZUVxb1Y3?=
 =?utf-8?B?b1pEbkt2Z2JBcG9kNklUV0o2Yy92Sk1wQ1M4dlordXhxYTlvdlBQbC9kZTZy?=
 =?utf-8?B?d1V2UE10cVNXTU16RzNqWnJiUkFEdWd0dDhIUUozY2ZKbEZIR1ZXY0dObnlB?=
 =?utf-8?B?aldoYktsQkI4TC8yOHg1UjNGUzBQcTlNam5KUHAxaHlkRDRYcDZjdnNJbEtq?=
 =?utf-8?B?Vld1bnRJdXVZUVNvQ3VlNldwZDgwUEFzeXg1a3dNL0tPWmQwaTB6MzlwZDlL?=
 =?utf-8?B?RG9RNDZGaFNkWVhtWlVIOUVtUnR6cFdhZHp1TERzY2tveEFnMmxoUlVldFU0?=
 =?utf-8?B?RStxMWI3WmxkdGFwR3BVTmxQWkwrTFo2YW5VTWd1eGZhMlI4TGZlTmRoOTRO?=
 =?utf-8?B?VHYrNjA0M1o5TFJrSWlHbDRENHgvNG13L3JQL2poTkpmS0RrNHViN2pPZHhv?=
 =?utf-8?B?NnJFNzFRZENoVHkwMW5HcGEzU3NWbk9WclUrdnR1SlZwZHpFVU1WcXZBZFF5?=
 =?utf-8?B?dytkdFBqRGx6bmNNS3NwU3J3TUtNSlZaclkvd1RybitCTDNxYXR2T2NOOGhF?=
 =?utf-8?B?Q2xFYXc0bmRwVThUS21ueTNkR1c1VzJpdEJSekxtbmRzME5IeVNsdlpud1RV?=
 =?utf-8?B?RXE0Q0NsdGE2aGQyS25tMWhXM0ZHRnRocWdIRWV3OUphZS82UzNrUzNDUTdO?=
 =?utf-8?B?a2hVT0Z5aVg5cGkyN0d1UlY4OVlJb0lhZi8ybWJEQnpWTkpBS0pkakdnQlEy?=
 =?utf-8?B?NkZ0Zi94NWR4SnFRdVJ2SHNSZDl3NWdmQUFlcjNkL1RiNW0rcUYwVkdyUzhi?=
 =?utf-8?B?V1BnV2Q2WHZEdUovOEx5Snozb3FyWURXbWtiT29LWC9XSldjdmRyUDlmN0NY?=
 =?utf-8?B?UnFpTk80azFPU0EwRVlXOE5Ud0xhQ0l5bTA3MDhhZFdKeVZWT2NJYnlBSDZv?=
 =?utf-8?B?QlRGd2ovZHVRMkVicktqdDVlemlTcjk0UldCekVSL3dXMk8yTE44dk1LQ1BV?=
 =?utf-8?B?ZEx3U2xCZjA5SXlXQndIQ1ZyRmdJVTFwQnIwT1FOUzNYd2lLRktFL2NxVTcz?=
 =?utf-8?B?Z1FDNG5tZWo3ZW5GaTNkOVNXT0dtc1loU2kxZitFUGJCTmh1Sk1EU1B4Q05Z?=
 =?utf-8?B?R05xZGlKUzd3NlNaUjJtSzNkeFBSTWZrUXQ4R24rbDlNYUZ4YVA4c1FnZmRv?=
 =?utf-8?B?MzIrQ0dpbkdLMy9zMzdzZlhjaUVDWUlaSjFaTWFiQXZlM1FTVUF4RVFMb2F6?=
 =?utf-8?B?Qjk4cncybEJ3UlcvTkcxM242RERld1lOYXQ1QjByQ2dCSVdrakE3Q2RhL3R0?=
 =?utf-8?B?bHFjRkFjWlRMVlo1aURSbkVUakIwcmY2eXA1U0x5UjFzM29pRlgvYWY4K0ln?=
 =?utf-8?B?L0hiYkkvb0wvek5NZk9qTXRqTC93QWZEK0IwQmNhbThVUzlFNkxsNEltMGV2?=
 =?utf-8?Q?BGgk=3D?=
X-Forefront-Antispam-Report:
	CIP:50.233.182.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:vm-swbuild15.axiadord;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 08:58:34.8656
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b6b76aa-2345-418a-8717-08ddff365f54
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7;Ip=[50.233.182.194];Helo=[vm-swbuild15.axiadord]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB4765

The Axiado SPI controller is present in AX3000 SoC and Evaluation Board.
This controller is operating in Host only mode.

Signed-off-by: Vladimir Moravcevic <vmoravcevic@axiado.com>
Signed-off-by: Prasad Bolisetty <pbolisetty@axiado.com>
---
 drivers/spi/Kconfig      |   10 +
 drivers/spi/Makefile     |    1 +
 drivers/spi/spi-axiado.c | 1029 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/spi/spi-axiado.h |  129 ++++++
 4 files changed, 1169 insertions(+)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 891729c9c5642a08212a0080db619512c5b57bbd..1e6443f5272a4b239542ea93a94b53693c1c51f4 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -194,6 +194,16 @@ config SPI_AXI_SPI_ENGINE
 	  It is part of the SPI Engine framework that is used in some Analog Devices
 	  reference designs for FPGAs.
 
+config SPI_AXIADO
+	tristate "Axiado DB-H SPI controller"
+	depends on SPI_MEM
+	help
+	  This enables support for the SPI controller found on AX3000 SoC.
+
+	  The implementation supports host-only mode and does not provide target
+	  functionality. It is intended for use cases where the SoC acts as the SPI
+	  host, communicating with peripheral devices such as flash memory.
+
 config SPI_BCM2835
 	tristate "BCM2835 SPI controller"
 	depends on GPIOLIB
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 062c85989c8c9652822ec377228398249dd2304b..7f1e7bf3dce41789e3d2ef31c0f78609d403f8ca 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -31,6 +31,7 @@ obj-$(CONFIG_SPI_AT91_USART)		+= spi-at91-usart.o
 obj-$(CONFIG_SPI_ATH79)			+= spi-ath79.o
 obj-$(CONFIG_SPI_AU1550)		+= spi-au1550.o
 obj-$(CONFIG_SPI_AXI_SPI_ENGINE)	+= spi-axi-spi-engine.o
+obj-$(CONFIG_SPI_AXIADO)		+= spi-axiado.o
 obj-$(CONFIG_SPI_BCM2835)		+= spi-bcm2835.o
 obj-$(CONFIG_SPI_BCM2835AUX)		+= spi-bcm2835aux.o
 obj-$(CONFIG_SPI_BCM63XX)		+= spi-bcm63xx.o
diff --git a/drivers/spi/spi-axiado.c b/drivers/spi/spi-axiado.c
new file mode 100644
index 0000000000000000000000000000000000000000..b3335610ffea6b0d956521220d8ae917bd4fde9d
--- /dev/null
+++ b/drivers/spi/spi-axiado.c
@@ -0,0 +1,1029 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Axiado SPI controller driver (Host mode only)
+ *
+ * Copyright (C) 2022-2025 Axiado Corporation (or its affiliates). All rights reserved.
+ *
+ */
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of_irq.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/spi-mem.h>
+#include <linux/sizes.h>
+
+#include "spi-axiado.h"
+
+/**
+ * ax_spi_read - Register Read - 32 bit per word
+ * @xspi:	Pointer to the ax_spi structure
+ * @offset:	Register offset address
+ *
+ * @return:	Returns the value of that register
+ */
+static inline u32 ax_spi_read(struct ax_spi *xspi, u32 offset)
+{
+	return readl_relaxed(xspi->regs + offset);
+}
+
+/**
+ * ax_spi_write - Register write - 32 bit per word
+ * @xspi:	Pointer to the ax_spi structure
+ * @offset:	Register offset address
+ * @val:	Value to write into that register
+ */
+static inline void ax_spi_write(struct ax_spi *xspi, u32 offset, u32 val)
+{
+	writel_relaxed(val, xspi->regs + offset);
+}
+
+/**
+ * ax_spi_write_b - Register Read - 8 bit per word
+ * @xspi:	Pointer to the ax_spi structure
+ * @offset:	Register offset address
+ * @val:	Value to write into that register
+ */
+static inline void ax_spi_write_b(struct ax_spi *xspi, u32 offset, u8 val)
+{
+	writeb_relaxed(val, xspi->regs + offset);
+}
+
+/**
+ * ax_spi_init_hw - Initialize the hardware and configure the SPI controller
+ * @xspi:	Pointer to the ax_spi structure
+ *
+ * * On reset the SPI controller is configured to be in host mode.
+ * In host mode baud rate divisor is set to 4, threshold value for TX FIFO
+ * not full interrupt is set to 1 and size of the word to be transferred as 8 bit.
+ *
+ * This function initializes the SPI controller to disable and clear all the
+ * interrupts, enable manual target select and manual start, deselect all the
+ * chip select lines, and enable the SPI controller.
+ */
+static void ax_spi_init_hw(struct ax_spi *xspi)
+{
+	u32 reg_value;
+
+	/* Clear CR1 */
+	ax_spi_write(xspi, AX_SPI_CR1, AX_SPI_CR1_CLR);
+
+	/* CR1 - CPO CHP MSS SCE SCR */
+	reg_value = ax_spi_read(xspi, AX_SPI_CR1);
+	reg_value |= AX_SPI_CR1_SCR | AX_SPI_CR1_SCE;
+
+	ax_spi_write(xspi, AX_SPI_CR1, reg_value);
+
+	/* CR2 - MTE SRD SWD SSO */
+	reg_value = ax_spi_read(xspi, AX_SPI_CR2);
+	reg_value |= AX_SPI_CR2_SWD | AX_SPI_CR2_SRD;
+
+	ax_spi_write(xspi, AX_SPI_CR2, reg_value);
+
+	/* CR3 - Reserverd bits S3W SDL */
+	ax_spi_write(xspi, AX_SPI_CR3, AX_SPI_CR3_SDL);
+
+	/* SCDR - Reserved bits SCS SCD */
+	ax_spi_write(xspi, AX_SPI_SCDR, (AX_SPI_SCDR_SCS | AX_SPI_SCD_DEFAULT));
+
+	/* IMR */
+	ax_spi_write(xspi, AX_SPI_IMR, AX_SPI_IMR_CLR);
+
+	/* ISR - Clear all the interrupt */
+	ax_spi_write(xspi, AX_SPI_ISR, AX_SPI_ISR_CLR);
+}
+
+/**
+ * ax_spi_chipselect - Select or deselect the chip select line
+ * @spi:	Pointer to the spi_device structure
+ * @is_high:	Select(0) or deselect (1) the chip select line
+ */
+static void ax_spi_chipselect(struct spi_device *spi, bool is_high)
+{
+	struct ax_spi *xspi = spi_controller_get_devdata(spi->controller);
+	u32 ctrl_reg;
+
+	ctrl_reg = ax_spi_read(xspi, AX_SPI_CR2);
+	/* Reset the chip select */
+	ctrl_reg &= ~AX_SPI_DEFAULT_TS_MASK;
+	ctrl_reg |= spi_get_chipselect(spi, 0);
+
+	ax_spi_write(xspi, AX_SPI_CR2, ctrl_reg);
+}
+
+/**
+ * ax_spi_config_clock_mode - Sets clock polarity and phase
+ * @spi:	Pointer to the spi_device structure
+ *
+ * Sets the requested clock polarity and phase.
+ */
+static void ax_spi_config_clock_mode(struct spi_device *spi)
+{
+	struct ax_spi *xspi = spi_controller_get_devdata(spi->controller);
+	u32 ctrl_reg, new_ctrl_reg;
+
+	new_ctrl_reg = ax_spi_read(xspi, AX_SPI_CR1);
+	ctrl_reg = new_ctrl_reg;
+
+	/* Set the SPI clock phase and clock polarity */
+	new_ctrl_reg &= ~(AX_SPI_CR1_CPHA | AX_SPI_CR1_CPOL);
+	if (spi->mode & SPI_CPHA)
+		new_ctrl_reg |= AX_SPI_CR1_CPHA;
+	if (spi->mode & SPI_CPOL)
+		new_ctrl_reg |= AX_SPI_CR1_CPOL;
+
+	if (new_ctrl_reg != ctrl_reg)
+		ax_spi_write(xspi, AX_SPI_CR1, new_ctrl_reg);
+	ax_spi_write(xspi, AX_SPI_CR1, 0x03);
+}
+
+/**
+ * ax_spi_config_clock_freq - Sets clock frequency
+ * @spi:	Pointer to the spi_device structure
+ * @transfer:	Pointer to the spi_transfer structure which provides
+ *		information about next transfer setup parameters
+ *
+ * Sets the requested clock frequency.
+ * Note: If the requested frequency is not an exact match with what can be
+ * obtained using the prescalar value the driver sets the clock frequency which
+ * is lower than the requested frequency (maximum lower) for the transfer. If
+ * the requested frequency is higher or lower than that is supported by the SPI
+ * controller the driver will set the highest or lowest frequency supported by
+ * controller.
+ */
+static void ax_spi_config_clock_freq(struct spi_device *spi,
+				     struct spi_transfer *transfer)
+{
+	struct ax_spi *xspi = spi_controller_get_devdata(spi->controller);
+
+	u32 ctrl_reg;
+
+	/* xspi->clk_rate - AMBA Slave clock frequency
+	 * transfer->speed_hz - Slave clock required frequency
+	 * As per data sheet - SCD = (AMBA Slave clock/SCK) - 2
+	 */
+	ctrl_reg = (xspi->clk_rate / transfer->speed_hz) - 2;
+
+	/* As per Digital Blocks datasheet clock frequency range
+	 * Min - 244KHz
+	 * Max - 62.5MHz
+	 * If the user configures less than Min value,
+	 * it will configured to 244KHz by default
+	 */
+	if (ctrl_reg <= AX_SPI_SCD_MIN)
+		ax_spi_write(xspi, AX_SPI_SCDR, ctrl_reg | AX_SPI_SCDR_SCS);
+	else
+		ax_spi_write(xspi, AX_SPI_SCDR, AX_SPI_SCD_MIN | AX_SPI_SCDR_SCS);
+}
+
+/**
+ * ax_spi_setup_transfer - Configure SPI controller for specified transfer
+ * @spi:	Pointer to the spi_device structure
+ * @transfer:	Pointer to the spi_transfer structure which provides
+ *		information about next transfer setup parameters
+ *
+ * Sets the operational mode of SPI controller for the next SPI transfer and
+ * sets the requested clock frequency.
+ *
+ */
+static void ax_spi_setup_transfer(struct spi_device *spi,
+				 struct spi_transfer *transfer)
+{
+	struct ax_spi *xspi = spi_controller_get_devdata(spi->controller);
+
+	ax_spi_config_clock_freq(spi, transfer);
+
+	dev_dbg(&spi->dev, "%s, mode %d, %u bits/w, %u clock speed\n",
+		__func__, spi->mode, spi->bits_per_word,
+		xspi->speed_hz);
+}
+
+/**
+ * ax_spi_fill_tx_fifo - Fills the TX FIFO with as many bytes as possible
+ * @xspi:	Pointer to the ax_spi structure
+ */
+static void ax_spi_fill_tx_fifo(struct ax_spi *xspi)
+{
+	unsigned long trans_cnt = 0;
+
+	while ((trans_cnt < xspi->tx_fifo_depth) &&
+	       (xspi->tx_bytes > 0)) {
+		/* When xspi in busy condition, bytes may send failed,
+		 * then spi control did't work thoroughly, add one byte delay
+		 */
+		if (ax_spi_read(xspi, AX_SPI_IVR) & AX_SPI_IVR_TFOV)
+			usleep_range(10, 10);
+		if (xspi->tx_buf)
+			ax_spi_write_b(xspi, AX_SPI_TXFIFO, *xspi->tx_buf++);
+		else
+			ax_spi_write_b(xspi, AX_SPI_TXFIFO, 0);
+
+		xspi->tx_bytes--;
+		trans_cnt++;
+	}
+}
+/**
+ * ax_spi_get_rx_byte - Gets a byte from the RX FIFO buffer
+ * @xspi: Controller private data (struct ax_spi *)
+ *
+ * This function handles the logic of extracting bytes from the 32-bit RX FIFO.
+ * It reads a new 32-bit word from AX_SPI_RXFIFO only when the current buffered
+ * word has been fully processed (all 4 bytes extracted). It then extracts
+ * bytes one by one, assuming the controller is little-endian.
+ *
+ * Returns: The next 8-bit byte read from the RX FIFO stream.
+ */
+static u8 ax_spi_get_rx_byte_for_irq(struct ax_spi *xspi)
+{
+	u8 byte_val;
+
+	/* If all bytes from the current 32-bit word have been extracted,
+	 * read a new word from the hardware RX FIFO.
+	 */
+	if (xspi->bytes_left_in_current_rx_word_for_irq == 0) {
+		xspi->current_rx_fifo_word_for_irq = ax_spi_read(xspi, AX_SPI_RXFIFO);
+		xspi->bytes_left_in_current_rx_word_for_irq = 4; // A new 32-bit word has 4 bytes
+	}
+
+	/* Extract the least significant byte from the current 32-bit word */
+	byte_val = (u8)(xspi->current_rx_fifo_word_for_irq & 0xFF);
+
+	/* Shift the word right by 8 bits to prepare the next byte for extraction */
+	xspi->current_rx_fifo_word_for_irq >>= 8;
+	xspi->bytes_left_in_current_rx_word_for_irq--;
+
+	return byte_val;
+}
+
+/*
+ * Helper function to process received bytes and check for transfer completion.
+ * This avoids code duplication and centralizes the completion logic.
+ * Returns true if the transfer was finalized.
+ */
+static bool ax_spi_process_rx_and_finalize(struct spi_controller *ctlr)
+{
+	struct ax_spi *xspi = spi_controller_get_devdata(ctlr);
+
+	/* Process any remaining bytes in the RX FIFO */
+	u32 avail_bytes = ax_spi_read(xspi, AX_SPI_RX_FBCAR);
+
+	// This loop handles bytes that are already staged from a previous word read
+	while (xspi->bytes_left_in_current_rx_word_for_irq &&
+	       (xspi->rx_copy_remaining || xspi->rx_discard)) {
+		u8 b = ax_spi_get_rx_byte_for_irq(xspi);
+
+		if (xspi->rx_discard) {
+			xspi->rx_discard--;
+		} else {
+			*xspi->rx_buf++ = b;
+			xspi->rx_copy_remaining--;
+		}
+	}
+
+	// This loop processes new words directly from the FIFO
+	while (avail_bytes >= 4 && (xspi->rx_copy_remaining || xspi->rx_discard)) {
+		// This function should handle reading from the FIFO
+		u8 b = ax_spi_get_rx_byte_for_irq(xspi);
+
+		if (xspi->rx_discard) {
+			xspi->rx_discard--;
+		} else {
+			*xspi->rx_buf++ = b;
+			xspi->rx_copy_remaining--;
+		}
+		// ax_spi_get_rx_byte_for_irq fetches a new word when needed
+		// and updates internal state.
+		if (xspi->bytes_left_in_current_rx_word_for_irq == 3)
+			avail_bytes -= 4;
+	}
+
+	/*
+	 * Completion Check: The transfer is truly complete if all expected
+	 * RX bytes have been copied or discarded.
+	 */
+	if (xspi->rx_copy_remaining == 0 && xspi->rx_discard == 0) {
+		/*
+		 * Defensive drain: If for some reason there are leftover bytes
+		 * in the HW FIFO after we've logically finished,
+		 * read and discard them to prevent them from corrupting the next transfer.
+		 * This should be a bounded operation.
+		 */
+		int safety_words = AX_SPI_RX_FIFO_DRAIN_LIMIT; // Limit to avoid getting stuck
+
+		while (ax_spi_read(xspi, AX_SPI_RX_FBCAR) > 0 && safety_words-- > 0)
+			(void)ax_spi_read(xspi, AX_SPI_RXFIFO);
+
+		// Disable all interrupts for this transfer and finalize.
+		ax_spi_write(xspi, AX_SPI_IMR, 0x00);
+		spi_finalize_current_transfer(ctlr);
+		return true;
+	}
+
+	return false;
+}
+
+/**
+ * ax_spi_irq - Interrupt service routine of the SPI controller
+ * @irq:	IRQ number
+ * @dev_id:	Pointer to the xspi structure
+ *
+ * This function handles RX FIFO almost full and Host Transfer Completed interrupts only.
+ * On RX FIFO amlost full interrupt this function reads the received data from RX FIFO and
+ * fills the TX FIFO if there is any data remaining to be transferred.
+ * On Host Transfer Completed interrupt this function indicates that transfer is completed,
+ * the SPI subsystem will clear MTC bit.
+ *
+ * Return:	IRQ_HANDLED when handled; IRQ_NONE otherwise.
+ */
+static irqreturn_t ax_spi_irq(int irq, void *dev_id)
+{
+	struct spi_controller *ctlr = dev_id;
+	struct ax_spi *xspi = spi_controller_get_devdata(ctlr);
+	irqreturn_t status;
+	u32 intr_status;
+
+	status = IRQ_NONE;
+	intr_status = ax_spi_read(xspi, AX_SPI_IVR);
+	if (!intr_status)
+		return IRQ_NONE;
+
+	/*
+	 * Handle "Message Transfer Complete" interrupt.
+	 * This means all bytes have been shifted out of the TX FIFO.
+	 * It's time to harvest the final incoming bytes from the RX FIFO.
+	 */
+	if (intr_status & AX_SPI_IVR_MTCV) {
+		// Clear the MTC interrupt flag immediately.
+		ax_spi_write(xspi, AX_SPI_ISR, AX_SPI_ISR_MTC);
+
+		// For a TX-only transfer, rx_buf would be NULL.
+		// In the spi-core, rx_copy_remaining would be 0.
+		// So we can finalize immediately.
+		if (!xspi->rx_buf) {
+			ax_spi_write(xspi, AX_SPI_IMR, 0x00);
+			spi_finalize_current_transfer(ctlr);
+			return IRQ_HANDLED;
+		}
+
+		// For a full-duplex transfer, process any remaining RX data.
+		// The helper function will handle finalization if everything is received.
+		ax_spi_process_rx_and_finalize(ctlr);
+		return IRQ_HANDLED;
+	}
+
+	/*
+	 * Handle "RX FIFO Full / Threshold Met" interrupt.
+	 * This means we need to make space in the RX FIFO by reading from it.
+	 */
+	if (intr_status & AX_SPI_IVR_RFFV) {
+		if (ax_spi_process_rx_and_finalize(ctlr)) {
+			// Transfer was finalized inside the helper, we are done.
+		} else {
+			// RX is not yet complete. If there are still TX bytes to send
+			// (for very long transfers), we can fill the TX FIFO again.
+			if (xspi->tx_bytes)
+				ax_spi_fill_tx_fifo(xspi);
+		}
+		return IRQ_HANDLED;
+	}
+
+	return IRQ_NONE;
+}
+
+static int ax_prepare_message(struct spi_controller *ctlr,
+			      struct spi_message *msg)
+{
+	ax_spi_config_clock_mode(msg->spi);
+	return 0;
+}
+
+/**
+ * ax_transfer_one - Initiates the SPI transfer
+ * @ctlr:	Pointer to spi_controller structure
+ * @spi:	Pointer to the spi_device structure
+ * @transfer:	Pointer to the spi_transfer structure which provides
+ *		information about next transfer parameters
+ *
+ * This function fills the TX FIFO, starts the SPI transfer and
+ * returns a positive transfer count so that core will wait for completion.
+ *
+ * Return:	Number of bytes transferred in the last transfer
+ */
+static int ax_transfer_one(struct spi_controller *ctlr,
+			   struct spi_device *spi,
+			   struct spi_transfer *transfer)
+{
+	struct ax_spi *xspi = spi_controller_get_devdata(ctlr);
+	int drain_limit;
+
+	/*
+	 * Pre-transfer cleanup:Flush the RX FIFO to discard any stale data.
+	 * This is the crucial part. Before every new transfer, we must ensure
+	 * the HW is in a clean state to avoid processing stale data
+	 * from a previous, possibly failed or interrupted, transfer.
+	 */
+	drain_limit = AX_SPI_RX_FIFO_DRAIN_LIMIT; // Sane limit to prevent infinite loop on HW error
+	while (ax_spi_read(xspi, AX_SPI_RX_FBCAR) > 0 && drain_limit-- > 0)
+		(void)ax_spi_read(xspi, AX_SPI_RXFIFO); // Read and discard
+
+	if (drain_limit <= 0)
+		dev_warn(&ctlr->dev, "RX FIFO drain timeout before transfer\n");
+
+	/* Clear any stale interrupt flags from a previous transfer.
+	 * This prevents an immediate, false interrupt trigger.
+	 */
+	ax_spi_write(xspi, AX_SPI_ISR, AX_SPI_ISR_CLR);
+
+	xspi->tx_buf = transfer->tx_buf;
+	xspi->rx_buf = transfer->rx_buf;
+	xspi->tx_bytes = transfer->len;
+	xspi->rx_bytes = transfer->len;
+
+	/* Reset RX 32-bit to byte buffer for each new transfer */
+	if (transfer->tx_buf && !transfer->rx_buf) {
+		/* TX mode: discard all received data */
+		xspi->rx_discard = transfer->len;
+		xspi->rx_copy_remaining = 0;
+	} else if ((!transfer->tx_buf && transfer->rx_buf) ||
+		   (transfer->tx_buf && transfer->rx_buf)) {
+		/* RX mode: generate clock by filling TX FIFO with dummy bytes
+		 * Full-duplex mode: generate clock by filling TX FIFO
+		 */
+		xspi->rx_discard = 0;
+		xspi->rx_copy_remaining = transfer->len;
+	} else {
+		/* No TX and RX */
+		xspi->rx_discard = 0;
+		xspi->rx_copy_remaining = transfer->len;
+	}
+
+	ax_spi_setup_transfer(spi, transfer);
+	ax_spi_fill_tx_fifo(xspi);
+	ax_spi_write(xspi, AX_SPI_CR2, (AX_SPI_CR2_HTE | AX_SPI_CR2_SRD | AX_SPI_CR2_SWD));
+
+	spi_transfer_delay_exec(transfer);
+
+	ax_spi_write(xspi, AX_SPI_IMR, (AX_SPI_IMR_MTCM | AX_SPI_IMR_RFFM));
+	return transfer->len;
+}
+
+/**
+ * ax_prepare_transfer_hardware - Prepares hardware for transfer.
+ * @ctlr:	Pointer to the spi_controller structure which provides
+ *		information about the controller.
+ *
+ * This function enables SPI host controller.
+ *
+ * Return:	0 always
+ */
+static int ax_prepare_transfer_hardware(struct spi_controller *ctlr)
+{
+	struct ax_spi *xspi = spi_controller_get_devdata(ctlr);
+
+	u32 reg_value;
+
+	reg_value = ax_spi_read(xspi, AX_SPI_CR1);
+	reg_value |= AX_SPI_CR1_SCE;
+
+	ax_spi_write(xspi, AX_SPI_CR1, reg_value);
+
+	return 0;
+}
+
+/**
+ * ax_unprepare_transfer_hardware - Relaxes hardware after transfer
+ * @ctlr:	Pointer to the spi_controller structure which provides
+ *		information about the controller.
+ *
+ * This function disables the SPI host controller when no target selected.
+ *
+ * Return:	0 always
+ */
+static int ax_unprepare_transfer_hardware(struct spi_controller *ctlr)
+{
+	struct ax_spi *xspi = spi_controller_get_devdata(ctlr);
+
+	u32 reg_value;
+
+	/* Disable the SPI if target is deselected */
+	reg_value = ax_spi_read(xspi, AX_SPI_CR1);
+	reg_value &= ~AX_SPI_CR1_SCE;
+
+	ax_spi_write(xspi, AX_SPI_CR1, reg_value);
+
+	return 0;
+}
+
+/**
+ * ax_spi_detect_fifo_depth - Detect the FIFO depth of the hardware
+ * @xspi:	Pointer to the ax_spi structure
+ *
+ * The depth of the TX FIFO is a synthesis configuration parameter of the SPI
+ * IP. The FIFO threshold register is sized so that its maximum value can be the
+ * FIFO size - 1. This is used to detect the size of the FIFO.
+ */
+static void ax_spi_detect_fifo_depth(struct ax_spi *xspi)
+{
+	/* The MSBs will get truncated giving us the size of the FIFO */
+	ax_spi_write(xspi, AX_SPI_TX_FAETR, ALMOST_EMPTY_TRESHOLD);
+	xspi->tx_fifo_depth = FIFO_DEPTH;
+
+	/* Set the threshold limit */
+	ax_spi_write(xspi, AX_SPI_TX_FAETR, ALMOST_EMPTY_TRESHOLD);
+	ax_spi_write(xspi, AX_SPI_RX_FAFTR, ALMOST_FULL_TRESHOLD);
+}
+
+/* --- Internal Helper Function for 32-bit RX FIFO Read --- */
+/**
+ * ax_spi_get_rx_byte - Gets a byte from the RX FIFO buffer
+ * @xspi: Controller private data (struct ax_spi *)
+ *
+ * This function handles the logic of extracting bytes from the 32-bit RX FIFO.
+ * It reads a new 32-bit word from AX_SPI_RXFIFO only when the current buffered
+ * word has been fully processed (all 4 bytes extracted). It then extracts
+ * bytes one by one, assuming the controller is little-endian.
+ *
+ * Returns: The next 8-bit byte read from the RX FIFO stream.
+ */
+static u8 ax_spi_get_rx_byte(struct ax_spi *xspi)
+{
+	u8 byte_val;
+
+	/* If all bytes from the current 32-bit word have been extracted,
+	 * read a new word from the hardware RX FIFO.
+	 */
+	if (xspi->bytes_left_in_current_rx_word == 0) {
+		xspi->current_rx_fifo_word = ax_spi_read(xspi, AX_SPI_RXFIFO);
+		xspi->bytes_left_in_current_rx_word = 4; // A new 32-bit word has 4 bytes
+	}
+
+	/* Extract the least significant byte from the current 32-bit word */
+	byte_val = (u8)(xspi->current_rx_fifo_word & 0xFF);
+
+	/* Shift the word right by 8 bits to prepare the next byte for extraction */
+	xspi->current_rx_fifo_word >>= 8;
+	xspi->bytes_left_in_current_rx_word--;
+
+	return byte_val;
+}
+
+static int ax_spi_mem_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
+{
+	struct spi_device *spi = mem->spi;
+	struct ax_spi *xspi = spi_controller_get_devdata(spi->controller);
+	u32 reg_val;
+	int ret = 0;
+	u8 cmd_buf[AX_SPI_COMMAND_BUFFER_SIZE];
+	int cmd_len = 0;
+	int i = 0, timeout = AX_SPI_TRX_FIFO_TIMEOUT;
+	int bytes_to_discard_from_rx;
+	u8 *rx_buf_ptr = (u8 *)op->data.buf.in;
+	u8 *tx_buf_ptr = (u8 *)op->data.buf.out;
+	u32 rx_count_reg = 0;
+
+	dev_dbg(&spi->dev,
+		"%s: cmd:%02x mode:%d.%d.%d.%d addr:%llx len:%d\n",
+		__func__, op->cmd.opcode, op->cmd.buswidth, op->addr.buswidth,
+		op->dummy.buswidth, op->data.buswidth, op->addr.val,
+		op->data.nbytes);
+
+	/* Validate operation parameters: Only 1-bit bus width supported */
+	if (op->cmd.buswidth != 1 ||
+	    (op->addr.nbytes && op->addr.buswidth != 0 &&
+	    op->addr.buswidth != 1) ||
+	    (op->dummy.nbytes && op->dummy.buswidth != 0 &&
+	    op->dummy.buswidth != 1) ||
+	    (op->data.nbytes && op->data.buswidth != 1)) {
+		dev_err(&spi->dev, "Unsupported bus width, only 1-bit bus width supported\n");
+		return -EOPNOTSUPP;
+	}
+
+	/* Initialize controller hardware */
+	ax_spi_init_hw(xspi);
+
+	/* Assert chip select (pull low) */
+	ax_spi_chipselect(spi, false);
+
+	/* Build command phase: Copy opcode to cmd_buf */
+	if (op->cmd.nbytes == 2) {
+		cmd_buf[cmd_len++] = (op->cmd.opcode >> 8) & 0xFF;
+		cmd_buf[cmd_len++] = op->cmd.opcode & 0xFF;
+	} else {
+		cmd_buf[cmd_len++] = op->cmd.opcode;
+	}
+
+	/* Put address bytes to cmd_buf */
+	if (op->addr.nbytes) {
+		for (i = op->addr.nbytes - 1; i >= 0; i--) {
+			cmd_buf[cmd_len] = (op->addr.val >> (i * 8)) & 0xFF;
+			cmd_len++;
+		}
+	}
+
+	/* Configure controller for desired operation mode (write/read) */
+	reg_val = ax_spi_read(xspi, AX_SPI_CR2);
+	reg_val |= AX_SPI_CR2_SWD | AX_SPI_CR2_SRI | AX_SPI_CR2_SRD;
+	ax_spi_write(xspi, AX_SPI_CR2, reg_val);
+
+	/* Write command and address bytes to TX_FIFO */
+	for (i = 0; i < cmd_len; i++)
+		ax_spi_write_b(xspi, AX_SPI_TXFIFO, cmd_buf[i]);
+
+	/* Add dummy bytes (for clock generation) or actual data bytes to TX_FIFO */
+	if (op->data.dir == SPI_MEM_DATA_IN) {
+		for (i = 0; i < op->dummy.nbytes; i++)
+			ax_spi_write_b(xspi, AX_SPI_TXFIFO, 0x00);
+		for (i = 0; i < op->data.nbytes; i++)
+			ax_spi_write_b(xspi, AX_SPI_TXFIFO, 0x00);
+	} else {
+		for (i = 0; i < op->data.nbytes; i++)
+			ax_spi_write_b(xspi, AX_SPI_TXFIFO, tx_buf_ptr[i]);
+	}
+
+	/* Start the SPI transmission */
+	reg_val = ax_spi_read(xspi, AX_SPI_CR2);
+	reg_val |= AX_SPI_CR2_HTE;
+	ax_spi_write(xspi, AX_SPI_CR2, reg_val);
+
+	/* Wait for TX FIFO to become empty */
+	while (timeout-- > 0) {
+		u32 tx_count_reg = ax_spi_read(xspi, AX_SPI_TX_FBCAR);
+
+		if (tx_count_reg == 0) {
+			udelay(1);
+			break;
+		}
+		udelay(1);
+	}
+
+	/* Handle Data Reception (for read operations) */
+	if (op->data.dir == SPI_MEM_DATA_IN) {
+		/* Reset the internal RX byte buffer for this new operation.
+		 * This ensures ax_spi_get_rx_byte starts fresh for each exec_op call.
+		 */
+		xspi->bytes_left_in_current_rx_word = 0;
+		xspi->current_rx_fifo_word = 0;
+
+		timeout = AX_SPI_TRX_FIFO_TIMEOUT;
+		while (timeout-- > 0) {
+			rx_count_reg = ax_spi_read(xspi, AX_SPI_RX_FBCAR);
+			if (rx_count_reg >= op->data.nbytes)
+				break;
+			udelay(1); // Small delay to prevent aggressive busy-waiting
+		}
+
+		if (timeout < 0) {
+			ret = -ETIMEDOUT;
+			goto out_unlock;
+		}
+
+		/* Calculate how many bytes we need to discard from the RX FIFO.
+		 * Since we set SRI, we only need to discard the address bytes and
+		 * dummy bytes from the RX FIFO.
+		 */
+		bytes_to_discard_from_rx = op->addr.nbytes + op->dummy.nbytes;
+		for (i = 0; i < bytes_to_discard_from_rx; i++)
+			ax_spi_get_rx_byte(xspi);
+
+		/* Read actual data bytes into op->data.buf.in */
+		for (i = 0; i < op->data.nbytes; i++) {
+			*rx_buf_ptr = ax_spi_get_rx_byte(xspi);
+			rx_buf_ptr++;
+		}
+	} else if (op->data.dir == SPI_MEM_DATA_OUT) {
+		timeout = AX_SPI_TRX_FIFO_TIMEOUT;
+		while (timeout-- > 0) {
+			u32 tx_fifo_level = ax_spi_read(xspi, AX_SPI_TX_FBCAR);
+
+			if (tx_fifo_level == 0)
+				break;
+			udelay(1);
+		}
+		if (timeout < 0) {
+			ret = -ETIMEDOUT;
+			goto out_unlock;
+		}
+	}
+
+out_unlock:
+	/* Deassert chip select (pull high) */
+	ax_spi_chipselect(spi, true);
+
+	return ret;
+}
+
+static int ax_spi_mem_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
+{
+	struct spi_device *spi = mem->spi;
+	struct ax_spi *xspi = spi_controller_get_devdata(spi->controller);
+	size_t max_transfer_payload_bytes;
+	size_t fifo_total_bytes;
+	size_t protocol_overhead_bytes;
+
+	fifo_total_bytes = xspi->tx_fifo_depth;
+	/* Calculate protocol overhead bytes according to the real operation each time. */
+	protocol_overhead_bytes = op->cmd.nbytes + op->addr.nbytes + op->dummy.nbytes;
+
+	/*Calculate the maximum data payload that can fit into the FIFO. */
+	if (fifo_total_bytes <= protocol_overhead_bytes) {
+		max_transfer_payload_bytes = 0;
+		dev_warn_once(&spi->dev, "SPI FIFO (%zu bytes) is too small for protocol overhead (%zu bytes)! Max data size forced to 0.\n",
+			 fifo_total_bytes, protocol_overhead_bytes);
+	} else {
+		max_transfer_payload_bytes = fifo_total_bytes - protocol_overhead_bytes;
+	}
+
+	/* Limit op->data.nbytes based on the calculated max payload and SZ_64K.
+	 * This is the value that spi-mem will then use to split requests.
+	 */
+	if (op->data.nbytes > max_transfer_payload_bytes) {
+		op->data.nbytes = max_transfer_payload_bytes;
+		dev_dbg(&spi->dev, "%s %d: op->data.nbytes adjusted to %u due to FIFO overhead\n",
+			__func__, __LINE__, op->data.nbytes);
+	}
+
+	/* Also apply the overall max transfer size */
+	if (op->data.nbytes > SZ_64K) {
+		op->data.nbytes = SZ_64K;
+		dev_dbg(&spi->dev, "%s %d: op->data.nbytes adjusted to %u due to SZ_64K limit\n",
+			__func__, __LINE__, op->data.nbytes);
+	}
+
+	return 0;
+}
+
+static const struct spi_controller_mem_ops ax_spi_mem_ops = {
+	.exec_op = ax_spi_mem_exec_op,
+	.adjust_op_size = ax_spi_mem_adjust_op_size,
+};
+
+/**
+ * ax_spi_probe - Probe method for the SPI driver
+ * @pdev:	Pointer to the platform_device structure
+ *
+ * This function initializes the driver data structures and the hardware.
+ *
+ * Return:	0 on success and error value on error
+ */
+static int ax_spi_probe(struct platform_device *pdev)
+{
+	int ret = 0, irq;
+	struct spi_controller *ctlr;
+	struct ax_spi *xspi;
+	u32 num_cs;
+
+	ctlr = devm_spi_alloc_host(&pdev->dev, sizeof(*xspi));
+	if (!ctlr)
+		return -ENOMEM;
+
+	xspi = spi_controller_get_devdata(ctlr);
+	ctlr->dev.of_node = pdev->dev.of_node;
+	platform_set_drvdata(pdev, ctlr);
+
+	xspi->regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(xspi->regs)) {
+		ret = PTR_ERR(xspi->regs);
+		goto remove_ctlr;
+	}
+
+	xspi->pclk = devm_clk_get(&pdev->dev, "pclk");
+	if (IS_ERR(xspi->pclk)) {
+		dev_err(&pdev->dev, "pclk clock not found.\n");
+		ret = PTR_ERR(xspi->pclk);
+		goto remove_ctlr;
+	}
+
+	xspi->ref_clk = devm_clk_get(&pdev->dev, "ref_clk");
+	if (IS_ERR(xspi->ref_clk)) {
+		dev_err(&pdev->dev, "ref_clk clock not found.\n");
+		ret = PTR_ERR(xspi->ref_clk);
+		goto remove_ctlr;
+	}
+
+	ret = clk_prepare_enable(xspi->pclk);
+	if (ret) {
+		dev_err(&pdev->dev, "Unable to enable APB clock.\n");
+		goto remove_ctlr;
+	}
+
+	ret = clk_prepare_enable(xspi->ref_clk);
+	if (ret) {
+		dev_err(&pdev->dev, "Unable to enable device clock.\n");
+		goto clk_dis_apb;
+	}
+
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_set_autosuspend_delay(&pdev->dev, SPI_AUTOSUSPEND_TIMEOUT);
+	pm_runtime_get_noresume(&pdev->dev);
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+
+	ret = of_property_read_u32(pdev->dev.of_node, "num-cs", &num_cs);
+	if (ret < 0)
+		ctlr->num_chipselect = AX_SPI_DEFAULT_NUM_CS;
+	else
+		ctlr->num_chipselect = num_cs;
+
+	ax_spi_detect_fifo_depth(xspi);
+
+	xspi->current_rx_fifo_word = 0;
+	xspi->bytes_left_in_current_rx_word = 0;
+
+	/* Initialize IRQ-related variables */
+	xspi->bytes_left_in_current_rx_word_for_irq = 0;
+	xspi->current_rx_fifo_word_for_irq = 0;
+
+	/* SPI controller initializations */
+	ax_spi_init_hw(xspi);
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq <= 0) {
+		ret = -ENXIO;
+		goto clk_dis_all;
+	}
+
+	ret = devm_request_irq(&pdev->dev, irq, ax_spi_irq,
+			       0, pdev->name, ctlr);
+	if (ret != 0) {
+		ret = -ENXIO;
+		dev_err(&pdev->dev, "request_irq failed\n");
+		goto clk_dis_all;
+	}
+
+	ctlr->use_gpio_descriptors = true;
+	ctlr->prepare_transfer_hardware = ax_prepare_transfer_hardware;
+	ctlr->prepare_message = ax_prepare_message;
+	ctlr->transfer_one = ax_transfer_one;
+	ctlr->unprepare_transfer_hardware = ax_unprepare_transfer_hardware;
+	ctlr->set_cs = ax_spi_chipselect;
+	ctlr->auto_runtime_pm = true;
+	ctlr->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
+
+	xspi->clk_rate = clk_get_rate(xspi->ref_clk);
+	/* Set to default valid value */
+	ctlr->max_speed_hz = xspi->clk_rate / 2;
+	xspi->speed_hz = ctlr->max_speed_hz;
+
+	ctlr->bits_per_word_mask = SPI_BPW_MASK(8);
+
+	pm_runtime_mark_last_busy(&pdev->dev);
+	pm_runtime_put_autosuspend(&pdev->dev);
+
+	ctlr->mem_ops = &ax_spi_mem_ops;
+
+	ret = spi_register_controller(ctlr);
+	if (ret) {
+		dev_err(&pdev->dev, "spi_register_controller failed\n");
+		goto clk_dis_all;
+	}
+
+	return ret;
+
+clk_dis_all:
+	pm_runtime_set_suspended(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+	clk_disable_unprepare(xspi->ref_clk);
+clk_dis_apb:
+	clk_disable_unprepare(xspi->pclk);
+remove_ctlr:
+	spi_controller_put(ctlr);
+	return ret;
+}
+
+/**
+ * ax_spi_remove - Remove method for the SPI driver
+ * @pdev:	Pointer to the platform_device structure
+ *
+ * This function is called if a device is physically removed from the system or
+ * if the driver module is being unloaded. It frees all resources allocated to
+ * the device.
+ */
+static void ax_spi_remove(struct platform_device *pdev)
+{
+	struct spi_controller *ctlr = platform_get_drvdata(pdev);
+	struct ax_spi *xspi = spi_controller_get_devdata(ctlr);
+
+	spi_unregister_controller(ctlr);
+
+	pm_runtime_set_suspended(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+
+	clk_disable_unprepare(xspi->ref_clk);
+	clk_disable_unprepare(xspi->pclk);
+}
+
+/**
+ * ax_spi_suspend - Suspend method for the SPI driver
+ * @dev:	Address of the platform_device structure
+ *
+ * This function disables the SPI controller and
+ * changes the driver state to "suspend"
+ *
+ * Return:	0 on success and error value on error
+ */
+static int __maybe_unused ax_spi_suspend(struct device *dev)
+{
+	struct spi_controller *ctlr = dev_get_drvdata(dev);
+
+	return spi_controller_suspend(ctlr);
+}
+
+/**
+ * ax_spi_resume - Resume method for the SPI driver
+ * @dev:	Address of the platform_device structure
+ *
+ * This function changes the driver state to "ready"
+ *
+ * Return:	0 on success and error value on error
+ */
+static int __maybe_unused ax_spi_resume(struct device *dev)
+{
+	struct spi_controller *ctlr = dev_get_drvdata(dev);
+	struct ax_spi *xspi = spi_controller_get_devdata(ctlr);
+
+	ax_spi_init_hw(xspi);
+	return spi_controller_resume(ctlr);
+}
+
+/**
+ * ax_spi_runtime_resume - Runtime resume method for the SPI driver
+ * @dev:	Address of the platform_device structure
+ *
+ * This function enables the clocks
+ *
+ * Return:	0 on success and error value on error
+ */
+static int __maybe_unused ax_spi_runtime_resume(struct device *dev)
+{
+	struct spi_controller *ctlr = dev_get_drvdata(dev);
+	struct ax_spi *xspi = spi_controller_get_devdata(ctlr);
+	int ret;
+
+	ret = clk_prepare_enable(xspi->pclk);
+	if (ret) {
+		dev_err(dev, "Cannot enable APB clock.\n");
+		return ret;
+	}
+
+	ret = clk_prepare_enable(xspi->ref_clk);
+	if (ret) {
+		dev_err(dev, "Cannot enable device clock.\n");
+		clk_disable_unprepare(xspi->pclk);
+		return ret;
+	}
+	return 0;
+}
+
+/**
+ * ax_spi_runtime_suspend - Runtime suspend method for the SPI driver
+ * @dev:	Address of the platform_device structure
+ *
+ * This function disables the clocks
+ *
+ * Return:	Always 0
+ */
+static int __maybe_unused ax_spi_runtime_suspend(struct device *dev)
+{
+	struct spi_controller *ctlr = dev_get_drvdata(dev);
+	struct ax_spi *xspi = spi_controller_get_devdata(ctlr);
+
+	clk_disable_unprepare(xspi->ref_clk);
+	clk_disable_unprepare(xspi->pclk);
+
+	return 0;
+}
+
+static const struct dev_pm_ops ax_spi_dev_pm_ops = {
+	SET_RUNTIME_PM_OPS(ax_spi_runtime_suspend,
+			   ax_spi_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(ax_spi_suspend, ax_spi_resume)
+};
+
+static const struct of_device_id ax_spi_of_match[] = {
+	{ .compatible = "axiado,ax3000-spi" },
+	{ /* end of table */ }
+};
+MODULE_DEVICE_TABLE(of, ax_spi_of_match);
+
+/* ax_spi_driver - This structure defines the SPI subsystem platform driver */
+static struct platform_driver ax_spi_driver = {
+	.probe	= ax_spi_probe,
+	.remove	= ax_spi_remove,
+	.driver = {
+		.name = AX_SPI_NAME,
+		.of_match_table = ax_spi_of_match,
+		.pm = &ax_spi_dev_pm_ops,
+	},
+};
+
+module_platform_driver(ax_spi_driver);
+
+MODULE_AUTHOR("Axiado Corporation");
+MODULE_DESCRIPTION("Axiado SPI Host driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/spi/spi-axiado.h b/drivers/spi/spi-axiado.h
new file mode 100644
index 0000000000000000000000000000000000000000..3d0a1437bd32e5a59937a1b68cdbd741ca254716
--- /dev/null
+++ b/drivers/spi/spi-axiado.h
@@ -0,0 +1,129 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Axiado SPI controller driver (Host mode only)
+ *
+ * Copyright (C) 2022-2025 Axiado Corporation (or its affiliates). All rights reserved.
+ */
+
+/* Name of this driver */
+#define AX_SPI_NAME			"axiado-db-spi"
+
+/* Axiado - SPI Digital Blocks IP design registers */
+#define AX_SPI_TX_FAETR			0x18    // TX-FAETR
+#define ALMOST_EMPTY_TRESHOLD		0x00	// Programmed threshold value
+#define AX_SPI_RX_FAFTR			0x28    // RX-FAETR
+#define ALMOST_FULL_TRESHOLD		0x0c	// Programmed threshold value
+#define FIFO_DEPTH			256	// 256 bytes
+
+#define AX_SPI_CR1			0x00	// CR1
+#define AX_SPI_CR1_CLR			0x00	// CR1 - Clear
+#define AX_SPI_CR1_SCR			0x01	// CR1 - controller reset
+#define AX_SPI_CR1_SCE			0x02	// CR1 - Controller Enable/Disable
+#define AX_SPI_CR1_CPHA			0x08	// CR1 - CPH
+#define AX_SPI_CR1_CPOL			0x10	// CR1 - CPO
+
+#define AX_SPI_CR2			0x04	// CR2
+#define AX_SPI_CR2_SWD			0x04	// CR2 - Write Enabel/Disable
+#define AX_SPI_CR2_SRD			0x08	// CR2 - Read Enable/Disable
+#define AX_SPI_CR2_SRI			0x10	// CR2 - Read First Byte Ignore
+#define AX_SPI_CR2_HTE			0x40	// CR2 - Host Transmit Enable
+#define AX_SPI_CR3			0x08	// CR3
+#define AX_SPI_CR3_SDL			0x00	// CR3 - Data lines
+#define AX_SPI_CR3_QUAD			0x02	// CR3 - Data lines
+
+/* As per Digital Blocks datasheet clock frequency range
+ * Min - 244KHz
+ * Max - 62.5MHz
+ * SCK Clock Divider Register Values
+ */
+#define AX_SPI_RX_FBCAR			0x24	// RX_FBCAR
+#define AX_SPI_TX_FBCAR			0x14	// TX_FBCAR
+#define AX_SPI_SCDR			0x2c	// SCDR
+#define AX_SPI_SCD_MIN			0x1fe	// Valid SCD (SCK Clock Divider Register)
+#define AX_SPI_SCD_DEFAULT		0x06	// Default SCD (SCK Clock Divider Register)
+#define AX_SPI_SCD_MAX			0x00	// Valid SCD (SCK Clock Divider Register)
+#define AX_SPI_SCDR_SCS			0x0200	// SCDR - AMBA Bus Clock source
+
+#define AX_SPI_IMR			0x34	// IMR
+#define AX_SPI_IMR_CLR			0x00	// IMR - Clear
+#define AX_SPI_IMR_TFOM			0x02	// IMR - TFO
+#define AX_SPI_IMR_MTCM			0x40	// IMR - MTC
+#define AX_SPI_IMR_TFEM			0x10	// IMR - TFE
+#define AX_SPI_IMR_RFFM			0x20	// IMR - RFFM
+
+#define AX_SPI_ISR			0x30	// ISR
+#define AX_SPI_ISR_CLR			0xff	// ISR - Clear
+#define AX_SPI_ISR_MTC			0x40	// ISR - MTC
+#define AX_SPI_ISR_TFE			0x10	// ISR - TFE
+#define AX_SPI_ISR_RFF			0x20	// ISR - RFF
+
+#define AX_SPI_IVR			0x38	// IVR
+#define AX_SPI_IVR_TFOV			0x02	// IVR - TFOV
+#define AX_SPI_IVR_MTCV			0x40	// IVR - MTCV
+#define AX_SPI_IVR_TFEV			0x10	// IVR - TFEV
+#define AX_SPI_IVR_RFFV			0x20	// IVR - RFFV
+
+#define AX_SPI_TXFIFO			0x0c	// TX_FIFO
+#define AX_SPI_TX_RX_FBCR		0x10	// TX_RX_FBCR
+#define AX_SPI_RXFIFO			0x1c	// RX_FIFO
+
+#define AX_SPI_TS0			0x00	// Target select 0
+#define AX_SPI_TS1			0x01	// Target select 1
+#define AX_SPI_TS2			0x10	// Target select 2
+#define AX_SPI_TS3			0x11	// Target select 3
+
+#define SPI_AUTOSUSPEND_TIMEOUT		3000
+
+/* Default number of chip select lines also used as maximum number of chip select lines */
+#define AX_SPI_DEFAULT_NUM_CS		4
+
+/* Default number of command buffer size */
+#define AX_SPI_COMMAND_BUFFER_SIZE	16	//Command + address bytes
+
+/* Target select mask
+ * 00 – TS0
+ * 01 – TS1
+ * 10 – TS2
+ * 11 – TS3
+ */
+#define AX_SPI_DEFAULT_TS_MASK		0x03
+
+#define AX_SPI_RX_FIFO_DRAIN_LIMIT	24
+#define AX_SPI_TRX_FIFO_TIMEOUT		1000
+/**
+ * struct ax_spi - This definition defines spi driver instance
+ * @regs:					Virtual address of the SPI controller registers
+ * @ref_clk:					Pointer to the peripheral clock
+ * @pclk:					Pointer to the APB clock
+ * @speed_hz:					Current SPI bus clock speed in Hz
+ * @txbuf:					Pointer	to the TX buffer
+ * @rxbuf:					Pointer to the RX buffer
+ * @tx_bytes:					Number of bytes left to transfer
+ * @rx_bytes:					Number of bytes requested
+ * @tx_fifo_depth:				Depth of the TX FIFO
+ * @current_rx_fifo_word:			Buffers the 32-bit word read from RXFIFO
+ * @bytes_left_in_current_rx_word:		Bytes to be extracted from current 32-bit word
+ * @current_rx_fifo_word_for_irq:		Buffers the 32-bit word read from RXFIFO for IRQ
+ * @bytes_left_in_current_rx_word_for_irq:	IRQ bytes to be extracted from current 32-bit word
+ * @rx_discard:					Number of bytes to discard
+ * @rx_copy_remaining:				Number of bytes to copy
+ */
+struct ax_spi {
+	void __iomem *regs;
+	struct clk *ref_clk;
+	struct clk *pclk;
+	unsigned int clk_rate;
+	u32 speed_hz;
+	const u8 *tx_buf;
+	u8 *rx_buf;
+	int tx_bytes;
+	int rx_bytes;
+	unsigned int tx_fifo_depth;
+	u32 current_rx_fifo_word;
+	int bytes_left_in_current_rx_word;
+	u32 current_rx_fifo_word_for_irq;
+	int bytes_left_in_current_rx_word_for_irq;
+	int rx_discard;
+	int rx_copy_remaining;
+};
+

-- 
2.25.1


