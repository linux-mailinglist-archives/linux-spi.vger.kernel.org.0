Return-Path: <linux-spi+bounces-7469-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 212D1A81A45
	for <lists+linux-spi@lfdr.de>; Wed,  9 Apr 2025 03:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 218AB465C25
	for <lists+linux-spi@lfdr.de>; Wed,  9 Apr 2025 01:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3711513AA3E;
	Wed,  9 Apr 2025 01:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="akE7RZUy"
X-Original-To: linux-spi@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010010.outbound.protection.outlook.com [52.101.228.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF8A29A2;
	Wed,  9 Apr 2025 01:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744160730; cv=fail; b=JyJaGHI8Vvwcv69TN01m1I6LAGLx+PB4k1yZEEcjsqrvf5UFCapzjero7E+zkBeIacONmhiRO/QhlNdA09ZALAFWX2ZlXGseJwh5VffJKHYxP6qRr2R3Wx3Cg6QlHd2POTx4cQaSJs969Sh3DxGdz2rPcnfLc+/qF35oRuO1H8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744160730; c=relaxed/simple;
	bh=5RHehGzBlZOmJgVFHyeR0x6Azh5hG4RDv/DT4b8Um0k=;
	h=Message-ID:To:From:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=YBG/z2SjpAQ+3cmOq9LGf1uaz71FytZsM2DFEtRXPpADcB6/uyggfCoies4+1AJHotQREuo6NOXm43mONhyhXYAIAlkvybxUfX4tfe8RqrH2iAqIXUphPe7G+u+E14KoBxii9bh132Ohvp4zf+XW5ya3dHaFPnI4nXQVcR26qP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=akE7RZUy; arc=fail smtp.client-ip=52.101.228.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OEv/98sJx+j7ascN86Sq+DsaS8uaZtx3krFsWNSrNdE4d4O8nDnRvFaGxkV+XR4h0/3/wga+KgXs0RLwOuOcjXaFewGi0glz6b4Ehnn2IOxc43bJ4DYJXZSJExP2bsqoAHsoX8Va0X8P9Xr0fRvtG+uKU8PQlZtomGo8xRCuk+NkU1k04OFy58Ow7EjZRBHYCo3SCIhXo8BN7RTva3HaaGAWgzbQWxt/SxBkVbUceXolC4AHEVMjJ1L3Jq1BfF7roepUQmtAVKpuV8us8o4epAaByr12Jt2xD5eIuUa6crCGm0GhZBomH5+U/A1S+OUHnPFFRwMjnFwGO/6ndtxi2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+DZ2Y2+fZJt8mKSKPNwSHhs4ctdr075701FHoEUUA9Y=;
 b=cJfy0FMGwywea21EEcTCeRXEzScoIK9KhmMuQyvVqGEHTs7kxc2dOLjTTKFsrDIW2IMhH9ddsnwAz9bQg3QoNCtTHuj9fWDpGQ4w6zPoxCHUO9fGja90AaP9vCDOANvKIfg8nqsjyAIdp45z0LXjF2lOLklRhm5t7QM3IFFPmrikTdoIQxw2gUEysARO6DdlDQpwwNZT1etSVKf1t2K+xDrcTaIdX5xV3UN4rcNpR66BNUcvIiqSY/BlYjqyrI5MPVYPb4K097zzj270nesVhxsb1l13PvZEBbSSoT1sCzePj4Sq7Xd5mFFebiO/yO8mfkYONOH8M5rSXhqN04EF+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+DZ2Y2+fZJt8mKSKPNwSHhs4ctdr075701FHoEUUA9Y=;
 b=akE7RZUymjAKCpTO2E1AbE430hotD2Jbm8dpBwNkEWtrYxXvoamdvIHqykMZoPY5CFrJM7nFcrsRddRM+atraxdw6wq0y8T/DirTK8yx/yHDZVb6v1hZ12GWqIbd/9ylBUY18tJ0/V8956aIc7kbCtrinyyMxsNLy/E3SKPRPuw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TYVPR01MB10623.jpnprd01.prod.outlook.com
 (2603:1096:400:2ac::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Wed, 9 Apr
 2025 01:05:21 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%5]) with mapi id 15.20.8606.033; Wed, 9 Apr 2025
 01:05:21 +0000
