Return-Path: <linux-spi+bounces-9465-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 452C4B27AD0
	for <lists+linux-spi@lfdr.de>; Fri, 15 Aug 2025 10:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 839801C8786F
	for <lists+linux-spi@lfdr.de>; Fri, 15 Aug 2025 08:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4853F21ADCC;
	Fri, 15 Aug 2025 08:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="CydOajrd"
X-Original-To: linux-spi@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013064.outbound.protection.outlook.com [40.107.44.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A882F184540;
	Fri, 15 Aug 2025 08:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755246096; cv=fail; b=bhwcRNBhWA8CMFErwaqwLGSVcY1Tp++yquOsaPAD3dkxZ9oXBBw06Q4SzytMhElkwy8sY7Vtd/UE7DBrQ8/xZ82T9Bp8jCi+SbQ/XKgFBbOO5ICOHFJLzS/jFXDQv5BzbHZV6Q8o09ob+kFI0JQqH3EKiizmXX/IQ9KsyhVXzQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755246096; c=relaxed/simple;
	bh=ClsD/1O0aQ4IRw0TBa13Q/WMrwG4/WuoZU0cKpkxcFc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=LFFX8Rey5X8JroNiKoCHMiGghO4DqD6Uq+zX4kAcFnygw/N9s8muehV1qxPs56grgN7me1o3rvBpJZb20XjwM4keiWulpz9ITYVokcNCQ4hVzb2vgPd/l7CwMEUh/W29LfvXJ0V3QgZGebUQqUdD7gq6y5peZ3aCeFnjzU9n9fw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=CydOajrd; arc=fail smtp.client-ip=40.107.44.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jcH78VjpVD4hXsxSZAhlvgt6eZuhRjB9xxzr7qJ84PMRqH6BzZ0e6otporaJgtjHKrKurQ7Unz26FJblE+v52ztGwj0DEgfTOdZBgiMZBZoQVoOoRBq9nWbNfGFRgtaPtOpfJPzXWk0MqSfRE60ybYlG1enWIe+PBmt6OUi0/vZPBm+C6ygyNQ61lAuEDxJNN5w5nwhzArcbG1fjjzBlc8uNx5Cli5fjHHVtU8CZjz/h5aKhRC0npwBHSRO1JQY1k0p9a4HgLTAGPnjljYkL544+g533ukGBZ6GIkcKTpR8C3fJPz51YYszzXdltzl7s4gHVDK+1GtLqByEJnTQBTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AE098psXgBjc/LKNDqDxOyVm7t8eYbp3oIT1vzKRMGc=;
 b=c8OUVrdXZNZWydULuOxtzFNmmnJzD0mJYNpcafo0ixMV023LIYMGuU7Uu3lTtA1Mhrr5qODY2jAXGfBPp6l8sY2oNRcgH8nWuTC3sfEyHXhSPQ4xmPS1/SPxFGIAiXQOalDErYHc89J143MYSNQUb7NhMXM8uu1+FIkWF3pByiP41Fg1GXcbi9E1nym0uTCDb9Ukug4N0RYHLlLJU9s40AZY576NLay/qnhkHshaNXqe3mah6KSbbYqEd6y6HLKcAKOqkHEIkvvS13vkKMwc6jWOwffmJ2+Re9BoszanITAW6vnChHtTG0i8CbV9CoBjiKvH98VZRegRVJgl3kyVCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AE098psXgBjc/LKNDqDxOyVm7t8eYbp3oIT1vzKRMGc=;
 b=CydOajrdHELPfHxkOeta7DLT8anP3aZGLfCh59lta724BVo1JtBjHGa5rUzLYccmbmESu799ZJEwI72uI80ILBBO5lpxNilWcn9m3wwMuEfXGVEf+rKNnFI5MaIrF5qfKACMBVj1ADEui6l6QjklfNlQ5JXOYu1WKXmUu+MllsqVKmguNng3P5D6qkOXLye4W/il1KMecuXUtxAOL/+Nl9pRIdPkmSePhWu8dUpTPzBo1Yz5orxHHR9fXaw/dRyWBYtExU/CW437OWhtdPq+RnIK33YTZO/MEiE06Gkfy9bdl0iA+zd1TQvOBAnmrev4fsEMZve11PqZjX5KtusTvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 TYZPR06MB7169.apcprd06.prod.outlook.com (2603:1096:405:b7::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.15; Fri, 15 Aug 2025 08:21:30 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 08:21:30 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Frank Li <Frank.Li@nxp.com>,
	Mark Brown <broonie@kernel.org>,
	Avi Fishman <avifishman70@gmail.com>,
	Tomer Maimon <tmaimon77@gmail.com>,
	Tali Perry <tali.perry1@gmail.com>,
	Patrick Venture <venture@google.com>,
	Nancy Yuen <yuenn@google.com>,
	Benjamin Fair <benjaminfair@google.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-spi@vger.kernel.org (open list:FREESCALE IMX LPSPI DRIVER),
	imx@lists.linux.dev (open list:FREESCALE IMX LPSPI DRIVER),
	linux-kernel@vger.kernel.org (open list),
	openbmc@lists.ozlabs.org (moderated list:ARM/NUVOTON NPCM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM PRIMECELL SSP PL022 SPI DRIVER)
Cc: Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [PATCH 0/3] spi: use min_t() to improve code
Date: Fri, 15 Aug 2025 16:21:14 +0800
Message-Id: <20250815082118.586422-1-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0017.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::29)
 To SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|TYZPR06MB7169:EE_
X-MS-Office365-Filtering-Correlation-Id: 37cfae7b-6b39-4ef2-e7c7-08dddbd4bcaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1f9Y3q7kR7Zqa/m10quYHcVVWx6nZqQy627nUmTJ7l5cxuV25Y1ngK0O9kOx?=
 =?us-ascii?Q?pxhm15jsI2aqEZxr6jlLGSm37IFfiF4PVDsRr/7Ip6ZLiHFAP28i39GqXZO5?=
 =?us-ascii?Q?xbJ3KmXcCpDYxLamnLniNTNLl6toe+tK0Vnt9RsJt/ycE8DTUsqQt/oYp+At?=
 =?us-ascii?Q?jQ06L/1kEcs64RpraY4UHGUrp4lQnnxbQlUNZCSBqy6+dzA6zVztcIaGmQws?=
 =?us-ascii?Q?Nt0X+DqhALVDE+0uzLIk/Jk1bGvaImBH9yp9875AzwDO6+z8pS3dU0/rEpy3?=
 =?us-ascii?Q?/ujvAECbrIpIDQTMzKEKTbJDebmYyOjaVhmNrKsxDyfYpJUKA72PMTmWfZyZ?=
 =?us-ascii?Q?AAwTDJ5eK7WxDHP0iOMHFlmdOlgFMayMwer2XO5NgFUh+8kxG5n2XUeC9XCD?=
 =?us-ascii?Q?QbZBvIQhHEywusA+vDbMnaiDyAE/j1SossiiDijxu/IOp6tuMdlqNOobEMED?=
 =?us-ascii?Q?r8Shwx2ZktpdNIrtQTEEwPA4tmsSp2nfzVe0Bc2Zy45VzypB0YigFHZSytqN?=
 =?us-ascii?Q?snTfuNu4DnjkoHmsrCaFe2vxE0ytH+tMLd0rpQ98Qvwh36OEyGEAuOL72K3i?=
 =?us-ascii?Q?IFXZhl5KLCClRcHfseCLPMnZ6lcQkoWV2CckpFyOAZwuTLP/ohOwbeAj6GRj?=
 =?us-ascii?Q?W4iAn0ENweg/j68aV78PRiD0kV70snzYNb931YcCQHupbJDqZWx0IK/aYbQD?=
 =?us-ascii?Q?aEZWgI/mzTG6f1oaHRKSbvzEm2LGbVW6luMJn02Cp9nxGvO+u1WJmMtnYy/J?=
 =?us-ascii?Q?APVxNiqLgFrFSPbSPWjvGu5qiTorscPYAKA0USJ05BdMUaBGSnMErfJFY5nZ?=
 =?us-ascii?Q?H3yhWbsNYU9wMXBD2SNwdcwoGUA2v4HJblv80w79AwVy1mRtvGrtu3bKdgDl?=
 =?us-ascii?Q?Y1aWzZaz+rXi2lsqyqNK5d9MFWnrdeM3B7SR/9Pt4QUuVBrDx5YnrxVsGcSG?=
 =?us-ascii?Q?cNal/lAblwlie4d0Kyh1eh/tGI8NvqweK1+ZGtxFMog3BkKNow9DPgYfVNNX?=
 =?us-ascii?Q?re7dTszsxffj4JmWXQ/s1buiHioUCICamv11LwRkqU0uO6XzdiPY/UN3qgZX?=
 =?us-ascii?Q?Y2sMrijTVY3+Pp8qUiLw72GCEA0vTb6VpsU6HN2qHKnGrNtIV71G1Cech3Oe?=
 =?us-ascii?Q?vd3uCBoY7gd7kUhppFVWbrhcoHNaCFtilY9EjW+ZcZEaYXGFZUgJYhEyAqaZ?=
 =?us-ascii?Q?LZlvxEXJIlo+vWlvZI+cfR8hQFzRYkkLeJ6gpsgATsaZuKJrJrPUq4Ou3zpC?=
 =?us-ascii?Q?pznzwWjRMkmwzZSwluFhknYcBl1iLbtMsK7ZqF2D1g07OvkvTo5okV8AuoQ1?=
 =?us-ascii?Q?MgcLiza6zMdp8jz3DTrNHSkcpeER2HuVFwD8GOjC26McsUGRKF2oIevpdhDE?=
 =?us-ascii?Q?NRqK5/widujspfMDtY1OYwUvRHDtTUcUqKHjq/MeXVEtiHIzu5u/bSgr2VCF?=
 =?us-ascii?Q?Cdv7pX38+YW3uLxFtKtxAgnHGwQY/SLimQzCH9dx0fHDI1FDlh6FfZs912uQ?=
 =?us-ascii?Q?HUcYbFvevBknjjQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZDLdsta4gvhOmIrhM6NmJ5J0fyvXnCccgdCGHA76Gs2DcxvbGEzny/925yhB?=
 =?us-ascii?Q?fdL5LbEhOhpkKl/2vL0OIKz1XOntH6YB3MCZ7J3wuDRs1EA8fY0jZBJtQ2Vk?=
 =?us-ascii?Q?4ZLL+arkOe35DmUotySl52pd4qAKPeNAQvrr9X3MloGqxHbE+ykHBmXlTB4v?=
 =?us-ascii?Q?NxBQ/FFz4DK/x9yUUI4Xpb6UnAc0bgr0HT7RMcrVlRE2fg7ZMa3rnYsb2zWL?=
 =?us-ascii?Q?fYNazqGa64d3BR1sCditW3nOmSrbCoVWQbJHKYP/tps6fWSCVa/hgP8fZsEo?=
 =?us-ascii?Q?y4WkANxdg8dF0DM+Xkjvg7nNKnIVlrh35yeJH/xv2DZuTS3CD+yCw0pAk9tl?=
 =?us-ascii?Q?JIBa1eZi+Lz8SoDoYhlfUVbyJ75rq05zhF3t/d4TteBDWPoD5L8GwWV+H48K?=
 =?us-ascii?Q?SWBGWU9rM8UGFrgtZZv+PxcQAEocFHKmUBtEUc3NZw5C0YZZbzFXj9W8nIrK?=
 =?us-ascii?Q?9XsUItRfFSWunJ5JjsqMnzlFZWOuz2vY4VnQAxiGlqnUOl4uLno5/SYznk7G?=
 =?us-ascii?Q?6SWOHMNBnVwPN15PjRNV7v8iOxwg/SFoQXjY/LbG8iHGMyKVGRx0X+XkXM1H?=
 =?us-ascii?Q?5ajv6Cn4fPBPwbr8Zy9AtG7kOYTdp75J5KMKlhTdVN12UGdsjTNAFcyXeePT?=
 =?us-ascii?Q?rJ5WZHK2PsjcrftECNzJcB7A4n8NO0mD2VXDMP8fDRJ5fltssfHBfyzbJXO6?=
 =?us-ascii?Q?SpTAi3/kVlN66rNIoQHybo+SVPnaEDs69NPx/lEzBC7jbXrXJaLW+YWuT2TY?=
 =?us-ascii?Q?sg0V/UVZmJJ6FTQuXAButuejDqoalOfxupt2m9cHWgjNc5PXFhcDA8HKoSPV?=
 =?us-ascii?Q?pGGpCxjm7BJtvb2OOHzngIjfAUg6GULqXIqnI427mpaDuQVC3N8LGCoYzEWU?=
 =?us-ascii?Q?fauyI9IYepAoxbEwJ5/XCnOQpESJhDaJEs+ZmFQVYtgPETmXOLg3P/vdvA1r?=
 =?us-ascii?Q?F7FoY9TDR2A2t/jQuW/HIJ9EhqU1vmWNU7CTBfY/ToFNe+XJge8WbPKpKM6Z?=
 =?us-ascii?Q?aoo3gyLcB6Wci+OvnAK2PO4G6QwkhNaqtRpgCC/9ScXyy/O5K0ExEPtwdwV6?=
 =?us-ascii?Q?itL8ti94i46i1oUVWAyWYrHaiJuIqUlwNPTNCxegnxZGc4CSctj7EubNGheD?=
 =?us-ascii?Q?C1mSKp16cdSBSlHGTiJeT9bZnXqcu2ZwLDnZhKkmehazk/+ulS+Ju3yADIQG?=
 =?us-ascii?Q?9XyvP6UbFsE88Mxb5HV8xrNh7X5P2clsGjuAN/0avjb+QsXM2IN/1pS9C2xE?=
 =?us-ascii?Q?6qWZKF9n5tSnvVpd6a94WpMBnoX6mG+T5X5xEYDncFl3u2fmtsh1m70MzlHa?=
 =?us-ascii?Q?lOPcmURNL+S2ohH6JEq43U5EdPVrQxSQqj1pBRwdgWx8Pb4TJqvu1wzk+v/d?=
 =?us-ascii?Q?MHi14Q8USWgMxVncHkgnVqsyebazvm+S0km7Mlj7idSP5AnsWGgUDVDzaSkb?=
 =?us-ascii?Q?2wVg5kVDNg/62A8j8ID7ZCBQ5PoGVcw3FjmV8nNrHMAnD/7M8v5hccRoRHME?=
 =?us-ascii?Q?zR8x39iz7AouGsr+fWRT5BV3k1LV4hiS5aIf9mMtQ7o9FsKwjBYM5OjqszpH?=
 =?us-ascii?Q?3TDGM64TLAksSCjb9RyaHNOMGSqO4CudMicK9Nxv?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37cfae7b-6b39-4ef2-e7c7-08dddbd4bcaf
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 08:21:30.3955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6ZM4EOiNIYmwucFDLZOCU0CQQV066Jwu7ri6RxWSMn4LbE7Vq99vOLa6m1AyCw3T6IX7t3cmPl16zAqJeGLPNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7169

Use min_t() to reduce the code and improve readability.

No functional changes.

Qianfeng Rong (3):
  spi: spi-fsl-lpspi: use min_t() to improve code
  spi: npcm-fiu: use min_t() to improve code
  spi: spl022: use min_t() to improve code

 drivers/spi/spi-fsl-lpspi.c |  8 ++++----
 drivers/spi/spi-npcm-fiu.c  |  6 ++----
 drivers/spi/spi-pl022.c     | 13 +++++--------
 3 files changed, 11 insertions(+), 16 deletions(-)

-- 
2.34.1


