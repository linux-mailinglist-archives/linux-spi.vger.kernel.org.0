Return-Path: <linux-spi+bounces-9561-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A8DB2DCA5
	for <lists+linux-spi@lfdr.de>; Wed, 20 Aug 2025 14:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65F225E0CEF
	for <lists+linux-spi@lfdr.de>; Wed, 20 Aug 2025 12:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05272320CD7;
	Wed, 20 Aug 2025 12:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="P3NngMQ0"
X-Original-To: linux-spi@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021135.outbound.protection.outlook.com [52.101.70.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BFD315760;
	Wed, 20 Aug 2025 12:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755693225; cv=fail; b=Wy/ACsOAIWYnTPOiXVThttSinYk/czMkEJkdgftdppBEuHWRYr2Scyxdpf0ApmyQVR6/XId5mxsD5gbiv769A277emCqgEBN0JdBQYgFd2or1yk4fIg5lEK8i1q0CdfBUlKdWZXN2oKNOfMlfVlSDP6q5nW0qoWcGJF4U4PTnm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755693225; c=relaxed/simple;
	bh=1mbsZxjHMop34vX89u+LBaxZtVmPxp3kOOOcTFpwVOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dXkrKlDb2G48CChc5eDZW0QMLoJ/6lDWxnUB/aE9WT67UkerJOGouaMbYteYZdrxo53ImXoELjhNfge+uV02cl5PwjLpGaYo49trb2BF0Pb1PLri4qdRO6bZGXQ7jQwvv9vCmBGP2E06yszudNVWt4YsXztkprvHC1a68p+w3BQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=P3NngMQ0; arc=fail smtp.client-ip=52.101.70.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RY0Bw1s8+jBmLitj6bKbrMy0IHmOS3FI91AZBLP8njjltP/iUuIpblyYmLHuVWtBSo0hfKxwzfzu+Oj1IPcRhCUKOTetat+zHYfv6CreLpQBNVuOYrSMzmCluSE1xF+pitkOJw4RVXly8lUdbtRXusqEvqsJ/WGKfXvVmpmVDXeFdxmqZpjvXzWx02wTckMMZgWilhQEyfNvfhhG8IJIE3Jw//p3F9eL+nF+iadXhpVQzkcK0+EZGU+gFTKQtsOGeMzvpE1NTiHXAgAdiKZN/lqqdU+MQAnwBRT+u96ivcFUjqTnvG8p+0XhYcaVv+0vWrPkeWckSxnNzkuJjQps2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dge+Wohza8VNTmicDnrqIU7ZiQ+jKHAuw30Z0jYAzqM=;
 b=lrOQV5A8uuSh+ZB66IxNHliWzH7Wl8uoZ1kKiRzrHeRHxurvsPiN9qZW16JM1t35DWTtT6cbtGWcfvPGPY8zlUoBmznyoMrUimIpUHLlVwIPPcouVKuxzmWSA2cbIwcnFo/jGH8U0NW6Vqq1/OmpvvfI5iPWWeXHXhQMMc5fBxE8/WwL4+JCYE5x5FP9rmzIcbv04PAojR8lA/Fl6Dym7TQkAsxidwXNwBF/+QsQPamW3r6P+MFW6q4rgA/dN0DG0sQcmI4ViR/wuIiQIndwfvLSI3shZagTAs2O9PDS+5A+64x5UfoTMcDJ8TerZIRG1NcKHEFQiNyYwADgw5F/+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dge+Wohza8VNTmicDnrqIU7ZiQ+jKHAuw30Z0jYAzqM=;
 b=P3NngMQ0yFoTsxtEOArL/fPGTSfOtOapdqqBjGX96v6OqFsWaLGFjHPGMZl1VsICDBcrjP+5GXZwGcrj5vq4MbcGUE86n1zL2a7ZVRLsxvN42m5RkNbdEB/7uzwXo5Tcq1o/VBvTg7/nT/0blMJDB3+KjtlKvT4polM3GlVgaowboAPxc+FeanIFdpuSwiRCcKkOBS5Sxn8rrg5UZDQArJwur9dUDnXRjYJgQ7GdnDMXFi2ESOgjXPiwzUYPWKsfDclAScDu6MwMX2u5dARIatHWIXwb6QWVefPDueUDPzY8zEQP96pN6sqVC7Sldc3Odg2diBfLWKnRL8swuSXazg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB7788.eurprd08.prod.outlook.com (2603:10a6:10:3b7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 12:33:36 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Wed, 20 Aug 2025
 12:33:36 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Frieder Schrempf <frieder.schrempf@kontron.de>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v3 13/14] spi: airoha: set custom sector size equal to flash page size
Date: Wed, 20 Aug 2025 15:33:16 +0300
Message-ID: <20250820123317.728148-14-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820123317.728148-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250820123317.728148-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0151.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::14) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU0PR08MB7788:EE_
X-MS-Office365-Filtering-Correlation-Id: fbd020ad-7cef-4079-6512-08dddfe5c84d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RdXYi8kBdSy/ZtfHRwgc5IgQA1dSQbF80Og5y574GHzULNwwZBWu/wu7yMIE?=
 =?us-ascii?Q?PHjk15l9NVv16CmrHPVY6pYqijo2IwU/b/aT/5AAAUEfB+sZWzLkhFGSNu+x?=
 =?us-ascii?Q?FxWGP7aFeBcJmrJQvRN+oGde85wXab+OtOLneJFN40mfYypXWlnEIMYHL37z?=
 =?us-ascii?Q?8+jkYhh5b9sYhpggV/s6j035zvvp/MqnOxb9kHUw70avGTa74lFgrkWXf4jq?=
 =?us-ascii?Q?D6AIGbj2aMhJxz8GDg7o/m0PiTi2PBGsLE2lpJbxy72rJ8HNd5Jd1sWtT+Cc?=
 =?us-ascii?Q?78CTObOVzqqtVTrnmX1N5S5+iW0Hla3e8bvD8AlRvm3t0q8hI36twuZs9aXZ?=
 =?us-ascii?Q?00cAlzUyn1MMJaJX44CUyPV9AzEY9Ut2DfW21IRIaNvSeBT1Zf3kTBywrlcG?=
 =?us-ascii?Q?lGC3UV8GwnJWMERQ89ZwA8J8IlcC9GEEwGlUm4P7TMwx3QCfPHgqEaSHfmGf?=
 =?us-ascii?Q?N7Py4dRxPGmxX9KmKKgtwK2RUXOl+A2dLyxSRKEoVYbS8uYiatod4UDWhT4t?=
 =?us-ascii?Q?LKPFxOSuozctwBLk2o8Zls/jT82hCxT32Silo+8UeJkcavvXTw6LOGsGHrna?=
 =?us-ascii?Q?Dn1IrUxcz7vgWhoxopYo1EgBJimWfXA0Xy2M5Sy6riS5Mv9F8P6+kT8l6YqH?=
 =?us-ascii?Q?ecj5HP5Zv94F6AVIw3LqABaKi1fCpEsbTds7aTHTw+9eN0KcBbTqfUWIvDQP?=
 =?us-ascii?Q?tLxrfHAvzxDyw9Ic92yVvPNp83NFBRI1z44SP+gLd0V3rcFBvzjgLnM/AHlj?=
 =?us-ascii?Q?+b3hAv1AteqEH4weRWxPDdu6uPtWdkqMmwDywaZsoFBfFU52Prz50+01UtX8?=
 =?us-ascii?Q?a8ns8ga+XDNibA1lvQgDbg1pi2SjohgXLI7CkUsIRxQm3RUeOL6wth4iyR7D?=
 =?us-ascii?Q?sbEhiogUWzJ9wYTefYsLhIwHNScFJ6krW+p39yWtXZzAOQ814QDSgFzz9cKa?=
 =?us-ascii?Q?r4S9E40+RkOw3qKe1QepLfxDQywA90Fb+4oCLApkCsfgHe5kDUjb87kE3gf8?=
 =?us-ascii?Q?h7A3fV1+Q4vhWXVX3Lzgoi5Qxl9zOCJPZaTZqb68L5NHYsm4nSTUF20CFy+i?=
 =?us-ascii?Q?wEEsuS4jB1vxvWUhljEwvHCtGBt5Nhb6ztk3jIo6FUXtg1y/EvXYjL67IK6X?=
 =?us-ascii?Q?Wjk3D7MDj8HGjYZnWAeUCjPU12GVY+8eE8olz7oFHEMAliDjRr6pg48dnN52?=
 =?us-ascii?Q?NKyNEnylFr1nQfNDaeQ4FREWVvwDOJxP3D/72mfg1ojJyj2td4ceiGzlEHnG?=
 =?us-ascii?Q?NcB+X4nOSKqCEHVL/2KFjVERBxcK1hWxqT+75nqVre38Wv2GHcdaST+Rn3NF?=
 =?us-ascii?Q?Cpe8yi8Jpk8SoNNJA3bzqA02yb/bLz2uw271yM+2yXaqaBEaqHTYFTC2o3mV?=
 =?us-ascii?Q?dBPunnMDuAxNwMHKzaCXaouwi14bYyuGWKucFpiF9BlUvbFllH23UDSai9g1?=
 =?us-ascii?Q?FoPwf/+7OeXhm6UmHdgLEGAwECkIrcYhj3JueAET0I1ogdaMY1uTTQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V9KDAJPVr8qvzNQI+jqEfo39PqRQTzH43qeWl+4zdrtiFsai3Zeh5svuMmeo?=
 =?us-ascii?Q?MAc9Nl25/WPmRhni/o2vC5xvIohEBBO36Y2QsBm10gHDD4mj2ztFUietMapl?=
 =?us-ascii?Q?6zqstYRdM5/lndIp/8cWsurJ19BGpt3HRhWWdEG1a8rrN39B9Yp6z0NgAbWY?=
 =?us-ascii?Q?3lWBALplKG2WWxxtpYs9VqhEjTu1VkGTeWENxBXfdwxEJqCwBHD7Tx0FEt/v?=
 =?us-ascii?Q?yqGlVauFDw4xSiaCLnHTR5rK2B2xg7OWzPn1Pka24iU48e+8gQV3HLHSuepX?=
 =?us-ascii?Q?EjglfC3f28XPIjo2mjnmvKDXy+yGmUzjgJL2WwT535158IwPD20LCutUp8d4?=
 =?us-ascii?Q?zbhaaxu+uN61Hxcrr44YiC9VJnc691n/tDSyAhwpCatDag/dJ5itCBjjpjTc?=
 =?us-ascii?Q?OzwiiI5ubrfIY2AvRVlxpC7WDleBsth7ZgoazMLGvBGeEFGTluXwHt0Z1aqD?=
 =?us-ascii?Q?vHINFOv4Uo2rNRUIdG9w0LFiTghk+jsO88aA8yQR/m/pEslTJ/OhdJ7Lm1j8?=
 =?us-ascii?Q?XajllKzS5Wfx5vlSmA0PlI4JnO6q+RQzmyON2MfPUIY0MSCbpOy7b+77G+Wz?=
 =?us-ascii?Q?Rbx6Sz5/poRX6ujSpfeGVM7f1dd+SsMVM3nbcz4ZAB1np2K2ef3cC82X8AAj?=
 =?us-ascii?Q?P5Oyf2C3HpagPXdg3gbDrNxQbN73NT2p4mQX0UE8PpwuI8mFD+fxfXTViU4n?=
 =?us-ascii?Q?K0+O0xK/N5av+PQZeAKO6AFosQKAjBvDKX4cmhuOMJ2byBDpgsM2pPDAfTSX?=
 =?us-ascii?Q?OHSPCYWyakKDAP8CCy9mfOHz4AvfSrMuQE2Z4BXT1vR1V5P/OT8FDBPuYDTh?=
 =?us-ascii?Q?NaOhRFsNG3srTjVdKtbTar6y8K6NEGi1I/QGczows1HgEPtuH33DZ4KzlkU9?=
 =?us-ascii?Q?IlWZwzgzyNXfvv6qZBXMOCkOP0GrUeyl4Z5Mfa9bw7A4gS4817DmhdhB7u/g?=
 =?us-ascii?Q?zQJpO4d9ltytHhdoOyIIO7qshBbXY4+uMfUH2ofOP/zTakBTNJ2z3I6HLhdO?=
 =?us-ascii?Q?BYhyOcXmh5Rjwemn3OTGxhdwxN7c8h/BKVZszqFC7iwG1hlPCKLbpIag/R/N?=
 =?us-ascii?Q?6vPnmRbpsn3EZixnJLcLmUZc5aGeX7ffbEz1mLA/TlYX/ogbDLFHOHVl8eWS?=
 =?us-ascii?Q?egoLq85jjRpLBltjMH22tl8YgG+ZofcrZLWU7New9MXyS/++tD27+elMbM7N?=
 =?us-ascii?Q?cMSQkZks7JFeC/H8zWVvpvgLAdU10crsdLh3ezqCfnYeQxVFaSOxaU70hZ66?=
 =?us-ascii?Q?Z0zZ4XgyFN+jt/fo9SsIfqkIXldrTVa6aRtIFBpeSahqR1GMl5k7Qrnl38uJ?=
 =?us-ascii?Q?dIp3mHc2jEtylwyX3pEE+dZZwbMVPH7djXpjram5H3KynkCFeBENXaCpfKT2?=
 =?us-ascii?Q?oghz8BV3DLgoegnhHhGLGt6UkF8J7q6kki7cnhKj23LS8haXdUTFcoHLMKig?=
 =?us-ascii?Q?j1mOMLkTvAl+SvxlLab2H3AZeIfNg88dA9mqs191v5Y7oZFa+tKXAuGZwcC5?=
 =?us-ascii?Q?IZrGLhVzz3IBjNtDk9kd/W7rsAcK2UuczUsdsOiupmfls1+q9L94v8Ui/REy?=
 =?us-ascii?Q?MsWaiimIQSwCthmZK/US7K1ahqE8lAGXDwJX7ds0/JQVTe8nAH1keCNpCf5A?=
 =?us-ascii?Q?WAjw0+WKrof091PbLB9IIP8=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: fbd020ad-7cef-4079-6512-08dddfe5c84d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 12:33:35.8967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9pMMPc7Udm50kkUC7vC/QYwbDYqYZRkLMOLD33HeihRy6g5OoBh324IPdiUvqeflCOWNBPDcBwUl7ujJPEwIxb0i3Ul2yGfah5v36MrnSgk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7788

