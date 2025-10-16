Return-Path: <linux-spi+bounces-10703-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DFBCBE43FF
	for <lists+linux-spi@lfdr.de>; Thu, 16 Oct 2025 17:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CC5CF4F09D9
	for <lists+linux-spi@lfdr.de>; Thu, 16 Oct 2025 15:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D2E313287;
	Thu, 16 Oct 2025 15:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="mQjAeF3X"
X-Original-To: linux-spi@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023083.outbound.protection.outlook.com [52.101.83.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2573213254;
	Thu, 16 Oct 2025 15:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760628662; cv=fail; b=CwntaNlfkrZSmiLnNaB+KT9zUHGC7UCw0WOa4MgI0GaJWeOsP/6C425UiC0MOpeMvQtbpOQfbNCQ3sgevcXw/kOYcEV6BMrN0MhaaKJb4jR09wvoNlD72c/kYlGL0L8e5+BMBOhQekib3y/Up0N1kfb/WW8aNB1vqzvPeu8IRVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760628662; c=relaxed/simple;
	bh=PGsjtztLuq9SOXvrkue8koWZ8x5Vko1vhbkPKzdU4e0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=h57IxQ6D+CK25ghDfpI3MtbfcnPF7QE4oCPUCEVqD7SjU7ocLjrs/7WepOqdGPNp3Vc3SKDPlWXfWEAmt0DW75IMZ3sr+IdN0eqcnlysQG0LJplwU832Qmx/fCEcbTMGxJABg5aT2Jday6M0osZYeKzxllngY4BZ6hjy5Lv0Z+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=mQjAeF3X; arc=fail smtp.client-ip=52.101.83.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hazMR8fPYKRYhdt+tlKZkFazFlg1KHY+FTgCxvBBf+gvsDfILeBpa+YRqfY3avTiywu/f6ua7tSmXhp+P4hNUxiCMXwivOXBS2xgaxsN8RRp4jciVWAPoinjuLINgWNa9NBVI9D7TbDnpbHaYZexBTu08kQb0EYfp8Oy8yotEYWPWheT2tTfyGAKl15ykV7fRejOAf8x9W773tA/W60uFILI6dWtvrR+8Z/k0Tlh6CJ9XEPVIHgEgkPR2xuLuoXI7trRJcUsDZVWIPIxnNvzPu9PEsZWHfOUNi19RayruDpFaIZ6O7etoHRFYCs6edqSyh15XEDVjBY2O3gWK9atnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PGsjtztLuq9SOXvrkue8koWZ8x5Vko1vhbkPKzdU4e0=;
 b=M/HUTlfDHMtCSILEGSDou+1AF9Qe6ez6W6CCkadpTLUHwkJAZon+Mggi6qbt7rag9vPV2Ow3sj5vps2mXt+yJ7UO2ltLu2etPJKmXJX0GJ1hbrOJ28DQJkqLXnU/NZkAhG8joApJCCIiq1FuIEISt4Z0UckLxcgALikVdH7vjLdNumFIDakwO7qQd5Ms0nw6hGHmnbqUuDMQNTY/Po2/tyIeMDlLgO9JvQioJHby0NIzNyfLQ8KDJ6OPX39VuTVEZ3Cho1Ck5qxekPaEShEq7tey+jlhOLmY/r8vB5PpjRMGPo3LmdIOZnfWapE5XZffF5iAzKiDadovIr+TkNDiMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PGsjtztLuq9SOXvrkue8koWZ8x5Vko1vhbkPKzdU4e0=;
 b=mQjAeF3XJARmrM28SemGfHcKFYfF65z2pOjvgiqGrwJiOK/7c4fKt1rE6H7N08sxeqPKNlRhLBWJUtPaCRJEeRidCCh4EOMcHWPaNAfWwPQ6EDAYbMss004pU/wj3fdMIyoTV16vE0TH8s0jn/5sTawwhfAtO28OjnRtSgiF3k9y4X6Ri0KRI2JxBYaCXKeCiitcfwMvRohKlV63Rx4oqzjFcApzgKnYO94YXudJ2kGBtu6ZQBcoUx1NrVR2nE4ktxktzaPsmSqM6SLrlifUmqU/8V9Of8nDJSDfVL+dIkh4sIXRdlp8zLfKblCIJ0wfPL6MFpEBLEjWpZ0Zl4lH1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB9PR08MB6683.eurprd08.prod.outlook.com (2603:10a6:10:2ad::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Thu, 16 Oct
 2025 15:30:56 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9228.012; Thu, 16 Oct 2025
 15:30:56 +0000
Message-ID: <42116c7b-e9e5-4354-8aa0-7f90a63a85f1@iopsys.eu>
Date: Thu, 16 Oct 2025 18:30:53 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 02/16] spi: airoha: remove unnecessary restriction
 length
To: Mark Brown <broonie@kernel.org>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, Ray Liu <ray.liu@airoha.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Andy Shevchenko <andy@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 Andreas Gnau <andreas.gnau@iopsys.eu>
References: <20251012121707.2296160-1-mikhail.kshevetskiy@iopsys.eu>
 <20251012121707.2296160-3-mikhail.kshevetskiy@iopsys.eu>
 <dbefe024-9b5c-4531-abb9-a1a7e9d3d769@sirena.org.uk>
 <177bcba2-2358-424a-a22c-9bd8b42cbeae@iopsys.eu>
 <0ccbe966-2e93-46a6-aad1-7715f289c275@sirena.org.uk>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <0ccbe966-2e93-46a6-aad1-7715f289c275@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0071.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::6) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB9PR08MB6683:EE_
