Return-Path: <linux-spi+bounces-10555-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DE44FBCE84D
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 22:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C9C3B4EB17C
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 20:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595ED30277E;
	Fri, 10 Oct 2025 20:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="BhGhuLmx"
X-Original-To: linux-spi@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021092.outbound.protection.outlook.com [40.107.130.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0E8302761;
	Fri, 10 Oct 2025 20:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760129126; cv=fail; b=ZqFWx1WnvNJjeUzEOGrU+8s9HSLTuKuXhDJ/Od1WVGLMBl30EEKEMQkziPFUly+BUjQgkQAK/bTZL1yXA0PZEfABjwT6F6hJZ52ePwWWUZ4YpKgW9FFdSo1n1YbgvwYobyFOdtCOAhKM16Iuw4vP48pWrG2FUAF2SSVwheVSsCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760129126; c=relaxed/simple;
	bh=ln9Uv+JjcDjysM4q50VJX3fGqO1QoWoTBi9g3lH9b7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kwNKSTSQkRLDIP3twjuRCPEXZ46lwFVvzruwXzp1XGjhJY7aONhcCyb22w0UMER8+dykrZ0JAMvc5pDt0bsyKDrZUE2TDI1aRRX4U8Q8TsGW97pveNqvt/MGz732q46y+4cnPSYs2nFej9KKo0I6BXBEm8LKP7Y6odTuIyikGvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=BhGhuLmx; arc=fail smtp.client-ip=40.107.130.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oTvScJhiyCo7QYjy4rZoqRYzffnNtHEvN59x9btvrjKlMitasHhXMFo2ZbdSJlfXMAN8Jug7tMTx/LdFx5czfexx1/T6cUfiGu8HIlVfcqJuLMQNGYpdAkL6M/bIIAFE93CxaF+9PLjm5dqnAFA+Ck6KpityuX2Fl/JWl31qCFGyWr18K4OQ234gV13GYXQ3JhoOAERaQf5rChpw67u4bInidm5NopCyJ/8ozA5rJH4pCylRhKfWnxVatq0y3AHmoKy73tkGwQYiTsm906WOIpcHb8DkWMm8KSh2QnJB87XRxK38mk4y3Jypfcc/HrBa94Z/B4mfGLT9dr0BghhE+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oRs3E6XYJFP2n905LhT/DxgKVk6bbVkUK5bfx5yHGus=;
 b=qbtI5ERIkQcBWlBOoqHnJro/q8kcg2ACPcZoRJpeB8SrtHLAfwlc2KtRjhmN9g7h1LhXE0GxLbFOij18Oq1e0nOM6xuDI0v8ZLYkZK/v66xeaa6WpfRSiyxSniphk96LtWxZj8I2qnbZgkp1pXMOQ5aPnOHQrcMHyADFO40Jmk/LuIlrLNu62CxbCp7lMn4m1ww/DgA8jFC6UbvLTiG1llWBYQQvuzBRzSCBZ0XM3mzTc8cgUm7/dXncXsQVP3iZ5aXZkcnn2klefNVpttm3WtyChSq8gKTsReE7w6ionzUCC+9lEHpevqXBMK98KbW2hG8oveSP3PlstDAAm/U3og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oRs3E6XYJFP2n905LhT/DxgKVk6bbVkUK5bfx5yHGus=;
 b=BhGhuLmx+1xmvIrRv0hOEf+w3l1Ta8CIc6pUvBah3WNguFx5zghaQiAPWYZb0eajMWaWvURhQVQglHEuWY9OCV0rakubW4llkp+cqXlBals8IJ7rFut/MfC1TCwvodMIE92vtYOda9iydOscznAwHvMvxXGnpQNNZ5Mf+MeQV/XuBlZmDjE/qH4VqxJFf80+CH3WtCPRhPutg8AOFV5r7FBQ0f1B6nrTr+98LBEBKdpKrWBFo32CnmnqtCOMVW1RFEQW6dvC//88VyC4HaAgIsPMYIT649mszL7nZih9tJ/BIiE3R/LWBj1ZEPcHpiGOSjpu01dqUFJgyLxurCwRzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GV2PR08MB11561.eurprd08.prod.outlook.com (2603:10a6:150:2d0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 20:45:14 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 20:45:14 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
	Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH v9 04/15] spi: airoha: remove unnecessary switch to non-dma mode