Set custom sector size equal to flash page size including oob. Thus we
will always read a single sector. The maximum custom sector size is
8187, so all possible flash sector sizes are supported.

This patch is a necessary step to avoid reading flash page settings
from SNFI registers during driver startup.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/spi-airoha-snfi.c | 38 +++++++++++++++++------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index 10c4081d54cf..a02dc6de5406 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -635,10 +635,14 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	u8 *txrx_buf = spi_get_ctldata(spi);
 	dma_addr_t dma_addr;
 	u32 val, rd_mode, opcode;
+	size_t bytes;
 	int err;
 
 	as_ctrl = spi_controller_get_devdata(spi->controller);
 
+	bytes = as_ctrl->nfi_cfg.sec_num *
+		(as_ctrl->nfi_cfg.sec_size + as_ctrl->nfi_cfg.spare_size);
+
 	/*
 	 * DUALIO and QUADIO opcodes are not supported by the spi controller,
 	 * replace them with supported opcodes.
@@ -696,18 +700,17 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 				 FIELD_PREP(SPI_NFI_OPMODE, 6));
 
 	/* Set number of sector will be read */
-	val = FIELD_PREP(SPI_NFI_SEC_NUM, as_ctrl->nfi_cfg.sec_num);
 	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CON,
-				 SPI_NFI_SEC_NUM, val);
+				 SPI_NFI_SEC_NUM,
+				 FIELD_PREP(SPI_NFI_SEC_NUM, 1));
 	if (err)
 		goto error_dma_mode_off;
 
 	/* Set custom sector size */