X-MS-Office365-Filtering-Correlation-Id: a61afa78-dda7-48f2-ec3c-08de0cc8fffe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dU9lUDRZZmtmUXFHQjJHcWwxSkpuZnROSXlkOEducjQxRkNGdHB5alMxN0V3?=
 =?utf-8?B?R3M1VFNLYndBdm9XcTJWYmw4MUhPOURkTkpyRUxFbk50VXY0TGN5cFpWbzVQ?=
 =?utf-8?B?NDBSTnZ5N0pkSWhqZzJsVHpKT0p2V2ljZ3hYZ2lYcGRqSHhzby9QTVFsbU9w?=
 =?utf-8?B?bnQxR0kvUjJnQnJCRWV1MFhyUk9tS0RlUEFpUkJjNkhDUVd5ZFZ2WkRCSFdF?=
 =?utf-8?B?Q3FQMHhQZ3lhQ1lYaGZyMVVyTVRxRGRvMVM4SkhvaUI2c2dhbmRqNUE3dzl6?=
 =?utf-8?B?QlQxSDJ2a2ZVbHQzR3ViQlFGanpTMU53dkFIYjFjMnQvRXlka3lTOEUwVStT?=
 =?utf-8?B?OUp2Yy82OEIvSjNTdWx0akh2L3VwS3Iyajd5YlA0cTA0ckJ6cDNiaCtsRkdC?=
 =?utf-8?B?N0tDdTVCZTVBLzlSTW93Y2lIcFI3MlY3TmxLdWRyTlZ0bXdqWkZwU2t2YUlp?=
 =?utf-8?B?MkZJczMxY013NUxpMFQxOWkrUXVsTHQ3c1QwdkNoS1c0ellWdlVlZXkySWVZ?=
 =?utf-8?B?WXp1K1N3dXdHTXlVVE1LL0M3Qkh6YmRFWXZhbmNEeGYxQVhkcDNpRGZxTFNB?=
 =?utf-8?B?ZENiNkRNVjN2Rm1pQnZzbHhSZ0g2WUY2c0lTZWFBWVBKY1FSSGRBVFJSSFBw?=
 =?utf-8?B?bW5yY2Y5dWVienExdnFlUEtHdnF2NGZhRTR4cVArNXJrK1dCQ0ZMcG5hMEcy?=
 =?utf-8?B?TzkwNXpJZ09aUW1jV1o3cVU3bnRvdHVLeDhTajJYNnMwR1VzMVRSUXowMklP?=
 =?utf-8?B?dFRINzJmNFY1RDRFaHdRcXBicVdTb243SE5XNXVKc1hXTmlqMUhsODNYeC9P?=
 =?utf-8?B?UjFKeFZYdnh0U1ZLbmVlWHlhVUo5czdleVFDOWRSaS9lUTNzajd0MDQ4UUd5?=
 =?utf-8?B?YVBIZUgxczg0UCtIallqQ21JdFpuNE5sVjREZlJaUzRrYVY1QXc5VkhNSUFj?=
 =?utf-8?B?ZnE4V3NPdHI4YldzOWFCbDdJVks2dm1ja0VybmFNZXo1MSszcm1PYlBGMnB3?=
 =?utf-8?B?RlFnVnRvV2Q0bEE0SkRJb0xPQTM5TGhVZHI5SExpSitncDE3MEczTFZYd01M?=
 =?utf-8?B?eEg3WG4rczliQTFza0IzSGE0YmltK1FJZE9SL2NINnV4OXRQUENIdzMxQUlm?=
 =?utf-8?B?ZTdUaWlPaS96RVFYeStFQ0kyUGQxRjBoVTEwTk9TT2dra2V2L0NibVM5Y2pT?=
 =?utf-8?B?SkZQN1JQNGdraHUySTcrbCsvbG9DWGFyV3pDTUxJVlA5WHJIL0FBL2tBTEJZ?=
 =?utf-8?B?ZmtOT2laTUxSN28wY1VIdlgvL2lBRWJkeE9ZdUVyUFNYbTBVYlhnazBrcm9E?=
 =?utf-8?B?RjVVQklFOTFxbEliUC9BMjliMTBSU2k5aHBIOXllOE5xME1paTArbXQxV29v?=
 =?utf-8?B?VHBPUit6NXhNbDQ2YUdEU3dENlA1TFQrSEs1S3JKellNM2M1emd5MkVpWmgw?=
 =?utf-8?B?ZDY4VTJUT2ZaNlRTRDBpU0ZpSDlVL0RUdldxTzAxNDlHSXR2RUF4clZiS2tG?=
 =?utf-8?B?L0U1bDlTSGJDODZUeXZmTzJsb0hFaVBYc25Ga2ROd2QzNDZTTFRYaEJVTEhN?=
 =?utf-8?B?VUpWUjUrSk1lM0ZYL3cvSGo0TG5tSGJBM1lNdm1YejNLOEY5alJYUTI2YXpL?=
 =?utf-8?B?dHVGWk1US0dHU3gvUkFSa1FPb1JLQnRmWVpUTWpScE9LN2ExNmxVOTdCc2ts?=
 =?utf-8?B?UFdFckhUYnVGNXozSTcyM0tlWlYrejhHQWVYVjV3aHRvYWs0Y1JoMzAzUU5p?=
 =?utf-8?B?WTRNYlBrOWU4ZGNUbHZWbldDOGVmVy9JK3JFRHpkelFFd2xBbFpUL0ZrMWxJ?=
 =?utf-8?B?bm5TQitUMmVyWjRvNVRYai9NdUQ3ZC9IWGxGcE9BUHpkSExUck0rOVhwdlNo?=
 =?utf-8?B?WmtyZFRtUm4yRzNqcjVpRU5qOG1CbDJRR3psd3hRVDFyemhyY1d2eXVJS2ZP?=
 =?utf-8?Q?GtASi6aSdiFDZ6NktCC+NG864l7IXH7u?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WWt1UldaYkJTUGhwcTBFU3RFV1Zja3JyQ3FHbW9MSjdIVEkxc0NxcTJWTmZx?=
 =?utf-8?B?SHFSVGJhejh1cUwvdXMxRE5aWVA1MmUzc2Y3WkdnRHZZUWdjcjA2M0NORHhu?=
 =?utf-8?B?WUtGVmVabWZXdUpvdDR6a3QzcnV1ODRoeHVaN1BjOW5XL3dLZEFkeWlzVWd3?=
 =?utf-8?B?cHBDUWl1KzE0d1h5RSs2azJ4ZGVKamRFR1lteHlLaUV3MWhLYTYzYVg3aUNN?=
 =?utf-8?B?em1sTTNTUjhDUmtkS1gwR2F4allRYU1qUmhVeEl1bEpXczFuMUtQQVUzZ2Zp?=
 =?utf-8?B?MEwxNjgyRElnOGZlaTcwMldnWGxrSStJQWpOTmlxbjJFK3lVbGNBYjA5Ty9O?=
 =?utf-8?B?VW9tTXlkYUhLdmxXR1pEMjBnV0J0NGhQYkJLbFo5aUl6ZTllY1lMY2dSOXcx?=
 =?utf-8?B?UzZZOUZEU2Vzem84N1d0K2orYVIzUCtHUEM0QTFYckRWZ3hMMWFaYlFQRHFO?=
 =?utf-8?B?cVd3Z1FOcW5pVWV5TDF6MEdvNnZTbTNGNDJQZlVXTlJ6MlJta2NhMDVWakpZ?=
 =?utf-8?B?dmQ0dXN1SldtYWFLVk5UTlM0bXFsT0lvZTVRc1ZHWkNYL3UvNVp5UXh4dm5m?=
 =?utf-8?B?aThvempLZk1KbWRsaGZlYjN3dHRYK3ZvanViODRxbkdDbVU3dk1SU0RsWHFG?=
 =?utf-8?B?d1dnY3lxNndmZmRTOHpLYWFlNTg0UlJXMXAzaFV1cHNXVXM5dGw1US9BU3lU?=
 =?utf-8?B?ckRkT3pIblFoQ2xReDZmU3dqOEJ6YWVUNGZESHArRVdOcXRuZ1JLbUdFWElK?=
 =?utf-8?B?dHRyckd6L1VmOEZmRDdrZ2pMMk5yZFJpM1dhbmkrSnhua3BaNy9lR211bmdQ?=
 =?utf-8?B?OEVoMjJ2ZXdYU1hPZk04U2ZZNnAwdm1UUVpjWndkekhENFhQNmZYSUlFQXdP?=
 =?utf-8?B?T3BwQ0pZVk5PNXhtdFBXM0ZlaFp5cEhyKzJGd3U5RmpPeTFUTmMyWFlXWHVs?=
 =?utf-8?B?Q3hMZ0ZNQXp4UDRZR2E1d2ZqWFE2L24vMW0zSjF3VjlrcXAvQXJFN3VBMTUy?=
 =?utf-8?B?dzhSOGJObHY3MzQ3MENxeGRwaWlYWmVCVEpBVDNBaFFNODBsblFlaVhpTDBM?=
 =?utf-8?B?aTZjZmN3NHJNbFd6NDd0ajhvaHNrdlRJNnZhc3FTeWFtOU42VXpsYkNrM3dD?=
 =?utf-8?B?bWY1TVVBb2lSMktxOVBoY1BOM2RWbGhvUmwwbmFPZUxFR3Q0V0JFQnUwSVZq?=
 =?utf-8?B?OTV6anJuaFpkT29pWmJ2dTFzZmpTWEZOU3RhckxDR01QeXpDbDRWZzdMUkRq?=
 =?utf-8?B?ZkovYzJEMFE3WkVmVHBaZzZlYzV5Rms1VHRwTzlQeTZlVjYyYmRHVnMzUlZD?=
 =?utf-8?B?d0RYZVFIMUUxMnIvSTJON0NURktKcWJhS1JOQ1Job0M5MmVNNzZlN2U4L0d2?=
 =?utf-8?B?c2RoWTEyY2lJbE9jbTVTU0tuQmlOZzFEYytCaE5aVTlDY3NrRGV2Nm9SaW9h?=
 =?utf-8?B?S3E0cVZkaTRERTVZRCs1disvYjZNa1N0VlkvaTFNM2wremtyOHlJdFl2Y1dN?=
 =?utf-8?B?TEI4QW1DVXpJVWk5dzd0elBjanlBSVNFa1JHY2l6RkZ4SUdsTVZJNXloT0Rl?=
 =?utf-8?B?aGgwMDJCdU8yZkhVT3hKejBjUjhaUTEvRkMxTkVxU3pPUUJiZjNrQStWSDNF?=
 =?utf-8?B?Um5pZjViK0J2RCs5cnY0WWlFOCszRHoyVHZMb3ZIcHkreTdaUkFwU21Ec3Qw?=
 =?utf-8?B?cWhQb1RCNTNHUDVFSHc1NFNXT2U4dmVKS2VaSkQ4YjBWU2JhZTdQc1VnTVVW?=
 =?utf-8?B?ampuZlpnM2ZGMlZNZHlObHVES0hWbEE5ZlZwTkpVdnJTenNpSzF6NHJMZFBD?=
 =?utf-8?B?V3RvNXE2M0NvMkcvNXplUlMvZXZlQUFEL1NRY2JxN0VUTjlBZk5ZS2ZBMll5?=
 =?utf-8?B?bjQwdGRpVUhWOXVLUXFDSVJ3dU9oMkwwcjJGWmI3Wk55T05JdnkxNCtmd2JG?=
 =?utf-8?B?RkltVE16dTcxbllJckRYaWVmcytZQUZrK1hQRmppYnVRRTkxdE83TXZkZlA0?=
 =?utf-8?B?MXQ4QWYvQkRmVEFEdXZON2l4QmR1TGkzU3lzVExHSExzYnR6c0VlMGJNS1Fu?=
 =?utf-8?B?Qnl5WC9QOUNDeTdKbkFhdVZJMUcvaW1mcEFmbXNGbmtVbHFOR1Y3Q0VqRUw2?=
 =?utf-8?B?elI1YW1hbTN5ZEdYOWc0NjF6c2pPNC9YUzVFT3lTeVhVYThwV3d2czF3OE1S?=
 =?utf-8?Q?mk+iCkyYDvx2Z0QBTPUNtwU=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: a61afa78-dda7-48f2-ec3c-08de0cc8fffe
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 15:30:56.2804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XY0nzAZBiCN3FNwKJocDNxuDy0HYKVml6Mdg9FAzWga8qfM26fbjz/7n15MekCz4nMvyI3ECOhjtMp/acgOxC8g/3H3J/fSZydQwFsyTHmA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6683


On 10/16/25 18:07, Mark Brown wrote:
> On Thu, Oct 16, 2025 at 04:39:19PM +0300, Mikhail Kshevetskiy wrote:
>
>> Could you give me an advice?
>> This patch series consist of:
>> 1) bug fixes (patches 1, 3, 5, 6, 13)
> I note that 13 isn't tagged as a fix.

In most cases this driver will be called from spinand code. Spinand code
provides the same logic, thus patch 13 will do nothing. But if airoha
spi will be called outside of spinand code -- patch 13 becomes necessary.
  

>
>> 2) removing of boot related dirty hack, absolutely necessary for older
>> kernels (patch 12 and preparation patches 9-11)
>> 3) improvements (patches: 2, 8)
>> 4) cleanups (patches: 4, 7)
>> 5) support of en7523 SoC (patches: 14-16)
> Fixes, cleanups, general improvements, the new device support.
Thanks

