Return-Path: <linux-spi+bounces-10591-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92127BD0221
	for <lists+linux-spi@lfdr.de>; Sun, 12 Oct 2025 14:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BACBB189448E
	for <lists+linux-spi@lfdr.de>; Sun, 12 Oct 2025 12:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A465A27E058;
	Sun, 12 Oct 2025 12:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="5rw4qwx/"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023096.outbound.protection.outlook.com [52.101.72.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414D627B351;
	Sun, 12 Oct 2025 12:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760271472; cv=fail; b=S8oN/jttPqdquwVvmvMlV0fKof2rhICiFLiKo3zhmSQPgJl/Q8qdu3dtAVVljCv6t3CtI9CQtvf/pKJfirzx3iFy2Z39EJgDeZjWKX9ihkQGyQMkLvlKRJnIFXHWAdqUOh8AiFms1WEFmcwoTNSff8U9D92UCdOlHm/bbSIi9+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760271472; c=relaxed/simple;
	bh=qI/aWULC92ajq0w+3fhhxhtQef9CdKkgitnqIQzRGiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LzJxpAJesyIzvX0J0p7zyRq44pjJ/tZq3ThbzpFPsi4F7MW3BvhJ5ltag67uchGpQ8VGdG8fGJkyOZWug4UTP7GrhbyxHlFFtTUrsdqHTB73bEDZ1CG3bjruuLicSv37yyX+4bguEfS88tBnZ6oSqoXByh+5rH0lKOMg4/jnO8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=5rw4qwx/; arc=fail smtp.client-ip=52.101.72.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X4hhfe6aNoy/qh8gyuuoJYebYoxwmTxVF2cPmZDEH9ki9Q7y1grBxOb7t8YYvEPXjo+UrRqA32ufBnl1LG5YR3QYvO+8J27Mq6JNdxjKJ4YR9Lw4pXVsu0BbwIDS1iSzp2ORx9hWlj7VHASn4WjdVCiNtodrJ6UYWlIRLilrCJZlcLzYHUuJJvl5MSFKQAhHoJTMRTj5AYSoSILjkN2SpDZvcE3Q1pCQxExZTiXOOLizHyda+R+gIKjoIl8r3qbH1stI5Uf6tNMfQ9+J7wsgYG+Ardlcwtr1bzW7GSWOCi2a+tTwW+gGMlrAiBKWMLKN2lj36282ioo7g7EItZmU/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e5/hZbOh6Ifif5WjU2+oENtgouoXyrZUUc3VRiRwO4M=;
 b=rIl+e6+7e9zrZQXe2rA0oVoYAyyOl0hrMGynGcY7X3qvapHf1ZZy4/v/uEs8FeFldWFzfoneHQgjq3dXe9qI+w/laQapJaX/ZSCP8JEkS0tc91+Ch4vF7uryGsJEv07uReDdJCJXQPZf4wFPEM6l8FoaJEjE7lPhK7r7hq7DCjEgt4/D9+6XYxMyMI2fq4Psok/VXyldVUEMsdf7sSJ8AZPLL4Lrc/Wso1wjXmO31Y9EUX8QKiwI1TvxEO1NDgEcMnMm1tVukzRTFVNWudAud25tCHwjC9QGjWonkV44fPR0FoOOVcw3PagTAWvqQa6t+JWBnHrOR+62CHgqUAfn5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e5/hZbOh6Ifif5WjU2+oENtgouoXyrZUUc3VRiRwO4M=;
 b=5rw4qwx/hPigKu4PRqYiT/ewjwNW33RwtIGYeEYFY1pORLE5rwAVntc/dvD4ssFo33ZjXEnMCyakpYab+NQRdG0pZFvvA/4Dgfra2CPU4KD0tu/4Me3O8XT59SSsQnL9XEKxetE1a9sGQkISrnpPedlQR3SjRVVYtZyXMre4NHO5Kwg1mu4e5+u6mJKuEsT6Qi76aqp8HRKXX76/U1j0oCK/QkPyiSHn/qLlsoxCz0nvx3fZVMUpoFkqCP6chZiDobH8VvtXinCVSENHsXO3UlyNudXt+D5LkA4ec3ipvWGStOicR0cFzZyUG1bY1LWMDheVIwrndzaQ7zJF8pDdkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB4PR08MB8056.eurprd08.prod.outlook.com (2603:10a6:10:387::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.11; Sun, 12 Oct
 2025 12:17:44 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Sun, 12 Oct 2025
 12:17:44 +0000
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
Subject: [PATCH v10 16/16] arm: dts: airoha: en7523: add SNAND node
Date: Sun, 12 Oct 2025 15:17:07 +0300
Message-ID: <20251012121707.2296160-17-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: d43e5b28-7a8b-421a-96a7-08de09895938
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aDzAPLKBTcHMd+2eDSwGJrG87gaNaEhBz1n9GQgxCcMk5iUf/kmw8GrDoGN1?=
 =?us-ascii?Q?ewEx2Uo85Eni7Cigv9VIqZwXBTnuoT68IiX5NZjaKJs22ZhsrHYcPwc7Rgwq?=
 =?us-ascii?Q?bIfdx707XsRIk/48EqHld4+GzNiSE25/qRirZmDd9oIrAq4qu498/yIY7YR6?=
 =?us-ascii?Q?b4v/voddG+Pye8UuV3U9JFcmiHxRX7Cx5WmtqLn9OcvTAh72O/JwkOxUisR+?=
 =?us-ascii?Q?r+CQy4qMWLuH1doEq50WBM7opt9GQsuwEiFc7tdhp3qhfNKhRV0/LgLidiHz?=
 =?us-ascii?Q?xMqDLTADUpk1paRRxQ0RvEUGU3cPjodq5WtwnSTSeN1TxLnqLpOE433hlAJH?=
 =?us-ascii?Q?C+w5qmbE7Tkgn5H7j+n5JNxRaKX/awOFL/yFVfNGWB/mtdAu8blqEry6X0ZE?=
 =?us-ascii?Q?9K2j+OZ+q7H/23mgAuNwRhI0uu6UUOT2oyE+0l3//FxEnGHfku6sQLd/vsFE?=
 =?us-ascii?Q?8uBdlJSV3FcdjFdkuLtjj388Y44gMyqhcRNR6ncKIx0ASddVVMauep6Zd2L9?=
 =?us-ascii?Q?yXxf7OobUwKHTrpbXZQqoVd4YcqESaQIR4Ln+WRLnZ1OFMrz+CeDoWdYnusy?=
 =?us-ascii?Q?kh/zHpg7F/BMAE1Bhz0kh41o7xN4BuQjoAK7wYg8hKsRqXqNZ9+DVhLrD6Kw?=
 =?us-ascii?Q?QkUkSqY6L4xPVZ2l04g49/m/pnege1mhrKSOYLh7U4/Li2K+9Z2tb54JlX+B?=
 =?us-ascii?Q?XtJKr3DqlppCT1iGXbVQqsOReLAu3+22jYpL3RGqf5M6SyngytZHZQ1ETLCY?=
 =?us-ascii?Q?OdYF9v60xaImniTMW5RvbfJG/7nQE/gZbzl+xtifLl7rgOCJAxk6kJ5v4bO2?=
 =?us-ascii?Q?R+MzMQwoFWkOkTgIr29jeu9zixSd0IzbS4FQaSdLUmRZpdP+84hPPNf3Azvg?=
 =?us-ascii?Q?21sGvB94DxjUKFmTBgLAoYCR6FsNV+VcPAEd7cxeFdk6cBg3738EuCJwAkNk?=
 =?us-ascii?Q?ff2LcEmNsGK+ZZUWmnXBdQRdUbHjppXy8dZ4hCsl0ne7omR4VO6c0yhBIEGh?=
 =?us-ascii?Q?zlt5tiwF+B5IaAG7uxN0SC9d7vU7PJepjEOsZsZgowgFUqcCsJCqgBgMJLfN?=
 =?us-ascii?Q?2c3YpiB3V8a42Jm607kpXR9Fm8ar7ooWQhBJwBIHlQcMdc9ROuEaWqVivxuE?=
 =?us-ascii?Q?SjBkNO0SKG9F9D1v1jKRJ3MtKWnRlJcqFCF0PIYa+BL5BhLEnIrvcsU+0jyK?=
 =?us-ascii?Q?82RP7c0oGKhJk8TTBiMdmTZ2F3nSEiVCt9qZFEr/+DZ8HG1FHRZy/koEczfh?=
 =?us-ascii?Q?5sTHA7mnyat2wI6duhSA413rx+QDwxyLt4t340AYoqDwyWu5BHMiXValFp7e?=
 =?us-ascii?Q?+HxQCU72XQm+02osgQ1QcDspDhb2nDb+k5Ef38uLc7BR4jRhLd9K+qYPLoCE?=
 =?us-ascii?Q?WifM8YfzVJTWXE8c87lXA+wjLx2GjgzhS7BG8ZHIL0DH1JNPzYRQwXRcgGV/?=
 =?us-ascii?Q?oGThwcXlKxOLMlwXo4NiVLkiYKccgQdzKV19L8GkWHCwc4Pes1W5X13NDZEd?=
 =?us-ascii?Q?MAx8FQ+yCmJB1I8l8dHgAblyJ8fPDJ7Z+G2VVRD5YEHSj7B6iqk5FMl21g?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8E/uvEO6sogJiR621g1e/yxBtgSDRLKXtVSs78j2JgckeAtgwucfXV/WmtcA?=
 =?us-ascii?Q?46Xz+iBXPdVdCXBo7FmR7H4hjWJtxExjYtXHk0qNB13DYklguDr0MJA8ruH5?=
 =?us-ascii?Q?ovBW3SXCtbEeTGNWhW2Af1rePwdWwArYc97uDWI7eyrhOgeJ5CkTJgh8eqck?=
 =?us-ascii?Q?p6SEOuHnounLoTBOMv/D9/8izOuBUf6Tha3KMf5x3WOMs/DdMXVbAmd134Er?=
 =?us-ascii?Q?mPo3u1SQDcGkt/Z2TP+UKaOE1iS75k6/Kk2KERPTX8T0nj53Qy1Sh13fQSKK?=
 =?us-ascii?Q?vDgr7m/aleRRf5PVD+LclaIUkOigTRGxX8liBcIc7E+KEpTpYXIHf0cA1Quv?=
 =?us-ascii?Q?drEKccJ9UyzmGqZNK28u088XzEN6HEI70pnU0pDfxgtq2QmYII3+AP8omlIH?=
 =?us-ascii?Q?ZDhRwh/mrM1yZhzCDQFHHWxNql5REFHbBqalPKxSmgPMst0OnP0d7am3KBs3?=
 =?us-ascii?Q?QGd05O0XhEorZcmFIa9S8ZKLpp5WeTCQD6Bju/BW+VbweM77cDV3RaBaNeZq?=
 =?us-ascii?Q?dLiiZs6/8PMGfezVw8lTj5f6xjfAqpsX6DTOLAF5T5A9gf9jLd6m3Cel19PE?=
 =?us-ascii?Q?qA1t2fYly6QUOh3HNoTKQGyufSnJ9wyRLfP/ojqfk/hIfuhrFCscxBi6DRkG?=
 =?us-ascii?Q?0gmwVIIn2XOBkxctairLDSYzZWWOI7Lgv9vMJyB2p7fEsIZ+Q7NM/1Erm6gL?=
 =?us-ascii?Q?8Dh2b8OdV2hQ4zJJJkuPnrNaY5s1JxG7XQ/D+clyZtKGEDsDNW0kw6UpqPGa?=
 =?us-ascii?Q?5aAaBdQhjihYH/6OSMY/Ivmir+HrUr3z7B+zPmLpTZ00I9Grgn3GI8fu2lxf?=
 =?us-ascii?Q?Fvdn0cKPgq1vbLNNUUESWyZ7mrkD6mC3vKbwUSKzqEO8xHkg2C3s/OqPYBbV?=
 =?us-ascii?Q?iva+WdsuQzl14pgJqL/eycMU5CecJhMSDvkqzhm/XttJIeDMPPRufwPmG7Hf?=
 =?us-ascii?Q?d3P912ShDYnau1saQhDQ2D/qJ95/izqmfS+XtCXLutY8oe85nZBT+GmVm1OY?=
 =?us-ascii?Q?/W3YHiPXSIWvtNlVvkdq13Mhq2xWOXkhlrBe8gXsCcYnVEOf8WELvv3p9w7W?=
 =?us-ascii?Q?Qc7H+ZO8FvLU9EYvhoxJrRUtgPrL0x2B6PHFl5z5TqFsHldfAZCduTGSm0gS?=
 =?us-ascii?Q?LNtrYgZ3V+YR6MRaBe/zvJo7Qf1eMyYHllchUdVL+e7lBCZKjr1xZLxZG1gm?=
 =?us-ascii?Q?SoynBGI47WFk1B2CE0Yd08Ilsh0wu1I/K7dMIKtnOMNlqIkIjLxcrwVB++70?=
 =?us-ascii?Q?esvnSBnJzgsmYYfVp00MYPD1+7O7sJihvaiFP+ajHkmY9up6ifcq1LdhXAUh?=
 =?us-ascii?Q?g2iZ6hh2s8AgxOaS53Lp4SnLbM7JQ0yWAirk2j25QgSf6Y6L0V6rHwtEkMg+?=
 =?us-ascii?Q?VtD7uXAdtEJWAeHdeF1GAd0HZU8cexEHme4djjPLwNUZofuldVmi1huRdRoG?=
 =?us-ascii?Q?qwYA2hYQabb5B0fONmRvoM6cvCiYGDBFABcsP0bktL3l6ZVxfAyh+7lzJcTb?=
 =?us-ascii?Q?n1hRUmebUNSBPFThAfY+hZbK1TLwKkHl8bk/P4b+D6lMHRF/2yk5eP9PixJn?=
 =?us-ascii?Q?6BMB6tFDThZaB2c36yWVX6rjOJS8f5GuhVviFfJ6a+PZNuJR3Gdv6kYIdhT3?=
 =?us-ascii?Q?mA=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: d43e5b28-7a8b-421a-96a7-08de09895938
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2025 12:17:44.6994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hgznWNfhL6VMCQ/sDjySttXL5BxwSuiAl+5fqVW+sk/DMvvvOEd59GFn+TMYh+yOZ3OfzsUZyBHRte9HEy6VsrUCNavqoRRtt2b6ANoUFe8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB8056

Add SNAND node to enable support of attached SPI-NAND on the EN7523 SoC.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 arch/arm/boot/dts/airoha/en7523.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/airoha/en7523.dtsi b/arch/arm/boot/dts/airoha/en7523.dtsi
index b523a868c4ad..31191b8d1430 100644
--- a/arch/arm/boot/dts/airoha/en7523.dtsi
+++ b/arch/arm/boot/dts/airoha/en7523.dtsi
@@ -203,4 +203,24 @@ pcie_intc1: interrupt-controller {
 			#interrupt-cells = <1>;
 		};
 	};
+
+	spi_ctrl: spi@1fa10000 {
+		compatible = "airoha,en7523-snand", "airoha,en7581-snand";
+		reg = <0x1fa10000 0x140>,
+		      <0x1fa11000 0x160>;
+
+		clocks = <&scu EN7523_CLK_SPI>;
+		clock-names = "spi";
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		nand: nand@0 {
+			compatible = "spi-nand";
+			reg = <0>;
+			spi-max-frequency = <50000000>;
+			spi-tx-bus-width = <1>;
+			spi-rx-bus-width = <2>;
+		};
+	};
 };
-- 
2.51.0


