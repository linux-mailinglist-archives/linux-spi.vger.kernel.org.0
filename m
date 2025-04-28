Return-Path: <linux-spi+bounces-7784-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA451A9ED83
	for <lists+linux-spi@lfdr.de>; Mon, 28 Apr 2025 12:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBD7F18903CA
	for <lists+linux-spi@lfdr.de>; Mon, 28 Apr 2025 10:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09707262FD1;
	Mon, 28 Apr 2025 10:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FjmBLcAI"
X-Original-To: linux-spi@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012040.outbound.protection.outlook.com [52.101.66.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180F62627F9;
	Mon, 28 Apr 2025 10:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745834719; cv=fail; b=BM6y6ddCXXS5B/SWcOfi3++lYYaoKHOrGZDFKMDU5n/ocGv0qMV6vrVim8uIAMQNzfUSCiBu5+b+AiKRzCXLpcc0kMIerYEiqXb+YI1ePqX16u+UhXZj0XkPjqjrWgMftYYvn+4AqMhCft62LL8ps45wA29oP/IvbiY36dDcgzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745834719; c=relaxed/simple;
	bh=krpq9nhBfLy4zLPhr+UXTcOoYRwPWSk58aZ25kSzJU4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=TrsK/YUNGzth2xwf3U5yPoxLtvqcirwepji8nfXpEh6hbXLYCWXP6IvaXUzDtFsXRBCZoxFQfH1C6joP4SIONh8tP1w5VoMX38ccrY2Fgqlf7Y6g5+fyAKiYWxZIFHsX/hjR3dx8i3u0qwrNjK9x4e5EN3Xt7UjuQ6MF2+sRTJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FjmBLcAI; arc=fail smtp.client-ip=52.101.66.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jymGuuV9PI2vv+XiWJMx9w8CdtStvhOi+rYhdQj+/DYfHW4rIPtjQ5YtzAz2vLo333GYBM4Km1Wk1AZWAUgKkGqGCg5m4htzajDxkxQA8GDeaLFRz4f9dGSM9w58ecBmbfdoR5ztXTF7BoofhzFdL0+JQ/7p2bi50tFQek3HwjhiJdC9mlZKm69PqeIx2amG9zRxtyImiBaGaLdzSWmOgP212wwpLwwyjVSSlphTb44QvA4il3O+z+ra/XTAff5NRzQBLj+xbXTzXXCBik2fR9H0BkO6wyBACHKhqKKUXBExlNbBkbXywErHzM6nlN+3f3dEX8WWuGePxG5NsZPrqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2FR9ammIYrrwyCJlXxuYqT6sm/P/vU4f/u5CjUy3df8=;
 b=G/8/Ut235GDXea1My+fTQfCsAvz3I36abJu2E7wLiVKQo7npRNh6aJUbivt0TOvLdxPyEW2tGfxNwF1NV5mkHX+Kyu9CSfomO3eTWGv4JNnKcQANvjDUkuSuwcrVGQR9xj6usSSa/fU8wVnyRhH+oiQECF3zVc38NUF9ZFBQaSMF6rLHNDNHdp7ZdO5mpp0d1zZpH/pigF7qCTjnhWSShF50jnAj8kB4VpjqhP8E+UAzgB9nHgRsc+Wg7nqSxVrQiER0YWVkGm/6S4/KAdMlpqkDn1Sxiqm9W3McDdYbXype8eoDnrmZZS+rujR1HpzuXh2/ffRr71etSRbzz6ktxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2FR9ammIYrrwyCJlXxuYqT6sm/P/vU4f/u5CjUy3df8=;
 b=FjmBLcAIaCHG1Jc6qne+Hl1ebQTbBer2VYsyoV0OUOvsy1d7foSAhwzADmA8+pY5wZIf71Sc6e9+JNet5ft55viM3dgulSmF7fZiD8vrD025/M6ZG4LfE6acX7gpHBDT++K7yX5YhC++EIOckfg/wsaQxkeFS/g5Idi+e7ev1newNiCCFwV+RKj7wwZyICoDIRt/EeX1sL7u4zPtG5COTV0CTuXkAIG+HJktvhGQQZtgubvX+/RHp+zcWaVOxKtqgRZbjRqi5oBwVfPiiXgCnheS6qidIce5eOuSTjenqmlBzEJzzpsUCMoCjPWEvUV//gykBlMvpRfVfbAjvMjhfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by PAWPR04MB9862.eurprd04.prod.outlook.com (2603:10a6:102:391::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Mon, 28 Apr
 2025 10:05:14 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%5]) with mapi id 15.20.8678.027; Mon, 28 Apr 2025
 10:05:14 +0000
