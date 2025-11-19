Return-Path: <linux-spi+bounces-11350-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D59AC70437
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 17:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E8CEB353C0A
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 16:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A4E3538BF;
	Wed, 19 Nov 2025 16:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="fko1ZBnd";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="Sk+d1TLw"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D2134107A;
	Wed, 19 Nov 2025 16:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763570437; cv=fail; b=DpaNGeMp1Mr+w28D9OBpzViIWy+yUwwekXmYKp8mNUGV3Qmd3uY0dCSxExuOuxhaGm0QMoO+3aFvwLIsapGkuDakbyKN71UKvcoTDE8uih2xV0IEeOTDVIwgTEPWIDIv0GqLFXgtbAczPnRMssYeCpvEcB5oiLCe32XAkysfdfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763570437; c=relaxed/simple;
	bh=+2D/kvvxP/sYr19hl5knus36FU6v77kWQX97gLl99k8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JtD1p5npmyq1PV9RZxdvVOvUSurUKt+zaz6j8U/xT0Z0HVlrSUY7RZn6bmlmbHKu6K8hrvjvaLPt3BtwW/M9yxBGhqqq0EG2RIzTqGuOpAvxyDxH7ybdPi538sNwcUe3MrE+cgLeyugYV0vXW5HJkk3B9kLkRj5GsmxG6YsFuVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=fko1ZBnd; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=Sk+d1TLw; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AJ6MDSq2221820;
	Wed, 19 Nov 2025 10:40:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=3o5kpAx8wNM/9fC1
	3CA9EMvrxlPNxabVzygXjpJbIXE=; b=fko1ZBndEex5ZLx2kre3wqXpAGxG3WEQ
	kDJleFEgBvzferqO5t+SDONjdv93INC1iC5xCORfGas8qDp7g8wAhWULZhZStG4Y
	LhqpMXBKy4ewYoVxoWn9UWGN4u4yp5q7sdOU8KQqMPsRj4QStj+UCAzgw3wBGsSu
	29f07vcgpOeOL/eFCO6VxktTjJJINk0LERuvaR31jGd6nmVxPsUI5aY68x1W5hxg
	AnsjR2We5ck9HaJodHF6ryrBMQy8Ltf82n+9YZ8o3b1X7SsgDPk1V9xh+VwKV4cZ
	xBjoaSplDT/Cxzf571c2p5elYw+GowUypgo9k0rS/gqKnK0nxwPIjQ==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11023123.outbound.protection.outlook.com [40.93.196.123])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4ah1bm96ee-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 19 Nov 2025 10:40:27 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qBzgN4ilG3cGOThWkaRyi/dfiGfHI58ceU2kDCmYMfxvm8kxO7zoB5melSMZN0trnqUPW9odqbybglt+SV41G0kVhsrpIqTnwo3zvDwUBSjnKqyjxT5E8XaTwPqD+lrclsyxgsRL4SXsGNhMWHCc600N9zEdAJqasY9SfKrMlxp2plH4wOJUTDHGFkRv339fZmdQX/usss6H9BosIweJUg3Tk/Tp1hkdr8S5uv86fpVYMTnN/22/KvFDoPRsYdpLBPUz7RP+Qf3stYfY+wOCI8xtEVLYNPq7XCD9ggcd98Br/Oy9QVts4oVk/DUdsu96Lim4/t+ZryH5gEe5U5UT2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3o5kpAx8wNM/9fC13CA9EMvrxlPNxabVzygXjpJbIXE=;
 b=N8NLrTuSyDjoU/1h8LB3qJI3MKV0befQZwwqKoWKxZ3v7miGKoE+3ipD6YaOXVTN1Ehg1uGCJzz4PZEyMUI7RginCjDmxOVh/xMd4AAtMo9fQWasafvSob4zd1x/YalHxIq0D5C58EOj6GMMt+WS6hznPEhN1j8yXs49LqRlo0HtjWbfSFZUhjtjVDJ7US5qjJDcI4AVtv/bFJ8Fv2vudXfBfWXoeiKHuEt1O38vTZErdszXW0aXZPioLth2Hc33R5+CJW6ZO/M02ulND8pSD+OwX/ePJHNjojUbYSGChcC2EKu3YEWnZzntOH3dZq+FYwIV60iXjSBH1RaqtXqm4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=bgdev.pl smtp.mailfrom=opensource.cirrus.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=opensource.cirrus.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3o5kpAx8wNM/9fC13CA9EMvrxlPNxabVzygXjpJbIXE=;
 b=Sk+d1TLwEcfy7r5vrTC9X5VH8vOjX8swScFGlbNUdchM6y11Fo2o7QwSTvLM+cfJ0N4rcK08Z0a0nnhpUgBdB16626pRpEnInH9+ezFTsPJCYpODb8Z28x2bES67PKeJCYWdPiZOzBjEo6o6qPURni5L1HVboSa7cYtJD5d4Ll0=