-	val = as_ctrl->nfi_cfg.sec_size + as_ctrl->nfi_cfg.spare_size;
 	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_SECCUS_SIZE,
 				 SPI_NFI_CUS_SEC_SIZE |
 				 SPI_NFI_CUS_SEC_SIZE_EN,
-				 FIELD_PREP(SPI_NFI_CUS_SEC_SIZE, val) |
+				 FIELD_PREP(SPI_NFI_CUS_SEC_SIZE, bytes) |
 				 SPI_NFI_CUS_SEC_SIZE_EN);
 	if (err)
 		goto error_dma_mode_off;
@@ -725,12 +728,10 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 		goto error_dma_unmap;
 
 	/* number of bytes to read via dma (whole flash page + oob) */
-	val = (as_ctrl->nfi_cfg.sec_size + as_ctrl->nfi_cfg.spare_size) *
-	      as_ctrl->nfi_cfg.sec_num;
-	val = FIELD_PREP(SPI_NFI_READ_DATA_BYTE_NUM, val);
 	err = regmap_update_bits(as_ctrl->regmap_nfi,
 				 REG_SPI_NFI_SNF_MISC_CTL2,
-				 SPI_NFI_READ_DATA_BYTE_NUM, val);
+				 SPI_NFI_READ_DATA_BYTE_NUM,
+				 FIELD_PREP(SPI_NFI_READ_DATA_BYTE_NUM, bytes));
 	if (err)
 		goto error_dma_unmap;
 
