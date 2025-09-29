Return-Path: <linux-spi+bounces-10333-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CAE7BA87D5
	for <lists+linux-spi@lfdr.de>; Mon, 29 Sep 2025 10:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EFFC189D3BD
	for <lists+linux-spi@lfdr.de>; Mon, 29 Sep 2025 08:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56BB2C21C2;
	Mon, 29 Sep 2025 08:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="cWs72gwQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11022113.outbound.protection.outlook.com [52.101.48.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70802C08DC;
	Mon, 29 Sep 2025 08:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759136321; cv=fail; b=Av3UrNpx2CeTIUVCkTCz2MgCsYThbLcPODICofGVh9QdYfvYxbeHUn+NNBeh8jDPp+PdnWp+BzMY9HcIGfI2n0JjpmlbTpY/l3tQPNkidK2PbuZAHv27bFktuToypMiYyEMgI7StsVnhVCxEJee1d2OhbK8F4GPJP5PhavmTsdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759136321; c=relaxed/simple;
	bh=W3V7aZCDCEVXFxeaLAFKOJZXCNmDZRtJP81SX4bU7pE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nEfyFF3ScMvTHViCiJ3jtdJV69hYVLWdA9AUDMTnfXb0cfAPOFwjjeawShktLceYzn4MZldy31YHgm2fcWnLoly3iY2smZkqgrH7F6UNIk6ubOeyomETVVk+4G5+YK+pO0mjpSt+loLOJo2wr6E+IPTU+k9NYFnhuiIB4MM9sJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=cWs72gwQ; arc=fail smtp.client-ip=52.101.48.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vauDIEXv2krL7sJ+HOfEsKxo5L81knakjP542sF8BIBNB5sbcSlAclhBwAzxY31OkJRm7ozHREsTCFZ61DW10y4FH1CFvYwYKmp/4Y78e/OmdvxUzfQhdkdMsubZRon20J0ar+YwSiRr8jZ9RYjiXNDKbXkzEXEME+weFkYIs8bhqUIXqUx+SRGRvZt6v2j8snH6ou8A8/w51V48Slq/TcspddX5gEmiBrN0Rb/R9NP+5LDyKrbAVMbDNigFu15QIjO/lVGMpU5YDNqIp+MJFrCwc0U0Yn8hr61lu6ZGW1ghOiUIPIL1+50QphoWGwk7gIKo0KeemqZSLfmHNPvqFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xl95bTUTlV83yjMEHHx1/9TXDYhS2owNoq4IXEhJqKY=;
 b=ltx2XhntwiNuGeawMlVEBBe+6iZQQrQCFU/3qHxIW6YcAztmylZaDkcBXtnvlfUIQSWUhiDVbDMyTVCOWoV8cPk71coz4dbG7/jBN/wgTZf7PgCzrwgM1dTduADQaF3p7+pdLIwnybF1oq5BlFEaD25NlxeY4umHry3J0B9zHxz7J1/OS5862LPOp1ei4XcpfFE2fKIO3INqbVKq9KK9XYbyj9EGtQlrcmS7ss/YUeX379iobI83Vu92pFbo4HXgNtZUoDE72uvbs/GpFRQXufglcEvnERDHwySowTsp6UAOEhE6CjoG54C0ZxVHdUoEDzQPZy5r4jECtF8p2NHY/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 50.233.182.194) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=axiado.com; dmarc=none action=none header.from=axiado.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xl95bTUTlV83yjMEHHx1/9TXDYhS2owNoq4IXEhJqKY=;
 b=cWs72gwQv4tsavdBiJoVF4XAAhpOhPBLrm6QOF1xsPaC5qnsfynYJsil3BSqnizm5vZrX15KgkwTJq+NoVyF8IcKTcLDBeJOumnfp7w53dPcWuzUoSqiF7bLy5Sl5Onr7bs/C0ZN4f5b2X2Brqgy7WtooVAImvD8itJ9E3OeCimejXsXys0cvEOspKqWTtuLzfGl0xw70yunvR4H1I9dJrTpoZ2WMZu7TQkhyBL8bT1+rXli/ZE13qZmfl5RJW6wekfQc2cui8zSeiD04icu37a/NYo3bRAJP4iqovbhba947AtYjs8On/gG6iXJwPsT4IzV8953GUkpNI3FH6nlCg==
Received: from BYAPR07CA0077.namprd07.prod.outlook.com (2603:10b6:a03:12b::18)
 by LV3PR18MB5661.namprd18.prod.outlook.com (2603:10b6:408:1a6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Mon, 29 Sep
 2025 08:58:34 +0000
Received: from SJ5PEPF000001E9.namprd05.prod.outlook.com
 (2603:10b6:a03:12b:cafe::62) by BYAPR07CA0077.outlook.office365.com
 (2603:10b6:a03:12b::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.17 via Frontend Transport; Mon,
 29 Sep 2025 08:58:34 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 50.233.182.194)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 50.233.182.194 as permitted sender)
 receiver=protection.outlook.com; client-ip=50.233.182.194;
 helo=vm-swbuild15.axiadord;
