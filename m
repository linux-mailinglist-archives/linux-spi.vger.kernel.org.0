Return-Path: <linux-spi+bounces-9437-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C59B26ECD
	for <lists+linux-spi@lfdr.de>; Thu, 14 Aug 2025 20:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4D03A2870C
	for <lists+linux-spi@lfdr.de>; Thu, 14 Aug 2025 18:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541CB225791;
	Thu, 14 Aug 2025 18:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gBSIlxjS"
X-Original-To: linux-spi@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011002.outbound.protection.outlook.com [52.101.70.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C76822B5A5;
	Thu, 14 Aug 2025 18:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755195836; cv=fail; b=mrBEj1nREd+00UErlVYpkxPxgBzPpKQqqIOmXwPrsbEK2oiM4anx4y8aDmJq/i4o1lhXi5P70IpHBCfFjAuI8sIsmWyWW8afPs+7G0boniNQbjir80n5RDoqiFKZ5iSPHzaTPP59lI2LhyK4jk46QcOJKsONTTk9P2qZLOawcU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755195836; c=relaxed/simple;
	bh=P2uD4xL2CYc5JlVo/MvD8Cu0mR7Y0MINwnXNLMts3Xc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eHOx2Tk2/+9gTX8eNhdQpKMyiqejh5Yj6zWXRMcjuRB+48h+8Jkla57V2wTLomDBgzXsz9uUcndUIZ7qxfQQlDzHZgG9ks+469cQwZvRGbLM7yg4mY4ANosNQArnyFWb5kWk3a/Bh0MOu+FSkXRSS/K+kTYU82D+F7gPf9iL2qM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gBSIlxjS; arc=fail smtp.client-ip=52.101.70.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eB7rLxlF0uSLkbwvtSrjUrnFYA0JXXqfFwWfc4uiJHnH1qFDs2YPkzp53vKOVBtOFCIqPE85YaCladq7fr78iUnqhIQSHVU7qLqEN/NVXAWCBuvd1V2y2el2sY3epSYDh6MFg4jDWA1OmHnlDTqDIiqFCElSZEnNInODAcMF49n6RYmZtrsI4/pyWLoDT1fJbm003Z+/dzJx8jxWFhO5rbEy+RoBbSQ7KQBSlYupjlYJvQXt+msbZJXJXwd7+5IzrEYDG4v7wWqSgJiuRtusjS7KMKZvKS5/Pv9uV6Ddsr+DGd2BrvSpfqjE42Ut2VtaEH41NaazG5Tldtx4/uyO6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nr3z8oYCi0lCzHl+oiX4PH78VsWkYTE67UGPIKC5asE=;
 b=rJ+XlKPI0n3wgQl4zDFBBjjPQaDts+MYn3iFfblRFqI4qcPzl3Dox8DYXZ0hSVvHSLHbavmab1yhGEl4QZPuXyqr/ogielOdgAEP2OSpPY2WPAdkx37Fj04NRIzuDlvcoNfob8UBm7d23zM6hmxMcfwFjE0y/9mtixEOQQ+e39oLTDnYcr88qJhXHI/OC3DviKaYSz2EerY0PY2k2N/Y26/uBudZ9efjwyf64ci1nd9mBwM7k1xtfMYXQDPtI5i0Esnhbo72nUjPvAYZZlcB1fgHtv0Q2vzEV3ZKgt8RoyZeX1y1/v5rC4TXaqKPuSXJIW49oJV4WHlyqH70Y9Ed2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nr3z8oYCi0lCzHl+oiX4PH78VsWkYTE67UGPIKC5asE=;
 b=gBSIlxjSHmrhLEVL2lKMnXFxzFJqTdRMeKBxw10NFRB1ZFvtbyJYl1ECwVjtTjD27BNoqABLbgcjQ5inCu3Di+DYbLNRvtRC3OdTCrLaDz0o6DknOQYGuiv18wxsHBuczhsPEh5fjDbzoE52hFLg42o1cVMAzfxlo2pkJxKWOtmXaQFRKrhP//ptcPBJPzauEEJUyQVWALadlSlUj06C0ASDa74mJjHoJjeiqMS7ij0p4Wg40T/uDMLD2miOZ2K727O82xTksPCWMTD/KfcO7rxXbIOvHBDbsVxNplivUd56HA3oFP0Lhmf27Aeud76IeohvGexFteTSAw93gGYnDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB8552.eurprd04.prod.outlook.com (2603:10a6:10:2d7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.17; Thu, 14 Aug
 2025 18:23:51 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 18:23:51 +0000
Date: Thu, 14 Aug 2025 14:23:45 -0400
From: Frank Li <Frank.li@nxp.com>
To: James Clark <james.clark@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, Clark Wang <xiaoning.wang@nxp.com>,
	Fugang Duan <B38611@freescale.com>, Gao Pan <pandy.gao@nxp.com>,
	Fugang Duan <fugang.duan@nxp.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Larisa Grigore <larisa.grigore@oss.nxp.com>,
	Larisa Grigore <larisa.grigore@nxp.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>,
	Ciprianmarian Costea <ciprianmarian.costea@nxp.com>, s32@nxp.com,
	linux-spi@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 13/13] dt-bindings: lpspi: Document support for S32G
