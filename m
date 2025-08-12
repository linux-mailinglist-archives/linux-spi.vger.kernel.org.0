Return-Path: <linux-spi+bounces-9363-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFAC0B21BAF
	for <lists+linux-spi@lfdr.de>; Tue, 12 Aug 2025 05:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B75181904074
	for <lists+linux-spi@lfdr.de>; Tue, 12 Aug 2025 03:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8EE9229B36;
	Tue, 12 Aug 2025 03:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Hfnx2xxD"
X-Original-To: linux-spi@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012059.outbound.protection.outlook.com [52.101.126.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179B21E5B7A;
	Tue, 12 Aug 2025 03:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754969929; cv=fail; b=l5h3GVraF9lZqQES238LJnoPpgfGZg7ElAmW0MTuVUxcVqqlOF9FcXrKPfnZBtmoZnqxoMSDCszwxFkuwnq1UTQ9ANbbC2voNy7/ZQHRybEm5Bko0DbNptLH8dda5DAoAKb8hWrPYzXM+fsT/xZsuFKTabtZZFYnJ2oCI3AQ5N4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754969929; c=relaxed/simple;
	bh=XBxbTXtzx5hMkSOlip1MHz6Cxwa/tgvAoLNBGZfM718=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=X6Tn0LrEhCoGWytt3Tj+qfL916AWpE2LDNjg15TIQxAvqJAQ+jjgJW3yo2xs8E/YbvDV/b6IMn9Ry3+6ceKWi767uurU6ioBfGRf2GSz0xqcuxCvV7FTF9zdz6aPvpqgsYBCmVDiuklTcNaIPzB4P4/G1ZaMjQ/v3d0GrXdcF3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Hfnx2xxD; arc=fail smtp.client-ip=52.101.126.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=frJ31oLn8Q3Rv4Xgb/KyXSTQKXirPAhU1aQutpLNMEkjbyGcoTqnsUwConCigGrrOC0Ay76RULgZV08fke5eNs7bKfLEs3psJ25A8SQ8TT+6vovsDM8SP6w7z9A2ixgXCAVCkG8BKSgyubEA4lMhTKc7m5z/uufXC21whPkdjSVLGFLeOj/jBI/BdzZ6BFBqjOV0M6xQuh1d16iwXcMp3O7mkT7vfzwsm8A5ZUU/Hdf8EebB4WVTFiOQ0mCBDpW66xiylhMNE4TvaXRpK+cFMfmWA6Dd5s43UN4UArmPleBC28OYbARw03/HUS5YqZCbnS6vULt79I6WYXpAOLFZzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LclfU/VrZ20N1MToFicupst9GEr8qUQsnqK/F9vaLmo=;
 b=YIwjQx3ml85dqAbfzHEw1K67hFWkPl8NKah2KYT5RRhq8/GFrv5wnd0OmUKJNI5ONP13KCWEyZR8lw7SpKCdQWmdSUd0Vt/g9U/SpNBrhSiWOBUKOSIo6ghIYHA7eiLeTN+9B/YK55pG2pggfI7OJD+JY6jp1GDJgMo6NV8m4F1MMynjNIE1lKPhssUFkj5w69rUeciGvp8bw5kUSYEzHXPc03J7sRBnjuu/Q/Ls3+YKVrKBbSCqvO6P4anb4IgA2MQqSLh6cMSJrrZAwV2SeQtbhpy7arvUWP7N2aKUumY/fYWYArdGWQQ/nK57snj7t88la+X66jUxB1ZHkUOV0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LclfU/VrZ20N1MToFicupst9GEr8qUQsnqK/F9vaLmo=;
 b=Hfnx2xxDnd8DcjJcMNB+m69PUJWO1BI0rVZRcAn2QlAR6wMIkhRrRfF6RWA5IY0Hm00FeIWrG8FrtnCZM7BHiD4/qtKa4FZyIMTGrOfkOzZ+nh/Oh2TYlfLrJ6XHezi2HlQq/GJYDv8TVB5a731SLPotsrmkJgbiS8ylZiwzYNKONSYOr73YuGQMvTmBJ9edgJxzdpfM0R4LpKkDZI/026/5f9VDioYWMR0sSjWl1RxAdgu6c2311MxABITGgaeETuH5jFLCSfpQROWLX8geCn5wjnF6ins68ma5JNeKL2D/v93dPz0m4T5kJoptck/s7X9uvEkzdc5d1DARVqT3kw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by SEYPR06MB6999.apcprd06.prod.outlook.com (2603:1096:101:1de::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Tue, 12 Aug
 2025 03:38:41 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%5]) with mapi id 15.20.9009.021; Tue, 12 Aug 2025
 03:38:41 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: Mark Brown <broonie@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Martin Sperl <kernel@martin.sperl.org>,
	Chuanhong Guo <gch981213@gmail.com>,
	linux-spi@vger.kernel.org (open list:SPI SUBSYSTEM),
	linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list),
	linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC support)