Received: from vm-swbuild15.axiadord (50.233.182.194) by
 SJ5PEPF000001E9.mail.protection.outlook.com (10.167.242.197) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.9
 via Frontend Transport; Mon, 29 Sep 2025 08:58:34 +0000
From: Vladimir Moravcevic <vmoravcevic@axiado.com>
Date: Mon, 29 Sep 2025 01:58:01 -0700
Subject: [PATCH v2 1/3] dt-bindings: spi: axiado,ax3000-spi: Add binding
 for Axiado SPI DB controller
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250929-axiado-ax3000-soc-spi-db-controller-driver-v2-1-b0c089c3ba81@axiado.com>
References: <20250929-axiado-ax3000-soc-spi-db-controller-driver-v2-0-b0c089c3ba81@axiado.com>
In-Reply-To: <20250929-axiado-ax3000-soc-spi-db-controller-driver-v2-0-b0c089c3ba81@axiado.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>, 
 Tzu-Hao Wei <twei@axiado.com>, 
 Axiado Reviewers <linux-maintainer@axiado.com>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Vladimir Moravcevic <vmoravcevic@axiado.com>, 
 Prasad Bolisetty <pbolisetty@axiado.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759136313; l=2005;
 i=vmoravcevic@axiado.com; s=20250904; h=from:subject:message-id;
 bh=W3V7aZCDCEVXFxeaLAFKOJZXCNmDZRtJP81SX4bU7pE=;
 b=OTrdGaDNd1+61GOkVucw7D/FK7UQfAOqlWmVP3JRCSjb2y4saTIUHi9z65YadiJlQTRvOYXnX
 sYp1YBTb2w8AjXwjGH3T7DwipeYNSnkhTd/jioQLrTlkAKYqqoPSloE
X-Developer-Key: i=vmoravcevic@axiado.com; a=ed25519;
 pk=iiyhWhM1F4HlCbbW3I3qKZhPCE8JsCrDQMgCBRg4YMA=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E9:EE_|LV3PR18MB5661:EE_
