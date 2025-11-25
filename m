Return-Path: <linux-spi+bounces-11551-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A390AC877DE
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 00:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EBADB354FC5
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 23:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4252F60CF;
	Tue, 25 Nov 2025 23:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="Yc2zrCb6"
X-Original-To: linux-spi@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021136.outbound.protection.outlook.com [40.107.130.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E2C2F39CD;
	Tue, 25 Nov 2025 23:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764114067; cv=fail; b=DKYxJHocAePR9Xrt6d1zrlBh4gaDOExQPPsvT2YieN1Az7/uSqBm7bHsCKhC4nS4lNZt2UNvb57KqNX2eKjm8cC9WaIgdC90rfnYSvwwuby07xPRGj0XHSjY5oTr1ljjknXyKs0r6SMOYeCME1fuO4/gVBsxg3c5KFke88+jotI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764114067; c=relaxed/simple;
	bh=nvzSbP9vzHqZ9BdvDElbSy9zjtNy+EQ+e//hLD4/DeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VnoxoRCxyu7rDh5jGOlQOAgbvIw0ZLif7bo1Gwx1z63YxeyLzcb4XsXFYyYm1Ub+OXg52avQk2VGHkDW8FN2Ll8dEKfFTYfI4iBWNGBC9lINWWyZGMx4hG7azI90OOqJCWK3Y3tYHU4ZzfK3lzyX4nqT07XMaXWrY7OHu4Nq+uQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=Yc2zrCb6; arc=fail smtp.client-ip=40.107.130.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mmnsQYQIu5cp4Na224NPCrhm8XM9+v8V9imksuou8OnkYU/1WkH/EyhnfeYiEsPLtjxoW2prfDqDcCxvDB0mmina6BJaT0e0kA8nOsKjYixOfZ9toQWimJvhRNIBOFIlXHnJSm05Jf6uJ9iM8NtE3tHDAg0dxsqVVfaRnW+2BbUB9ROLJgDhw2qz8UMin1HOFSfS3humYinrGYGjfKHjKEIub5zTYNarX2RCM/KgDC0Sr2tMBbquC/rJOqjlVVFSxLWxUIzeikqrVBU6vPwNWfKqmQYgNjPio1DQQP+i63k4RUdCdnLu/Zk3eLgwGwkaW28mfZZ098JVSCp+45IRvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aj3KXet9skYYmZuJ1RFhi80JF8Ngy4LwP2uvVKLNgRI=;
 b=MXFlxb+KUgXtOTNnTXwYG/NgwMo16coSBnj4lwgfi/c9+kSbu4uZvooQnsU/HYeWfv+axm6//XJKpErMiiLEJbTmXxS3eeIaRPXsbYJf2YY1nTSlT53PiaFynG2zKyvVR7frzd0a4VchEJlAMPLsXGUFoRpSVCOGdRFTnn0xr7rn6GWqbC5p2AlHA1oGKIB3HOaGGA16fgRNXN1iIAwG7zhDHbKuETcZ62iWH+mmY7b880zgR+veUw/SEbgMasscgLuSX3xBJJVCne/r8U84jrof29omX9PDPPuuTGdJxZG/5oRBemK5cdYbIAXISNYNj0/O6R+G6z9JjbYSGV/HLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aj3KXet9skYYmZuJ1RFhi80JF8Ngy4LwP2uvVKLNgRI=;
 b=Yc2zrCb6Uul5dJ2VI2HqJGajlB9vrhVMHRfq6ARjpjHHOjmJsikNwWZcLwjQPvByQzu9/a0EqjUf8GaofxkFXOyE9CJZuEdhRICvydAPS4n0zniJLiWYxNmX1yQjHHz54PcRPt9gbmEqCciHY++S5JEhWnmdGAwYVxrujhrfvVkNLMNzp0Q5GWqtN3B1nnvRfMk21SCtjEQ6R30rwQUAI3h5hYsZ8JUB2WTIi0dTUD4u754dmtKnsizycrhorQYCu6Hqq2x13/ReaVRIZDIBLwrNiG4Fe1c0hXmJ9TWmOmhcy0yGSSX53Bl852JojfqVzn+cHFnVLvnZVIHrYO1Bpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PA4PR08MB6063.eurprd08.prod.outlook.com (2603:10a6:102:ed::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Tue, 25 Nov
 2025 23:40:59 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9366.009; Tue, 25 Nov 2025
 23:40:59 +0000
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
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v6 2/3] dt-bindings: spi: airoha: add compatible for EN7523
Date: Wed, 26 Nov 2025 02:40:46 +0300
Message-ID: <20251125234047.1101985-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251125234047.1101985-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251125234047.1101985-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0141.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::20) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PA4PR08MB6063:EE_
X-MS-Office365-Filtering-Correlation-Id: ba547f3a-ce18-4a10-c3e4-08de2c7c15a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N+YYYIpGeGbAJ9b4IQ7D4Z0L41K8u6eA855VqHnvExF063UjRpH9YACwmViK?=
 =?us-ascii?Q?CTtQ4TUueyoBteM+0TUaPRYeleKhhuoupQmmKe7aiAtSn25bJ7UrOWATqcmh?=
 =?us-ascii?Q?OUBUXhF9UTl4XgXmM/GlDucCb3lzgrrjz4Vp68nTjnl0R/YA3INdKuuqMSjh?=
 =?us-ascii?Q?rH93LH/kEQKQAUdzT3llRbq353TKJDImkVgbWGrXNDSN0G17jsbPtP4XUPir?=
 =?us-ascii?Q?V7vbQRUZmdIFMivxjhIAQcDprwxB5etLFmXXZcjz59cs1IVCcza4V80Eh8i3?=
 =?us-ascii?Q?KLl1/hwuPq9O2X0g27I71f7m305iWdt+wRDg8h0Tj83pfQ85ypDlufJOzl1d?=
 =?us-ascii?Q?3Wmo5zNWTGk7RVwqkZA7Bi4LEzOcBuZeRGhuDGCDLGsZqDRL9BWJ5fynn4Xa?=
 =?us-ascii?Q?h99JLgp8LXdjRn5UA/xrrsifxg1KTy+pUWzENFzm15uCnl2BcSS9kyR75C8z?=
 =?us-ascii?Q?64NzA+6S047d+tL8Kv456T8y5pelzjN+43ZP8aTyv1UD9gRCOAkO+KXNSrjy?=
 =?us-ascii?Q?TGbbvoUl8wiB1lZ9XN0UOf01TW2Eb5idaNtQKLW+p3UhEBTGQwLQdu+cUYN5?=
 =?us-ascii?Q?0HiQeLbKct8+L05n8XFmL16LVGA84S5p78TcC+pCvOI0WuTD4cmBWA4mNd38?=
 =?us-ascii?Q?GSxStgWmevuRQHFNtO1u2CwFooxnL3B48MYqj2ZDncHtLJBNvblF8MOykDWR?=
 =?us-ascii?Q?LisRmtld1mHfNQHHeNAV5JD0duSWl5vw1ctDUHD7yveEaDooDYcj54WB71tp?=
 =?us-ascii?Q?QmC2xJKt/vEt7ZdAgDAI/Bxuw9f+gfFOk9wRM47+PbT5OCtGiG4WR/EhafOo?=
 =?us-ascii?Q?XgquHBy7JJnfF2h5swDsTYeRpcsT4mJ4HKuDp9GyLJoi5UODigasiEtpCG8k?=
 =?us-ascii?Q?i1nzr72EIV58LyImyJnXXv2CyAFDwThI9itDWbsaT9NVpKtlHmTnhnavcXQT?=
 =?us-ascii?Q?t63cX1RRDoBK1tDiIxFLd4cDEDbp4AikypUB3snjBSwAwh54BXhhcLk31i2Z?=
 =?us-ascii?Q?KQH4IkGHbL1MwUkIHvn6MEpRp3+WopAsFgwTVACaQDJil/ObuwXyFdbkR8wv?=
 =?us-ascii?Q?ndEiNB2oqiFi68JZd7zZZii6N4gWaBcf0habRdYCmRMFhW9GCIZFVIyB96+V?=
 =?us-ascii?Q?cfTJgK7u6xMTomBgfcJlOLk1FLCuTmRETle7JLuRqFNvmCtEzCTpGYo4kmr/?=
 =?us-ascii?Q?dOR8WlqoI7NYqq5eQjP4FDz/BXyUuPt/kMx+5n79MJlbwDLj77pqecmLjEzg?=
 =?us-ascii?Q?1Gk58yUN9aeiPRiuG9siKfy+c5znSlXTTe1shD0k4JQa/WEXJPXRy1YownJf?=
 =?us-ascii?Q?RPyWAQyNDcG735mTbuNyYeAH+JskzYpdtD+uXzvjxIiHH4Q/FPoYUEMKlY5Y?=
 =?us-ascii?Q?j6Wub1PkS7PX4xdTdr7Lr4SXrG63IHf/qfYgE+wjw4Aoy/LY0NdxYe3zo50D?=
 =?us-ascii?Q?eIk4aQoMLEGHVKPhaSU+d/oJraM3/4EvdyX6mIwCjMF3FWiGmqwHzvg9GkKO?=
 =?us-ascii?Q?p7Nvs52GuxhBBFfa/tqJbi3sdEi0x6IREBn8bfgZMoLnmwfuWP7FVzQADA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/WuziU/pXseUZIYzAYoWMAFtw+UvuqHk/0N/WQhB7+uho56i4Ux0pSd2F9Ao?=
 =?us-ascii?Q?ZEYkv4A1QYhdaJr5PUnT0QxNy1Ds3IUihAaym1JwuUudLr1w2PX7yMGxn78p?=
 =?us-ascii?Q?HX77MTfSR6ybTl8VtXxXnD0ywNvMSumUrSz2/SG3qnSYGk2bugobCHSJzsyO?=
 =?us-ascii?Q?l0hdUznEU9Jx1Rgd20YLg5Ct1ilXDjD4R6IPqBPMZ4lRFeXaJRloDtxw1eN1?=
 =?us-ascii?Q?Ftf0qfOdWjMHtSgMDFSEpYvUGxi8cJk6/jS2B5gb2hwk42JjCAo9cdtLZxPf?=
 =?us-ascii?Q?1KSvMEerJYkVaPS0k3Efp9EWFFwRYwhKBnjxWeAZ2b5wzRC9ws6myTCKOZE2?=
 =?us-ascii?Q?V/X2Dk3WimjT0pWJH/qlcu5I2sgDwY0tzigqnFYe+yJsvhTde7VfQrfcLfNF?=
 =?us-ascii?Q?HFkEf9aWmZW8wHY0uYvTfLdGk6yePVPwqcHXjZagWSQui5tv2wYEGD1CIjU3?=
 =?us-ascii?Q?5LYqEJHg1yLORNtXGGlGMqDKOS2Q/GK3yUzv6Sm30l80tViv73U0vceSh7TT?=
 =?us-ascii?Q?vu4ocTb6O/GLncldmxWvNklkXT8boHPqZgAXpXyInCYDZKSVy8G3a+NDyng5?=
 =?us-ascii?Q?XOuJeL+y5FCAwf1a/8lBOk/EGSyv+mhTyUggJmj1poFQaZ+2brk1UQDVNh4o?=
 =?us-ascii?Q?yqTJjbRjLkaC8m48QnljI2BXV+cryx42k9CspkxErgr0jicGtJXwcwwu3No9?=
 =?us-ascii?Q?kiTnraRO8r1jxd3r9mDvvXh5aFoOPJHqkEF3HHrByL3hIpFNvQlR2tbvSDif?=
 =?us-ascii?Q?vU3aEuBIvVNNJTG66rggBPEkuw+B5bgf+fAl29R5OZTXBJLPSQWJ6+FSkFnT?=
 =?us-ascii?Q?R5xTDN5gtq6B1wD8sGnqNSNToJj6O60XdsPsE/BefNyCVrhRgNGiJeccotvr?=
 =?us-ascii?Q?Uz294AWv3dNLLkeCWfDJzGZizAqVO0gT1XWGENmcTR1X2tS5HSjXQEIBgBFS?=
 =?us-ascii?Q?ZuVJ9lCRFVp5001EGSfPj8Qz0+bVVV06TLG+qx3mVvje8smsQT1CLY9VDIey?=
 =?us-ascii?Q?JtCjZpsnBLP46zZCg1AMZJGfU1AwY9sP3vFrmlWCQXqHMYBwWFN30Fv0p070?=
 =?us-ascii?Q?jvsjzAqYCV1WyVtLQet3Uf6ZRTKRGTEJN3SWFgFNMXvHEeOIZ3hIw0fdpROU?=
 =?us-ascii?Q?/WOUd9iEx0V4ZRigeUa0EwpxzdkFaf7xOCa1blDw9QhD00V/0+2tIAOCUCTc?=
 =?us-ascii?Q?wheKdE2LmdOXNvFqu+g3IuXGh7wYYzlQRiHlkNFfVirxnv/hq38oA3mij2zV?=
 =?us-ascii?Q?CVRH69rASyTVC628bo+2zEuzRh264H6HVZmMyDVYhVrgGY9p8m2bCbwa+TLb?=
 =?us-ascii?Q?n8Vz0CrBg3nn4TEmLmecAOXsLnyyel8fWbiUazbOPPvwt+NHQukgZsNwU06Q?=
 =?us-ascii?Q?ovYq0igcZNQMnCyCBeyi39j6lGwxR14MwXok0Pek4TRmQ+mJvJFSTC0IjHXA?=
 =?us-ascii?Q?F4A1fBNolqLTv0/qNFD8uEA+hfQA0P0sc6JIW5H5IFQWXYxe+gDGYi3xCsyk?=
 =?us-ascii?Q?T8w0iMMq+ZGCflYlqFpkRs6ctKdpwWoo1CB0e6Yaju/TKCUY5Gy4iqO1xGRf?=
 =?us-ascii?Q?ypjH2ESrHf1821Ck3y8KBtW7o2cTtle2GAaj0O0p24DNKaJXyvGXuFvkgvUG?=
 =?us-ascii?Q?qI/XIbaPmDHb9Ln2zjGQFx4=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: ba547f3a-ce18-4a10-c3e4-08de2c7c15a9
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 23:40:58.8482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZL/2ORk3gaCqdTLM4mejJBR83rXYIuYtOLD3ie/1EzqRwb0p4PRe476hHcdLcY/G0AhTqv79Jk2jrbqm0MhMxnsgqgfCFN2SDN1Xs+L1R08=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6063

Add dt-bindings documentation of SPI NAND controller
for Airoha EN7523 SoC platform.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/spi/airoha,en7581-snand.yaml       | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/airoha,en7581-snand.yaml b/Documentation/devicetree/bindings/spi/airoha,en7581-snand.yaml
index b820c5613dcc..855aa08995b9 100644
--- a/Documentation/devicetree/bindings/spi/airoha,en7581-snand.yaml
+++ b/Documentation/devicetree/bindings/spi/airoha,en7581-snand.yaml
@@ -14,7 +14,12 @@ allOf:
 
 properties:
   compatible:
-    const: airoha,en7581-snand
+    oneOf:
+      - const: airoha,en7581-snand
+      - items:
+          - enum:
+              - airoha,en7523-snand
+          - const: airoha,en7581-snand
 
   reg:
     items:
-- 
2.51.0


