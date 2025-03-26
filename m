Return-Path: <linux-spi+bounces-7336-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E88A725C8
	for <lists+linux-spi@lfdr.de>; Wed, 26 Mar 2025 23:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97C26188E2E1
	for <lists+linux-spi@lfdr.de>; Wed, 26 Mar 2025 22:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D8F263F20;
	Wed, 26 Mar 2025 22:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JP4mWlL7"
X-Original-To: linux-spi@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2062.outbound.protection.outlook.com [40.107.20.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450E01F55FB;
	Wed, 26 Mar 2025 22:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743028952; cv=fail; b=eVtRlCPeXwgDo8g41x6KELT2sowwUn6Hm+NuPb6thaoEqQYLeNqhLUFW32lTALjgSEmUXJxOKhAIKqokOE+GnGS80fS7+5EPkXB/VscTAlsTE9j8j9JJH2CY6O4S18bGt7gfCgXrfOvZNvmorAqi32h3D6MrdPykgqF59rDWs/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743028952; c=relaxed/simple;
	bh=Z/jQibqQgXhoVzlhtJftYQtNoMHVxlhwDQqJcbj2Qdw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=MjE/HIzHxjknaoYxTERjTbFxd3l2vJw6j5OM9hE6mIBfyyWxT5DaDGKlxGoMwItgXzntFio1INbulKGafXPvQBfzpcuCDmMRdVUVXD7mVSinWi2mRvrd5dKyxuI5S5lMG3wg4olO8NPdStVYMMe7nn5kIiR4yP1arkClwKOKgxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JP4mWlL7; arc=fail smtp.client-ip=40.107.20.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hl4FPWFaRg7Q79SeILrfDNrpkw4qDXgrCeZkitV3ZCICg53bgz7LUXpkBV7pUU+2cXuPZVSp0/TjeAMF1rCTlbWvNIohLSoESq0bAGDotQSqERDUjbriZe13SkFYmEqQb1FWRKj9xWa8KzDnKhJWKeSdvjPTCOqvU1wY5Ftvw2hGl3TtCN9S9mL0P6G8QrJkA3DEGEUJykA9bnBtQzrjNeK3C38CnqzsD7iC1YhZVP3O5jYwgI6nh0qGszArKwn/qyMWV+Xu74/8dO24RK6rNi5z/nXsZOYf4PG/kzelIxHB6/hWHdYNvVNawTxic+Ep4yNNNVQO9qFk0zY45NgGHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3DEte1MqOvvJHIUWP6MKi5Zln/qwBjFHKa+9xCNEt+0=;
 b=NTIupBOWsexHfSuxaVlZuC7/FHjLhVmYjQERQi8E12sImKGSzD/hm47Deun3FE3hkctcHrXWdHlZUbYrSAnY+KPEYvlV2TCzQi0b6TuHA06T4ffo5GXS0nB20zZhvttL8OrwXisV2Vc/JLMxur3aMX01On1gc9MTe9Z4Rl2xIFaZrh8uyvjBcZwV39gU21RSbyGaTWAsMtZUAaFttDGXbawmmpEdtWhK+TgLXI1tgpUoAl8LAv7qu0RoM8p9PkMtNkI5Y19Yia1g36heuYJN4gtOsiM+s2T+eiC7PMfNJDRsg+Aq6eZdImm912UF/JIeUerIIQfloxHUaWlFZtU3CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3DEte1MqOvvJHIUWP6MKi5Zln/qwBjFHKa+9xCNEt+0=;
 b=JP4mWlL7KojSG6G5wKnOixVmGd9yIWRJqJNIgZL75+BIDq/UBlEfi16roYStNBEJ90+0tf+vxayC/O9gr9QA7yAz8+YiEKKcCaTvHV0dTN4xTFI4q43xe3JpMLusT+rzUU2WUFu1DdSXtBeI97jyQ0a6bd/IUxNpgP6hvzdz0ZowEZBA5jOj+CkHsibw465Kkt7g6V2mqSxp/c0hVpQKZWbUVIsOTGRk59QhqOH0P43gQIvTf2lnfvaqe6qEvt/thcjk4Z8wPiqeDYcmAUPHdiZeqmtAAdhPual1IB/eKyp026gsbIESZ1ZyuTxLvFhh64gjoFgxWc0R6gfeKM0gPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9071.eurprd04.prod.outlook.com (2603:10a6:150:22::11)
 by VI0PR04MB10781.eurprd04.prod.outlook.com (2603:10a6:800:26c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 22:42:26 +0000
Received: from GV1PR04MB9071.eurprd04.prod.outlook.com
 ([fe80::b7f2:1d0:6b6a:ba58]) by GV1PR04MB9071.eurprd04.prod.outlook.com
 ([fe80::b7f2:1d0:6b6a:ba58%4]) with mapi id 15.20.8534.043; Wed, 26 Mar 2025
 22:42:24 +0000
From: Han Xu <han.xu@nxp.com>
To: Han Xu <han.xu@nxp.com>,
	Mark Brown <broonie@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	Volker Haspel <volker.haspel@linutronix.de>
Cc: stable@vger.kernel.org,
	Kevin Hao <haokexin@gmail.com>,
	linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] spi: fsl-qspi: use devm function instead of driver remove
Date: Wed, 26 Mar 2025 17:41:51 -0500
Message-Id: <20250326224152.2147099-1-han.xu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P220CA0034.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32b::7) To GV1PR04MB9071.eurprd04.prod.outlook.com
 (2603:10a6:150:22::11)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9071:EE_|VI0PR04MB10781:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e7204ac-88e6-423e-b700-08dd6cb77a2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iA+MTURxp/x/c1pV0lv/MhSRWAXE09uP6CvNIxeiCfeveDhdojBBX21K8lMI?=
 =?us-ascii?Q?7uFVuLGVf4+D9ZpOh4Sos2/WHLSnYdHctj07R2vGHYyr8ZG7rAHYTg3wZmOz?=
 =?us-ascii?Q?MNYmWnuXtFlNeo9jsb4MMBwdi8mw/4/+q0Zw0OdEOgsDXdRt0yrML0LY4cRl?=
 =?us-ascii?Q?uE0ZcKV7plAklQjHVB07e4aDvrpWPZ46Hx0PqhZKMu4snlRC3PfsO1OgU1iU?=
 =?us-ascii?Q?15hG6wwue9esGSW17zMEf1CNviX4NVfeyCNS//gkyoiRE4LZuVWzMhAsdsFL?=
 =?us-ascii?Q?oZHG9OoXCMQ/ltvZpZAJq/o4kf+NskvOvt2vST8j9KegLJDMvsPFiGXPvvc9?=
 =?us-ascii?Q?MIajqwz95gnCEl54uK+GqE5oTMzPN6DAJ6pc8+sGlqrC6at/dAxie2vPZPNt?=
 =?us-ascii?Q?Pk3m7v/wqE5KBf0KyJKsU4PywMl2djUmLFKi3Mlwb3zjPvHSX6zX7SofbxGu?=
 =?us-ascii?Q?fYHxcvAP4iNjjJTA3FJcjPcgjP0rcOiAt/v4KjnBINII9y15a1wutNE6hKR/?=
 =?us-ascii?Q?x+19EKPTKgPnMKP5zz6aCA74RzxsntGqNJezAHkgsl97hQo3aJOsvBExFRPS?=
 =?us-ascii?Q?MRNADQ4qXhWZMtV69xZPNhUXcGYY8hzxxmlZabWlPYgJFTx8aD5xkUw5hzlr?=
 =?us-ascii?Q?dFz+La1vYx7jwWwUnVEnFZMlQFClcY8njesBhEv8/Rz5J9mxPJwNP6S/y+6K?=
 =?us-ascii?Q?3MeHAFw3+xVEUnMviHxhbDPJce8wW6Fk2iUGBvliNp+C0MS+rh2145gxz2TL?=
 =?us-ascii?Q?4dNuY70IOhaUSB7eQrifR55+7BC7NtVTX/TUi6u5R4lBxAEiJ+gy5l3pgzGR?=
 =?us-ascii?Q?d6PIT2Pnjn84BX4kS6w2whiKpBdz+b45QI1lP+4RYlAN1kVx28MOq5ru1Cs8?=
 =?us-ascii?Q?6ZXTbsmM8BghFLlYs1AzKSUX/PMSJ5b88uumofDXrpUdKmpaTS89G8qZAwIR?=
 =?us-ascii?Q?BuuOhFTFKDOXU+puacMXQKp7s9thXQbMrGz1RPJIy6yztnrg1WSVcuNNQqzi?=
 =?us-ascii?Q?P7OKRd0+1/YswIt2fBhHd5zmg+66ft9F+t8WP2DCGaFDwj0VZ4SYHa7LBCkn?=
 =?us-ascii?Q?sQxcMIFvR42CxfXuV23sKBPOJq6+LMFFd7/C0bfgQwoifKoeathP+N+V4u4D?=
 =?us-ascii?Q?YfGzGOqDwDVqeRgco1FpeKclF6cPDGSXV9rvVdAziodY0fEt1rrFQmBA9RoK?=
 =?us-ascii?Q?Kva3PV14Q2SI5/5Fbcj+JyFVY4NssIz7LdDnTRasE+8HbdL9iQy6W49u+hyp?=
 =?us-ascii?Q?NcVy99VmDAbhwEbxEFh6k0JrLDTvf1E+ETtfih2vgxHDtO5gVpTLXMJBXHcM?=
 =?us-ascii?Q?Bic734OS9V4XivjHzWtx+ma4E8J7LofS+9LHk6992wJIxVJvRcghBQ9hFyuc?=
 =?us-ascii?Q?Gz57rhpnZl6hmBULmFHf8re/fFLwJ3PMJKuMqNZdm/1DsrXuuQcAQuzh/ka7?=
 =?us-ascii?Q?H1t5JXZPfuOzBDdg2K/UxM62R86tWK+R?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9071.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1f/WgDOUQ5dWb4Ab+8NOOLbmLpm5EHKwuP01XGyullFkYs4kji6PjjTz+pva?=
 =?us-ascii?Q?s7U8+3eZy2mgsuB7fcj0XBm2JoI2oFedYN72FKs/C/3zniqIRaWjwv5imTPv?=
 =?us-ascii?Q?qLUUq7vqfwd9C5c33VCdHf0BRfOuMLXxEyC1ptE3Iz64zNatygTgmWglopXp?=
 =?us-ascii?Q?M+2vOSvQczH6SUA6JvFcEZIxfNW1HaJYMwXXwbnNZr+34mVaoUqUw6pVSxSc?=
 =?us-ascii?Q?MPecQXOxq72FMyHx2E24BRV/D7XMaPBrFxgBCcWUZpaeVTp5plz9f9wnyMxj?=
 =?us-ascii?Q?/TyCCQuexGhkeNb1Ih6/PxQ3QPFCwqkW90lrE7yaZX3ECzqV3GifjpK/3ou9?=
 =?us-ascii?Q?ojjNpjul6Ky+MWWNhY0lQ/WOne8bYakkbRIa9DNfIyQ9iM2tjxR9WuXRGr0u?=
 =?us-ascii?Q?wCGVjzHvRG1xSt+gUtzEHij5oTcbvumLqUJ3dgAg0G8HmzkjFfkeeEu1XToP?=
 =?us-ascii?Q?5u681qXiDS0/UXDb4ewJ5gZ5VbneHlLHcUl8LBzT6tCi0ItjayONNtaHFk9Q?=
 =?us-ascii?Q?NRRWIzWosS6DyiYqxEWjYW+laoyL/TucoslejWeymSGXhXF6K62I/wcfw855?=
 =?us-ascii?Q?4Yomkp/cF38Z7L52nO27mAqkUwlWKB1UVVxTj8Cw9j0m6pUXKbh/dkaPuCGq?=
 =?us-ascii?Q?2RNMjhAC8ofiG3H94QINfr00Ui9u7iIPVtDldSkDEHwaICTJLPdQQhe5/imS?=
 =?us-ascii?Q?r5wLCMA1gmTQDKX6PwNTyc243ZjZv0ayFm8Ntn0e28qKWfUMlH5kimcOQGNW?=
 =?us-ascii?Q?E+MdHMw3e8tqg8Is/af78sc1K5sxtrPHWp7ikEpKQPzeVz5vvZLC6PY9gaQS?=
 =?us-ascii?Q?kAjBV1f9NeGtYothJZl2SdILdC6I8BJlYrW7UbaRbGvKSAZeHNZzlc6BT9L1?=
 =?us-ascii?Q?Ygaicqb+uR5OUrSFZq72zHmTp1+lOwhQixfwOwIMLzdcWu+LhY3u4S4pnJML?=
 =?us-ascii?Q?lcXXQimDClYypCcVdS/qIeaUH+OqORN1HarIHO990uH2th4vWCbwdTj3rCbC?=
 =?us-ascii?Q?6IGD6mJd6zqr34DMuJVj4Mv1wZ+Jmg0SMz3oM2EzP190UdEp1d8+mrA3mA7A?=
 =?us-ascii?Q?GJAje5Jh2bcQUVRp1l6YQ9qYj/VcOwbVzD7hxxjAlBxPsmgCiLWAPUl2AJv9?=
 =?us-ascii?Q?FFiyDGQI7V3y4uErIikfFxf1H+dmx2R2jRIRcZANZfjkXjTkZ5maarUGZk/E?=
 =?us-ascii?Q?suJOXY2SROAar5HJ6beVD46BvXZlaas5NL7iOF8khRYFzDsRqxnHwpEA3h1E?=
 =?us-ascii?Q?Tk4BTAnBJL0T17dM0yXr1ArxaKVyXN1OOIpLRDb4PygGrDQ3QGISpWzAFYR8?=
 =?us-ascii?Q?p86sD6nx3kk06PLt3x1BUYBW2+z4XpxurVM2x1i7QmiGk/pkOhyoAQ+YF6eW?=
 =?us-ascii?Q?P/kpSeg9zOI0D52skbBiw3hLt14s5XJcoMJ8ir90VYZFcxdRZMd12V1GAB/W?=
 =?us-ascii?Q?9YZKw9mSiuG8ZNT6jZb188wokC87p4Hgo5a36qNFPX4yJ5jOY9J+E+RWed1n?=
 =?us-ascii?Q?MdKEJkHeeJOGBV84X+tYQ8Dcjsdz3tYslhEoScqlHrAzoCMFXFwwJIAmbjnH?=
 =?us-ascii?Q?4c2b5JQAdjz4CAd7TgetLLt9QudU+6DdlYLEyT9h?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e7204ac-88e6-423e-b700-08dd6cb77a2a
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9071.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 22:42:24.2982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MWNnQjjwuhlP1jjolgWpMmLAn7JtQr30kw+IGhDpbOFXtfsZsiFYrtdZKT6KfIOs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10781