Date: Fri, 10 Oct 2025 23:44:49 +0300
Message-ID: <20251010204500.1625215-5-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010204500.1625215-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251010204500.1625215-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF00011B51.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:8:0:b) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GV2PR08MB11561:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ecfd80b-b3cc-47be-74f6-08de083de9c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fgGy/Z4A2iLLVLU84YM4mCJ6YnDJkM4KYO8/1UCZB3BgOy0wGniUsSRRuOqM?=
 =?us-ascii?Q?hcU9a3KaSu+KeSeukM3/9If2CrtLfkZwx0UHWVBtBl0HNMacLkMPg+tq4yKU?=
 =?us-ascii?Q?IWdvWwLA7Py6Y37iCOT7AH0BomVFSk1wEo9NcY4tl4fJCNGEcYpmb41F+KgQ?=
 =?us-ascii?Q?BLnptvqpcG2PfzysUV76Nb0ai0sr+6pyHhBGyO/MV26VJiid4IIINCWS8/sN?=
 =?us-ascii?Q?ogA8XcgLyF2Z8gUIOBYzVKAJX7uXDVq1d5+JJKWrHaYbOntA9V81+u27ATo/?=
 =?us-ascii?Q?OdRB5O48e1wxg5VwdCqckjQU8Z7SNZY/w3Jrxbp+hqzN7cfeZl4RvseFQ4+i?=
 =?us-ascii?Q?7j6J16K85xG5Sy0GoBYeRT7cvWVQ+rxSeTFPT2V1VBfTHVniaPXueLGp2mGm?=
 =?us-ascii?Q?a25f/E6H0sIKk/6j5TsZ77Opm+FY75qGk765pe9///0w0Pw+hUSzmjbzsiV9?=
 =?us-ascii?Q?jJNwTwNvsoDVLHICEk8uAWTjE+c5SGjfCe4y54JfZduYzfoeDg4gSyD3Wpzz?=
 =?us-ascii?Q?Twvt/z5/Fm4sjsv9CfB47TRvDLT12BJUg0oGtX+FPOmEfdLJ9MkvCOvRHgZc?=
 =?us-ascii?Q?vFGyfgRNjWnnwVcC7lPRIfcwmqDovE0r3CLvxIpAM8WKh011JO6F/FeQ4CwY?=
 =?us-ascii?Q?NbQ1RchOBUdrMUYx8ot53BDAIZ1TUIZ1iwrDBqdABzZQ/7p40YBRWI0uRqdE?=
 =?us-ascii?Q?iKZ46AiDqRZaQPtewX/TpVwajft9QHYAL6iVx+sdp+unks7kd5vcbz8OYSas?=
 =?us-ascii?Q?nyesaII7PS/7l1F7xzuhVmvYEbKujuUpuXtvBHFiVjxar/oooTaZ34u0Q97f?=
 =?us-ascii?Q?XFXMzW8OPJxjOJhRnxehpmOy3FG4eqO0k43B89SyB7ynY5+G9w8G+TChHrLW?=
 =?us-ascii?Q?GmMiKSB1WXL1j0T6165x2S0uCQzkgZhzQ5X1C11EF6HkfOaVDdgFMzFsgSXg?=
 =?us-ascii?Q?pwa1A9YQZYzZyGUVsukOlNUU7saRjqJGTH71X+t7biMgwM7WvBs9yP2VmT61?=
 =?us-ascii?Q?94g2tVfHskHemWNf4y0SeXBqVCgKVb8e35WECL8MZpZudsDv4gWbwoEgli9M?=
 =?us-ascii?Q?vzI1dLq9mEDCaM61Nmi7yqpBEgjilpdNy87V2ImpaK4o3H8ckeP5iDYBTq69?=
 =?us-ascii?Q?iuYYIFjE5jNRdFmk5S5F+/rSUTZqywPBD8zNCUrMgundS1qPzOAgowem3eXg?=
 =?us-ascii?Q?6P1WtHd4mEnwp9ijLnGyVXdrn+NRqhCXMbztGCm4ZRDIdKaiN+ISVFb9Tet+?=
 =?us-ascii?Q?DlNsGizdnubCjNRpdNLfMZKZvIGRPABmIJkWPta4UnvTVq/MzZOCZSiOMhGm?=
 =?us-ascii?Q?QhjMRH7bMGjvhGFXOc55EFkDYd92m3fBO37S1QOROOm8v0FenyVN7mjgkbrY?=
 =?us-ascii?Q?g1uYa7fOMGxeOWDhXoc5NfwRxAhgwH9/agy1QBTVIbqYQ3MSF2kGUzgCWO7i?=
 =?us-ascii?Q?ivBkG7M0nUJVPbYLTCmiSOW4mBfWLlCiRlDPnvEmL++tD9IiuNGe8OhNxRwF?=
 =?us-ascii?Q?g6HmJj6z9pdquBwqdTlVRYtYo2TwUQ2zQMgShFcRYktZK/X997gqcJSJ3w?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?354aiLwgq7Iu9QbA2pn+d3KaFLi1rPNIg4tzedk663kqf4yQky1EGS1nl2ml?=
 =?us-ascii?Q?WuXhyGjmXvWedLcZSV+sn7wkJk5DBB/CNQoR+B33VxSmqqSjza4SvInuIjPW?=
 =?us-ascii?Q?GIAVNPxabNJioMt6H7QoRvIBH/LfIq4M3o11uDm1f0UhldlLi5t625NVttDT?=
 =?us-ascii?Q?wgS9mfaFrcrA7rO58C5AvWCnNcjMtL+mVKuS2wAJGRIFJ1elX4K6evRB+QTJ?=
 =?us-ascii?Q?nJh/E1TiPDIPmgoBfTo6MDrx1xu9ztBvRK2V91YrPgfxzuzP+keDLWCNCTEq?=
 =?us-ascii?Q?Spno7Kh+PB2dfKtPl8oO5E90XI2lE/Nc/j7ehWV8QhRRZ5s4PZhVg3SCylFM?=
 =?us-ascii?Q?aR4mgnMDZCKRHvFbXRLT5oVJBrK0LUxaRfAHCIxBXPInS6KY8vxFlmIYUIDF?=
 =?us-ascii?Q?EUuPBFDNwB1h67rinkRjq6RFZdxTcaFNz/F7mQ3EuRRK5V4dYZ1yaYgamhW4?=
 =?us-ascii?Q?/CzS+pyCys5SPBJWwpwRRliW5JrWHBLNNwjklYh+lUND0xH+ZrQ1AmV8MwVe?=
 =?us-ascii?Q?JfSOXXcNgGhoRXmcrFhDslQjW++g4xqr5B01gBFKTwHUd8G+6oUlXeioOKHV?=
 =?us-ascii?Q?DfS5xWs2qAOTQxydgvaOR7rzdwnVGa5V+aCmwGBTROi1OuZDbMeBzA3fTQpx?=
 =?us-ascii?Q?TQNShpkHNq2b+HWBJbTnqXz8RTYLtGnX6dqcwPKhA6ymnhz6AE8SDqcFb1S2?=
 =?us-ascii?Q?tm/wLuY5RvBNwDTr/p3umy93J7eZAXmcsaVoYKDQp6lcbg+sWD1wJJvxRDma?=
 =?us-ascii?Q?pgXJbmtPb2FjPyYuDDx87Q3s4lL2QCPs1GUKFrE7fBqmcn6W8wwKXTCjsmgK?=
 =?us-ascii?Q?xIEE3I2W86MU9u4fHCsP5mh/5F1zDi0yB4kSD8qozVnWYejWkrIp9zrhy0up?=
 =?us-ascii?Q?FMCBiBx2dmNJl5NzIF3PTykT1qyiNZsDinurH6b+MZVD7lqktuz26xg+8ynT?=
 =?us-ascii?Q?Q5UOdCijnzhTFb4Uoup6x97V8Qw+xHT2aPkgzjUhYFCsrq3Cv2fRaeBbQlMX?=
 =?us-ascii?Q?t61GMpFSN45wD3cj1BOGeUO/t54hZsZXh5QLF/CpeqYqYM8UwuAIxntXGnls?=
 =?us-ascii?Q?fZnRPecdxYFiyOYnrR3dsQj0jvuBlSFalsDcexFTeJO00Pti3XP9EVkI6jGR?=
 =?us-ascii?Q?jcJ10XfTQ5HVMCcBhB9dFPD5fQLbE/T9LFatM5afdn+WBAvVFEan0ESwPoaG?=
 =?us-ascii?Q?2Hw6lzUwyC44OC/12LedwUCx7CnBxv1IlWhk8/fUVjPyuZ6vjIhjxEs1uy2C?=
 =?us-ascii?Q?SejYUDNyN5VGQqgrqT6WgyMQOln14e6iE2WIVw1Gxthx47MbHD06KaOxknBQ?=
 =?us-ascii?Q?nmFIfm2Ymkj83i1dTRzcD/F+UAH1qo8bcOhQ8/aDndgKyV0lsQ9LxqhnEYN1?=
 =?us-ascii?Q?6oPS30lYHZ40Xbl+FD5ZKUzZlzQQ2m8ZSHUz+8pvv8k6YDWPYinfDFKvpw/q?=
 =?us-ascii?Q?hCt/ZLuMas5e8gm2zFAaA2UyIu4qG6fVAsOQteOqX7wyNqsbcahEnZ9WrHxj?=
 =?us-ascii?Q?6ed0bd/G2tZ7gEOGzniva7MxEK5XrPu8RCBexQPG/B6zJnH526PaqSyQE20o?=
 =?us-ascii?Q?vVFlUQeuxwCE0xldPdkc6Xp1DkBI7M6ynyX7Lyvnm5ba8cQLlxR7HaxDOF1l?=
 =?us-ascii?Q?NUViSZlh8XzlJtfgTTfTdiU=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ecfd80b-b3cc-47be-74f6-08de083de9c2
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 20:45:14.2718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uATfGLH5BNNee/zcE3tnKAxdZMTEuDQET0WoH7U6GLxuAkb5HV94DeWO7GZ7ZrILBEu5ESPRFA+kNUjMD//uYeYkAPzphF/SkjvPEEvyXy4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB11561

The code switches to dma at the start of dirmap operation and returns
to non-dma at the end of dirmap operation, so an additional switch to
non-dma at the start of dirmap write is not required.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/spi/spi-airoha-snfi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index fffed26ff990..2d86dc62dbde 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -812,9 +812,6 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	int err;
 
 	as_ctrl = spi_controller_get_devdata(spi->controller);
-	err = airoha_snand_set_mode(as_ctrl, SPI_MODE_MANUAL);
-	if (err < 0)
-		return err;
 
 	memcpy(txrx_buf + offs, buf, len);
 	dma_addr = dma_map_single(as_ctrl->dev, txrx_buf, SPI_NAND_CACHE_SIZE,
-- 
2.51.0


