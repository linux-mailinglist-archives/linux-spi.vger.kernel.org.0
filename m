Return-Path: <linux-spi+bounces-11388-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C28C73986
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 11:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 4A8DA2A8FE
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 10:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B07732C94D;
	Thu, 20 Nov 2025 10:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="CPnDEHlp";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="uj9rnhhQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C91932ED36;
	Thu, 20 Nov 2025 10:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763636371; cv=fail; b=pS5YHZCJ0vbnDDxWrQDKJ3Deba5WzyDzZOWbtQDMgu2E8523KBng9/fze6edbLrdRNXyT148i1NmZHaDHQ64n0O3IqG9QMkbvXs/ntrB7TmFPXgI9oUKmXnpnm5fn5LR5bSsdcilqW5WNByzH9M+Adczwwl0keEFMzwnCY7tTi0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763636371; c=relaxed/simple;
	bh=cOpLyl9LQkwXD/Ig2bLB8L1OGdEONsIVtT4F0SkAhbc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XKSSXNFRwuXztNlHwVwmEgFtk8Qk5pVbT9TOa0wysbwutDvo07ZgcIlqUezAMjpUICTWTx1MYsmTxDJl9o502tclKN4FOBlXwriydYE8e2VzuUlk0W3N87D/Kvfecx1XoONjYzJgKfMHhXbEaueL8TKXig/lDDYamYYm7LOGR24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=CPnDEHlp; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=uj9rnhhQ; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AK4fZTR247388;
	Thu, 20 Nov 2025 04:59:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=6RYO02qH8ExjJZMF
	szUVY/0OoGNDmJ3iXeqpKP/Of5Q=; b=CPnDEHlphLyEBjitINaoyo0J0WI5+/Xa
	D4nVxj03dCWLcRyjIszLKdsPcVJlY/EM/95u5J+QgB8xCt39HqKn4OJjAKvshawB
	33+F+P3Q2D88iTaz4vD1PeGsPpM6yZI/70m9Xhl8vEnhksdjAxOr6lfJd5FnSOEr
	q5IVEyfgg7hng98HutwTppLIoUm16y3oXQdNvn0CoPFBrdXSTYU4+DeBSwEKRBZk
	sDfHhB2TGJYMCPrVAhibW58MrSIRClhxMZG4bLahI2KgY70pFtkHA+XEgr+p6yo+
	qMQr4Cs42fF0TGpBACWOBaycML6STfYB0uR8Y+TWtrGuBNYobSxP5A==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11022119.outbound.protection.outlook.com [52.101.48.119])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4ah1bma7av-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 20 Nov 2025 04:59:22 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z9WrBbJwCsTHe2LPhVIvd+N/cIKeDpX0ITmlNopELUy0DtMbO9cGjto8/9WJQKHEMSmA9eSBCySFXZZvR6sO0dsFJOrYTK3v7f7R4wzg+pkUmwV7TJPM2T0Dk0bSUU68EylFjQX8/hURS77mT8NVDk7Ee/acNZbelyyTqP3ZLswsic6WVBQ7HBDgZfSMxHhzCiv1+7M1Tz0Z9n1LXT00wwGRCDMLoyPQQV1B5AsMfJu08X/8zfBmVYBXCAIGPE5yccmj7gXFlXWNW1TVFSvcV29U0Mt7Mx4v2Oje4aqM8DO5fqai3J80jev/OShbf5zwxvu2jA4pFNOiw+zBmx6IOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6RYO02qH8ExjJZMFszUVY/0OoGNDmJ3iXeqpKP/Of5Q=;
 b=mgU+hCrI+1C3dT02UxFhWotHkW/3O0/2YaeLfuUZ6ImAzQV2x1SpE7pqUkWJnl9ZkspdBWwAUExCv+5m7zk+byV8hsIiw9teE+qHrOZuyaNprV+qAcH0wMqQcn5i8bfK1ozV/E3cLob8zxss0AWY+zg6MVclA8KAfFEWQRnP+T8JwG2MxeieI/0nCcvbNr11mzBAqP3oTHs3iYAVB6RYbCEIZxLy25jk9z7Bc/jZ+VrFDArnlFKQHfmagNwfWvrcGu0uCRfOSvmypOTIqqgHQMCh48JUMamXblWHpbBGSVvk11/aQrd1SGwWdGVsQo9I9tOAze1hU1UD3+1u/ujy2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=bgdev.pl smtp.mailfrom=opensource.cirrus.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=opensource.cirrus.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6RYO02qH8ExjJZMFszUVY/0OoGNDmJ3iXeqpKP/Of5Q=;
 b=uj9rnhhQ1xohEQRJ/ybdPvQS/gJPfaXc+Sm399i9YA0soTji1IR9xCi5lQC8gRbXgUxGK0w9igH1gKOl5/vWQZkzmyMtH/NrOgBxl6qsn4v2YdBpdh+12lGr+N1iZrYWJtT3l4v6ydezgACuiMCIR8yv4j399jxMVk5PrYvfkiw=