Driver use devm APIs to manage clk/irq/resources and register the spi
controller, but the legacy remove function will be called first during
device detach and trigger kernel panic. Drop the remove function and use
devm_add_action_or_reset() for driver cleanup to ensure the release
sequence.

Trigger kernel panic on i.MX8MQ by
echo 30bb0000.spi >/sys/bus/platform/drivers/fsl-quadspi/unbind

Cc: stable@vger.kernel.org
Fixes: 8fcb830a00f0 ("spi: spi-fsl-qspi: use devm_spi_register_controller")
Reported-by: Kevin Hao <haokexin@gmail.com>
Signed-off-by: Han Xu <han.xu@nxp.com>
---
 drivers/spi/spi-fsl-qspi.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
index 355e6a39fb418..5c59fddb32c1b 100644
--- a/drivers/spi/spi-fsl-qspi.c
+++ b/drivers/spi/spi-fsl-qspi.c
@@ -844,6 +844,19 @@ static const struct spi_controller_mem_caps fsl_qspi_mem_caps = {
 	.per_op_freq = true,
 };
 
+static void fsl_qspi_cleanup(void *data)
+{
+	struct fsl_qspi *q = data;
+
+	/* disable the hardware */
+	qspi_writel(q, QUADSPI_MCR_MDIS_MASK, q->iobase + QUADSPI_MCR);
+	qspi_writel(q, 0x0, q->iobase + QUADSPI_RSER);
+
+	fsl_qspi_clk_disable_unprep(q);
+
+	mutex_destroy(&q->lock);
+}
+
 static int fsl_qspi_probe(struct platform_device *pdev)
 {
 	struct spi_controller *ctlr;
@@ -934,6 +947,10 @@ static int fsl_qspi_probe(struct platform_device *pdev)
 
 	ctlr->dev.of_node = np;
 
+	ret = devm_add_action_or_reset(dev, fsl_qspi_cleanup, q);
+	if (ret)
+		goto err_destroy_mutex;
+
 	ret = devm_spi_register_controller(dev, ctlr);
 	if (ret)
 		goto err_destroy_mutex;
@@ -953,19 +970,6 @@ static int fsl_qspi_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static void fsl_qspi_remove(struct platform_device *pdev)
-{
-	struct fsl_qspi *q = platform_get_drvdata(pdev);
-
-	/* disable the hardware */
-	qspi_writel(q, QUADSPI_MCR_MDIS_MASK, q->iobase + QUADSPI_MCR);
-	qspi_writel(q, 0x0, q->iobase + QUADSPI_RSER);
-
-	fsl_qspi_clk_disable_unprep(q);
-
-	mutex_destroy(&q->lock);
-}
-
 static int fsl_qspi_suspend(struct device *dev)
 {
 	return 0;
@@ -1003,7 +1007,6 @@ static struct platform_driver fsl_qspi_driver = {
 		.pm =   &fsl_qspi_pm_ops,
 	},
 	.probe          = fsl_qspi_probe,
-	.remove		= fsl_qspi_remove,
 };
 module_platform_driver(fsl_qspi_driver);
 
-- 
2.34.1