@@ -819,10 +820,14 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	struct airoha_snand_ctrl *as_ctrl;
 	dma_addr_t dma_addr;
 	u32 wr_mode, val, opcode;
+	size_t bytes;
 	int err;
 
 	as_ctrl = spi_controller_get_devdata(spi->controller);
 
+	bytes = as_ctrl->nfi_cfg.sec_num *
+		(as_ctrl->nfi_cfg.sec_size + as_ctrl->nfi_cfg.spare_size);
+
 	opcode = desc->info.op_tmpl.cmd.opcode;
 	switch (opcode) {
 	case SPI_NAND_OP_PROGRAM_LOAD_SINGLE:
@@ -838,9 +843,7 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 		return -EOPNOTSUPP;
 	}
 
-	memset(txrx_buf, 0xff,
-	       (as_ctrl->nfi_cfg.sec_size + as_ctrl->nfi_cfg.spare_size) *
-	       as_ctrl->nfi_cfg.sec_num);
+	memset(txrx_buf, 0xff, bytes);
 	memcpy(txrx_buf + offs, buf, len);
 
 	err = airoha_snand_set_mode(as_ctrl, SPI_MODE_DMA);
@@ -876,18 +879,17 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 		goto error_dma_mode_off;
 
 	/* Set number of sector will be written */
