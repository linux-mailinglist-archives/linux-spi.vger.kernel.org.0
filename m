Return-Path: <linux-spi+bounces-9582-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 368A8B2F636
	for <lists+linux-spi@lfdr.de>; Thu, 21 Aug 2025 13:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B27A1BC731B
	for <lists+linux-spi@lfdr.de>; Thu, 21 Aug 2025 11:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5065630507F;
	Thu, 21 Aug 2025 11:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="h2Mh4gom"
X-Original-To: linux-spi@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023137.outbound.protection.outlook.com [40.107.159.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E63A30E852;
	Thu, 21 Aug 2025 11:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755774804; cv=fail; b=YdgC0kOYRKSFIZ38n6icEVkDQ3evd3/FT81RHQ8MDyUEuzH9++RYIuk6fPFqpp/TZF9MkEm+Jd3MjLTodQkfV1hdBs/Ggd2q4p4WlJsYVOGLVIRIMbYJzGkq6n+gAo1QLPSIAPoJj3Th0BhrL9hD6WbAvtf9y+mdLT3NKHvZKto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755774804; c=relaxed/simple;
	bh=xRDxZZ2ThdkyISJZoSYz1WlYKswBOenGPdKBEAIfw4c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=r9QtN1xdtcX2qk69toMahGw7Ew4KPsYE+gm88g2ZtrtwU6ok5HUUUi1Yi674y66/Y5AMlqv5E3skWncH+9hwb5+xSW3JIlfAAa0kWQFkCL/igXBKD8wTTSI/ZWyj+TLRJt2lXQ09hd54xLy8W4/u++8/UospWvWx5782ybu1auo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=h2Mh4gom; arc=fail smtp.client-ip=40.107.159.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rs5Wp0tJ3MhpP0sH+jvlGbCWMm/NeXXDgHZHYTxS3qoizpjJfDukrG4e+eXMZ8jKCfrJml0JD5fTFibCdc7bSTtMymuKhKcEI0uklkU/fxtmcx+RTKDbZCfgAQGhkaZBhLyzxEqVE/v9TySHI5Th62JQeGvlO+7H2k6H7EFW+U/2JDTN3NrU2yF8vZqBdcXJ7d9dWRR+QN8BSPVsQ0rAIs3nfIKg3RXqWA/T4tCak+BdRWnQJGQ5isJpEyDlTmYxKIL5zY5+pV9OzXzYGG5AUddBpjnfTQnHwyBV2SXMY4EQZkhw4ErzDqLn9E8LVKa+VG+cRClb1fDJ97tHpISjCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eQcy7GoNPP7wBWmdsEav/9caETataLayud9hj53YwLI=;
 b=ZLr3mcCMkH4joVfOnWWsRR5IN3WMBFhm3RHIbzKPgf5Bnmom7U9YN4uB7ZAUwIH3iWlg7Z2eggmKVtL1u/SJjBsrFfLrj6KignlZqwy0Ifm5Q8WunYTedTjGMU8rXuBPIN8mRB0bEHJjqOfrsJQnfOe9yYPRKigxBVh3HUU/N+O7EBjWV7jKWbx+CQgN9VqI+/yPSr/xEs+Dfz5gBZxLvpcPf174K5dCRuhxeKIA0fCS5lUs5M/iqZK6BHGj5TAoL3oGMVVb9uxvOzRc99ibyoiA8TFub7XbJ1VeHSbbGDJeDlBWlgSzyT7IkGv3WOo9/SgvhonYsYmoWldZTIgxZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eQcy7GoNPP7wBWmdsEav/9caETataLayud9hj53YwLI=;
 b=h2Mh4gomFX2MfPa67bYhd9ubKdi5kAR9ojKh+SxhS7AQoMS60rXN0eF7x+dPur3Jm3OSVfJVYmcspP/oPsA+U62dlPMqb/sEFlttlrqQJ6ApqArw6pxlZwZhmttis+kyluZT2nWL61L3/DkaIZ8sDL1BOpUarPlqlF//epbYOuIx5Vy4OfMGJasVl06TgU/1PpVtRy1VBc3jogx59s69MTa0tY4DX0QxpYVg+/GAgp+kXzov2tpk+r/78cr9s+4Um5ykANdQAOTficEBhTyzTMAX82VGPm+5E2oXwesDa+U2TOgcf4GgUklSheY064UgVllyrwbGAvT8PBsY5E/o5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS2PR08MB10155.eurprd08.prod.outlook.com (2603:10a6:20b:62d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Thu, 21 Aug
 2025 11:13:16 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Thu, 21 Aug 2025
 11:13:16 +0000
Message-ID: <7bca8089-09ad-4550-93d1-35a365bcd167@iopsys.eu>
Date: Thu, 21 Aug 2025 14:13:14 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/14] spi: airoha: driver fixes & improvements
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Ray Liu <ray.liu@airoha.com>, Mark Brown <broonie@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org, Frieder Schrempf <frieder.schrempf@kontron.de>
References: <20250820123317.728148-1-mikhail.kshevetskiy@iopsys.eu>
 <aKbDjIZhJuWo3yFu@lore-rh-laptop>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <aKbDjIZhJuWo3yFu@lore-rh-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4PR09CA0026.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::9) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS2PR08MB10155:EE_
