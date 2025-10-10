Return-Path: <linux-spi+bounces-10557-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 557B3BCE865
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 22:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BC1C19E12C6
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 20:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0DC302CD8;
	Fri, 10 Oct 2025 20:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="5GMNto6J"
X-Original-To: linux-spi@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021092.outbound.protection.outlook.com [40.107.130.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6869F302CAB;
	Fri, 10 Oct 2025 20:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760129129; cv=fail; b=FmPQgQV1dHal/cZIRA1q95Apb0YPoojPqVi11nxEsCnVR/vzRVWtXBZpYzyON3/wEm/P44MdglsIOpZVCRm9ih7j88ZYE9IkrRuxO5Cqa0A2wi8TPtaB1Z7/U+jls+JjRDW5RPfyCXPR7HirQrIToH5KmdZry1PoEi1M7DZYaZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760129129; c=relaxed/simple;
	bh=E2M8lRG6zN/Y5R2EJPWZ8XXbtiAD084miYqnGi5jqec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ohJotzQPnH0P3durQG5cdw4yTnlbeMdgFxCJj7rl0Se3hTfzdBEdQkpN8fi+zFxqByA9CuEEl9F6FWCQvXXgyK/ADFpCYftwDZSohKlIUfbeF1PycYGc9nlxKTEW9P7TgrA5XM8+YkFe3Gq3VcXCxsoQf/zEmMWI7EejgeG00Mo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=5GMNto6J; arc=fail smtp.client-ip=40.107.130.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aDIuhFYJoDKj9VOHeUJlsYeMtx6Tl2C5J7S7QgbEdd2IX+ZZyoR4ZrHsUGdtfx0iRBMWIkyle/uDf499d0BBqmjObk25E855r/b1mFk+OfN579EkmzQJK2W4+lq2pvkOb0GmJJsgepdSZTDQLJGPq3xlsxTEXpoy48MLJcBBi5wvjm+1X9/JlAEuAOPnMQpQ4HHpaXUy6EPEZgAwztjj1fTI6kmIy3gAdQ/5dHQfatPzpXaYhOKlRYoFbtbmWGYtrTjmw9yFnKeXKq7BAfTzBwmBH2X91zz4B5tIGL72pNivqSgnzQjCJCMWasDLphsP3Gpe+XLOm0lessKQOwhaVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2snrpNrzRAzTOeqpJ8KPLiTOapJVIgdfhM9IUrv732o=;
 b=wBlcf4g2fv1dVvMIYHiJMnQFJSS98FdIrV9YvRhqJje5b5CMwLPhS0pUhPCjhfcALa8gGIrSjflHUwvL5pdFPPT9p3lPo+Qq8fLOLDl6rLrOujMJnDAl1Dc7eeYhwguB8Y8uy83s3vwM/5ocNMg0D47rs2VBhkR9Be7fbexUU1fZXB+j6RB5B5kno2sj92lVzmueK9+iABGHTbOoi/tsCFJ5bVGC9lrnXM85xeMBz0gRbueBmmbI5D2mbjFswAoiElBUgCyfPglivh40B1Dd6VEaG9rY1u5bMGBj9jfMIYR0bj1/qZkFpaUts6Tg7zN+EWQvtlXwKDxouR9GiB9PMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2snrpNrzRAzTOeqpJ8KPLiTOapJVIgdfhM9IUrv732o=;
 b=5GMNto6JvyLKlza3pShTaLlGEwcZ1AzSVwZ/87iaYccmCnq95XiTadoNbPHD7OkwlUQhuZNf7ydco66pR65ZWCSAUHlzSaqYyz8JGdvQdFk8j0usP/+JewY+KvGN19Du/3R0npZs6clb7b1wFS3oX2KUv0vsCYiHEhF5W60FO9Oh1+n33PywLElwFDo1gLt+aKyXTky+AeKj0WE04RxZL+9aDKx68MEZhtvjBukRyeJpC/Z95k+UOnTT8aFnbUSAhrIBox9N0l4q5hDETJhDxH2s8I6Qz5T5kB07etQUZ0GR1lq4+Z6q2bmHLUdtEvNqK5Ph8Ly5pW1jgFxN8ZQJsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GV2PR08MB11561.eurprd08.prod.outlook.com (2603:10a6:150:2d0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 20:45:15 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 20:45:15 +0000
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
Subject: [PATCH v9 05/15] spi: airoha: switch back to non-dma mode in the case of error
Date: Fri, 10 Oct 2025 23:44:50 +0300
Message-ID: <20251010204500.1625215-6-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 290f5567-8f8e-4130-fab3-08de083deaa8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C1cP9XWlRYh6Y3J+i0I+8TiNX7qfJmB5Z7ofJ18brb1A46nQBqsyv9cdzWCd?=
 =?us-ascii?Q?yB3B5cA94Ntdz4Dot3f8RWEqDihoptE1ZP39CZaGkOovLW5Kfjyh5X0mwgn7?=
 =?us-ascii?Q?42AdPQcnuPwceAzrLDA6R0pJ/JdL0Klx5qLxiBSdUET9ZFCcERFLeS33/eOd?=
 =?us-ascii?Q?nJF8RfG2JJE6Si8jAHzs+jEdEdzDGalVaLNzj0ehpWKes56fZRLtkHa42sJL?=
 =?us-ascii?Q?KXZyHF7gmFdW6Dh4VLf0FRKOzmajAoCjUZhL9uJnm7WcnCVVPsJumQhzE/0r?=
 =?us-ascii?Q?BcJpzZJv/6hQn6WgXm3zvebgkDmFufAL6ZxOmwRM9Xt7lKjmBU3a/+17D2Mx?=
 =?us-ascii?Q?y1qmkdJH6wkV4YLnwMCQY++uNSYjVr4F3P587G6dZbKF+flNVIKew7JkaLAg?=
 =?us-ascii?Q?SL5EKnlq+N9kw9wgeroMYW76Hzss43gY+vkyW59AoAVhTj4H6tkbNZVZ5zit?=
 =?us-ascii?Q?B0O0LWvv5y6E7BnXhL4K+8sjj3clWcwHf0R+Awjcb8EZN+K8iPtsp3atfpDy?=
 =?us-ascii?Q?oKkcTr3MkudvwwR/rkluL9Kh30/ydEGjTWY5nGu2vmqRAfCGoDP2XmCgoNlz?=
 =?us-ascii?Q?KTcvgLoLFeZtlbbt6E1zVLMAT7h8BO9B2UO5JogPlZMEUrTc3oP+I/B66fpX?=
 =?us-ascii?Q?ivoLY+9qC87e9/mqX7iiVd4rz6NVcH3+VfdXhHkHj+TewSxA+hWUvwLuclbo?=
 =?us-ascii?Q?W7TLttFLLZjTtMlmtNnppJ/+rNpy7KCLriQ6DF08esdw01e5jZ5nvdhwMuMD?=
 =?us-ascii?Q?1YImHC97IHvKkfi+wvxCu4kvUTfjjzLH3QJ+rpK8tWeaoKbqYBA/jGYwFODt?=
 =?us-ascii?Q?UpvmywwmjfII6Zv+NOi0ywp7WsDH1Q9uMOwRb+0XkIxwizux2hRYwBxAHntQ?=
 =?us-ascii?Q?cyhr27pXD6KrxoFcgBhQ2RnOJh0XHuLr8MM64kzd92fRzqfy1EQlpv+cnV6k?=
 =?us-ascii?Q?0yrAdeMcjkvshj/F+lZwUXbCx48zMWAT3ZqSNVQvEZu2UebDARqVm4su5LdO?=
 =?us-ascii?Q?W+IHMw+1CWG6vMfYOrFF3y45S7x8CFO7tHyvOjKhN3DhCaK0vzx1CDbWW3o9?=
 =?us-ascii?Q?d5DBuIukVR08YKlhVb6yb4QGMVKeAFnXkm/5xLW5Of6SoeBzgWSz8MN6fvIu?=
 =?us-ascii?Q?z/vDrJwITUHxDW51E2fVbofizcSY0jM3hY89/M+3smm5k9YzgQ8p3sEyLn4f?=
 =?us-ascii?Q?pBC2qx2wefmrQyWo63OrJ6TRVjXeHlGLgMaxvysDIJe6LqsKAb5ZbHOisTsx?=
 =?us-ascii?Q?Z3UMigrUxzIx1ONWcUgT0h0i39QUOA7Nf44S5CndtkWussaFiAUsDBlJWacl?=
 =?us-ascii?Q?0bP//PzCow5AhjJofr4pP8s5dqkZL7d9VFIG/FrXQs593314khQQEuueAJs5?=
 =?us-ascii?Q?YVLFDZ+3sp+kJpbgZ2+YtkZ542X82FyRJjEzHwNRU7cJRqTMMDBtTBj6nxhC?=
 =?us-ascii?Q?WGuxjuTl5V2d6iy8VUIPYfMOBqXJxjYSk5QkMSE4v7YI/KfNceosIGvgrQqX?=
 =?us-ascii?Q?ToHmJ9qHcja+U1y47SU5NivaOXUTwSzI1bVkzuCdnVU1QAgsU0nsUtxnhw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H3E+wrj8KSWII8uP3TnCwZdIh02+mTCzaRUAD5/9uUeUFIHKgTTQ9cqTNrfh?=
 =?us-ascii?Q?gZ2FGOwb302vIpd/TRFikyPb6wBoLeIvGYXBtq1eAnHxMgBqeqJm20Ts+Pp8?=
 =?us-ascii?Q?/8Q6K+BhWq8Pj0hpzy2vbk7IBU/+ChFxw3cV63CgE/Y+BB1syKbC/yN+LXzO?=
 =?us-ascii?Q?5gpshITDvxCcvlxIbnx+kU2obFLZYxKcVfCsRFNH5kYe+UDD3UvFBAL1t6zZ?=
 =?us-ascii?Q?urFs2eMU9Hf7dSJG+fnsm5tg9m3E6jRWbNhRk4r4Sr0t5j8N5h6Uy1u3Wiud?=
 =?us-ascii?Q?FFzImmpuLB5svQjJk/f2BJY300IfWPmjj3EDacz1ThIGq2Uvvp6qzJtB54G9?=
 =?us-ascii?Q?kYT5tqRb+TYh2U3VOprny3LA0sO6cyPKVrnrvJEXRmwmgVIq0Uohxld8WVDh?=
 =?us-ascii?Q?vXSsJDP7flNavQ5SS65KNkOf6/Br55g/pKNQBeoDcJR/P2AZzTq7H1p2yyWa?=
 =?us-ascii?Q?gvWEvMcwwW2UFQHsH/CxDPukwHIxv8reDJ7JhlS6y6adKbMgURtN/2fIhAPM?=
 =?us-ascii?Q?e74NCKxlYsPoSUzwMfZStl7VyWeR0aLgmnOp4jQGg/D5Gn7rqCLdLyaaSl5E?=
 =?us-ascii?Q?oKcTpqsqRpM9q3aDkcPA+iL1eGTsw3peEE0tZanoFaIwAQ6CPXfKG5I4BAU0?=
 =?us-ascii?Q?C/I9uDIueCLPbaHM1d+Y4L4eDwZeyOGCKC1/EmahRqHNvRFFsFzpEsAuwFQ+?=
 =?us-ascii?Q?3TxkCwZtNvwyBrQvrhgzUSoFQrE773Nxpc6fd8AgW70Z70FUYSS18ApL44Gg?=
 =?us-ascii?Q?NJhoxVWCWGe6ynwdPF1855UR6vZskPPlcpkoz5kGtfO1X/veT+nDfZYyWxYT?=
 =?us-ascii?Q?UkqKLFZ5ZIiu8zc2EkOu/GABX9HqGimtTLt8elRgNK+gofKDrOLtA+twV4XN?=
 =?us-ascii?Q?S+NjR08mbZQov+b4XQ1RyD3YSf3urOEEcty7GD4L5ZIBIu0plPHx9YjnInZH?=
 =?us-ascii?Q?wQkurwDr6+eF1XJzy+D7gUvsoswOjdLhCkaG+91RbqJRGntmHYvrNrykrMra?=
 =?us-ascii?Q?yl08kBl3Ju65Cjbstck+Q1qGTqc9FKVkKk0Eng/9CdFTpnMGFf85y6JbE550?=
 =?us-ascii?Q?ANAOI4l4QX8RmNwpcO0N0y7H93WX4Qglxuyg/RVnqNTBGUrcyq2UZ0hTS2rL?=
 =?us-ascii?Q?SZjDh+2Tjv5TfH9Zt5qI1G4koE9Pc9+C3A2LPkLCJfgvXk77L12gUbef1D+s?=
 =?us-ascii?Q?sEwMOm5p5vvV42sWnfjbUE1TbkZDMUPocB05vHdwD7viMHvuKGQbWFdeY4OE?=
 =?us-ascii?Q?IjxJKUkeGlXcyGwnU8bWXePEEn1oPY9LGSdhEHYfuqqEoFZz68bCYKEd9D9l?=
 =?us-ascii?Q?RKbXhGqJm67vSDLRr5YWCWBwLdSibiwOUm0/AWLgTSCt+aNISF6+AyN7dBRF?=
 =?us-ascii?Q?j7FPReJ6NxE4+LASGyYkin7eoQPEKgXCm3RjdRaNKhdUcrr1aJ0JV2UDMWst?=
 =?us-ascii?Q?KdnyUDpZoS4waYc756W6xyqIHbENpKCAUBf1mk/5eixI3I/RXAXZtqNJRVu8?=
 =?us-ascii?Q?06PxCH9i+zSa/aRfS2GoTrlCAdY1IceVcu4CSWv+nomSh2lzyY+EFvXmynMz?=
 =?us-ascii?Q?yL/EK/CoEHJy8n+dmy3vfsO/v/S6Jb85H3xLP0OSyizbr9DFQr0b2OJd2M7/?=
 =?us-ascii?Q?VBdsvzaaMdjJXRVirqRzbas=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 290f5567-8f8e-4130-fab3-08de083deaa8
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 20:45:15.8046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FoH0yxmoqgrB+sNRfUqI2Op6jjvILhY/QtVpYe6a2ctIp4FxaOLcpDjrQ7ehHrAKdFgp4SKK3Jrw92hsiDqhcuxosU/nOlCN5l1WLJ44bM8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB11561

Current dirmap code does not switch back to non-dma mode in the case of
error. This is wrong.

This patch fixes dirmap read/write error path.

Fixes: a403997c12019 ("spi: airoha: add SPI-NAND Flash controller driver")
Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/spi/spi-airoha-snfi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index 2d86dc62dbde..a39c3ab4af5c 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -691,13 +691,13 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 
 	err = airoha_snand_nfi_config(as_ctrl);
 	if (err)
-		return err;
+		goto error_dma_mode_off;
 
 	dma_addr = dma_map_single(as_ctrl->dev, txrx_buf, SPI_NAND_CACHE_SIZE,
 				  DMA_FROM_DEVICE);
 	err = dma_mapping_error(as_ctrl->dev, dma_addr);
 	if (err)
-		return err;
+		goto error_dma_mode_off;
 
 	/* set dma addr */
 	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_STRADDR,
@@ -797,6 +797,8 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 error_dma_unmap:
 	dma_unmap_single(as_ctrl->dev, dma_addr, SPI_NAND_CACHE_SIZE,
 			 DMA_FROM_DEVICE);
+error_dma_mode_off:
+	airoha_snand_set_mode(as_ctrl, SPI_MODE_MANUAL);
 	return err;
 }
 
@@ -926,6 +928,7 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 error_dma_unmap:
 	dma_unmap_single(as_ctrl->dev, dma_addr, SPI_NAND_CACHE_SIZE,
 			 DMA_TO_DEVICE);
+	airoha_snand_set_mode(as_ctrl, SPI_MODE_MANUAL);
 	return err;
 }
 
-- 
2.51.0


