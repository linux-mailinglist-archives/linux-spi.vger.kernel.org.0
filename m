Return-Path: <linux-spi+bounces-4603-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F3E96BA32
	for <lists+linux-spi@lfdr.de>; Wed,  4 Sep 2024 13:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66A921F22542
	for <lists+linux-spi@lfdr.de>; Wed,  4 Sep 2024 11:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135221D86F7;
	Wed,  4 Sep 2024 11:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ijO94UZb"
X-Original-To: linux-spi@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2056.outbound.protection.outlook.com [40.107.21.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247191D3658;
	Wed,  4 Sep 2024 11:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725448680; cv=fail; b=meijAVSl3osEEDy5VodWfINuigXsfdCKxgkZvXjb8xV6JWRSXag4LxVSlsWwyfS452LrBolgurFibFXAFcbknKflnUwEuU0a1zF/8SMPRISERgACd22gWPpNqahY/tKqMGBxmmAEP9thNFN7MXFxRRQ7eCm2vOAfOG6ckek+oBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725448680; c=relaxed/simple;
	bh=WyEQW/M7B7jUF1Tiuj3tDW5ImxsCVPjSrAKj9OOrlW8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K8amdLo/klEDgGZexjL/id4qdEb9eiLlhcy25DkmExI+BoKeHuemFEy9uc7yTB0yq2zapAfXex3liDJEmpB6O7YDwjTO+zxVGY/gR7pcKAaLhypz6iM/95GPUTTtQgHF8Nv9Yn29ZEVrASsv+NQxX176bfS9HeBI06IV/bjBRCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ijO94UZb; arc=fail smtp.client-ip=40.107.21.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SSCfWRngqFq6ODGJkxltqsqQavAo4hnirVGvuA+7gYeXmzw4QMNygtnxcxirg4GXjn7u6gkm8lw3BhniQuecq0e2jGQwNoAMLAC2L7b2f+UhgfdpltQk9iWPIIipeKU/VksE690CwcnTSCNJDtGwg3zU7/GGEOGoNs4Q3dcceV2qkfs1izWbvvpxOWSaVA6KruFWP4j2ksCkjlDSv15qUkcg35gjWd+xYCVTGhdFKsXhyJmGIvSiFnyIbc6q+uYV/WxK/vrGpGDxNEGvPproPJbkjcU93M8jnC8/HYXTdSBVOvLmEnqYU7W0fqOVtHYe4yJNaQ95Wng28v7+/UpglQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AIt7bUAdvLp2xTJHFUTcA904gvk2qkfY/lnFFJr4VT0=;
 b=nMNZerqOZtnKVKVeJLB57LTDu3xa6Fga6CuvPxozpSaMx+QLopId2ZGKrOkm+elJGm4MjQRnUL94Vx7qHCylvsGPMxz6uDemJVTz4zrxs/wnMPAdLMpR1HHOqf0XCGA2RYPYaRQMl8XBsNCci/Z26CD8Rbe1ETYNrR3UnoMobyiVe/xYZhtPxl5Ve3t8egpwCHKI643zrASAEEAQ4vA7MCQQgMaq52x8GZ+VnEZl36KCsAnsbaJocI8/16z/0pXEJmSMvXDTqT/SNljjb49FWouHL5GuoQlB38bPj8lJxdIykQomO5ZdvR0+Oyfrxja6DUjcO8lqo9e85rN2SvYRUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AIt7bUAdvLp2xTJHFUTcA904gvk2qkfY/lnFFJr4VT0=;
 b=ijO94UZb8JHWsAq1stEI53DvDMkX5idKDbIZE8/W6j6tUsg0on+dOI/s6e77WzR73PAWy9eJAstFmhl4e4v2tO83CXXg22yJEsL66dN6ueXqVVWMQhsNOqh0wlOpejIAWR5wyIkIYh0uLvX2PiBph7w5ZH444x6GPJrVOwZ28ADmVwKMm6UofC0LEaNYaktyoXshY58D7slDcrGMnN0e1z98MEaHHVazsCvX/lcI8DRQTeJzGDlZ/z5/35FMek/iilkbHgfPISiV5G5efhkMF7XHciLPGby8a3xfSHp02MXZ1LmzBqaa9XiOBfJ/35sNCZ6QPtct/J+3Q/nNCuV+Mg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by GV1PR04MB10607.eurprd04.prod.outlook.com (2603:10a6:150:203::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 11:17:56 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%4]) with mapi id 15.20.7918.020; Wed, 4 Sep 2024
 11:17:56 +0000
