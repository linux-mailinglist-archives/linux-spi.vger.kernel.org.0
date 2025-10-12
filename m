Return-Path: <linux-spi+bounces-10576-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FDEBD01C5
	for <lists+linux-spi@lfdr.de>; Sun, 12 Oct 2025 14:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 347BD4E4732
	for <lists+linux-spi@lfdr.de>; Sun, 12 Oct 2025 12:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8892737FB;
	Sun, 12 Oct 2025 12:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="zf6dcFBH"
X-Original-To: linux-spi@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021088.outbound.protection.outlook.com [40.107.130.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4986E2561AA;
	Sun, 12 Oct 2025 12:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760271446; cv=fail; b=Kt9GrtuhukXyLkwNtZEezKfTzMUKonnB1QnNINY0//5mj+H0qUJoJ+LxhTUEU35DoGjH6HmdQSuww66YDEm9z7OlsgczYQ8la3uNcFdmiVzJjs9f8ycm1JlDPP09wJTB6bu63llVJ0/tBNZmLforeVuS9nLM3hOoiGbI6xWpvkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760271446; c=relaxed/simple;
	bh=A1bSBGy2kZH8EFv3WwQRHeaHSvuGuDCdM/uEwJlCwto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iIuGnU6oYwknsDvb3uDpXegkq7SU3O/iDaK4yyxwOZ3GaBYl+MJPKWDeYkzkhPfHmd/LVCbKXMknyYgEqeFlhpluhb6LvWb0OU07/kGZGZpZx3jpOswPpDiHqlpwz7KNRnczKccKrOYWovbCi5PzCdaH0hN7CU+n5uoNCmsj5k4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=zf6dcFBH; arc=fail smtp.client-ip=40.107.130.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BAa1b141QWQ92Sk9TGuXb9H2i/IM3TiWZ0gTXbSQ60ZKgbNfgFyK//L1gEXzVnQLWARvNeEh5RleHM1pogADQGv8oL8PW2xkSr8dMhUFfEZ/Z+buotaOotek53BpY19MLQT5PLbtXBh6ag/lf4A0mtAhvv87dSwEnblYwE4+pr30IQzRauLLzGuWXituP+Tg3B2XWi16w7fdlI13BE/4B09Uqw7Q1reQ4qEIegcO4WXgpXAm48L44tTVt+6pct2/0BeInCPF4l1x6CYpPFj2WaFJvXfCXxe7GZ+ZjDn9k4f0kfcySpm6dCUf9xih+1ZtN19qzQN7ih2WsBbWbB8IdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DHZ5zpP9tC1wl8ucs9JOwOjBMT1xIexdwM8R+ImbukQ=;
 b=KWxlGp95jz5DUQzmBHNuYNbjnj59JBZHGru7IMUdSDA5uq6T76Mlfn0rwhOpVKpaSPTELwpb9nSJvXP6kHyWarU9zvcRO5vXpoHClAnGwmqdKWB6S/1d2zLeOVQnJF3+gTp+9599PavdsA6VqI1EPl/8x1DhA1qQzez4sihEC5Sf4b+pxh4Jr7rrb1YamNqpN2F+7x4aHcJ8isw5tGjEd3LnKU3lCAR2Z1zrx5+CabYp8ZG7QggdgbWZO07LMXieiKVQSraXd95ca3AxKpzyR6kWE/eWinQw4d0nfRVf3N5wbKF9CrinSqnLwoeoUylBd6rdLyplqcMEuZLy1tZCWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DHZ5zpP9tC1wl8ucs9JOwOjBMT1xIexdwM8R+ImbukQ=;
 b=zf6dcFBHQI7CfbMaToqO+Q74nTAYH0Oe3PeydohZsIwpGp0QQ6vuPTPPgAckcovJBjffniXSzl66F+K4QfL8Pp2V9wLUmZvL+xIuDKXDSPSmFa/azxxMXuTSRNS0pbOZRT4UBZX41v/jyEw2wfyF9yEihNXD/Oa6qWoVcDpEyqVw4EREudrdgeX4BgTHIRDpGVwz3MfuVOvHHPhTmis1Bgiq4itDJ+wZ2Efofqf4XDq5RkCGS/g2Q5mUHu8a2A9gpQDHHaxhVnrcRQauRPdnD9uFH8l702RdkqqI+pD/PTQf7tfpzeCGJMMxJZE1iZbttcS+bxVkkTNATjivVGPruA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB4PR08MB8056.eurprd08.prod.outlook.com (2603:10a6:10:387::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.11; Sun, 12 Oct
 2025 12:17:18 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Sun, 12 Oct 2025
 12:17:18 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
	Andreas Gnau <andreas.gnau@iopsys.eu>,
	Frieder Schrempf <frieder.schrempf@kontron.de>
Subject: [PATCH v10 01/16] spi: airoha: return an error for continuous mode dirmap creation cases
Date: Sun, 12 Oct 2025 15:16:52 +0300
Message-ID: <20251012121707.2296160-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251012121707.2296160-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251012121707.2296160-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0424.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::17) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB4PR08MB8056:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b4f578b-1dc8-4d60-fa30-08de098949c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9lX6rkcIDHm5WNJb5dirs2fw4Y9EPVTM4RNaPhgVF7kkIuCaDAw4Epq5qeq3?=
 =?us-ascii?Q?DYOoh6zMVUkbOgDQlhUX1cVW9Fso+Jnb346h6f14YEs+cV7Zo+gWJSojlNtt?=
 =?us-ascii?Q?2DjtoxFOD1CL/pV4t2PP79bns9HwAmbslPOk8O5oiBxxjpU5FwCKj8MSKzXr?=
 =?us-ascii?Q?aEiMlHfu54CE4EeJLaaNWsFFQDlZmRMNOTLSde9IXmcH7hz9OoKbAdS/v8ik?=
 =?us-ascii?Q?ZUA/eVro0SJyxwmEH9WBoM3YdlXamDXvbptkhH352cxFDhENMs+sv6hrx3Zi?=
 =?us-ascii?Q?22Jfl0BPQJ2YImGCAKFmU7pyOIwvw/0Sw+bD9dzfcXLMSGBq+ID7eWoQROHJ?=
 =?us-ascii?Q?A7UaT86E2gWY65N7NSP9OR0u05NmbSiedD6r5HYzXtBgdxuZpJqZ7G1QciCq?=
 =?us-ascii?Q?BBRYMhxwWGq+zGooH0/wCXUWfGDlZZFmbCTVmkx3R+g1Kp8qOzePLoU90UBe?=
 =?us-ascii?Q?eCNOA54FV4McNVhHA7PtyKns9roWo5CddnKHMtDJeQG8V36I5Je4alo3NbcK?=
 =?us-ascii?Q?GhPTN06pAu2D/4qDbmNmkKGZtssmAO/B0OKhgpnvbiW3Ey7+SHjIUbmPOBTz?=
 =?us-ascii?Q?RDhobLul1uyiLcfZBR78GGQiK2s3CWYpOdN41zdoMzZ/9lieFSAIGehsr7xm?=
 =?us-ascii?Q?mAnQ69oTy86qAyiAA6SLf6EUNB7J+BS6t9l5T3A6KxeSXKN1S02bbNMqqGsi?=
 =?us-ascii?Q?PmHstFV14RD8q2vW/caiGDzNiZcotV41cjq5pNgA3EEV3UsxFR18TmU6F6qM?=
 =?us-ascii?Q?eXcsR6f0J7VqIXPSetCRQRk9JA97D4LsIMrhcFRkPctvfuiXTqnpmmX7jaAj?=
 =?us-ascii?Q?9TayG0tTw33BKft952z6LUlMlROazLm+75j83WJZwiwIk0S5Axa33L1I5ONP?=
 =?us-ascii?Q?6zfr9trBsiqV6ydHWPNQiRWTq5vf5k6UdGS2M39iY27qni8cpeAWBicl1he7?=
 =?us-ascii?Q?Fo1eYWFhbHWWFqFrh6EjDrvwhvPZgJ2cc5sMC5mzDfpAVfgqyfps2C1kVOYa?=
 =?us-ascii?Q?hAmyxyd6rD4rhzFICA1xUhH7PKF0juG1NDwjYVfFndYwz+GBkeA80UQrdiUh?=
 =?us-ascii?Q?6inoFRvyrzsXkuJUHimMhHdW4KI74VMGbCR14WZiYdUBfqmWw11/x+rnIlBw?=
 =?us-ascii?Q?eCMlXrtpEqzB0fZjR6QCodvP18+GC4fvUIbpPGMlw965sVKRjamVCEXPBRzL?=
 =?us-ascii?Q?Mkw4Y/Ic0mMSLcFcH3uSpMxHtHGPCW6k16zrsMnIfCKU/TTivubv8DDMi0ap?=
 =?us-ascii?Q?Kf1q6r1Zhs0CLTUr674Mq09T52m75yFuiaXKCnrTjCG5ob/I3K6DJVJJwzbf?=
 =?us-ascii?Q?YJg1ZyPqKwu/nEN6SLEhjTHy3EnnW5fO5RtOv/VENu/cYmHF1wNeGNP9LddV?=
 =?us-ascii?Q?nZJtpmcFMbed1a6DBv5QbtGNDXC2UbLXxDkPdw3Yr0aGCPHo/6/hmdegvyk/?=
 =?us-ascii?Q?rTtYN9GuwIJPPYcRNWwt0HgXDcmEzGp+7oR9PEbZb1C1hjK4Wz5DMYHXkbWN?=
 =?us-ascii?Q?VfmD3T79WhS6WKleyyKs3CwaF0zLPJkDNJ7GkEugGa9TLsmDQ2prMO3Dtw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Y9CYaKcgOrBBPzU8NYn/8jx5QMB9EBWmj7v+ZJbhReHqMxxwLL6nkSPfy8dR?=
 =?us-ascii?Q?lTsAYLno3cAxXCo3JmL6DQsq5YAGpzA9Oe6zl3U+YlyniUX3qLS0nus61xto?=
 =?us-ascii?Q?lN17k5iT0cgQfFm8gt/Bzef9X9yATh7Pa9TQEEfuL3y/hsWKgwqhdgrgUwJQ?=
 =?us-ascii?Q?2lo8SuwJbCzjLeVsLO4bFKi4pD9T1aJ40eXroTDYCfXARkCXs8lp/84V+GhC?=
 =?us-ascii?Q?0KdqrT+Wwkv+kUW9Y9xINeO6jRnARIAKPdnBTmzDJzkMn2zYZ81zvlTB5mfR?=
 =?us-ascii?Q?/sCF6c3X7yuGKp3/edr/a5ZyGzPKzizPM01YJfD0lquXJvlyAP84/Iw1ZgoV?=
 =?us-ascii?Q?DFshjUsoAtNsquqT7O7UCtkbWKiGSBFGnXdYhaUrNXTLXb7U8enW5LacBnlC?=
 =?us-ascii?Q?pGqvJf7HztToGiMpvVzorXPpXPf3JpUtWkWlOF2jvLIoFEXJVwKk4CPnfHhD?=
 =?us-ascii?Q?Pi9FIdZ6rs8n/1AHzmzD2gZVyLkvnNRtR2b4Kp3wMhBVTfP/HzoCbRKRqMK2?=
 =?us-ascii?Q?JMCBNkw8LoqbwBHYtrfRjc+p7KnbCFAIGJU8OT35hwD0Jbe1z03/acc//glB?=
 =?us-ascii?Q?UxOgsQIUApq/Ea5IZpCnT3zV0KnaelOPskAKf5jImRNqpd7OO2OB5pBVe16l?=
 =?us-ascii?Q?oKZPt6MEWOEGfV0M4OcpgtgGfeE2LZgX2nW9k+aixlbrCpro42r6yKeYu7w0?=
 =?us-ascii?Q?5/YWfbEIyud2aIS2ibYXJ1piQCaXhO61W3wHGqPz5bHupHj9eh0crNdpqzQV?=
 =?us-ascii?Q?GEh8jUOmvBDl7aEia4rrlVZe6Op5JeaXToVLbnmI+lNqUhlp3akx6DRHhd4b?=
 =?us-ascii?Q?1/vC0ny1URSpHy78MRSmkaxKE70+1T5vicAdLsGRv/HFrgD23CPdJdyZyPoy?=
 =?us-ascii?Q?DxMt6OIEBXzXwN0u+POaDRIwYi9+1u7VPGA+5fVxYkLZXOXksbjNoySOt4Aw?=
 =?us-ascii?Q?8JPyzCYAr7jVMgp7TxrL4l7ENa3RzsIah3mh1+RLjqc3Ytou1KnnCGRTnz7k?=
 =?us-ascii?Q?unyzn8Eezj4NK7DBPfxf0BIljMKBVe03wAhbpIF7qxWGYa9l4biFxDAm7GHy?=
 =?us-ascii?Q?FQuqGurWlMFdyX7SKZi7L9mSlvWJVX2W2svszMBDHyd45zkbz/ZNsgDXTiGe?=
 =?us-ascii?Q?qRC5CyYdaa2mxKPwx0HX6vLMaWCV6IfeUBBtQgTgoqKBqGwWGKsy7EBYMVCv?=
 =?us-ascii?Q?3rSaIe8AU7qzwvN7HlbWHU7v05+0+xxfc0W9t8by2tRKyopyerxJ3UnDDqGd?=
 =?us-ascii?Q?pNAmb5PeM9WDPPVeH6rQT1ia+48CV/vVul4aUSOmV12ht/ae8wk87whmwy31?=
 =?us-ascii?Q?IYaX8XfMYyz5HlP4uKfaOnQERMJ/dsbL8SmvYQahOk7FOlqDOvHwyH/qPIB2?=
 =?us-ascii?Q?LsoieApehdpprXsL0TxczaqSjXtTebxM7OAnoi9/FmZxjnVm8LE0KKVIyNRk?=
 =?us-ascii?Q?PU6RdDdzb2Qsau/bNdszYeIqxZqWWvbK0x6AfalBZufMo7B7RsqKtxcQl7Wi?=
 =?us-ascii?Q?3jqBChKV9d4SsktxhI+wvhWM8fmrdKYSwdECW3YR9/IlvJjdQDvXS6R2O16s?=
 =?us-ascii?Q?V1R47OWkMg34CXKfOvIXl+JnpOQiodhEvgBaqtr5atF2Ant+8wVv/HsSN7dp?=
 =?us-ascii?Q?/w=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b4f578b-1dc8-4d60-fa30-08de098949c1
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2025 12:17:18.8130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l4LaHMXYWHmdFpYA+7lz+eTQ3vudQfk1yqOYJw6zHRUgA/gUGDJgFvGLGLs9WxrTTlHS+2RO6TCFgKj1959Absnh685Ef3GN++SVsmSeWGk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB8056

This driver can accelerate single page operations only, thus
continuous reading mode should not be used.

Continuous reading will use sizes up to the size of one erase block.
This size is much larger than the size of single flash page. Use this
difference to identify continuous reading and return an error.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/spi/spi-airoha-snfi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index dbe640986825..043a03cd90a1 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -618,6 +618,10 @@ static int airoha_snand_dirmap_create(struct spi_mem_dirmap_desc *desc)
 	if (desc->info.offset + desc->info.length > U32_MAX)
 		return -EINVAL;
 
+	/* continuous reading is not supported */
+	if (desc->info.length > SPI_NAND_CACHE_SIZE)
+		return -E2BIG;
+
 	if (!airoha_snand_supports_op(desc->mem, &desc->info.op_tmpl))
 		return -EOPNOTSUPP;
 
-- 
2.51.0


