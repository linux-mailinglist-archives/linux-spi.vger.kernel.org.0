Return-Path: <linux-spi+bounces-11529-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C375C86C05
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 20:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 725884E2398
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 19:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3607254849;
	Tue, 25 Nov 2025 19:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="vbkhSplB"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023132.outbound.protection.outlook.com [52.101.72.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EB61A9FA7;
	Tue, 25 Nov 2025 19:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764098211; cv=fail; b=QSKemqw2D5h9+/L30U9Yi78K+5UpkmEso7T4Cz0+/skXGMjvkTsz79C/K9GOXmtw89huKq7vghXZqaxyLeuu79xO0y3Qm5XFZvR1PSYjnua8Rwxu5yutdssoJefhQSG244J7yyqkC4mvuhjfX6IjDcONb5KXfD65wf1mFV+GV8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764098211; c=relaxed/simple;
	bh=9AtAPKe6T3JpdGYOsN0YFHJDl0HuRzqY3bi1JEbFgjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=cg3Slrtx/ET+orCmRvQ5CP87kJen7UqckCVckBre2OBvGgBGehEty30z5oqpYCpCSk8P8LKXyEoocraG2yBKqtxev2RJ5uQpeQXxjt6rVif5LegQu10pkFNTb7swdB48zl5Ijx4n6KX1qtO7z/Ry148bTc5Xho0+VYTohcQyPvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=vbkhSplB; arc=fail smtp.client-ip=52.101.72.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WZgArasKTBzhcMptQ4uRvK8ZVm75mgLnOWlQA/W2sC67y+o6HazP2NOubQKyPIpFRriII49tKwipMfwZkDfFbLhMOIhlrM3Cr+qWkfwsOO47NQ8pkVVgMrTHk9peJigCRo/XpW0rP0MSz81g0x1ele1MgN4rKaVDUhH261LI27P/43z1p/hUuNIokLBPS6oKd5fZ2JFWVOh+cn4EaOZdAAYgU8N7MGMIoq6C4X4CtcHzk3tLWe0jGSyna10CVcJUZAegniYwUk+lKr64zOZavK+mpgy7BcI9suTNNYOXkKAR83yDFIbvL4lQtTESXL5v2pL6s1xHWZFGQn2H4SU3Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9QqlxszkTg6tasUSRAg/dx2UGh+sXmH+7uo9jXtc4pI=;
 b=RkhdOpV5b6vG/1E2ZtSuj3hNfuO+ruhMuYb28d7zo3Bs9/v3rOo2haioCSjK+tbI1uzAUl33Opv9BRvLVmh0j80fSEHPpVnE0Q92n6jFg783nOpSRrSY7/R4/wEtKMtu4/AvjuaAtLxkMiufg+QGl4xgcOiLlUfkcYsd7zLneste3HKEH2R5FKRNoZqJHIXDqOpqaHnFjOaRXcAhg/yiw8A+KZGEf7Ynca7c0tDizF6jjHYGZb/lYau1f5sF5w5TnwbDTwM6oVjCbwqJFJekr4EqZ8R0oNbugMtFBg41nQFkWLsFesMY+iEbliSsOPkDI984wbE7oZAQOjV+z5NgXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9QqlxszkTg6tasUSRAg/dx2UGh+sXmH+7uo9jXtc4pI=;
 b=vbkhSplB2lTlv1KB8qrrysqsrtOQa/gkCrYLw00INPuB4gNzLTBAtBQ/K+obEB9SzSaJWRKlPUMQtGfQYLOrjBAc3B1hl3/u7yQZ55RrKjCPYwQqjuWaRN8yled0c+eh3zFhlqpppJs+zHjgPUj1Ee+v9952YrwFJzvxcxZEjm995Z6Et11RPi9WNQaaNLuNXLPHNnF+dqegC8OElnkmkhatpqUb42j0R8DdWuLn7fSf4cGkGIkEJndmEUJu27PH/OF/FeXwRgynCls5ihScPRTWDIz4OSUjbHr94tmKMXA9lc+QNGiaZxWBZyM8eCzssphLjN8x+8ZPMDBrpgrrbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU4PR08MB10958.eurprd08.prod.outlook.com (2603:10a6:10:56e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.18; Tue, 25 Nov
 2025 19:16:43 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9366.009; Tue, 25 Nov 2025
 19:16:43 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
	Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH v5 0/3] spi: airoha: add support of en7523 SoC (for 6.19)
Date: Tue, 25 Nov 2025 22:16:32 +0300
Message-ID: <20251125191635.1075027-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF00007A84.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::616) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU4PR08MB10958:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a883078-279e-4bff-865a-08de2c572b1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Um+mqUtYOT0pj81kYs2Bs5P7M4u0EKFd27PqZMdNAVaegXVIDKIVC1oTamAu?=
 =?us-ascii?Q?TIk1ylc2/Qi4BYIYnvZQlQN6kCx46rgElSRKuBrG/7dzscv0fbsmEyN4CuSD?=
 =?us-ascii?Q?N75+d0TTRE5C1n05RIR2qDUrn9zpIEv3i1sp8qpEj1lqh1CSfX9ecSrH8OIK?=
 =?us-ascii?Q?210Rl5Ca4Nz8TB39VhmixeByj/4RjHcqWnNRXfcDD0astkkPXfbte27j6baF?=
 =?us-ascii?Q?hqvPHelwSru93TLKzUkLJKsJrXyKu8ho0LyepwUC6Kq6B4oZ1fAXuSujmR5A?=
 =?us-ascii?Q?0rVGZCwSSUXbst37w5cQrDYl9l2D6GHswFNX+Qj95vSo01QeUO3VdHZxqGiY?=
 =?us-ascii?Q?igHt9UGfp82Vn5Hq2JH0Xm8ENFQxrFQEBXVeqg0ISIyjQSdQFL5uq3rNSPUy?=
 =?us-ascii?Q?Hy6nySkfAR1qMzIKmOHkLyqac/yfdVth7+WjsKVewVwZ6HuIm7xL6jrk/oP4?=
 =?us-ascii?Q?P2AEHE17Ay+3zVfcMPFDqv6Cxpm7GQ+61miWurl40UlNFSQ5v/Mpbn8OjPAI?=
 =?us-ascii?Q?gYIIVBucdoM8uNu7jO/53ethi8FpoVFIuwd6lYHLTITjmijrklThxtVNkVsE?=
 =?us-ascii?Q?mIGCYcKQ2itHUpkek8yxlMCe7zTwHmTE1ljIKrWrajeO9LpkPu9Z4pTmjtzP?=
 =?us-ascii?Q?S+reWUw8iG46Dyao8hHZmY9IPVsbnY1bL6qWjiZaAu8WYYSaCvu0PWq54BHS?=
 =?us-ascii?Q?T8+Z9SWTll64IoFi0ChsHZpiXqIBY45KPW6DOVzu3Q0f42vZcc8K+N6N4/tB?=
 =?us-ascii?Q?K410mCgVVoIN1nUOYyzqubiG0Je3wZIENU1j3Q0TWQL+8dH76gQyoImuiGy+?=
 =?us-ascii?Q?KEHlN7OtXujsrU/WwpB2JIKCxZHvw8qkEPKNnU/Zp5cyN8hGx/0T+YxuJF9v?=
 =?us-ascii?Q?ad6uxxCLMUG3YWUcYKtWDI1WL2XKfUCSVhFNkQiZmggbAacLM68LYCr6/lv0?=
 =?us-ascii?Q?XHCCHkVU/15vbjeeiyLJabWYUq7ODQEmMfAup0nsockOJ27ajA2UnHT2y4pG?=
 =?us-ascii?Q?TwPnKkl28uHB0QW0hOiiw0/CTr+A7wGD1GwSN4IwRwFKqiZLIW24eALc7lAT?=
 =?us-ascii?Q?nsK88kRsIapQ3+mhVaz/9XJRe2USn067SEThhq6lZpmHb/AQiBfD4tANySoV?=
 =?us-ascii?Q?zNCf45Am6734rJWN3hM9B7F46DPaMExZb2uidixECfXK/O+FYdxOtwOs4ORr?=
 =?us-ascii?Q?YaJiHSRJ9BY35sTIF5uMPjZL2vbCHwykgGfj2SyE2mmiuVVgHOT8HBtMzWHW?=
 =?us-ascii?Q?D6P+b/pGqOe2XK03wgznq250ZL44omrYJsOKgljS4dx+AfGG9CV03ITJHjPb?=
 =?us-ascii?Q?6KlxDVcKLawyK81MTYQMIrV03ocIiBnjeG8fIju4Wr1uYhehPW00azEOjjXc?=
 =?us-ascii?Q?EOuf9eZAfhBRswDPllI1R01z6NQgk8QgwH4lA/ue3ZtNOcj+C3DYWRaNCOgq?=
 =?us-ascii?Q?i2Bp70PeYPAPe4SQAYSeMTQaHrAO580V9zMFrW0u2oiM3B50q/sHmqDImZbQ?=
 =?us-ascii?Q?0qLwpWHle5Bfvp7udTB/M1PZqcg225lPxksGqCWIYxyA67HKMdN5aW6tnw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/ICuQPCZcz1/P+WW0/5I2HIPWsUQAsggE005mh8BeTpLLTB8UsP2JPToWnrh?=
 =?us-ascii?Q?d992peu1a0ZbEt9jjxyDMHmGZbniApp84Sazo+fnEdvElm/p+zBXnFgptQ4Y?=
 =?us-ascii?Q?enpxy/exXof4+/axSDlwCPLjucpvRIm54q1ehE91HgtL52VJbrKZ5PzpL38O?=
 =?us-ascii?Q?HpX3lqrUu2yr+IX1V2LSXMZ0hSqBr8Rblajp5qdBvSDe6xzU+WC4XKWPLU/v?=
 =?us-ascii?Q?YQq/rqYmwJD3nK0XEmbcc0ggNhz9y1GwlA5MIDKV7kaDa7JuCBk1sTQ8bX1Q?=
 =?us-ascii?Q?IiWtbQqWdQHq3jO0NqfO0L85JzKeyn32Lh6DAIpx6ws5si9Wvk16UIBMwfFs?=
 =?us-ascii?Q?LuHN9DKaNqnk3uF8bj/8YSriYtCoqcp0yK5fLUjmInBaV+Vlbd8shL6pTl4v?=
 =?us-ascii?Q?RGB/tgN9nOXpOdxy6Y22ungXONXMDBlGI1I4Cp0iRKEghLDPUjWoHbyCpKI4?=
 =?us-ascii?Q?bPp9MQLd5TSoLB35waxDvXMWycTtdF5gg7aNLRMdHzdYalQTY4K3Cv71Z9vY?=
 =?us-ascii?Q?zKpI2/5wc/sUtLHG34vU9xdvR0i+X8L0hv16E8U2CI4iKtP89YtRCfNaafHK?=
 =?us-ascii?Q?a3bVg5JdK1m1UQPhywnO8W+fG+zHQHj+b0MljLg5nbLeF/CuuPDdiQql0Fuh?=
 =?us-ascii?Q?2c/OtIA9TuomLcEezK5GAYIkbYd/7ZNBtgPmfnd1xYV/FW5XZ8xmCW+B23cp?=
 =?us-ascii?Q?TeST3Qcx+03oHVYmb1yD2ytLvQCuCGQPy2betgIPeY6pJxeAN6p3rZDVqSJP?=
 =?us-ascii?Q?ZnP4yl6rZWwAnfLmUlFevkjidTkl0/rnRl30XGIfHN0xkGav0PZX1KfcZlH8?=
 =?us-ascii?Q?JGpGKIn3tAXrCTOn21As42NW8aTz+BlRtBtcZNDLl95SWeJDpRh1gYUfLqrt?=
 =?us-ascii?Q?bQeUJ9TmGqpFahG18B0cwgCcoq11qj0/MatQrFpIjVdP66oFIIro/TfREV6p?=
 =?us-ascii?Q?lio8SQhmyHhgEl2FJO52Ma/OoxVs7YdyvMgahd62Oysc3mjV6rh6cRzfB7uA?=
 =?us-ascii?Q?CN/UwKlTqhfL/xi7vx93DJis4GN24FG8a+i7Wtocvp040oExJO2EY+5rxK6T?=
 =?us-ascii?Q?t5q36kk5zcPvXdRcdhz4pgspii09v0Of58/XHNtkzPxlHklRLTDpzYl497CL?=
 =?us-ascii?Q?Y300jTa0qY+hSQTvqAZB81vqHn1XOG8+lFVUmUGFGZa9Za9Bf+vJjZhHKBEx?=
 =?us-ascii?Q?CWBdlUvIlQgORvKLmbgNSY8bM19V6TdRQQ39BRA4Ler67yhjowq1AOc1mZQI?=
 =?us-ascii?Q?0d7vxHen13wkBC2C6DpnOTrANy4bG25L9aHXMIKZnA/NRMnNARKmHgurzk4u?=
 =?us-ascii?Q?CdsgnsnK+r92l+uECt+NKnhhjrtVBjiVaga9c6+/UQcYfTfHOJBa6/Vpir91?=
 =?us-ascii?Q?pifrnWJf/QDg3WuRzCVMfQLdEcDfy9T25WCwv7MSDwagFHuwe+/eV7h2yX7Y?=
 =?us-ascii?Q?bV+xSddTZlCYGajYpjRV4q+UuhuqsyoBsdq4p+3jFV7Ke3KgzcTelBpkw//j?=
 =?us-ascii?Q?A7vfGZcJJ3ggOjqwRfyjUoDaauXBTEwXIIHyXkCQUMFRHHdwRjRX2G+W/rIk?=
 =?us-ascii?Q?Zf2H4ENI5aMuSPmRar6CGRCG7yA+0jm8tasflCYMgSx61IeG/RLzLllTPKzd?=
 =?us-ascii?Q?Qvbge2Nhw8s3UWHytsPD4qA=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a883078-279e-4bff-865a-08de2c572b1d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 19:16:43.2688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0xQjn1ciM+MkWbt+TSdRzESoLxPTMe61Wf7GVSwuCuW0pWPGZVoDpDjMZoR3uQ33ovlw/IQIflRyfw5LU5d0ETHBkJno1JPDzPvnp0dZDhM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR08MB10958

