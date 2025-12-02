Return-Path: <linux-spi+bounces-11711-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 833D3C9A965
	for <lists+linux-spi@lfdr.de>; Tue, 02 Dec 2025 08:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2B90C347B87
	for <lists+linux-spi@lfdr.de>; Tue,  2 Dec 2025 07:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB3D304BC9;
	Tue,  2 Dec 2025 07:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="efXaUAZE"
X-Original-To: linux-spi@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011022.outbound.protection.outlook.com [40.107.130.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A77A3043C7;
	Tue,  2 Dec 2025 07:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764662177; cv=fail; b=CuZOMEIgSC3aMOSJssb6MtY9m2SysRPPYfA8KvhsynHaQoxLMM81QgFYZaQWJOlaKQw4K5H0wT+1S7F8wEAuScfpDw3E6hHTDbCvYVu4YD5+lbGjZDfbR85DDASvTifUU19hcaJ8jHs6jV3j59LN4HJXQE7yhgIPuzEp/I4Yf/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764662177; c=relaxed/simple;
	bh=26efR4r7+INRTYbFvb1eOsKW1iF7qtT0z3rx9VzhLeo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oViouxDhweOV2gVVWDoymoxbMWVcsYhXTtzerJvSeQe/Nyt0ucp0oGN01pvJo+srgGPhTral8eT91ApMtCXrYRONKF7cloiaVuCBMTebpeAfrgNNl/8IINYPtvSoWf2BIB64GnV8SATWlHa9wfStg2GlPfFojEGnSe1zYDDbJLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=efXaUAZE; arc=fail smtp.client-ip=40.107.130.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KyJeiVWaxr7q6ie7Tx2/vK7mjpKYogD2DKj3ApAYfeM4T0S0sAs8rZUZbSTHNrFzxcC3HnR7WoTISrmlMX8f5pOT3RGgOFvtYP66t5ziY6Y1SlhLemy+xRl+4MJyiRrLpuy6/afRwNbxKDNT7Kikul0cVdt3LR3epKkIIXuM82NBz/4Mn+I2isE+6fT5EyuUOfozssHK1caM29s3I7yddOanbiqgjznXlifKNi2S00VhOhpsnRPa2hsxeQdINJZLHjLOsGVmviq7FjFrcq1/OyN8EeZMbGtEcmK+ywQjS9s2r39DvIMUTbKqg1YrPuPP76xviKRbNE33WHYNS+MC5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vCf5DGLSVMOgyMPlycX7/E855RsBu7Nslul2Wob88dU=;
 b=OqYFH3KQCmRzMefm2Sarr+AJa2xyUW7zr3mae34BU7xHebafefWe01C6teUjylxW6S/BPyit9+Mk7g3LGQAc1RLtRG+1ApUzcefabJOhYRDuVZdWx++A+I0JtsVzst8TS8T0wSDSKctsuTVynRcCdzMoReRAdPiHYsFXkVC1hsAPFXI/ClByOT5lQ8ig0gPkQRkiOHzV1EM17TcVqXSNcRTz9haXs0/3DnnTazX+fjEpmDZA7tjkyHri4LKbNV+qB6O2DZslcpbvpLQvPrwU6O2gW2HpkiW7KWJgMzJ/wA1/87B0dGTPo+je6B4ASh2DSw7Wiwadz94AyOPYYyJRtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vCf5DGLSVMOgyMPlycX7/E855RsBu7Nslul2Wob88dU=;
 b=efXaUAZEkO26IUbrwkNLy6uPNORChz22xRqd6A3MgzYmlE86vcCDCU9gGpiPQzJuRgLCRhctzs+QBYJFs29zdA+vaNBUTa2sPMtSK8GVKOj+K9q7HAETrxgz9NT/Wfmc5MnBrlU7vnFgw0UWv1cVVcM174ISGBTG0oKKD9DEOkQRogGD7mAPp4GHIyJKQaDghnPKVz6lpa7j3PMzUm0xgw3MTYn2ZI5fmacr0W4RqRgAitGSdBTm3GVCfSz6NTPnXdYxx39nNe4A0qffVUMtpPUP7pT1mBvQjSWfelLZoXEY0Gt/RAKXb05SHb64xjSvzslyB1VKy4Di+z0VBDRGog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 (2603:10a6:800:293::14) by VI2PR04MB11171.eurprd04.prod.outlook.com
 (2603:10a6:800:29a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 07:56:11 +0000
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687]) by VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687%6]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 07:56:11 +0000
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
	Carlos Song <carlos.song@nxp.com>
