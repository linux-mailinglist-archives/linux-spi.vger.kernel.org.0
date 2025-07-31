Return-Path: <linux-spi+bounces-9247-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F46FB174B6
	for <lists+linux-spi@lfdr.de>; Thu, 31 Jul 2025 18:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E241F1883324
	for <lists+linux-spi@lfdr.de>; Thu, 31 Jul 2025 16:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9BF1FC0E6;
	Thu, 31 Jul 2025 16:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="FZPEY5GV";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="SKY8CML6"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FC0F9EC;
	Thu, 31 Jul 2025 16:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753978143; cv=fail; b=LuJc3IKel5ymk+1N6/lMWfMp/Q6k4GelnkQSmLkYHi01wdbg4DgHZUUuLlI41Gh6HQV0A1OqS9gTVl5dUNdhVkqQPAD7hMeV41Cz/X5kAGB+F7iXJqkK7lAyfKTi9e6iZu5unRKiW3XiBWkczF8k0n7+lgEFmqmtdxBY/d734vM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753978143; c=relaxed/simple;
	bh=GMU0s3iuQePGXQQDgZrPDGAdyMpPDQNoeGIE5UJos1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VUdxMzLDcL6uZVgwKZmU9tyXPk996Tup9ca/iqR0nry2NpTNLTjLrounjupUUFe2b1gbVldFsbC3AVBfUcfAtTGIuYtaI7ynHT3ZrQ3MkDMR785hrTv+99pJn6dCrWvZFqgc1CNEE7tbPcink2dsDdwfPSBslcvuFCkKhUmLFNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=FZPEY5GV; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=SKY8CML6; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56V4cd8V031254;
	Thu, 31 Jul 2025 11:01:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=e0cQh9d9sPI6j/eT
	9InIbEqZpi4VVlGXZeHVY7pceRY=; b=FZPEY5GVkvkAtMR+t1HCr2w2SI4ToyRa
	yCljS0OunEYQkKRtscY7DKv8BeWiVdZv5eMhI1ruvxgCDPjMABgU+S2LcgDbB5+R
	WY4BWktzezFbeZFR5/PMc+YbPROEcQ6IpxhzQx+RlV0lLPQzZMqdkW8h3Y24SjPs
	rpb49MPrg4q61vKP2KMi0G0uunsg3oaYLIE3L/yPD2e4NObSLyLWvLdeqzEiEqV/
	zO+UH/bYlVafZM8d5AgVe9leaYo/SInWNH4miwIOqmfb+DXV8LC+L/X348TRcJ3G
	msti0njoeJsEIk1db6S9GWXMGTOHL3iebMSO3cquCpCWX+3RWUhPFQ==
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2131.outbound.protection.outlook.com [40.107.244.131])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 487yq6s44q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Jul 2025 11:01:30 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YAkYWnXZ2/xvnlkhwZGaFJtf5P2HHjAYFRJmmf/dphD/vqOdrU5gStShnxSp5grbqVlOlwHsi/6gwLjd8yDmUehxm2LucYPTJNlqYAZU4FSNpp3A6zUqoeu2sNufQO55F7doKKCQjjfRIOD3VSCLPVz+iRL8kVdHwrK/Jf/QWQyJnujTUNeaYsgWdti3zDEA+ws8I+tael+UxgHAQKhO+51pIBxWGpFPmTEDWFrseIKyKYGtnl2QvEFWpGfwB2MvbCb5TmKIDLgXTlAg8mMgKm7OiooO2SneA/ss2sh734FjUj/XSV7XPF5Nsjqwzwc9i1togfIKY6ZCm1/GLCzBgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e0cQh9d9sPI6j/eT9InIbEqZpi4VVlGXZeHVY7pceRY=;
 b=FpecvHrVEaRLcJcRA8gkN9zYsK6g8Mfkkv4NBoJl3I9yZCAoUVOTqo3A7xhJSjb0S71i/EUG3SyPENKAx9V/nrICl5j2KChmPhLXzx02J2Va5wrp+OC79k79piVA2qYhN0+lZJ7wgFMahyxfL5oUowd08ASodk5AM0U4M2Z6t5dM0C1TWea+7JlFAc02GYg0Pmb/tsQ0ZrE6CE+ZA/loiqRs0gTxDpW2ZAj0q2dgrSn3X70oVXPsBZsXtNnjaEYfkkpCJ0ZaeeyNk5dBr+yjFU01l5pqkXLTGJqlbrNGTu0Pa99TcOBVQqrhMBwFWETGiFUKzdC053KuPBKtz7WnXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e0cQh9d9sPI6j/eT9InIbEqZpi4VVlGXZeHVY7pceRY=;
 b=SKY8CML6oa5BNs7tAA0Rne2yjaS9o/L/ljjvm+029gqMsJJoz27kwHHRAxL4IwXJwrilsGSTmS8MRrFJAO5bDwhD1HO6Nli7pU0Q/2SukIE5zKft75ancpb+BQsPUQcdK7YyZZ4ywo3nbZz+mZFCGJa7USJBipButAFBIsIR4js=
