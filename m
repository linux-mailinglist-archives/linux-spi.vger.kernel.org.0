Return-Path: <linux-spi+bounces-11710-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C24C9A974
	for <lists+linux-spi@lfdr.de>; Tue, 02 Dec 2025 08:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 467C83A7D41
	for <lists+linux-spi@lfdr.de>; Tue,  2 Dec 2025 07:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984A83054EB;
	Tue,  2 Dec 2025 07:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nh7uEM9E"
X-Original-To: linux-spi@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011044.outbound.protection.outlook.com [40.107.130.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65B23054C2;
	Tue,  2 Dec 2025 07:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764662172; cv=fail; b=j+K03fbarE/G7BDGpQh2JARAoZU56BHTbb1lTV7TgGOF61UbLE+EnDpt9OB4ahyg38c/Cb9SkdnFZea02dzBxhTeoSuaBdH+49E8BUwDlsedH3PX0MYjIK/zk2C83BNHZyVvMJrdrO8IwPh1Y4NFen5+auYp2CFLyKW3VGP0vAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764662172; c=relaxed/simple;
	bh=H25pw5D5zL6skjChnyxfweuc79CQ/ylSxbjW+YJVPF4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=stHQAf0+cnLg0fA8kCf11MRcv8qoCCxvsVKI26M86ZAt2Mn7oPxxCMePIZqaqIj7TLoru+dyiTlCtgMf31VhZPnkySHttLT6gAlz8Y2CUpJ8VJAQrDJiFWQTbrtWaGU1hmAE28mVkeXAfJRtvUajxE4R7NTpE/DO6ZIF6o3weSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nh7uEM9E; arc=fail smtp.client-ip=40.107.130.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AcykNRM1u88ERGifNwy5a53SigRcqYcDuZXqMnJuzy5mCnAco4fUvid3VHE1mHE0ROowQEFXsFfAokE16yAk80KwH8fRmIexMiMuVW9RpFrLW62FY1HmbOYWhkLioTreKyQga8aUtOL8mk+8854383L0SfmEQv/cTKvcPKAC0AVbu//Vs4QVSqNfFLYupsdQYZ+zmlFGV4p3GSiWOTFN3cnv3Df4GSHN8ugIXV4u7JX66cjoxyOv3alEhzKEVMpd7YmK7VXqUoBdVQj1m9uxnlWQpPE6YD8FcOmgfMR+SuSRNONrMGGOw0AkqapKUsP5sdDUQ3FIFYKGFQx9NaSlRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9sPjGfJ4KUeawhjCFNtgrNytcqNmzSFeWPen5MoTn6Y=;
 b=khJuFKgCObFfmM3Und63yI45MfmDJyE87WSbVzq3Jyjihfoz69TqOFgESKM35IJSF2vNt+sZ0IQyD4Z/doNlTjog/NGptu87So12MabLaUB6FymOGvGPWS8XFpLph2ktMnq1rs/IWJIf4RZFKAMBTF96ak3bzg2GwubXch7+eVHVCZLAmfSSqRCbDJAD3etgCQ7vmlk08Qa/4jlIfXG/vYZej8opWUi7wvK4MeAqjS2YK8aUdXLO/ocClbVX5rnFqoo9eJK21pzKX9weYLjKKEGPtu1iI4EeR+HFTOuA9cOECJYMVkoGeYc+xT/BDlluS3cbLMp5Ts6ziXfYR1OGEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9sPjGfJ4KUeawhjCFNtgrNytcqNmzSFeWPen5MoTn6Y=;
 b=nh7uEM9Esw8qmJLOIAMCJOGvjl7NDJxYEwZnnVN88qFcjVQ7nFzi2mHfaqM6qaeV74t3vfYaD7XlLNzBNk+044OqZLSATLacGaPktimkOoIp3RcM9DJdBi9BQ4A0s9P7IWTsnd0GaEsrQxp/KEX1xeDH/BWRuOfp/txTrCqI29qUt18gmOU10lvFkJ8Ty59JfdT7bZJHlPz7Nj3fDKB0NGk3Cu+jDyfiiOCBWhHA8W37QUOAEGQ8CqusofP7JKPRdu+UGp4mhZ2vGoN20H0orL4YEE8/1uUMlKAVvEXihWRR+PCQrT8uVC1U8qq//7+73zcbIoGWkMCx72sd7Qrxnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 (2603:10a6:800:293::14) by VI2PR04MB11171.eurprd04.prod.outlook.com
 (2603:10a6:800:29a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 07:56:03 +0000
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687]) by VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687%6]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 07:56:03 +0000
From: Carlos Song <carlos.song@nxp.com>
To: frank.li@nxp.com,
	mkl@pengutronix.de,
	broonie@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	kees@kernel.org,
	gustavoars@kernel.org
