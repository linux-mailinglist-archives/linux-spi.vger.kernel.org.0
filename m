Return-Path: <linux-spi+bounces-9552-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A19B2DCA3
	for <lists+linux-spi@lfdr.de>; Wed, 20 Aug 2025 14:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFC5B3BA080
	for <lists+linux-spi@lfdr.de>; Wed, 20 Aug 2025 12:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31AF31A05B;
	Wed, 20 Aug 2025 12:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="H2ora7Ne"
X-Original-To: linux-spi@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020141.outbound.protection.outlook.com [52.101.84.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7E331770C;
	Wed, 20 Aug 2025 12:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755693215; cv=fail; b=p3mqziFhe4wd+dP92YvWzxKyq2v/B54rGy3sNNICQbuPHOzUuUFIdFX57t+9Aiv186jyDkal/C0WbO/KZmcEQzt1XKPHK6OPwiEYxrkwDgZF9l3z2M8f5B/MA4iC98rC0RN5cfRnXP7IlKazzV1uQ5++6XocLxydmgkJiOVEImk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755693215; c=relaxed/simple;
	bh=W86g0NsD3OJESLhX+5yXzFIXGL8/TKJdzM92z0+boHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c2zX35MoVjtaO5iFIpxOT5sIHtJHg8f8tPbAM538iH3Ak7trCv6yilLFHM6ZFChm5cFh4x4DnBDtuGNnIcSHH4BF/SQ+++IOx/nJ+KBQPT/Y8AhoTBCMjHw+0nAMcbjzD4aXrt06s0YD8XtGWv49Wh1A3bZ6b7V+2BODvZC1g3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=H2ora7Ne; arc=fail smtp.client-ip=52.101.84.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HJA88jHye7riFhH3vCr5a2bgDGQD2oigJ7kD/fExytMZLNbI1AUVjx7DALpW1fxVkApljb4aYMSaVOb6o6f2pjEmwpmmuu3dxhWxtGpQvl1ef2luvmv96mFS0jA4Icisy5sPUAhTdaqfBvqKvWMO60RDchIeOvdxmYCKHXGHcKDcHlEFw+uXaD7KOka8e6fJphugMJLH+DVd6vwbo8a9Uhx3vu4kvi0fNk1JffrCTqJ1a0b2dwjdGqfdOZd9Fb01tFRpmv7n2L7JakRANC2UGKRMGxam9utlfbItYbZGI8UUodzcMxF2zVGHyXkEQojiPFyW9E/kKKxT8X9MXg7vjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QZuFdupbcTec0eDGrzQ/n0GGOEGBWkYNKuTsFdVsv/A=;
 b=tX6G2tRXQ34V7AKReEnc9IF8CN5sH72AIKKmVmt3wVM+cKFp2pOKQ9VALtGnwYjhIhl1OA2MjMhd/1JWLAiWVpKRV/5tXyAKT2fb5GbfKs0urYIh6NEAyq3ENZGYtZW1Xg0SpAuyEgPPtvQz43SZpGIT8xozfktrYjZzkMVdOMNw9Tf2+a05feKNjACVpooIwYv0FaL0Iumb+N6H3ZjrL/BLRqMhxLQxPjofahBjqCqV971RPe0OWF5k8PJK+UjKPKP7nN7kVNvFZx2T/qDwgW5uKuaBrTQ5rBasbFRdLCqmz3bcM+gJsWlRkiDZmWL8K75ZD/thtJLU0EEn3enUdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZuFdupbcTec0eDGrzQ/n0GGOEGBWkYNKuTsFdVsv/A=;
 b=H2ora7Nel7f4AExvqwBZ4JR54aCCKQ6gYKfaRGNzbXsZqCl37jn5SOsRu2CZTBIJkIeUBZPQJedz/9bdLKO+JPjOih+u6R+jCGPmHK/Ru9fSX3ey/UFQhrIbRte10uvjwmVQ5bFfd5OYxc32n4WrYPWKp4TXgJvZC9c+ifTaZJxhhwEmeBQmI4Hn8vlfZOXRvMHHZTzKGyKobNzE85n2RGiLZl2kZ8e7boKs3C7fiwf+dBr2WQ8fBx0U+Z3XDlDKlpd7l1jLBiIJARim8asVG+aLWHLW/IwjJ6NRiO47ihZb348lNEw96PLaoc+cxvV2EtqjZX0k0dkNQrXe0wTBxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM8PR08MB6355.eurprd08.prod.outlook.com (2603:10a6:20b:363::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 12:33:27 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Wed, 20 Aug 2025
 12:33:27 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Frieder Schrempf <frieder.schrempf@kontron.de>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v3 03/14] spi: airoha: add support of dual/quad wires spi modes
Date: Wed, 20 Aug 2025 15:33:06 +0300
Message-ID: <20250820123317.728148-4-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AM8PR08MB6355:EE_
X-MS-Office365-Filtering-Correlation-Id: f3691a32-88c7-4a2e-ce8a-08dddfe5c2fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RPY8Bzt3UBCaFqDmVGfnqZ88OZEinwKpGW8c3JIHvD/5klfuPnj0z/GfUGFI?=
 =?us-ascii?Q?dMg1/v9jfnx6GQFDE1TG6cu0dtGnbk+Vut6z8e1nXXTtsP+6KJSZ5I8vblcL?=
 =?us-ascii?Q?uuQ/F68AQdiAy6yPnTuDLwPRGj8DUt/QLfYAFRmJuUfN4is5PIN/5imN1FZH?=
 =?us-ascii?Q?eR87PwJjrXdAGrsQwaD6ZZAGsP1PHfDRxvmAAVoI+wOJgsJZal8ksdDAcO7+?=
 =?us-ascii?Q?FnLBhj69EVhqp6XDRHiEYYnHlHBd5Vl2ZlrF6bSaybK027J1c2Bh6moCYCcL?=
 =?us-ascii?Q?kD4riFp/H36yA+iJxFKwCLDvWdPzE0N53NdAaKJAKYwf1duorpeGz/R/E+x0?=
 =?us-ascii?Q?sC0O5hVRAmpDe8bDe7Y6qp+8h3t2VsIGJa2YcFrJZ8TF8Rko5jdR2kNFv09H?=
 =?us-ascii?Q?Qlun2kFBaDmV9W2/Tt8i8qXCwPyLncv1+E1imvFP2bF6W/FO5xNcYUBLAZTX?=
 =?us-ascii?Q?7zXhXExtmvfq6fTmfL0w4Kmvia3ZA6Xo/Ah19+8xQiI+ElZ6FzqlaPdK1Gxx?=
 =?us-ascii?Q?ia1++DtIDm1ZWqgm9z7LZ0pKC8sjVaN2L1Q2mu9rJfx0UdUz7Iwfu0fWypM1?=
 =?us-ascii?Q?OKpI7tRaVm+efix4I2Uejfw7/2M2QF9fjSq9AyZNQvGClH8I4uUG2lIc+h3X?=
 =?us-ascii?Q?rP6iHio7dvt5xoVk2Mx6T2h0DmBwXf3tHcjHKAUQzRig9btxyTNjcrB1VC66?=
 =?us-ascii?Q?jx2lvjQlgHcYugARksw9PjQttwnMUlouAPjZom0E4tpbldt/RYMeQ/J5LgOC?=
 =?us-ascii?Q?NiQzqiup85AfYtlK97m9ZDEe0XZ5FO6rfKZrGQmp4sAl3GPFIBEQHqzAcpU+?=
 =?us-ascii?Q?MgC5kLv/YDUZGuQJt69Kqi/+NyvG+HQ3mD8RIqs9YCSes/19s/gA6ygnDvnz?=
 =?us-ascii?Q?+8CApCBMYVun0ll5GGPuxeCOP877tQafuZWbw/Rpjk0UqOLUsyA+hoLoOXgt?=
 =?us-ascii?Q?mpPU0b+YroOl0+kxduAbRoFywrvPr1wb5yMsOvimo5Xkp15c2UXS4Oo70o0v?=
 =?us-ascii?Q?i8MSBPwp0tQh0gM49iJ9k7B9bGo+PE67kVG3jVFEWeVwNSN+eVZUoWJVwIpu?=
 =?us-ascii?Q?1Z1uV3rfZv2/DlSLrHfakPOpTSvojyg6OGTulJQ+bF6bgXxBq7R+x9c9ct3z?=
 =?us-ascii?Q?c9iZvAq7U8zPYaDcgUa4RqM7kdWRyUzbgog4+rJQO+ntCSfoXRXMJpeMp/cb?=
 =?us-ascii?Q?hTMBKJvs/DONLU4ewIy5IygRDpyRCYH9+kE8ZrNTn3iXxGCHmvAX/JWvjLdF?=
 =?us-ascii?Q?NYNw2qlJkzmZXldRN7SHW5lVLDzYG3kxCQluz8MAHQ8Cp/GH2RItVpPpPyAu?=
 =?us-ascii?Q?RPX1aSHM41B2bag7WmChNIF3S+0sawnkjgVrLTBQNS4D7cvsn+EY+Ve1MIkK?=
 =?us-ascii?Q?h44CuNv5Xwbas5a/O73/f4Whd9bN7aZIBGGWxBcBONDlbIeTzjtcdYdNgOJY?=
 =?us-ascii?Q?Zp2BYmaZDq0joZL8/Ywe3Y8X0uMXpPAC6/o+0dJo2ErHFJzeAcEgrQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ejaDHIEQVS8xzsIi2quh/04BdfiD1PYvgQYUPfm+JXnKne0cxblFYfUnf/zY?=
 =?us-ascii?Q?UlrwXY/DTTe8VVNTAv6B3Pd7sAyjbNj1pP6Q+Xja2BnsklDwoUs51DXBnCR+?=
 =?us-ascii?Q?QGx+TuhXiZfMIFbicRuOqKOBN2fMNnDmPXll/s9+bHTTFQp/BYRHy9NKz8Yu?=
 =?us-ascii?Q?oDUNuxrgYZs+qVwYRG8zcNPgA0sd7gvrb0TI9Bs8RBM9nDIzUGQxkDHi7MaF?=
 =?us-ascii?Q?nuc1Owcmxv9WBRKfgl0exMQjb/ov25Ds7rWqx5g3EPdpH2+db49n9NLndFuv?=
 =?us-ascii?Q?W/Z7uBxXNUrvrCRTMMl68ug14TX2zzfUg67M8eyiCdOk8B5+kNn9haupFTJm?=
 =?us-ascii?Q?lY0YeWdKxHcdL9lFq22os6sb+mlT3RGZJhtV4vi4f6a7sHQ7oRZdSMEGP2PA?=
 =?us-ascii?Q?t8DktqIWTvBIAmyqkg2gLef51JYk7vX+3ecc+ifFakTyKx94vDBlGofgkFMC?=
 =?us-ascii?Q?lrN23Ob0KhtX2wwlfhJNKRaZKz9Pk3WF8YWDJZ4QQu3cJGwV/o5chDwhXI6c?=
 =?us-ascii?Q?4QKcdRwkq32j6IK31dsqL+0BJ36GFR+8cXExidU1JI8YkRpT8rS+352zuXnF?=
 =?us-ascii?Q?atwBbqrIF3vVAh5VXwyis4wcjlAkwzN4Y8FyHlnPRRCnaL7JkUQr2iht3BQG?=
 =?us-ascii?Q?WHC/MfGL4QY0++nq09Mq7DKYbNuoNhTutRKquUe6dABJ+41z2gcOohmU4NWG?=
 =?us-ascii?Q?0Ty+2DAOPVAPYcDDbqVFaYy+LUJ04rcDKYzGJ/H1eL369zCWsouUYQmzi+AG?=
 =?us-ascii?Q?evs5qOXPbJt+B7OdELUEq8deRB5mK7YXlBMFJ+uHysI9w1si5Vh0BshoEKII?=
 =?us-ascii?Q?Lgwm0xPTEtm1UdBY7s4t8OLALz+vw8kqrgBFVvsiDKQWbyhmz4Qxe92foIZF?=
 =?us-ascii?Q?bBhDPuJqJyo0C+gGbkDVj6PPH/OBI4mC6NWRoLd9fl4WpUzjCkvXp7HNNFEn?=
 =?us-ascii?Q?vAQtKjRLT5yda2Q0+PTwvTj8wEwx/FKJ+DYmUNUIkozLxw+VC76jr9vF3o8/?=
 =?us-ascii?Q?UynoxUaI7g9ttkPaUiNSJEoNexeB9w6xvOe+M11qFK9IQSUQcnMkRBSyr+eU?=
 =?us-ascii?Q?2/MLOlvIYz5fiN0Q8odam7KWOY2oQSl6U6IWuaCi9bWaAqJzQX7mPKdLRuxy?=
 =?us-ascii?Q?utQDlcfT5CuylB1yaTBlibrTKIwBvw2pvrZ3pabdzJ+mQnBoDWiWe5XJwmOw?=
 =?us-ascii?Q?Lmih8xMIg5w5EbZNk+1NVsNu374Ml+EM68VOEnXiYxseEVyNQiOy5Rzs50f4?=
 =?us-ascii?Q?YgvPcurO3KLcQk1fC/V99HHaDyMpsb5HVNqhctI/Su37JkD6NVJHCt/0wQAg?=
 =?us-ascii?Q?mDY2tj1CiKSQVIEmed/Nr281HxcLntkI8e7T6v3UwUh9GURvrDBzUN6yWScJ?=
 =?us-ascii?Q?jlW4nQLRYkh+cEAPDi50SWvIPLeaPylZq+twcWKapvtlVV7Tz0Rjb9wZnCXD?=
 =?us-ascii?Q?LgweHSrsEA+ynCJbo/ZKxd5jJAYq9wDbCY9ipx39olnsH7SgCOJZlyNvv9yC?=
 =?us-ascii?Q?3W1lgZVHsG9jH0FxtplcsYv1Im4fYHres1SEExepqJ/bxPcyJU7yyZ2qX23n?=
 =?us-ascii?Q?DL4g0912ktpwg7b5iXlAe9z5MYRlQF6d6j2leFoqLkFTN98HynEQ9jecBj7b?=
 =?us-ascii?Q?sRMrIpkSoq2U4fu9PefXXKM=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: f3691a32-88c7-4a2e-ce8a-08dddfe5c2fd
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 12:33:26.9847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: naIQrSYIq75rbfy4bLXjrEjmE5nIqUnnwwlDkOaHKmxR2H7DxkGMeTJ8aHccAee17D6X6jqRKfU4W1zWVbMon3AbTmM1DAb19U2P0qYFRus=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6355

This patch adds support of dual and quad wires spi modes. It will
speed up flash operations on the hardware with corresponding hardware
support.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/spi-airoha-snfi.c | 107 +++++++++++++++++++++++++---------
 1 file changed, 80 insertions(+), 27 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index bcc464ec9c61..7aab3506834a 100644
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
 
@@ -387,10 +395,25 @@ static int airoha_snand_set_mode(struct airoha_snand_ctrl *as_ctrl,
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
@@ -409,16 +432,31 @@ static int airoha_snand_write_data(struct airoha_snand_ctrl *as_ctrl, u8 cmd,
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
 
@@ -895,12 +933,27 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 static int airoha_snand_exec_op(struct spi_mem *mem,
 				const struct spi_mem_op *op)
 {
-	u8 data[8], cmd, opcode = op->cmd.opcode;
 	struct airoha_snand_ctrl *as_ctrl;
-	int i, err;
+	char buf[20], *data;
+	int i, err, op_len, addr_len, dummy_len;
 
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
@@ -911,40 +964,40 @@ static int airoha_snand_exec_op(struct spi_mem *mem,
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
2.50.1


