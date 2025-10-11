Return-Path: <linux-spi+bounces-10572-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C19C1BCEFDE
	for <lists+linux-spi@lfdr.de>; Sat, 11 Oct 2025 07:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB9DC19A4A37
	for <lists+linux-spi@lfdr.de>; Sat, 11 Oct 2025 05:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CCD156CA;
	Sat, 11 Oct 2025 05:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="gykA6Z45"
X-Original-To: linux-spi@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022121.outbound.protection.outlook.com [52.101.66.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963203D76;
	Sat, 11 Oct 2025 05:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760158933; cv=fail; b=hluk8+szuVBPFMwRWvlgljM6z5ZqgFR4XeV8Rq9fgScJcT4siET15K2FZhd+EXkUmG2fGfXPL4XWb1I6lneh+zYfJzdE32DwXbt/l0CaN2pHGiDFOSd9yXXIWzI3XJ+6/W+bnCqhvAZ0Y+rqaq+Me9naQe2v7TX42ISZWCfFSP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760158933; c=relaxed/simple;
	bh=fA/c28Kf7NEXtyXu9hJ9iFrzzLZwuTux1F8pNWdtAiM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DCmQ7y39u/9L3Wijm094QHab3hpkD3cVwXjY7+l74zEkvCHxBOKuPPcePCb97/hDRaexloczZ5K7QbhAJZ0fLgJ/IKYuZNTmWha5JNy7K3oxBa9IhA1vryCabwqd5eBT+jhO9g9TxLOIQFM8TE85UEO6pvTHBFkBRCHEWYRL+n4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=gykA6Z45; arc=fail smtp.client-ip=52.101.66.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TbDaW5tb+Xl+EFzvIAFbqGssmh5O5GoZFXtF27DGim6K1mwALSDknghE7BsmrsJf82T7O2DktUqZRFIezHNTp7R05z+dAcOhUfrqxVmfeFDHCngYD7Tg/TGUHwWXZ3hB6Nr6xUdwG+N/I3IueAeMmvYi6GfkYMlTn7v0h0LNknsPwDxUaCHqGgcrbH4LK2tm3KIZjcgVeKYqEJGMVZpEE3g+cCIqOinOlk/PXEu5dHco/v4NPdIbC47WeC0YLNntoZb9BPVS8fXFKeKhinkHjmTRtOTP2l5HRUMblak6UKXVvjAg5mq5PZr6Ab2oeKYLnQUXbURNsFZa4ZMAEk7N6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jkCtL2/ykNLPMBgPFqbyjhwBGVMME8MyEkFkBuDfJkY=;
 b=dvI2XQXs32cSIFXAguqXtaZFwFV3kBYtw1ULWnAU4hNERoG2/oCOpYJN/w9fPGAwXwd7gPaXYzYf9n7PaUdfGWALWpz9wkTXek8DgAGVtEsquPNKy+PV9/H13wgEc2K9jT97rQZ+75FOmvnGg+LFlPYcG5b7EG15wm1piEBla0Y47G/b5LGJMmf6XGvWxqdUv0D+3v1DbEwMMxx6lFLkPa+yWffcRwzEfbCuuXEE2nYds1CuHvi+EVlioo+Lllb0+99KeyXI9A2Dzt4JWEjCv2e0QyGHndBSPdrSsDYTk5tD7GvLDC9uIdKK1QfS+ljg7oYR3dSOMEqTY6ptOmjgaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jkCtL2/ykNLPMBgPFqbyjhwBGVMME8MyEkFkBuDfJkY=;
 b=gykA6Z45dKRGliP7mbMEQ5qMJuvBvJJdM1jPyVy5NY0Tn/if7NY7ESpY9+VTlLUuDanb48y/BVw1fCGRnqT2zmyOSaxeKQSnMP3/EYa+X5HkWHZFgUyMP++I7554boiyXCDc2EUDxghZf23mD6eTDQGMj0zmSmR8O+b7PTl85fhsF1krpmIBXdXQXg9UNBgr3eSSsgylOneoTJQ8WTuFCbAiZsYdAh3h92i5R9IlPhdfsXFWYYAq+e2Oc7ozEPWT+kBD60uGO+5Vn+v+leW+BJZ5ubMtqYeh0HSPzmHOeOD+CGxQZYQOuqoJs+ZUINF7G1lauk/8w5snbJ03dR82ng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by VE1PR08MB5854.eurprd08.prod.outlook.com (2603:10a6:800:1b0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Sat, 11 Oct
 2025 05:02:02 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Sat, 11 Oct 2025
 05:02:02 +0000
Message-ID: <10802039-ca65-41c0-88fa-51db6d86aabd@iopsys.eu>
Date: Sat, 11 Oct 2025 08:01:59 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 15/15] arm: dts: airoha: en7523: add SNAND node
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Ray Liu <ray.liu@airoha.com>, Mark Brown <broonie@kernel.org>,
 Andy Shevchenko <andy@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Cc: Andreas Gnau <andreas.gnau@iopsys.eu>
References: <20251010204500.1625215-1-mikhail.kshevetskiy@iopsys.eu>
 <20251010204500.1625215-16-mikhail.kshevetskiy@iopsys.eu>
 <34899379-9788-4ac8-8b62-e9f47b4d49d9@kernel.org>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <34899379-9788-4ac8-8b62-e9f47b4d49d9@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0112.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:8::23) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|VE1PR08MB5854:EE_