X-MS-Office365-Filtering-Correlation-Id: a4e003de-0abc-4258-d97f-08ddff365ef3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V0tyZ1JxdXdFZWRpcVUxSmx0WDVqNzZnakNJSlZsZDBHR0FtNmlvdWdMRnls?=
 =?utf-8?B?NmhDK3Zrem5xSy9pUzJ5ZnNDU3BSeGFmdGxIeVhRWkUySHJ4VnhLclV1ZmJn?=
 =?utf-8?B?UXNncloxRE5zYWc0b3dUNDEwMkxBRVZVRE1Wc1RPRkt1RXZvc1dHcUpwUXIv?=
 =?utf-8?B?V1I1MjJoZlF6a0F0N2plZ0FWTXNPMUdMTXBPZUpoTmxaT0xFZE9KVHVISEtI?=
 =?utf-8?B?aEZjdWFhcHVRN2MzaEhGbkdERHA2UUVpeFZqakdSQnUwY3ZBdzR3UkxTYk9P?=
 =?utf-8?B?UnZRdmNzYlJwalMwUTFzWVlMc2NERTZxZmQydFYzVWZzNnU0eWxzclZtNmRG?=
 =?utf-8?B?cTdFVy8xRVphaVRJTDc1UUQ4S0R1VDlHR09vVHNwd1ZLS0RkT0lVTVQ5VVRl?=
 =?utf-8?B?ZlRoRjdLRy9rRmFTV09MWUZiZ0VKU0NhUWZQejhzUlRhVDk5cS94L1RxWXRX?=
 =?utf-8?B?YWViMm1zOHd3aHVCZWFpVlJwNzAzTHg0NklZV2QrN2tMWFRtaWZiVlBLbzho?=
 =?utf-8?B?cDhib1hYRzV2Z041cjdBVnRJdzFGL3dCcEE4Q3hwMDZCWi9Pem8yWEVxdmlH?=
 =?utf-8?B?ZENjVHUvdVNCa0VmSS9Cd1A2dzY0b1VWbUhkc291Wm51QkhHQkphQ09XTVpS?=
 =?utf-8?B?dHRSUURxZWwrUWxGcVh2bzRHNkswcHlUd1NMTEY5UnYxbG52S3ZDNFZBUXdw?=
 =?utf-8?B?ZmRBUzBUdjRGbThvN1VNMnZVaG9qa2ZLQXcweFVJQVJMVkZyM0ZmS09CNmZ3?=
 =?utf-8?B?aXpRMW5qRFdUMW5rOGU1T1drUEZ3dFBqSDRkZkFBMkQxTHd0U04ydU56cEFW?=
 =?utf-8?B?VG55SEJlNGt3U1B2V1lVeHF3MC9aZElQL1hxNWxqcFVRQ0NxWnFlalo0QlBZ?=
 =?utf-8?B?alpWZEhZVjVuQlgwcDd4bVBQVzVtY1hxa3RkSXRKS21nNXoweVlpdzhXOHVU?=
 =?utf-8?B?RGJEMm9RbnFPR3JLckVEa0NXNGRENmR2UXlRak05ZVNtdmRQTWw1QkVkaENJ?=
 =?utf-8?B?dWNQd0NqQzgxMlUvWlpZbWxvcndFTEVRMHAzQ01uZElIOU1qazhYbXN3SWhm?=
 =?utf-8?B?SmxNRW5oNjRzVklqVlhCbGwxK2ZTdkM2UHlDcis5cEsvaWdoSEtCTFFCYWhD?=
 =?utf-8?B?L1E4enNLNmNJWWpwRDBzUHN4QVBIWkVQU2VPSm0xNkt6RVhzL2RQOUtZanV6?=
 =?utf-8?B?em1wak1HTk5EMlN2alEvMTJva0lzR3F6a2ptM0dQNXRINHJIRkMxaU5oTWxp?=
 =?utf-8?B?VVFwUExYUkpTUW1pd1FtVVd1WFAwWk5LbTVuS1FvYTFTWHplR0xmMjBSYk5x?=
 =?utf-8?B?c055bVBJSENRTko5T085ZFpzWERQb1hJOXNWTndtSUkzZm5WMXpMdFpaQTY2?=
 =?utf-8?B?Wm1zZWdmbytHZXFHbzdsRFRxaWxYalZNV3VSWGFURWJQeWxEK0cxZS9PRFRG?=
 =?utf-8?B?TzM2bVVieUFOSE4zaXpRT2R4OWh6Vy9ZcGt3bGl1cnZoR2JIU0FHay9qQ212?=
 =?utf-8?B?YzhLTjJPQWhBSnIrbkhWNVc1MTBUVmF2OTlkTGtRVlhFS0d2dmFYMGJYcjRD?=
 =?utf-8?B?L1ZzalhmTmVMY2Z4ZjRSL0drTHNoQlFOOTJveTlobGQxQlZBRkJmY01xdkNT?=
 =?utf-8?B?UnI1aFV2S1pRVnRiNDhjNi8zWUZkSzQzUWt1QSs5TFdDcmlGUWkxS3lrUkZR?=
 =?utf-8?B?dS9vRFQ4dFhBVlA0Vk1nNkdtOFNMWmhCRVYzeE5RNVQzdXk2VUYvTGh2dHEz?=
 =?utf-8?B?OGpBOHpzSmt1TmtLYkdKN0E4VmNEU2p6STNiQ3dZYXg1ZS9YNUJEZWgvc1NH?=
 =?utf-8?B?RDV5bC9OZ3Uxb2ZwMG15VVM1VVNhU3k3UWhMNXZPYk1FUW1BL3dhYjh4L1V0?=
 =?utf-8?B?VG1odlZJNHc3Ukw5b1JiTDFOb1RWNmszM3NPa2EwUW5wS3dNS0FPeFA0eWJs?=
 =?utf-8?B?VXBJYngyeS9QWEp0Zmc2aTdqbHhHalZKbytDZ01mWGoxdmU1Tm03cG44WGd6?=
 =?utf-8?B?L1MyN2ZIWUxrVVNGdjJYdFBoSWpJdk1FRU8wdkxGYmxDemtSTVNaOFF3MjV4?=
 =?utf-8?Q?PVvSni?=
X-Forefront-Antispam-Report:
	CIP:50.233.182.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:vm-swbuild15.axiadord;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 08:58:34.2406
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4e003de-0abc-4258-d97f-08ddff365ef3
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7;Ip=[50.233.182.194];Helo=[vm-swbuild15.axiadord]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR18MB5661

Add documentation for Axiado Digital Block SPI controller.

Signed-off-by: Vladimir Moravcevic <vmoravcevic@axiado.com>
Signed-off-by: Prasad Bolisetty <pbolisetty@axiado.com>
---
 .../devicetree/bindings/spi/axiado,ax3000-spi.yaml | 63 ++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/axiado,ax3000-spi.yaml b/Documentation/devicetree/bindings/spi/axiado,ax3000-spi.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..34fa96778dfdec89bc14782265ec23c0bc455a20
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/axiado,ax3000-spi.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/axiado,ax3000-spi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Axiado AX3000 SoC SPI controller
+
+maintainers:
+  - Vladimir Moravcevic <vmoravcevic@axiado.com>
+  - Tzu-Hao Wei <twei@axiado.com>
+
+allOf:
+  - $ref: spi-controller.yaml#
+
+properties:
+  compatible:
+    enum:
+      - axiado,ax3000-spi
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: ref
+      - const: pclk
+
+  clocks:
+    maxItems: 2
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clock-names
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+   #include <dt-bindings/interrupt-controller/irq.h>
+   #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+   soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      spi0: spi@80510000 {
+         compatible = "axiado,ax3000-spi";
+         reg = <0x00 0x80510000 0x00 0x1000>;
+         clock-names = "ref", "pclk";
+         clocks = <&spi_clk>, <&apb_pclk>;
+         interrupt-parent = <&gic500>;
+         interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
+         num-cs = <1>;
+      };
+   };
+...

-- 
2.25.1


