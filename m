Return-Path: <linux-spi+bounces-11550-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A55FC877D2
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 00:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B8813B62F7
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 23:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC38F2F3635;
	Tue, 25 Nov 2025 23:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="SZeP38V3"
X-Original-To: linux-spi@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021136.outbound.protection.outlook.com [40.107.130.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB982F3608;
	Tue, 25 Nov 2025 23:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764114065; cv=fail; b=uUQT0A6QJnx4v6ctcSJZ0NKWVC2p022g32p6STWtF79H7G1dkoLSxypAdTetdL7/ttWdEp1FLZ1EKZtWcbr8K6SbGP73pP85gIX+nU6cvPIELiBoJ8ongMjDNBs4bggWAw7RJuDDcSuhyeociLWtwpwTnB2j9rgjETqh1uS6/18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764114065; c=relaxed/simple;
	bh=61qyWBub+U9Ah13Whb6ziMKDKqETfuPSShzLVf1YfMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i5ttyjlmF3E1opOqHVussgBDAibGLxPBOtpIFzJdlZey22y7Si0vwjO8KJuscRihnfB9R2jre0uZY1QrXWcuyNBlzcH4tX0f1TAmkBk/tLMBK7h8hoBNtFCT+bV6w8svjpV2Pj3usII2z4EWpIHDa9X9n40dWriEZgkygcAvFd4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=SZeP38V3; arc=fail smtp.client-ip=40.107.130.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aJJQ10jv/LLsKIO62XXvb3suOtzedT5eZeMRfCjhB66/aTEKO6Mrv7jnp1hmro5u0//oPrnBCrnIh/XAWD0kcR9zpZqnV8CqADd7s5XEWzJJFtSJetGBqlcjltawV1ChwsCx4UlAhTFGxioqTm3yC6UbVoHxnbNVUN1rp9LQfH1bCbu0Iaa+/QsS9Kl8Eq6jqUK7v/5i0pTqcB6XgrFtL0OM6REEd8QSLoUDUfyxVGHz05BBJAgU+RqtdZ1hwckcsNNanz0O8QWN11+SxcWf0Ead/x7nCrwEeAKxIyB70JvwUk/rRmItJfClYItpzW1ozH0pca+7XLM/Zodc29kgPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e9v+RbeI8ge2Gfp5062EuY3XvwuEi8UuACLPTl9BMDY=;
 b=q5LzzUtViAjDYnnetLD7YrPrs6t1shJXlg7JENzyIIYlDyyuOH9gOWTU62n8m+uE0Jc1JTLi9F1alJKVa0/Jc2l2nJSAqwAUKall3M93XJ6rUH7/1tqRhHgLQuVRyMpLLNTC30JMww+1L+7kloNccQfFaF2FMuAGJ18SJ80Jtjg06NOmCpyDdFYe1WDwFCmr1VkrBpJt3bwwxOL7IE2spLYNG8OcIDWZyJ0+/6hQyg7UlR+hxZowluQNQV36AEwL9AM/+sHHocC4jc70zCvAKv1JAwiw09CIncNOfPpfXSEO4gdt/Aznl+SmWn+d7lT7nwI6+xG+EGaCAkCAYT4n8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e9v+RbeI8ge2Gfp5062EuY3XvwuEi8UuACLPTl9BMDY=;
 b=SZeP38V3JdB3Gy5i0z81r/3SJOcMOnv43exoUQzgo9qoa+AAfWXHhXwudKZfxqvCLbtWLP2rUDFoyjJ/GNzyVkXvqsAb1Ujo7/GC9rpIT96tEQ+EMokoDYP83bSQ97QnEpKA1D/Of7EJto+bXTYbC74wpywwicv7UKSJHsCPSycZzKVIu7ly5VX7pJ2rcw+DxscSgh4BwhZD4yZDnpjJFzy95UWJLb7jJAh2hAvhxyj/BD44f5Z3J403nksNNGgVEdrROEVpQqwz4es1MGyeQ2EfHrBsNYbSXP04SRQQbJx9G/mc547+GWesle776YAZDw36kWc70HCJ/g9LJt9TOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PA4PR08MB6063.eurprd08.prod.outlook.com (2603:10a6:102:ed::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Tue, 25 Nov
 2025 23:40:57 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9366.009; Tue, 25 Nov 2025
 23:40:57 +0000
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
	Andreas Gnau <andreas.gnau@iopsys.eu>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v6 1/3] spi: airoha-snfi: en7523: workaround flash damaging if UART_TXD was short to GND
Date: Wed, 26 Nov 2025 02:40:45 +0300
Message-ID: <20251125234047.1101985-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251125234047.1101985-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251125234047.1101985-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0141.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::20) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PA4PR08MB6063:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c9ffae3-c9c4-46ef-d259-08de2c7c14bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ykNZTyKkOt5ChNsFWGTe+pBSLdcdYA/kKhjRelp5OQ+qWG6U0yINmK32EDIR?=
 =?us-ascii?Q?331JV6uX6N3Pbu+rI70SiZ6rm6PYilf1OoGlT4ST6GGjMyBKm1jNElMrVDTW?=
 =?us-ascii?Q?yp5U1NpgqL8qOqFjYQEW+BoT8tUfl5vI9KnnY2jxNzUlH6fAWYZ/D5TjStiL?=
 =?us-ascii?Q?jNN/5rc/OgkLj4nwSaUtyprkaGeWYd4PwRJJGKRvEM9SCdt1wR7baUsDv1Ht?=
 =?us-ascii?Q?5X6VcknZuO1r7PgA/HJnfHpcHEGlhW/MNtN/bzkN+kb4HI+P1QcXIn0ixxtL?=
 =?us-ascii?Q?0SMaURx+HOYYaWuR2MV9/3B/FFmoKC6ivzV42vJreUPMGUCqWkApS+p9Sf8U?=
 =?us-ascii?Q?BQwYY7Bs/XfAtkW7FA9yOw4+IQT+6Am8j35dCwGzdpgUxUnJIeTMjUuWHDTb?=
 =?us-ascii?Q?2La7y5KidEZ3ZsFytyE8y0IyFrVzL+WoItM7sRVhcVtk6MTSMlFABbTjras1?=
 =?us-ascii?Q?lLuwQXO81MOdsideS3plt5IArKBNMHQrs2g22k0pEWPZTDz6vbLOFT87FgoZ?=
 =?us-ascii?Q?ZkyDQxQcIwkFUfOm0S0JXD0WTn8ELKfJijhQ6vQQHHnKqGcOvWUnmt7ptvrn?=
 =?us-ascii?Q?7ZJ6MV/BZp8ORCthGTdC3SPnOUqqukpyVLbzfTRPVuu6lAlcaIdJtb8L3x3I?=
 =?us-ascii?Q?XEfNa4YB7gwgw0vFQ9KsGJFxb9SXaCKBv3Bhykc3KRlh/c2bEzYzXojAUbt6?=
 =?us-ascii?Q?PSPFwf6E0o2cc1tPJMygovJrAAxZom9utbW9yYtE2KwNHhJR5G6wBwm0ozbk?=
 =?us-ascii?Q?qj9wUi+3cRx6zaGhS1hfzmhyAJBxfy0doJJxUUGroVbD2mvJCuMLcgCTz2qT?=
 =?us-ascii?Q?tRnevnPjrFu6Pa3JEgp/3tlwQqQVSVKDJoV0vCpa6otpH9+SxoNIqhSvTNMG?=
 =?us-ascii?Q?g8jB7Z/xS6uDaSm6ZP4Eq7kLVnIN2oWJxUafpkMf4OYMvnJrT1RsbJv0/MKI?=
 =?us-ascii?Q?2xw6s3K6jgmDHbvgMFJi70AFY9vlx/7Z0FKsHmmYskAnk/w3SLoSesRD1Yom?=
 =?us-ascii?Q?2ma9ZGClfNITM3ex8KN5y7dJoXrxC7wDDIX9eYe0+HLrCC0GyI5/9KpfvpYE?=
 =?us-ascii?Q?E0IZR4c+9GHH7H+83f6HowYBCvuvd5fhvyRunfstsdVnFkKjD4aCKQPFbiz6?=
 =?us-ascii?Q?Q81+EH+tNVcNZXFFwsgsDjEgx1nbilvAsGho7FdS9sfP59X1EFqy3dS2nPId?=
 =?us-ascii?Q?ANHcgt2ZmZ7uz3Q1UZXkC5hXC8snQwFq+xSPQ2J9IqqlOh7IweHgIV9Uk2tK?=
 =?us-ascii?Q?5sdG/KNy03m78bAq3zWPoiyD3LOiXcPDpHeT2tZrGuAaZRDF9R2emp3y/whG?=
 =?us-ascii?Q?0xCTtULq8sRS5InJwIs97YUYtQ6JP6WO+UMdi3jsHepIwpBviujDIUdwUnvQ?=
 =?us-ascii?Q?jGRDuQy9r5f3tOiDz/KWPDsGjFBxpF9b5E6y+2yj7SillDpg/WPRf1bT/fse?=
 =?us-ascii?Q?O/f7l3uQWw1uy/88OthnI+iaRsLfcHDkxoAGkFc6Qk8XUzo8qoMdZd4FanZ5?=
 =?us-ascii?Q?IVk1VP10QVOkVvo+EyXV9KZ73q4osGFjY3cUIzmKk51bf41B1w4H6gLF8g?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L4scXBBHdCppFxEnNU0lsQTvj0Miq6pPZHj05oRDKMayPpHyTZG+2MYC/Gqq?=
 =?us-ascii?Q?7tN1grU7TYqcBQFz3ke18O8W3GgPrRgHgAIjoc9O9LuprcIZ/Gv5SL98nL6H?=
 =?us-ascii?Q?dfR6b1MP2LC8E9gzfryWQOGGrMCaoY/alggQnV/G37vs4GcQXM07OQSyzpRd?=
 =?us-ascii?Q?rWbUHrCbuNM525IYLYgypE13eJN5ne69vAExslvi1fZx+ZMMluwCoYpeAHkg?=
 =?us-ascii?Q?u+YguwAEkj5S9y7aML5RWjX7PB6v7AzlOerz8ewnwC5sRsfmJmUiWioIqhyY?=
 =?us-ascii?Q?g7dLwCPIoSitPzS3Z2ZUp05cYX41T9tQMgDKLu0y5uGvDJnerFpl4nYjEK8w?=
 =?us-ascii?Q?A0c+03Vw5lmyo7D8yaXH3S7EkRKL7gB16YYXge1bbsZPu8Hp/85gXthvwJ7P?=
 =?us-ascii?Q?9yeD1y3bov8DO8EG8yrpapyKb6KEOEWo2ZxeTbgKTxG2lmkbpURp531pdjKE?=
 =?us-ascii?Q?RUe8bhLA3/yVGGM9N3q0y53MV1Q5QHorNBEeGXy8AzQEd8uZjUZjtKIq8yra?=
 =?us-ascii?Q?5CORYMgxYDtqeOIderU16t5OvBK84hl+CfRg9dvl2QcWaArQbPnPcjsVLWPH?=
 =?us-ascii?Q?kSrcDk+Q5nZifVLFQC0Fy1dIvUcar5W9f5JzJpqDEzlmb13ms4B+XuXS2+Mk?=
 =?us-ascii?Q?WisrFtCCtTNuKDCL7YwsioejCW0KST5IVNWLYK5Zex5ZsbFF2mo1VRE2zmTo?=
 =?us-ascii?Q?koYV2vZc0Wprm/rDBU3BtUIafFgCUvqdHZIOK1IGvqRXH7GshMkmwRnPN2gA?=
 =?us-ascii?Q?M5BRqCsFROnEj3He7FtwYX2cECp6ZkrN8zeIbpirLbb9jLubZCIWcqu4T5Bv?=
 =?us-ascii?Q?LiVxXnn7RtjSslW4ejaw2igMxNY0piFsI6UuxACDYW62b4LP6BysupBjMozB?=
 =?us-ascii?Q?jmab+ASt7v5x2fh5A2FhS47MO1lnHkCIzbAgUYjf1OiEAVw6C8NJNtMRufmC?=
 =?us-ascii?Q?06ywDupAkKFvmn62+NLUox2zluT7ibahk192zuW7lg0UDcZTMbAbNIK7JvKs?=
 =?us-ascii?Q?wq39xFPPBPKLqe3camYT/VwvtT/854i/Qjr58RnC29PXOOshwTOZxIS1aGcS?=
 =?us-ascii?Q?lIUaTXHmWsPskp7nHS9xN88Rj/gJKa9kkbIWu5EqA+SAO0wRILQj4VuGP52C?=
 =?us-ascii?Q?xrYLSDn53Hi8JvGBfLi4vqj+nb9wlzP2h+6vxAMrACKxvldbYGkM8SdgwMkd?=
 =?us-ascii?Q?W4jcVIFxM6zn1oxJdgQvlQcUcx0zpaIV1lcey49OmXgUKK3orqYL3lngjiv5?=
 =?us-ascii?Q?YJqn6Rc8qHDsaBO7T9uJEE0ojNgS8T1g/M56SRH5yjEeSnGBrX3/bkERHf1y?=
 =?us-ascii?Q?a3yF6JcbF7boainCbqEear8PaOBDEWScgyaxwF/u9HP3typ42TzYVsrFobmi?=
 =?us-ascii?Q?y1j4L6Kte02/28fWQhK2ED37p8psE94sZFrJ1h0CgpA13p1/4wi7N8hdSrIi?=
 =?us-ascii?Q?OHYHFZqBw3kYey+cujCpnHLLNY+s+YvDkL0bcpn+1YO/WIetQS/RpwbIpWoT?=
 =?us-ascii?Q?4aGhCRAhytXjr4cUu5oYANGZcQG4yarepzegvOSaLNGT44WsK2A2nKx4HMF8?=
 =?us-ascii?Q?Fo30WmU10AAW5K2phIe44RPlYOYB6b2MX9WNqTq5oR2yLJ8+/y+C9OPS0npY?=
 =?us-ascii?Q?eLNVmKswXGlnxhfyYYzreq4=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c9ffae3-c9c4-46ef-d259-08de2c7c14bd
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 23:40:57.0608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kSTeICGfnx2y8BTnCaOj858URRYTeA+0oGFej9yxr7q7ex9qSZNC7YkajV2hgXNAip2VdXo5KEn9MNwNsWirUSnDh+E6n4vgGioKC9mICe4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6063