X-MS-Office365-Filtering-Correlation-Id: 06104cc7-9b5f-4c0e-b11e-08dde0a3ba2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VUZpZzU5ZEVZRHdPSGpkeWdlMGdFT3ZNbE5YSlFOcGFCT3VRcXpnRkhCaXIy?=
 =?utf-8?B?SzMxcmZad1d3by9tUVNJRU5XSHdIMnJYcUk1d2ZXVitrei95aUpmb0xNY1Z1?=
 =?utf-8?B?cmlyNm1vZkYwcUp2L1JKekhQZW5jYTdPTWlSQkU4TmNUVVk4bXQvb09leEFw?=
 =?utf-8?B?eDNPTVpYbDdHcmhkQWpJWEVPNmNlaTNXanhwUHN5ZWRkR1MzdDdxeGNRN0FV?=
 =?utf-8?B?NDRZVDBaNDdWRmNmQVVtbnN5SkxFdkpxSzV4Ky9aTEE2b1NmWlBJQXk0azBO?=
 =?utf-8?B?S3k3RTRFemRkMm5XSnVZUS9DSXFzVTgveTFjQkd2NU9xQWNiR0laTHhDOW1C?=
 =?utf-8?B?UEtubVNlWHQ1QU9WYmFDMHBpczRDY2QwRTBXZFdxSEJIME1LZytWMzQ3Zjl0?=
 =?utf-8?B?bjdHMnBXdjYzbFVscldVeWFwWFB2UTV6dmpSYUt3bjg1ZWFmS1NiOXhuSGgy?=
 =?utf-8?B?L2JORzBBbCt4NGxUMURXK3dEcTFVVkk4bHVHaHF0bWg4Q1c4Q1lIc2RNbXVa?=
 =?utf-8?B?cUNvd0ZldTY1S2ZBOWNCYW5rYXhXSXNPSUE1bmdFMldBNWE4RXVGTEZXMDc4?=
 =?utf-8?B?dUdmUmFLNllQcGljODJheEtuTjJEK1YyNFFQbGt1bXhlMGM3WkhiZ3NZYTNl?=
 =?utf-8?B?WSs3QXNIclFOQUk5SC93ZmpxY3ZFVFFDelM3bzRtSmlGM1paWk9qN3NuSysr?=
 =?utf-8?B?Q1RJREZQRHJKZDJxdWpZOHlPRmR5b3FmY2M3YVJQUmM0OCtXS3pjSHhMRjZD?=
 =?utf-8?B?QXBMQm1jOEJsem0xaDdFSCtlbFE1MGtGOE10Wjg5cTV1RUZVRXU5TjBtaG04?=
 =?utf-8?B?OFd1SncrK3p2dkRKb24rK2lNcHlnR1hYTUYwWjZpanNWM0R3M1BaWXRsT2Uv?=
 =?utf-8?B?SEpFQXJmT2lFK2xQWVVGQXFIejJ2OTVrbU1ZTWlpVk8zbDB6Z0YvcVo1Q01P?=
 =?utf-8?B?K1MzY0tVaFJxRFFpOWNnaml4SkdLWHphRXZScjIwRGpaR1ZtMUpPTU43bmdx?=
 =?utf-8?B?enplZTFRbW40UmpzdWgxSVV2WW9QaEc1RFQyNmZaRkdUOUhwNEZCVmJKa294?=
 =?utf-8?B?ZFh1YTBwWkpoYmY3N200ZWlLdmZUUHZXY0h1OXdMenFJeUtLdDNMME1ZRDU4?=
 =?utf-8?B?VGNxa2JGcTc5YVVaOE1DUnhkVWw4aFRKK3JSZmcwcFVHU2xaNkJ3TDV0K015?=
 =?utf-8?B?a3MreHRGVWljSUk1TkZoODBGRzJzTldJR1lCS2dJaUNwdXJwWjZySWlTVEtl?=
 =?utf-8?B?NkNRYzExaEZuZnFjYkRLS3RqdmMvL2dsOHk5K3kxTUM2Zk4rSkh2N01TcnNK?=
 =?utf-8?B?MzZDZDN3ZEYya2x4VWJHNVVSYVhOSmtNMjFHWHlRUVR4anVVbkxwVXorMy9V?=
 =?utf-8?B?TnFjTUY4dlp2dTVlRU9JdzFaYmVOK09wUGV2OGRxWHJrWVIyZVY0eE1QQ3pD?=
 =?utf-8?B?R1FQU0k0TEU4LzhmckpHR3JIQjUzd2F5dUg4aDhsc2VMMStCbVpWNmR5RUls?=
 =?utf-8?B?aE1rVHQ4NGE2TlVjQ0R6c1hmUEl0TE0vcW90NTZIaWxSRk94NnlIRWVXeERs?=
 =?utf-8?B?WjI2QlQ0ejdMTWNKTlV2cEpnR2JlMzZ1Ymg3WHhOS1YwYWhvMk5kK3FsUE1a?=
 =?utf-8?B?NXdqaXo4RnlCSDh3cS9oWVNpazhZVVRMZW44THc1b0xCL3lvVDlRZUNkRWFB?=
 =?utf-8?B?d3pOdFMyMkF2bEI5aWxEdTN3SFZTa01Xc0IwRFByYytlajRxeG9aU1ArL1pt?=
 =?utf-8?B?YzVjbVFBYXJ2S0JheGsxVC9JMDNkcDd2S2hVN1ZzME9zN1JOc3ppR0FocCts?=
 =?utf-8?B?azRMY3BKb0Nib29YTkxsVWkvdjlOYllJVUpsVmpnS0NsTzkyc01vcWp2Z29t?=
 =?utf-8?B?bm95emNNRWRicmZXZEUwZVprUFB2Y3U5RG9QK0krYy9GdHVVSWpxeVhKNWNF?=
 =?utf-8?Q?1v9FHaSHX+k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OTc4amRpQnlkZTdwYjQ1UnE3VkRYTUZvSnZZNXpleXhXSUpsQmlpeGxvdjFL?=
 =?utf-8?B?Y3B6dEpETVdsZlNMekVTTlAxU3VYbG5GMU1HUXdPYlh4NHN0aXlKYmI0aWJH?=
 =?utf-8?B?b1R5MkE5elBCVHlZblltUkVNV0tyRGh5aUZmajhlT2FCSC93Zy9ybWlGK1Zv?=
 =?utf-8?B?dW5VK3FsdlY2R2NLOEJLK0V0RzVPN2ZaZWtPSGk0MWV1UlphTDA3RE5BanR4?=
 =?utf-8?B?dGM5WnhUaFpmdTRTMU54K1pYdUxYbzZKMVg5NHRXUGZYd05oTWxaZXlQQytM?=
 =?utf-8?B?bkkxV0h2ZzlvM3BzWW9pWVBlWmRha1JGZlNmNXNuS0loM2Nud0hoNnJrTmk4?=
 =?utf-8?B?UjVjTWZGRVZQSm54KzZyaDZRMlV5OEpEWDRaMXNVWGE5cVRpZGJnOUl5WFdH?=
 =?utf-8?B?d01Fa2FFYVBRaGIyWnVraUVUdHBWb1dIWEk2b0FuRldWV05GRW91bHlnSXBz?=
 =?utf-8?B?MVhPT2h4WE04Nk1XRDhJeGVIQzJhdDcrTElEOU1lT2dxaWZJelJ5TVk1MGVs?=
 =?utf-8?B?VjRwZEwxNGJnUFQ2cktQUEJZU3M0dE1naERkT2Z4UFp2S1pSbmdYWG1aRk5X?=
 =?utf-8?B?T2d2UHIrdzJLSE84SVpCYUJDN0NsUXJ2MW5QRzNFZEhWaE1PTnpHcU5RMmM3?=
 =?utf-8?B?elFWeG8vWVRDS0QxYzB6OEhQSlc4aE9FRU9HUmZPMHRTQmFialNFK2oxeXNz?=
 =?utf-8?B?ZldrZVZIbWJURWhxVmFlUVdZWXZ6VHI3MkFhaXZNUHE0UG9EK1Q1TnNDem85?=
 =?utf-8?B?eWxLQ2NrdkVkWUlqRnZzeHdrU0plWFp6cExHTjRBU2tEcGxpNkxyc2pLdWh6?=
 =?utf-8?B?OGM0MzUyS2hZYXFaT29USU56ZGtuVUhpY2Q5T0VoNnoxQ1NlTFYrR1JFeDNO?=
 =?utf-8?B?NTdobVJ3VUVEcWFYZG5XWTJnbDZqV2p1N042cjJGQ01Dckp5WlFnTzhNZVlP?=
 =?utf-8?B?RVlxclI0ZWFGUXI5U3BuRHY5c3NDSTlxZ0JCdjA3M004WS82U2xTNWxqdkkr?=
 =?utf-8?B?Z2NyN3JCRFJKbWN2ZXQyZ0dqVURqOVBYa2p5RzZYdnp1V2taK1dvbjhzcGta?=
 =?utf-8?B?TWUyRVRmQVo4SkEzc2xCaGF3VmJadnF0dU9yTDBucEJQdmpkdmo2bmYxdGVQ?=
 =?utf-8?B?Q1R0R1lnVW1DUHdKNnBBOEtEY3pWU0JTSFhjaXAvdFByTXloUzJ5WVpoVFY5?=
 =?utf-8?B?cHRTT2JWMitFSHdLTWc3OWpmSmxmZG9nT1cyTGxpaTlmTjdTeUwvS2hRNHMx?=
 =?utf-8?B?WEtGd2VXRkFoL3dxdURTUkdPajZFUkU4bTVWdHdicEhTWlRmQTRaZXRiOGtV?=
 =?utf-8?B?c1dkd3hTM3Zrb3RUU2V1UXJ2cjE0aTdmNm5JVDBlTmZZcXZkRzFZdGZMMXhu?=
 =?utf-8?B?YjZ6SVpNQWhPbWg3MFMvSzFOZEV6OFZjMWRHTW1STitwWW4zMytTNDVUeTVq?=
 =?utf-8?B?OVZyOE1nQTlueEdKaWs5TGNhdlgrL2ZWLzFMN1BpcUE3bGVpcjBHc2FlWmtn?=
 =?utf-8?B?N0gvRElBSmRpMW5IdUxPaHhSQjIwMlNMMitNUUF4Q3ovbnRBNE1mZU4yNSsv?=
 =?utf-8?B?dTUwdmg4MmNETkFYR1gxeXo0ekkvRWpuZ3I4MC8wN21ILyszQ2JaY3gwcU4y?=
 =?utf-8?B?bG5La1gyRUFncEl4MmxFN1BYL2FldVB0Tm54d0NaTXMzYXVaM0MrUURrYzRQ?=
 =?utf-8?B?WlpUeFN1djBvTzB0akFKVW5BdnNGTnpxRzNyeFpDS0JMNmNYUy9NUTFzL3pr?=
 =?utf-8?B?eHNDbFZDQnB2NEVDRmNaTFVUTFFhT2ZuQ2tESkMyNGlLdTMrMlhoZUdqUUJW?=
 =?utf-8?B?eWkwaXg3YjRETllLeDVIaDdqa1JpaHhzTWxSNDBhTEJlYU41Ymlxd1NuQklq?=
 =?utf-8?B?M3JDREwzWXVkMXpNVHVzalRBRXRUVWFZZDBCQlJSNUNVR0UzRjRNUi9iNE0z?=
 =?utf-8?B?SFlZamt4WHlad2l6akt6b2NEQjdaYTJtUUZSZW9ScXdjcFZlL0ZERXlYK3Ix?=
 =?utf-8?B?Vyt4Y2d0Rzd0eUZkMGFwSjhHR21vNUg1QWx4U0F2bkVuWXNZMk9IODBrYjZ5?=
 =?utf-8?B?VnJtNUI2ck90dGNDMU9seGszYy9UVHNIQ0ViTkJ1aWdpcXdLbG9zMlUxeW5Q?=
 =?utf-8?B?TXhxTERpUVlDMDZKWHVwUWdJV3JyaHE1YkVPd2JUVStyeE5hblJWdDcrRm56?=
 =?utf-8?B?Y0E9PQ==?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 06104cc7-9b5f-4c0e-b11e-08dde0a3ba2d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 11:13:16.6248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZcIej7FhHD5pvZX2kM0abwr+7fcO/Bz6a7b5XFxyBGi0TW7WmXDIyq75ubWPajsUTzpMB9OOWTY1RZ5XEFH6GyW9oGiERXlAq3E8XctooNU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10155


