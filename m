Return-Path: <linux-spi+bounces-11616-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 690C4C8CC39
	for <lists+linux-spi@lfdr.de>; Thu, 27 Nov 2025 04:41:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E1B0134C114
	for <lists+linux-spi@lfdr.de>; Thu, 27 Nov 2025 03:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3CC29D294;
	Thu, 27 Nov 2025 03:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ubz4J213"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013027.outbound.protection.outlook.com [52.101.72.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B92F1391;
	Thu, 27 Nov 2025 03:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764214905; cv=fail; b=WhJVAQrh6/oGjZMFG3UXsxGLQ0iOOmYtdMxK9mVCB1Lk3QjSz06TB2UBOfTtB3kN6qev31oh18xovzQYe4KP3mogfeLuov0gW+Zglb7vFzCno3NmubOJ5Gm6xuhOOjwvyfTK4ToiY+bEa4yYIGKOOL0PrR5MiajK8JEB8QjmABI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764214905; c=relaxed/simple;
	bh=GL2LoIUec4nISvu0k2gUYlbKKSE5FHL/Q8KgAMjhQIo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iRCi1LRuG6FuBNpRX3uJcQ5/Lly0taoFuUV8cie4mYQOMS9oqbhKPNaz1JXBo00bX3NPu66Z68fawPzOztjb7CXj9ap+HRt+Z00+4Cu9DG3FTpR3hWjOETCh7PQYhQcQDZ8WC5iEAyOJGxjepY1msu2VIdkLt77Qp7xDDffjWbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ubz4J213; arc=fail smtp.client-ip=52.101.72.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fsl3sTVPRSa81jyxWOB1Wte7SCVn5MVSswxcFMOo9PmN1+874DNujoIZ84flzn4gl6ZLHe/BqR6uzLFPWUEukH7T1p0YOswLYbP+YQLBisXiuMaYvTphVz3AMAbhnycCdYE4phvAih3uHKMGxxTNyZD6I6Yhs4BB7MLSKCo5KHlAfc4/CR8cY7dX314JtCF71kNRJS2anwHZDA+/Q7E3HuMg8cmV/qnFgt7klf4yqwS0yfHRCHDI5dbY1wg/Tpd1Zl0+O0gb3vAhzg5Av5j4xM0+vZs0qkcjHA8JkEZiCfPULQ8t5bNU7fk7kI0GHWMlu+wWQJYHSywz2qjMcI1tSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GL2LoIUec4nISvu0k2gUYlbKKSE5FHL/Q8KgAMjhQIo=;
 b=LHNks8XgnRG4H7BAXjemG1SPvK78wwvrOkKNhEPeOMVWM++QLLcq93RY/aVSc3vW7dALdfMQd5CGy6RZXCaWGESdJbBARwj+62tn7QDzjO6vGVVXCiuZ/5orBTwjDVA2K0zwkD78Py3Kipsf73+cdagCNvYmru2d2/EX9kT1HoBs7S4ifBliBQqdacg5lFSN9MS7QXWpcA0Hc2xpRG1thwmo5S6UlaC6Mi7SH6wkaepccN9CgvVzozraqN/3nTFn2/bsNGQHK7sxHJiNjzPFjgysLyP9GKWCOgnA5d+gay4pMtx+dcDicjT88K8gWbLwfAd2fzB15i3FyYDYIM7mFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GL2LoIUec4nISvu0k2gUYlbKKSE5FHL/Q8KgAMjhQIo=;
 b=Ubz4J213uPqR7ZmWlm9mvMvOUFN2vDK3cnvzyq3bVZfO4m1o+fzmF6kxSZJCYQi2rkZOSoXQc2eVOvoLtuYnhBq7xfbSy4MhzUtfCg2X+WpDY7U+sMOvqQj7q0sQHwfbYbLTu2se3Xzf4hmSlRYtlSo+SIK6gExqCICszcf/QmXt/YOxeR2Nek/TNiarmFOwWMoxYlHeuWHEAi5kn7HVEY0EcEOIkXVwz9vlPN/s9AeM1O1ILpvts4uB+5gDCz40c12KluDwCKSPHxA32uHAyZHjt+WDpIMl4nOloJatrTVBxLcw45owXdLrZ0KCaAmfmwkiIDtfxwub6bNrHbi6iQ==
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by DBBPR04MB7866.eurprd04.prod.outlook.com (2603:10a6:10:1ef::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.14; Thu, 27 Nov
 2025 03:41:37 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33%6]) with mapi id 15.20.9366.009; Thu, 27 Nov 2025
 03:41:37 +0000
