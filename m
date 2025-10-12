Return-Path: <linux-spi+bounces-10585-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D05CBD022D
	for <lists+linux-spi@lfdr.de>; Sun, 12 Oct 2025 14:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 76E314EAFAE
	for <lists+linux-spi@lfdr.de>; Sun, 12 Oct 2025 12:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2812798EC;
	Sun, 12 Oct 2025 12:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="wabRiNG0"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023096.outbound.protection.outlook.com [52.101.72.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D7E276054;
	Sun, 12 Oct 2025 12:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760271465; cv=fail; b=t5jN45FGsBGuUiJAWygXtde/79eRsaZDbfZamBsF47qTd8C23GIMTcmWmlPDEbkuyUFUKHyEs+NjZarD2+1G6THw9/eZ7n0UUgQfXHh6bOIL/bidIPJ9sDbS6uQWh1CWAWNSG9K+nek8ycNeOso0JS/Zorzh9/pKYtqgRDFN3Tw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760271465; c=relaxed/simple;
	bh=yls5E1AQJW8UjaQIdkFn4PFMkKchlzz5HVhY0hyRl2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o5DUgR7OIizIVQWoPjw6roT6gMxGO+3Pz6RYLvOrJPqxEmxP2a641laJgrEE0pEEXT+Kel4XOUdabfqW4nAqpi8eBM9V/1WjHnpq+RfngRdUQCJobi9gTylUrQUbAVQFuQm30B6/vlyZU/QROQMafO+jTK0ZxUHqhXiXhFPLmoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=wabRiNG0; arc=fail smtp.client-ip=52.101.72.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=liL+FOWjIDQ3bxGSg8n1dH2E/nqu1G23ttBaTqBu40OopFZDv1ONrrczQQpzx+UoqrkJjPlI1r+rU2sP2ni7pZcAxEqOsbv/pDnVsbyYzBZBEJUHLyPPJg8h3vF40I/0WRxbTG4uG/kbAsFTMcSoCAA/k7+lzSzAPVYxg+m0Wg48AYg7VNaLP0BwQG/DHdJneFyj0A/dlotu19bTsm2llcfij4SaJpiQBIc7L4YqbS/eslYyFuvl7R7XmtGZ0T9jHFcX2PG8rTlxypCxSNVZa22qfMn7Sha2Cx51pqT3kgT7HBjJxvg4xTXQy+hQCoLOh6LRacl/slPhqqiwMXi7Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nFKNDFk6oF+S+8lmQu7ZvbBpT1DDV81X0kaPUpu4tAg=;
 b=J7a49EnEWGyBx6R7saPiK2ckIEVIdQg3M4+r1Amh2Sds/ughyh8tVhxXOFGEJFlbIKqLK0kIhDDlTadxsHIGSG8SoQu1rVvCw6xigp9G7fb7pqM0Vb4zMTn7i0QLfbP3YLDVPbDWMIj5e1opHN5zGb1AGMD95VyCw9/EMLeoVGvcjIAEGfMynPY1QBNkb8etQaaYDXt0JyBQgGlorU2cH6d54UXrm3JXPRCzAPkp9c2vhMnQjJe5haktaBpJvhViAT4xrdGCoZOeLLPrepzLsufcP+PMinz0G2J035DfXK6ScP+CpfmUXXWGZ1r9OdPG71ohEowKPy/rJPD+DT12mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nFKNDFk6oF+S+8lmQu7ZvbBpT1DDV81X0kaPUpu4tAg=;
 b=wabRiNG04gMTNpSkXc6VGvXesd8eGIy0qPREVssFgpNjjBTmLmZASvdziMQTNqiYrtj3qcRPq9LqvS+f4Fh/W88haeUTJ7FC5mEp09ZOLE6RboPGsX69iVPCW+zzn1l09JyXtuvkDV0zf6xGXiP7a+T+EwtoOpg96MZWFYvuFx0wQLTkOIyMu4spe25MwTCvYzPAtIpqAo1GytHcFEdyHD+v+anwK1W3k5ZSQrkbIB+nsM5obgSmpCW2JEajcbt+z4kICEWxQUHYhPseBUtmTBZkQ68YJ/lVLpTof0+UoFDv32xCFIAT1LN9BPd5gXzjE5k0wR3CNHdT7BzltCSqtw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB4PR08MB8056.eurprd08.prod.outlook.com (2603:10a6:10:387::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.11; Sun, 12 Oct
 2025 12:17:30 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Sun, 12 Oct 2025
 12:17:30 +0000
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
	Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH v10 08/16] spi: airoha: support of dualio/quadio flash reading commands
Date: Sun, 12 Oct 2025 15:16:59 +0300
Message-ID: <20251012121707.2296160-9-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: d5c22089-a309-4853-a055-08de098950e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HFcO1RoSHSScgrcr7bZiOBAlvNPnflZ6933AIP2uxrI0UbEDwr7H02Gt0BVA?=
 =?us-ascii?Q?bLujWnNiLSfHxtFU5J+gyGMnrkKRnNvy2oFsMxfHCxfkfar9N9kcHOaRup2o?=
 =?us-ascii?Q?4j/AhdmwD+N5T62MFSpUfzOxoRXI2ldM88T07VcWD0MdGRuC80HV1a+X1CvK?=
 =?us-ascii?Q?agBJzqg3rh/KFWF8AKoKOiYdGkbPbNczl2TkQFUQ4yCK5D5D5YzXIg/ud+B1?=
 =?us-ascii?Q?RF+wUgoalOok9+vNFPHf+VVUEOlT1iaf9e5xBJ2L9c/iWEMywXJNv/AYS5qM?=
 =?us-ascii?Q?U5ddFxQ8Xo6CxKfnMjp/q6ij9WjnFWHNDqBnfTzYQlQJWU9+Vx9nn+W0/B6j?=
 =?us-ascii?Q?tKYxAthbnUT7QtOSnbcr3F/qK/JW4Ml7TSBDC+wQ6xpMvccAwEEgtBO5ukXP?=
 =?us-ascii?Q?kP7X1xCW26ujUYRa0d3yL+DiEYaDMthSEEUYn3UOy5aoPnEX/yXUMb0G68mv?=
 =?us-ascii?Q?Xv6+1kebTMGtrRwIevSMgbSXB6pfQgWDX/30n7QONOO1UXHsj8e+ph/iy6if?=
 =?us-ascii?Q?laAVSVbyhe5DVrHc6khbjVaZe62Sm6mP7Cn1LVPXKPcWzBGvICGWr9voY/Wg?=
 =?us-ascii?Q?OlBKcowHRJWvDB7O56A2027SD5Xa2arllnkHBqN7R5TTMR1Td6ffjq4Us5cM?=
 =?us-ascii?Q?2tIQq1YNChKGDllNreKsPUCyihENKaPXK8Ch29bShXEg44CRcajjCvta4DKC?=
 =?us-ascii?Q?DizwxiCpa5vEoGB/u5cAtNMb+iJ10CoMPEKjw8Tv9i1/PD/HtomsKuAbz5lv?=
 =?us-ascii?Q?JUVUFObZscOK+SMDN6i3EY/YLwwac9m7NIPIVySERvi9zzTvyvADJC+ainZM?=
 =?us-ascii?Q?Rf0Xnz+aCir5aVzZrHLS7icg5uJ6n6wdO8vssMQmPTyT6zM0uMjKib881vxb?=
 =?us-ascii?Q?Uxew7bfrsPz2x2g64CgdLXnnZ8xiE5BXSL2rWPhbF923YptFpP9Ci7mrbzY1?=
 =?us-ascii?Q?suep11Cc4x4rcjKRiabrzGECgR7Bb7fdjKmZeQi+RgbhIM8kGMcgFyBonEbC?=
 =?us-ascii?Q?+lNNjjyel6JjtMGviJD61zNwiAYauH+Qs8vZ+ALo89GGeeP/ZewHcWOoSPjc?=
 =?us-ascii?Q?VK8ZuYf/QGm8bQG/QkwkvHIsVNpRELVbaMeGZzIdzDUd6BCwWrYKYppvtZTG?=
 =?us-ascii?Q?igp/zBZdEeaYgQRrBcuj3eBnEIIXTswOTsJObL4m4y54lsmrXrP0hpl1L2hd?=
 =?us-ascii?Q?Czt+tFNmTAIM6jBzhtnm8LWifCty5zggAXkuLV45x6BFC+tR9d4gK8i7oMgP?=
 =?us-ascii?Q?p4q8atNugQNFORmHbhDmvb0S/eK6dh1DfggCUGnMwZhuZPi3RajsT7JUykuM?=
 =?us-ascii?Q?BlvHkzh15S3wwAQh/dLvXvlRYBgnccN/VBv4LQyKNhi41XLqb2uzRt97hiLb?=
 =?us-ascii?Q?yLFBXj+1vqccblIZahC7WpPZVc2aHpjsl+6cjDN0TiRQ4+GjkAWRmuFJN2En?=
 =?us-ascii?Q?jz2upFHtCwqPNf3eVuKRgy4wAgzbxG04GF8WKT8k1Xq0Z3eB0v3/Qn+rJgjo?=
 =?us-ascii?Q?pblu9+pdd0Rt4upVntGIdyPcAGcHmdZ96mtQsnpBHvcUYXBx2VT6m4hDmw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X/MqUR4gJsTVvDwfmOmCcJB/0/Y1Rt3SDVT5puqwtENLRSlIWQPNoaU4F6Q0?=
 =?us-ascii?Q?JLAP9YKMLrAHSulGWOIZe2Fk0/wzTRhD7eh+RmZLGIPYExnOXYuIcSu3at8h?=
 =?us-ascii?Q?WAaJy+anvQj5EgkQHeltIeaVASuCTlUKHvf7xg4WnI9V7yDN9HemfQ6Py/W7?=
 =?us-ascii?Q?2fFfAwsXOZiKJbvQ3yXjPIDfhLFlXzKrNngfHE+NmScOkA5077Dazkgv4ff+?=
 =?us-ascii?Q?hUuuA9DwR7xs3QrJSKpWNiWstFO+wJ0sxZXeYsahyxnopZ8vHzFmp1NYzN0z?=
 =?us-ascii?Q?LV/rp3DwulRTZNLJJdv04ozukkZwtbzoW0MI2BHUxypeXMxiVgMSvxYu0FSm?=
 =?us-ascii?Q?mErrirmY8xsGQjbFrg/H4m3UOKUHnXxxm3Si+H8T8sCS9cPRqdlIKlamrSdC?=
 =?us-ascii?Q?ttySJ3wTKJWTBV/Qj4P0V3SXaLgey7+MuWZYQ8dhUJ8IcP8//0Jmvf8HP9Ic?=
 =?us-ascii?Q?+pwaukSgQc/Xdyzwx4vBwSiC2sAMXhOyMP8ifI1fMDhVc4HQNfi6NzD8uizb?=
 =?us-ascii?Q?zIlCMhN27RT7TAGcnAURDPuBQ8kt55H2BzHDIXW2tZ4LRJCl/uR074/H4EqZ?=
 =?us-ascii?Q?piEY5h0O/OFaeO5c1a1Q/pcZ9UwqQnw4S8CrpjnN1Jwyn8VZuqpMymL5LNdQ?=
 =?us-ascii?Q?Po/vAB93cOctYbqy4GhvtUkkyfrnvAFQR5vOYu5z3LTKzsx5V3K7sM8omvQY?=
 =?us-ascii?Q?UZ5ui8IK/BuRoRfYAfYyJuSCjSsLTsnXiJdYrIS4lw1QGOkEXe9l5hTlLCnB?=
 =?us-ascii?Q?T/0qf9PcRoQFRFcKX6SEChDrFuJ63ZrMxOY1hxrcBP17fT7nnaMl/TzgXFhp?=
 =?us-ascii?Q?bd+LjFu8r1ohe6Jf+sqkEwOGHYEviqOgywKk2dTlN9J/p5xOnB1iMEP0fxte?=
 =?us-ascii?Q?Sa/dpipr+OJiDKy+USwSv5m8kQ7VM/TdQazLLbwngtwiu+uH19C5obvY5mpq?=
 =?us-ascii?Q?yZcShanFVbvRLm4x7g0K8UJvm+4m86/cg+szYo1mLHN0cHhbDCg2mL1wsz5Y?=
 =?us-ascii?Q?D3lqQWuJIXel9zUe+Kx3dGn75LifdLJ3f/C20UNQmSWY94y9gZtlRyEBp7hF?=
 =?us-ascii?Q?R7m2lxQYhLudIrLaXlhsxvyfa1GvN7BsSayw4XGqZvIJjhckYcPupjJf7WqC?=
 =?us-ascii?Q?zgzFFHJgp4WoY6vl+8ASv4BKePVXKnLWUDqa3/Ni/YThAru2pbz8CsdjboAr?=
 =?us-ascii?Q?v0xmYmwvgLxFSNsI8Wv/y5DZxYDCanMYbLzW//QqCKtp1mpt7TC7n9WEGHUY?=
 =?us-ascii?Q?8QytvNGejvMooYiJKuH+Zjd8bqVY3mzPMUqXMwySCYW1gbAg6y1qyyZpMGvI?=
 =?us-ascii?Q?Aw6LOQ4/O2Rm6jRi+BmxLBbEn52LyyPoVjl5eCZe4YdVWLdrAi7iSnKQdjWs?=
 =?us-ascii?Q?4z08hoq9uevq6ip3w5By/nDU+EfaNxxiRnqyd9ABf20ozuEHi8F2+VbV5uix?=
 =?us-ascii?Q?F3wH4dwi0URP7OAxJBK/EKiZXYQuvfKVzB2UnsQfo/PW5JoEbCk4vMpAxMHm?=
 =?us-ascii?Q?Xc0w84tkImUqgq+3u6FfPG0BR1Bz9I5XlCap3Xy/fcMoWbrSAsPSlsUSdLe2?=
 =?us-ascii?Q?Na925GycjUYupmLkIXtVIWT7yb6HywVyv9C0iwcsYkRg4T+QZ2X/C4CtYc5p?=
 =?us-ascii?Q?TA=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: d5c22089-a309-4853-a055-08de098950e2
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2025 12:17:30.7447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xe4eSwBZRD8/XUV+iwbK1Chw1UdmZr12qcx9pQNkl6L5AW1WYmse9WUU0/yDGkvbXBipRLPCiOmAWkoqenTGCtlLNwlZfGCQ9vAThxBAL0E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB8056

Airoha snfi spi controller supports acceleration of DUAL/QUAD
operations, but does not supports DUAL_IO/QUAD_IO operations.
Luckily DUAL/QUAD operations do the same as DUAL_IO/QUAD_IO ones,
so we can issue corresponding DUAL/QUAD operation instead of
DUAL_IO/QUAD_IO one.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/spi/spi-airoha-snfi.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index e90fab69d81e..744eeb2b24ef 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -147,6 +147,8 @@
 #define SPI_NFI_CUS_SEC_SIZE_EN			BIT(16)
 
 #define REG_SPI_NFI_RD_CTL2			0x0510
+#define SPI_NFI_DATA_READ_CMD			GENMASK(7, 0)
+
 #define REG_SPI_NFI_RD_CTL3			0x0514
 
 #define REG_SPI_NFI_PG_CTL1			0x0524
@@ -179,7 +181,9 @@
 #define SPI_NAND_OP_READ_FROM_CACHE_SINGLE	0x03
 #define SPI_NAND_OP_READ_FROM_CACHE_SINGLE_FAST	0x0b
 #define SPI_NAND_OP_READ_FROM_CACHE_DUAL	0x3b
+#define SPI_NAND_OP_READ_FROM_CACHE_DUALIO	0xbb
 #define SPI_NAND_OP_READ_FROM_CACHE_QUAD	0x6b
+#define SPI_NAND_OP_READ_FROM_CACHE_QUADIO	0xeb
 #define SPI_NAND_OP_WRITE_ENABLE		0x06
 #define SPI_NAND_OP_WRITE_DISABLE		0x04
 #define SPI_NAND_OP_PROGRAM_LOAD_SINGLE		0x02
@@ -664,26 +668,38 @@ static int airoha_snand_dirmap_create(struct spi_mem_dirmap_desc *desc)
 static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 					u64 offs, size_t len, void *buf)
 {
-	struct spi_mem_op *op = &desc->info.op_tmpl;
 	struct spi_device *spi = desc->mem->spi;
 	struct airoha_snand_ctrl *as_ctrl;
 	u8 *txrx_buf = spi_get_ctldata(spi);
 	dma_addr_t dma_addr;
-	u32 val, rd_mode;
+	u32 val, rd_mode, opcode;
 	int err;
 
 	as_ctrl = spi_controller_get_devdata(spi->controller);
 
-	switch (op->cmd.opcode) {
+	/*
+	 * DUALIO and QUADIO opcodes are not supported by the spi controller,
+	 * replace them with supported opcodes.
+	 */
+	opcode = desc->info.op_tmpl.cmd.opcode;
+	switch (opcode) {
+	case SPI_NAND_OP_READ_FROM_CACHE_SINGLE:
+	case SPI_NAND_OP_READ_FROM_CACHE_SINGLE_FAST:
+		rd_mode = 0;
+		break;
 	case SPI_NAND_OP_READ_FROM_CACHE_DUAL:
+	case SPI_NAND_OP_READ_FROM_CACHE_DUALIO:
+		opcode = SPI_NAND_OP_READ_FROM_CACHE_DUAL;
 		rd_mode = 1;
 		break;
 	case SPI_NAND_OP_READ_FROM_CACHE_QUAD:
+	case SPI_NAND_OP_READ_FROM_CACHE_QUADIO:
+		opcode = SPI_NAND_OP_READ_FROM_CACHE_QUAD;
 		rd_mode = 2;
 		break;
 	default:
-		rd_mode = 0;
-		break;
+		/* unknown opcode */
+		return -EOPNOTSUPP;
 	}
 
 	err = airoha_snand_set_mode(as_ctrl, SPI_MODE_DMA);
@@ -717,7 +733,7 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 
 	/* set read command */
 	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_RD_CTL2,
-			   op->cmd.opcode);
+			   FIELD_PREP(SPI_NFI_DATA_READ_CMD, opcode));
 	if (err)
 		goto error_dma_unmap;
 
-- 
2.51.0