Subject: [PATCH v2 5/6] spi: imx: support dynamic burst length for ECSPI DMA mode
Date: Tue,  2 Dec 2025 15:55:02 +0800
Message-Id: <20251202075503.2448339-6-carlos.song@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: b1e6cff4-e3e6-4431-42c7-08de317841e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|7416014|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?scicniEKvv00pkEt5Rjja0XrIHxmJh4FnMW6ddFSJB7ttB/DhoaLQ6Q8GxQ8?=
 =?us-ascii?Q?dsg0pd79qkffpzEVb2VdYctkCNkY1gDwrJC3eYd/4eTisn0rx6EjF5yzuDn5?=
 =?us-ascii?Q?/nC6OHEBd1kAomEabejPBfHBAcIUk9frdqc2xcTxSwAOPSNpPRAGRyFDmkUW?=
 =?us-ascii?Q?eg9VnApRx4VjEePQbAGUjRTVOV3ph4XkXaJOMsAHQBrSZDBnFYsTPiZRHHAX?=
 =?us-ascii?Q?wCRer+/CbhL6Wg0VRGX3wFW4bQQe5ac8Xbzi80ABvsqZpj9bzjGRP2ozLyrH?=
 =?us-ascii?Q?xND5Twe7elnzfCzYzzaxkMHWn149kTWzR0iVNeLwGXxYc9/0vcBJT3Msc8L0?=
 =?us-ascii?Q?CsveYHTaaDao+AmOn2fx6l8RaVnWXAZvp0ec/o42gJsTlUZXYJzLQI2jNM0Z?=
 =?us-ascii?Q?xI/YEY+eQKWwyyG4NLc9CKFAK2tclWcyPaxLJMF/iXEB7dd7mphymbJIzIeo?=
 =?us-ascii?Q?RWr76rMzmu2yLEJJ5Bl9om83gUu8MIgZ9eHVCBp6UAAGhbz6XZc8MBp2DzSm?=
 =?us-ascii?Q?V2o1ZCqceUamP9s8k8I2HhC+v1YFbfUIdbVtyBr3j/pSXctr+e00QUD9jjIe?=
 =?us-ascii?Q?gkha4p9cBAeH5JW+SQ7hqojHHYfjK2lNSLJ4gp3n39i92T75R9RVLbAUeoIG?=
 =?us-ascii?Q?Lv05sIDjECpJdEwBWj8TYTifjS93hIWiC1CXXS6ytrNjsdpu2cBRrKKh+GS/?=
 =?us-ascii?Q?mUXIjlcSpd5QFH7/PONyY/CKjP2hbX4B2qe/qaoIBCC4v76UV2MMAKVumzXt?=
 =?us-ascii?Q?ZJnqetP+pLS/WrP4yI5n3uqgaiIKfJijdBfGwkFZVBzp4QXN/1mpZIo8WlXf?=
 =?us-ascii?Q?EKPCxeXK9f5VFYB/lkpAIWKASbwBt2DQNLtvmX8hg2g5h+vCM6Hc4GCzotAn?=
 =?us-ascii?Q?BvnwyrfB1ZXxz97qrYi69HzZt7iiJopOQ2fyorxznWECefM+GbFd7s4kNG3E?=
 =?us-ascii?Q?WmJPUQlaKQFOth731wK53GO7oJP+Gw1uRY99fEbeL01FZoKN3+gsjv1VLPB2?=
 =?us-ascii?Q?QfZb/ZXWlkUOJMpEvbg4DJzXElEwpDe1yDo9bKsSDVbE/ccV8bXovJzy/iZK?=
 =?us-ascii?Q?l6/67ohVJ+Q8E/sZaijn2Wvx5LWhK+bC3i8iydcAwserSM0/Vn6TlBFWdH3r?=
 =?us-ascii?Q?4MRKA/aKppt2rCnWwFiGcrMAPGRg8WdS5mvu4I/XUdXhDUjfacIdkwplYW5w?=
 =?us-ascii?Q?AFlvTxM9Y38W5LmZrzrCg1LrAN8EB8j1QGtKBEslmShkZkSjmqXapap99v/R?=
 =?us-ascii?Q?M+3nA0DzAgGJprl4NfXGz7CIEVIc3TWZOOgNZUq3u9O1esfkGX03tNYw8bt2?=
 =?us-ascii?Q?NJKOuzBbpgYktUDQSub8Jwo11tdVToq9lI3p+6+8dH7lEpJnYmQUmPsgptoz?=
 =?us-ascii?Q?ZK2abmKykI7S5y6iIeZsy+9STjsnua9BNDThpnx3PT6goOekyKVYLH29C2WE?=
 =?us-ascii?Q?1a+WAAfCrAnbVh6e8RASaEOoTKdO2BzGdP3Ns08Fvek5kJpCjEv3RaUKncPK?=
 =?us-ascii?Q?Jmd3h1XAHzJ/lJVbRAvX19qtsMq7BfcA7OE5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11147.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(7416014)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gE39pjusLPF07/HoXetDgvmhAZ6TtPYmXHh1xGnyvkrBv+KUWUjlZk4twXO8?=
 =?us-ascii?Q?YGCYc82izD6Phl7EilE6KsnJ6JZntU3YhNwJnmpsM9ef5gSdbukKxF6eDrlZ?=
 =?us-ascii?Q?B1c7nRZDqtYsjOVOpye+EMIMJEPEYoDf8QWrwFV7Ce3aR8HuVSAcOGKqI6cP?=
 =?us-ascii?Q?gbpWNcNFtZFrsr5+beB2XXSoKqNK6xs+o/QwGh7L0augnD1ojJbOUUmshLGE?=
 =?us-ascii?Q?giDrrIMcsPNRlJoO3MzL76Qb1yyDytoirUtIN5zR3bjjr6U0Fg6f3uPMhNZM?=
 =?us-ascii?Q?xqPp6DAHlsBsPMZCMFO7Y1ieMaPjf3tRHOtJtLLV9fh9q3kpajY0Bwa9q6dS?=
 =?us-ascii?Q?iJ9SONIOiG70ltU8lByRMfckMV3HQlcNlh5rkP/r+rmvER9h+yH/mgRmXuqw?=
 =?us-ascii?Q?MKffP008PR8+0wPUu2TUVFm8aQB7d5ty5svRxXaHK/A6LKdy7IBc+d7sxcEo?=
 =?us-ascii?Q?zol1inxeVw6Jn2BEl69SV1SRh5V/w8tV9qh3/DphcuyuIgTLVh+9Nmnu5djz?=
 =?us-ascii?Q?2+0MaKc+511vKYgkD6nkJVRNpmYcakT0c+yGaGO/Sjeh4mqd5xCuJDjBTRDV?=
 =?us-ascii?Q?FESxL3f4ywIDfyUrT8RsVERmEU+GvJdgrcgXrs8nui6wKxyDX3XRUhBX5a1x?=
 =?us-ascii?Q?ubQe1kPjo70CWfRG4pz9H7jZAHwpMbrANoDXrDOzHc28QsIURnA6w3tr22Nb?=
 =?us-ascii?Q?UeyKlqOKWcBXjn2tILcAl2E9whl5096buy1n+LhNM6kJkRX7xvjBf0q56vzI?=
 =?us-ascii?Q?+N/eGX/s6iDYhOQRrP4YZ38wUtC5b0xOSkZzDMQKDOQ9fx9itewz4+tnJ2Y4?=
 =?us-ascii?Q?h7ebCKTmlQajWk4PFcofBV6cW1GSDM+1cIyn+GvMPqNwNQvhNfNX6tDTQTWU?=
 =?us-ascii?Q?SHK6RW4S5MarMeVTjSfAhQw+9wZl17FN1FQfNboQm0n99UOY0KtU3WO8mL7n?=
 =?us-ascii?Q?k8htEkjQXOD15zgnBe2IBPvi1mW8zUeGznu6G90eSNj/cV85ieN3xZmuGfSg?=
 =?us-ascii?Q?Id1dvxQijNoweAZFwwLRE6TKBf15JHcDk+/fX2YH/slYWp8xzKOfkGYy6vvG?=
 =?us-ascii?Q?zxHupDyYnQ3gQtv5gJ1XlhDyomzqGu6iU2hZVQZJERjnCw23JJ21SLSk7IB5?=
 =?us-ascii?Q?3Q9d3MQEjwv/hggOqRfKXAPT7Nab7pzKJqxe1GbRHICqUWR4i4QQyVI2h8sg?=
 =?us-ascii?Q?GllfMKVfDRXzlwrtGDymYnQPnkY4nhDU0aZ+FyV9yvIONzUBs9BVZecbub3D?=
 =?us-ascii?Q?+veydeUbd5NJQr3Kaiq1esB3glr2ETWKNHYhQ3vLZ1Yp0I9+256PcmGUJ+3G?=
 =?us-ascii?Q?Wt6YTSpVARvYtJRAiEqbKXQNukwGC+CX0V1LyaGSJaqVvXi+swT2B4jk46cU?=
 =?us-ascii?Q?7bdnEEKMW041v4b9tq2GmnZ1xPcNbMh7iBAEGJWn7WysWeuuruamUtW3Bode?=
 =?us-ascii?Q?T2nQOnJvtun1zRhvZfO48H2uE5mO1T7AmocmUqLM4X6u8oaRAEmqkeuQuqDi?=
 =?us-ascii?Q?6I/1sGvwf6cXJzVsWpNyLYYC1kpn2aWweKCm9vz3x0wEztyyYyUCXMCKWDgT?=
 =?us-ascii?Q?5FVbKLJYCIawNRruf068BfF7ii7zxQhuu6Vjdh3n?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1e6cff4-e3e6-4431-42c7-08de317841e5
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11147.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 07:56:11.1337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /bAx9XT6edqAr2gE2PzN07YwxnLwgQq2BduT4TuiM9SpQSoNM7S79aiPgcZFi2pvPSIYLR/Cm1Xn0YauByrGdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11171