Message-ID: <87y0wa9mb2.wl-kuninori.morimoto.gx@renesas.com>
To: Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Jaroslav Kysela <perex@perex.cz>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Takashi Iwai <tiwai@suse.com>, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sound@vger.kernel.org, linux-spi@vger.kernel.org
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 5/7] ASoC: renesas: add MSIOF sound Documentation
In-Reply-To: <875xjeb0wu.wl-kuninori.morimoto.gx@renesas.com>
References: <875xjeb0wu.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=US-ASCII
Date: Wed, 9 Apr 2025 01:05:21 +0000
X-ClientProxiedBy: TY2PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:404:a6::14) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TYVPR01MB10623:EE_
X-MS-Office365-Filtering-Correlation-Id: dcf67cec-8d89-46a4-7298-08dd77029a03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KLAiQxjFGFUtkxPDiFuRIMgYhL9tv5ZJAT1BzxWqlTGLKdirRmEXFIczDKgL?=
 =?us-ascii?Q?AKF5au45TELDpX2eaCTx0iX5Iz9LJ35uP342RifMoL4xwOgx09XkYM5vmRLC?=
 =?us-ascii?Q?jK/MUl7V4NhoilnaCHGhzFtF09xV5rsxEHNa2eX7x17lQcK3kVscKB5ikoGy?=
 =?us-ascii?Q?HcdG8KsQqTn8ApImqTKK5OQYoZVGqRlUTznNFE6C2APnaVtD48wNft29nEzB?=
 =?us-ascii?Q?nS8AxLAFj1gNnhPER1Zqifpi0R4O18BKmH8oMjZh1DO71feOf7Yj9z5VwFik?=
 =?us-ascii?Q?uTmaNZKiD/oWYDlj3QX61Btniun7sCoPUTg22NjoxG3nWmrUJjo/SKdFcIGb?=
 =?us-ascii?Q?1J57bFsVZap3g1uMANSuba3Jt3vM5prGAG28gwaJ4NT6Ay9mXrGVECKRlJY1?=
 =?us-ascii?Q?oj+vFMpT/nwz/2V6I8QGkZij5+RtThGpRKEQAD4ZAVGZ4KZnblJDinClAvi3?=
 =?us-ascii?Q?0Jm9a26AKhMkRZXuJCVN4lHpPutn0NwZLtmYCZCQ4C1ULoPz4XqvoCZ7cOIz?=
 =?us-ascii?Q?JF/rYstZHScel8VWnFvBU1F3sB4FGcWlDlvax/UhYCCJHt7XtFZ/W99mI3ND?=
 =?us-ascii?Q?GUBTgGUNZ6vkiYDfOr0a89xlmH87MyitwJ5Xp8jUfNqEHUFvGqhCYkJlDSni?=
 =?us-ascii?Q?IMO2JqHtjXhgfjwRSNA4mgbVtVQjrDdpGjRZYTNRf+AkhQMCTVr1GThDrf5R?=
 =?us-ascii?Q?4gCtzNEtOU0+wdNQtQOVbzlsuJI1+ckzgX1tOySF9sWfS0GK7NCOiAhUS8ta?=
 =?us-ascii?Q?RBuYvjVcRh74Iun/a1Dle/X9o2JCbuELUQ6iEPeMsKoe+YgjmNUqt8oW8j6w?=
 =?us-ascii?Q?LOY7tosrnRSyiQ/evKpW3ATJzCAiaZRbAxSijplNPISplGNMoYf0ArbrqbaE?=
 =?us-ascii?Q?8qCXlUgQHjAzSOINt7xH8FnZcyqUGNgD1lpSArwm6qDLE9/oPQLHLWkvvCCx?=
 =?us-ascii?Q?GE055/jemU8WiHFgo4RTA8FoxFXBqFzSgY5AMdOGdx5BfzQWDFY2JUAiM9XI?=
 =?us-ascii?Q?BUyDeG3jUvoqLSzeDYxEm/nvBftPL78N8XXRp0wFJZ3BXbRVGxeh4Oc/PAOP?=
 =?us-ascii?Q?pH6filCvfgf9TP2ahgI7H4yTdALeyf/TXQpi6yl6ittUWs1ttTqt5uNUjm1u?=
 =?us-ascii?Q?+OU6J4Y2Yug4IGjPGRwyg2qw+7vd2BVfQ4IovrZNo5PAgiQWGJD68lET8q87?=
 =?us-ascii?Q?qvOVlv0yXUpgX3G/H3YX+OjD+CEWJJ+CDhBPxW+3g/vDxsO43x/esiKgp6de?=
 =?us-ascii?Q?lJLaBYsCFQzoFErFhW1QBv3LxnTOgPg6qQ5fQa0Q4qCY1ccc0D4ZITfElYVc?=
 =?us-ascii?Q?1QOykYkoLgbOaHso7SdT55OgflzmlRnIJWDVF70xN0cbtBe9OI0br9m5Iv7v?=
 =?us-ascii?Q?4DMM0rZxTqeb7uY8DRZdZDjtHmQd8FN6fhKk466fDAqY9LpyNbxaIAfgMDuy?=
 =?us-ascii?Q?SiHyUZLNo9dLgClpjbqyiErKRg4McmI9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yLKbqv1NzpJMjBQx4gzIjXTB1QoFbp2+Hz1BtoHS2rSBfj3raJSd5BO+D4MP?=
 =?us-ascii?Q?9CdnEMF4uiLBh/bAGE9rQ0mo58vxvh4NZ0cfp51RyQ3I83pqlgjB7+i2HZMQ?=
 =?us-ascii?Q?iWU+7stkLctjI0dkMM7qBIk4GAJYi586E+lOM6Xej51a2Znug1xFOrni58/e?=
 =?us-ascii?Q?0bdsQ/EzM1FRYrGGXejtpujWFDAj4kVeeYo1PdjeJdhHaxhAxiEYKpjX3eFB?=
 =?us-ascii?Q?MTf3GppnySfOJzpHh11lj8DVoeUPmQrXb9lSGRFjsn9XrCl/3uVcr1dBYIAH?=
 =?us-ascii?Q?4J/bxa/j84Xy0+iXUvKs2FCWfKg4ulZslSvx9dv2YHnvwWX3JZvPhHJmXJDy?=
 =?us-ascii?Q?mlLj5IiXGFd5ObBwEatwi0WJHjqHzCnuT1XNJAg2pQFHWqS38vEUS78Siilf?=
 =?us-ascii?Q?qsMPlH5w74jlEdUaHJ+j1aReX7wCUU53VIIdDE5N5bBwTS7ekq37KSAPzAIn?=
 =?us-ascii?Q?NpLZP8KHeRFNAJCpSc5PDhuZVAih4ytEVIHeJGA8Gfw6JSyYjTL4n1snZ0su?=
 =?us-ascii?Q?GWXQu0LS0exbWeW9IUjss7j4q14tsDOrCWbvzTIzle+Rf0zurtHyFGsFKl/Y?=
 =?us-ascii?Q?mXhycki659V1Z8uV1RWAUmt/q4f8WlofdJpSHwbu3JTsa5+k4XIekEF+mDhE?=
 =?us-ascii?Q?DiINcJ9uIQZA597DpZv2Fg0WmOzxprZ/0hCs85SXoz8MiS0TIbrY6qDsZ2iR?=
 =?us-ascii?Q?aMKGogBg0/lnTh7br/HjQPNv80lG0aXJsOXQdfvQVA6poJ3sjeCd8cBHK0PF?=
 =?us-ascii?Q?AcEISaMyEwt3RDzwg1IuExb3tMVivOeGvMlKD1ChgXdnqcLXH0iW2rBt8JwG?=
 =?us-ascii?Q?FJP9+9VQYahjzn7mBsGUv1fZfqLtrleNPCI7JhAnsAKqUha4kxx18+IYq0ho?=
 =?us-ascii?Q?VdL7u5RRVM9Bi34oQdVYe9TsVSGuunW0qZkAvTyLnrk6gbPKkjIbDaHVhj+k?=
 =?us-ascii?Q?dKi9deR39IRD+FzlelezT+96GvRxmB+5js9i0rA9OTztjPRJxYVwzuvZCaBU?=
 =?us-ascii?Q?eBm0xzgv3rfOfx9ELAJ3A17CmBKTHU8gqBEgXKWoc7loklqFNN1wj8kYQNUt?=
 =?us-ascii?Q?2wdPbm9Sp0bIEhpo17RBW49pW3qslJ0DAF63GVdienTMRPUtv0SDI+JxoQLl?=
 =?us-ascii?Q?LjY8SjItj+ycMFf1NEIyuh+4LCKtekA5kI6xKtyrgfSgcYc1Sus3Htn0kSNG?=
 =?us-ascii?Q?LJCm3g8XQyCj5zh9OOFD3TC68tKQceITKJovAHCKxZmlw2OP+BDdYIYtgeB2?=
 =?us-ascii?Q?hktlg4vHKO08T41XtxYCyyqUBTM8KKAnYZq4+1rBolqs5tMNZZ5ygC08WO9o?=
 =?us-ascii?Q?i16oYu4MwbaE9n4jMUb1djpNGeT6X1+FPqIXh70D0bgPweQgUMSSXIZ1cfHX?=
 =?us-ascii?Q?3yH3l24V+zsRQh5f+C2uZXZ+p8L6wGLpYX44GrpQo0wa50BWQuuU837/JRHJ?=
 =?us-ascii?Q?rwZJJUHv71Kxw3EoIHF95WEq6mEvYkrCjwWZOj8gBhV4e6JglhPGIwVZltc9?=
 =?us-ascii?Q?Z6hSwiGMIxYDZLDA16T4g89fbrfDlJGf44/HiXYjwKyloy0/kVfzj1Rp8ntx?=
 =?us-ascii?Q?I4HOl4ubR6hwtTD+x5w0EEs7TwdhusIIZcz8nVxerEWa+0N+zt2uBcPn6Ykj?=
 =?us-ascii?Q?Hf1SdPzn6NuvUIbJYJoQ/ng=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcf67cec-8d89-46a4-7298-08dd77029a03
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 01:05:21.5189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sFcfEpT0TJj0bL0aTP2jBaDfYgDxiiQ3jJRih16+7d/Zu0SVgEJnivzGQ50E5TbXUpXJHwj4Kpp9JfcbrZGPk0rVbuR2QWFKm9pTUEVbRE/lvv+S2f7DJaPqJzmvDUaf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB10623