Airoha EN7523 specific bug
--------------------------
We found that some serial console may pull TX line to GROUND during board
boot time. Airoha uses TX line as one of its bootstrap pins. On the EN7523
SoC this may lead to booting in RESERVED boot mode.

It was found that some flashes operates incorrectly in RESERVED mode.
Micron and Skyhigh flashes are definitely affected by the issue,
Winbond flashes are not affected.

Details:
--------
DMA reading of odd pages on affected flashes operates incorrectly. Page
reading offset (start of the page) on hardware level is replaced by 0x10.
Thus results in incorrect data reading. As result OS loading becomes
impossible.

Usage of UBI make things even worse. On attaching, UBI will detects
corruptions (because of wrong reading of odd pages) and will try to
recover. For recovering UBI will erase and write 'damaged' blocks with
a valid information. This will destroy all UBI data.

Non-DMA reading is OK.

This patch detects booting in reserved mode, turn off DMA and print big
fat warning.

It's worth noting that the boot configuration is preserved across reboots.
Therefore, to boot normally, you should do the following:
- disconnect the serial console from the board,
- power cycle the board.

Fixes: a403997c12019 ("spi: airoha: add SPI-NAND Flash controller driver")
Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
 drivers/spi/spi-airoha-snfi.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index 8408aee9c06e..70327aebc26b 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -1013,6 +1013,11 @@ static const struct spi_controller_mem_ops airoha_snand_mem_ops = {
 	.dirmap_write = airoha_snand_dirmap_write,
 };
 