Cc: Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH 0/2] spi: Remove redundant semicolons
Date: Tue, 12 Aug 2025 11:38:15 +0800
Message-Id: <20250812033817.487565-1-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0166.apcprd04.prod.outlook.com (2603:1096:4::28)
 To SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|SEYPR06MB6999:EE_
X-MS-Office365-Filtering-Correlation-Id: ce573720-ddc5-4c70-637a-08ddd951bb4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qjeSo2OxbjBFDjEsae/6L74i1g3cvBD8YK33EZBLe2HOLhTeVu4BMpvQuwUI?=
 =?us-ascii?Q?O3jRAl0FXKoZbW7qpYVRydNJ6SbhpDAN8jhjN7Edx7bsanJu5dCLbeYA0cYs?=
 =?us-ascii?Q?S5uDIbZht1dMV72RYuKh3z7MvRPvZGHwlEzCriYHSwcx9XI4mnSO/pbdnG5S?=
 =?us-ascii?Q?ThN3pHFeW9lum0D3Z6muEIQGQxxqQoIVmo+A7T68lSqzgtv7qOd/LEpEdUJW?=
 =?us-ascii?Q?ABjU45XK4zIg9Ejl3CsGhAFReWOQcsEtTJ5fsWTJw1hcmi1buAVCBLIMxpPS?=
 =?us-ascii?Q?jBwC1PPHb0OHSMACcoVKp6gbm9pEnnhlM3JcdeMQ2DVGJ5rCFFfpFWeyAj67?=
 =?us-ascii?Q?1f88tqO4MzR39RStmS37BgK61xKzvLf1ztYiemrvqdfWTKNTUuL7ImLW/YX0?=
 =?us-ascii?Q?0JVLoFW0EzUHeD8YMSoSoAkDInAZkiSk1tTcS6xvZ11V8fv2dx/PkKTbUjGr?=
 =?us-ascii?Q?t/ehM5zswIlB4dImaBXbYAW0+glEYtCxnfU+FE4nHKgezBRFa+ON/FxyU6z8?=
 =?us-ascii?Q?DjAVUd8HuV7/SHMENXXK5SkmYnFNaT4uUas0MOoiUrQ450CU3u8iNbq/oMH6?=
 =?us-ascii?Q?VrwTgebaFu0T5mp68fIZHhtsGZ8QE31W+ib7JO5GNLu6DczsnVSC3UyEkfOJ?=
 =?us-ascii?Q?C1Cnsmr1vS1fmAkwWIvl1cmeO/dMYkPXJvwefV2y2lsWUY3Z7sw7UiBFUx8T?=
 =?us-ascii?Q?G9Izo3i56TRPAtpn3/iju6qzycb/eRZ9VVHoRWIDOPv5kUKn48J7spUS5vaq?=
 =?us-ascii?Q?ysCjjKfGMkYFsmMLgdfhcXR9JcW3wcP99ixsxHqqxvSKMmFvcIHV/gt18OzE?=
 =?us-ascii?Q?abBDIFlv1BEGq/JnbRzz6w+AGMCr1bvptZ4IQnSt6a/C1sz7z0K27xnBY7FB?=
 =?us-ascii?Q?cAUkZj3eS2V7iZAd/B5ykMR+CtBRXUazi1wdtUkirzG+5CYeUjCi7rjBNW/M?=
 =?us-ascii?Q?8UeX1bW/MfQ6WZufPwyD/wQGl1oEsMHxCR+VcgIimheOFJdzJMPOOLYhcwQk?=
 =?us-ascii?Q?j8evKpBU16N1v3jfzvQw8swJt+nKWFR6ZGHVsF4lbDPIJDaAqtOkWYG3VBrt?=
 =?us-ascii?Q?3DCSfKfPd0gQJbz8pqFo79LcTC96/xpkjRfk3PXvZ9CLyMvseaEY19m+03wZ?=
 =?us-ascii?Q?9CqVlQEp/Kaf5daSLdYK9OziPSELsPuNo135Ef6mcFF6ydCoBZex+wD9OJQ+?=
 =?us-ascii?Q?L5kH3mnz/Ww8VFvbqbQn3IxkEJe1dO26cF9f64PnFTu++xCWCgz+EB0a/+Gv?=
 =?us-ascii?Q?GdYZ0MaiNDQ2sAukhKPUXceIfQ/rTxMIGIHRuHLzzTMnt6nrf3R7ZTZ5CfPJ?=
 =?us-ascii?Q?0Wqy2izMXHksd83aamBIAFCkABPeUNzc7mDaUTB9H6g2s0hMNJPq9Xk3MGql?=
 =?us-ascii?Q?q1ahP512l58niTIxWcODmpAOWTK1tiXtBTEXGkH7ewOkfMjfTLGp9IJO8Qa5?=
 =?us-ascii?Q?ON38jlYTc1lC+vCXY2suYj7RfVb33WXxciF9xm8thJjKhtbW5+VdZ1eF7YAt?=
 =?us-ascii?Q?SpKyLfjVJnWd9L0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FwYvN9NDusNa8xBAfTYmfpJ2VeWmOK7b8ZB8TPvWRvnB4OJ6zXMG9Csfm5X0?=
 =?us-ascii?Q?342LZl8UfsquC3dO/ZR61moXWxgJMX9y+lS1GFpTm9ubVUiYYaNU+20Q1OAw?=
 =?us-ascii?Q?ldHjtxxFXZ+/xLOdHDZLgUGQvv11/NIdBvcP1v+uRNtp9ZOlbh57XaEHcnI6?=
 =?us-ascii?Q?yY806gvtuz1Xc53tsJ1TKmBA1YCgct0kbA8/NajKKXRBPA79ZU+qMf9++Bd5?=
 =?us-ascii?Q?m0HlYELpQ97Fn3UxYb/vHMD6dZSc1jRI8A/M+zEkQaN2x+n/hgxwExI62xoH?=
 =?us-ascii?Q?j1TYecFDTIe/PsEKqdegK6ZfcMlYpiBgKonBTK625IIrqYvxicuAJwpiexFq?=
 =?us-ascii?Q?Er5VbdpvqCWultql9/vX4ctARiFrJFI5q2+0uNtjH8cOCZZAKU1bCo0zRT3Z?=
 =?us-ascii?Q?tXevFf+CPdFR/k+UU2gzeKDVY/0gHyxDlaWS9p9niE3ZoWl7Ak06CyetG2FA?=
 =?us-ascii?Q?oIYAq7WMRJIXrSju89dkOP9mchgo+ALOufoB8ACbJO27hm1xO7zrPn8mu3on?=
 =?us-ascii?Q?nFZVFLTl4BTSnKQLWIJAK+xhmqWrO4pWoMpUTfYn3PfdVnnBuS4y0T8HUKHe?=
 =?us-ascii?Q?Twi3/J0wbeejOONVhsbimCa/uy7qnqoqJPxNATC3Sngx0Rw+NgECXbhl1e2Q?=
 =?us-ascii?Q?SPIByLbDS1+vNe2woCX/j/AFVDqNUCBJb5dKz5Zh6gnpwlkjPNGSBICvQkbn?=
 =?us-ascii?Q?MhU8/xslGgOmlYTJIpm3uHWNU9b5q4uluJ/d61AZT2o7NY+FLUp04S7+MRQa?=
 =?us-ascii?Q?7DAGM7sQ1aISel3RwQe45R+LAw3APL3ZxszV1xRBo4V84PferduMUPbcFtr6?=
 =?us-ascii?Q?N3KcvaAgwMS2k0Qrq3fwx9kuQtZI5MpDPAcWH01UenEbD+//AEM9ScE7nugI?=
 =?us-ascii?Q?HzgfegErfmy88OOPadtOMB++vdrpoNt0VMOeo8hAxqSI1bKbZWAleKABA3px?=
 =?us-ascii?Q?bpy+4XwiFgk8iZx4ZhRMN1oOI5r5RlmS0m5tAEmi7h5yzmaCcSK2xAeyeXsf?=
 =?us-ascii?Q?Q7lWc6UIZOIAJkTyuWSczwj+1P6G3bAqw8tcbtA3YUFkWvXQ8W4w/x3p6TWP?=
 =?us-ascii?Q?Di8JBxY1W0DNCNi/dpVdv3kAfDy1MXLwG5cuD4IhZmzsHvTvnFzoHmsrNobx?=
 =?us-ascii?Q?N/jnEFp57Ng1NJClQDCvJ3SdD3Y/iOUkTIw7r8Byn6mJGgEbt4hy4456VMHX?=
 =?us-ascii?Q?+nck8Q9FxsChW7n9rHEf9ZIxjxl8lIiLFnu7k3vOItHHynfQEDs6eicYgzFs?=
 =?us-ascii?Q?g7vmgf0b8fgYE5obK4sMuwAr9JIErlwJgtS/8nlLz+uHIAXJhzwwJu0dqRaL?=
 =?us-ascii?Q?8aqN64j6/2AfIMpq9ZMlN0mQwoakdTj5S6DH35WRxX/kxSQuzOh1WKRU43aw?=
 =?us-ascii?Q?/d0jXbqkPMZwXqUuqffP1sZbvnbRTUd04/YfDhqbJOq92OQVtnUPMkteGEuE?=
 =?us-ascii?Q?jHbC3FSZNIxNyke6/nbnq4z2DPSnEp/isTNRZZF198PS7ehoxtpKgHz5MuJK?=
 =?us-ascii?Q?bKsp7Pt1OaNPjQLNuNQlPZGDZMqkMBvTWYV4NtALNEC7rrrUCWFhORiO78Na?=
 =?us-ascii?Q?6dcXZl9GkbLLiDmzivXW7OywE+So7vaYSLFQx0HU?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce573720-ddc5-4c70-637a-08ddd951bb4a
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 03:38:41.6486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0I48fTXyhPvBpWS2rOcPhhgVudqUPYDA7GIYoeu6CHCK0OjTunv3C09low+XC7KkdX1yYXPdWFA4d8M6+NKmEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6999

Clean up the code by removing redundant semicolons.

Liao Yuanhong (2):
  spi: bcm2835: Remove redundant semicolons
  spi: mtk-snfi: Remove redundant semicolons

 drivers/spi/spi-bcm2835.c  | 2 +-
 drivers/spi/spi-mtk-snfi.c | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

-- 
2.34.1