Renesas MSIOF (Clock-Synchronized Serial Interface with FIFO) can work as
both SPI and I2S. MSIOF-I2S will use Audio Graph Card/Card2 driver which
uses Of-Graph in DT.

MSIOF-SPI/I2S are using same DT compatible properties.
MSIOF-I2S         uses Of-Graph for Audio-Graph-Card/Card2,
MSIOF-SPI doesn't use  Of-Graph.

Adds MSIOF-I2S documentation for Sound.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 .../bindings/sound/renesas,msiof.yaml         | 112 ++++++++++++++++++
 1 file changed, 112 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/renesas,msiof.yaml

diff --git a/Documentation/devicetree/bindings/sound/renesas,msiof.yaml b/Documentation/devicetree/bindings/sound/renesas,msiof.yaml
new file mode 100644
index 000000000000..5173e80698fb
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/renesas,msiof.yaml
@@ -0,0 +1,112 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/renesas,msiof.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas MSIOF I2S controller
+
+maintainers:
+  - Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
+
+# sharing with MSIOF SPI
+# see
+# ${LINUX}/Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml
+select:
+  properties:
+    compatible:
+      contains:
+        pattern: "renesas,.*-msiof"
+  required:
+    - compatible
+    - port
+
+properties:
+  compatible:
+    items:
+      - const: renesas,msiof-r8a779g0   # R-Car V4H
+      - const: renesas,rcar-gen4-msiof  # generic R-Car Gen4
+
+  reg:
+    minItems: 1
+    maxItems: 2
+    oneOf:
+      - items:
+          - description: CPU and DMA engine registers
+      - items:
+          - description: CPU registers
+          - description: DMA engine registers
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  dmas:
+    minItems: 2
+    maxItems: 4
+
+  dma-names:
+    minItems: 2
+    maxItems: 4
+    items:
+      enum: [ tx, rx ]
+
+  port:
+    $ref: audio-graph-port.yaml#/definitions/port-base
+    unevaluatedProperties: false
+    patternProperties:
+      "^endpoint(@[0-9a-f]+)?":
+        $ref: audio-graph-port.yaml#/definitions/endpoint-base
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - power-domains
+  - port
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/r8a779g0-cpg-mssr.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/power/r8a779g0-sysc.h>
+
+    dummy-codec {
+      compatible = "test-codec";
+
+      port {
+        codec_ep: endpoint {
+          remote-endpoint = <&msiof1_snd_ep>;
+        };
+      };
+    };
+
+    msiof1: serial@e6ea0000 {
+      compatible = "renesas,msiof-r8a779g0",
+                   "renesas,rcar-gen4-msiof";
+      reg = <0 0xe6ea0000 0 0x0064>;
+      interrupts = <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>;
+      clocks = <&cpg CPG_MOD 619>;
+      dmas = <&dmac0 0x43>, <&dmac0 0x42>,
+             <&dmac1 0x43>, <&dmac1 0x42>;
+      dma-names = "tx", "rx", "tx", "rx";
+      power-domains = <&sysc R8A779G0_PD_ALWAYS_ON>;
+      resets = <&cpg 619>;
+
+      port {
+        msiof1_snd_ep: endpoint {
+          remote-endpoint = <&codec_ep>;
+        };
+      };
+    };
-- 
2.43.0