From: haibo.chen@nxp.com
To: han.xu@nxp.com,
	yogeshgaur.83@gmail.com,
	broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de
Cc: kernel@pengutronix.de,
	festevam@gmail.com,
	singh.kuldeep87k@gmail.com,
	hs@denx.de,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	haibo.chen@nxp.com
Subject: [PATCH 3/6] arm64: dts: imx8mp: add the compatible string for flexspi
Date: Wed,  4 Sep 2024 19:17:24 +0800
Message-Id: <20240904111727.1834935-4-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240904111727.1834935-1-haibo.chen@nxp.com>
References: <20240904111727.1834935-1-haibo.chen@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:194::6) To DU0PR04MB9496.eurprd04.prod.outlook.com
 (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|GV1PR04MB10607:EE_
X-MS-Office365-Filtering-Correlation-Id: e5633cb9-8ad6-48b9-513c-08dcccd339ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IFAlfBHHQb5lKWKfN7O+a0Yfk0LNm5sVhJYmRHccgc6GMCBqPZ+kgstQAqJ+?=
 =?us-ascii?Q?LklLVsRHZQ6QUrPr1h6rtsurFnKJdKcdVHHbZGAuSt+/a3O1iOSA1mONb9me?=
 =?us-ascii?Q?OBuzvAfC1KmrBDrxKrOLpDoK2l5EixAootqou3rVzd1JivJ7jXyRYnDT0I9z?=
 =?us-ascii?Q?+PzbF+K+PcECTVksFmQEaPkELJFXsxHCYNiU1C/mDVxXQDX+QUsMUVPJz7MS?=
 =?us-ascii?Q?iAoijhan+B8Xcn3b13G9FW4JMv6SSAozNQXXWwbonU9K+yjkI52meaYbGWnT?=
 =?us-ascii?Q?HWPPTxzAwT0O51BD/rbyX85BYHEsQtwKJomwvJEB6fN0GJgr+z9YOGCNZSUj?=
 =?us-ascii?Q?1BbDd/4j8nBulCl+t2W4Q+gZHVnaOCvrOMkjvuIrAk2elkStE+TKV0+cjqGn?=
 =?us-ascii?Q?L9WFd49iBKr8YdwOgEpdPL4iiyp09nNaf2ddGsFNjN7XOu/FOQWxbOx65cZu?=
 =?us-ascii?Q?kcsasyC97mH3jqXIdLU1Epy8njDN/CxUTXV0bChzNkoAwZ2S+qOEGq5Sqlav?=
 =?us-ascii?Q?ECmKrI1RNNsiaAx/YErsWDbvmJ2ZUpTMjFaD2Km4ui+Ck27cMjzf4VjCslTI?=
 =?us-ascii?Q?/lbKNMRBoZUBZadw4UHev1QSDvc8e42PS9ooCicNkg5FMMGeyHi2tnCakIh2?=
 =?us-ascii?Q?q0IY0YOo04/32biwIsS3Mm1iSa89MH7Ms+tAuy9CecsBhP4yg6BA5xW48UxC?=
 =?us-ascii?Q?uFNjDd9lipMHmTfVs3FaSXfhzGnUeNe0TjGpjrucfnsJeAI07T62hPXn+1F1?=
 =?us-ascii?Q?B+6rfZWIhxaj4oMsJUek7j929e29y27hJ6ixD32vt/mhAUqQ2+froKlt3Utp?=
 =?us-ascii?Q?BoKkgdl9L8wAdwL/o3RPmGHoX3h0FmPykeJYDEw7IiNhj+DfKwHc4Uo+6Qiz?=
 =?us-ascii?Q?BS3BcgFLf4wv69Bx8wYbcoASUHZbtaY7WjCeSkOPoOEPmVhGY9076CisR1fn?=
 =?us-ascii?Q?PWWK2ibwPTSclYahVVMJA+Y2GZkbyUdREkioO0ZNAqcBBt+v22YM41Y5QIPP?=
 =?us-ascii?Q?7mPKpr96lG1CG2wZPZfkhRlIyWJ4MEB2DfzaaJi16bjhEGg5bMsP9k0i2dPH?=
 =?us-ascii?Q?5Rl+/d3J+AijU0Zf82Pw9E3jDc7kaUaw1Z8h02Dt65UoTh80TRS8QJhV9gBe?=
 =?us-ascii?Q?wJYXDXqK6OYfwu6zEx4bgCeSNtafQSv8Jlzo8kB6JGnX/jGyCNGSXXzs52Ts?=
 =?us-ascii?Q?t0Nrcpj4IKsljsRN8mU6AAJ2tckpJNr0CXd5aIHeaKtAB58ViD/G1/uVXB4c?=
 =?us-ascii?Q?cYQGglI9n1TQhU001rMQmua3p9O0E26fhT/sc+d4WYTH13fyplRiZ7PSR7su?=
 =?us-ascii?Q?97Dj1l4vaJDCh7TQn2SzV6nBUSZL4boaS3r4RDUcgt3jdyCYvuqzIl6YcviT?=
 =?us-ascii?Q?mkQkWvGeEQ0AJBMymW+HfkOikr2cbGlYrHV6r2tgOOQXSox5VQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nR1VTX3d68NnGuj4vOYbpWpl5pRlBY/97ivftcNxzXrQfTAT2ljsdT0sEuGI?=
 =?us-ascii?Q?y/sYfO5MeGhuUTNIDHDY5iB2w7vGjMTSnnLKO2TBPBCw23gqA0MItQ0EbmPU?=
 =?us-ascii?Q?oShuHxl00UpOkSRBpi4Mu081xE6jcTx9oso7Bq7Qs4is/b9RXPt4J1lhIncr?=
 =?us-ascii?Q?ktnUkyQ1liWpVfl0KEU24mnppEPyU6/3KVhedAse82YQtmULcJ42i17PUSOx?=
 =?us-ascii?Q?+iDAOt5VpBnwqv2nL8+yjfajuXsYrk+vw0nx9z84IBkm+1H7vd42PWVcm2gv?=
 =?us-ascii?Q?a7qJ6WNFZUNDRowa1+K+sGXMemFYbnuj8hCTnICLLvRsoSxMFdr9sX/a+hMi?=
 =?us-ascii?Q?cN7Ptbt1q3rK5XsraradEZHAuh0K8q56dyEj/L2MPcMi7zDP+pksrSDMEyg+?=
 =?us-ascii?Q?WsGb69GAfIb8/zRtxgEAzH1+RQ1r5RUNrjk5urudjwnZQzhXhA6ECpdIQHa9?=
 =?us-ascii?Q?NvC5Z7dl9DSTwS+t5Aw2OHLxoK++6DSoNNIRgfnapLJLNriMt5q4RAmjDrfu?=
 =?us-ascii?Q?65COf8+0Tp91sGTHjPFYW0sv71YfDtCiowIFVE18xEJQi54g85rlYW9wBkfY?=
 =?us-ascii?Q?3nTSvSX51h/diO7PxjhbwOPe3T40fhgfeT1Ilry7lRQVqfJnjX6lhkBMcLgw?=
 =?us-ascii?Q?FsaT+e2tUc+sq6qLl3FeR2vAogT+rYlpPjG9JW4UV4/reO38/scx5DTkpRQk?=
 =?us-ascii?Q?SqXJ+4A0krPuTz8DvxUcwUaR2eVSTp7TGvxEtznsGupBRHWjUVYjkPeOHCh7?=
 =?us-ascii?Q?1WWODdun2jjNXzl+IizEQYeI5WyR0LMpvWW8yioy3zRWg/sNje94rIKmgH67?=
 =?us-ascii?Q?r3sN7iMB03VuBtkcCJy7SM5+O1zZnuMgP3CBpNWWKLjueLs4NftCz56DsFxS?=
 =?us-ascii?Q?mGgAnYFT611YAiAfqgfXvBPZp6O4+erOF89+G5C+kvz5JtvwhX4Ovrvrnrxe?=
 =?us-ascii?Q?Za/77TsSUjJ10SpSrXGglkWql4pSce+tk2dHR7+2RA06/E1kUkR/Si3POa/A?=
 =?us-ascii?Q?kH8LUzXSZsBea2Ez0J2PWMM9JmclVAE+zbdWuPF0wkZtawcdJ58iXkCz1bBQ?=
 =?us-ascii?Q?eX9MNCNEl/eEhCtoK7X/eBCvxV/VPINXUxYq5HPrXNOkuYD82foq2wjChS4Z?=
 =?us-ascii?Q?NgJU/JM4fS0jv/h/1s9jhD0js1GX0XpAhs7ruJt39dD5rj/xdqrjerqvSF8N?=
 =?us-ascii?Q?7rnnunWuxpkw3td5Sg2JpveDd2o9LrV7+vfZ4PFbOAbMlBl6nezkx4tkmEJq?=
 =?us-ascii?Q?PrN9uXOIhiJZ3MPe+SYuaC7m4uxq4foKOvr+LEptWBDVuhbN/4RcN4M3pmvi?=
 =?us-ascii?Q?GFcdBYr6qPraRGeWEimibtob7G7dwA4DwOi21OncES36t+PlYkpPa+aRJh6i?=
 =?us-ascii?Q?RQuK/VKRgqgH2ssQlMOltTW9Naz7q7HGEVTKPoFtUHyXKByVpJd8vtkNPmxA?=
 =?us-ascii?Q?YohlapxgCeG/krUPJlZxDKugINnF67AQerT/YiP6YBJFvNu0Qlif6HxERBKO?=
 =?us-ascii?Q?YEd3y717/6fUFCH9sjsLiq7gWdSwP5sOWxa2y+UkiYjObA0ooU/d+fGfc9mc?=
 =?us-ascii?Q?gwdkTMEcuneo+J3/kd/gHjGw5JOVeHbPpOsfH/Yx?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5633cb9-8ad6-48b9-513c-08dcccd339ff
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 11:17:56.5759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3InDYEK0OZ7JH5QT08l/CkP3hwgy6Lfv5G7Yis1mCjZFZHWOQot1ks5pDP7MFUsU/3OvSBEN4npf9FAQAPcURA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10607

From: Haibo Chen <haibo.chen@nxp.com>

The flexspi on imx8mp is compatible with the one on imx8mm. Add the
correct compatible string here.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 3b02c6e2988c..e44424af245c 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -1300,7 +1300,7 @@ usdhc3: mmc@30b60000 {
 			};
 
 			flexspi: spi@30bb0000 {
-				compatible = "nxp,imx8mp-fspi";
+				compatible = "nxp,imx8mp-fspi", "nxp,imx8mm-fspi";
 				reg = <0x30bb0000 0x10000>, <0x8000000 0x10000000>;
 				reg-names = "fspi_base", "fspi_mmap";
 				interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.34.1