ECSPI transfers only one word per frame in DMA mode, causing SCLK stalls
between words due to BURST_LENGTH updates, which significantly impacts
performance.

To improve throughput, configure BURST_LENGTH as large as possible (up to
512 bytes per frame) instead of word length. This avoids delays between
words. When transfer length is not 4-byte aligned, use bounce buffers to
align data for DMA. TX uses aligned words for TXFIFO, while RX trims DMA
buffer data after transfer completion.

Introduce a new dma_package structure to store:
  1. BURST_LENGTH values for each DMA request
  2. Variables for DMA submission
  3. DMA transmission length and actual data length

Handle three cases:
  - len <= 512 bytes: one package, BURST_LENGTH = len * 8 - 1
  - len > 512 and aligned: one package, BURST_LENGTH = max (512 bytes)
  - len > 512 and unaligned: two packages, second for tail data

Performance test (spidev_test @10MHz, 4KB):
  Before: tx/rx ~6651.9 kbps
  After:  tx/rx ~9922.2 kbps (~50% improvement)

For compatibility with slow SPI devices, add configurable word delay in
DMA mode. When word delay is set, dynamic burst is disabled and
BURST_LENGTH equals word length.

Signed-off-by: Carlos Song <carlos.song@nxp.com>
---
 drivers/spi/spi-imx.c | 413 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 377 insertions(+), 36 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 42f64d9535c9..045f4ffd680a 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -60,6 +60,7 @@ MODULE_PARM_DESC(polling_limit_us,
 #define MX51_ECSPI_CTRL_MAX_BURST	512
 /* The maximum bytes that IMX53_ECSPI can transfer in target mode.*/
 #define MX53_MAX_TRANSFER_BYTES		512
+#define BYTES_PER_32BITS_WORD		4
 
 enum spi_imx_devtype {
 	IMX1_CSPI,
@@ -95,6 +96,16 @@ struct spi_imx_devtype_data {
 	enum spi_imx_devtype devtype;
 };
 
+struct dma_data_package {
+	u32 cmd_word;
+	void *dma_rx_buf;
+	void *dma_tx_buf;
+	dma_addr_t dma_tx_addr;
+	dma_addr_t dma_rx_addr;
+	int dma_len;
+	int data_len;
+};
+
 struct spi_imx_data {
 	struct spi_controller *controller;
 	struct device *dev;
@@ -130,6 +141,9 @@ struct spi_imx_data {
 	u32 wml;
 	struct completion dma_rx_completion;
 	struct completion dma_tx_completion;
+	size_t dma_package_num;
+	struct dma_data_package *dma_data __counted_by(dma_package_num);
+	int rx_offset;
 
 	const struct spi_imx_devtype_data *devtype_data;
 };
@@ -189,6 +203,9 @@ MXC_SPI_BUF_TX(u16)
 MXC_SPI_BUF_RX(u32)
 MXC_SPI_BUF_TX(u32)
 
+/* Align to cache line to avoid swiotlo bounce */
+#define DMA_CACHE_ALIGNED_LEN(x) ALIGN((x), dma_get_cache_alignment())
+
 /* First entry is reserved, second entry is valid only if SDHC_SPIEN is set
  * (which is currently not the case in this driver)
  */
@@ -253,6 +270,14 @@ static bool spi_imx_can_dma(struct spi_controller *controller, struct spi_device
 	if (transfer->len < spi_imx->devtype_data->fifo_size)
 		return false;
 
+	/* DMA only can transmit data in bytes */
+	if (spi_imx->bits_per_word != 8 && spi_imx->bits_per_word != 16 &&
+	    spi_imx->bits_per_word != 32)
+		return false;
+
+	if (transfer->len >= MAX_SDMA_BD_BYTES)
+		return false;
+
 	spi_imx->dynamic_burst = 0;
 
 	return true;
@@ -1398,8 +1423,6 @@ static int spi_imx_sdma_init(struct device *dev, struct spi_imx_data *spi_imx,
 
 	init_completion(&spi_imx->dma_rx_completion);
 	init_completion(&spi_imx->dma_tx_completion);
-	controller->can_dma = spi_imx_can_dma;
-	controller->max_dma_len = MAX_SDMA_BD_BYTES;
 	spi_imx->controller->flags = SPI_CONTROLLER_MUST_RX |
 					 SPI_CONTROLLER_MUST_TX;
 
@@ -1437,10 +1460,259 @@ static int spi_imx_calculate_timeout(struct spi_imx_data *spi_imx, int size)
 	return secs_to_jiffies(2 * timeout);
 }
 
+static void spi_imx_dma_unmap(struct spi_imx_data *spi_imx,
+			      struct dma_data_package *dma_data)
+{
+	struct device *tx_dev = spi_imx->controller->dma_tx->device->dev;
+	struct device *rx_dev = spi_imx->controller->dma_rx->device->dev;
+
+	dma_unmap_single(tx_dev, dma_data->dma_tx_addr,
+			 DMA_CACHE_ALIGNED_LEN(dma_data->dma_len),
+			 DMA_TO_DEVICE);
+	dma_unmap_single(rx_dev, dma_data->dma_rx_addr,
+			 DMA_CACHE_ALIGNED_LEN(dma_data->dma_len),
+			 DMA_FROM_DEVICE);
+}
+
+static void spi_imx_dma_rx_data_handle(struct spi_imx_data *spi_imx,
+				       struct dma_data_package *dma_data, void *rx_buf,
+				       bool word_delay)
+{
+	void *copy_ptr;
+	int unaligned;
+
+	/*
+	 * On little-endian CPUs, adjust byte order:
+	 * - Swap bytes when bpw = 8
+	 * - Swap half-words when bpw = 16
+	 * This ensures correct data ordering for DMA transfers.
+	 */
+#ifdef __LITTLE_ENDIAN
+	if (!word_delay) {
+		unsigned int bytes_per_word = spi_imx_bytes_per_word(spi_imx->bits_per_word);
+		u32 *temp = dma_data->dma_rx_buf;
+
+		for (int i = 0; i < DIV_ROUND_UP(dma_data->dma_len, sizeof(*temp)); i++) {
+			if (bytes_per_word == 1)
+				swab32s(temp + i);
+			else if (bytes_per_word == 2)
+				swahw32s(temp + i);
+		}
+	}
+#endif
+
+	/*
+	 * When dynamic burst enabled, DMA RX always receives 32-bit words from RXFIFO with
+	 * buswidth = 4, but when data_len is not 4-bytes alignment, the RM shows when
+	 * burst length = 32*n + m bits, a SPI burst contains the m LSB in first word and all
+	 * 32 bits in other n words. So if garbage bytes in the first word, trim first word then
+	 * copy the actual data to rx_buf.
+	 */
+	if (dma_data->data_len % BYTES_PER_32BITS_WORD && !word_delay) {
+		unaligned = dma_data->data_len % BYTES_PER_32BITS_WORD;
+		copy_ptr = (u8 *)dma_data->dma_rx_buf + BYTES_PER_32BITS_WORD - unaligned;
+	} else {
+		copy_ptr = dma_data->dma_rx_buf;
+	}
+
+	memcpy(rx_buf, copy_ptr, dma_data->data_len);
+}
+
+static int spi_imx_dma_map(struct spi_imx_data *spi_imx,
+			   struct dma_data_package *dma_data)
+{
+	struct spi_controller *controller = spi_imx->controller;
+	struct device *tx_dev = controller->dma_tx->device->dev;
+	struct device *rx_dev = controller->dma_rx->device->dev;
+	int ret;
+
+	dma_data->dma_tx_addr = dma_map_single(tx_dev, dma_data->dma_tx_buf,
+					       DMA_CACHE_ALIGNED_LEN(dma_data->dma_len),
+					       DMA_TO_DEVICE);
+	ret = dma_mapping_error(tx_dev, dma_data->dma_tx_addr);
+	if (ret < 0) {
+		dev_err(spi_imx->dev, "DMA TX map failed %d\n", ret);
+		return ret;
+	}
+
+	dma_data->dma_rx_addr = dma_map_single(rx_dev, dma_data->dma_rx_buf,
+					       DMA_CACHE_ALIGNED_LEN(dma_data->dma_len),
+					       DMA_FROM_DEVICE);
+	ret = dma_mapping_error(rx_dev, dma_data->dma_rx_addr);
+	if (ret < 0) {
+		dev_err(spi_imx->dev, "DMA RX map failed %d\n", ret);
+		dma_unmap_single(tx_dev, dma_data->dma_tx_addr,
+				 DMA_CACHE_ALIGNED_LEN(dma_data->dma_len),
+				 DMA_TO_DEVICE);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int spi_imx_dma_tx_data_handle(struct spi_imx_data *spi_imx,
+				      struct dma_data_package *dma_data,
+				      const void *tx_buf,
+				      bool word_delay)
+{
+	void *copy_ptr;
+	int unaligned;
+
+	if (word_delay) {
+		dma_data->dma_len = dma_data->data_len;
+	} else {
+		/*
+		 * As per the reference manual, when burst length = 32*n + m bits, ECSPI
+		 * sends m LSB bits in the first word, followed by n full 32-bit words.
+		 * Since actual data may not be 4-byte aligned, allocate DMA TX/RX buffers
+		 * to ensure alignment. For TX, DMA pushes 4-byte aligned words to TXFIFO,
+		 * while ECSPI uses BURST_LENGTH settings to maintain correct bit count.
+		 * For RX, DMA always receives 32-bit words from RXFIFO, when data len is
+		 * not 4-byte aligned, trim the first word to drop garbage bytes, then group
+		 * all transfer DMA bounse buffer and copy all valid data to rx_buf.
+		 */
+		dma_data->dma_len = ALIGN(dma_data->data_len, BYTES_PER_32BITS_WORD);
+	}
+
+	dma_data->dma_tx_buf = kzalloc(dma_data->dma_len, GFP_KERNEL);
+	if (!dma_data->dma_tx_buf)
+		return -ENOMEM;
+
+	dma_data->dma_rx_buf = kzalloc(dma_data->dma_len, GFP_KERNEL);
+	if (!dma_data->dma_rx_buf) {
+		kfree(dma_data->dma_tx_buf);
+		return -ENOMEM;
+	}
+
+	if (dma_data->data_len % BYTES_PER_32BITS_WORD && !word_delay) {
+		unaligned = dma_data->data_len % BYTES_PER_32BITS_WORD;
+		copy_ptr = (u8 *)dma_data->dma_tx_buf + BYTES_PER_32BITS_WORD - unaligned;
+	} else {
+		copy_ptr = dma_data->dma_tx_buf;
+	}
+
+	memcpy(copy_ptr, tx_buf, dma_data->data_len);
+
+	/*
+	 * When word_delay is enabled, DMA transfers an entire word in one minor loop.
+	 * In this case, no data requires additional handling.
+	 */
+	if (word_delay)
+		return 0;
+
+#ifdef __LITTLE_ENDIAN
+	/*
+	 * On little-endian CPUs, adjust byte order:
+	 * - Swap bytes when bpw = 8
+	 * - Swap half-words when bpw = 16
+	 * This ensures correct data ordering for DMA transfers.
+	 */
+	unsigned int bytes_per_word = spi_imx_bytes_per_word(spi_imx->bits_per_word);
+	u32 *temp = dma_data->dma_tx_buf;
+
+	for (int i = 0; i < DIV_ROUND_UP(dma_data->dma_len, sizeof(*temp)); i++) {
+		if (bytes_per_word == 1)
+			swab32s(temp + i);
+		else if (bytes_per_word == 2)
+			swahw32s(temp + i);
+	}
+#endif
+
+	return 0;
+}
+
+static int spi_imx_dma_data_prepare(struct spi_imx_data *spi_imx,
+				    struct spi_transfer *transfer,
+				    bool word_delay)
+{
+	u32 pre_bl, tail_bl;
+	u32 ctrl;
+	int ret;
+
+	/*
+	 * ECSPI supports a maximum burst of 512 bytes. When xfer->len exceeds 512
+	 * and is not a multiple of 512, a tail transfer is required. BURST_LEGTH
+	 * is used for SPI HW to maintain correct bit count. BURST_LENGTH should
+	 * update with data length. After DMA request submit, SPI can not update the
+	 * BURST_LENGTH, in this case, we must split two package, update the register
+	 * then setup second DMA transfer.
+	 */
+	ctrl = readl(spi_imx->base + MX51_ECSPI_CTRL);
+	if (word_delay) {
+		/*
+		 * When SPI IMX need to support word delay, according to "Sample Period Control
+		 * Register" shows, The Sample Period Control Register (ECSPI_PERIODREG)
+		 * provides software a way to insert delays (wait states) between consecutive
+		 * SPI transfers. As a result, ECSPI can only transfer one word per frame, and
+		 * the delay occurs between frames.
+		 */
+		spi_imx->dma_package_num = 1;
+		pre_bl = spi_imx->bits_per_word - 1;
+	} else if (transfer->len <= MX51_ECSPI_CTRL_MAX_BURST) {
+		spi_imx->dma_package_num = 1;
+		pre_bl = transfer->len * BITS_PER_BYTE - 1;
+	} else if (!(transfer->len % MX51_ECSPI_CTRL_MAX_BURST)) {
+		spi_imx->dma_package_num = 1;
+		pre_bl = MX51_ECSPI_CTRL_MAX_BURST * BITS_PER_BYTE - 1;
+	} else {
+		spi_imx->dma_package_num = 2;
+		pre_bl = MX51_ECSPI_CTRL_MAX_BURST * BITS_PER_BYTE - 1;
+		tail_bl = (transfer->len % MX51_ECSPI_CTRL_MAX_BURST) * BITS_PER_BYTE - 1;
+	}
+
+	spi_imx->dma_data = kmalloc_array(spi_imx->dma_package_num,
+					  sizeof(struct dma_data_package),
+					  GFP_KERNEL | __GFP_ZERO);
+	if (!spi_imx->dma_data) {
+		dev_err(spi_imx->dev, "Failed to allocate DMA package buffer!\n");
+		return -ENOMEM;
+	}
+
+	if (spi_imx->dma_package_num == 1) {
+		ctrl &= ~MX51_ECSPI_CTRL_BL_MASK;
+		ctrl |= pre_bl << MX51_ECSPI_CTRL_BL_OFFSET;
+		spi_imx->dma_data[0].cmd_word = ctrl;
+		spi_imx->dma_data[0].data_len = transfer->len;
+		ret = spi_imx_dma_tx_data_handle(spi_imx, &spi_imx->dma_data[0], transfer->tx_buf,
+						 word_delay);
+		if (ret) {
+			kfree(spi_imx->dma_data);
+			return ret;
+		}
+	} else {
+		ctrl &= ~MX51_ECSPI_CTRL_BL_MASK;
+		ctrl |= pre_bl << MX51_ECSPI_CTRL_BL_OFFSET;
+		spi_imx->dma_data[0].cmd_word = ctrl;
+		spi_imx->dma_data[0].data_len = round_down(transfer->len,
+							   MX51_ECSPI_CTRL_MAX_BURST);
+		ret = spi_imx_dma_tx_data_handle(spi_imx, &spi_imx->dma_data[0], transfer->tx_buf,
+						 false);
+		if (ret) {
+			kfree(spi_imx->dma_data);
+			return ret;
+		}
+
+		ctrl &= ~MX51_ECSPI_CTRL_BL_MASK;
+		ctrl |= tail_bl << MX51_ECSPI_CTRL_BL_OFFSET;
+		spi_imx->dma_data[1].cmd_word = ctrl;
+		spi_imx->dma_data[1].data_len = transfer->len % MX51_ECSPI_CTRL_MAX_BURST;
+		ret = spi_imx_dma_tx_data_handle(spi_imx, &spi_imx->dma_data[1],
+						 transfer->tx_buf + spi_imx->dma_data[0].data_len,
+						 false);
+		if (ret) {
+			kfree(spi_imx->dma_data[0].dma_tx_buf);
+			kfree(spi_imx->dma_data[0].dma_rx_buf);
+			kfree(spi_imx->dma_data);
+		}
+	}
+
+	return 0;
+}
+
 static int spi_imx_dma_submit(struct spi_imx_data *spi_imx,
+			      struct dma_data_package *dma_data,
 			      struct spi_transfer *transfer)
 {
-	struct sg_table *tx = &transfer->tx_sg, *rx = &transfer->rx_sg;
 	struct spi_controller *controller = spi_imx->controller;
 	struct dma_async_tx_descriptor *desc_tx, *desc_rx;
 	unsigned long transfer_timeout;
@@ -1451,9 +1723,9 @@ static int spi_imx_dma_submit(struct spi_imx_data *spi_imx,
 	 * The TX DMA setup starts the transfer, so make sure RX is configured
 	 * before TX.
 	 */
-	desc_rx = dmaengine_prep_slave_sg(controller->dma_rx,
-					  rx->sgl, rx->nents, DMA_DEV_TO_MEM,
-					  DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	desc_rx = dmaengine_prep_slave_single(controller->dma_rx, dma_data->dma_rx_addr,
+					      dma_data->dma_len, DMA_DEV_TO_MEM,
+					      DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	if (!desc_rx) {
 		transfer->error |= SPI_TRANS_FAIL_NO_START;
 		return -EINVAL;
@@ -1471,9 +1743,9 @@ static int spi_imx_dma_submit(struct spi_imx_data *spi_imx,
 	reinit_completion(&spi_imx->dma_rx_completion);
 	dma_async_issue_pending(controller->dma_rx);
 
-	desc_tx = dmaengine_prep_slave_sg(controller->dma_tx,
-					  tx->sgl, tx->nents, DMA_MEM_TO_DEV,
-					  DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	desc_tx = dmaengine_prep_slave_single(controller->dma_tx, dma_data->dma_tx_addr,
+					      dma_data->dma_len, DMA_MEM_TO_DEV,
+					      DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	if (!desc_tx)
 		goto dmaengine_terminate_rx;
 
@@ -1521,16 +1793,16 @@ static int spi_imx_dma_submit(struct spi_imx_data *spi_imx,
 }
 
 static void spi_imx_dma_max_wml_find(struct spi_imx_data *spi_imx,
-				     struct spi_transfer *transfer)
+				     struct dma_data_package *dma_data,
+				     bool word_delay)
 {
-	struct sg_table *rx = &transfer->rx_sg;
-	struct scatterlist *last_sg = sg_last(rx->sgl, rx->nents);
-	unsigned int bytes_per_word, i;
+	unsigned int bytes_per_word = word_delay ?
+				      spi_imx_bytes_per_word(spi_imx->bits_per_word) :
+				      BYTES_PER_32BITS_WORD;
+	unsigned int i;
 
-	/* Get the right burst length from the last sg to ensure no tail data */
-	bytes_per_word = spi_imx_bytes_per_word(transfer->bits_per_word);
 	for (i = spi_imx->devtype_data->fifo_size / 2; i > 0; i--) {
-		if (!(sg_dma_len(last_sg) % (i * bytes_per_word)))
+		if (!dma_data->dma_len % (i * bytes_per_word))
 			break;
 	}
 	/* Use 1 as wml in case no available burst length got */
@@ -1540,25 +1812,29 @@ static void spi_imx_dma_max_wml_find(struct spi_imx_data *spi_imx,
 	spi_imx->wml = i;
 }
 
-static int spi_imx_dma_configure(struct spi_controller *controller)
+static int spi_imx_dma_configure(struct spi_controller *controller, bool word_delay)
 {
 	int ret;
 	enum dma_slave_buswidth buswidth;
 	struct dma_slave_config rx = {}, tx = {};
 	struct spi_imx_data *spi_imx = spi_controller_get_devdata(controller);
 
-	switch (spi_imx_bytes_per_word(spi_imx->bits_per_word)) {
-	case 4:
+	if (word_delay) {
+		switch (spi_imx_bytes_per_word(spi_imx->bits_per_word)) {
+		case 4:
+			buswidth = DMA_SLAVE_BUSWIDTH_4_BYTES;
+			break;
+		case 2:
+			buswidth = DMA_SLAVE_BUSWIDTH_2_BYTES;
+			break;
+		case 1:
+			buswidth = DMA_SLAVE_BUSWIDTH_1_BYTE;
+			break;
+		default:
+			return -EINVAL;
+		}
+	} else {
 		buswidth = DMA_SLAVE_BUSWIDTH_4_BYTES;
-		break;
-	case 2:
-		buswidth = DMA_SLAVE_BUSWIDTH_2_BYTES;
-		break;
-	case 1:
-		buswidth = DMA_SLAVE_BUSWIDTH_1_BYTE;
-		break;
-	default:
-		return -EINVAL;
 	}
 
 	tx.direction = DMA_MEM_TO_DEV;
@@ -1584,15 +1860,17 @@ static int spi_imx_dma_configure(struct spi_controller *controller)
 	return 0;
 }
 
-static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
-				struct spi_transfer *transfer)
+static int spi_imx_dma_package_transfer(struct spi_imx_data *spi_imx,
+					struct dma_data_package *dma_data,
+					struct spi_transfer *transfer,
+					bool word_delay)
 {
 	struct spi_controller *controller = spi_imx->controller;
 	int ret;
 
-	spi_imx_dma_max_wml_find(spi_imx, transfer);
+	spi_imx_dma_max_wml_find(spi_imx, dma_data, word_delay);
 
-	ret = spi_imx_dma_configure(controller);
+	ret = spi_imx_dma_configure(controller, word_delay);
 	if (ret)
 		goto dma_failure_no_start;
 
@@ -1603,10 +1881,17 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
 	}
 	spi_imx->devtype_data->setup_wml(spi_imx);
 
-	ret = spi_imx_dma_submit(spi_imx, transfer);
+	ret = spi_imx_dma_submit(spi_imx, dma_data, transfer);
 	if (ret)
 		return ret;
 
+	/* Trim the DMA RX buffer and copy the actual data to rx_buf */
+	dma_sync_single_for_cpu(controller->dma_rx->device->dev, dma_data->dma_rx_addr,
+				dma_data->dma_len, DMA_FROM_DEVICE);
+	spi_imx_dma_rx_data_handle(spi_imx, dma_data, transfer->rx_buf + spi_imx->rx_offset,
+				   word_delay);
+	spi_imx->rx_offset += dma_data->data_len;
+
 	return 0;
 /* fallback to pio */
 dma_failure_no_start:
@@ -1614,6 +1899,57 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
 	return ret;
 }
 
+static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
+				struct spi_transfer *transfer)
+{
+	bool word_delay = transfer->word_delay.value != 0;
+	int ret;
+	int i;
+
+	ret = spi_imx_dma_data_prepare(spi_imx, transfer, word_delay);
+	if (ret < 0) {
+		transfer->error |= SPI_TRANS_FAIL_NO_START;
+		dev_err(spi_imx->dev, "DMA data prepare fail\n");
+		goto fallback_pio;
+	}
+
+	spi_imx->rx_offset = 0;
+
+	/* Each dma_package performs a separate DMA transfer once */
+	for (i = 0; i < spi_imx->dma_package_num; i++) {
+		ret = spi_imx_dma_map(spi_imx, &spi_imx->dma_data[i]);
+		if (ret < 0) {
+			if (i == 0)
+				transfer->error |= SPI_TRANS_FAIL_NO_START;
+			dev_err(spi_imx->dev, "DMA map fail\n");
+			break;
+		}
+
+		/* Update the CTRL register BL field */
+		writel(spi_imx->dma_data[i].cmd_word, spi_imx->base + MX51_ECSPI_CTRL);
+
+		ret = spi_imx_dma_package_transfer(spi_imx, &spi_imx->dma_data[i],
+						   transfer, word_delay);
+
+		/* Whether the dma transmission is successful or not, dma unmap is necessary */
+		spi_imx_dma_unmap(spi_imx, &spi_imx->dma_data[i]);
+
+		if (ret < 0) {
+			dev_dbg(spi_imx->dev, "DMA %d transfer not really finish\n", i);
+			break;
+		}
+	}
+
+	for (int j = 0; j < spi_imx->dma_package_num; j++) {
+		kfree(spi_imx->dma_data[j].dma_tx_buf);
+		kfree(spi_imx->dma_data[j].dma_rx_buf);
+	}
+	kfree(spi_imx->dma_data);
+
+fallback_pio:
+	return ret;
+}
+
 static int spi_imx_pio_transfer(struct spi_device *spi,
 				struct spi_transfer *transfer)
 {
@@ -1780,9 +2116,14 @@ static int spi_imx_transfer_one(struct spi_controller *controller,
 	 * transfer, the SPI transfer has already been mapped, so we
 	 * have to do the DMA transfer here.
 	 */
-	if (spi_imx->usedma)
-		return spi_imx_dma_transfer(spi_imx, transfer);
-
+	if (spi_imx->usedma) {
+		ret = spi_imx_dma_transfer(spi_imx, transfer);
+		if (transfer->error & SPI_TRANS_FAIL_NO_START) {
+			spi_imx->usedma = false;
+			return spi_imx_pio_transfer(spi, transfer);
+		}
+		return ret;
+	}
 	/* run in polling mode for short transfers */
 	if (transfer->len == 1 || (polling_limit_us &&
 				   spi_imx_transfer_estimate_time_us(transfer) < polling_limit_us))
-- 
2.34.1


