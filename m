Return-Path: <linux-spi+bounces-11458-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 82AD2C7A4D3
	for <lists+linux-spi@lfdr.de>; Fri, 21 Nov 2025 15:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sto.lore.kernel.org (Postfix) with ESMTPS id 00D5D2415B
	for <lists+linux-spi@lfdr.de>; Fri, 21 Nov 2025 14:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A4629A307;
	Fri, 21 Nov 2025 14:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="C5U0x1yf"
X-Original-To: linux-spi@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021110.outbound.protection.outlook.com [52.101.65.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FF629B8E8;
	Fri, 21 Nov 2025 14:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763736719; cv=fail; b=AR/3pN7/np0QYDhcuwbcKVlwNUmmcc9tTpyeLI4jykPuPvEZVgqlHMq6RxpinVskAAKQ0ieyh9XVn+SuNRVFkuzLA8FqL0YscWu9AP8SZz9qda1Y2YxlzHr/c2lTOwp7QSauQPHFX6WGKCNRElkz6/Vbq8sfIGjQxCo+TTW9poc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763736719; c=relaxed/simple;
	bh=ZTJx+HVIWTkFIxnlRkeO/492rmnJgRPWmykHRIkPSR4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WpIqueMo1fBePPoonGj1r2eQ/XERwnfL9ys9+LQXgiLrmnLJq3g9bR/N3vojFkR19lRNvJvJ5G/2h7f+wDm3JNPytoHbbIuJRglG+JYWPa7E2GNUSziECFJfGy+5/eCJnqG5OBL3myYrAlOee9uXvRKZ4nV6H9Yu3p0eOcByehY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=C5U0x1yf; arc=fail smtp.client-ip=52.101.65.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ORX/SNrTTKTsFCajSJ7SSWET4QL7Dj3K1jf5JWTPdYuxFCai4U2E+tBDPuXTuCTiAhBn82qX5YYXzn4FsJV32+qF4YdUoBiTuSVV86Bd0MG43OEsCG2UTTuDQEw4rZORwB8WmgZzd65HlazpdNmnWfmUIVNmgQTAMZO3jhnVw4Y+ALrj+UGPlxmhjb87Q0PA1n5LqUsoNgeo6DF+hwFPQWOfB56vqBH+MA6gWB0RRRVcl2qGrHKyqwRot4//kiUcGq43jIG3jgis5aO4UltT2eM+7r+r0r+stXoA0iTAPlVhHG9tNUWF2Qetqw91QHxyR+dbdl8z9prRJ5PtZ+3q8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZTJx+HVIWTkFIxnlRkeO/492rmnJgRPWmykHRIkPSR4=;
 b=AiRpQwdtuuFAGjp/Qgwi1SZt1DWTmPSVR5t5My+GikjWxIIl5yM6HArUkyh1Gpz5T+rtxOQkYMcg23S1/K8Kd8jq1XbtghE2nfb1TxFYKeaKY0vjkrRDpRlhpeiOLHMqShnE8teBOQIXEteOTfsAh9FTgrj8EHvhIRFXIRTuM/rWZgXDnTqNZ6EpyjRx2Phhdv62yj9EGtpszybQ2HC0PlKYnbViixnHJms/91ESv1u6wU/WWmlLASdBSKYnntcRizkQvwgJ5hRejZhyAmmK1mUhS7Yxw/gJp+GEZqTFZq07wyfAa9TuOErpWPSX+wop6RM6gyLgKIf0cbeDa1PEjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZTJx+HVIWTkFIxnlRkeO/492rmnJgRPWmykHRIkPSR4=;
 b=C5U0x1yfFf2FZIdIiXtOAjYsBYh0QZpzgv57sM4elCHucIJNgkAGASzh7K6ThS/sK9PHXqGV0cN1E8NAu9ezYz2JMGt/8QISjk6CKAtDV7l/Maz8ZK/9KL/34Z9xtrUjerUn7Lyj8FRYzc/9a0hyy7kx4ioEYr3rRednftj3ajzHg/vhH3euoY1rKXYBSYM0QM/0sEds/NOjOijwRMl3qKIy80EuDnKD+lZuh9KaWNwFWMInMoTX+9EDi69QA9oulcH62BIFZDugksq2Yug38qLkQX3KFzlOQ+49mXYd+ucLZiWlw0S5mOEtCx0xB2/ePzXBVw5Eh07g0lhl1sULCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB9PR08MB11529.eurprd08.prod.outlook.com (2603:10a6:10:607::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Fri, 21 Nov
 2025 14:51:53 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9343.011; Fri, 21 Nov 2025
 14:51:53 +0000
Message-ID: <a0b0b7cf-31d4-4932-945a-bf138cfe2f33@iopsys.eu>
Date: Fri, 21 Nov 2025 17:51:51 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] spi: airoha-snfi: en7523: workaround flash
 damaging if UART_TXD was short to GND
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Ray Liu <ray.liu@airoha.com>,
 Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org
Cc: Andreas Gnau <andreas.gnau@iopsys.eu>
References: <20251120042753.640492-1-mikhail.kshevetskiy@iopsys.eu>
 <20251120042753.640492-2-mikhail.kshevetskiy@iopsys.eu>
 <15bf444c-0eff-4856-93a4-764668666c3c@collabora.com>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <15bf444c-0eff-4856-93a4-764668666c3c@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV3P280CA0036.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:9::23) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB9PR08MB11529:EE_