-	val = FIELD_PREP(SPI_NFI_SEC_NUM, as_ctrl->nfi_cfg.sec_num);
 	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CON,
-				 SPI_NFI_SEC_NUM, val);
+				 SPI_NFI_SEC_NUM,
+				 FIELD_PREP(SPI_NFI_SEC_NUM, 1));
 	if (err)
 		goto error_dma_mode_off;
 
 	/* Set custom sector size */
-	val = as_ctrl->nfi_cfg.sec_size + as_ctrl->nfi_cfg.spare_size;
 	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_SECCUS_SIZE,
 				 SPI_NFI_CUS_SEC_SIZE |
 				 SPI_NFI_CUS_SEC_SIZE_EN,
-				 FIELD_PREP(SPI_NFI_CUS_SEC_SIZE, val) |
+				 FIELD_PREP(SPI_NFI_CUS_SEC_SIZE, bytes) |
 				 SPI_NFI_CUS_SEC_SIZE_EN);
 	if (err)
 		goto error_dma_mode_off;
@@ -905,12 +907,10 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 		goto error_dma_unmap;
 
 	/* number of bytes to write via dma (whole flash page + oob) */
-	val = (as_ctrl->nfi_cfg.sec_size + as_ctrl->nfi_cfg.spare_size) *
-	      as_ctrl->nfi_cfg.sec_num;
-	val = FIELD_PREP(SPI_NFI_PROG_LOAD_BYTE_NUM, val);
 	err = regmap_update_bits(as_ctrl->regmap_nfi,
 				 REG_SPI_NFI_SNF_MISC_CTL2,
-				 SPI_NFI_PROG_LOAD_BYTE_NUM, val);
+				 SPI_NFI_PROG_LOAD_BYTE_NUM,
+				 FIELD_PREP(SPI_NFI_PROG_LOAD_BYTE_NUM, bytes));
 	if (err)
 		goto error_dma_unmap;
 
-- 
2.50.1