X-MS-Office365-Filtering-Correlation-Id: 2aec58ec-e1be-4869-5ff9-08de08835086
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RlJ6aDNBbW5oZmQ1NE9aMk9zcndDdWtrSjk4ZVNTLzJNSHROa3BOSjZ6cWYr?=
 =?utf-8?B?THl2cTFneUpHMmxKZ3U3YVpZR3c4WnpBVzN2V0gyR09DRnptV0I5NFVPNlJq?=
 =?utf-8?B?Y0pzRVI0aFFKMlR5cG45RGFiVWNjYnoyNmdSYTIvWXR0UTdHaXluMjg1QzlW?=
 =?utf-8?B?VkVWOUdrL3ZtMjNYaG5PYXdCdWE3L2M1SERQL0NHUUY5UEczRmxiSkF2L0lm?=
 =?utf-8?B?TFljUGJ4VFF6blFReXRCTUxzUVgvUlRXeUJDQXVBSXBONjFoUkdUOGg1Z1Iy?=
 =?utf-8?B?enF3MWNCQ1dLeWlDbUtpNkh4NjVsUnUweWx0QTBZaUcrbXRnU29RbXhVZ0FN?=
 =?utf-8?B?UlgzUW9lN0labzg5cUZkMGZiVEg3enIvNXdvQXlKcmtTZU53T3BDblRHNUZr?=
 =?utf-8?B?eW1DaDBHNForaU1VSytFWkpyWVBadmE1VkJJTW9ZcEFlVnl4ejd0KzJLT0xG?=
 =?utf-8?B?Y1E4MElrTjFxZ1N3aklmUGw1WTFzS0R6MXlsMDF5TmY1dDZ5QU5LNStTYjls?=
 =?utf-8?B?dHlwVTJ1N25QbTdvM1RRbU5haWtCQUFCQ095a1REOTdsditaVXN2YTFFQWJH?=
 =?utf-8?B?N2tWN1Yybmtna1ZkQU9RN1lSaElzckVRa3hvVGpqVDZuL1hpOFErNy9IamFn?=
 =?utf-8?B?ektMZEFRWk9naFhiTEdYb3lKMUJocTZpR1ZOVk56ZXdhOWtJaE5ZZFJOT3Bu?=
 =?utf-8?B?ZnRCZkR4WG5wQzY5bFNlc3BYS0tYbUJNcWZ4YTdvVHFuNjVTVDQrUFJTOXJV?=
 =?utf-8?B?dXJkOHYvYnZhbXhRa0FWNWJKNGthbEFtVmNFeFkwL1VoU3o3QUdyUy9xdzlW?=
 =?utf-8?B?TUFqNndyeDREcnh1Y3NkOHFyNGJQVjU0NGZFUHpzeEZEaUNpaE52clJuaksx?=
 =?utf-8?B?VXdHQWtobEdDbnY4NFAyK010ekxTQjRhTnlsSU5qN3NnZGk1aU5EeWVRMTVR?=
 =?utf-8?B?U1NqLzducDBaVkZpUEwwU3pNdzR2Y2J3SFZpQUpmYi9BS2pKV3BsdUxCdFhD?=
 =?utf-8?B?Ujlock5FbVN2YVhVNENQRnEvN0dPMU45L3FWY1F0NHdJT01VSXdiMTZSbXIz?=
 =?utf-8?B?dEtxTytsYjBzaWxZWGw1ZUo4cDNKaHMxZ2RpeTRzb0YyVnBZekFYeUt6NExS?=
 =?utf-8?B?OHlTbHBndnloUkltUUNPVFJ0QnArU1ZBY1RlK1lMTDkxQm1hMG0xMXhueW5m?=
 =?utf-8?B?cExVb3JIdVVSZkVKWk85eU1XMWtsQmpSTi8rNE5FR1FiWkhxUTZqakZsTE1s?=
 =?utf-8?B?R1FUOXA4eWtQZTFra2JjSGFRTjNwR1VuUk1nMmZLeG9hais5cmdrc1RHclA0?=
 =?utf-8?B?a0tUWEkra2RpbDhrVU13bytSL3l0QmVyKzl1YzZWbkJxc1dybzVUZ0x5cGpR?=
 =?utf-8?B?b1lBT1dNeFM4TEZTV1FIc0xmVGxqWUFTTlBjOXdXR0V0ekpBN2l6dUJYVnFn?=
 =?utf-8?B?SkRDWVBvcEJJQmgyU0R1YU9HeVNTYWJ4TkxLNXJxdlFwTWhZZ3RCTDBJWFlS?=
 =?utf-8?B?aCtiSVNRMnR6RGErMWVoa3hoUVRtYnlyd3NuT3c0Tjh0MXFQdm9lZDRpQktU?=
 =?utf-8?B?dGpyOW5PaXBnZks0M0c1TU9rcGpFK2VxclJJZnVmR1d3UThzd2p4QmdsQkxB?=
 =?utf-8?B?UUZ4SnVCdS9EZ015NFNSd2JsME4rdEorRXE1ek1hUzNlci85SEVqeG92Yk5y?=
 =?utf-8?B?RWMxU3FRVG9od2xtS0VSUE9LbDlzUDhXSVlxcmVndk5oYlBub2lmZVozZWhE?=
 =?utf-8?B?M2xLMlJtRTlVbTNDUEU5TUZuMmdOVDRMUmJiYWp1SnZEcldkRnRKYVJWRTRs?=
 =?utf-8?B?Mkl2NnpIWWRIMTRXSnphOENvaEZUTVBvazEzSFNPclo3Zm1zYUFJYXJwTG5G?=
 =?utf-8?B?S0d5UXMzb2FuZDVkdW1ZU2lROEQ4OE9ya2o1UGlUZXUzNWNXbWFhTXBxQWVX?=
 =?utf-8?B?ekJmU2lZbCtmajRtV2ZkZWMvSkpGNVdwVDhiMzBLQTJNTVd4eWhMbWxBWEdh?=
 =?utf-8?Q?7jjFtD5n81ufXTalIRI3v2jXBOizgU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RUdjbW9QRWtFT2puN2pVdlZJYThxdnRHcHA0Qjk1dWNwMTJOay9BVU0zSkc2?=
 =?utf-8?B?WHRZdE45MmwvSXhDTHMxZzRDOHNGNHl5Ymx2dU5JMk40VEF2UnZ4TnlrM2FO?=
 =?utf-8?B?TWp2OG9IUVd4NlE4ODEzQm9JazhrNm9zeWpmZlVDOWdnaURpenljUnVHVlNF?=
 =?utf-8?B?ZTZyOXJ2TzQwVDliU09ydFdSVmxmRHhzZXZBaEFWSkhVSmVYS1luQld4U2xk?=
 =?utf-8?B?S3d2YzFiRTVROXdNU1hRU3FZMEVSaTNGeWtDT2ZZVDRTV3MwSENDUTVtdmZ6?=
 =?utf-8?B?VWxDMFRJRCtpOXlKSmtGeEk2SHZTekVXcFFEdTlLeHZseDRRTzhkRW82eTgv?=
 =?utf-8?B?Ti9Vb0QvUGorVFJlRzJBSnhVRzBwUmo1RXdUNkhrTW5OY3NzNmIzNXVzUk1s?=
 =?utf-8?B?R2hxYXFsbFloU0oyZCtSeUYrYVJGVlhMVU15QWRPbU1jTjBuRnVGZTFTNVJI?=
 =?utf-8?B?UjdIV0VmTVM4OU1zSmRmZFU1WWwvdEtWYTZRc2NiSWwva0g1SUs4SDFFVkVC?=
 =?utf-8?B?Nm5tUk9RRzcwVnVGUkM0VGVnZGVpcEtUQjJHRXFjL2JqM1QvNCtsUE9lMlZX?=
 =?utf-8?B?MjROL3NjdnlWQ2dwdCtKV3ZZZWF6eENETENkeFl4V3VCeVIvRjVEQUwzNXBp?=
 =?utf-8?B?dlVDZWlOR3ZxQ3R1Unk5Y25FMm8wUUtyNVQrRmtWVXQ2K09ZTXF2QUg4QWMy?=
 =?utf-8?B?TkhPcWREZU9iZlpDb3JhU0JjNmRoa3UzS21nVDFXMkoxdm12T3hqeVc0OHVn?=
 =?utf-8?B?a0lOZ3JyUDFuWlpsTWJwdm1NL0UxeFh3cC9Ic3FLazczZVgybXpPYmdZeFhP?=
 =?utf-8?B?eFAzbGU2QnYwODFaTVc0QkhwRDFaRFl1ZmZUMnZGTTMveUd1d2tBVGpUaG9r?=
 =?utf-8?B?VkRnR2p1dHkrVWlMakNXSThuYW8wYi9yeXFESEtYV0pqWTA2UGl2UlVmWHdY?=
 =?utf-8?B?Q1dBRFZMV3BMYmZMSjhVdzM3L0tUclQweW13bWRlYzN3QitGbXR2MWVXeHJp?=
 =?utf-8?B?c2V6QlZQWGFab1U2UEV2a2NvSW5sU2szc05VTmd5ZnMzTmFHeWNEWURPNzNv?=
 =?utf-8?B?R29jaTBPQWQ1U2gra2hySTJPeFpHUXcrRjVDbXN3QkgvNEFHVG9VYzFXRlhZ?=
 =?utf-8?B?QUh5TUg4RFF4SFE0a2xHWGVObS9tSERLSWl5OE9HcGcxVEcrYzhSbnc0Mk1R?=
 =?utf-8?B?QmtKMnlYQkZwM29hb3hDcUZKNUt2QWNKOXgwY1NTSndEVWlhTGs4N1pCRHp6?=
 =?utf-8?B?YVg2cnJkNDY2M1A3Z09xTjFwVjR4eEF0STVLTVVGbko5dXNmTG40bGYrYkdx?=
 =?utf-8?B?SnVRMEJTUm9sb1dhRXFoTFVVVDd0VE85aWxPRTlYd2NIV2hiOFE1TkYxWCtY?=
 =?utf-8?B?Z09Tc2FxeGo5cGM0eFBBKzB1S29hQlVET2k0eXB2bnlnK1EzTnYwSHRuNGNt?=
 =?utf-8?B?TmpJTGFzSy9KMU1jKys5VzNqeDJ6SzZ1Y0ZON0ZxOWJ4OG9NZkR1bjQrNnVH?=
 =?utf-8?B?VkxEMUkvRnJOeTVRY0MwUkFWcGgzVkxXWjNlVGN2N21pdDZVV1Y2S2tPL2FI?=
 =?utf-8?B?OEVHcGUzYno2TUJFZTJJdjcxbGVEcitYOU9FeXh2QWhYYTVLNFVxVlBiV2ZP?=
 =?utf-8?B?MWlCVStydXJRc3B6Uk1MSCs3dStPN3hERlg0YVc2V1hja25KUk1yVjlqKzBj?=
 =?utf-8?B?dkdFdGJmZFltWGlTV0tzMTVjK2N2NVB2RE5SdldFdGU5OERBTWllZUdMZ2U5?=
 =?utf-8?B?bkpLdWdPdnJtL2ltaVp4dkVVNVUvNm9WeHk2b3IybWFyaDZqR0p2djJGK1RE?=
 =?utf-8?B?aUVsOFZmd0ZUOXdwQUh1YTRzSitnUjdvQWhNd2M5OW5VWEFtNUlQOFhyenJk?=
 =?utf-8?B?NG5HQlZETEIrUTJ5WHFlc0NpeERKVkZtakdQY0thUEFvMVFkQlpsQkxaVWxx?=
 =?utf-8?B?bmo1WUsxcDk5SDhLVXY1MUlLVjEwcThSdTFZM3drNVpNbHZiQldtcFFMQlg1?=
 =?utf-8?B?QjIyRjB3TEgzZ3M1Vk9rWW5UODNqRFNPTEU1Si9Ld3dzYUtpRUxsRGhMUTdI?=
 =?utf-8?B?S1EvWkoyN09nbldxWTVscXB5bWNqVVVCUjFNcFVrdmd0a215RlBEdFBrcGJq?=
 =?utf-8?B?STdvZk02eDQrZE85R2JaM25ZVHhyZmJ2Qnhjc1pDbjJNb2dpMDR4dUI2Rjhh?=
 =?utf-8?Q?o/yRupKJG4U4l/vrMUFt0OQ=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aec58ec-e1be-4869-5ff9-08de08835086
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2025 05:02:02.0485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CR58JbACKgDzA3o+t/vXUlnVY1YyQEG7ksoeP+fsrcZvGrsTqVKNgGMVjao/DQdLR9yOkALdAPCaR1eDdsNr4j0Zz9jukWLS4hgaqcYpCnA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5854