On 21.08.2025 09:58, Lorenzo Bianconi wrote:
>> This patch series greatly improve airoha snfi driver and fix a
>> number of serious bug.
>>
>> Fixed bugs:
>>  * Fix reading/writing of flashes with more than one plane per lun
>>  * Fix inability to read/write oob area
>>  * Fill the buffer with 0xff before writing
>>  * Fix reading of flashes supporting continuous reading mode
>>  * Fix error paths
>>
>> Improvements:
>>  * Add support of dual/quad wires spi modes in exec_op().
>>  * Support of dualio/quadio flash reading commands
>>  * Remove dirty hack that reads flash page settings from SNFI registers
>>    during driver startup
>>
>> Unfortunately I am unable to test the driver with linux at the moment,
>> so only the following testing was done:
> It seems to me this is quite an important rework of the driver. I would prefer
> to have some test results for this series. Are you able to run mtd_test kernel
> module for testing?

I'll try to build latest openwrt with this patches  and mtd_test kernel
module and try it on one of our boards.

Actually patches can be divided on to parts:
* fixes of current driver (patches 1-10)
* change of behavior to avoid reading flash page settings from SNFI
registers during driver startup (patches 11-14)

The changes are based on the code we are using for more than 3 years. I
adapt it to latest linux/u-boot code.