Airoha EN7523 snfi controller almost identical to AN7581 one, so the same
driver can be used. The only known difference appears in the very specific
boot conditions, when attached serial console force EN7523 SoC boots
in undocumented (reserved) mode. In this mode dma reading of the flash
works incorrectly.

This patch series:
 * add support of EN7523 SoC
 * add spinand node to en7523 dts (so spinand flash finally becomes usable)
 * updates dt-bindings to mark driver as compatible with en7523
 * disable dma usage to prevent possible data damage if booting in
   reserved mode was detected.

This patch series was a part of a bigger series:

  https://lore.kernel.org/lkml/20251012121707.2296160-1-mikhail.kshevetskiy@iopsys.eu/

All patches of the bigger series (except these patches) was already accepted
to linux-next.

Changes v2:
 * small improvement proposed by Lorenzo Bianconi

Changes v3:
 * split multi-line print on a series of single line prints as suggested by
   Mark Brown

Changes v4:
 * improve description of Airoha en7523 SoC specific issue that may
   lead to flash data damaging.
 * add fixes tag

Changes v5:
 * replace 'boot pin' with 'bootstrap pin'
 * do not use caps in some cases
 * always set dma mask (even if dma will not be used et all)

Mikhail Kshevetskiy (3):
  spi: airoha-snfi: en7523: workaround flash damaging if UART_TXD was
    short to GND
  dt-bindings: spi: airoha: add compatible for EN7523
  arm: dts: airoha: en7523: add SNAND node

 .../bindings/spi/airoha,en7581-snand.yaml     |  7 ++++-
 arch/arm/boot/dts/airoha/en7523.dtsi          | 20 ++++++++++++++
 drivers/spi/spi-airoha-snfi.c                 | 26 ++++++++++++++++++-
 3 files changed, 51 insertions(+), 2 deletions(-)

-- 
2.51.0


