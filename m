Return-Path: <linux-spi+bounces-11506-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 09426C845DE
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 11:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DC06E34DE19
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 10:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67AEE2BF001;
	Tue, 25 Nov 2025 10:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="i1fAXbz6"
X-Original-To: linux-spi@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012023.outbound.protection.outlook.com [52.101.66.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04472CA4E;
	Tue, 25 Nov 2025 10:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764065243; cv=fail; b=dhmvoNnAaTAh9TiXYYX9NeDTeYQLr4MW2YdyABUExTQPtech+unV8V4yVkJnB7jJCasWiMMlvS9gqB8urktCwnr89o2VD8UZTVWzWxaKq/sXPKSa6Gg4RNO6HlrMFT7psTT8UuY+yzPWf6lI2jJ4aHvR+2XuFDFC7e0UQg5SOms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764065243; c=relaxed/simple;
	bh=6yanx9z7R2Xw2qi1P+MkgRU0AUCx2xnRXKH3WMzny1k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l1ZD+PviTiVQAjHntpK9kpSh40SUa8Nv684ZghqukuXumTJ5tuZhIkG0tflH/vCBWWVJg55MYpgtpKhWoMpZlY2kzXUVDg/OjGSURYqA8P6WWQLvOZE403cgaEuHldhiAK0tAN7hsx0o4rDnN7a0HIBAt3jShYuxT87NweiQTDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=i1fAXbz6; arc=fail smtp.client-ip=52.101.66.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XpDPnnr8O+YRHPHaz5AR0lU8MlP4sVxQCYUGURFKuu6zhgfUvt2SfTc/SXkz45uKNYGz7cyKrgq8U1X0ROFW2205LjlQ1DERrkSzw1fpA417MtXfpqYCEVcY8HRoWJWUaTpC9Hnw7wQ5bD8ZTCQPOCNpwQyagaKltZ+6tJVJIKsvW5Hdb4HrFTSHNKhHvSV9oCkbelckRw8WOGlfvMizEljbkKBfu1sjGfRN856Y9meizybkTqebZRO2z4g+kn5XZdowlajV/JQMVZgA1/F13h5npsc1DmDSxI5caILxTmlai75rT3UMsPhgp7PxFp41S3yQKdBFMsou4MR7LpM3cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8S8i0ECnBIYhGS2TmZkLx7RP76/JdosRKtyZzHX+zTo=;
 b=V+59Yz6wCeeAiTFVUQm765/ycc2A+Dfu+d5UUq6zfXrxpRXRtc/z8/ivAdO/8okbgwCv4TNez2dYZQmmoFnG2UTCveAguJNdflngxy44HeUuvqRP1YXweBs4kj26ztwYC/cfkz8KrAgE7fFFj+XrvmbaIsuCJ1RuC3vE+gOvkgFva8BdgyV+fi8DeG0ad9V14rmYZWggO4ZGXPE+sRED11H5/CkcQYBcy3qU4XelcJzWHhGgHh6IlJeIk0yVIuoZ0m2ls7Ck3xJlRryfHbw6fR4crod6w44zgPCjaanl9ivIlBDP+bG0wSdg54FOCFV94P3wzstU96kz3atoqXjSFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8S8i0ECnBIYhGS2TmZkLx7RP76/JdosRKtyZzHX+zTo=;
 b=i1fAXbz65Qn1aNzQrO4DkW5Td4hwadSLERhL7VGnTQ5UAPhnyTkwa6PO/NGxpJo7pigy/svwJFwz4ApeITGU9UpDiBYvU6d4cE6nwO8xEjylpYOAqSOTxQbRGukbBnP3gv/afcIkJvuT+U1/z3CwJqXoxMSaxnyW9UrlmB2RWumMhyuLizCZSUUx/sdPAMNaTaOjiqtbSZB19mYdbkdPwkG+F+q9g6MZZThTuLk5xh+ccFmsOEbT4BYaR7CtBm4oLNNbk4dTTBxy0Qjaswza08rJ+FHmv8R8m1/cJ0MHp5Qh67Bzu+/dfdBmij16TyEe63PcMilX3zigB0cyZK+6HQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 (2603:10a6:800:293::14) by GVXPR04MB9735.eurprd04.prod.outlook.com
 (2603:10a6:150:118::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.18; Tue, 25 Nov
 2025 10:07:17 +0000
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687]) by VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687%6]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 10:07:17 +0000
From: Carlos Song <carlos.song@nxp.com>
To: broonie@kernel.org,
	frank.li@nxp.com,
	hawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Carlos Song <carlos.song@nxp.com>
