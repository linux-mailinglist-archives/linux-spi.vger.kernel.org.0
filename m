Return-Path: <linux-spi+bounces-11240-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A40C6142D
	for <lists+linux-spi@lfdr.de>; Sun, 16 Nov 2025 13:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D574F3B5AA2
	for <lists+linux-spi@lfdr.de>; Sun, 16 Nov 2025 12:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161EB2D061B;
	Sun, 16 Nov 2025 12:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="cuhKUMt/"
X-Original-To: linux-spi@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021140.outbound.protection.outlook.com [52.101.70.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E95C2C3242;
	Sun, 16 Nov 2025 12:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763294458; cv=fail; b=rcQy5NVEV9ekvKOArPR3e2V6j5Vm7d5jtskJxaULAVWNNBrv9hbEM5A9Q3nOn3DYa9IdFbhlvTv3j50sx9+8bhdH8J0/wLUat4esyoJA2Wv1S7vrZm8CgYgTIcS1xMkylsF8R0bkM3dLnWUyzTYonO198DWbhMLZ+8d1A1mQiMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763294458; c=relaxed/simple;
	bh=nvzSbP9vzHqZ9BdvDElbSy9zjtNy+EQ+e//hLD4/DeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qEZRPFW7DTAtnsABSpogwiL2gF2Aw5e1llxH7uPGvLlLdfaS94mbCSXB/2GFwdXeMaBaghHQhTOtwUyFnnXILmYW/F6DBN0DuY7stBeZYcd2A/B5yySGl0gnd3r3kOhBosorxrYGHCaOC4mWS0XUZBGwi15VO1kjjq+Ax32I9O8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=cuhKUMt/; arc=fail smtp.client-ip=52.101.70.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZltIpWoHs0IEYkSMiloUID/CNJY+N86sWnNiTjQB2lsgbxGxgxbG0sZfPCyqEy4IsBDQ2g0hXO8kjNrP6ocf0b6K4XFRK6BRVXME4dGXn+53Pk0aZ7a2s8vNBogU6mHRuqoo4g+sj7bDIXP1xJgHUx6zyxKkAL2+mgZyzw1YGIl7ELKlIeNmu5a92bKbzRG7OBpCPKJ4s0i+6oyar6GbCfbTAz/k9Htd9LsKQNh+s94rjG203EG2oH4rig9arR/Dm+Rq21AvX+8vFTwx2J5tdwatLTpqoXGgtVusnjJir2MlnP8LdofthwS3ub4G5MCYGkX5KGVQYxV5kOHM6H3/xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aj3KXet9skYYmZuJ1RFhi80JF8Ngy4LwP2uvVKLNgRI=;
 b=ETIWeBfIZkeq3pEpKtmVKKD4kKD4uPCgZ1My3AVshVLnC7Kbm7LY7/nwulTIPiHV89tujW81jEbwqEgHhXvtLCQELDOYjlZbRLbVhunv7QXD20MXHU/pmAEbjLvNXSveW4UulqsDYl6nDh5V2yh9sIHKa3VnAkbczGcdAeXjw2Aj3SsCNnIHaWAYDQO+G/Fp6pgp1Hrl6XTi9bsBbPgx2YL5Wip90i4rEBvaQugY/7fK7358yWIMVPzQo+H1/ESZ7NLoMYPUS20b1hq8AzZkxSOg8CS3MWv6yCI1NNqJQfHIBX9WILMflMwQ7VroBWVtBNApFHkaIwA0WBzkR5F8jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aj3KXet9skYYmZuJ1RFhi80JF8Ngy4LwP2uvVKLNgRI=;
 b=cuhKUMt/Oe6VxJwJfkEQfw8h4Wp8wbnWcpz5hKhRWvVblgfQJ1MlnEoQJEE189f7ZiWY9YdDlZ6dTbRqj/qyoAVp0czcppH2RRgppBMv1W7KPcAmbSuUw3CDFVcEoui0Gah992IUl39t0dk1I18+pOXSS7/ehfF1oENUrl+CyjXpEIXFkdw/QWQFZ9bckeJmrKKfaspuzpv4ZATAVURqbN7DRvNES8/gMX7XUBUhAO0Fqc0ylmgVuSvBw6UR5nkWKgQevYFQKMsmflQ0rP2OEqZGnEGpjmYNGcp21bkJunuYF5Sc6xDeicWJO7KufXS4iDpaZx8DnvIxxLl4BQra6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAWPR08MB11201.eurprd08.prod.outlook.com (2603:10a6:102:46c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.20; Sun, 16 Nov
 2025 12:00:51 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9320.018; Sun, 16 Nov 2025
 12:00:51 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
	Andreas Gnau <andreas.gnau@iopsys.eu>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 2/3] dt-bindings: spi: airoha: add compatible for EN7523
Date: Sun, 16 Nov 2025 15:00:37 +0300
Message-ID: <20251116120038.672178-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251116120038.672178-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251116120038.672178-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0118.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:8::31) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAWPR08MB11201:EE_
X-MS-Office365-Filtering-Correlation-Id: 13357da3-3858-41fc-fc21-08de2507c974
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+DddnlgOtkhEUW3J6un+BvgzQQgI2x738NBUk60ctGn5aotU8tGXg+YkeIel?=
 =?us-ascii?Q?NRW5/6BQWN7/EChih9UT6t9BGKpMzl1CHaqu0yXXuYgEpfWiMTAG+kDAC4+O?=
 =?us-ascii?Q?IysBry3xeVfZXNbeLBWjesf/mAqttlSlORUa/aPEQbnriHNihfo/WOvNH4RZ?=
 =?us-ascii?Q?5OJn5tGkPH27n+kGQC37DzZx3G2D46/bn/PkQoKa/DccKx/nWKg6t94+llPo?=
 =?us-ascii?Q?G9jDkYDl4RhzHXAHVtETXpWFPTkkxtXxmTrMlfWOpX6deqcYti/uw4D27tW2?=
 =?us-ascii?Q?HWp7kdRxq18rHkcIxMNyUdqj0USdub6nevdEsDHdg72kmYM5bskT4gVDOAGu?=
 =?us-ascii?Q?IeCSSW+PJA8I89q0PeR+d3iNoN2zJFtH6m2skI9cXa/SAFDXmEM8Li2N8yv3?=
 =?us-ascii?Q?4wqyOUoCHDdIdnV0tTOKYn6wENqeyYZYeR5oYLL8BgldqJFynhyZ5TCaT7L6?=
 =?us-ascii?Q?rnBUswIKt3TiaAqxNkbvh0RmWSaK5+4ACvHsCMTTfNogixprb451vNBghkcD?=
 =?us-ascii?Q?4hMCLsvkKGIQVGD6jKoUrOQI80lcyp5LzN5q8+v+zaGvr9vZPUujIKERY3ID?=
 =?us-ascii?Q?B9cHQ3U0NxanwximUbJewGiG5j9N0kwXec67N0z5HCTblruL2yel8F0EluZk?=
 =?us-ascii?Q?WixjNYFSCSo1pehML5AdG2o4JD4mNZpO6OgM4CrNPZPiEQDy6tFVFWGcUyRr?=
 =?us-ascii?Q?AqmDiIWGIefzvW3Hr3C5tOhggiYx1LFzSKUEL3X5oOMKRRmtLduLlJBLrBNG?=
 =?us-ascii?Q?SmqtSW5DXDfrVRjNeZx/FKate4TTe3ENpAS4ESv2/Q6EZQNyXwNNn+NyIfBG?=
 =?us-ascii?Q?kIdIJxQwI5BynBwS9nJr+3hNmKuCW1JCbJmKXSwDFABcIL5YY6Iv8QKtPNeu?=
 =?us-ascii?Q?tYjYmIitJYZqOb/Aen4CFNGcflmOiLBlF9NRIgA4m0XXqf2X+LUU8H2fp8P+?=
 =?us-ascii?Q?3/B9b5Dw93yFHTX8ViE119gVTQR/NbprdZ4jc/QgqxcId5MMTitKASI+2lyY?=
 =?us-ascii?Q?BBtCxWguJnQIKTIX8T0jc/+CbHAiC8YaHiVdZAq2Qzzlmw3Fv70OAQ/7Z2r6?=
 =?us-ascii?Q?HgFo6UgKM+AlvqnXEKiUKMWFrHQ8RotZ4tlyI7uSPbV5pRLME7JpmC1BueqW?=
 =?us-ascii?Q?ruqkwkWblGiu4uasrJ+6ijSuPxLXVGXhqfSNW92pzBXpSL8ldk8j6hrseRQC?=
 =?us-ascii?Q?X8EUkFctoucjMbEoCjslHwBb/iCDjibu4gcg1R7dLAZeffTaa9dj7HFMP+1S?=
 =?us-ascii?Q?Eldr7ALEtXEHaanXzWY2o2p5Fxod31mg3LsqmXupUHR6ciVja2dr/3EnRdEh?=
 =?us-ascii?Q?6A7K8dxN4C96XYeYeeRRX28pIDfiA4IEF58OF259r2Ko8MP3ENai4Ij2hlVh?=
 =?us-ascii?Q?Nvvx6n8pGhlFnqb6XDIgAmu0yqTQ2B6pqce8b5e+LT3Nk0p0q/cP41kwW3SG?=
 =?us-ascii?Q?4+7aASmVeEpIBSrRthtLQnbG6xP7bbfJpWRUYtn1jhOBCnMZ9h5sCpSxGbfo?=
 =?us-ascii?Q?vSVM6+MMUVa6Jh5SsVTFtTeGBuHygZc1JJIBPFyySU2vbdco8CgSl+F8mQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NRuFSrEHAHxA15t3Xc3TK9b/BQfD9vcwhuelxwxhSEyz/khGjKNzAc+y//Lm?=
 =?us-ascii?Q?WYrGVJx0SnorOye42mASgI6eI3F4hiNwskP5g54TmLpgSrY0Iwi/8pxfFtxQ?=
 =?us-ascii?Q?LH+lx7MvqfXjwgeGs47yJxuH8XVBU6/eBQZUsk+t4QmmmJWJGX+XJWOt1EGr?=
 =?us-ascii?Q?DZdcBTWqw3fpPKIQgjBJ4e00Cecp12xGDpfjZASit44ooocrVDknOSOW+CA3?=
 =?us-ascii?Q?U7JTKUEELLDU2OFHf3pnC7H2MPKG4ZwR5xoih2W2uvUWPjwnz98JZbgqPdUm?=
 =?us-ascii?Q?b7f+NJOwMTwMtap4CVCbyCtZItfdeF7AlsTRlNVlzEGnTmiZGGEfvqmGZHSA?=
 =?us-ascii?Q?19QiJWvIX1o5uL9RFeJ/P5xzH/G019P10EQ+MlFXolCqobcYar7ZwAkL8eHL?=
 =?us-ascii?Q?4NSRNceFPSun7hlyLbRc240WVElCXwhcOyAT6Quzf8sKPrLGUGnnjK7CnIoJ?=
 =?us-ascii?Q?L7HNIoO2+9R9rLoQJ+lB/i7vUuhvVD0mxYrGSKRQwHkzTlqp2CzFg3qKDKI3?=
 =?us-ascii?Q?oC0kT1h1WcBhxtyzzHh6HWM77IBZThPCTLQkzq/8ADzJjDE6Nvg4RKaPF6Oq?=
 =?us-ascii?Q?aiVqAMgjSr9n2NSbf+V/nvgAYLWryaZSCSlEFSIhxT3QW0nPy3YJ5JoEwcnO?=
 =?us-ascii?Q?k93KwYbibQl5OpUJ524KRHrgJmB/3YQ77jB56r7tj6nPijMgEkog/EZ7rqTr?=
 =?us-ascii?Q?+hlbRRyW6mPyd63B848wXlJ5DWlHn2F9EgHZFCaa+W5Pswnw5GUWidjf+TNq?=
 =?us-ascii?Q?zXv/DZdTLxtNo9Gbgs23OeLAAndtaZgUXdqlpibRBvSu878fjkDszL3A3jjV?=
 =?us-ascii?Q?9aweXCzFNtSiO9P6XYpshmX1MZ2IumFVJjlxiJHMIHcY/ywnDGRuGL8/W12p?=
 =?us-ascii?Q?BjbqRM51rD38wUjkeHjZTxp6ow+YVSIUdEbWea4xdLgGjDwjYVvSBhYd3hOa?=
 =?us-ascii?Q?WArOSRuKnpOGZox2p5v2iHcerBrjHUg98ccqaH4qV6yTPLMByeFV03SDjkui?=
 =?us-ascii?Q?wqXOGqpY3S+la+9SGcTfjZUuOaHuPJmbb7H+rtWWKcmYgFZyLksrLxhYKbMW?=
 =?us-ascii?Q?I6F1sYVO/tRd44+Va45lF8ZBxGOZIPmk+jirIg0B8M5kP2e075XAV9X0j4i9?=
 =?us-ascii?Q?EjpHNeFO1RdqenglQeK/2rCIAioBse+O4NHS3uizp+BNnSVY8HAfpnUhsftJ?=
 =?us-ascii?Q?+1SuoFaLQMasuy5NCxqAsNah5q8qf4jK3yZbJ3Z66IvDaU8fCMp/Sa6pTrXH?=
 =?us-ascii?Q?6aTSxozYZoupu4FVbKZ5BH9Wxc5XVXJMq4w/JVpszQF1XolLNTTXF+VjVepZ?=
 =?us-ascii?Q?J89EVyg8ecvUwg9vvf9C9f/abn36Mjnbu3zNCC6PLpmeQw4IfUBqoRaG7Nya?=
 =?us-ascii?Q?tvRBw66XHpYedlFTo6ZLX6wXxA3OCj48tXKNc/E+Q7+0Y7BNDMA3U/C1rd3h?=
 =?us-ascii?Q?T6hnYgUkLpv2GAMGe5v4pBk1FlAabAK2yITDOlWkUDozlvrQOoIOOcGaGk/W?=
 =?us-ascii?Q?+tUsXJcuutYTBuu2JtoUNO+DZP6eQLRN9NHbz3aGVaROKrCjiL8m26yghUmb?=
 =?us-ascii?Q?gBqvyIbUhqStG/OHrMR3ILAog/bfnY4kgOzz7nUmaxx788GbMvSeKbZkPdvc?=
 =?us-ascii?Q?q0J7QC9I/db0WBNF4/9amxU=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 13357da3-3858-41fc-fc21-08de2507c974
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2025 12:00:51.5064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W9ahzGz6ucbTxQNnwut3mGKcATG4j3wTc0KgvJz8jTV23ZOByKS6UVhJ1XFegRG457gwW8e/6Qk/b+qwqqK6YlunHCekirRHCaNBpkGQfvg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB11201

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


