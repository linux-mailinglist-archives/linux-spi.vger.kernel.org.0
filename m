Return-Path: <linux-spi+bounces-3734-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ABFB926692
	for <lists+linux-spi@lfdr.de>; Wed,  3 Jul 2024 18:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E17B1C221A7
	for <lists+linux-spi@lfdr.de>; Wed,  3 Jul 2024 16:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122691836D0;
	Wed,  3 Jul 2024 16:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="N8G6QWYm"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010002.outbound.protection.outlook.com [52.101.69.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4FC181B8C;
	Wed,  3 Jul 2024 16:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720025990; cv=fail; b=nWZKId7la2TFbCLONVkO9ECi6z4HFGOtfVcKghBLfYJ5jsQO47DzNXyAbZ8dxXDS9GKvznEzOeKq1t3FlXyBbbGeEERfqOHuwWwKPfIFzN2242XLdXioi9RJdpF/u2mYNN+1LNcIJjwH1jg0/SqLlOMzj5YhYfFB6psFYpAq2TM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720025990; c=relaxed/simple;
	bh=KxeI9dIDFo/NdOvOPm9EBo7G9s7a1zdQ+RgsqVuXaYQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=F0geiPLLXfBIsV4oWANaa7OpU8V5HWtYxcDPlnGbYJwKzrWBqZArW5V023XM9Xyl6nT+TINKbVmYDdU5BhyFhFzLHdzMaGB5V7PTFWqWsUpLb6jbnV7q5ErsQ94cTkYLXWog4aC4Vqv41OXDOtonXW9Y/VaZSwlF7IFK/PARpIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=N8G6QWYm; arc=fail smtp.client-ip=52.101.69.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I1sJglLAVgJgqKaIGGvq1osiZ7RYivthUr3WkyveKz26TnI0P/rHlitn6Fc/DGrvZcdrcbcM9XGhExhJ5pC8AEUbXdSGTsyrHRZlPEBatuBL5TpH89KuLaPdvvk3cN9JJeVuWXbWF8CMwZg8JnOi1OzIKsSWQqClyTW0mcfmyFf3xMQCOmB6vILeDD20Li0QhIX5WJMvLtuC/SXzkkJRl0iJYYEWYS3R4ai0ZRWJSlWfn9bwAk1XwbhVsTnnyf44OEac5lNreSGgC5WQRoTyqPuYSJNr9oN0xiy6/0mQCtkBS3+Yv/M9NCJOw+f80Bi7hZZn9wXJf+/xWzHwI29w6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o7pPFPkD9SwQLjURLCowIpcqvnR0VgaS6CKK0kzHI0s=;
 b=LH7IMLvuWoftrVXeTvoEj9eWtnmSgQ+fiZ640x13lbaHg9RCQsz1pLuJqDgTnMvyOUN+IOvpzCh17EJiY3zSqmxJUUEkuEkF8hTp9Ed7w195QriuXufuc/veb5j30ShlkBvAxS52ncBZ4H8iCEOBJbbaKzKzqS7T0U7tJsWzK9PXiQ0UlC3sc0kExh5LlCEukHmxqj09xQmOe/J+6k+gkR9BGyHLGg+OkCs6lQZOsJnVvqAEXHmrZQt6ZSk9krZiDiXrzdMZ6kbUJNgmQXdSFiEGk2H9pZ8V6HVUoQ0LPVzOF/4Yz+B6FZJOu+S+kU9Wb/Q5xb0a5MKFhp1doDZaqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o7pPFPkD9SwQLjURLCowIpcqvnR0VgaS6CKK0kzHI0s=;
 b=N8G6QWYmck25NfXFqfs6R8gj/j0xJ75eGzPii2dEP1oxfLSAMnlPUp6FscwhbPe3RaOM72ONLGQeEfU7jakCSLE2v9ZhesAxEpz5/fPyY/MExvlqU37pUlL5/OSiJi2jO+TbLpNwRhu74czxGzDBgNWZ9dEp6PQqTiOn8eplYNc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS4PR04MB9435.eurprd04.prod.outlook.com (2603:10a6:20b:4eb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23; Wed, 3 Jul
 2024 16:59:44 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7719.029; Wed, 3 Jul 2024
 16:59:44 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Vladimir Oltean <olteanv@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-spi@vger.kernel.org (open list:FREESCALE DSPI DRIVER),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH v2 1/2] spi: dt-bindings: fsl-dspi: add dmas and dma-names properties
Date: Wed,  3 Jul 2024 12:59:30 -0400
Message-Id: <20240703165931.2325807-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR04CA0023.namprd04.prod.outlook.com
 (2603:10b6:a03:40::36) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS4PR04MB9435:EE_
X-MS-Office365-Filtering-Correlation-Id: c6fcf8a5-3a7c-4bf4-d4a7-08dc9b8189c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ur6Av8DV0nFl47rKDUpGNDlqXz3btWA/6RPrab+9PSY4E8KnI3XWZrX0AZL4?=
 =?us-ascii?Q?+Ci68XpuFd7Owqm3a+FpbGRz4qpCpjD8gyDnCDWKgLsh4arrvgdh8PPPBMum?=
 =?us-ascii?Q?no4fUpLBGH4H5DbGBUgkPjAy75JCua33zsbWAM3B//6CniYmGPLQ8+Oo2glM?=
 =?us-ascii?Q?B3akrs6s8s4zeTFdUFMD2G32E0PqCQBIMkwKSYJ0I2QT8h1j6yoIjrlsGsFj?=
 =?us-ascii?Q?xtd1zgTr2WE8tvqyqx0verXfXGyu7xwtnSUqUrSy8IjkaPOw2pNmOO5Xs1I2?=
 =?us-ascii?Q?eSalzUwrhOXvMygTaYZolojlO7DL93OZSKOQsi4kUsg4wYgNqkYxAnH3TCiq?=
 =?us-ascii?Q?FUqhiPTQVKjEZ7Srw6T9P4Ofy7MDQ3/3jt+LNbH3KTJIuW8TqFruXqRQpzTf?=
 =?us-ascii?Q?YYHC8zK4dVANBCvmVvkZ4YQblUxjJ7ylX6QNFv5Lh02GDuhKF/2UOboM8HTV?=
 =?us-ascii?Q?B0DFZks+L48Jz+B7KXVQGsCSBSn7COmUPoS3KeTs1WN3jX1GpkZC8t7cjNy+?=
 =?us-ascii?Q?B7Pab7aZEuMIFWVgZSbwN4kv/ryhtsmLBvB/xbn74AEOePILjzDECSScKsMn?=
 =?us-ascii?Q?bQ93BGBjnRgxBvOMD37+r+R20P2wagBycFuBeRQ5cgMxTfhH6Sb2BRb2bowa?=
 =?us-ascii?Q?rp1k2L5rouidHk4dbtAqiYcZUeAQfSRy9AEl6Tuixb1r7J4WZ0JDBw6MbC+g?=
 =?us-ascii?Q?3DNg9X/kyis9yO3i5VESfa8Z5A9LaxdQ1O3L+ofWHFRcfrnnPMJ3k0J+advN?=
 =?us-ascii?Q?bTGSepQNrTyvjGVOxG2T63ZeWNA34m550y9OgJSI61fD4r4lm/rZUWxlxF0q?=
 =?us-ascii?Q?Fl2Hmf88L0XntAvKDAIyfTVI9Qc/9UkIa1rGLh5H0niaICECdzKxKwpSg5oI?=
 =?us-ascii?Q?8I3Drj9wwlkoV+2Rfa9h+DvYSd5fVhPG4x3tqKX7TVvLJvh2V9xFGsiGkl44?=
 =?us-ascii?Q?eCtNxeu/UBXrbB7yqdTbB1px7Sr+rl/9jGo1TTmgR/naxH/mN5qk90IjmHK5?=
 =?us-ascii?Q?QjlUM50lNgdfZGRBuYdRQYppCjlJm5NLAPoteLhvrODt3Oj1sLerszCxbSOg?=
 =?us-ascii?Q?Yqh0KOYrJt7JIk9N8qheZYHJBgqfv1n+KY54JyJrrJXAWxZtgnOyAJS3px//?=
 =?us-ascii?Q?DTk0gFiNpXpEVKmEr4V6FlGTG0WRM/t2CJvdgil/gJkCsOEks97IWnbe28uB?=
 =?us-ascii?Q?4ED6u9MucutEC7Bi4NTgmOnAJHYlMej4D2Ox/jOCJJNMqAarQS0iV5wavvFp?=
 =?us-ascii?Q?Wd1x3mKPNZfc13wrvQaoaDiePXSIzH6Ujh75mDm+A2a4FDS0B9xKPak0aSY4?=
 =?us-ascii?Q?LTBMDHnjnqrCrm8SFdXcSYlqp6nmm5466+X5Iv19hDjyoisdfWsjrJVjS3tV?=
 =?us-ascii?Q?RWYJqcw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AbTcH253pht+SStuUOwu6TBzi1Rb5Akqk86Q27lGZISgpkXAq3kudFOw/F0x?=
 =?us-ascii?Q?az7OBm/BHeEsTPxBrGh2zkUODB9RMs5L53Jckkmrqyj7KuaZDKz74xFbaQft?=
 =?us-ascii?Q?pU6MKYZJ9pHGYVG7uHXtGcAv0QEq5kVCvsHpYJiVOxtnefKcdGowLRePZKBL?=
 =?us-ascii?Q?z6axsDxsxiRwiFwcmRBBPN7gTwwNqmZ7w0EzRGYKZUq3FOn4XxiLYfdSFtxh?=
 =?us-ascii?Q?MtUYLTOCiyTHvM6AZIkkHXBSyNfcyFP4ym1MLuxVtcx1bAzp7aYGv42UaZjt?=
 =?us-ascii?Q?O3ghDab5WMN+DVYmy8yjtsgb6h05gTkGto8upLKfrc3YGogEW4tXXnP2QefK?=
 =?us-ascii?Q?ATqBDALApfIMQSk6QjEPSES0saKb7OgKnY1Mx//qgcOUiUW1cXJM0SSLjcSn?=
 =?us-ascii?Q?b4zKKUHPKoacgrB4zZ9GFLpz4ON92wdRrsYU5j0TIzFMAKmu3OUk7a4x2xp3?=
 =?us-ascii?Q?tJ0Nb1NJAGnUcXchgc8L/B6bqOv1GSLzp/p5B0LENnUrT6okMR+xCjIEY72r?=
 =?us-ascii?Q?UhucAqo5VzmyrHrAOjKk77F11u9LnN7RIxg87ICsYfJhR+K7Z9JLaHO4ddAY?=
 =?us-ascii?Q?d/wgTjd5QEl/oTqiPqd42WVLeq6tA022Jdwga9h7xfEL+Et1xm0CgT05XaBi?=
 =?us-ascii?Q?OxOGW4Xo8QDhWG3DHSkdeJld8xZzLH5L82oRKj6I0xS83Qg6yEFXPywu9ROE?=
 =?us-ascii?Q?wjO+vz19HJf68ehGEh0mCPZhd0+bv5oM3mao+/rgzwQD2cWRRGOjepBHUhFd?=
 =?us-ascii?Q?LjxJkeUCnoYCjaWnGeF4uoDeYdGflqNRezFUG2ZQuZAmBpnMXj6GJY8D1Wpb?=
 =?us-ascii?Q?2bPgRO1zPn5VSmQNphS812LXrHl7epdU/v5zVW1m+a1szmOB/J6Uf4F1MZX1?=
 =?us-ascii?Q?9noblKJ+Dxbcvrs/m6SpoV7pdGe67Ew59dHvIzRxeUMXMGel1LeWi9Z6oqPN?=
 =?us-ascii?Q?N6uX6yb/DWgkmY4cJmb5faOvXMIY5Arpjh4eaUyyiu116V0h7/P8Jxl6PXjT?=
 =?us-ascii?Q?UhkqMMhh7pscn68qfe+Lxg3rV2hcncC4u6eaU50jYg1bsLe4U5bVFP2vHojF?=
 =?us-ascii?Q?Tc7YaQu5yGCngPRi83yeKji3GdO7c9B9pBiyuu0bgjnoaR6iDBmOb//1RpGv?=
 =?us-ascii?Q?k0rldtSKx5+b/ndshtyP3LBbIJ+XGurnYqIzFF65d1meJTIsotep62bQKXqr?=
 =?us-ascii?Q?zchqyqTCSZaLpImD6wRxWXu8+VkhxwG5x4/wXNHPrixiW/bDattluElXfNCg?=
 =?us-ascii?Q?OTsQWv0MNyfrvGYAoyK20MiVmKSKP6rDc15iytMrPwkZ5EIGXRhU0W5APwxn?=
 =?us-ascii?Q?SRI2R5OIDEtNqr7hAb4m+ogdVRi+NUUdIUMf5vrEetTH8zwmCU88CLHh3MgB?=
 =?us-ascii?Q?OcJT+gpG3vHh/sJXOk/MlF/uUMpWEM2LjaLXaGyTQoQhhHQU/qLUnHJ2hFkL?=
 =?us-ascii?Q?qtbRC0V4nC3Kx8/u8C0WC/xQiFSl7pN1Ng1v8e3kNOIlfZZfWAqtTXm2Cxrb?=
 =?us-ascii?Q?u3btBi0RsBe8HDj+wdGgca+gB0FzvtfFIFcpqEMJomC07Z3O3ycFPiAdnGWH?=
 =?us-ascii?Q?OlJonxZctF/W/BHHBjQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6fcf8a5-3a7c-4bf4-d4a7-08dc9b8189c0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 16:59:44.6857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +kdEr+fsC7fka4QlIE1PnLsUm2IbqR6NidV1Nl/jhCBpuJLjx1gHM+/2/pONaeRyvlO17Baf9pzwycnwzioVVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9435

Add dmas and dma-names properties because dspi support dma transfer.
Fix below warnings:
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var1.dtb: spi@2120000: Unevaluated properties are not allowed ('dma-names', 'dmas', 'little-endian' were unexpected)
        from schema $id: http://devicetree.org/schemas/spi/fsl,dspi.yaml#

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v1 to v2
- Add Krzysztof's review tag
---
 Documentation/devicetree/bindings/spi/fsl,dspi.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/fsl,dspi.yaml b/Documentation/devicetree/bindings/spi/fsl,dspi.yaml
index bd28335a6ac86..f16ac22291456 100644
--- a/Documentation/devicetree/bindings/spi/fsl,dspi.yaml
+++ b/Documentation/devicetree/bindings/spi/fsl,dspi.yaml
@@ -48,6 +48,16 @@ properties:
     items:
       - const: dspi
 
+  dmas:
+    items:
+      - description: DMA controller phandle and request line for TX
+      - description: DMA controller phandle and request line for RX
+
+  dma-names:
+    items:
+      - const: tx
+      - const: rx
+
   spi-num-chipselects:
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
-- 
2.34.1