X-MS-Office365-Filtering-Correlation-Id: 79fba532-687d-4ccb-8c2b-08de290d825a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q0lyVWlEbnY5ZlB3MXB3eGRrMGJSUjVoejhOcDhPenpoVmxJMURlMzJvbmx3?=
 =?utf-8?B?STdvZlhkTy9rSmZPK1VOaGxpcVFrM040OWVQVkh4QTdFQ1QxRlhsYmRqNHlD?=
 =?utf-8?B?T2NBa3BRRElqQUwvcWw2YkZiZkE2RDN1SXFFWnpvYko1WHg3S0tvOFhsekN1?=
 =?utf-8?B?ZFVTWUY1NkpOSndvajdMelo2R1krU2o1TVpnY1VIWWhKUUllQlAyaElOcDdk?=
 =?utf-8?B?T2ZKUmpCU2JmcEk5Wlg2SDVSeTBVUWRhNERtQWVaeldkWUc3djkrU1UvdVNv?=
 =?utf-8?B?OXVYNFNMN0Q0UmNiOUl1ZTdtdWdiSTlGbDdzZmZjQnFNS0hKTCsvTzlUWFJk?=
 =?utf-8?B?KzlVMGpPajRRME42cUd2ZGtiYUt4TlE0MFV6OVplTXFtQi9pQ2wyOVRpandQ?=
 =?utf-8?B?UDNTSFpvdnVOUXZJVVZZbGIxdWt1ejM1YSs2TWdhSFBUcERrWUxBRzArNE1m?=
 =?utf-8?B?Y1VkK0lxZERPVzhSWkNHOHhZSFk0VEdCOG5uK2VyODlheGRSRDZ0RkJ1RzVy?=
 =?utf-8?B?eUFBbVFaMHBybDVlZmFkVlBiYUFtT1FHejlTRm54UVBTMzBxUS9xUjREeHpS?=
 =?utf-8?B?aTdwU1o1YlFPdWxuNW9vRVJpdkRJTXI1LzRZZUREZFV6SU8xVzljUWUvbndB?=
 =?utf-8?B?Tk1ZdUZXTElQWWEvSS9vcTBxSWluUFI4WVVqSHdXNEs2UnMyNDlrWEJQeGNK?=
 =?utf-8?B?MCtYWEFvQWFsMjhuUU05bjZDaVp6V1U1U1MxZDFNcmEvWnhIWTdRSkxwcml0?=
 =?utf-8?B?VkYzOGE0RlFjL2xaTWtHOWU5eXdGKzhHeVUyTU42WE44akh2VXIzZWlNSCtw?=
 =?utf-8?B?TW5mTEV6L2daVVpmcExHMG56dXFoZDdYcjJjbWQ2OURnTXRTNTFncFU5TTcz?=
 =?utf-8?B?akpzcncvYjd5U3JKd2poaTlBcWtjWXdYQXl5cis5bkU0eFk1cFcyQ0hpRlRs?=
 =?utf-8?B?OWVtUDJpNnFvclErMkMyWk94VHJWTmRyRjh5Qk13RGJxMjBnMjZ2Yk1icjA5?=
 =?utf-8?B?dFRDNzNQckZLcWJ1UWk5UWtibkRjTS92Z2FtNWEvR25Ia2trdnhBNWJ5dDIv?=
 =?utf-8?B?cEh5T2Vxa29hYk9HL3RKc2xyczUxbDdqV01FZ3grNk44RnlVdVNXbUNJM25O?=
 =?utf-8?B?SHpSQ3hBR0J1d3ZmL0daWXRzdjdaZVFqVnpiWFRDc1VnVjczQ2JNeTgyR280?=
 =?utf-8?B?aXRkRjhnWTlmK2E5Y2NJN2ROMjE4eGt3UGxTTTJuOHRBdW05UVVJMUZseFlZ?=
 =?utf-8?B?eCsybWg2Njg4eSt0S2t2T2hKcjJTZlpNVFBHSi9ZYWh3TVdXTjlPMVhNUVNw?=
 =?utf-8?B?Rk9JTVRtTVhrOG5wSktKSG5aOGUzU0hqcjRXVjB4MS9QRERidDZUSkJDSmt1?=
 =?utf-8?B?OWlJamRuQzRDTk9xTTRkV1NYZlAzenRCbVFHS3IybFR6ZVhSajEwcWRWeUll?=
 =?utf-8?B?VDVGbG9aSk1NakdqVFBNNGdMMUtpNEIvemZsYUJ0L0FWMWF6QXBSWmRGekxq?=
 =?utf-8?B?ZlBKRWJTYWRNS0xlVCtsWm9sZCtEb21GdGZGQXc0WCtIQ2NIYzdYV1dXeGJX?=
 =?utf-8?B?bzEwL2FxclRZNE0yUXVSUHNrZmFVNlNTeE0zMHBVM1FkcFVTRGVRd09SaHor?=
 =?utf-8?B?VkxMMy9QQWxHNnJhWWIyakR1Zks3dTl4V1JTcDRxci95YWkzcmlVNDFLa2Qw?=
 =?utf-8?B?K2U5WG9zYUFPLzBkcXRPakExbXh3anlLVUFGTS9tT2swQjlhUE1jWXRORmcw?=
 =?utf-8?B?ZjBPWlBGK1FUdUFNVDFHTm5ZTHJYajczTlJ4T2RZZFJPVDNWRTVXd2QxaTBm?=
 =?utf-8?B?N3JNS3hVbyt6alUxOU9WdXNwRE5XbGEweUJ5UjM4MVRORkduU2xjcGlqVFdy?=
 =?utf-8?B?cU0wR3BrY1RORVVjUXlqamZ6aTBRRkphL1Z3a3RBR2JEOEtScVVnYTFzdVpu?=
 =?utf-8?B?UU9yWEpCTlYraW5FMDMzS3RoK21yeXJCRjN6WDlpaU4yNUtkMCs1akI0dWR1?=
 =?utf-8?Q?p2tE4tbt91GCmw5oqrYYDYsmgdP824=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RHlESElBVmFoUWFpOGJRZ0FXNzNYcHhPTW9FUmhJay9RR1hLWjVPeTk3RmUw?=
 =?utf-8?B?TEVZbUtHR0ZIYUQ4WENGOHZsYVE0NUVhcnFUOTFhaXhzbXBsUVVFajNCTVdH?=
 =?utf-8?B?cllFVnhpRERNOU1NZ3R0TVFkMHhITXZXb29ZSS9vOHZTWk1ucmMvNnhwenNC?=
 =?utf-8?B?aFIvTmMzTCtnS1BYeUlxME9OWDQ0a2pYRlZjNjROY1Urd29OZXFvODlxVzZs?=
 =?utf-8?B?d0xHYWV5SEhXVUtCYXlyaGdqUjM4QkFtWXJsbGxHcmR3NVlibGVqTG01djgz?=
 =?utf-8?B?ZFdyRjRiRlZpbEFnY0lXdDVqQkdDbDRBN20xWU9LeGxrb3NQZ2lEbG03SWQ4?=
 =?utf-8?B?ZUpFbHBETW9ERmRsb1JpQm9OQ1BQQUdBdll4b0t6K0ZHVHBrd052QWVTTEp1?=
 =?utf-8?B?blFNUUZlZitLK1d3M1JVZ3YyZVRmVHdNbDlCL2ozL0VsVmgwb0lneWp4dGQz?=
 =?utf-8?B?eXA4dlR1Wk1jZzN0a1VZamJuT1lVZ2tRaTlYanE1V1hFQTI5VXVvTFYyb210?=
 =?utf-8?B?SlFOVnYvakJEM3hlbVZnanNiNGtTNk5DOUFsWnpjVC8vMHdkcm5LVFF5VnE5?=
 =?utf-8?B?R1laVHFuTVQ5Mnl0azNzdVMvU0VYeWpMYytHOXR5S3dPaGlKV1hkSEUzZGtR?=
 =?utf-8?B?N1VISlMyMDVzTmVONVdSc0MySVpXbzdTWVhqTUJwOVNzclhTSysxbXJPczFk?=
 =?utf-8?B?d3l3T2NpdXVLamRiYW5ySy9ESThrNmhZNkNHTG1pb1hQMFFjdDk4YlU0elNT?=
 =?utf-8?B?Q3lKeDl3TkNKQ2lHVkdFTE1SMlVvRkJSU0J2bm5jT1dmMnJnbWp1MGZCV3Jy?=
 =?utf-8?B?bEFFeHpVaTkzREZ0bjJYQmxyS3IxdDEvQ2xPeXU4UlNvaGlyYVFvbEQ5b2ND?=
 =?utf-8?B?Tnl3N0tJWWltTW5CbVRVMEttcmVHNHI2S2I1VGgvM3ZpOFdSQkhzb2NEN0Fv?=
 =?utf-8?B?TmQrUGZEZWgxYUZvZmRwVlNlQ0FHWG82cFNlRmtHZzRaNWp0eTBVdU1kTHg4?=
 =?utf-8?B?QVRwNHk5ckJxMHYvdS8xdEpZa2RmeHVnUk5JaFM0ZjBvNW1HLzNtTXlSMmRR?=
 =?utf-8?B?cWc4a2NndUd3MmxuYjJZRllJQ1pyaVhQRTk2MXJrd0xGcytmSjlVaTlBbDRB?=
 =?utf-8?B?NXNvMFVKYmhqcTV6a25SZ29uOUxEdm5Lc2FkeHpiOFl6QjdOODh4enBqUlA3?=
 =?utf-8?B?eHM3Mk9BZjF0ZzVMbUF4alN5NjZoeDR1WVFmMURibUhKdG9wckV1N2MzMklI?=
 =?utf-8?B?TUJSekFYWk13YWtnaFd0c3Bja29WbXcwMVRHQXBtMWlYOHE2SWE0cVI1ODVo?=
 =?utf-8?B?WkJPNm1ZYWhHT3A0OVI4clM3a0JHNlJLT2s2UmpEVzJnSDZsaE1zM3NGOCsv?=
 =?utf-8?B?eDZMOEduWDRoK0F1c0Q3M254bC9YZTVCeVVtQjM5NURDT3lXd1ZRdll0cjlU?=
 =?utf-8?B?cDlFSG9lU3FJQWlaTmF2VDBpNlBXZVJSTXZITG5jVlZMNzF6Mk0xMHhab2NC?=
 =?utf-8?B?cVpNSFlyTmx0U0NmTUkyMDFYTEVOSUhMK1p3MXdEQnUzck13eTNWbEtRUlRF?=
 =?utf-8?B?RGc5QWg4MDZnWjUxb2ovQ1p1emwzVjBtRG5HcHVEUzQxM1FvSVlnRVhmVkhQ?=
 =?utf-8?B?dzVPQnZjMkR6dGlOL0JGWmY3RjBheG1RMFgxQmpZalJoQ0NUREF5QjdQcG1w?=
 =?utf-8?B?enE1enpxbGdXYU5lQkRNY3hobHk3VlZGekw4cERWWWsybForMHNTdlh1MklR?=
 =?utf-8?B?bUU2VEVLMjZWSU0wNjlsVkJ0ZEdRS1k2VFozN29PMk01NDF4QWRyblFpam52?=
 =?utf-8?B?MWhKajloVlcxSENheS9JK3ZZZE1jR3JsY2NQZDI1V3ZVTmtxdnVIeWYxOXU3?=
 =?utf-8?B?SEk0TjErUnI3eW51NXV5cnB4Nzl5THdrcE1aS1IzVjRiZ0twc1kzalNVL0hE?=
 =?utf-8?B?UjVNVCtVblY4UVF3dkdYLytnYmk5aVMrRS9QWDQxNEx6dDFNcU9SWlBXelFQ?=
 =?utf-8?B?ektGclNoRmJZN21JS0lUZ3IvNis2TTMyZ0NpTnhMaGF4cFNZUUlHRmJYRVlQ?=
 =?utf-8?B?MENvQjlrMTU4enFxTUJmYkN5V0JqRDBrSXFmQmdEWUcxQ1NmTlYreWVwOEY0?=
 =?utf-8?B?YWV3aWl3TnZyRnVKajJEWHNKM3BHSDVFUHhmb2xYRUJTRFZURHVhM3N1L3B6?=
 =?utf-8?Q?fCxffsIMm1v6H2N4I6dELF8=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 79fba532-687d-4ccb-8c2b-08de290d825a
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 14:51:53.2837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F82W/506BAGV+Af6+vB1IdGtIWZ8giDNKizu70w9ugvB2vJt5eF22hmbb/Znk4rrd+8iSWMJZWzPA9ju8OkkuWQh+EJxeNR7Zks0kfVw8Kw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB11529


