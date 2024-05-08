Return-Path: <linux-spi+bounces-2768-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 631BD8BF5BB
	for <lists+linux-spi@lfdr.de>; Wed,  8 May 2024 07:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4FB21F25354
	for <lists+linux-spi@lfdr.de>; Wed,  8 May 2024 05:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00667175BF;
	Wed,  8 May 2024 05:48:21 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2119.outbound.protection.partner.outlook.cn [139.219.146.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7456C15E88;
	Wed,  8 May 2024 05:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715147300; cv=fail; b=ZQjMjHpjL5PsiqHoN8VdI3iVXZxfV+htt+NJacpv1PtNawMzjoG3cFuJuF+rK/dFvbWTbkevRSjv+jrHzoenJTJINguC84I7eMAsEan5yCIaS/s15EheCHNfJVPvVdtBcm0bhL0v6O3j2kDELBbixO7CCGn7LIlP/F+H6T1Hy7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715147300; c=relaxed/simple;
	bh=60T3JzxEly7EJthIA2DHI9T1Hg8voJcmZ0OEihuFC8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oESOJI6dzsN54joyWzxNiCo6Wvs1/W4bSV+66Cz8QmM3nDkcc98Q4Vfs6mzJExL7yhH23osbXqlnU+TJB5cXrPrl8KRrlTmghqSo8oQaKIT8UZfAfZnbdzLs+51//eqDeKbh7a1bJvu0eORGA1ZnT8wHrpza4B8fHytzlT4s8JA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WiEFYWyvBYe/g5sMVOLbdkFbeb5ypIwD/kzVpLP1x1lJV27VyJibMCvGgHica9rPSIj66DwfNaDYufxonTnx9uUccgF9lGljpqPU1Tv1AjfQwD8RtH2adjaH1QJgB6/Pde4M+E6uyIv7GazqLMZEv+JVt+YZOEQRR6iEdTdG2xMQ0MrVB/se4TvuZA9yfnYUTWJDOa+pfwnIZhu3Cft5Vu9fm3KuliNF2yogZfs8R8rKTQ7KhwGtF/rpT8TcEniQTV7V31YBjm6//mXonFZtg6BAWiBSp8CYCE4FurRW+C8T6Usttww5VebZvpUYG38CCHQ4vdFJvqBm2a7FARGqzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IoHuaOd4zqoYz+Zx5UM2D+r2YLaqJIvliBGIjPOtRc8=;
 b=UGBqUmmR27IP1xQ7jkQMtR4R2dvG+9839JyXAOXb1fzRgzhEYM+ZnRr4W68RfYgBCw0ZfmIp6KSpAo0wUPOZRJ3fC2h5CzEJZMGBdilKTl4IOn5VJGGcbmZ5H2AZ/luQHY6Thbur856BjuJwnq09Vz6h2nFdyt9ViVaiDNhsZlgGXNK76W5U93nD86/yYCMe+QxfjitmZ8gcwHyTIl2thxSSrzO++CFPuZF2nQo4nnqy13SAj9ZFw05CrhnUON9pF0L4GQ2pfT1paVjj7eTZKUzjRXOItGLRV7k7g8MOWcFiXeO+ZJ8z0Efcx9CsDr18mbKMZXFnOwmCzB8oK+N4lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1154.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::9) by ZQ4PR01MB1169.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:13::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 8 May
 2024 05:48:08 +0000
Received: from ZQ4PR01MB1154.CHNPR01.prod.partner.outlook.cn
 ([fe80::301e:ec80:4356:8b14]) by
 ZQ4PR01MB1154.CHNPR01.prod.partner.outlook.cn ([fe80::301e:ec80:4356:8b14%6])
 with mapi id 15.20.7472.044; Wed, 8 May 2024 05:48:08 +0000
From: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
To: Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Michal Simek <michal.simek@amd.com>,
	Lars-Peter Clausen <lars@metafoo.de>
Cc: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>,
	Ley Foon Tan <leyfoon.tan@starfivetech.com>,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eng Lee Teh <englee.teh@starfivetech.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 2/2] dt-bindings: spi: spi-cadence: Add optional reset control