From: Bough Chen <haibo.chen@nxp.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mark Brown
	<broonie@kernel.org>, "linux-spi@vger.kernel.org"
	<linux-spi@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Han Xu <han.xu@nxp.com>, Yogesh Gaur <yogeshgaur.83@gmail.com>
Subject: RE: [PATCH v1 1/1] spi: nxp-fspi: Propagate fwnode in ACPI case as
 well
Thread-Topic: [PATCH v1 1/1] spi: nxp-fspi: Propagate fwnode in ACPI case as
 well
Thread-Index: AQHcXxLFAZWsvobtAU2fAsS7FvLewLUF4KsA
Date: Thu, 27 Nov 2025 03:41:37 +0000
Message-ID:
 <DU0PR04MB9496A87FC85F20D9649D35D190DFA@DU0PR04MB9496.eurprd04.prod.outlook.com>
References: <20251126202501.2319679-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20251126202501.2319679-1-andriy.shevchenko@linux.intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9496:EE_|DBBPR04MB7866:EE_
x-ms-office365-filtering-correlation-id: e7f6ca3f-33e3-4ce1-89d9-08de2d66de55
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?gb2312?B?VzlFOGlqQW14dHllaGpFaG1iRXNwOFVnalB5eDMyZUlaRUo0TzcxYmQ5dlhV?=
 =?gb2312?B?b05wUUVWbm9odWljTjV6Qk1ibGpPVVZMYm9HWmZpalpQcmttWkJRU1UxN1BL?=
 =?gb2312?B?TVNFYThYaU5LZmxZRlVDRkxva3B0aXhvRWc2MFl1TWRmSzA3V2V1Z1R1TDZO?=
 =?gb2312?B?UFc3d2g2ZHhTeUVuQU1sU1U3K1RmZWh0YjhWVTNyemZRWENoZFBLakhxV3dn?=
 =?gb2312?B?ZWZFSmhFejl4ejRWQW04ZHhuUERvMDZIYkdVemhVMkNtOTN3MjN5REozOStB?=
 =?gb2312?B?VldpRW1qbG9EQy9zYnArQWJDekFpWm5sT3dqQ0o1bXZVTktRSmpFVzhzSllH?=
 =?gb2312?B?elFnN1FTN01YeTRkV2QybVZ2TTVldkpOUGt0eVRDVGJ0MVR1clU0dVYxYk9z?=
 =?gb2312?B?VE96RkZjK2w4VWQzbE5pVE9iazMwL25FbkpNc0R3TmJ1UzFVWU5zOVVEdzZs?=
 =?gb2312?B?MHdSYnBTbnVUVUZBanE0MXo3bFFMR3NGZi9wRWxqZ1BGMXFWWEJHZjVNRmJS?=
 =?gb2312?B?V0RFMnpIQnFqRWNVbThjWWd4WFlmcURiMVdWZ0pwZmNxU3YwUUgvWXdEVzAr?=
 =?gb2312?B?OGZHNVhGMVpWbjh4aTFQRlp0MHVBdGpERFJjb285NldhZ1o3cW1valFHNUtX?=
 =?gb2312?B?OUVuOG44cGJEUmxHWEZxOGJ5RzhlYnNyTkNGUW9sWnVtc1VoMk5QSVM2b0VF?=
 =?gb2312?B?am5Rak5KM0dzalBvNFNOK29vMzNVSnN6YWhOUnZuc0tiRG8zVTlNR0Qvd2Vz?=
 =?gb2312?B?QXRzSzFib3k2Y3grSVpCaFNNQ1hVaHJtQkpnQWFrYklRWGY4aEczeGpwbDlu?=
 =?gb2312?B?Ti9xUk0vSitZTzJKNEh5VElOcmFEWUJ6cWVFRkF6dXdUd3VRcENLRGdNcHNF?=
 =?gb2312?B?THlUMm5YTTdnMzVxNHRyYXNqcjEwVHhwYm11eExxNXd2Y0JWZ3pMZ1loMmND?=
 =?gb2312?B?ODd0TVZBMnFnckRrbmkrMDY4SnM1aHNjU2lOZTJjb1dCVDdaeHkxb3pyUmt3?=
 =?gb2312?B?QVp6alNWU0VvRktITGJxeEFueU1CNUFMalAxa0pXUFlpK3BsMVBGQWpPTlNT?=
 =?gb2312?B?T2J3YlVBcXdwbGtoMzV6V3d4Tlh4MFhoK2dMVnJ5Wk9UUU90YnYrK0dTa2dU?=
 =?gb2312?B?ZVJndW93eEtTUlZFM25tZnZpUXBQUDlzdGFXODh6a2FUbXZwbmlReE1LRXVj?=
 =?gb2312?B?UmhRYkU0MXl3cWxOMEZlWUVHVS80eTNYNTg0WjRaYWVsZTNOTjlpSzJUaUMy?=
 =?gb2312?B?V29YekNDS1VLNnllUnRHQzVsaXBST2pkZU5vcEZ6WHBwemRWZDNReGt4Wmt2?=
 =?gb2312?B?N21lWStoMGJkTXZYdThSdEZZZFU0ODNScXcyMUxCRXNBOEJZZDZjMUxGN0xy?=
 =?gb2312?B?YkVkaEp2dU9RSXNFUUluT0h5MEhzU1Zreis4Wk9DOWQ5dXFSdkM0a2FvVUIw?=
 =?gb2312?B?ci9obDRqZGcxTjZzK3gvbmNTQStBSVI4a0RISEdxd2pvZ3pXNnFPc0JGQVJn?=
 =?gb2312?B?a2xGRVdscWZjNzZmTiswcmdoZWxnTzNXd1BFNzZ5TjZpcitObmY4WGpYZnlz?=
 =?gb2312?B?b29OOGJXeUgxSklRNDI5RTE5dE5SSnpKNS8vNjJtajliQkdWVDFKR25jVFNm?=
 =?gb2312?B?cmQwQ0kvOFNlU2ZYTnJLYUpCRlU5bi9UaHZlMzhVYlBMZ1NFN3N5V3FGYzVz?=
 =?gb2312?B?SFRWeDByb2kvNVZQUUJtTnRWZlI2NGRvbWliU3M5UDdRL25pN09jbkhMZmo3?=
 =?gb2312?B?VDF2dDBHanBUNC9obG5pZzRZMGNvay9ZRE92MUxCQnhtWmdpb3VCb2RpazRV?=
 =?gb2312?B?T0puM2F4NkQ1cmY2NjBhb1N2aHNNWDBOMStwOC9wemVkYWp6N2ticXdXWnhD?=
 =?gb2312?B?VzNjSFQwbzhSSkJiV0xCSDhvaDR5dnNhNXNGVVlUdXBLcWxCaWZwVW5GR3Zw?=
 =?gb2312?B?dDhrQk95MVFwb1ArTXdRTDFZUFEwWTM5UlR5S0MwN011eFVOZFlNcnNJbkhU?=
 =?gb2312?B?blJtcm5keEVvR1VjblFqcFZCTDdaL0JTZ252WUdqNnEwQlB3N0VtQU1Teno5?=
 =?gb2312?Q?f5oU3C?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?TFZNQ1JVNVMwWTJMblFWU1h0SVpBM25uSW12QnhBSEl5UnFJQUg1R0xmZXZs?=
 =?gb2312?B?aXJLQXVYcmRNTWh3M0l6OC82aFRKcHplYUdUaW5xUktRWFc5NXhxYnpqUEh6?=
 =?gb2312?B?eGRoek03SzRta3gzSllPWFdxaEdDaEs2dkUwRmZTRTFQSGNyNFRsZUpkVHFr?=
 =?gb2312?B?MkIrMVVlaVNRZGY2b2FIb2ExUXpzcFpVc1ZiWFc0ZytaVG5JVlRra3drRHVa?=
 =?gb2312?B?V0E5NFFLYWFCc3gxZlJnTmZxL2dNTGZRV2o5MWppRjh3UVVyZE9aOFUyKzZY?=
 =?gb2312?B?ZkNpajBBUHAyQnVjald1TjZhbnpGajF1VXBTTFM1WEwzNlRBQW12MjJ1MHVV?=
 =?gb2312?B?ajd5WDIzWFhzWExiQUtEemMwNmZXNmFna0hTZXlZRmZOOEJlc0xDcEZNdGVZ?=
 =?gb2312?B?VDhVR25lRVJ1SXNTZGdBMHNmcHRUQS95UlowRXRGcjR2SWpIcExqOTZ3QzY5?=
 =?gb2312?B?SzdwdU1KYzBCQzR4VFFwZW50eTQ4ZXRxdDVWZkQzRnhkZGZOQzJaSmxZaHdr?=
 =?gb2312?B?SHNVSVk2RWMrc0I0YkJaL2wxTE9kb0dsb3dtdkFUeHpWQm1qUEJibHZWbzd2?=
 =?gb2312?B?NS9VWE1lZlNFYTcxVllnbVRURW96ZkpmN0tjWUZDMWpmRHVVd2toWG4rd2NS?=
 =?gb2312?B?eHdzandzcGdXWDRoQWMwbUlKMlNqMVZUcUZnY1NFRkpxT3Zsa0krYzVHVE45?=
 =?gb2312?B?bWhxRDdTU1JpOVZTdWhyRHVWcEJWKy9yMmVQUitLSWI4Nml1UVRpWkhUOWxX?=
 =?gb2312?B?ZGdhRW1hYlgyWGducXo1SG1kMmgvYlhKU1crOVJXVUUwY0NTUVMrVSswNS9B?=
 =?gb2312?B?U1RSR0xDU21QenVPYkZQT3ZTaXc2UmZ3MlhRRjRlSlJyTjRnWTV4dEJYK2hn?=
 =?gb2312?B?ckp4TDRaVTFHWm83R012aEZJckkzNkRxMFB2ayt1Y3NqMS9CQ00wVFl1Skx5?=
 =?gb2312?B?dU1IQmhwSUFnemlpTlFQMzdaZG5ST1V5REZFeDhrRExZZUdSa2VEc3VpSjRm?=
 =?gb2312?B?VXdZdnN3SUY5RVVUOTB1NFBucTN6cnVNQ3MyUThrSmFYZzh0dnIyVDZsWFRt?=
 =?gb2312?B?KzN0cVkyandxV0dJUUdtMzBoWjQwaFlEY0IzQ081Nkgydmw0OE5mL29JRlJX?=
 =?gb2312?B?WlJCMlZaZ215ODROT1ZUcWFkWGw2VStrSm9RQkxnVjVvRkk0QURDN1lDekdU?=
 =?gb2312?B?ejdtVHh6N050a2hEcUIzMjM0NHNFQ1RMQ1ZGaDNWdFlUNkNjNTZ6cm5kc3dF?=
 =?gb2312?B?WWFrME56Y2EvS0lDTTIvN0pWQTRXYzU1V1NkY3p6Rmg0QkJWVGtSbU9jbXZ1?=
 =?gb2312?B?cHJJcTdnSmVvZGJoQmhoVEFPeDd3VGJ0b21qMjNhUE9TaW9oUDVJR05PcVVS?=
 =?gb2312?B?NGk0MnNiMHBwRXpCVDVMeHU0K0JJZEt6dUQrYXhpU2ZpVjJLQzArK25qYjk5?=
 =?gb2312?B?cERuSjlOdXpsOUlTcTA3SHpUVnI0M3FIeDd1am4yeWdnQVdVdlJzK0Q5Vlp2?=
 =?gb2312?B?SU5KK051Z2o5TjRjN09FSkNtMW9ycmo1YjdmTUpuWTZCOTVMUkM0dzA1VU53?=
 =?gb2312?B?Mll2TE1xOXBoNEYrYUN0V21LbzZxTzNCREU1MWgxZURmeEZHVGJCWG9nQitv?=
 =?gb2312?B?SjJZR2JNOGpZMWdmUHg1K3ZnSklnVE5LbXNHNmsxKy9RL0pkc2hQZW90VmxZ?=
 =?gb2312?B?RVB2emZEZG00b2Q3Q0dEd2hYOVE0TFY2Nkw1TGFxR2NSa2hHTnV2UDYyWCtx?=
 =?gb2312?B?andCb3U1RGZQTjd4bTlYREgwMGNwSmUrZ21UbmlDUnJaaWpGOTNDMHllUUdu?=
 =?gb2312?B?V2Y3K0R1U1FSSE96NHdOVnRhV2o1eUdWMjZFSStjQjVaeFdvL3dIYitOTklD?=
 =?gb2312?B?ZEpPV1cwbTMzU082dk1tOUZIZW9oRnhsTm1GQWFpUEdpYTVhYXcrSVVsdXpC?=
 =?gb2312?B?TTJnN0ZiTzNiNWpqaEYyWnAreTdRYSs0M2w0bzNqbVg5TXc4QTVTZGUxd1dx?=
 =?gb2312?B?RGQ5a2NlODlGR2l4OUVENUFVOEQyNlNRd2s3WmlqWms1SDdLdjE1RXFXcnZr?=
 =?gb2312?B?MGN6QXlxanNWRDVjV2w0bWQ4M0kxMHR2bHRJdGtIOEdpTno5MDdxM0xFcXl1?=
 =?gb2312?Q?SVvw=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7f6ca3f-33e3-4ce1-89d9-08de2d66de55
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2025 03:41:37.2644
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7M0Sa00/jHRstDmcVAS3YmTLCjYXzJ/k/FCos2mHKSEzCXjXGNBMlhbQU2zYSBvzDTZh6r3S5f+tMccW+u1cGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7866

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbmR5IFNoZXZjaGVua28gPGFu
ZHJpeS5zaGV2Y2hlbmtvQGxpbnV4LmludGVsLmNvbT4NCj4gU2VudDogMjAyNcTqMTHUwjI3yNUg
NDoyNQ0KPiBUbzogTWFyayBCcm93biA8YnJvb25pZUBrZXJuZWwub3JnPjsgQm91Z2ggQ2hlbiA8
aGFpYm8uY2hlbkBueHAuY29tPjsNCj4gbGludXgtc3BpQHZnZXIua2VybmVsLm9yZzsgaW14QGxp
c3RzLmxpbnV4LmRldjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBDYzogSGFuIFh1
IDxoYW4ueHVAbnhwLmNvbT47IFlvZ2VzaCBHYXVyIDx5b2dlc2hnYXVyLjgzQGdtYWlsLmNvbT47
DQo+IEFuZHkgU2hldmNoZW5rbyA8YW5kcml5LnNoZXZjaGVua29AbGludXguaW50ZWwuY29tPg0K
PiBTdWJqZWN0OiBbUEFUQ0ggdjEgMS8xXSBzcGk6IG54cC1mc3BpOiBQcm9wYWdhdGUgZndub2Rl
IGluIEFDUEkgY2FzZSBhcyB3ZWxsDQo+IA0KPiBQcm9wYWdhdGUgZndub2RlIG9mIHRoZSBBQ1BJ
IGRldmljZSB0byB0aGUgU1BJIGNvbnRyb2xsZXIgTGludXggZGV2aWNlLg0KPiBDdXJyZW50bHkg
b25seSBPRiBjYXNlIHByb3BhZ2F0ZXMgZndub2RlIHRvIHRoZSBjb250cm9sbGVyLg0KPiANCj4g
V2hpbGUgYXQgaXQsIHJlcGxhY2Ugc2V2ZXJhbCBjYWxscyB0byBkZXZfZndub2RlKCkgd2l0aCBh
IHNpbmdsZSBvbmUgY2FjaGVkIGluIGENCj4gbG9jYWwgdmFyaWFibGUsIGFuZCB1bmlmeSBjaGVj
a3MgZm9yIGZ3bm9kZSB0eXBlIGJ5IHVzaW5nDQo+IGlzXypfbm9kZSgpIEFQSXMuDQoNClJldmll
d2VkLWJ5OiBIYWlibyBDaGVuIDxoYWliby5jaGVuQG54cC5jb20+DQoNClRoYW5rcw0KSGFpYm8g
Q2hlbg0KPiANCj4gRml4ZXM6IDU1YWI4NDg3ZTAxZCAoInNwaTogc3BpLW54cC1mc3BpOiBBZGQg
QUNQSSBzdXBwb3J0IikNCj4gU2lnbmVkLW9mZi1ieTogQW5keSBTaGV2Y2hlbmtvIDxhbmRyaXku
c2hldmNoZW5rb0BsaW51eC5pbnRlbC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9zcGkvc3BpLW54
cC1mc3BpLmMgfCAxMCArKysrKy0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25z
KCspLCA1IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc3BpL3NwaS1u
eHAtZnNwaS5jIGIvZHJpdmVycy9zcGkvc3BpLW54cC1mc3BpLmMgaW5kZXgNCj4gYjZjNzllNTBk
ODQyLi41MGE3ZTQ5MTZhNjAgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvc3BpL3NwaS1ueHAtZnNw
aS5jDQo+ICsrKyBiL2RyaXZlcnMvc3BpL3NwaS1ueHAtZnNwaS5jDQo+IEBAIC0xMjg3LDcgKzEy
ODcsNyBAQCBzdGF0aWMgaW50IG54cF9mc3BpX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UN
Cj4gKnBkZXYpICB7DQo+ICAJc3RydWN0IHNwaV9jb250cm9sbGVyICpjdGxyOw0KPiAgCXN0cnVj
dCBkZXZpY2UgKmRldiA9ICZwZGV2LT5kZXY7DQo+IC0Jc3RydWN0IGRldmljZV9ub2RlICpucCA9
IGRldi0+b2Zfbm9kZTsNCj4gKwlzdHJ1Y3QgZndub2RlX2hhbmRsZSAqZndub2RlID0gZGV2X2Z3
bm9kZShkZXYpOw0KPiAgCXN0cnVjdCByZXNvdXJjZSAqcmVzOw0KPiAgCXN0cnVjdCBueHBfZnNw
aSAqZjsNCj4gIAlpbnQgcmV0LCBpcnE7DQo+IEBAIC0xMzA5LDcgKzEzMDksNyBAQCBzdGF0aWMg
aW50IG54cF9mc3BpX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UNCj4gKnBkZXYpDQo+ICAJ
cGxhdGZvcm1fc2V0X2RydmRhdGEocGRldiwgZik7DQo+IA0KPiAgCS8qIGZpbmQgdGhlIHJlc291
cmNlcyAtIGNvbmZpZ3VyYXRpb24gcmVnaXN0ZXIgYWRkcmVzcyBzcGFjZSAqLw0KPiAtCWlmIChp
c19hY3BpX25vZGUoZGV2X2Z3bm9kZShmLT5kZXYpKSkNCj4gKwlpZiAoaXNfYWNwaV9ub2RlKGZ3
bm9kZSkpDQo+ICAJCWYtPmlvYmFzZSA9IGRldm1fcGxhdGZvcm1faW9yZW1hcF9yZXNvdXJjZShw
ZGV2LCAwKTsNCj4gIAllbHNlDQo+ICAJCWYtPmlvYmFzZSA9IGRldm1fcGxhdGZvcm1faW9yZW1h
cF9yZXNvdXJjZV9ieW5hbWUocGRldiwNCj4gImZzcGlfYmFzZSIpOyBAQCAtMTMxNyw3ICsxMzE3
LDcgQEAgc3RhdGljIGludCBueHBfZnNwaV9wcm9iZShzdHJ1Y3QNCj4gcGxhdGZvcm1fZGV2aWNl
ICpwZGV2KQ0KPiAgCQlyZXR1cm4gUFRSX0VSUihmLT5pb2Jhc2UpOw0KPiANCj4gIAkvKiBmaW5k
IHRoZSByZXNvdXJjZXMgLSBjb250cm9sbGVyIG1lbW9yeSBtYXBwZWQgc3BhY2UgKi8NCj4gLQlp
ZiAoaXNfYWNwaV9ub2RlKGRldl9md25vZGUoZi0+ZGV2KSkpDQo+ICsJaWYgKGlzX2FjcGlfbm9k
ZShmd25vZGUpKQ0KPiAgCQlyZXMgPSBwbGF0Zm9ybV9nZXRfcmVzb3VyY2UocGRldiwgSU9SRVNP
VVJDRV9NRU0sIDEpOw0KPiAgCWVsc2UNCj4gIAkJcmVzID0gcGxhdGZvcm1fZ2V0X3Jlc291cmNl
X2J5bmFtZShwZGV2LA0KPiBAQCAtMTMzMCw3ICsxMzMwLDcgQEAgc3RhdGljIGludCBueHBfZnNw
aV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlDQo+ICpwZGV2KQ0KPiAgCWYtPm1lbW1hcF9w
aHlfc2l6ZSA9IHJlc291cmNlX3NpemUocmVzKTsNCj4gDQo+ICAJLyogZmluZCB0aGUgY2xvY2tz
ICovDQo+IC0JaWYgKGRldl9vZl9ub2RlKCZwZGV2LT5kZXYpKSB7DQo+ICsJaWYgKGlzX29mX25v
ZGUoZndub2RlKSkgew0KPiAgCQlmLT5jbGtfZW4gPSBkZXZtX2Nsa19nZXQoZGV2LCAiZnNwaV9l
biIpOw0KPiAgCQlpZiAoSVNfRVJSKGYtPmNsa19lbikpDQo+ICAJCQlyZXR1cm4gUFRSX0VSUihm
LT5jbGtfZW4pOw0KPiBAQCAtMTM4Myw3ICsxMzgzLDcgQEAgc3RhdGljIGludCBueHBfZnNwaV9w
cm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlDQo+ICpwZGV2KQ0KPiAgCWVsc2UNCj4gIAkJY3Rs
ci0+bWVtX2NhcHMgPSAmbnhwX2ZzcGlfbWVtX2NhcHM7DQo+IA0KPiAtCWN0bHItPmRldi5vZl9u
b2RlID0gbnA7DQo+ICsJZGV2aWNlX3NldF9ub2RlKCZjdGxyLT5kZXYsIGZ3bm9kZSk7DQo+IA0K
PiAgCXJldCA9IGRldm1fYWRkX2FjdGlvbl9vcl9yZXNldChkZXYsIG54cF9mc3BpX2NsZWFudXAs
IGYpOw0KPiAgCWlmIChyZXQpDQo+IC0tDQo+IDIuNTAuMQ0KDQo=

