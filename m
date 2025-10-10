Return-Path: <linux-spi+bounces-10554-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 630E0BCE847
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 22:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B194E19A84A8
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 20:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE0130275C;
	Fri, 10 Oct 2025 20:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="XSFhzmgQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021092.outbound.protection.outlook.com [40.107.130.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160E2302749;
	Fri, 10 Oct 2025 20:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760129124; cv=fail; b=aTDqzagcmEuWn+RvDwYNR8sUgxzt6MpChKZ7XfXLbdLDOcpl198RJ1gSPVSAD0SdNi9kxQsPEfRVrXYyNcO5DhxivvNHzIguWlRTC9D1CLFkgfevs9ZHZeIElCoWpinHMqpVsLXKOIJ+nDcEFf4nUnRUJ3hPWx3nSiw/WrL2DAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760129124; c=relaxed/simple;
	bh=4vEupTlFblAxVYLWw8wNiQeHRVE4Pd1f1C8AoyYUpKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AXg4QQvPEahnlJJPSN4mfyOl1AT2/hI7dnDYZWTSXz5hPd5OEqof1TCmN/vMvSBmkdelWbVNQ0F0Ejqbay4X8Fh6b0NwTow/XUl8MJaAHagmIeNk5Y0dJzIC1epBVC3Y7cl5TDHk8Zy/1SbHrbw726IbLc/FOZ5R1lED3N0MmR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=XSFhzmgQ; arc=fail smtp.client-ip=40.107.130.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FM38dS9AshD17ymCPmovWDb/DYYaYvOVyy+yRGM1PEDUuFXmwwE6qz3h2uSkn0PdsXsS5JJBXeLtPp0DoRiphSPR2mKHGJ96FEUXnFPCaeRqgAueWi1uGQ447aH4eT0H8QwGvu4VSzUVq9lxsBAXclQk76N/HOrVZY11r40HhQ6H34S0dCWKPpduwhFvmHt9bcpMs6776nPmmUDZFmHjMd6anNXKWMemAl4yHhvKjeyON04J678Rau3ka8w18FlES/hAufmLRwF4Fwz6/+QrjQimRghInLCOoJlIHzd7FxTmJPDS5ZllKYQBG6G6W0jeLNOihw/nXg/QfsR7f4DPVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vYefZq1Kji++ENuMNeN4dsMVnRysysPfLivp5ZCp2Ho=;
 b=VUVvyO41+V4oFBs8KZPoQjiPgCh6IN5yo93b2pwUF4+Dq/Z1o/kpAZQnRJHOuYaT79qvK2YJSHbV/Z2NswmqVJTMRtETk2gNniR+QCY6Jb/EkXljZHpOy+5b52j7WBNfnuXqLdvpzRp7ngzRE5tuZgWEJtrXO30Be/7PIUIlADhrDNxefKZP0sK6YwW0xR2Em5/IBzjtygPIgiolJXM3+PkX4SWZNeTRa+SqVE3tgyQKjIvOFeZ/bhgmKjws2s/xkobVlfZRGVFzn5parjN0qZ6rmiwYS+5zX0pF4Let437kRTBYZbKy4Cyoz2jgwXixViI7u00U5yaQruKWCLKt8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vYefZq1Kji++ENuMNeN4dsMVnRysysPfLivp5ZCp2Ho=;
 b=XSFhzmgQVANqUFl3J+tSuOEu57ripGPXWxBWfF4k4iuAl23IzSDZznyHAISyj3ZeNHM1qlFX35Xsm015xITOUDnNNMqcvLRIyH2w2fwPPt1Z8fU+Wu3YYUGekuNasUlRnBvjXefbA9c49BYs+POS4RLOFecwc2WQZ7ROLh7rmFOsdJBrgbKA7J9akAjBH/GOTxNgOvyesF21VMen8eLE6mYezPa0hIii4Q/oKWx1q/T2vYoZS8JXL+51n/+RU8iB8INxirlPD7lL/ZIudkAN1wRAtZ7WLmAXvppJu2mQfVjhBtsFL7dRJLJRn+ith4pEhqTb4EwSxTVneVqXpJLntw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GV2PR08MB11561.eurprd08.prod.outlook.com (2603:10a6:150:2d0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 20:45:12 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 20:45:12 +0000
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
Subject: [PATCH v9 03/15] spi: airoha: add support of dual/quad wires spi modes to exec_op() handler
Date: Fri, 10 Oct 2025 23:44:48 +0300
Message-ID: <20251010204500.1625215-4-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 86877e9a-1039-4a97-d64d-08de083de8d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NMrGKpH/XShQwT9o7TrMDd74mfI9233xnDZjaO/WPKLPH2vAYQtGmwVMtfqp?=
 =?us-ascii?Q?cgsiqBIyE4OAnFi+dAs0CJ7DV4iE1GAJhTZ2fhQyU9C769tHWh/jMi9sEOS4?=
 =?us-ascii?Q?N3w6DVKpjS9enEUbC4YNfrhEj/04oReS1wIEPhyfn+2i58t8wsvuwcj40dG9?=
 =?us-ascii?Q?tiBcJTmHyJusZxxSnhAp++dU7rDk6DcvZK9Lcpy7tPaeE1cpDimalhdjeibL?=
 =?us-ascii?Q?X01zkE7LJgzJQqrbHZv3YqWXYIySdLQAKrfjjZaQxXxZipWtsRAH0NOqgLlK?=
 =?us-ascii?Q?Owfk1uD2olgwJXi6wYPL61X596JFvAnyAPm9e5MJq8TNJnRoBVQiA6mQErJZ?=
 =?us-ascii?Q?gSfk3qZ26YUWOdrcNQFkJpO82QocCa7iKxV6VjjYG0wR/vTtAdWY2FZjUivq?=
 =?us-ascii?Q?yd34CRg3rCqqVPvekgkutI2QShXTaLVt5i8H5PnA9zoy0rrAyh+Z/hVKkR43?=
 =?us-ascii?Q?xhZJznr8i9oV2MgvzH/DoF6vA6B7+9RtvUZ5axsPPemL/Pelo8TEslWty/jm?=
 =?us-ascii?Q?/MRLLaP8ydikB8UpgCDcl9Fd9P/dPYHr4FCFro1jJiF3MA69AfP/vTI4sWzI?=
 =?us-ascii?Q?yct3L6tZbCafvM79xpqnZ4PZVCeb0NpdIxZjgH7Cf08/48qR/X6PRmx5eQAR?=
 =?us-ascii?Q?zq3u1qaaz4EoZR+JUF0pvLgZuO3Hdknx/7tIFITlr4HvouM16vpj/psn17DM?=
 =?us-ascii?Q?zg2AxIxTIxY86bH/3la72l0BDFVizCRH+xHe0dNH+uG1ZD2otiycOZwUfY7Q?=
 =?us-ascii?Q?RXeTRfB3qxdZYevdkLay8BqjRXfG8cFmNKfInOzfgQlFBlQ3+zNgKfs9/lej?=
 =?us-ascii?Q?fCGBJmebuDcHUjdoatxxYQHMyvkcXdqarmVt9zidnx2tfQbVkR8sWRCCkocu?=
 =?us-ascii?Q?Il5TL4IhNyWawnGYf2Q5BqLIACKC5gVdPjad48I9UvpOwy+BrZsYzIMIvhua?=
 =?us-ascii?Q?MQiMar1FFOGsrdlfkgtQXYnzF6MJa/km/aipQiY3UitG9vyJbFCh6yrrNZDF?=
 =?us-ascii?Q?3k998DAXmZo3A/ztlTEtFZk73q6CybnRVbBCJ2id/+SUSBQoXBzxm13FP0Fn?=
 =?us-ascii?Q?xqGJsDOw3HrsCqf33XLrBVIryAP/2izfFEAh00CNfIHozbPJE8ejcRgWuSSi?=
 =?us-ascii?Q?7QJs04iZ0yqhdiMo3DOxjoSuxKgbzmnHultQday5u6cUijSb78Rpst33Zcib?=
 =?us-ascii?Q?7oZBkfwniPzG8P//iFkRlz+JQ/jx5yWvirXpCFMsGQCZRg6XzXdzivD0ZN4U?=
 =?us-ascii?Q?TxnnRMOE6UW36Rsk/6PQtqozuqrJATjfCU5Z8Y8O7GQ3Z3/JWnOF5H/h9363?=
 =?us-ascii?Q?ra5S1C+pEtLB88Q1iJlec5SC5CWYM5tBM7nvF2GuO5OVe053YkPMIE0B1bnT?=
 =?us-ascii?Q?v0b4jw4YIoMwIMb+7S+oSJ/Yp1m7BkFSTEe/CKlooUXI4w3khqVaWyUL2xW9?=
 =?us-ascii?Q?plB3i161BlWxAIMVqWIQXLj1D/hf55md0hhEnm3aZq4WGU7yysOZEUFtN8B1?=
 =?us-ascii?Q?kleDz9jTSkB3BaNghsfuTQciBbIJR3pyTwSVcZGADQ5PU6/aO7iu4bhzdg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Qa4KcSnrtjY5aTo/0iWtFc1u573+H3bTDS/WTV7Smh11XdFlSVdffQ3aGE1D?=
 =?us-ascii?Q?uK5aDKycQtM8BuaZNMucuyXhOLkztP+h6oV9jLP/OPRotLeoUBpzmtIDSW4K?=
 =?us-ascii?Q?QS06qkLt09YOylIHL+tjGNTpssXv7p9sCvP0LWewTeGyUjuPjtrKeIwvfpw2?=
 =?us-ascii?Q?kJydAPVqQm1mT9Z+Pm9AVQlUUuiCY0gY/RSLakVxEBqn8yM+GYvf2zvovRHZ?=
 =?us-ascii?Q?T2g8FEON7xdmb0wXCmNuXQBhT63Q3SCTAp+fhmNT+SaRY9eNsci831DguMTk?=
 =?us-ascii?Q?Gc7UkUyPzgt8pqAuvNVgruQpqssS613fq/pwVnL8aXNa02YHjyjmysSQHR0w?=
 =?us-ascii?Q?dlwAhdsyM+fOSOT1bsvPsynUCWCdPHUcSmAf3vty483I3z/5DVTw9AgHCa87?=
 =?us-ascii?Q?atoqvR6IngcoE0IJ2mdd+jOmrQvOTak79zyijLy4N+QK6REg2QLUr0iGFKcw?=
 =?us-ascii?Q?Jqag3nLTxA3RsV9PBT8dDLdoo31GnTu0SLcQ7E9RIShG4KV8WMrRePOl+Wlk?=
 =?us-ascii?Q?8ckgfGgcHhcn2p+aEkbMh29scr8+LFTxYvPH60u/BSs5PfmvsuTjuO0V1ASF?=
 =?us-ascii?Q?S1sZ2MFlRXfaU+BgYkPrTjqKd3BBBBmV5RQ0pVtoorhBUSNCW/q3BN1+WtZh?=
 =?us-ascii?Q?sAiIajoXw3vZu4VoB3fcVWJlfZfWTyM27WCBQsf1JAJbBmfpyuXP63tKPDCv?=
 =?us-ascii?Q?1v1EP1fXwqt1Xyq90l2e7hoAmKilXFbfQwSM8GMgmoorhMWvxIWh0b3ogzZ2?=
 =?us-ascii?Q?wMNcLdIX/7K8ELVCi5CDJpQTsRUQUd1KFBjq4mEwTT5LqVLFY4bsANvnPY6j?=
 =?us-ascii?Q?4ydWsC8Idj10jei2mh7jillRV2xsMCdA/8E6HfVA3zAfmp4qrJSQp3OlV4XN?=
 =?us-ascii?Q?laK5OYANGWK3FK5Hxz4+fcUIaXPTCfQ00EA0WqsLq3qckvfJ8bKEi32m2Wj9?=
 =?us-ascii?Q?ft+fDh9OYL3WpubRPRDcoMXDt0vryYDSoCJsFK3z1xibms5BJQ336DOqh2/x?=
 =?us-ascii?Q?1p1SwwfZMbRoIKPefdWIVWWDcshwT41QW2q9AqPVffjLEhi3lT4PrTKewaL4?=
 =?us-ascii?Q?+LPHFJloC2T8cBSH8fF/1zJShMiSf4F9HjZDMfnOVrvJKjFmS8FUZGTreklA?=
 =?us-ascii?Q?pNOGX3+WMsh5beO77ypSGh7z+cW91CcRR7i0909RiTwanPOF7eoJEErTKF82?=
 =?us-ascii?Q?ZD2wmChAfD8C+dPy8ec0fJVOz+rd9DYAwGcMlgmN2Uvwv3+B0g8psQZIQviW?=
 =?us-ascii?Q?wMaqwPZcr8oRRe3wlKrLaWFNnQ0qw/ZUVrTCEdQalimQsCca2s8F+oqpijb2?=
 =?us-ascii?Q?nYBR3bPuTIlar7I/kWKUgUQcVaSJ9pP0bg56J3gv4lBOZm2DPBLcDlddmkgv?=
 =?us-ascii?Q?BkSzbqtn3/w0NOvto1HdGMA+mwu9VwNCTe+69OEYYbnMEiTe//L0wyxPC978?=
 =?us-ascii?Q?Fa+4wOT/hoHar+sL2yJLu9IouTmmUuuitb89XcpB9t98sJxmKP94nLXEonUy?=
 =?us-ascii?Q?y7vOM9QoJaSMiz9sV+796gVWgUpW47BgxCZ6nMse+8m7DXQHVXzr05ZdOsue?=
 =?us-ascii?Q?yCSzXHiUdfrp9IBF0Gh7OFaYmcX+gDx+3jQbyHprre1ToXnifEYHU43kf2YE?=
 =?us-ascii?Q?9id0oYj0hXnHVKnXWvDfu4Q=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 86877e9a-1039-4a97-d64d-08de083de8d0
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 20:45:12.7759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 38dwqEj2fDM4LI270f59mOZW2Yg5S7Ov6rJOw6pf4KhdD6NGMX+adGxLMr12KYLvQs4p7B5lB1+Qt5Itl2EdhogRTvL2AhaA/Pj0I09WuIE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB11561

Booting without this patch and disabled dirmap support results in

[    2.980719] spi-nand spi0.0: Micron SPI NAND was found.
[    2.986040] spi-nand spi0.0: 256 MiB, block size: 128 KiB, page size: 2048, OOB size: 128
[    2.994709] 2 fixed-partitions partitions found on MTD device spi0.0
[    3.001075] Creating 2 MTD partitions on "spi0.0":
[    3.005862] 0x000000000000-0x000000020000 : "bl2"
[    3.011272] 0x000000020000-0x000010000000 : "ubi"
...
[    6.195594] ubi0: attaching mtd1
[   13.338398] ubi0: scanning is finished
[   13.342188] ubi0 error: ubi_read_volume_table: the layout volume was not found
[   13.349784] ubi0 error: ubi_attach_mtd_dev: failed to attach mtd1, error -22
[   13.356897] UBI error: cannot attach mtd1

If dirmap is disabled or not supported in the spi driver, the dirmap requests
will be executed via exec_op() handler. Thus, if the hardware supports
dual/quad spi modes, then corresponding requests will be sent to exec_op()
handler. Current driver does not support such requests, so error is arrised.
As result the flash can't be read/write.

This patch adds support of dual and quad wires spi modes to exec_op() handler.

Fixes: a403997c12019 ("spi: airoha: add SPI-NAND Flash controller driver")
Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/spi/spi-airoha-snfi.c | 108 ++++++++++++++++++++++++++--------
 1 file changed, 82 insertions(+), 26 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index bcc464ec9c61..fffed26ff990 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -192,6 +192,14 @@
 #define SPI_NAND_OP_RESET			0xff
 #define SPI_NAND_OP_DIE_SELECT			0xc2
 
+/* SNAND FIFO commands */
+#define SNAND_FIFO_TX_BUSWIDTH_SINGLE		0x08
+#define SNAND_FIFO_TX_BUSWIDTH_DUAL		0x09
+#define SNAND_FIFO_TX_BUSWIDTH_QUAD		0x0a
+#define SNAND_FIFO_RX_BUSWIDTH_SINGLE		0x0c
+#define SNAND_FIFO_RX_BUSWIDTH_DUAL		0x0e
+#define SNAND_FIFO_RX_BUSWIDTH_QUAD		0x0f
+
 #define SPI_NAND_CACHE_SIZE			(SZ_4K + SZ_256)
 #define SPI_MAX_TRANSFER_SIZE			511
 
@@ -387,10 +395,26 @@ static int airoha_snand_set_mode(struct airoha_snand_ctrl *as_ctrl,
 	return regmap_write(as_ctrl->regmap_ctrl, REG_SPI_CTRL_DUMMY, 0);
 }
 
-static int airoha_snand_write_data(struct airoha_snand_ctrl *as_ctrl, u8 cmd,
-				   const u8 *data, int len)
+static int airoha_snand_write_data(struct airoha_snand_ctrl *as_ctrl,
+				   const u8 *data, int len, int buswidth)
 {
 	int i, data_len;
+	u8 cmd;
+
+	switch (buswidth) {
+	case 0:
+	case 1:
+		cmd = SNAND_FIFO_TX_BUSWIDTH_SINGLE;
+		break;
+	case 2:
+		cmd = SNAND_FIFO_TX_BUSWIDTH_DUAL;
+		break;
+	case 4:
+		cmd = SNAND_FIFO_TX_BUSWIDTH_QUAD;
+		break;
+	default:
+		return -EINVAL;
+	}
 
 	for (i = 0; i < len; i += data_len) {
 		int err;
@@ -409,16 +433,32 @@ static int airoha_snand_write_data(struct airoha_snand_ctrl *as_ctrl, u8 cmd,
 	return 0;
 }
 
-static int airoha_snand_read_data(struct airoha_snand_ctrl *as_ctrl, u8 *data,
-				  int len)
+static int airoha_snand_read_data(struct airoha_snand_ctrl *as_ctrl,
+				  u8 *data, int len, int buswidth)
 {
 	int i, data_len;
+	u8 cmd;
+
+	switch (buswidth) {
+	case 0:
+	case 1:
+		cmd = SNAND_FIFO_RX_BUSWIDTH_SINGLE;
+		break;
+	case 2:
+		cmd = SNAND_FIFO_RX_BUSWIDTH_DUAL;
+		break;
+	case 4:
+		cmd = SNAND_FIFO_RX_BUSWIDTH_QUAD;
+		break;
+	default:
+		return -EINVAL;
+	}
 
 	for (i = 0; i < len; i += data_len) {
 		int err;
 
 		data_len = min(len - i, SPI_MAX_TRANSFER_SIZE);
-		err = airoha_snand_set_fifo_op(as_ctrl, 0xc, data_len);
+		err = airoha_snand_set_fifo_op(as_ctrl, cmd, data_len);
 		if (err)
 			return err;
 
@@ -895,12 +935,28 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 static int airoha_snand_exec_op(struct spi_mem *mem,
 				const struct spi_mem_op *op)
 {
-	u8 data[8], cmd, opcode = op->cmd.opcode;
 	struct airoha_snand_ctrl *as_ctrl;
+	int op_len, addr_len, dummy_len;
+	u8 buf[20], *data;
 	int i, err;
 
 	as_ctrl = spi_controller_get_devdata(mem->spi->controller);
 
+	op_len = op->cmd.nbytes;
+	addr_len = op->addr.nbytes;
+	dummy_len = op->dummy.nbytes;
+
+	if (op_len + dummy_len + addr_len > sizeof(buf))
+		return -EIO;
+
+	data = buf;
+	for (i = 0; i < op_len; i++)
+		*data++ = op->cmd.opcode >> (8 * (op_len - i - 1));
+	for (i = 0; i < addr_len; i++)
+		*data++ = op->addr.val >> (8 * (addr_len - i - 1));
+	for (i = 0; i < dummy_len; i++)
+		*data++ = 0xff;
+
 	/* switch to manual mode */
 	err = airoha_snand_set_mode(as_ctrl, SPI_MODE_MANUAL);
 	if (err < 0)
@@ -911,40 +967,40 @@ static int airoha_snand_exec_op(struct spi_mem *mem,
 		return err;
 
 	/* opcode */
-	err = airoha_snand_write_data(as_ctrl, 0x8, &opcode, sizeof(opcode));
+	data = buf;
+	err = airoha_snand_write_data(as_ctrl, data, op_len,
+				      op->cmd.buswidth);
 	if (err)
 		return err;
 
 	/* addr part */
-	cmd = opcode == SPI_NAND_OP_GET_FEATURE ? 0x11 : 0x8;
-	put_unaligned_be64(op->addr.val, data);
-
-	for (i = ARRAY_SIZE(data) - op->addr.nbytes;
-	     i < ARRAY_SIZE(data); i++) {
-		err = airoha_snand_write_data(as_ctrl, cmd, &data[i],
-					      sizeof(data[0]));
+	data += op_len;
+	if (addr_len) {
+		err = airoha_snand_write_data(as_ctrl, data, addr_len,
+					      op->addr.buswidth);
 		if (err)
 			return err;
 	}
 
 	/* dummy */
-	data[0] = 0xff;
-	for (i = 0; i < op->dummy.nbytes; i++) {
-		err = airoha_snand_write_data(as_ctrl, 0x8, &data[0],
-					      sizeof(data[0]));
+	data += addr_len;
+	if (dummy_len) {
+		err = airoha_snand_write_data(as_ctrl, data, dummy_len,
+					      op->dummy.buswidth);
 		if (err)
 			return err;
 	}
 
 	/* data */
-	if (op->data.dir == SPI_MEM_DATA_IN) {
-		err = airoha_snand_read_data(as_ctrl, op->data.buf.in,
-					     op->data.nbytes);
-		if (err)
-			return err;
-	} else {
-		err = airoha_snand_write_data(as_ctrl, 0x8, op->data.buf.out,
-					      op->data.nbytes);
+	if (op->data.nbytes) {
+		if (op->data.dir == SPI_MEM_DATA_IN)
+			err = airoha_snand_read_data(as_ctrl, op->data.buf.in,
+						     op->data.nbytes,
+						     op->data.buswidth);
+		else
+			err = airoha_snand_write_data(as_ctrl, op->data.buf.out,
+						      op->data.nbytes,
+						      op->data.buswidth);
 		if (err)
 			return err;
 	}
-- 
2.51.0