Date: Wed,  8 May 2024 13:47:28 +0800
Message-ID: <20240508054728.1751162-3-jisheng.teoh@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240508054728.1751162-1-jisheng.teoh@starfivetech.com>
References: <20240508054728.1751162-1-jisheng.teoh@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0026.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::35) To ZQ4PR01MB1154.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::9)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ4PR01MB1154:EE_|ZQ4PR01MB1169:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a6459af-73c6-4840-9ca0-08dc6f227013
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bnwSRuoS8Tz42vzYhUEC3li585Q6P4qGds+Ga6cSyn/1Erw5e2wyR3NZGBS4aLTgNoalu/XzfwpWhZOQh4PB2Vsh+WeFrBHe0Kq6dM2hOZ05YOZY6yQlpHXY8i1YGB8B2QBZ6M0f46IXz0cXmj4oEzGz1yLh8q5SQOpHkyHz9zZpv62eEAEGQo4+/KBG7PoUt2QCKB5zeFoyL1Aoc+h5jdQPXnfht6TbARy/ypJ9KvCot7W1+E4em4Xb1cMBjTFK9ozBfSAMbJ9rdtXzKpj6SlLsOMmXP8YSNkboyQe/Fz6R/t/RZuMYUxFpJ1xAgylGgYdYtSb89OXSqcoqSAJIXPSSPZq+DHQ9irj8lNrIS+dnlpOX19Y8r/+JcrzJIhcSm4a6lvm3cmBD4IF5rSq0kuWGxGmWa8A6CJqugXibjQzUC/9nIOWWAVaxae/CvR4kLyvLpbm0NPQ1/iwpCEKBWSenfEYtBnpIAymGFVAtZ/2qwW/v8z4TAvgKromMiH7tpD/S+XGz2nkHnKXtt53VxcU1N2gYxA0hrwCrA3+o43TTAuuO0L+Rao9Q0zCiX61gow89U52R/XnHjx36JPemVH+/a81YCZA37gezC5C5UbRTlnUKUtF7Lg3ZHzYJK74o
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1154.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(52116005)(41320700004)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aBqbaMhhBLklSFSGAJphtoZJpY6pC9DNrOp3oeTbRtALMrOBQD+T9dS5L9O0?=
 =?us-ascii?Q?KGSOtsqd2hqTRxf5pEO6zksLlmTgmsHx309z8BgceCmNuUYGbDnPYJkNhn5J?=
 =?us-ascii?Q?tPr4H/WGzf9+oa+PwDfKMzK3x85OM9PHmLvqhsO5pFSv9yS4BDF536KYGiVu?=
 =?us-ascii?Q?dE1FcghMnoOQmxAmDe/qCJx7FDc86eOiDBSte4wDI+CHPwPe0ltPhYANs8Dp?=
 =?us-ascii?Q?jukr8Wg7FpSc+Qep3HeT5bOUJR88BwEVtwNTr4PE0G6EE5DHA4d4PQA1z4MW?=
 =?us-ascii?Q?V7vx1tBVPHXUGVjNIaY6HTA1vS3mJqt1UVq+YuI3CClYZBxie/DwJlMD/hHm?=
 =?us-ascii?Q?gO3+jjxHL8hutIPsXKKkAKwXCk4b42ll3sJ0OjO/MSCYtoLf48S4Uw/LfFUl?=
 =?us-ascii?Q?XZ0mU6N3Iq715li8JK2R+lg9i8opiBYhY6KYJ/AkB54VWlW7fpVCIDlsKPSz?=
 =?us-ascii?Q?yF50TnPTZKb3OmzRCk34C24d7nLX0Uya56yYx7Bq2lkvhJultneotMAK14mr?=
 =?us-ascii?Q?rcS/mAkt8/2f4du32gXvrKemj5nVydrDKODdasFdWCFHsZKVG7HvyiCKbbFC?=
 =?us-ascii?Q?euGiCKGMch4raDZY10L4h2JE+9UST6yzyvLwtQCWMamjiOf4jUuSlj7go2BU?=
 =?us-ascii?Q?v2pMqjND7QHADSUnjj6rkureKBeQiWt6YmCyfMeFlI2LjCuGFG3Y92D5xv+w?=
 =?us-ascii?Q?/JPx+zFjDb++1uE1PmPTvodYegaL+yWyJ7jxw5U7LJB+uEdX8w6WWFwyv/vf?=
 =?us-ascii?Q?cnBEdcCZkpk8utsT2MxbHeCnongGwTdZM4FmLoOLL/FbEPlCz0y9hz7fwU8i?=
 =?us-ascii?Q?OoceqlWv904SGW4EW/U3gR1vMAvQlPSasVPB6kwxe7GwqH32lNkDMfmAaTpk?=
 =?us-ascii?Q?OfEGxmxLP3V+H10YnwpzUxuEjTaIOTOKqHqIQ1nUdkoBOs7DIHcoAcpcqR0y?=
 =?us-ascii?Q?TwoYrdAeyiLRldVZyUTI1mmkQ94sbKuKuv9EOWZ2gMqFxvfClLEjidq9PhYN?=
 =?us-ascii?Q?3QcR2n/Mjs6vuleIJ0ArxsgcHm3et/dWdyr+c9IOsNp0GT1ZyywEr9dSf0/H?=
 =?us-ascii?Q?cBeWhr2/G4fHZ2bTWxkkNd6n4xkpuA1bIhEMUt0Vq7QZ3bmrjn7xiJWAe3SF?=
 =?us-ascii?Q?vWU/8YB8XQ+yhzYjIFiQWcSEcYoNaYH2vanURD/Cl0u5TCYsny8pXBo2xG5g?=
 =?us-ascii?Q?V8W/BmeSqdQVA8KvSNp8hHnnRdGH06tCVES/OsgLq2Bo6mj9PDk0jVXbvJts?=
 =?us-ascii?Q?YCLVSXrLIvAe557O6+ud1ZNE18sSt8zuInmz9zA6sbGanLF6NCkwWGMYLmrs?=
 =?us-ascii?Q?Wy72TpS7LfK04GbTF+N4ArOb2QhXJpyTmpQXxjShLPitiSkAXHJTFXnYJu2t?=
 =?us-ascii?Q?jhMD9ErULcp7kg48V28BYJPTCARcjFipWzmj28sRYMmlyEMGfUj4gy6QFfRb?=
 =?us-ascii?Q?9lUJ4rKIZE1cQd4jkVdE6IEjEPZ5Gy9H8hVio6fG933biq8tjiuVj0i69iFI?=
 =?us-ascii?Q?xJwAbJtaNsdTkFOdEg4KrE4Jh65k/L2UkTVC+lO5OiQH+S+NBriVyf8N1hYZ?=
 =?us-ascii?Q?6kN+7GW+CLogQ8pUuLFgHR8kfyyTzVhysCEmhWpTxt9S/z1maZwulSxW72Ts?=
 =?us-ascii?Q?hGOI9ZtSCwujpmPAnrdHOpQ=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a6459af-73c6-4840-9ca0-08dc6f227013
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1154.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 05:48:08.1249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QLT1EJCd+8H5SXZFd+VDI6UY41xpZHh7qUpRFpgVCWStMxrHJeQaP0oED4o2NKlLA1r97Y7PFBC03wnH3fefoW24MOvR7YCblw6Ij2lYpO4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1169

Document the optional reset control to SPI.

Co-developed-by: Eng Lee Teh <englee.teh@starfivetech.com>
Signed-off-by: Eng Lee Teh <englee.teh@starfivetech.com>
Co-developed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
Signed-off-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
Signed-off-by: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/spi/spi-cadence.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-cadence.yaml b/Documentation/devicetree/bindings/spi/spi-cadence.yaml
index d4b61b0e8301..8de96abe9da1 100644
--- a/Documentation/devicetree/bindings/spi/spi-cadence.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-cadence.yaml
@@ -55,6 +55,13 @@ properties:
   label:
     description: Descriptive name of the SPI controller.
 
+  resets:
+    maxItems: 1
+
+  reset-names:
+    items:
+      - const: spi
+
 required:
   - compatible
   - reg
-- 
2.43.2


