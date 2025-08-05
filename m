Return-Path: <linux-spi+bounces-9295-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9587B1B7A6
	for <lists+linux-spi@lfdr.de>; Tue,  5 Aug 2025 17:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F6B718523D
	for <lists+linux-spi@lfdr.de>; Tue,  5 Aug 2025 15:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF0A242D9D;
	Tue,  5 Aug 2025 15:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="lc1sQNYp"
X-Original-To: linux-spi@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023129.outbound.protection.outlook.com [52.101.83.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0C578F2E;
	Tue,  5 Aug 2025 15:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754408222; cv=fail; b=jvX1H1PwZUd7KBAuKMR/MqpfdnZ0H2sx87hnziQGZLk24FvKzgQUWCyaKSGGabjYVC2kCovvuM0Qt8QBrkTMULLTRFxTjzInAyLhQuIOFvJ6w2nKtKysqk/PgJOv++0i10lSQkRKE+nfGSlwtzGfwpEDOja/Kx17BJ/TOfEw9GI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754408222; c=relaxed/simple;
	bh=7qtf0tZcHwMSrpKeO5hpoKWM74LC8SCOD/G5Gq0F5dM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Pv2YufAmNyL/z5vynK9lAC6XVAHX26gd8xsMIbqzX4AvemVmMgF+SWJk4e77UbV4aPV7otssj5mA/SurhiFnTwM9vbqcGc2DXro6yY5URyy9dVGxO2JpVDZccCkbpfAYYd+CvhM3ah/XSjWft4QwWyocxyILx3fVtxmKVceDkFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=lc1sQNYp; arc=fail smtp.client-ip=52.101.83.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DhCAb/weMYNEzL/60fw31ABmiVSaKnlJfCsBbW9tsQ8CUEfso1Q+y/tWdAhnh5dZM4u9mpD+4QxBnIMBKs7lVA/Cj79qGSYe1sxXGsb0SFKHkJmUDtWqLdNS6fe4mg7wlKPRnI3KMmgNdO7xrN32D6+LpT5NhumKSJ5i08EkfzESwI41+L+K29eIBim4mAGLwRROIJWorb/d8MWixEQRbun9Q3LM7kiwViBsxtjmF7uOAN6gffo4bNz0ukJ69E9BHDQWorKsfMgkC5t8TbIZ/2Qay/hyqMSK+XkDOtfsTOemexJ87j2xj+brOFtSdVEgf+ul6tN5u8QCBpKZEqA4rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=maVb3zcWbi1nwkXudxWrfa5L/jUpJRhsvkr/aRuwqt4=;
 b=bl97zyHYHJdHpBR1ivR92sWo40mfqXkgE3Hnn003F4YYm9mrN98C56pBCIl3+h5FfN92Me6Zs9HmAiGn8rb06ofo726LfcZYi82dzFQWZrnwLcWhKQ3II+bULcRbNgeU1IbcUuJh8YEWosPMdk3fAFuL4/NtMjxmGDoqh1TaSAcYucBBarPz1sYNZ6l7z6gtYHYVdwiImQ6Sn9gbBOl87fu++rcDXE+K5LxQSzaGbANxNoRb78YQzJWAkR74pFpsnmbO43hfn8odXxT3h8ydpRijpx7cipsTD6i4c2aGJzQ52/neLWgSumR/X7WM+7lITSFf3cAEVbpdi+r4OKKaOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=maVb3zcWbi1nwkXudxWrfa5L/jUpJRhsvkr/aRuwqt4=;
 b=lc1sQNYpyxzecV8KJGqpaG7FPKIgVBFIbZ0NNL8jCtiD/g1hDh0MkMTu4q3LJoWIMcz1jvRT3gvBlEL8MW2hqYCcyEnaDZqKOhfCeKVrSHkvIC67bKLiAoH+pRKCqrsiHlubg/SuC+YZ8Tz1oOyxw8sMc6FJ87dyvWnnYBXIcLFsiLKDPTx0lhByMKAcE/rzU8rbOB476Np80jy1ljSzvVZewAXbL+QVs7BfYIl/5QB2KJWyQR/orRhlkhVYULrOyas0p7rqGpIHHi8gbnR78pZBGS7EZsY/PS8KCiysNVEHp38IVt+v14XFWOQeAhKmVBmS4Y6KGhS0Ryy/MHHl0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS4PR08MB7855.eurprd08.prod.outlook.com (2603:10a6:20b:51e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.17; Tue, 5 Aug
 2025 15:35:35 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 15:35:35 +0000
Message-ID: <74646064-0c8c-46b9-8ec3-653c4f80b70f@iopsys.eu>
Date: Tue, 5 Aug 2025 18:35:32 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] drivers: mtd: spi-nand: try a regular dirmap if
 creating a dirmap for continuous reading fails
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
 <vigneshr@ti.com>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Ray Liu <ray.liu@airoha.com>, Mark Brown <broonie@kernel.org>,
 Tudor Ambarus <tudor.ambarus@linaro.org>,
 Martin Kurbanov <mmkurbanov@salutedevices.com>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-spi@vger.kernel.org
References: <20250804192132.1406387-1-mikhail.kshevetskiy@iopsys.eu>
 <20250804192132.1406387-3-mikhail.kshevetskiy@iopsys.eu>
 <87jz3hhjlj.fsf@bootlin.com>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <87jz3hhjlj.fsf@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR0402CA0035.eurprd04.prod.outlook.com
 (2603:10a6:7:7c::24) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS4PR08MB7855:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c755bd0-5fa2-4897-14e3-08ddd435b893
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eVpvNkh1YXJmYUhlTTZkbGFMNjBBdHdHVzNzSXdueW5OdHFoUTR3cURQVU5W?=
 =?utf-8?B?c0RrMEdkRU5TK2hIK3c0M2M0M0VreG8vNGwyelN1djZnejcvM3JDRjNiVzQ3?=
 =?utf-8?B?RW91Y3E4Z2Voa0J5RS9qdUFmdHhxTnNjWHNoNmVJK05zb0Rnd3U2YytEbUl3?=
 =?utf-8?B?SFdEcXRBODZkb1ViYjFyekE1bkZ3dE1iSEIwOFBUT1JGR3ZYSTVIaTY1TVo0?=
 =?utf-8?B?bE1tVEJnN3J6T29QbUh0QTFMc1V5SXRaSVE5MzJiNHU3UTRpcGdqcnFyS1pa?=
 =?utf-8?B?bmZYbWRrdXlXSS9iMU45aTJDU3Era1FZb0hSZHl0WlNIak14VzRZeFZJYWpM?=
 =?utf-8?B?eVJZRUQ5UGY1Wkc3YWFJZUlRNjB0bVBZQ0k1MTI0czArRWtiaEErT1p0S1Rn?=
 =?utf-8?B?eEJFZnZWaHV3dHhQQjlGckhRd3FlaEs2Y2t3djZyQ203RmdmU2ZmM0FzNTRS?=
 =?utf-8?B?aDhYbkVQRnIvK29ER29zeVkyNXk5MklWTFF5OXVpZEt3T2dmNys2elR0UU5I?=
 =?utf-8?B?cy9IcVQ1QWdQUWZrR24wYk05T2NTWDhZSjNUQk5yampmN0I5SUhhci9oVCtF?=
 =?utf-8?B?MFpkMFZEQVFUVHhhK2F0V3QrZWZuWVkzVmpqY1FReTMzNlptSDBqZnlvVTdD?=
 =?utf-8?B?emMwcXJvdUNoZDNRZWFDSnV2elozRks5UXBtWm5MRW1maVZDN1FOQW16U0xK?=
 =?utf-8?B?K0RPaHNkYlhYWXR2Yzl5NTlQQU5Ca0w2bit1Ry9PSnpNZFJKT3hkYnU1Y1hF?=
 =?utf-8?B?V3lMRDd3SlRaRmRJekVhQWNjQVl0OHd6UDFmQnJTbFEvNStNRGp4MWhCZVNC?=
 =?utf-8?B?Vm1XK29JbHF6SFhTeVZ6VUkzcUZsampWSmZMSEpuc2pHek44ZXdkeDBSMEFl?=
 =?utf-8?B?QU9lMXhJcE5GVVFPMlBuYllRbmZZVk5kbWRwdXlNRE83QlZla3JqUVk2QTVn?=
 =?utf-8?B?UDJubFNURW5GR2w1RjRybzNtS2pkbXpuVmZwQkcva1l0YTVaVW5lN05ua1Yw?=
 =?utf-8?B?NDJ6K0hsL3N0QlRlUStOTmFkUlcyTmdYL0MzTXFpa0FPTWFneHREYlErZUZF?=
 =?utf-8?B?S21tZWlzOHh1MFJOR3AzUHRrYnJqamJJVEUyYzA5RGpFSG0welRvdHUxTEl0?=
 =?utf-8?B?ZXVNVkUyK25PWjZJakRIL2UrY0RuQWZRUTNkelJ5bDVOamhsdnJBRVFRTzVS?=
 =?utf-8?B?cDdWamVDREczSkpDbm5xYkZPdkdhbUZ6V3RBb0paRW5Yd3hUVzJ2ektmd2Mx?=
 =?utf-8?B?M2tJUGNydktTOVQ3RmpJRVJXcUpSbFJ2MHBFZlQrVnR3eEtDNE9CS1A3Q253?=
 =?utf-8?B?ajZCNWtvU1ZLWjFpdnhpUmpNd1FBV2phVXl0K2FaTENyd3hmamg3MGFDTzJZ?=
 =?utf-8?B?SkZzM1BYWi9Zc2Z2STl0VWJXcUhNRlBCUXczcUZwM1IzRjgwTnVwUGVlY1FH?=
 =?utf-8?B?OGJhbnFzeFc1Tjg4cUlpMFpJUVVBZlV0TFQzc3BPZVhlQWJBRldQRG01R2Jx?=
 =?utf-8?B?WTVhMUlLNUJNMjRnN3pJeTVEYTI5c2dtVDU3N3JCOFlRMUNmejdDYnRNbFRS?=
 =?utf-8?B?S3VSTmtsTzJ4bSt3eU5jZHdRMnFPcGtwNzJnWk5odncvU1NEV0V0UThSczFE?=
 =?utf-8?B?Znh5N2hucnhNWkozNkJPTWFXOTRtUlNpSExacklZdWRIL0dRcnpVS1NNN2ZH?=
 =?utf-8?B?Wk5NS2dnU2Z4YlJ6aWJNZHVXU1l5dy9GNTZ1MkFxdWZLL3JKQ3poSDBVdDdM?=
 =?utf-8?B?Nndkc21QUzJRL3ZZZ2NpMFhYb0UxR2E5Tjg5WGRsWCtZNHdnYXdRL01XdWFC?=
 =?utf-8?B?M3kxZE5ISFlJTk9tVCs3azNHUFRPM0o0R2FLY0NwWmMxRWE5S3RTVWE2Z2xH?=
 =?utf-8?B?cmZ5c1lXVElHNXpteUdlR3FHc3RJWUo2bGd6V2E0NVlEWjN6VU5rVERzQ2I0?=
 =?utf-8?Q?+3lFidrAO+w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eGZjakpHQ0YyN01XNzY0S1FvQnk3b0NaSk1MUlpCbTZ6SUFwUjBlOEhWbS83?=
 =?utf-8?B?eFk2OHJqQlVudXBpUFdwUjZPdHlqM3k3Qll5TWFMaERORVVRWkZ4S2hBVVE3?=
 =?utf-8?B?Q3lidHVnUjQxUnc4L3FEY0tHdFZhdEkreFQyeGpHbFlDaithZWZQY1ZjZnBs?=
 =?utf-8?B?c3A3ZUNXZ3k3dTN5dTdQUzUzU1J5cWpxTy80eWZrWDhPNzc3VkJpTS9FWm1h?=
 =?utf-8?B?cFpxdVg4SU5OZWpPMzlOcWpFV3ZhQXVMaFVQazczMTRxckxReGxzMmxtM29w?=
 =?utf-8?B?Wm9YcStFVFdGeDAwVzdLZXg3WnhWVFpLeUhmNnNyTllkdnozRFJkMjFIS0JK?=
 =?utf-8?B?OWhQRE9wZW5LYVFQNGpqbFhnYkcrV3RuUXdWMUlMb3FRVGsrL095OTZQbnMy?=
 =?utf-8?B?SjA3OGQ0QkEvNkIveTByLzZXUGE1NVVWdTgyTmk2SHBsaExCUXVhY2Rrdjlk?=
 =?utf-8?B?ekRQa1VFK1N6TW4vak0zeldmV0lSRVZBS25seG1pVEJxcXdmVEQ5QnJJdkx2?=
 =?utf-8?B?RlBSU2NJU0xZSE5FT05SWXVybDY2RnBVMVM5bWVqa2t5cFNYTE1ER2svVE81?=
 =?utf-8?B?K2hkdjMwODU0V0N4WHNRaTNubkVnK29Xb2Z6ZUhFdkpGR0svQjA4MW9PbEFG?=
 =?utf-8?B?c3dkeWc4bys5SURMT25TVDRJSkVLbUJ0L2Y5TWJ0NVl5dDE4TklnRWxFcXRP?=
 =?utf-8?B?SHRBSTMzUmRZMWFrNHAybDBZYVd3ZXptcGlVTEU3aG1pd1VLVmhCUnRzeVB3?=
 =?utf-8?B?bnUzcG5MZkhvTTR4NkNta1YzMFdBenR1OE5NRCsvTnNyeDB0YmRKRDRyeU5P?=
 =?utf-8?B?a3RodTJJcllrcTQ0ZmFUcklrUzdRaVd2RTZqVi9GbFRObEpKVFhoT3NMM3Bw?=
 =?utf-8?B?T210RTg3cnNIejU2NEd5QmxjZXVneUtJZ0c3QnhDM2VMamZIODJxTU10L254?=
 =?utf-8?B?VVlGOE9QSEpnRFJkeG9GNmRWdnptazJqMUhHRWFRbTFIQ0hKQjMxL0gwVmxV?=
 =?utf-8?B?WS9OazZoUTZqODBKNzBuVUpGVDhNb01ZcllzcXY2bWtmb1owM0gxNllkUU12?=
 =?utf-8?B?eEpaY2xkUjNTUVJCbXJ2Rkk0cEdwRWlPc0ttVWNCRUMxTVZpNTE5SHZrV09n?=
 =?utf-8?B?amx3SjV6Zit1Tk5IVXkxQ0lFSER0Z1B3Q2ZCb3NROVR0eWVQdEJxNTZtMXdn?=
 =?utf-8?B?UWpkMzRSRkV0bEhVWlBuaGlNUFpubUNWS2pLNHZpRGJJQzluUEt0aGNlUVZ1?=
 =?utf-8?B?aHl2cHdFM1dVbFcydTlhSkJhZG9jOVQwTVEraFBtMXRRb3pFRXRqMWUvMnpN?=
 =?utf-8?B?djdROThGZ0psQStNZEVhSHU4QWo4b2VJN1Z3VXdBeEhtMUNRelYxQ3hSWUd1?=
 =?utf-8?B?M3F5THZBLzlJNGNrSFRIZC9NVjRNUHlOUUpYenRnaWgzQnZYR21PYTZHYXN2?=
 =?utf-8?B?c1F4SHlLSmpOTG9WRHo2SnVCald3SVhCZmJnZ0RxbmdLZkM1YVgrZzBtcng3?=
 =?utf-8?B?Q043VHlLT2xzOFBDU3FjSW51QmNOWTdYNzZmN3ViQkZKOWpjNWx4Z1k5N3Yv?=
 =?utf-8?B?VUdSWHJ2Qm1TaUtBWFJlMkVTT1hMbDhPa1JCMmdMQ2wyV0l1aGZJeGRtT01h?=
 =?utf-8?B?WVFLQnQwL0tLbTMrOGh2dGJNejN4N09ibU9uTGhBcy93dVFyaXF2TXViUThp?=
 =?utf-8?B?NnE5c2x3L2ZHblJGb0NGUjhER1UzRVYvd0p1ZitaVTBVUEg4Y0VBT2hhUThK?=
 =?utf-8?B?SXc1S3NHbXM5OWx2RDMvZmRiY3JEMndBTWxzeWN5U1B0OGpxUVpCV295RWF4?=
 =?utf-8?B?ajhZdlJPclRQUHZsbVlRRFE3QnVZR09hTHIzNGFsTW01R3Z4akliM1YrWXpq?=
 =?utf-8?B?cWt0U3NleS9ZdVFEcVpVLzIreHdVNnl1akl0RWZPTzVCakt0ZEFxbWVUZks0?=
 =?utf-8?B?SEtVc2xGQ2U2UWJEK0JhZUovb29oL3NvNVQxOUNYYzZ0RmM3L0dEbnJhdEhi?=
 =?utf-8?B?b3gwdDBNbFI3T1RnN3gySlNBOHR6dXlNMWNzTzZxRjV5NzhKS1pLdjR0VFB1?=
 =?utf-8?B?ejJNakF2SlQ2UDQySndNbmFUTGd6TmRrZlp2OE5mSkVab3RITm5rMmNFTThs?=
 =?utf-8?B?WXM3S0duM25aOXNJMWtsdmE1SFdLV1lWY0dXcXZvNm1JUEdvd3UwZzd6UitS?=
 =?utf-8?B?UkE9PQ==?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c755bd0-5fa2-4897-14e3-08ddd435b893
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 15:35:35.2867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EVV4SnnQXwWYiw/QtSXQbw778owODsGjCD6TX5FmeRTIZ5tiX8m1uJJz15kdxnAnYYy0IYfRSnZqsIJ9cqCrRZvHjKD7D/dt0nHULjiuvB0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7855


On 05.08.2025 18:30, Miquel Raynal wrote:
> On 04/08/2025 at 22:21:30 +03, Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu> wrote:
>
>> Continuous reading may result in multiple flash pages reading in one
>> operation. Typically only one flash page has read/written (a little bit
>> more than 2-4 Kb), but continuous reading requires the spi-controller
>> to read up to 512 Kb in one operation without togling CS in beetween.
>>
>> Roughly speaking spi-controllers can be divided on 2 categories:
>>  * spi-controllers without dirmap acceleration support
>>  * spi-controllers with dirmap acceleration support
>>
>> Usually, first of them have no issues with large reading support.
>> Second group often supports acceleration of single page only reading.
>> Thus enabling of continuous reading can break flash reading.
> I would be more conservative, I believe it is very implementation
> dependent; many controller drivers do not even advertise a max size.
>
> I agree though that controllers with dirmap support may express
> limitations such as the mapped size which may lead to splitting
> operations into smaller chunks, possibly leading to CS changes which
> would break the continuous read mode on the chip's side.
>
>> This patch tries to create dirmap for continuous reading first and
>> fallback to regular reading if spi-controller refuses to create it.
> no '-'                              ^
>
>> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
>> ---
>>  drivers/mtd/nand/spi/core.c | 29 +++++++++++++++++++++++++----
>>  1 file changed, 25 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
>> index b42c42ec58a4..ff6a1e2fcfdc 100644
>> --- a/drivers/mtd/nand/spi/core.c
>> +++ b/drivers/mtd/nand/spi/core.c
>> @@ -1114,11 +1114,32 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
>>  
>>  	spinand->dirmaps[plane].wdesc = desc;
>>  
>> -	if (spinand->cont_read_possible)
>> +	desc = NULL;
>> +	if (spinand->cont_read_possible) {
>> +		/*
>> +		 * spi-controllers may return an error if info.length is
>> +		 * too large
>> +		 */
>>  		info.length = nanddev_eraseblock_size(nand);
>> -	info.op_tmpl = *spinand->op_templates.read_cache;
>> -	desc = devm_spi_mem_dirmap_create(&spinand->spimem->spi->dev,
>> -					  spinand->spimem, &info);
>> +		info.op_tmpl = *spinand->op_templates.read_cache;
>> +		desc = devm_spi_mem_dirmap_create(&spinand->spimem->spi->dev,
>> +						  spinand->spimem, &info);
>> +	}
>> +
>> +	if (IS_ERR_OR_NULL(desc)) {
> Here if the problem is continuous reading, I expect an error and not a
> NULL pointer.
NULL is possible if flash does not supports continuous reading
>
>> +		/*
>> +		 * continuous reading is not supported by flash or
> Not by the flash, here if we get an error, it is the spi controller
> (still without '-' ;) ) that fails (please fix the comment).

we can go here in 2 cases:
1) spinand->cont_read_possible is false (flash does not supports
continuous reading)

2) spi controller returns an error (spi controller does not like
continuous reading)

>
>> +		 * its spi-controller, try regular reading
>> +		 */
>> +		spinand->cont_read_possible = false;
>> +
>> +		info.length = nanddev_page_size(nand) +
>> +			      nanddev_per_page_oobsize(nand);
>> +		info.op_tmpl = *spinand->op_templates.read_cache;
>> +		desc = devm_spi_mem_dirmap_create(&spinand->spimem->spi->dev,
>> +						  spinand->spimem, &info);
>> +	}
>> +
>>  	if (IS_ERR(desc))
>>  		return PTR_ERR(desc);