Received: from SJ0PR03CA0250.namprd03.prod.outlook.com (2603:10b6:a03:3a0::15)
 by PH7PR19MB7412.namprd19.prod.outlook.com (2603:10b6:510:27e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Thu, 31 Jul
 2025 16:01:25 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::8b) by SJ0PR03CA0250.outlook.office365.com
 (2603:10b6:a03:3a0::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.14 via Frontend Transport; Thu,
 31 Jul 2025 16:01:25 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.8
 via Frontend Transport; Thu, 31 Jul 2025 16:01:23 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 7E260406547;
	Thu, 31 Jul 2025 16:01:22 +0000 (UTC)
Received: from lonswws01.ad.cirrus.com (lonswws01.ad.cirrus.com [198.90.188.26])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 4C7EF82024B;
	Thu, 31 Jul 2025 16:01:22 +0000 (UTC)
From: Simon Trimmer <simont@opensource.cirrus.com>
To: broonie@kernel.org
Cc: linux-spi@vger.kernel.org, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        Simon Trimmer <simont@opensource.cirrus.com>
Subject: [PATCH] spi: cs42l43: Property entry should be a null-terminated array
Date: Thu, 31 Jul 2025 16:01:09 +0000
Message-ID: <20250731160109.1547131-1-simont@opensource.cirrus.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|PH7PR19MB7412:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 122519dd-82e6-45c4-39ee-08ddd04b7ff5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|61400799027;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oFaRpScOtHCgHIGU5N3nVEDpWEEdwZwl4jhsu8e1ZllVpR4+tKQby+I+luzB?=
 =?us-ascii?Q?xJFM/hhWTugFJqmmnEU5BhQegU4ynNKu0gb0vZBybrmVeymW4gCrYQR8w76/?=
 =?us-ascii?Q?WQZm3mLQOpKpDVjDhud3Eo/3IdJl+bdqhl8ljgRzGnhUgFTQcIWzk+y0F717?=
 =?us-ascii?Q?rWm5k6B/W23TkJXcR+M3O4esuZgGwdAuywYSvYBrPReWDxzlIb3SCJx1ROug?=
 =?us-ascii?Q?meUX9/aY/pD0vEJ7NagHXZTYw6mS54mRV1fPIHpb/4m0g//L2DWagxoxJr4c?=
 =?us-ascii?Q?eFgCHJfKZG+Ph5sRgjk1XQ+IW7d4BVanxc6oOcqYuZ2rpcn60PGcKTt62JC0?=
 =?us-ascii?Q?rAGjEhwgtTdd1AhMvYqbc2fKn7dH5+21ZoYhgoKCJlBaoUsrZaW1mRT1POlw?=
 =?us-ascii?Q?eqzl1n3vnyHpKFoh/gv5RBBbtRGLXXB6atG5IdCzavFeFN9Ohv0GbIHTLjXf?=
 =?us-ascii?Q?S2VEnCmep73ro9BJ6G5d+rc0KCE9/Ui1235eyEFW7idBUJdjjaU658XkMLEK?=
 =?us-ascii?Q?tyPYSoffusLsXWq1653JTp69yxajciXeLfEA/AD1Eh9MLEJ8pxg7/6D9DGGo?=
 =?us-ascii?Q?ARDBWbzjn+XZSwsybC7LJVWJmCv/7RBv1s7yfMJ/xembZY7CL7kw4R8MTbDg?=
 =?us-ascii?Q?6ChW5l2wKsyGpGrJfMUVBzlVN9nr6uqjx9QEuh+dYt6xUlBGR8axeSTR+i4h?=
 =?us-ascii?Q?uF9FdHGRI0GQ/evz+z49LQguB6Ke4U5AWHZVr5WlV2vS6A4TUnMpk3/0kM8h?=
 =?us-ascii?Q?c9llZ7E8rBaNN91epEMLtRmujgn81bxuAEqhxm1OhLhNacRftq/mLZXJL5gZ?=
 =?us-ascii?Q?7bOilB4uJLV1IHYXF+zhtX0pG1HXNgSYJJkkc98BI0/XdvMo+h/KB4vvoJud?=
 =?us-ascii?Q?vfhPoPTd0FaNDd+F51lSxB7y7lJqrq9S0uTTg5YczceOf3KNf7RUk6Y3kKel?=
 =?us-ascii?Q?YDkfEmSWNoYHrXyVNT77p6z+bpBcnjlzMlm0Jir3Yjf/mocxwi/bzVX0oJ7P?=
 =?us-ascii?Q?cp8kWvhp4ihgfRPHhTlW1i1FNOgMtPIg7YfVwGwnbTZVUqShThPpuNBFLBaS?=
 =?us-ascii?Q?eUlm+vxE3QjyDjFlAv1F8nSvRXtHHgrYJSPsDkbBvdQXHirdvysfKvFISFDw?=
 =?us-ascii?Q?uo+KvG5ZgiWpUE0c2ZZ/CSkPcC72oaXtoEBY1wa0rXfc33z3/Ey7HAk3bohP?=
 =?us-ascii?Q?KQcJ7Wg4sdysf5MXtIBSi8wJC5VrZ8MTj0K2JAZpmAYkg8Yy4KGMl1qpmdaP?=
 =?us-ascii?Q?uvLzwTGi5/P/VVfRpZ0TPg/S2vhCTrlQGNvPr6qjGGUIIHcSgybZ5bcKeQFK?=
 =?us-ascii?Q?7x5R7U/qVRxlI04dQlpfAM3da/1chjAPICAJBqdJdi+YRLZchSn6jAXEVZtf?=
 =?us-ascii?Q?clf4bmPJLyPKsDwIBPR7RnRr9MWaIVtPlcfReBoClEJxJc8hEKlR3ota4uWW?=
 =?us-ascii?Q?k2JGEUhE60PfyzIVECvZGi2i1Riai1Oj9aujN5x1eZY+RVqyUVvc6w4bee2K?=
 =?us-ascii?Q?1EnxtPNFUvthBe6tsMcQjvnHj6v81sYLY03g?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(61400799027);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 16:01:23.8145
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 122519dd-82e6-45c4-39ee-08ddd04b7ff5
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR19MB7412
X-Proofpoint-ORIG-GUID: j_PugTjKdR0FUuWzfzHe1kAlkePzySBB
X-Authority-Analysis: v=2.4 cv=Lcg86ifi c=1 sm=1 tr=0 ts=688b935a cx=c_pps a=OlAd6myHLz+OteJZ2xboiA==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=Wb1JkmetP80A:10
 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10 a=VwQbUJbxAAAA:8 a=w1d2syhTAAAA:8 a=w1S5MgMd2ar8CtFz09gA:9
X-Proofpoint-GUID: j_PugTjKdR0FUuWzfzHe1kAlkePzySBB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMxMDAxNSBTYWx0ZWRfX5MNAiuzrTGGq qZ8GD8r/rKKm4pWcuWnT151qRBlluhvw3NydHYXJKNPRvMsjRNs3YWaqhrdn3jEl9sJeEI5rHnr hjDk7oTLTRzgX1+fUaPh1BNn0HYQdF+Pj9X+ex6w4/9nrEuTo0dZabSPOMQZILyfJeJNY5IOju4
 HDE666VBuR7xpFaDspKz+NtBynWZg4vXAUqNOsilYoi5qEBmGAdoTb0zwWqur5FhjGv2t9RZqT7 xqI2LEOYAkanmv740xPpLLwFj09Ex0k2YV9ItcyIJw+BaoKAsxpiFK23xqSrNm8kRw5W8YK6u2A ljzZKeV5tiOU1i49RYAeHSv5O7YQuIFmRmlolg4BJ0xxwsAGMUH6Zs34X/oxtvEoOoN+WKzZ91B GVxoSc8P
X-Proofpoint-Spam-Reason: safe

The software node does not specify a count of property entries, so the
array must be null-terminated.

When unterminated, this can lead to a fault in the downstream cs35l56
amplifier driver, because the node parse walks off the end of the
array into unknown memory.

Fixes: 0ca645ab5b15 ("spi: cs42l43: Add speaker id support to the bridge configuration")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220371
Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
---
 drivers/spi/spi-cs42l43.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cs42l43.c b/drivers/spi/spi-cs42l43.c
index b28a840b3b04..14307dd800b7 100644
--- a/drivers/spi/spi-cs42l43.c
+++ b/drivers/spi/spi-cs42l43.c
@@ -295,7 +295,7 @@ static struct spi_board_info *cs42l43_create_bridge_amp(struct cs42l43_spi *priv
 	struct spi_board_info *info;
 
 	if (spkid >= 0) {
-		props = devm_kmalloc(priv->dev, sizeof(*props), GFP_KERNEL);
+		props = devm_kcalloc(priv->dev, 2, sizeof(*props), GFP_KERNEL);
 		if (!props)
 			return NULL;
 
-- 
2.43.0