+static const struct spi_controller_mem_ops airoha_snand_nodma_mem_ops = {
+	.supports_op = airoha_snand_supports_op,
+	.exec_op = airoha_snand_exec_op,
+};
+
 static int airoha_snand_setup(struct spi_device *spi)
 {
 	struct airoha_snand_ctrl *as_ctrl;
@@ -1057,7 +1062,9 @@ static int airoha_snand_probe(struct platform_device *pdev)
 	struct airoha_snand_ctrl *as_ctrl;
 	struct device *dev = &pdev->dev;
 	struct spi_controller *ctrl;
+	bool dma_enable = true;
 	void __iomem *base;
+	u32 sfc_strap;
 	int err;
 
 	ctrl = devm_spi_alloc_host(dev, sizeof(*as_ctrl));
@@ -1092,12 +1099,28 @@ static int airoha_snand_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(as_ctrl->spi_clk),
 				     "unable to get spi clk\n");
 
+	if (device_is_compatible(dev, "airoha,en7523-snand")) {
+		err = regmap_read(as_ctrl->regmap_ctrl,
+				  REG_SPI_CTRL_SFC_STRAP, &sfc_strap);
+		if (err)
+			return err;
+
+		if (!(sfc_strap & 0x04)) {
+			dma_enable = false;
+			dev_warn(dev, "Detected booting in RESERVED mode (UART_TXD was short to GND).\n");
+			dev_warn(dev, "This mode is known for incorrect DMA reading of some flashes.\n");
+			dev_warn(dev, "Much slower PIO mode will be used to prevent flash data damage.\n");
+			dev_warn(dev, "Unplug UART cable and power cycle board to get full performance.\n");
+		}
+	}
+
 	err = dma_set_mask(as_ctrl->dev, DMA_BIT_MASK(32));
 	if (err)
 		return err;
 
 	ctrl->num_chipselect = 2;
-	ctrl->mem_ops = &airoha_snand_mem_ops;
+	ctrl->mem_ops = dma_enable ? &airoha_snand_mem_ops
+				   : &airoha_snand_nodma_mem_ops;
 	ctrl->bits_per_word_mask = SPI_BPW_MASK(8);
 	ctrl->mode_bits = SPI_RX_DUAL;
 	ctrl->setup = airoha_snand_setup;
-- 
2.51.0