On 11.10.2025 02:42, Krzysztof Kozlowski wrote:
> On 10/10/2025 22:45, Mikhail Kshevetskiy wrote:
>> Add SNAND node to enable support of attached SPI-NAND on the EN7523 SoC.
>>
>> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
>> ---
>>  arch/arm/boot/dts/airoha/en7523.dtsi | 21 +++++++++++++++++++++
>>  1 file changed, 21 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/airoha/en7523.dtsi b/arch/arm/boot/dts/airoha/en7523.dtsi
>> index b523a868c4ad..78e351eb787a 100644
>> --- a/arch/arm/boot/dts/airoha/en7523.dtsi
>> +++ b/arch/arm/boot/dts/airoha/en7523.dtsi
>> @@ -203,4 +203,25 @@ pcie_intc1: interrupt-controller {
>>  			#interrupt-cells = <1>;
>>  		};
>>  	};
>> +
>> +	spi_ctrl: spi@1fa10000 {
>> +		compatible = "airoha,en7581-snand";
> NAK, now I found this... Respond to comments instead of ignoring them.
>
> Three versions within few hours, that's not acceptable. Outside of the
> merge window the expectation is minimum 24h difference. Within merge
> window this is just spamming.


I already lost any hope to merge this to linux-3.18, so no problem.

Could you and Rob explain me this compatible issue? I got a feeling that
Rob telling me to keep "airoha,en7581-snand" compatible while you are
telling the opposite. As for me the use of "airoha,en7523-snand" or
maybe "airoha,en75xx-snand" for both en7523 & en7581 chips is the best.

Is there any policy? Could you provide a link?

Regards,
Mikhail Kshevetskiy


>
> Best regards,
> Krzysztof