Message-ID: <aJ4psW2Qul4x2bQ4@lizhi-Precision-Tower-5810>
References: <20250814-james-nxp-lpspi-v1-0-9586d7815d14@linaro.org>
 <20250814-james-nxp-lpspi-v1-13-9586d7815d14@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814-james-nxp-lpspi-v1-13-9586d7815d14@linaro.org>
X-ClientProxiedBy: AM0PR10CA0100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::17) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB8552:EE_
X-MS-Office365-Filtering-Correlation-Id: 42444cf1-8009-420f-2154-08dddb5fb7d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|376014|7416014|52116014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WtXwQmgGFxLA2e9hDR1Fk+ypOPQXhOSUm+xfO4PP2MaV/ZM8jple8eJ0mIgj?=
 =?us-ascii?Q?VBrn0Snfp7hMA0wSQBeOSd7qi+//1rsSJQRDOPdTpdwwLSiOB4/gxJzHF2Yw?=
 =?us-ascii?Q?etd7ZkmmgQGzQ9a9B68tHBLYIBeBZSU81IhdHsvzMBYdEITTECzcBmbkv8F9?=
 =?us-ascii?Q?AGshl9PjRWE89W+yOSkOtEJhOcW2mreWkCj8fd2czc9KzrimfYcCAX4fMW3N?=
 =?us-ascii?Q?rIn9nXhiGQNGkR/Qh2lDrnS8A8U3MzMF+J1AAKksmZmt1jHV44s2VRhlz+dL?=
 =?us-ascii?Q?Iuu3DShriofc7qeBdyk7qUa1SIaMh5W1DVwYhU/XiahsXu6qHqCDb1FESW0N?=
 =?us-ascii?Q?jNVZYWU56lHfWNiwDQTLWzbcj0dNhFGOpd+TOhSSsFABOQ3vF67+Hy25DJZM?=
 =?us-ascii?Q?XJw2DeLJEu217hPn/oSelr0aopccqhBrNDug58pXR1Fvld9BA/hfuQGc+cz0?=
 =?us-ascii?Q?IK9+zRtuDR+sX+2gJBF0xRYidIwKFkflW8a/sHSjOGO1iUpus8KQV9fIPctU?=
 =?us-ascii?Q?Uue4VF65WucGfqxkm+PwmcSL4T3LG0Gn4wMqjBwXOKmkKAXZt1auZ0FW3bfH?=
 =?us-ascii?Q?8Fu8yTmM06Rtf3BaoUnfx6vpNJxL6cdAbhbQpCK2Noy8Bo9T75NFWIDeT+VW?=
 =?us-ascii?Q?f5VGIsqOHbhy263P0s/Nm2RU4LFez98vpvclKtn9Iwwv9VcbVz1t3SYIrnLd?=
 =?us-ascii?Q?ztXvXzrWE108tN5A7scWu9CViylBtJGzjUSFGVycnA5p9kb6EbqZN/FXVp7m?=
 =?us-ascii?Q?eb5tj7J0dn+9j3ohQG1xkbsuF9ayY1QTofauNMEPavBI75Xx+HrIhFPF3Hqa?=
 =?us-ascii?Q?EKFVi3lM2TlzErKiT0zwRNqImG2HPZIByMOGskRXo1Yx6B3Erb7SzNJRknS4?=
 =?us-ascii?Q?oRAj3UqABh+96Q5JfWX7zH5kn3Pe3fZFLqGkwxRwfe9faF/BQBho3bQbg+wx?=
 =?us-ascii?Q?iEGTjb39OjlVuqs4zL4WhLStaDtvJyCvf+B3xE+flfBScwx/OWbjgc+blSQc?=
 =?us-ascii?Q?y+qDKhT9z5rFC60gsi8rAbMaxn8f0j6ZGdw+lr97NfnEx/9xgcZ1Hjf+XuA7?=
 =?us-ascii?Q?dAFkNfwh3iRREAP9RKM1F7SRrmDG8IACTQaTIEwIgrfqh/Q6XtIdv8cARjvs?=
 =?us-ascii?Q?dbpVwb0lwIm7kKM9GaGhHFfLkCyv6a1NLV2c33xvsex9m6v1NUXBQ1i9mqmn?=
 =?us-ascii?Q?oDcDDTQxOPu0Nw8ezldftxXbJpJ70ln09OtiLF2kkp0BJJsehgJPIAkPj+sx?=
 =?us-ascii?Q?ShWHa4NvjLpaGB2iucaoL5P5n7gLXms9EsBcX7yu2pjxe+2xc5xqyvFzE1I8?=
 =?us-ascii?Q?d1jHbBqhFaYhlAfPRODm+WQ1trBEuWN8BKN9xdR3r+Emf93pQBCJXQXY6UKd?=
 =?us-ascii?Q?EsUMSE1e1nNSjuqVYVoVEd7ISMiw0VBW2TreVtasJPpAK4y3UbnujvY9M92m?=
 =?us-ascii?Q?xrFhzBHf6xzgmTIHPMcQuZzblOwNX4EUUzAWzw6mPiJbpWa3b3gKBw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(7416014)(52116014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dMY8hrUSjvv36KSwHztN/mgd+2f+Z9j3rUcaUVwOaFR//TMY/uEcRhYFzhla?=
 =?us-ascii?Q?cEL5Lo/XToAa8sGNrqMtB5GKc5INNJm3pL4qslx07nZIWNVB+BWY/TWk+nZb?=
 =?us-ascii?Q?f290HwIRzrU07wMafL1EgtmPWMYcANJqjI2wljzdGAWCekrGevaCFy9fWtdI?=
 =?us-ascii?Q?c3BCzxFahxHxiGXsKNlg90G9Bm7fuu95rDXDVM3KGfoljOl+DdM9TR6DtvJ1?=
 =?us-ascii?Q?55qI5KIhfh0LFp4kN8scOrh9cRreacD4cSdcw2EAId73YfIJxtMvYwf2EDcE?=
 =?us-ascii?Q?T/Nvq9P67+X90rTA12wNqwSW2Zti6WUsg3S6dHOONSUUZU01MkCPPVfNQL0a?=
 =?us-ascii?Q?m9+sOK2tr+Jke1g6Xeh2j/AVyfB+s97j99TutWkoOquIKF2HcPBcbPdloJsC?=
 =?us-ascii?Q?WpAgJSD6NMj0m5wapRxc1UiB9XAdNUSlI7mXBU7FHJRwcGttn+zXIeGfLxxE?=
 =?us-ascii?Q?Ez4sTBZvH2CDs9tkEDgWKshDJw2Y9PLCT3Kdzi1v9cNjDedEpUrWwkCU86x1?=
 =?us-ascii?Q?OoXc9p9u+j5Pizb3zekSMl5oXd6TtrXCkAEGn007S9nscRfsMfOeikidr8pr?=
 =?us-ascii?Q?kOrodkhFM5j9HJ1MxGMRZ8V3AU6qKVV10SQ6He1mBkNpfTUFAO6XREAfJISv?=
 =?us-ascii?Q?Hp9Gq6YL9Eba86wg+ZHZIg+mxK8y7fH6JJfUBQdMc43ybBnW9ZpTLFab8GcI?=
 =?us-ascii?Q?sEPH8f7nFiY+iwi4pzpyLNPGxlbH2llidyEivgDRMn/0xzMv65gyNjPremQh?=
 =?us-ascii?Q?t5bURFjxWuXxmdAZ5IFjFattLB6ThqjBpxZMsRlPRuuHZ9q3PTiiNubf8Ubw?=
 =?us-ascii?Q?lvlxkuCnKBYyZnlwGauppsgZ19dpDI6vT73796sfQP9q4kMG1dAfZTnwhgFp?=
 =?us-ascii?Q?uGoxQHHGlvyQYYUF9+J/QG9mRVOhw3oIN0kCfh4sJwGQ4mTXYwZTESyGzQAL?=
 =?us-ascii?Q?hoY07qv73Hs2OPKVBCCzmla8DH8k5bfBRE7R6ZPXj9t4R26A724dm7wa/YBO?=
 =?us-ascii?Q?vRByssQcuV+c4JHxeCt4Icwk0NIf9rgVCC2i2VcrxvhjGSbX8hWzfU3+Z4f9?=
 =?us-ascii?Q?eFXWSUDoXxxrlbyqjs9U+MKr/Of939B1AyA5SarVT176ak+uS6ffX3EXxfPq?=
 =?us-ascii?Q?KGLVvQ7JjDRYkrKZcw9ynpQF69qBBmecc3h4u7I6oqf3Oa3z+3lRxD0djFkc?=
 =?us-ascii?Q?NGzu7OtQvt5qMLE0sFcU9qtlnRenSgd2pQtj1Lx3LGPhj+rFKplUk1V1wTj4?=
 =?us-ascii?Q?8MTuHqqVcCPivhh9KLmERLlF1pjtikfwUw2dzG6xvM5+03BywRGS7l3IsDFy?=
 =?us-ascii?Q?/BOHI/UzBKLrlAYs+qjRlZFzt7o7p8r0n2VjaIoXhkXT3YciVHDsZlOr6ue0?=
 =?us-ascii?Q?6eC4Wytx/tMubTZvbmEKQBg9fNhpkv8y9j2VbcSDYIHgL4kbo8C9dRF3W4cB?=
 =?us-ascii?Q?mal9P7xRZi6g1ycnz9ArVvMi1ua4tsXa3L8XIAPG99e2NTrMXTm7GojiF+93?=
 =?us-ascii?Q?6OMh/7ObqHMcNwvRPC8i7LSZVyWXTZrEQnaDvg9j3IepSZHv49dghpr/wko5?=
 =?us-ascii?Q?OR9M00PD+BS4iDK34fU4H3iGWCIg0p/RK4I5HGRG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42444cf1-8009-420f-2154-08dddb5fb7d5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 18:23:51.1032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l+GUIHLgm1It4GK1dmsgn+dNTO0SUgicwtrXRQKcr3OW/D03rE5aF9kAYlWLn9WFZL6/cseNY1V+6ooKkWXoSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8552

On Thu, Aug 14, 2025 at 05:06:53PM +0100, James Clark wrote:
> From: Larisa Grigore <larisa.grigore@nxp.com>
>
> S32G2 and S32G3 are currently treated the same way in the driver, so
> require that S32G3 is always paired with the S32G2 compatible string
> until there is divergence in the future.

Add compatible string 'nxp,s32g2-lpspi' and 'nxp,s32g3-lpspi' for S32G2
and S32G3. Allow nxp,s32g3-lpspi fallback to nxp,s32g2-lpspi since back
compatibity.

This is independent part with other patches, you can send seperately.

Frank
>
> Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
> index 3f8833911807..9fc98b0f3428 100644
> --- a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
> @@ -20,6 +20,7 @@ properties:
>        - enum:
>            - fsl,imx7ulp-spi
>            - fsl,imx8qxp-spi
> +          - nxp,s32g2-lpspi
>        - items:
>            - enum:
>                - fsl,imx8ulp-spi
> @@ -27,6 +28,10 @@ properties:
>                - fsl,imx94-spi
>                - fsl,imx95-spi
>            - const: fsl,imx7ulp-spi
> +      - items:
> +          - const: nxp,s32g3-lpspi
> +          - const: nxp,s32g2-lpspi
> +
>    reg:
>      maxItems: 1
>
>
> --
> 2.34.1
>