Subject: [PATCH 2/6] spi: imx: introduce helper to clear DMA mode logic
Date: Tue, 25 Nov 2025 18:06:14 +0800
Message-Id: <20251125100618.2159770-3-carlos.song@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251125100618.2159770-1-carlos.song@nxp.com>
References: <20251125100618.2159770-1-carlos.song@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0063.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:656::14) To VI2PR04MB11147.eurprd04.prod.outlook.com
 (2603:10a6:800:293::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11147:EE_|GVXPR04MB9735:EE_
X-MS-Office365-Filtering-Correlation-Id: 3105b74a-9b23-4fc9-9121-08de2c0a69fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5epM7Y61uHgvhIe9PzR0quXU/rtUHiCoyp+xnSQuQM/dLSwI7BsqemO63diy?=
 =?us-ascii?Q?BVhhRolqx7Zlk+3FVIgzlc+8SoceP1dNf8KaCVpa/Sx0gkyaqddvJhfjtXlG?=
 =?us-ascii?Q?FPnB2Fo6rZryiJjS0FgFh9OcPrrzdsvMyh/Jq3YKVEGQcwm35OUr7R6KJqw5?=
 =?us-ascii?Q?nKQoosz39HNs0IDFZbVW9aQxrKz9djs/UJ02VxJiTIwVVXzEulPn/Yx3Ls2P?=
 =?us-ascii?Q?ejeVLqSnm0dPpLYgM1Dv4XJ5MGmqRX6k0NKkxysSfIODefSEhJdiQC0F6zJn?=
 =?us-ascii?Q?TzVRIJUdwlHcy6HDklB5qpKKSrBkWh1Ymh72cQlSgdiii0BTKBEMF4XwSPFx?=
 =?us-ascii?Q?wqJ03fTuYJieLA8ViOpLPA7ntnUAGq0p4qXmgL8y0uI7OMzhqATj/3pAv4k6?=
 =?us-ascii?Q?INIo9uQG5Pl2cT5D3isEunLqSvzzTBQX/deuixMZSQ3rooVONg9TXGctjoSM?=
 =?us-ascii?Q?XFQYFIcFHktjtZZZ0kGJn8Oo3T1UpjsXGtsagIRcj1OhUVzFc6/eIiSS03Vf?=
 =?us-ascii?Q?moigORiswgjOKu78fK1/F3pA/dRG18DiTe441/GHVDWEcveHIVvDjszs3gny?=
 =?us-ascii?Q?w0LP7io9vvsScl7/gpOOoWfKBpHxGzplghxwPEwBn8Rky57NiVvpQr+dALi8?=
 =?us-ascii?Q?7uXHBO8X+EcABgLB5eawhMSIwzni7c/rCKnj3P0BBMixGYR/hMhr8BiuJaPD?=
 =?us-ascii?Q?QkNOoaN3Jzc62d84OqwoQ35PUbipdPP/uCkOCaW99efsZhf9lI33jHlHL74H?=
 =?us-ascii?Q?tdushGtF0FqjYbAJqcKhNkLVw4Di0WzbQlQlxGR6NgKucvVHZQoTOZD7RoPv?=
 =?us-ascii?Q?4DnKCiVFnGysHaisH/5FTETn6qppJfmkG3fBaUhFmJ2SuDUDxctmxiZQHt+1?=
 =?us-ascii?Q?4BRoZXBOT5QUz6eoY0686Ga21vATT83Xul9DxS1TJSqd1VpClFmwBPqLRk6/?=
 =?us-ascii?Q?egn1Xm6bwfxo2DPKda1pOlAjjQ+DwoZLyAx88o72yjyV5bRONsFuaN5CuqPb?=
 =?us-ascii?Q?eODbW3lIDnBD+6V5HwlAA9PD6ZMvYMUCvSAqSqPwAoPLBaGyf4D7k0FskvOq?=
 =?us-ascii?Q?AxFv0p44cBZuN+dEcf+cNOrOiuqz8kZkSKTnMpOQsvW4R7olSrYHhgqamWPz?=
 =?us-ascii?Q?zpwj4Lh+w6HpvtLZ3vMrJ1UE6Ipa55nzm5EGLquA1OjAhLhrC10r8E7vpnHZ?=
 =?us-ascii?Q?ny1XCA/dlNL3uPi1End/e7ptvnuAHfeNJLxsoF7iIksMeb20GlpSU0FIIH4l?=
 =?us-ascii?Q?vBpjjkP9S6nkJ9nHvLjZhLuDSmDq+nBdZCig1SY6KoUmGM4pG1tiU9bBOqbo?=
 =?us-ascii?Q?4jkGvK7gjyD8w198g/Or9XcSjo0awjaPg6xmtP0Y5IQcODepIqTBz0eM9/bk?=
 =?us-ascii?Q?nbpwCQF4Ih0OUPY6PF3weVe3C8lqLYxKXuNT69DXkw3X//WdjT57L8KbRZUa?=
 =?us-ascii?Q?b82GuCqc45U8vMQDpJ8DylzCJxkSx/GZ8abmo4wsC6uz71vacP2tLMedY9F3?=
 =?us-ascii?Q?ohe24mnCD3uTvIV5aXpuSTxrGrDcmdFHKbPf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11147.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Zb08JKEg3HqeJ2g9MxBiZSJ7pyYYvNMZQJp0cw6Doz0R9dqkzPOTP+v7oYFN?=
 =?us-ascii?Q?ddY+8b+2AeIZZv4V0tq/SL0aWfd9caLcZUvVMUoWIGH1r0UQSgrghGOtcFfK?=
 =?us-ascii?Q?ORGOlKKY/BUHvQszvH7/JqgJeaRkCEiXW1kmUyHiQidT4eC22di2HpY6yFEt?=
 =?us-ascii?Q?yka5hAKbFttYg8YNSmeX7rfQ1hnB9oN45+K8Fx2gcmA/9xP/0HZXkSQwlLJ4?=
 =?us-ascii?Q?F/RdStcTxci72xZh0VT6yRc06SwErBTgVzFVvPJPyx2Q+tJJYmrWCUJc4wa6?=
 =?us-ascii?Q?HVQ9+2H0Q4GGHW+1Q9W0wDjTCOXOl7b2alO75A9ZSe1bmhUrCQsPfx35zRde?=
 =?us-ascii?Q?K24aMTd9qyks37ocITfMPtnvhEvZ97Fn4fpgJwEH9XjbXZGqar7zerYtBaYA?=
 =?us-ascii?Q?4LC1mL3xUqodylbraMiAA0B36LVdtIXd1Nk3ei5LrREDM/MS9II9Uxc/4ZR+?=
 =?us-ascii?Q?WGB7CKUFMtO0boeADGlmyZDAwIjqIN2o4+NjPHAoDZoSQhYXQcBUmJJCYvek?=
 =?us-ascii?Q?4Suhc/f6bJR1GLzKD1Y0QX4lJMlXT1QURmZf4NTknOnw4eMxzWhQYJ/fXUH7?=
 =?us-ascii?Q?lp9hkZ4cr3agRhXUSbFQs8egiuGayc2b/dYnyEMadVCw2MTpK3l/zNh6ZHAW?=
 =?us-ascii?Q?SGeivezTuPR9yDkguEdWV5qKAo45cyaZtTLMdR3RfkceT7X5ugXcn5GtmOgF?=
 =?us-ascii?Q?E/DUbPzSGmtuvD1ctKqmlJqAwAz2VFU9J61h00yEJhG4NAbVt40h7CRFcJC3?=
 =?us-ascii?Q?6EcKxpxpQGLPXvGVhJ/EbT00NWnYVplriUTFG4wKDOgcrkAxXdah+rLqwtA7?=
 =?us-ascii?Q?j//cMrNg7bHl/57ZOVe8QKu1oQ/tDMrm0ENJz2cYWT+osX9vCDbVe0X2FVKR?=
 =?us-ascii?Q?IHz846F8FhyfZ5EW0BoDSP/uYOYGycR550nqUlnKp6tI9e/UU/wGQbMX93X/?=
 =?us-ascii?Q?qEnNU4N+ccnCeCoMdpfA9a+OaS9Xpwr9Gct/L0nof14ixdh1Qv1qYmJ7ahuO?=
 =?us-ascii?Q?AgfApqhoIjZ9wDZcn3eHSeP+m8YTuGIoM/FVGOu/y0FXuAwcYma0vdtaUx5O?=
 =?us-ascii?Q?mI9DNVOgNWCnjR2uV6DPVrBVutkFak+FYMPXZaUVKxwzHrSfMTqvpXw92Pfy?=
 =?us-ascii?Q?0CPNNnOVnt+s35vuS01SGih97gsyfGJZjTB5Y1I40L6PMZF/rUG48vrm/TVO?=
 =?us-ascii?Q?dQJUA8yD02LKZilOFG626XNznLPsjuT3E+/478/ttID/HFSa8JJeL+Ph8VIS?=
 =?us-ascii?Q?WeDgs4HOmXohIx98VKgMdeyIDn0LkOnZO5SjHL7Rq3Pwy2+yEe8A+Cu9cVBu?=
 =?us-ascii?Q?e5oeDyu7jVeCu3ryjuyrN7SumZJqH8gWGQ8PqI2u1ql7KdsBt5TyjyfcTmwG?=
 =?us-ascii?Q?oy5QXyKaMkaF0G5jKMRa3HhguVgtCIGqnYOaJaG3/P4sxb1UebiEP/r81cRF?=
 =?us-ascii?Q?mN7ayxpjUrT8n5iUenG2yw6fHmCgkDCbAeY16OqJei17R66nOCpBfg4zc0Xc?=
 =?us-ascii?Q?HmsmJDHTO0qOty2l99LDohdkYhRuXw1ZYNrZogHJDRwoKIKW1TDp8J5n0pZu?=
 =?us-ascii?Q?2pbduDBYywEq//eQhLUukHCl0zfnwi+94oqNNhW4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3105b74a-9b23-4fc9-9121-08de2c0a69fa
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11147.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 10:07:17.7590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ouufkAQ085z2T3wVAVosArxvBUM3mk1dsMAVi2f1C388z0rZ5s00Gd6n2Gi3gVYo4HR9vfHWqSPJGRTx2VYDBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9735

Add a helper function to handle clearing DMA mode, including getting the
maximum watermark length and submitting the DMA request. This refactoring
makes the code more concise and improves readability.
No functional changes.

Signed-off-by: Carlos Song <carlos.song@nxp.com>
---
 drivers/spi/spi-imx.c | 164 +++++++++++++++++++++++-------------------
 1 file changed, 92 insertions(+), 72 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index e78e02a84b50..012f5bcbf73f 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1437,6 +1437,94 @@ static int spi_imx_calculate_timeout(struct spi_imx_data *spi_imx, int size)
 	return secs_to_jiffies(2 * timeout);
 }
 