On 11/20/25 13:18, AngeloGioacchino Del Regno wrote:
> Il 20/11/25 05:27, Mikhail Kshevetskiy ha scritto:
>> We found that some serial console may pull TX line to GROUND during
>> board
>> boot time. Airoha uses TX line as one of it's BOOT pins. This will lead
>> to booting in RESERVED boot mode.
>>
>> It was found that some flashes operates incorrectly in RESERVED mode.
>> Micron and Skyhigh flashes are definitely affected by the issue,
>> Winbond flashes are NOT affected.
>>
>> Details:
>> --------
>> DMA reading of odd pages on affected flashes operates incorrectly. Page
>> reading offset (start of the page) on hardware level is replaced by
>> 0x10.
>> Thus results in incorrect data reading. Usage of UBI make things even
>> worse. Any attempt to access UBI leads to ubi damaging. As result OS
>> loading
>> becomes impossible.
>>
>> Non-DMA reading is OK.
>>
>> This patch detects booting in reserved mode, turn off DMA and print big
>> fat warning.
>>
>> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
>
> This is important enough to get a Fixes tag. 


Actually I don't know what version should be mentioned in the Fixes tag.

First of all the issue is en7523 specific, but en7523 was not supported
by the driver before this series. So it looks like no issue was present
early.