From: Haibo Chen <haibo.chen@nxp.com>
Date: Mon, 28 Apr 2025 18:06:46 +0800
Subject: [PATCH v3 4/5] spi: spi-nxp-fspi: remove the unchecked return
 value for nxp_fspi_clk_disable_unprep
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250428-flexspipatch-v3-4-61d5e8f591bc@nxp.com>
References: <20250428-flexspipatch-v3-0-61d5e8f591bc@nxp.com>
In-Reply-To: <20250428-flexspipatch-v3-0-61d5e8f591bc@nxp.com>
To: Haibo Chen <haibo.chen@nxp.com>, Han Xu <han.xu@nxp.com>, 
 Yogesh Gaur <yogeshgaur.83@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745834827; l=966;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=krpq9nhBfLy4zLPhr+UXTcOoYRwPWSk58aZ25kSzJU4=;
 b=BMS1sYs/om34v1q537xQSzogKrQAWdMdLtaFp1/hQSeJtgPYMaZUXXbBKObC2zN3XIRBe02Zi
 9xzd1OMlnBCAmQzUzum76VZ7y4grNYBZHPhwJNfAz6Q0rB6f6Dy8eWj
X-Developer-Key: i=haibo.chen@nxp.com; a=ed25519;
 pk=HR9LLTuVOg3BUNeAf4/FNOIkMaZvuwVJdNrGpvKDKaI=