Up to now the only known issue appears on en7523 chips only. Here a
corresponding patch description (not added to this series)
====================================================== spi: airoha:
en7523: workaround flash damaging if UART_TXD was short to GND We found
that some serial console may pull TX line to GROUND during board boot
time. Airoha uses TX line as one of it's BOOT pins. This will lead to
booting in RESERVED boot mode. It was found that some flashes operates
incorrectly in RESERVED mode. Micron and Skyhigh flashes are definitely
affected by the issue, Winbond flashes are NOT affected. Details:
-------- DMA reading of odd pages on affected flashes operates
incorrectly. Page reading offset (start of the page) on hardware level
is replaced by 0x10. Thus results in incorrect data reading. Usage of
UBI make things even worse. Any attempt to access UBI leads to ubi
damaging. As result OS loading becomes impossible. Non-DMA reading is
OK. =======================================================

Regards,
Mikhail


>
> Regards,
> Lorenzo
>
>>  * Driver compiles without error.
>>  * All changes were tested with corresponding u-boot driver. U-Boot
>>    SpiNAND driver was modified as well to match linux-6.17-rc2 with
>>    additional fixes for continuous mode.
>>
>> Changes v2:
>>  * minor fix
>>  * add comments to code
>>
>> Changes v3:
>>  * add patch to prevent continuous reading
>>
>> Mikhail Kshevetskiy (14):
>>   spi: airoha: return an error for continuous mode dirmap creation cases
>>   spi: airoha: remove unnecessary restriction length
>>   spi: airoha: add support of dual/quad wires spi modes
>>   spi: airoha: remove unnecessary switch to non-dma mode
>>   spi: airoha: unify dirmap read/write code
>>   spi: airoha: switch back to non-dma mode in the case of error
>>   spi: airoha: fix reading/writing of flashes with more than one plane
>>     per lun
>>   spi: airoha: support of dualio/quadio flash reading commands
>>   spi: airoha: allow reading/writing of oob area
>>   spi: airoha: buffer must be 0xff-ed before writing
>>   spi: airoha: avoid setting of page/oob sizes in REG_SPI_NFI_PAGEFMT
>>   spi: airoha: reduce the number of modification of REG_SPI_NFI_CNFG and
>>     REG_SPI_NFI_SECCUS_SIZE registers
>>   spi: airoha: set custom sector size equal to flash page size
>>   spi: airoha: avoid reading flash page settings from SNFI registers
>>     during driver startup
>>
>>  drivers/spi/spi-airoha-snfi.c | 508 +++++++++++++++++-----------------
>>  1 file changed, 260 insertions(+), 248 deletions(-)
>>
>> -- 
>> 2.50.1
>>