+static int spi_imx_dma_submit(struct spi_imx_data *spi_imx,
+			      struct spi_transfer *transfer)
+{
+	struct sg_table *tx = &transfer->tx_sg, *rx = &transfer->rx_sg;
+	struct spi_controller *controller = spi_imx->controller;
+	struct dma_async_tx_descriptor *desc_tx, *desc_rx;
+	unsigned long transfer_timeout;
+	unsigned long time_left;
+
+	/*
+	 * The TX DMA setup starts the transfer, so make sure RX is configured
+	 * before TX.
+	 */
+	desc_rx = dmaengine_prep_slave_sg(controller->dma_rx,
+					  rx->sgl, rx->nents, DMA_DEV_TO_MEM,
+					  DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	if (!desc_rx) {
+		transfer->error |= SPI_TRANS_FAIL_NO_START;
+		return -EINVAL;
+	}
+
+	desc_rx->callback = spi_imx_dma_rx_callback;
+	desc_rx->callback_param = (void *)spi_imx;
+	dmaengine_submit(desc_rx);
+	reinit_completion(&spi_imx->dma_rx_completion);
+	dma_async_issue_pending(controller->dma_rx);
+
+	desc_tx = dmaengine_prep_slave_sg(controller->dma_tx,
+					  tx->sgl, tx->nents, DMA_MEM_TO_DEV,
+					  DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	if (!desc_tx) {
+		dmaengine_terminate_all(controller->dma_tx);
+		dmaengine_terminate_all(controller->dma_rx);
+		return -EINVAL;
+	}
+
+	desc_tx->callback = spi_imx_dma_tx_callback;
+	desc_tx->callback_param = (void *)spi_imx;
+	dmaengine_submit(desc_tx);
+	reinit_completion(&spi_imx->dma_tx_completion);
+	dma_async_issue_pending(controller->dma_tx);
+
+	spi_imx->devtype_data->trigger(spi_imx);
+
+	transfer_timeout = spi_imx_calculate_timeout(spi_imx, transfer->len);
+
+	/* Wait SDMA to finish the data transfer.*/
+	time_left = wait_for_completion_timeout(&spi_imx->dma_tx_completion,
+						transfer_timeout);
+	if (!time_left) {
+		dev_err(spi_imx->dev, "I/O Error in DMA TX\n");
+		dmaengine_terminate_all(controller->dma_tx);
+		dmaengine_terminate_all(controller->dma_rx);
+		return -ETIMEDOUT;
+	}
+
+	time_left = wait_for_completion_timeout(&spi_imx->dma_rx_completion,
+						transfer_timeout);
+	if (!time_left) {
+		dev_err(&controller->dev, "I/O Error in DMA RX\n");
+		spi_imx->devtype_data->reset(spi_imx);
+		dmaengine_terminate_all(controller->dma_rx);
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+static void spi_imx_dma_max_wml_find(struct spi_imx_data *spi_imx,
+				     struct spi_transfer *transfer)
+{
+	struct sg_table *rx = &transfer->rx_sg;
+	struct scatterlist *last_sg = sg_last(rx->sgl, rx->nents);
+	unsigned int bytes_per_word, i;
+
+	/* Get the right burst length from the last sg to ensure no tail data */
+	bytes_per_word = spi_imx_bytes_per_word(transfer->bits_per_word);
+	for (i = spi_imx->devtype_data->fifo_size / 2; i > 0; i--) {
+		if (!(sg_dma_len(last_sg) % (i * bytes_per_word)))
+			break;
+	}
+	/* Use 1 as wml in case no available burst length got */
+	if (i == 0)
+		i = 1;
+
+	spi_imx->wml = i;
+}
+
 static int spi_imx_dma_configure(struct spi_controller *controller)
 {
 	int ret;
@@ -1484,26 +1572,10 @@ static int spi_imx_dma_configure(struct spi_controller *controller)
 static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
 				struct spi_transfer *transfer)
 {
-	struct dma_async_tx_descriptor *desc_tx, *desc_rx;
-	unsigned long transfer_timeout;
-	unsigned long time_left;
 	struct spi_controller *controller = spi_imx->controller;
-	struct sg_table *tx = &transfer->tx_sg, *rx = &transfer->rx_sg;
-	struct scatterlist *last_sg = sg_last(rx->sgl, rx->nents);
-	unsigned int bytes_per_word, i;
 	int ret;
 
-	/* Get the right burst length from the last sg to ensure no tail data */
-	bytes_per_word = spi_imx_bytes_per_word(transfer->bits_per_word);
-	for (i = spi_imx->devtype_data->fifo_size / 2; i > 0; i--) {
-		if (!(sg_dma_len(last_sg) % (i * bytes_per_word)))
-			break;
-	}
-	/* Use 1 as wml in case no available burst length got */
-	if (i == 0)
-		i = 1;
-
-	spi_imx->wml =  i;
+	spi_imx_dma_max_wml_find(spi_imx, transfer);
 
 	ret = spi_imx_dma_configure(controller);
 	if (ret)
@@ -1516,61 +1588,9 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
 	}
 	spi_imx->devtype_data->setup_wml(spi_imx);
 
-	/*
-	 * The TX DMA setup starts the transfer, so make sure RX is configured
-	 * before TX.
-	 */
-	desc_rx = dmaengine_prep_slave_sg(controller->dma_rx,
-				rx->sgl, rx->nents, DMA_DEV_TO_MEM,
-				DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
-	if (!desc_rx) {
-		ret = -EINVAL;
-		goto dma_failure_no_start;
-	}
-
-	desc_rx->callback = spi_imx_dma_rx_callback;
-	desc_rx->callback_param = (void *)spi_imx;
-	dmaengine_submit(desc_rx);
-	reinit_completion(&spi_imx->dma_rx_completion);
-	dma_async_issue_pending(controller->dma_rx);
-
-	desc_tx = dmaengine_prep_slave_sg(controller->dma_tx,
-				tx->sgl, tx->nents, DMA_MEM_TO_DEV,
-				DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
-	if (!desc_tx) {
-		dmaengine_terminate_all(controller->dma_tx);
-		dmaengine_terminate_all(controller->dma_rx);
-		return -EINVAL;
-	}
-
-	desc_tx->callback = spi_imx_dma_tx_callback;
-	desc_tx->callback_param = (void *)spi_imx;
-	dmaengine_submit(desc_tx);
-	reinit_completion(&spi_imx->dma_tx_completion);
-	dma_async_issue_pending(controller->dma_tx);
-
-	spi_imx->devtype_data->trigger(spi_imx);
-
-	transfer_timeout = spi_imx_calculate_timeout(spi_imx, transfer->len);
-
-	/* Wait SDMA to finish the data transfer.*/
-	time_left = wait_for_completion_timeout(&spi_imx->dma_tx_completion,
-						transfer_timeout);
-	if (!time_left) {
-		dev_err(spi_imx->dev, "I/O Error in DMA TX\n");
-		dmaengine_terminate_all(controller->dma_tx);
-		dmaengine_terminate_all(controller->dma_rx);
-		return -ETIMEDOUT;
-	}
-
-	time_left = wait_for_completion_timeout(&spi_imx->dma_rx_completion,
-						transfer_timeout);
-	if (!time_left) {
-		dev_err(&controller->dev, "I/O Error in DMA RX\n");
-		spi_imx->devtype_data->reset(spi_imx);
-		dmaengine_terminate_all(controller->dma_rx);
-		return -ETIMEDOUT;
-	}
+	ret = spi_imx_dma_submit(spi_imx, transfer);
+	if (ret)
+		return ret;
 
 	return 0;
 /* fallback to pio */
-- 
2.34.1