X-ClientProxiedBy: MA0PR01CA0011.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::9) To DU0PR04MB9496.eurprd04.prod.outlook.com
 (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|PAWPR04MB9862:EE_
X-MS-Office365-Filtering-Correlation-Id: 24761bdb-ca6a-4963-ad24-08dd863c2b5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cXY0Y042TFlVOW5iWGhiOFd6U0JEVjh2b1NRc1B4bTR1ZVZhSG1DT0dSYmFH?=
 =?utf-8?B?SkJWemN1OHRUSE1rZWdsMk5EQ0kyMzRqSk02RTdEd2dUVjBMQ2wveGppYzFC?=
 =?utf-8?B?dVNLdzNVb3cyWXgvU1JyR0NGT21BY2FucVZ0dS9SRVI2RXB5cTcxRmNGRTVj?=
 =?utf-8?B?RUp1M3pPaEk5VEJpTUwxbnlLY1JBSHk0eEtsL3BKWVNacG5OdkQ2My81bzFG?=
 =?utf-8?B?enhRSEhTYkdJaWNlcEhBbG9UY0tHTENMYlVJWUk0dDk3a0FPQklNd05XelZl?=
 =?utf-8?B?V09jQVQ5SytqazY1UDh6R3YwU21Yait5VDIwZ2tYbzFoaTdoU0VHd0w4TmNo?=
 =?utf-8?B?LzJsOEVVRVp5d2hDMFZzOEI0bHI4YndQSVMxRGVSMFpJNVYrQ0preVVyd21k?=
 =?utf-8?B?MElVRkRvVTZPeTRlNGFXczh0VDU1R3p5VDQ5bUo5R0hlcHVERHZMeW83R3JS?=
 =?utf-8?B?SnJuUXNIV0JJbFhORzQ5OE1NQ0Q4b2Y1SFJhWGx0Q1k2RjVuZE1IZFZvTkdv?=
 =?utf-8?B?Wkd2VEZRWCt4R2NEeDVlYy9oWncxaU8wYWxJOStRQmsyVEkraTJra0dUM3dk?=
 =?utf-8?B?Z2Rhc1NTV0tZUmRjRzl0RFo3RFVKNTRxRUhpelFDYXRLOTNRbXhQNlVHU1pB?=
 =?utf-8?B?OEZtZUVGbHhBOWRMaTRZaCthOVJwYm9WaldMRDlzWUYvd096U3JuSUFSaUdq?=
 =?utf-8?B?OUNERjI5eExESjlSc2pPdjJuNWNmanRmbEtHNm5MZTY2eUhtWVkrbzdUdXlW?=
 =?utf-8?B?ZUs0d3EwdlhWVml0Q2U1b2VqRWZYVkk5R3FhUW52SjlDVlY0VW1HbXovRWZY?=
 =?utf-8?B?OXhwMTcvRWtJSFNoTFE2amtQa0cxdzEwb3dWZlZBc2FweE0yenl2VGc0MElO?=
 =?utf-8?B?emF0MEE3SHpsWCs2aXppVk9XY1ZlV3hTZ25BK3Q1Y1FLQjVKbTRTV2toQlBv?=
 =?utf-8?B?VWkrNHUweUZLWXdnSENDaHRoWUJtMmpuUnl1cWptajNlaCszMXFNWkxZUENx?=
 =?utf-8?B?ZityWHVUUjhQRUpUcFljMmEzdnB2VWJkR0xCZTZXVkZxdGV5YWFpVFVvd1Rq?=
 =?utf-8?B?RktaVUhiTVh0eXNmZU1NNDhveTAyL0toT3YyRCt2UmtLTVpTZ3NBcEJVcTMz?=
 =?utf-8?B?YWZOMSs2cWF5aStlcHVIclN6WTZLaUNHUWFCMUVzbDYrTGptZnRLdXk1WEdj?=
 =?utf-8?B?blhaYUxaZTdaRGFydW5VYmN6aloxeU9oWituZzFRSEZFVzlDcUZubWIyZnE5?=
 =?utf-8?B?a3Q2T3YzUXRPSFl2b1RYTThPTVg5VEFVV01CZ2ltRkZHa0RrcFVPUDBKRU84?=
 =?utf-8?B?NENDUEJKaGRXZU5sUXRlNDRsYzh0bmNXNk1CdjBFeFRReGpMOGdKeHlncEh5?=
 =?utf-8?B?UExvOW9xTDFnRGlrdzVUVUZORUVrallldGNTWVFla0U5b0hBT3g2MlllYzMz?=
 =?utf-8?B?ajB0S3BSRzJWL1hpVVNWNjBHNEF0Q1k1dFBwenZWTjRDL0dzYXpKTmNYTDZp?=
 =?utf-8?B?SWY2NTJHNWFRRnB1UXdGaHhMV01CdkxMUzdydTZ4VGxCV3NZaUhGUS9kZWNM?=
 =?utf-8?B?QXVnMW1oNDNlTzl3eXF1V1F6Ylg0UTJGMDg2WU0yaVczSFNKUGdRVnBjWi9h?=
 =?utf-8?B?OVNoU2ltS0FXMEZ1cXhrQzgzQ1ZLT2g0V2oybHNZS3FPOXR6QzBIQldoVm5M?=
 =?utf-8?B?ajlGdnJlU0FpZldpL3VwMDlINFJkc0RCZCtuNTAydkEyVDdqckZPdU9hUTJ5?=
 =?utf-8?B?WmhTVmtxSjFLUE50VlJrQ2VQVlJhK3BzYmc0SXROYnNzM2VPbGhvZm01YXVn?=
 =?utf-8?B?aXZZZVVlQ3I4V0lXdGRxc1Yyb29OdkMwUXBmN2h5VFMzNGlJOXhuandiL0xR?=
 =?utf-8?B?NWtVVnNkcCtyUFVBY0t1eFBtdWRQK2dQNjN3Z2tQOFE2T0JlWFdmcWVGZ1kx?=
 =?utf-8?B?M0I2bmdTR1ZMZm10NHJ2eHZMQTVpRVpGQ1pHc1p2RVlJbTlmL3NJV3p1SEtq?=
 =?utf-8?B?cm5WaTVJYXJBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cTlWcUNFV2tqUUhMRzh2aXhaOG5ib0diYUJRR0RVcG5xWkZGN1ZqOTFoWGJp?=
 =?utf-8?B?ZWRGWG9lcmc4Y1I0cHJLdW9SaWZwU1RJYXNPVzc2dlVWUzJEV29iWlVJTk0r?=
 =?utf-8?B?L1BuV1VoQThzdHFDUnBlbWplVERKaDljbExXay9sRUdiYjJSZmZPbXQxUko4?=
 =?utf-8?B?emdpdUZ0VHhIWlpzdndKWjlaMUNiMmJFRHpjSE50VUEzcDRXVExOZWlqQ1Y2?=
 =?utf-8?B?ZnpVSXpzWjY3YnVpeGdvZjhqRWxqRDlHaXUwNG55eGZubHN6WFJRZVljNzZl?=
 =?utf-8?B?TVhMTXdBWkJ4eUtpWkVsNS82dnFBbVorTVdWenlYN0hrMEZTc05TL05PdU5B?=
 =?utf-8?B?QkI3OG05M1Z4VFcrSW1CN3dQajdUVmEwUlp6QkdncDBMSHJIcmdrY3ZFK2Jl?=
 =?utf-8?B?dlN4WWYyOGxRcWljMGtJOWltTGk0c3BmMmtFS3dFZTB0ZHdoNWNnQ1RUcXE0?=
 =?utf-8?B?N2pScmlGbVFnaHB5d0dQTjRIM0IxbTRGUWN0elE3L0hBK010MjdLQ25lWWgz?=
 =?utf-8?B?UHZNanpLL2NWamRpNDE3N3l6V1kxVC9OTVNZNFhBcC9RcDVTbllVSmpnRTlB?=
 =?utf-8?B?YnQwdWd5eGhlR3R0ZUptYnFGVEVKOGJIeUZpRlQ4VkwxUDFEZWQxWXBmWE4y?=
 =?utf-8?B?M3JER2FtMVorOWc3RGRRWUloYzRGMkhZSFV1UnQ0ME1SUWJMSWIyb2ZkWWQy?=
 =?utf-8?B?TXdLSU9qQVdQbXFqSnZROGdpbWx1Q0t4TEtTZXJ2YU1aeVlaVmZrSm5TczdY?=
 =?utf-8?B?ZTRyUDVsU3ZiUzd3aVZsWWs3Y0Y4OW1SRmhta1hHWnptdHV6T3FUU2hrZ3pp?=
 =?utf-8?B?OEJHeE9iZTN1YVYvOU02c0NZUXRzd1E5VzVsTFRIaFdqWVZFY3JWRXpqTWZK?=
 =?utf-8?B?eXFEUlBkZlZFT0tCMzlwdlRVOE5GeHdvV3U4T1lDRTliNk1QM2I1L3ZUbFdL?=
 =?utf-8?B?UXBxMEVldTlkWENxV1ZiOEx6MWc5bnU2UFhKWXIzTkFDMjBnbnoxdktsYlZZ?=
 =?utf-8?B?YlNzd3d6eDJTVUN5TUxNZHR1ZmJFOWhSLzNtbHBWVnNTK20xQTZ2Mm52bjNi?=
 =?utf-8?B?TGtBYi9KVVVqWUJlTEtnb01oL2FpZ0V4bnpEd3d4dUJiSDNUZmY5aXF3QWVB?=
 =?utf-8?B?M0JieGhGYlV5aURQcGJ1TW5uRyt1dyt6blE4TkR6cVYzV2dYZW5DcE9aMFZW?=
 =?utf-8?B?TXdkTXNiL2tLNkVzNk9UTm8zWVE2RnNVcVNIT3F5dVFoYlRUQzZvUzdoQUpR?=
 =?utf-8?B?dk52Yk1pN2dhd1BHdlpaMzlmS0xQemJYV1JLaTA2bjRsZVd0ZkUrbWZXVzhJ?=
 =?utf-8?B?Zy9mWUlXUTVvbkdSQ3dxUEVXQmd5UElubllKTCtReHpjLzMrWDJKcytPWGpO?=
 =?utf-8?B?bFcxeUx1ODB2VURDdVJtSnJubzlSQ3YxWEJub3FoN21SbnB6ckV1TU5MelJy?=
 =?utf-8?B?dXlaSW80MGpXdFA1UmZQZm1vQjBLZ2E4RmRPdDJCcUY1UkU3VTFrSkNERFJQ?=
 =?utf-8?B?MW5uaG5lZXBDdzcrYVVHR2VEZktEN1cwRkVubS92ZkQ5RUtjME1DNFRyQUJX?=
 =?utf-8?B?aXBDN1hERFd5RXVDb1RuVXpta2hJd21sZzdnNjNad2JsKzVaYlNpVDZpYm5o?=
 =?utf-8?B?eGtFcFdyUENlQzZwVHF1a3RXanlDS3BOcGZzRVpjOG1BdFAzY25RenJvMThT?=
 =?utf-8?B?SUhFTEhiZER4bU1QZzVwZjFjNERrcmZtYUF5Y1pGeE1WUDdjWThvWllpV2Ey?=
 =?utf-8?B?NTZFSmJYQ1R2T1YzdnBDMGQyTkN4TWpJazk3L3VTVU9qUHp2THRlWXU1aUtp?=
 =?utf-8?B?eWNRM0d0UnFZclM2UVBvOHdYYlpSYzJqaFhBQVJyaCtqb1RhaG5LMTlqMWtH?=
 =?utf-8?B?TFJCMWxqZUFyL1dvYlNPVTZBTGhQeWlsZFAweFJGQTc1eWRkNUl6U2UvZkI0?=
 =?utf-8?B?TW1CeldMNWcrVzhRbGoxdnROT1JsUEVWTXV1YXlHOUxYTXJJTGMvUk5RMzVT?=
 =?utf-8?B?bi80Z080T1R2UGdpU2ZCUmQzSk81OUNrNUdLOXF0Z2xGWFBtQzh2OHRxYXFq?=
 =?utf-8?B?U0FrdkFwU3Rrcm9UR3dpTElRNXJXYUMvcVd2eWFITFN5aWFsQk5hczhnckll?=
 =?utf-8?Q?w08v5mx1961UDcv1i2JsLWcjv?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24761bdb-ca6a-4963-ad24-08dd863c2b5e
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 10:05:14.3921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qID5QG3vR40RpjJDUw619pH+XFAAaC/d4xjXL3YHxi3fyoIxfpNcpQD6MPOUuCgamHek2bcIfb/t7jnkcZijpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9862

For nxp_fspi_clk_disable_unprep(), no caller check the return value,
so remove the unchecked return value.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/spi/spi-nxp-fspi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index ca0b51a254c15f45a9e91907900d94d77f1d5dff..0ea04e77a968b9c8dbd73a76984022a8f9e9b178 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -634,15 +634,15 @@ static int nxp_fspi_clk_prep_enable(struct nxp_fspi *f)
 	return 0;
 }
 
-static int nxp_fspi_clk_disable_unprep(struct nxp_fspi *f)
+static void nxp_fspi_clk_disable_unprep(struct nxp_fspi *f)
 {
 	if (is_acpi_node(dev_fwnode(f->dev)))
-		return 0;
+		return;
 
 	clk_disable_unprepare(f->clk);
 	clk_disable_unprepare(f->clk_en);
 
-	return 0;
+	return;
 }
 
 static void nxp_fspi_dll_calibration(struct nxp_fspi *f)

-- 
2.34.1


