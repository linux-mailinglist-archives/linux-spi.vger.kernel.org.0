Return-Path: <linux-spi+bounces-4678-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EAA96DE9B
	for <lists+linux-spi@lfdr.de>; Thu,  5 Sep 2024 17:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6532B24F67
	for <lists+linux-spi@lfdr.de>; Thu,  5 Sep 2024 15:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B05119DF44;
	Thu,  5 Sep 2024 15:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="W+RVo1X3"
X-Original-To: linux-spi@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2084.outbound.protection.outlook.com [40.107.20.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8730A19D895;
	Thu,  5 Sep 2024 15:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725550914; cv=fail; b=WUM0Kq77FKuTsOzrc9i499a1l9KWsAGqzR+0DVAmreq8heDBt+6HqDXmfJXikk8Paqb0xAE671VpzH1xTyRCFpX9U3tr1KP9vKAdyuEEPX6Fy/MWGQBBB4MGfjUMXGgfuANuUMjYvtwRD1RcDr/zbTWWCDU+bEvZciM6tl3azoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725550914; c=relaxed/simple;
	bh=IOhUuCc8isQ2wT34Quv3guIQ7aZ241rcLJx+7jxJWsU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=FTwF7Ou/tx1pAmJtH7yCWlxa97AJGvbXP+eBScnuZkC3hQ+M73sdUL+KRg5j+EP/CS9PjxLFJP9IxoE76EFAl3rgOUbKmpUQhIHtH4HENM5yhbwEnKqq4nqjLe7SzWiNOYd/iOuyybAlKv7FUECgDZjET8xOpxtk8S4Uh8CVOKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=W+RVo1X3; arc=fail smtp.client-ip=40.107.20.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GKTrV0nY1aIN0gdvaARggNljaq8dLaaWD64eX24vQc3dIHOqX9fUisozGzTIsESangddeUS3tv/S/ZUpZucgRSDwTF2yg/oa0hXvv0uiVyzwRk118Gy+QYbMA62hnHdVU9HFMXhSFmIylBnGUUuj6fP0O+hIwpV3NrdMXSLvJUR6fgSqNjB5srQ2JLs8DsYyb2mhLPNKRexFClae1a9koFDN8MHK30SCULKLYPnsHpz045CF0Ojm8lmZ5E5kxgiTShiPM840saZAdLx/GXYB5sRDmPIXoire9TpNM8YfHrHFml+9Hp07dTS3PW1nOTOhiVw/WZp9OFOolhSUkrFO7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8KL9/f7Sq4UXl4UGphd2vc93lZqYyI6VAzhuWLB8O/c=;
 b=nF6P+OLIUXaVuuer4Ab/EZCapp2ZYH9vV36v2iK6PqTmOCAKgBJeMocktzccqreS4IIE3ZOVYtWYPKDnn+NKVXUgxcjQksYrPFS7NeUiKZAJN1pi8o9IzYX3Lul7nDzQnVR5dXs4nuTQW34l/xbjVuOI3n7wbafDbP/H6QQ4ZVO/10JRNaEYPh+WqMIfF63dKjYq4JrXLL+9fILi0D2sk7DlZyv/j92wcH2vhe6XnZNYbJbup9BSuZ3P/nzy/1bfyLiNLl68NN3wrbCn15TfQq1/4eR2DjTTYjxhR+TY0mMyisj5FFTvSte/LaCiXxzFmbHLGGvlCy/u0r2bEJ2EcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8KL9/f7Sq4UXl4UGphd2vc93lZqYyI6VAzhuWLB8O/c=;
 b=W+RVo1X3BnaVI3soiu46wkROFqqh+/IN2UdSL1jFoaXKVhrLC7wafltvzq9qzGYIcNc+I/XlsGKzaAdpxLhWu0d/ohz5yXGhWJhZFQ9pEqGBY6MWRPgJk7Hg25Q3aGV0ZTtn6CA1jSGjME9DZ8hX/Z19BVz+Ecc5xT5R9Sx3iJwx/ZG7m9fIFqb4jVZhLy4ktvKRKrzCAs0ik9EbMxyhNvCE8F/hPUrldVuPlaYl1zEjrui7ORimNG4LbnpFEHzISp/YDWoFNPrvACU+nnm02Vqa5onbkZJThBlrkR9zDTnbSqIx7ViNx3rhNyIDdmpS7sTtIFGqoqR/99U5Cjw3ig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8521.eurprd04.prod.outlook.com (2603:10a6:20b:430::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Thu, 5 Sep
 2024 15:41:42 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 15:41:42 +0000
From: Frank Li <Frank.Li@nxp.com>
To: wahrenst@gmx.net,
	broonie@kernel.org
Cc: carlos.song@nxp.com,
	festevam@gmail.com,
	imx@lists.linux.dev,
	kernel@pengutronix.de,
	linux-spi@vger.kernel.org,
	s.hauer@pengutronix.de,
	shawnguo@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] MAINTAINERS: SPI: Add freescale lpspi maintainer information
Date: Thu,  5 Sep 2024 11:41:24 -0400
Message-Id: <20240905154124.1901311-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0050.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::25) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8521:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b48abd5-2b4b-4b2d-faec-08dccdc13d1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MpDfBWfEuYODSnq2UFNbq/YTR9wuDKeCBFr9RPARQv4vd+PsRGsBlKVZNjuR?=
 =?us-ascii?Q?EUFq8z/iDrYC87kdsl29AKPTXPHrYIPT6BrrwmPycFnxAxUBVzQcyy9L6GF5?=
 =?us-ascii?Q?DtBXe32r+xzBnOnkkYQTwhwWoP06+eiFsxZjDAuRJwWpyWc9EejdXQZcaMnf?=
 =?us-ascii?Q?BtfuFP0vlMkPxIKdnz02dKEcuCpjhnwe82Qn3L1j5gEtnpVPv5QKqJt5ooHF?=
 =?us-ascii?Q?gmHfpkdiFWK6FuboCz9Er2RP0N0PfULRyodHZTZ9fNx9WzwDsJ9CYFZEnq5C?=
 =?us-ascii?Q?zEXmF9R2TaKy4Gxi598+4D8L5hp8LXBEm/b7C8kpmEk6orf/Hb1/+sxkV5SM?=
 =?us-ascii?Q?YgFUEZj5AbJnW1w39Kdc/sMbbb1Ab76a+aXIufT83OZEAESh9It1/FR0E4w8?=
 =?us-ascii?Q?Hy4G/THM2U3IZqqVX9Z7g1/5nI57T17BQeaku2U4MivE+OsOsbfvbI6GVc8M?=
 =?us-ascii?Q?Q99QqZg8gIvS5CL5QnNyJmi0xp4L8xEIprBbreKN5Ubw9jcpFnhwGfq+bHvt?=
 =?us-ascii?Q?lv7rCIAuUwxBQjTddf8Yt0WslkgLfQUSYa0P72XKXo8WAL+T7GX5T0jiuMBm?=
 =?us-ascii?Q?PJJ6XKwvA6E0HzXQkqfBLwzOtqSlfSM5E2HspYcL2peIIMe82DK3I+o5xZGG?=
 =?us-ascii?Q?5CYUJL54ZDv9fV15PxTm/fJTzK8BHtezS3vW+FxRqJmYjXbMMFltYLHtCQKr?=
 =?us-ascii?Q?KT8PPoRYHzMlP7nmF+zrs3WruKl0b+XdPloEX45ehTInkreOxP+aZb5rn7pu?=
 =?us-ascii?Q?qYzQ22QxRsYuNFArxsecGV0yqFmOZoVSA7y2bkDPHhpD4fJYx3fEK63LiM4L?=
 =?us-ascii?Q?0cbUmW9sjISXplhvP8/qjgBY5X6zTbSf9M9t+VEPHa14ZhW6qdruGh2ziaHV?=
 =?us-ascii?Q?h+ye/EXG5XicT3Ikz6y7G7OOvU6AYlc7nddOpsJxGiHP93ME1V5c9ipzdzgH?=
 =?us-ascii?Q?HrB0UWvx7mRMQcmDjGxyPI8R46XTRD9Vt4FMEDBt+aGWNS6mqKeXBB+xG2+0?=
 =?us-ascii?Q?NxZiCWIhQRq67y5KwKSwrBgpBeI8B6MR+/vBxRH+B8n/nGC1G0WwhSO083Kg?=
 =?us-ascii?Q?fGwJvQm40JUXD+Gxr0QD695S7rl74XNgO/Iwh5g9JQlihU8JgzBT+9rA2oN6?=
 =?us-ascii?Q?3k6dxBZ4u8O9QBGWYrCGddJt/kyBnaUgqzw5cNRjWXoKKOTC4jjWo5l7WtFD?=
 =?us-ascii?Q?feyHLTV1N2YE73/Xfpa2obgiDpM3HXZVb8VPj4pMIvRODUAzZJzghiqvVJpg?=
 =?us-ascii?Q?nc7ciDk6D6WKWD7Z0iwz0zJyl+NLFywT316NnfwIrQCjHPJ4ifDyXo9K8+qO?=
 =?us-ascii?Q?nTlx/Z8WXlW5pNkSAdvLxgSZpnoe8RoUo4r7yQIEqNlVH4NwKDrH8/ZuBENW?=
 =?us-ascii?Q?rbLdWbHxKIxZT0pSLsxPJ/fmNFzOuakfqJvQHT6EYBmtcFBiCg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HE37Z7b1v42VNHWF4rnD7RGsJ01LFny4lzi4W8+xYJe9enSr+dlVf0jevc1Q?=
 =?us-ascii?Q?lktjsr9SDd9F7tCAkqmBu3xge7MOScEpp4C7JPpvYLYQGj6sa8sPchccTTfK?=
 =?us-ascii?Q?u/T4WuyQ7n2vWwK8pauhIqiq5IAhloxvuHiVfjcroACNGQP2hWRHl+5GPyrK?=
 =?us-ascii?Q?ocxsc3HEIjOuauc+zOgXX6X1e1W0XbouSdAbCLz2unTEbEO44wXBckXHLGQB?=
 =?us-ascii?Q?DxDc71n65PI2kb5hpXkX5/ibqI22kKzEJk9vrqhs+nmYJmFFNP6cL6hvsOeo?=
 =?us-ascii?Q?lzDaG2azK0CmWZCwPYAo3pAnUX70I67i4Fm3vVfp/cXibyjKPmgECvdWM4q3?=
 =?us-ascii?Q?XjHBaTDciExtDKnyaoW9fjg5JyXQC9UqtstfLOjN8vNpzELxAkjHeTnP4MeN?=
 =?us-ascii?Q?bArOqgwjKhvqdmlndAgLwxlbhn6dKJgRaBEMoDwvM9RR/aNhjPEJhRCacVrW?=
 =?us-ascii?Q?IX1M8pbpKz/ZEFQ1mp/cvYVapGSstBFZP3j//GI0xXG2djKXgQsbiOlpBddD?=
 =?us-ascii?Q?Ip9vyEG1nPggacQpGJmXmtVCtYbmec1ALSz0WPkiDuyfBG8awFQWEf6ixNHR?=
 =?us-ascii?Q?3JCadL93WLkbdStqzz8kwZx7nSGbFf0wCw+d1WBgsxnJwWKrYe8VGs16uv+F?=
 =?us-ascii?Q?v479ALueQ+gFdIs6rnW1hH3J5zAiGPoZHnNdLhJIDuAqWjApNny2zVLHClKL?=
 =?us-ascii?Q?hwjJ/WDm7a1H4j9mnqu69uwVXobipuSMD/qXE8eD4wUJ2ccn9D4wwof/g1v8?=
 =?us-ascii?Q?0JiyYzVyZ58MFoS+lnUwEjN7g4tz+AjvSkqc2F/XPq/YvxVRvRKhUp5fF2w7?=
 =?us-ascii?Q?vmjoM6jLK4TgfeSh7qMIJCkZcQYJexQ6cBYTquU9TSxpgQdRGDsdPaKIgjKl?=
 =?us-ascii?Q?B/RRpm6LX24p7fPPq/t9wzBnmuIlI8sRtKbeE5YOQAqjp3WbMI5lwy1lQTzQ?=
 =?us-ascii?Q?pUFJUaMd+40kbfTVepQ8vBygf82BOUQvrsrY69GrgpEQ5/05i11T0CKd/WiY?=
 =?us-ascii?Q?1qdMdns3A4msQfE20GFOLrLrvmAS1ih/vQtSUW49JQgfHQK1H/n63yPgUF80?=
 =?us-ascii?Q?egQTmvISHbvavfv5R+zb7PwjvJDepvXxWsoyTBpLzF//F9nzJ4tDUg1rWIIv?=
 =?us-ascii?Q?nXYJPFgvBGUvQWSJ53M78XGt6FfYyPVF+PFuJnqxrfaoRjZWIY62lCDFtWFP?=
 =?us-ascii?Q?bYtEARSahwGpDNFAqU18txC0JDa33mxSbymFDAHqe+NhVtSgUZaTZmqoxzL0?=
 =?us-ascii?Q?WCA/VkAYjHZ5v/bce8/y3J+lvTUNGqe86AH4zXFIgxRNBrtQKjKhMdGMCsey?=
 =?us-ascii?Q?w4sDqqttGhMoY/bOdei2CubCI3oXxJNuS3D8czwBHqkuMZP88An81hHFKWbe?=
 =?us-ascii?Q?uQJfW+zr17gsmNVPK8dU8vUHpDNmAe6m6GX5km6vA2lt7RgGyqrQqkMKeinl?=
 =?us-ascii?Q?iqCoH5RMlwA2CCbx9HaR+aoZ1FUXUNInmeOQAwEvsaMjFPJ930u/peczSLvD?=
 =?us-ascii?Q?jf4U0V64M8SGD0qxZq+Q3w6phszDr89Fy+HjHyug9jb+34LHuWJHa879NuvD?=
 =?us-ascii?Q?mhRzCc1IOG2ooSPHLTbEDxT4ZvyXzgwWOSs5XIYt?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b48abd5-2b4b-4b2d-faec-08dccdc13d1b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 15:41:42.0260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TXCEgRjF9ryKZXhIjyFTy4YkUN1cs9qbfZizqUOLJKnuyFA0EmHxM9LaS0jZZqeJHDJ4cQ04lFqV77h0Jx19dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8521

Add imx@lists.linux.dev and NXP maintainer information for lpspi driver
(drivers/spi/spi-fsl-lpspi.c).

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 87c128de792b4..59eb18b0261fd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9042,6 +9042,14 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/i2c/i2c-imx-lpi2c.yaml
 F:	drivers/i2c/busses/i2c-imx-lpi2c.c
 
+FREESCALE IMX LPSPI DRIVER
+M:	Frank Li <Frank.Li@nxp.com>
+L:	linux-spi@vger.kernel.org
+L:	imx@lists.linux.dev
+S:	Maintained
+F:	Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
+F:	drivers/spi/spi-fsl-lpspi.c
+
 FREESCALE MPC I2C DRIVER
 M:	Chris Packham <chris.packham@alliedtelesis.co.nz>
 L:	linux-i2c@vger.kernel.org
-- 
2.34.1


