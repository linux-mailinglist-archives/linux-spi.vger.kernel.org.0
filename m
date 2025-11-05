Return-Path: <linux-spi+bounces-11055-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 814F7C36D70
	for <lists+linux-spi@lfdr.de>; Wed, 05 Nov 2025 17:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F4376659AF
	for <lists+linux-spi@lfdr.de>; Wed,  5 Nov 2025 16:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0348335564;
	Wed,  5 Nov 2025 16:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="B3XxEGBN"
X-Original-To: linux-spi@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010068.outbound.protection.outlook.com [52.101.56.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201B33346BD;
	Wed,  5 Nov 2025 16:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762359140; cv=fail; b=Vh5AhVzbA+A9HSzHanPzpVa/YXAMd4fkvcer5tXFCoy5CPh6SCY5iVUOwQuionGqedtXU/n8WXAn4pIBK02jZQ8a60SJ6SbuLSJ7xhCrh7IsRTRZ7CrK0HaI4kPo1NFKISmeZYOSZ+dJeF0CaXifEoq6G/3x1MEnl8l+Zec0dnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762359140; c=relaxed/simple;
	bh=rXLbcLyMTI63Kmkb2h/Z8n11C5dd4MMgafDQ75DgmlY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NacTrXur1VEiuxZaBCFQlTRZ3Rg+PYK7I+STVnaPz8PWWDkRRTP35b54W3WN2ktiSX2jY6A56efYymUsROu7rQgBiQaZoO45CYi09TjAwHQ3+7YEwYt1tfrSY1q57v5lpXJNM1tZDGGJwsRMoWIpGLB9APHvJQoLhSLcagdwvhg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=B3XxEGBN; arc=fail smtp.client-ip=52.101.56.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wsFkHZ8L2DwO4hWeyezk6UfSgcrw10wycdth8dyGr1AvPcqkxTxOOlcSKllVXzlWeUw0VzSO6mTEKK25Ge3lwH8qFPt667k3tp7jrfMO2OPMTII1KFdoxCvOtBtcLTtGdIWwixrJNkFoXhSUGep4pmF6SCelBQjNZnYy3+XrkC7IkusCfS7gX9Rm2w12fFaSSYuokFaaEmZ/ZvacErl/bWHI3XEKIARIPsXnsT6qnqm3E3uXyF5nWxu6X47o4zw8SHW83Ilquj3Bn4PlH0B8RqXSz74UzjO05ZAl8kIYd8jR/HHhDXQsCai4hg2MFe5r9tyaasdhjr/SqX6Jc96BqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=feARJwxnvGP0I3HbLSmydcDlRPqxwkDIDzTx33ZT2pY=;
 b=Nk+S4ABW6hAdjScrgYgz7QAlNvGBCjGgKKt+u8AQM0k2lWpeynh/i4isiAcvUckg1DeQav8DhEZ7KzOpTooiMkLS070GQyh4TwGbjIy/0bkwZfFPnja4a2sWaala5TOkZps33bhIkmWcRWCXEubtgeepzkHlBYfcZuV4aweZPi8kOggMooAu5ccRAcdhAjd2j176HzvaODsNYIqXcX/mCTNMTHYbtJcrn6rvfkulfs1yVgYtr071PD1Juby8+7jjf7NW6ig9ZInj0LBcxmE+sqzUPgGDP0yJOXgpAJHLgPa5sVS31o+Ohh2rTji68n9mvXeVBciPUYdBZF9vz74HzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=feARJwxnvGP0I3HbLSmydcDlRPqxwkDIDzTx33ZT2pY=;
 b=B3XxEGBNSJDlEVsIT11Qkw5y0OdLF5M+umNMwTLqtg6RaOC1l5XNM8Oq0AwVHPlnLNKnloxat+SH48GvpBxGm8+ZoCuNsPcUQZDDMj6R9m7MeS8scNKswpMEGgiGHfikwddOg3S3v1B7Re6YwEwyEz6x9XyKr3iWeXz93HyZoAQ=
Received: from PH0P220CA0020.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::34)
 by LV3PR10MB7940.namprd10.prod.outlook.com (2603:10b6:408:20f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Wed, 5 Nov
 2025 16:12:03 +0000
Received: from SJ1PEPF000023D7.namprd21.prod.outlook.com
 (2603:10b6:510:d3:cafe::a5) by PH0P220CA0020.outlook.office365.com
 (2603:10b6:510:d3::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.8 via Frontend Transport; Wed, 5
 Nov 2025 16:12:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ1PEPF000023D7.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.0 via Frontend Transport; Wed, 5 Nov 2025 16:12:02 +0000
Received: from DFLE214.ent.ti.com (10.64.6.72) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 10:11:55 -0600
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 10:11:55 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 5 Nov 2025 10:11:55 -0600
Received: from a-dutta.dhcp.ti.com (a-dutta.dhcp.ti.com [10.24.68.237])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5A5GBldM3979508;
	Wed, 5 Nov 2025 10:11:53 -0600
From: Anurag Dutta <a-dutta@ti.com>
To: <broonie@kernel.org>, <khairul.anuar.romli@altera.com>, <vigneshr@ti.com>
CC: <u-kumar1@ti.com>, <s-k6@ti.com>, <linux-spi@vger.kernel.org>,
	<gehariprasath@ti.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] spi: spi-cadence-quadspi: Remove duplicate pm_runtime_put_autosuspend() call
Date: Wed, 5 Nov 2025 21:41:46 +0530
Message-ID: <20251105161146.2019090-3-a-dutta@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251105161146.2019090-1-a-dutta@ti.com>
References: <20251105161146.2019090-1-a-dutta@ti.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D7:EE_|LV3PR10MB7940:EE_
X-MS-Office365-Filtering-Correlation-Id: 190b7282-818a-4656-24a8-08de1c860e36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|34020700016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TyX34dbHcvKYz7bqewtN1W7SpIRmy4QxlQ+Xe6GQ7KSScMELYxfzUj7iaY+5?=
 =?us-ascii?Q?hqGnMuk//stoO9cgtzO/QiNigeI4kMWwazvMsutlZyR8ivbj1XvWL908oZ8q?=
 =?us-ascii?Q?OmAI8+r1qA4xjNXs5fBdvQZz6k2kBENAXE3ECfA0zBNPRtCInP9ZTKXeQG5g?=
 =?us-ascii?Q?nQXUN5dbPQTixOsLGsR7GzEEv8hRcgXGIY2NGGX6loSBw+iYmpcosGNLTKOz?=
 =?us-ascii?Q?WRHYudQElFmBRB87ewe/1huNAX34UFAsxjQdodL+fdPzz5SvI7KlQG1RIEoV?=
 =?us-ascii?Q?VAwLqJOTDq+uw2ZZTRxbxton3lkk/QbvEIhVZk9HmiYMpLhL2nhavrcvwSll?=
 =?us-ascii?Q?WAODRqGR70ynOqhHM0rC2wHrj9UxSu4EZTUc+iR+5O7oBLfoU9febm04IN9M?=
 =?us-ascii?Q?0wcrEh1AOZKdjznHQU2ev21IzSsyndoFfy27ekGcHN6eBNrjnycEK2tYSfum?=
 =?us-ascii?Q?uYLlHELgd+HvhNUBgjo2wwj1G123IVQO3S04Gsyy27uz7qA6rY/9tZhewXOy?=
 =?us-ascii?Q?ydInkcnZTCa+ChRvPKXagtiOnCcalR3LGa7Q8Pq2LrSI9sJiGXNsl1c8OeCw?=
 =?us-ascii?Q?jEsvQXIbAko2oobP1J7Y04hTxnSFaKb3gaFfvMB7POVFIPuCWNP4Z7K6CYM3?=
 =?us-ascii?Q?d9d71XSqawn03tAbQSRD/pMfryOlvZRz1cBBNRdzOnjJqyrljHxQ87rZSg3z?=
 =?us-ascii?Q?CnA0dRhIkUCdLeiF3nGOaScQ2tgKtCc1LBLR9Np9ql3NAVJaQJ3zE921DKIV?=
 =?us-ascii?Q?bZXFyKqgAEhsl6ZCH+V2Fr1EL/+tSslcDjlksK95xduslaWUNrZRZpsV66hb?=
 =?us-ascii?Q?4aW4HG7fptEV1y9+3/SHDI0JHRt4X0dvrlZcuHOh4Wrgw/6NcOpLa6JdLKc0?=
 =?us-ascii?Q?mCMBR8MhBGtdCrd4sFgqRbFHRJ5j4Aojx4Y+hrDKE9+o/hmNBQWEnFWLz98e?=
 =?us-ascii?Q?XUkbEMfuQaQfHLdtpbzIsZtS2uxgfuLXbo3yPPuKD8qjXDtB0yg6jbGgCxVn?=
 =?us-ascii?Q?mxagRNaBqV+PmNLdbjlDqMgG3jRfwYOCxYB067ynD399zxQg/XfhxYbX72UL?=
 =?us-ascii?Q?bPo9wIxki++4QBAIC8N8ee/DnGVbyHuiDJkk05kMGV8m3gCzRfSGcCMw2oIJ?=
 =?us-ascii?Q?GZyrA7lKlPVL0/XfouXOjWgDnAh6vvOTWH9P8OpPDF3tcQHJMn0ntYa6Itph?=
 =?us-ascii?Q?E/FytjWHuaprvegxw10OfaytIFQBitjO368keOwKGJt62w86JEMHVthdZQ7j?=
 =?us-ascii?Q?i/90yhCLemuUDXFDEDvMBsaBhXgBQVHw2KbQTsb8mYjcaE4cVewV5HuwHehq?=
 =?us-ascii?Q?oFyh3N006rzQvjaezzTyqFTkhWCBwJW++AvQ7513g64M3TD2MlDX8HfBtEfY?=
 =?us-ascii?Q?hrRMSXB7O0a+SkKzdPUDhA9nGg/fyvjW+K7jTk0rDbM6q6HTuXWH99vkUMQz?=
 =?us-ascii?Q?cP5vYkHGR0//1OqCLCzp1MIggdrpzCD+SCqO5iN1sOOAeqiGVvs5uKpsl7lF?=
 =?us-ascii?Q?QEWtxmYk4Q8POYRLi0vr2+fgObTz67QAIyHPHS5XdF3e61uzI3cYw2bDSTq1?=
 =?us-ascii?Q?olUfiSUtnpfT7NGhjNg=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(34020700016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 16:12:02.1472
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 190b7282-818a-4656-24a8-08de1c860e36
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7940

Fix runtime PM usage count underflow caused by calling
pm_runtime_put_autosuspend() twice with only one corresponding
pm_runtime_get_noresume() call. This triggers the warning:
"Runtime PM usage count underflow!"

Remove the duplicate put call to balance the runtime PM reference
counting.

Fixes: 30dbc1c8d50f ("spi: cadence-qspi: defer runtime support on socfpga if reset bit is enabled")
Signed-off-by: Anurag Dutta <a-dutta@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 56906dc76b34..8e0df08609c0 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -2012,7 +2012,6 @@ static int cqspi_probe(struct platform_device *pdev)
 	}
 
 	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM))) {
-		pm_runtime_put_autosuspend(dev);
 		pm_runtime_mark_last_busy(dev);
 		pm_runtime_put_autosuspend(dev);
 	}
-- 
2.34.1