Cc: linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	Carlos Song <carlos.song@nxp.com>,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v2 4/6] spi: imx: handle DMA submission errors with dma_submit_error()
Date: Tue,  2 Dec 2025 15:55:01 +0800
Message-Id: <20251202075503.2448339-5-carlos.song@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251202075503.2448339-1-carlos.song@nxp.com>
References: <20251202075503.2448339-1-carlos.song@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0052.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::21) To VI2PR04MB11147.eurprd04.prod.outlook.com
 (2603:10a6:800:293::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11147:EE_|VI2PR04MB11171:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d862eb7-2eb8-4de9-9326-08de31783d6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|7416014|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9f7tv1k3h9dP159jJSbcVIqbX8gvlvf3QVt52Yhq/9a7b4zsyauwL7eiz/G0?=
 =?us-ascii?Q?p9Asx8oTlFHFaS7VgcqzZjYq4xYrZzKKJoMBCAoxImBNI0DeiBToMHWa7nQe?=
 =?us-ascii?Q?kVz5UmZRDyjtNgUeOPq345xyG8TaUv34Lv9DIxlmLfxG5tSy1cIpfOk82PZR?=
 =?us-ascii?Q?X+oUj+Bf/Y2AFtXPAu3sj8bfYWLGwO9/hPLuPr4T1dybnRFvuP132iopIyrb?=
 =?us-ascii?Q?MwJb+AqHeQo9WoCOYJfKDiP6hz8654cLsGuyrTL4Jn4axAvS6JFUw/QYlkWa?=
 =?us-ascii?Q?q978EQqRvVE1oLlnJvd9LXK7mQjXQMzhX7jF2SyyPjHEWoeoD6x0EUs7Kbt1?=
 =?us-ascii?Q?0v/WzAJHruanqjEYiYrjCuDCSXE1fvQL2LazYLo5XZ/ghMlFsu2AgazCXDh3?=
 =?us-ascii?Q?Au4dGz8+A9cRx7jHlC780EXhcZBshRtA8SU6gj+7ZnAaPYGqQT8IyKHvMIKr?=
 =?us-ascii?Q?sLKpeHAGbCmK7zR9FA+rilHyv3DaaW95aBYNqKAtlsqkbdbJksG0/HbLzEmW?=
 =?us-ascii?Q?TEoGfsoS0UQFCcjH1zvj23p3vvYVt9zrLNaztxX76n6s8twHkKdbINW4Qvgl?=
 =?us-ascii?Q?52AYSkOVvZR4uVRgEevumTMnK6u/XNPjCAzSawVfeepmtc3OSvup64z0b9yF?=
 =?us-ascii?Q?FmmdBblgXAM7U+1PRkzTjd53DvtvB6h8g/1O65RLWBcA9ZJQmJQuJijIXMr7?=
 =?us-ascii?Q?KRkYD+Wv/AMJmz96kXwyK8W1hTHHoq3bOKYEweq+ZyZuUC1sw5V3pZ5Al3oO?=
 =?us-ascii?Q?AzXzYQTB9r9FB7bHvp8ng5trwmAzpu7ztxK8TIAXDdHzoin/RkyOuYZZHsfX?=
 =?us-ascii?Q?8fa9pwRTCgUBJf9ALCXpHw0/u+hvuSZCoHDWD8xEDIWEjvBrum9ItcwfPlGC?=
 =?us-ascii?Q?GfnAKXmL5qqCjCJHsJLQRdFNOyJOox1TBAcAtkxsIyTYN0eOVkFo2lGXnpqY?=
 =?us-ascii?Q?KBB04P+JS+KpY8iMZb8Z85LwNDTKhWG/xKq/PcQDXofm9Hwm0nGJAOWgkMpv?=
 =?us-ascii?Q?Yptf/sqg8JxDY9ngC3K6ZlY6iuZzOmrstZc/I99/Hf7wrlLwsF4ZbZTbIZsr?=
 =?us-ascii?Q?Fj6T8HfLU89PDIMPIGgf3ZZX4hp5YxihIdltqshWj5QbJtwxrj9KDczN1xPZ?=
 =?us-ascii?Q?Q2LfftF0xGFKg246FlLc+zZ/i/scBvkX34vNmMYOW7S4OVO7Tp4HZKPJWqV7?=
 =?us-ascii?Q?fvqbc9VvmFF5iwNvQqj/XjmcNr9uJQZAaUp4yn7fpBHJCIt3wIyNjH+G/Sns?=
 =?us-ascii?Q?XLMtNjC3hmkRF58TGCSThZ4N7q3naXCMkbEPdnHFXpIMwpsZfY1kVDD1pGWL?=
 =?us-ascii?Q?74aL9cdepfup+mR1YdNx5HVQqCDD/6AZEjigDmZ13QzIP1C5JpoHS6RW1Cp1?=
 =?us-ascii?Q?z+HAuyTcR3gn+4vpvydsrpfE4vH5YUt/glouvr5VgjVGrr/IVYGCvaoTt1sx?=
 =?us-ascii?Q?gdEPk7jwPV/SbQectolvWcs+K+4gwoN0G1ADzUQOCuhw/gwXL4Cy+KranSFt?=
 =?us-ascii?Q?lRCGl+fwq1ZAqpZ+tb14EHrBuxxw9lljqOnF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11147.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(7416014)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0HqVSVjPsyRjK9i+P2NkF++yjoV8RlCu4DB7oKgJSJQABs0QLJlN6l+/raNu?=
 =?us-ascii?Q?/eTrk0jdRzNE7Cnuq6H/JXHsgTyFoHoydcVlE8E5WHTNn9DQdq5aUylzf3FF?=
 =?us-ascii?Q?yoOJVULJaLuQtoidm3ok9XM00CyuYqzGs2uT1gNQzKnuQqt3XlcS2Xbrg3IZ?=
 =?us-ascii?Q?qzQv7gomD38zSvDPFUgshhe5fjf0I6uhaEdF13ozsFwVeuuWTq6Xri/gcGBE?=
 =?us-ascii?Q?FO0QXYhr3Y/Hr7ebd4ZgHl05Vop791tP16SVoUHraLvanNRSB2MWwBKtcTel?=
 =?us-ascii?Q?rNyYNNejpruRAlgRMvseJr19VOd1VrjkKRNrtTXXxk7ucLzmXrkOACB6Za7J?=
 =?us-ascii?Q?WAsBpzlO5OzmVlxI7H+otzLgpfnkPZmGkzccwp7UGfJiHvFHQLNJUf05GaeI?=
 =?us-ascii?Q?M4XOzIsltC0oHWPYLIYfjAf003jySKbi0P53WnhGAtjmbKMEviv6x6yAyzmL?=
 =?us-ascii?Q?5UO3b5JDpCpaPrzsaLg5W0zNukbxH5/4yDJrJYj5Q06vXtn1aihSwR6gS1rj?=
 =?us-ascii?Q?/BmS5Kf6eJeDfqLibqo+26xNopL6pR0S6b0l57mDPVcK7JNqu+AVBAOwN1JP?=
 =?us-ascii?Q?zm/RTuQ7nZ3/3ZkYRS1e1FM4mkCnt92vL0wusxIv6uLa96TQX0v25z+HQhi2?=
 =?us-ascii?Q?pKxyYoc/AVJi9lykvu1heByFB3VFTUq3IgdBwosDiQbL9y2qO3cVNHmjFlOD?=
 =?us-ascii?Q?jMowZ2KcNHOV+OFcFhNqwlF+SGMvKPsRV1g+mpJsQUDPaoosdomx5EiQ2Dqm?=
 =?us-ascii?Q?FrHyZu6vB7IK7Y4ohLlGPCVePUhsOyjRtuX0kYmdkpw7VWlS3Sw5bZbq6Cud?=
 =?us-ascii?Q?aKDN3Al5L9NT/VO/nX0DbYS3JpYiCoP10ycVLl1Q5/FB/kgq+8HLuTL8Z7Pl?=
 =?us-ascii?Q?KxYbGOeTDCZWGgDTKsgbJic+1mtIt0gEmNrbBs5SeDQ11q7VG94otjWBzFbe?=
 =?us-ascii?Q?FI7IZ8hoxG0Vb/1rS+6m0Drsacpa8u/dBUtxe1AFzEqj9kuF8OeAuQMkGJ4O?=
 =?us-ascii?Q?epDQY1VniuLvV7fSl/UPFObCimf9kloHzFe747FKKVgEZc8Js/Xhvl+Hbvi9?=
 =?us-ascii?Q?Om/2S1chb1eQJe8Zi6INeZYb8PQRNDejonTO1AE+wPqHK/JZ2W4eaB3YRExf?=
 =?us-ascii?Q?lbGmB4rzpRd+cXnY2+IfLcbFdfep0SqRBlln3G0gAeznmQc4IIaergB6YqW0?=
 =?us-ascii?Q?TFmOQ2aoB4K0RN0BXuWuZuytP7fITqtMQgd0NOwx3GQTMUBsILg8oclbvPUn?=
 =?us-ascii?Q?DTI9xCSj9SlRDfYKI7JPLQ6vvZ3tbPxel8/KCu1kz3LfntF7HVN5rom9F/41?=
 =?us-ascii?Q?VtRbMRVnCjWQ0gm8Ek1sYbTjZBmWNcfB3qRpR8OSq07TWMEOzunKl37ZzsP8?=
 =?us-ascii?Q?VL0d88nJxCNgGlrfPuLEJN3wax43pGnrdPKUQx+nQ9jRfgbXSKsmI6zLKbOo?=
 =?us-ascii?Q?aKqoW/ANwn+Hk6refJASnHPewZXb/lQwDSxH9w2kZqPTjZXA6cyBMluGB1I6?=
 =?us-ascii?Q?1e7Uh7LGebC7+HIA9lHug7Zq9YjBgj8e0tV4BZ6Duj7Hm/I63jgzLfxj5wOv?=
 =?us-ascii?Q?Ggcvsgc9cqRm8BwfvjfymoUQO9EfndVO55wxs/o6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d862eb7-2eb8-4de9-9326-08de31783d6a
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11147.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 07:56:03.3267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XT8I7QMRTs5f3TzY5bOaPqpYvZ/fr1Wb0A80TnkK9H1k0o+VC18g+lDnJi8qG5LAp3xSvQMKk9Np9llTlwsHHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11171

Add error handling for DMA request submission by checking the return
cookie with dma_submit_error(). This prevents propagating submission
failures through the DMA transfer process, which could lead to
unexpected behavior.

Signed-off-by: Carlos Song <carlos.song@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/spi/spi-imx.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 186963d3d2e0..42f64d9535c9 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1445,6 +1445,7 @@ static int spi_imx_dma_submit(struct spi_imx_data *spi_imx,
 	struct dma_async_tx_descriptor *desc_tx, *desc_rx;
 	unsigned long transfer_timeout;
 	unsigned long time_left;
+	dma_cookie_t cookie;
 
 	/*
 	 * The TX DMA setup starts the transfer, so make sure RX is configured
@@ -1460,21 +1461,29 @@ static int spi_imx_dma_submit(struct spi_imx_data *spi_imx,
 
 	desc_rx->callback = spi_imx_dma_rx_callback;
 	desc_rx->callback_param = (void *)spi_imx;
-	dmaengine_submit(desc_rx);
+	cookie = dmaengine_submit(desc_rx);
+	if (dma_submit_error(cookie)) {
+		dev_err(spi_imx->dev, "submitting DMA RX failed\n");
+		transfer->error |= SPI_TRANS_FAIL_NO_START;
+		goto dmaengine_terminate_rx;
+	}
+
 	reinit_completion(&spi_imx->dma_rx_completion);
 	dma_async_issue_pending(controller->dma_rx);
 
 	desc_tx = dmaengine_prep_slave_sg(controller->dma_tx,
 					  tx->sgl, tx->nents, DMA_MEM_TO_DEV,
 					  DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
-	if (!desc_tx) {
-		dmaengine_terminate_all(controller->dma_rx);
-		return -EINVAL;
-	}
+	if (!desc_tx)
+		goto dmaengine_terminate_rx;
 
 	desc_tx->callback = spi_imx_dma_tx_callback;
 	desc_tx->callback_param = (void *)spi_imx;
-	dmaengine_submit(desc_tx);
+	cookie = dmaengine_submit(desc_tx);
+	if (dma_submit_error(cookie)) {
+		dev_err(spi_imx->dev, "submitting DMA TX failed\n");
+		goto dmaengine_terminate_tx;
+	}
 	reinit_completion(&spi_imx->dma_tx_completion);
 	dma_async_issue_pending(controller->dma_tx);
 
@@ -1502,6 +1511,13 @@ static int spi_imx_dma_submit(struct spi_imx_data *spi_imx,
 	}
 
 	return 0;
+
+dmaengine_terminate_tx:
+	dmaengine_terminate_all(controller->dma_tx);
+dmaengine_terminate_rx:
+	dmaengine_terminate_all(controller->dma_rx);
+
+	return -EINVAL;
 }
 
 static void spi_imx_dma_max_wml_find(struct spi_imx_data *spi_imx,
-- 
2.34.1


