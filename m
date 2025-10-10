Return-Path: <linux-spi+bounces-10540-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F063BCE5C0
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 21:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ADFFE4FDBCC
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 19:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6E0302146;
	Fri, 10 Oct 2025 19:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="qXSiipn9"
X-Original-To: linux-spi@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021136.outbound.protection.outlook.com [52.101.70.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD203019C0;
	Fri, 10 Oct 2025 19:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760124064; cv=fail; b=gh0Wbmdir/ZYUJvjV4E6CylKgb0dFSQaB2/Bsqj+n5uyo30pXxdyAoGEmqlYHByVQYKQa8ZcsZOdT5UFFOP/ueNOz1Q7PkE31f2/w7cjq4II0KF6nAmg610D+tPrLYUiUfbxaU3+NirU2eGtnP//JHUg9AzgLwzaoR/4pWO7s/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760124064; c=relaxed/simple;
	bh=ln9Uv+JjcDjysM4q50VJX3fGqO1QoWoTBi9g3lH9b7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GL6UjJ1loCaG6FW9IVtjoSXBURxlhfrL5uPmIxUXxmCtjIaLfn+FGCISeXZL3FVU7/B9j56T5MH1P/GTyU2fch/Cv+u//f86vSKUb8FBk9pqwqA3W5Bsdn5AHPjRlSkrpEwq8EskPHJ2UuvR+a6be3Ww7QkzZz6bWrj/DWZSNtc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=qXSiipn9; arc=fail smtp.client-ip=52.101.70.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zSGNLY3Y6goISU58q/7V5uaggY9srrgWqYjv6rRgyIutysyPZPSvhzFUK9jVKSY+co+HwBHrij5iBeidnGsH2YE3xfYzBzGHhUMOCgGgsFbXHDn5QJETKBESLDLtn1EKxVm0oNi7lWIJaf8veyMiv3bfjBhE/klVOF+sG347RRVlGDcQhIe2iBcP+qQQxo6lPoE4UcjNbL2JSdMcrDyymNgaL++azJidyCsdgwGE8zYYf1hTj9Wx3d7K1Rk3YZ5yIUbl00e8yFMhxuEuQsgWL9JZ++KMHODvcl/HviN+vBF/dJ1Os9apEK5rBUHLgKgfNClbkK2UuVEdZkgCMQvRgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oRs3E6XYJFP2n905LhT/DxgKVk6bbVkUK5bfx5yHGus=;
 b=aVR+WKqwTqFldMKtuOoypwBhG5Gkz3ZaVZ0PBn9IpvjBvix6tMlG7jwbaVnbLQpbfIh2dnzXv+jsRNS7hKizJP3nw5r3jPXNTiMgekHy39waw/FFEZdrmcDLGW7vAI3lsAOEQHZ0kwJEwvyqQ/52S43mxvz9noH0ZJwzxzXqsPs/bRR0IT93mYt3WFZloSahnTbZnHM7B6R3l1uN4cxJkqWWnxzrGk5S5qs5OXyu+L9hVuSs4jsymzU/2JDBNekIeWRWCWWJAqAii/KPyR/92+riwesKcPZAXZ8iHuQ3BBG2huCDERTefnfOCwYiAxfdU4QfNiADRVj8EgzlkDaMPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oRs3E6XYJFP2n905LhT/DxgKVk6bbVkUK5bfx5yHGus=;
 b=qXSiipn9fugwi22bVpqtrct1vgwJ8ynTIthXIj6OnPtFtGBoqvhVCqLYU3C61nhx1/s0sgbIoMbf1sNSsJFpCSdkFhFCXtgxrAKBwlvUXm+3sC7fIWssosT+8mJtDV7GqSVbZb2iJJTfTtJkW8klWXhsNlPkaffNyb/Z6StnsJtLhjDnGPWsZ+FWwLIREb17fUN+279Fa/0cyEdg9pk4TT/qUe53hwx1+typXWzJQdfS70VkHpx9so6Iot78pCZeY4mZK9C3P45vr9gQMhR/nSaZuGEa42LWk1QHhZpaurFXuYaPKTas/JBRszGsGgv8OC6n2TxDXSe3GO+LNqBLfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GVXPR08MB11352.eurprd08.prod.outlook.com (2603:10a6:150:2c4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 19:20:52 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 19:20:52 +0000
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
Subject: [PATCH v8 04/15] spi: airoha: remove unnecessary switch to non-dma mode
Date: Fri, 10 Oct 2025 22:20:27 +0300
Message-ID: <20251010192038.1592889-5-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010192038.1592889-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251010185940.GA715991-robh@kernel.org>
 <20251010192038.1592889-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0020.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:b::32) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GVXPR08MB11352:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bcb9b28-3e9c-46ad-f222-08de08322073
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UPiw/0Es/zBxrdRDXy57i/xofHZN6g3ZmYuwj1O225bQZ7inyoxzNTR9wTlN?=
 =?us-ascii?Q?wPwqb3xLxlj4R/p3r7M9DWuN3uAwUoCLi/jgZlQxi6DvCVpPrlBt93K+ghPa?=
 =?us-ascii?Q?8xZ1117LhQQPztRsdCZrpQJ7M/UoaYk61fPWIJWoUJTBJnX/vnQBh1nw6aDX?=
 =?us-ascii?Q?uANK6zb/AfJEHnHo8tskpmUCYq6ilQiWQaffdWU9zY9HM7tlo7N9C8wVR1ty?=
 =?us-ascii?Q?Q1RN6JeE7A7Pfo6l/TkKD4Tpo8gKk0qzKWk4BaFcYulvmNKlBaONw958u63I?=
 =?us-ascii?Q?gHG8qVPb/isMwLcaaq7L7hjSNcigsh3w4G+Nhan7xKILUJ8s5rlvhTFiKCIU?=
 =?us-ascii?Q?dBg/0wJyFppZmB8eI0os8z0w7AEFZRJdAPQ3L2OGatn4O4iplEblBaARbfl2?=
 =?us-ascii?Q?WhvnZzQ6YZqU0/AOES4s53D7skdtF4j/Q9UM+o/s33xOVzSOgnvpwWIk9cXW?=
 =?us-ascii?Q?mTiJvhmxawywseLQ+qzhjjDYANmxIgTsIbgmsup+g7GFKPD21tb89PzVi5i5?=
 =?us-ascii?Q?75rK7DhzLhZIHPRUAhFpruq7IeJfBhhaw9J3zzdVu32ffWeGTP6LIQyUU5k1?=
 =?us-ascii?Q?h7K0LJUpUS96FnNU58qfoFVAufjzhite3mXGU22zb/UxFcBuxT/sgbJOqfjb?=
 =?us-ascii?Q?1B8xcTFHOLxkKSJN9H+jP7Qet6aEq90tFBakZvRrvgYXDRMxWNDFyIUjHLZ7?=
 =?us-ascii?Q?7Ax0x7Cm4ZONA/0rITbyTS+pxZMMP7MQ/rzfUhKf/xiFoO65xgwi9ctvi+mA?=
 =?us-ascii?Q?XNDX/ExlTicvILcfY2huvsOzca0lh71JPT9Zp3fcCVbPnXcZfHa6cryeTuoC?=
 =?us-ascii?Q?T03le1bo9x2snAj7GvUi93Nyec3ftoyjQvZXYWvsxHWoRpyo3iGfs5TlZKXP?=
 =?us-ascii?Q?AYe++Es3/i6tvqhxjKpy7yeXMR+lWKU5Tx+1cIzrsMkS8v46y42nmh+mk44q?=
 =?us-ascii?Q?+VfyyGG/5KRoDxkchkS/r9FMKIimNPa//75AoPVJ8IIH9hF9tjfUUgZEEtQ2?=
 =?us-ascii?Q?bIM9nE4LJ6MtKTl7DzgGFEfzImk1Yrw/2kXuQy0DR5qZndHNvbHaqKGDk8Ht?=
 =?us-ascii?Q?J9r2/NIXq6HV5rBGlPHf8t8XTu+WN8LUnAhJKeRW0clqI43c2HKFaUpTD1Ce?=
 =?us-ascii?Q?8VhamCbA2Z4PQwiuHbnPCPKPRgnRudiVuBfB8CqJvsVEVVD3PJjXmjR/JPRY?=
 =?us-ascii?Q?nTvUiZw98GppSHVeq/K8Nyl9Z2Btnv5qO3W9lvUzCP/88+N8U3ss0BV4czbr?=
 =?us-ascii?Q?C8s1BqDMi7N9Su6alQcTCKGKI+O4O5YUMSybz4VLQH8pos1iiEvm/0Oil8Na?=
 =?us-ascii?Q?DnbFvdvH8nUdK5vw+k1yo+ByLnIOvY3wCRl8CdwUYq5UFb4k9HL+kSemYoP/?=
 =?us-ascii?Q?TLy6BImf2LvymG/dzXW/850NgZdFUYCjPJ52yRkdYm5ZN5STxWkePp3dJqrm?=
 =?us-ascii?Q?EDrpX4IQRexqLpK4jmdfIH6WkDmzrlH/wrTeLP4wKtpuGTglNfEbIxr+J6jB?=
 =?us-ascii?Q?tFbGbXy67iw8HXDLGYkBSXjuaRI1/MtN13NUDAm4LdXkb/knNqgHvr6UxA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M+UVU6lc5YwZoBUmyCWg8kS4Cu1oRH8iimPwSrZzOQqTHQpAAzdzaVACs18g?=
 =?us-ascii?Q?R8qmUvhqE4uVJMtAqSQKYsbooEEkm1rMvhzEvk8kG3dpFG8AXoNipzCXBWJR?=
 =?us-ascii?Q?q26goHrSrxOwGqkr0nydSs0WGl7Ky66SPZQl5OSiD1M/kA9YIgf2HRPiAirK?=
 =?us-ascii?Q?nXT/ru0N6+dNg2uPKZy/wWpaw8IYmcTPoXGrfjGtnpGamzPRTQMzVU4RpbLj?=
 =?us-ascii?Q?pEGXHGCtDMvaRf1bt0ZV0o8d3HtPMWIEpWxs6/ljREYCOYFRHD2zRkolXcty?=
 =?us-ascii?Q?SQKRlhNgDVWsEydfSIe6nPjoRdElfc01MgZTEsky5I5vfK8pr5S5O9FaTTYH?=
 =?us-ascii?Q?6Monf8x76Mvqo1zk/3q11Cr1jg0+UdHDGuqZ2SjsdQl02Lp4F7OAUxXB0SeW?=
 =?us-ascii?Q?NwWlJGy+iEfLX4OJt6osZk7e+SSEflhDUqdlrmv4cs07zAZcnEQV55ejqUQd?=
 =?us-ascii?Q?hKEnvsDAAnK5DYvViJdjjtwwbxukDT1wtpzrgGSQOzfge0WpM62HgUwXgsq2?=
 =?us-ascii?Q?HwrKdM+B4ZKQ3L1tZm7c8sZXpqgrDwdxr1kf3Xm7ITZqIdKqStE6iKMOW11I?=
 =?us-ascii?Q?afX7M+YFIp4jFauj/Tlc1afNQKW5sSGNFpPUfO8IYFbtNWPJsgs3i5QJPJzR?=
 =?us-ascii?Q?8kgSA6Vlrxw+0iktDn57BRqUnBHZaiq9sjAXJzijqiqGpiLXcMVU/jicnb+g?=
 =?us-ascii?Q?Niz08DdoQw7LzOhTW19q5dPzJZkbNfDeHG3nR5E3VeLX7eKcTI68uvgjZ8Ie?=
 =?us-ascii?Q?Kaex6qOWhP0lSHHWcMczbCuurIb+BGyGHZ6NTq0H6AhLRs6AtgzgJe+BIHsC?=
 =?us-ascii?Q?Acpa8XBIzzFKfdRt0GjH13IyRE+MlRMdb41wYizfh7/mUEwtJfnDyf/9nQKh?=
 =?us-ascii?Q?V+ZLpkSG0YFoAMe5mq1w8LYyFa71agHqyU9OwwjB2T38UyXCbONguIEYMDZ9?=
 =?us-ascii?Q?kf8oJS/Tm/MnCVUA1yxCKi25HpPF5hCY0lp+2ni7jNJgWWC5xfM/ZsS+pAr7?=
 =?us-ascii?Q?/RX4TsVQLSmZGVMhsvnDkX5aRYbhZXQG36efFx+7fL7xWP40xK4F49RHid/w?=
 =?us-ascii?Q?CvY0temlxzvr6tA1EP7cLk7iziuV93WIU24WPOKmoy01neGBUPHEVfzMjFNY?=
 =?us-ascii?Q?b95GNwFp5pws+ISNJ1MFdvI/B6Gyp+mQz6a+LhOSOAe7Khgup1rvq3UGqIrz?=
 =?us-ascii?Q?RJN1MtOIJH/mdFv8xBwFdyNR0rAMZfemJWE9kcWlWuFk0J3egQk4TyrdbIy0?=
 =?us-ascii?Q?BbAucREhMh+f0y3DADwmQmKu1OINyulBwNbpMSx/QnFL8I2tc585EczauW/N?=
 =?us-ascii?Q?XjwPibDVGC/P5T7lYalIL01Fu9QvtXvft4xNzsxGjk0jc2QmfLzHh0V3mcnT?=
 =?us-ascii?Q?SsfFbP1RglyiZaPDi0CLGkVCOiPLeytAtEofR92L4vdaqoyduUWTd0F1KsXb?=
 =?us-ascii?Q?3LN5E0BGLE8qG2huS7lFjxK1BKXYCwZ0Gh/h8EAj3pB0zGrd6K7Gh5d5scFt?=
 =?us-ascii?Q?S5Qx/j2wZCqK3nvcLPTnNp+P0vfbkfp32AGGdJU+GwwTEJ3/VLbaH3iIwydc?=
 =?us-ascii?Q?piiVTvSLqDT5DTcVGJJ1bMlG1wXvy97HvRoDCBPruHBA1WcBh5RpXUO67xEy?=
 =?us-ascii?Q?az5zObHp2rm1Kp+XfApaSvs=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bcb9b28-3e9c-46ad-f222-08de08322073
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 19:20:52.0759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d4C6e6n1BqacQzGyDkT7Bu2neFzNolWFJN9R/UiokpiYhygwyXGUu0p7eboTDep5NwOfmmuA7nM/w0sfqu8AOtZwATRjnW+441VRwVUrPls=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB11352

The code switches to dma at the start of dirmap operation and returns
to non-dma at the end of dirmap operation, so an additional switch to
non-dma at the start of dirmap write is not required.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/spi/spi-airoha-snfi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index fffed26ff990..2d86dc62dbde 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -812,9 +812,6 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	int err;
 
 	as_ctrl = spi_controller_get_devdata(spi->controller);
-	err = airoha_snand_set_mode(as_ctrl, SPI_MODE_MANUAL);
-	if (err < 0)
-		return err;
 
 	memcpy(txrx_buf + offs, buf, len);
 	dma_addr = dma_map_single(as_ctrl->dev, txrx_buf, SPI_NAND_CACHE_SIZE,
-- 
2.51.0