Received: from SJ0PR03CA0236.namprd03.prod.outlook.com (2603:10b6:a03:39f::31)
 by SA1PR19MB6669.namprd19.prod.outlook.com (2603:10b6:806:258::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 10:59:14 +0000
Received: from MWH0EPF000989E6.namprd02.prod.outlook.com
 (2603:10b6:a03:39f:cafe::28) by SJ0PR03CA0236.outlook.office365.com
 (2603:10b6:a03:39f::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Thu,
 20 Nov 2025 10:59:12 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 MWH0EPF000989E6.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.9
 via Frontend Transport; Thu, 20 Nov 2025 10:59:12 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id E754F406547;
	Thu, 20 Nov 2025 10:59:10 +0000 (UTC)
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id CDD18820247;
	Thu, 20 Nov 2025 10:59:10 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: broonie@kernel.org, brgl@bgdev.pl, linus.walleij@linaro.org
Cc: andy@kernel.org, p.zabel@pengutronix.de, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, bartosz.golaszewski@linaro.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: [PATCH v2] spi: cs42l43: Use actual ACPI firmware node for chip selects
Date: Thu, 20 Nov 2025 10:59:07 +0000
Message-ID: <20251120105907.1373797-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E6:EE_|SA1PR19MB6669:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 48dd8703-54bd-41e1-4b7d-08de2823d6cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|61400799027|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+UuGovXi3lMIvmIGWSROHLSFXiqW2CKwvTElpnxaG7Kgx/wnd4yijGxUmU8I?=
 =?us-ascii?Q?kGjzzjOEpLWDvaAmqHq3qQM96an8NeRbPpAQzdanGAySzmZ5Cuwh7137H8li?=
 =?us-ascii?Q?6Z5SEG4+H4qp63JGAKaf/sGF/CvtskmSSfoTeUcBkySobooFzK5HeL8CkrxK?=
 =?us-ascii?Q?REXPKqeN35diXLwuyNxXzoCd6m+T6K9PoXkPWLHGk1Dd1+SD+vxdgv7xOojk?=
 =?us-ascii?Q?OOVLC+OEYA8SpX3zQN6RSImAC1znf53ajxCbP1FVHmjnR4OKMM7jBQerZgxD?=
 =?us-ascii?Q?3He7s2lCUP7+cvcVDQ8G3pYQ6dKr5YBKI9mpvX9BMaFOzzB5G53ns2FYefkc?=
 =?us-ascii?Q?Vknzd8KSyLi5w1uCmz+LCm9mN+VPGEXH9C3E4t8I0blBz8kNO1izyrLsQ0ff?=
 =?us-ascii?Q?nBAD2mttFhu3ARJmjob8CF0VH59led+QKYV/IOpChExLO+qWbLrfhC6lq6k3?=
 =?us-ascii?Q?fyTDpqhYCXFO7gfjuR9RSoRPAzf+C6aOIVMe8wtIf+eGp1Frx6dyXF5PNh5z?=
 =?us-ascii?Q?obVdSfbl2SNTSR7AKS19H/rtS1W/fgQrpYFtIgbQVLg9tjB0sB2kbs7zpp04?=
 =?us-ascii?Q?RURQfZknIJhmLCul418qrFlPWKN42uaJGQfgfHnhVwoWa2a7HD0MJEkkEWdV?=
 =?us-ascii?Q?DLK6O+HuBac/WMumfjaFnVpUApGNLpEkQzBMc85N+6cD1JsRbcrrJrlNcRcZ?=
 =?us-ascii?Q?9AreJ4ug2doAfJVYyGxtTG3c6IpGUhATphMv12bGYnFgdXM5Hmw+K7xulktZ?=
 =?us-ascii?Q?RO5n49eHiLpVUllmdwhPM6Id6dIyrIr0D6Ps9/waAiduow1ZLjrD88rDh7WA?=
 =?us-ascii?Q?2CYlv8yFhFRVcvcgYo2JVePOV8VXV5ypiWPEOki0XdftxNBBMy+HhgPi7NBW?=
 =?us-ascii?Q?YPIhSYE++sN9NPI1IR2zsGSks5B51Ias0JgSsmGJwMnDTHfD7NhYRK4xUZrB?=
 =?us-ascii?Q?dBSkd1l0VUnXKoAYJ0KharphzTqssGF9GDi+W0EAVliLeXnjNs/MFuBpGOPL?=
 =?us-ascii?Q?PWhSJcXIJuT1aQW/Sy3GVGK1d6G/AXRAnNWobH0K7+MO5BuoQ/1qk1xpHqzC?=
 =?us-ascii?Q?4CpCzHgcx7VoyWMGizgsB8aYxYorZtsNNyoGsqyFP+332y7yau46MwqExhTc?=
 =?us-ascii?Q?DnQVnPhivOMrsnQKB9xjeHLFwflItGhjUfTMwWuAiV4bfLs3p3p/alsHZ+Sy?=
 =?us-ascii?Q?SdGGiFCqp127bsjM/9by6RQX4iOD7je5i7QeMQkzZWuLyt7HzJ/bgVE22KKO?=
 =?us-ascii?Q?0TsAR3/xj59+UtYsOD/cIstMGAfT2UEhqtD/nyP/GuXRx2f+adPOu5otoTaH?=
 =?us-ascii?Q?LbXPFlEEzYDkBX5I/uvZYicBDxXTZ9pBZJO8RR+tnAbBPSrf9Cjkj4gYXODK?=
 =?us-ascii?Q?LYC/HMdoatBlWVznjl1GfeRoTpKCbHbYboZZDMwu3zLb9No2ptevNYR5DeqD?=
 =?us-ascii?Q?3hRSepcbUmux0Aj2iPN8/la4TTvtSUMPvwploscqibz4PvTVGqYTIYku8Kzj?=
 =?us-ascii?Q?zZCRX280F6LtdQzzpAi79myLVFOZbwcrzokIIuF9ImfHfl624H1jHZVlKqsc?=
 =?us-ascii?Q?tDdpFvEBfYKBtipoizw=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(61400799027)(13003099007);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 10:59:12.2640
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48dd8703-54bd-41e1-4b7d-08de2823d6cc
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MWH0EPF000989E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR19MB6669
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIwMDA2NyBTYWx0ZWRfX1FfmZqZh2Drf
 EqPdt072s9L40cW+rwIaL1WRyWMZ2KZ5v3MwqwkYVAYxm6lL12t7YpdQ1kMX/dR/MiW5LWoj1+p
 BbDUUGYYwocm8NdRuEnMAVSl0p7q7TspgCDI41Z/XsbbZ1x3AYlVAr1Z7Z1m9BxPrySthsto0Kt
 JnWwhbqZkUDLLU2mYoypLWsK2Qf+wYF3i4WxmdFGQn618e6lzfTYIzJfEmHIBKHFuvB6EcRtebL
 4kWka/DabzfNEVrtiB7sEuD9sEZIdxYIzjP8mvno60ba6boKrP+gELxa9Q+nNieuGRw662V1plj
 BPqwBYhfBCwk3/WOuwR99Rgh/wCX0mgzw3Hq8jOeIRTMtroTwn84vzd1C1ZGcwcnrh68ZOo/sBV
 gZJIq2JPsUvqe5kEHtVl6bLjNYOIUA==
X-Authority-Analysis: v=2.4 cv=XcmEDY55 c=1 sm=1 tr=0 ts=691ef48a cx=c_pps
 a=xSzMZOIKDOBgwsc4tMfFrQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=w1d2syhTAAAA:8
 a=fgxdDTbAg5jrxkgt21sA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 7y1PwuU-hr7cYHkv4szhVvkx69qYBtXJ
X-Proofpoint-ORIG-GUID: 7y1PwuU-hr7cYHkv4szhVvkx69qYBtXJ
X-Proofpoint-Spam-Reason: safe

On some systems the cs42l43 has amplifiers attached to its SPI
controller that are not properly defined in ACPI. Currently
software nodes are added to support this case, however, the chip
selects for these devices are specified using a hack. A software
node is added with the same name as the pinctrl driver, as the
look up was name based, this allowed the GPIO look up to return
the pinctrl driver even though the swnode was not owned by it.
This was necessary as the swnodes did not support directly
linking to real firmware nodes.

Since commit e5d527be7e69 ("gpio: swnode: don't use the swnode's
name as the key for GPIO lookup") changed the lookup to be
fwnode based this hack will no longer find the pinctrl driver,
resulting in the driver not probing. There is no pinctrl driver
attached to the swnode itself. But other patches did add support
for linking a swnode to a real fwnode node [1]. As such the hack
is no longer needed, so switch over to just passing the real
fwnode for the pinctrl property to avoid any issues.

Link: https://lore.kernel.org/linux-gpio/20251106-reset-gpios-swnodes-v6-0-69aa852de9e4@linaro.org/ [1]
Fixes: 439fbc97502a ("spi: cs42l43: Add bridged cs35l56 amplifiers")
Fixes: e5d527be7e69 ("gpio: swnode: don't use the swnode's name as the key for GPIO lookup")
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

IMPORTANT NOTE: This depends both functionally and build wise on the
linked series from Bart, it probably makes sense for him to pull the
patch into his series.

Changes since v1:
 - Add missing tags
 - Move swnode config onto the stack, since the core copies it

 drivers/spi/spi-cs42l43.c | 40 ++++++++++-----------------------------
 1 file changed, 10 insertions(+), 30 deletions(-)

diff --git a/drivers/spi/spi-cs42l43.c b/drivers/spi/spi-cs42l43.c
index 14307dd800b74..43079f292d6f7 100644
--- a/drivers/spi/spi-cs42l43.c
+++ b/drivers/spi/spi-cs42l43.c
@@ -52,20 +52,6 @@ static struct spi_board_info amp_info_template = {
 	.mode			= SPI_MODE_0,
 };
 
-static const struct software_node cs42l43_gpiochip_swnode = {
-	.name			= "cs42l43-pinctrl",
-};
-
-static const struct software_node_ref_args cs42l43_cs_refs[] = {
-	SOFTWARE_NODE_REFERENCE(&cs42l43_gpiochip_swnode, 0, GPIO_ACTIVE_LOW),
-	SOFTWARE_NODE_REFERENCE(&swnode_gpio_undefined),
-};
-
-static const struct property_entry cs42l43_cs_props[] = {
-	PROPERTY_ENTRY_REF_ARRAY("cs-gpios", cs42l43_cs_refs),
-	{}
-};
-
 static int cs42l43_spi_tx(struct regmap *regmap, const u8 *buf, unsigned int len)
 {
 	const u8 *end = buf + len;
@@ -324,11 +310,6 @@ static void cs42l43_release_of_node(void *data)
 	fwnode_handle_put(data);
 }
 
-static void cs42l43_release_sw_node(void *data)
-{
-	software_node_unregister(&cs42l43_gpiochip_swnode);
-}
-
 static int cs42l43_spi_probe(struct platform_device *pdev)
 {
 	struct cs42l43 *cs42l43 = dev_get_drvdata(pdev->dev.parent);
@@ -391,6 +372,15 @@ static int cs42l43_spi_probe(struct platform_device *pdev)
 	fwnode_property_read_u32(xu_fwnode, "01fa-sidecar-instances", &nsidecars);
 
 	if (nsidecars) {
+		struct software_node_ref_args args[] = {
+			SOFTWARE_NODE_REFERENCE(fwnode, 0, GPIO_ACTIVE_LOW),
+			SOFTWARE_NODE_REFERENCE(&swnode_gpio_undefined),
+		};
+		struct property_entry props[] = {
+			PROPERTY_ENTRY_REF_ARRAY_LEN("cs-gpios", args, ARRAY_SIZE(args)),
+			{ }
+		};
+
 		ret = fwnode_property_read_u32(xu_fwnode, "01fa-spk-id-val", &spkid);
 		if (!ret) {
 			dev_dbg(priv->dev, "01fa-spk-id-val = %d\n", spkid);
@@ -403,17 +393,7 @@ static int cs42l43_spi_probe(struct platform_device *pdev)
 						     "Failed to get spk-id-gpios\n");
 		}
 
-		ret = software_node_register(&cs42l43_gpiochip_swnode);
-		if (ret)
-			return dev_err_probe(priv->dev, ret,
-					     "Failed to register gpio swnode\n");
-
-		ret = devm_add_action_or_reset(priv->dev, cs42l43_release_sw_node, NULL);
-		if (ret)
-			return ret;
-
-		ret = device_create_managed_software_node(&priv->ctlr->dev,
-							  cs42l43_cs_props, NULL);
+		ret = device_create_managed_software_node(&priv->ctlr->dev, props, NULL);
 		if (ret)
 			return dev_err_probe(priv->dev, ret, "Failed to add swnode\n");
 	} else {
-- 
2.47.3