Second, we don't actually know when the issue actually appears. It
definitely present in the latest version. I would say:

* with almost 100% probability an issue present since the first driver
  revision
* with a quite small probability an issue appeared within my commits:
    - 70eec454f2d6 ("spi: airoha: avoid setting of page/oob sizes in
      REG_SPI_NFI_PAGEFMT")
    - d1ff30df1d9a ("spi: airoha: reduce the number of modification
      of REG_SPI_NFI_CNFG and REG_SPI_NFI_SECCUS_SIZE registers")
    - fb81b5cecb85 ("spi: airoha: set custom sector size equal to flash
      page size")
    - 902c0ea18a97 ("spi: airoha: avoid reading flash page settings
      from SNFI registers during driver startup")

We start using something similar to 902c0ea18a97 ("spi: airoha: avoid
reading flash page settings from SNFI registers during driver startup")
since June  of 2022. Before this date we was using code similar to what
was before 70eec454f2d6 ("spi: airoha: avoid setting of page/oob sizes
in REG_SPI_NFI_PAGEFMT").

The mentioned issue was fixed in the February of 2024. We never test
old code for the issue presence. 

Regards,
Mikhail Kshevetskiy

>
> Please resend with the appropriate one, after which:
>
> Reviewed-by: AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com>
>
>