Received: from MW4PR03CA0150.namprd03.prod.outlook.com (2603:10b6:303:8c::35)
 by SN7PR19MB7575.namprd19.prod.outlook.com (2603:10b6:806:34f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 16:40:23 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:303:8c:cafe::d2) by MW4PR03CA0150.outlook.office365.com
 (2603:10b6:303:8c::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.23 via Frontend Transport; Wed,
 19 Nov 2025 16:40:23 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.1
 via Frontend Transport; Wed, 19 Nov 2025 16:40:22 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 1AA7C406547;
	Wed, 19 Nov 2025 16:40:21 +0000 (UTC)
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id EBE70820257;
	Wed, 19 Nov 2025 16:40:20 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: broonie@kernel.org, brgl@bgdev.pl, linus.walleij@linaro.org
Cc: andy@kernel.org, p.zabel@pengutronix.de, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, bartosz.golaszewski@linaro.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: [PATCH] spi: cs42l43: Use actual ACPI firmware node for chip selects
Date: Wed, 19 Nov 2025 16:40:17 +0000
Message-ID: <20251119164017.1115791-1-ckeepax@opensource.cirrus.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|SN7PR19MB7575:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 7cf8185c-6c07-4a07-e20a-08de278a5592
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|61400799027|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yC1LkVTx2WzHuPjqfClWyf6k9bKZyObyL+/ARlvhJAsoUPp4gye3+NP374O5?=
 =?us-ascii?Q?aO2yfoFaoy6dbTEHE/xUKNxNCqi1oJf3hVvZDlBn6Z33Tv09Nrdnh7d31uF8?=
 =?us-ascii?Q?Xsci3E7FgpkIY1jG1fnEcp2aVBft9TFcEX1YSn6CE1m9YUsmF/KgdffgdCp/?=
 =?us-ascii?Q?mcKAeVTtKg+FSQbBmWPRofuuGa1PHHw+IHiECpnsEkCAjsZUaQIX4lD36zdP?=
 =?us-ascii?Q?nklYq5VXrIFnMMy18voOth5FZg3vzFNxDOJ421L52L9jKSfoYsVEB8Z5S+iZ?=
 =?us-ascii?Q?X3lYnPUQ9mI6BbfOH2Mwyy90vQoC2E1Ur/9+W2ag96qjUb/2LEX7OSL+HnyQ?=
 =?us-ascii?Q?37fQ0ZvcB33f01oDCwxrCdDglZlUnt8RNx2PywcoKhddDbBz6Kh8HdEKjvVG?=
 =?us-ascii?Q?2Ypb1p7tTrmnz1AsWXd+3eQlS+LPjcMwXO/LQFCm2Vmz666iFg/tYDq1H8Wy?=
 =?us-ascii?Q?/sRx8QaFjrpmNPHtq24kGcbuuTVuxdghipFYBYo9rwx2uQv1njzPqbd18NB7?=
 =?us-ascii?Q?yoojSi7NaWCLYPOQbXzzerss9dlrIChXY8d9z6U3vNma/mYKS+51WGjgC2iN?=
 =?us-ascii?Q?AUvnPWLGK7/hfvGbEN6fPRp1XHSKFoTt6v7JpSpRAahwGwmxdHWoil9N8lQw?=
 =?us-ascii?Q?BmnAUU7nS9A/DNMAUYevvzsAxW+zpKspQJssZ869ltNUmzKb1m/xNDDk1PeH?=
 =?us-ascii?Q?rXJM8mh9aurm/lrvA4s6g1pkjezm2E0NqH1tb03NfbPPV29rjgtbE9iQdyAN?=
 =?us-ascii?Q?ql8RkOe2WJ57bOaxLh35J0V/XWI7OzACTHILW55iis1xyeoCZHHTjyoPD3VE?=
 =?us-ascii?Q?3I7fA0e0w9/IyFHKOnwX2zgYUGzUSoDcLgXXrS9PtIBQ5njqrVMyd38vi/3u?=
 =?us-ascii?Q?P8Bix+VDXgOjqXKYbDx93RbkR2HRQ1WYZaPRWZqHmAS1Xz41IfD9a2zp4ZDQ?=
 =?us-ascii?Q?SECWbg4yo4dyULVqLZUBKj5+j+QoMfHy7tC3E2sAgBF7G7Sq906I4XI2uqWO?=
 =?us-ascii?Q?oH4omtHtsyc9hf24Ydxm+Pme1gMewZEZxYxlpi7HhExAh74rHkAAgyFuGPru?=
 =?us-ascii?Q?a7iHOZoFc37f6ydqiJ4uZ6fy9W+63Cy9wrvUAnp9wbq13OdUsRrovkQM4Mig?=
 =?us-ascii?Q?PkC5s7uSBlF/1YENhE0BbYg9Sldim26p3Xcw0ZZN8nDaomLVD3Q3nTlE/WZq?=
 =?us-ascii?Q?x+FhwKm3RWT5k9JPQWjlKK008YCaZFq4Y1pCsMDxw0YJjVkyyPRAEQIl49N9?=
 =?us-ascii?Q?Ggs/9kdwOxOw0LLia/OFDFETR30pIcoJibsnOUz4v7MkjTKVwySLGzk7hmec?=
 =?us-ascii?Q?/VBpjdlCIpyvv7zf9Jq6taQodCRAzsxVTMN6vKS8/UJO5vQyFFBBEBQdA7yp?=
 =?us-ascii?Q?tYKReOu6ecRXZFamc0q27BvJbAMuTvEVBI0K0SAS9e3n8RoZmjyB7mkg80q4?=
 =?us-ascii?Q?dEbUPVSUe2q/Ns8/+CEAPCBMQVLnqFdC9upmIO3dtJ47YOBbTamRgRgIShcf?=
 =?us-ascii?Q?Z0mMQx9WbYaFrFSbSrL6VFX7ZukTYsunQmp5KyP3NBadUqWw1HW6Ur81cH0B?=
 =?us-ascii?Q?NrVGrUjpTU6utxvxZzk=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(61400799027)(13003099007);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 16:40:22.4521
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cf8185c-6c07-4a07-e20a-08de278a5592
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR19MB7575
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE5MDEzMiBTYWx0ZWRfX6dzZPTSv+S1I
 wycH6Kq6pBkk9eAh1u2UtR4mFghYS9nAZEoxpVgsSVbrNsioJVRxptP09Me4t4QZoYIC5e1eI/G
 rTfi4VQpAct8vt0/UUp4YSjZ7pVKFGUt22M7QcG/WbHl/yhpJGgaABKRpAgyaNjPJuYiZC5qiso
 xV0DnEXnZeBNvflUSNXDA1yHKFHI/I1Wrnalenku0xXSOvVyiAjq2Q+qrB1PjXlvAXInRNi1d60
 nCyZ9uiR0Cy6taVNkUq6nB7R2EAkDA2UuwN/MnFImN31CUMvmEuhWTwGB2RYHDJgmZre3dp5a4/
 g74I7ikPNpbCfzZ/+MuBtkxsiU574/4I+3HxiPQGJzHPu9TbXvFtwvbww7q3ulrHsE1IujEClJQ
 h+t30IGJMohtdRJeq5Mi6syN8nqXDQ==
X-Authority-Analysis: v=2.4 cv=XcmEDY55 c=1 sm=1 tr=0 ts=691df2fb cx=c_pps
 a=3JIx0no49nfI/nrzBlLv0w==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=w1d2syhTAAAA:8
 a=lx8XbjUHjB6Rkn_c2z0A:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: b_bs15M1y2lxczwe3EPKO7NFJGU2aG_q
X-Proofpoint-ORIG-GUID: b_bs15M1y2lxczwe3EPKO7NFJGU2aG_q
X-Proofpoint-Spam-Reason: safe

On some systems the cs42l43 has amplifiers attached to its SPI
controller that are not properly defined in ACPI. Currently software
nodes are added to support this case, however, the chip selects
for these devices are specified using a bit of a hack. A software
node is added with the same name as the pinctrl driver, as the look
up was name based this caused the GPIO looks to return the pinctrl
driver even though the swnode is not associated with the pinctrl
driver. This was necessary as the swnodes did not support directly
linking to real firmware nodes.

Since commit e5d527be7e69 ("gpio: swnode: don't use the
swnode's name as the key for GPIO lookup") changed the lookup to
be fwnode based this hack will no longer find the pinctrl driver,
resulting in the driver not probing. But other patches also add support
for linking a swnode to a real fwnode node [1]. As such switch over to
just passing the real fwnode for the pinctrl property to avoid any
issues.

[1] https://lore.kernel.org/linux-gpio/20251106-reset-gpios-swnodes-v6-0-69aa852de9e4@linaro.org/

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

Ok here is what I would propose to fix this one, IMPORTANT NOTE: this
does depend on the first four patches of the linked chain which I don't
think are merged yet. But I would argue if we are removing the name
based look up, we should add support for fwnodes at the same time.

 drivers/spi/spi-cs42l43.c | 35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/drivers/spi/spi-cs42l43.c b/drivers/spi/spi-cs42l43.c
index 14307dd800b74..b7dd5f6ecc30e 100644
--- a/drivers/spi/spi-cs42l43.c
+++ b/drivers/spi/spi-cs42l43.c
@@ -52,12 +52,8 @@ static struct spi_board_info amp_info_template = {
 	.mode			= SPI_MODE_0,
 };
 
-static const struct software_node cs42l43_gpiochip_swnode = {
-	.name			= "cs42l43-pinctrl",
-};
-
 static const struct software_node_ref_args cs42l43_cs_refs[] = {
-	SOFTWARE_NODE_REFERENCE(&cs42l43_gpiochip_swnode, 0, GPIO_ACTIVE_LOW),
+	SOFTWARE_NODE_REFERENCE(NULL, 0, GPIO_ACTIVE_LOW),
 	SOFTWARE_NODE_REFERENCE(&swnode_gpio_undefined),
 };
 
@@ -324,11 +320,6 @@ static void cs42l43_release_of_node(void *data)
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
@@ -391,6 +382,9 @@ static int cs42l43_spi_probe(struct platform_device *pdev)
 	fwnode_property_read_u32(xu_fwnode, "01fa-sidecar-instances", &nsidecars);
 
 	if (nsidecars) {
+		struct software_node_ref_args *args;
+		struct property_entry *props;
+
 		ret = fwnode_property_read_u32(xu_fwnode, "01fa-spk-id-val", &spkid);
 		if (!ret) {
 			dev_dbg(priv->dev, "01fa-spk-id-val = %d\n", spkid);
@@ -403,17 +397,20 @@ static int cs42l43_spi_probe(struct platform_device *pdev)
 						     "Failed to get spk-id-gpios\n");
 		}
 
-		ret = software_node_register(&cs42l43_gpiochip_swnode);
-		if (ret)
-			return dev_err_probe(priv->dev, ret,
-					     "Failed to register gpio swnode\n");
+		props = devm_kmemdup(priv->dev, cs42l43_cs_props, sizeof(cs42l43_cs_props),
+				     GFP_KERNEL);
+		if (!props)
+			return -ENOMEM;
 
-		ret = devm_add_action_or_reset(priv->dev, cs42l43_release_sw_node, NULL);
-		if (ret)
-			return ret;
+		args = devm_kmemdup(priv->dev, cs42l43_cs_refs, sizeof(cs42l43_cs_refs),
+				    GFP_KERNEL);
+		if (!args)
+			return -ENOMEM;
+
+		args[0].fwnode = fwnode;
+		props->pointer = args;
 
-		ret = device_create_managed_software_node(&priv->ctlr->dev,
-							  cs42l43_cs_props, NULL);
+		ret = device_create_managed_software_node(&priv->ctlr->dev, props, NULL);
 		if (ret)
 			return dev_err_probe(priv->dev, ret, "Failed to add swnode\n");
 	} else {
-- 
2.47.3


