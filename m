Return-Path: <linux-spi+bounces-9076-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1955AAFDFED
	for <lists+linux-spi@lfdr.de>; Wed,  9 Jul 2025 08:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56D16583644
	for <lists+linux-spi@lfdr.de>; Wed,  9 Jul 2025 06:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE61176ADB;
	Wed,  9 Jul 2025 06:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="xXMfTJSc"
X-Original-To: linux-spi@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023138.outbound.protection.outlook.com [40.107.44.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082351AAC9;
	Wed,  9 Jul 2025 06:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752042560; cv=fail; b=ihKAu8IdTD1mo2dgFIlYdhp4YgzaTjs3n0MMcg7S4ff7Qe8WqdXPZBQVQgW8lVNYHmQWgYF8w30qxDG/cGXOZwf28Yvg0vDIQ8QSzE81sQZUA35ZNxY0B82S1TDxflcmi4EB6g0hV+I/x8xMqUDbItv+/FRVyenZdIbgiZ0kfqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752042560; c=relaxed/simple;
	bh=1jP/YjNbiVT9Rh/cCjXi79yDVHWvI7jEsX/SkC5p6hU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Umr7FtzL4FZcwBRbPv9nm6Y3tvdso0alp6W4aDZYcUnk6Lkd/XndKe2Y5lc/mH4jbYdfmP8JCuREA+iDDBztautzidYYwNv3s4xxMEQlsVoUFDy4h9qB4NUo7KrYJx6bB8wRULRPU0YlosRcwrD6HV8f/ku8700vER/ItdicuMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=xXMfTJSc; arc=fail smtp.client-ip=40.107.44.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tx+HkLaUlhfRl2NZdesH60AW7WTKR6cEQBvWfEhFHIs7dar4RHzSPdbRsYWN/B9hN7OlytZ3utMrqgi7NUGfzrcblW1yI9jU0nSvurcLTmw/N0j3Lx/RlQ8ZBikaz5ZnN8b88bck5eD8Cvexz/Ne3ZNO2xuo/bbWJB/Aa8PoIp40aru1Gjr2sLqLBQxgSoT8hmFGFTZbm85dXmH++qeSd9DBgGbDG1lZdWJVfwWjszYi+i5m1ynEefX+TjSp0p6y0vUvpPcssRZa1zpV3f6x3DtgNOwIo58iS5F0yDZgr1QdAro/46cFl+V+mf2sm8dNLkRV+cvFwkaQjMtffva0lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=70Kjsow97SpSjFTUp9r/Mopjg+DY70dvJWkLSMrv16M=;
 b=NJbCngqKugvDsGve1qDCAtRrDNW/56kCgVSTTaZWO2tecZFQg0pPI0d81THdAq6oHGJnb8KmYThytezlSF+KNC8MeaVjUlbE2x+oAlJ7IPOXRu4AYHyPU9KesbiDEEpaSWUDYJwLH2Dwcf81MgvyHNTTZCzNFmb/zNTjQmJgSvgasgGzBbW1BcmbU9NiIUQnEX0E/yzcO7x59ZL/34EAZ47JpM7CoKenEfx23Bj6Qozg3u6UePxEW/RYMz4azibieSROqL8hRC1mjLKPfzj4e7Jcejg4U+qgDnv2+O3aLisIAINsRCzGFW8lxR/6fuIzSXSWXVq3YEO7vvjqB918lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=70Kjsow97SpSjFTUp9r/Mopjg+DY70dvJWkLSMrv16M=;
 b=xXMfTJScWImDT6rLD0SzWQzvJF5ZyYDu76EV1MljiZVWFEKezbGY9EaKgtxChjGBWpaFi1jjlWMUb+bhEHu5kAzvGGDgdU3bdk7s52W2c50+jI/Pancyk6GGbo4qMd6Di89XOJJl3T4QK4wcCf8qDy3AYXnJL5TD7zZG4j7mEU3StfYMFRnI4hyLd9qKOckhKs/iSLQSdWz7MfRIvTrv3toDiQJNEEmj8oWhZEOKYb0U1VtIQQaKEAVnKiMfhwRlmXHjng96PYi3tMnuZWi0ELxVxMRsjB/CU5z9fPw7vQdRci1YvePx4O83WbJ99TsnxgxayWT6RMXgs3LVEAbA2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by TYZPR03MB7203.apcprd03.prod.outlook.com (2603:1096:400:339::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Wed, 9 Jul
 2025 06:29:12 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123%2]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 06:29:11 +0000
Message-ID: <646ef30f-cadb-40ab-a0ad-c493fbdb9709@amlogic.com>
Date: Wed, 9 Jul 2025 14:29:07 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] spi: Add Amlogic SPISG driver
Content-Language: en-US
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Sunny Luo <sunny.luo@amlogic.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-amlogic@lists.infradead.org,
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250704-spisg-v4-0-6b731dfbe610@amlogic.com>
 <20250704-spisg-v4-2-6b731dfbe610@amlogic.com>
 <CAFBinCB4Lw04StL-kPpzKHPyETKfi5FYFipHRBDDnPdtRVDrmA@mail.gmail.com>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <CAFBinCB4Lw04StL-kPpzKHPyETKfi5FYFipHRBDDnPdtRVDrmA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:196::8) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|TYZPR03MB7203:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d689aa8-46b6-4c5f-b1b0-08ddbeb1eab2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WUw5VS92QTB3SzB1NkFBTExXVk5sTXRoQ0FhLzRvb2ZJWHdBdjhTMjUzbTlP?=
 =?utf-8?B?U3BVelBVV2g4VG1mTjNwQTRGYnFJMjh5ZXNsNE1ubXlSQnhxa012czFXSmpL?=
 =?utf-8?B?dnBiTWtyQkxhMTM3amlENkpTSHRCazROZ1V3RnRrZTBXaTJiRW51Y2JpM1VL?=
 =?utf-8?B?MEx1aDBiY0UrM3FQakY3ZlhvQzBqUkliNndWZmhVRzF4ek94eTJPd3F2MDVJ?=
 =?utf-8?B?MVY3aXpBOUdGMWJDRVNTQ2xBUWVBTk1jU1JqNUlOUWpVK243Ny80L1RrbTZE?=
 =?utf-8?B?akg1NUtFQWppY1BYT3Q1enNHcWRGeXdXZnl2NDJyNWtYcXFqSUlzZjhBT05o?=
 =?utf-8?B?dTB1V1JjNERZamlVaWNhUThSTjN0bzR2NjFyeGJibzluME9Wajc0bGIvOVlB?=
 =?utf-8?B?TUZhSGY2VGtmd0pEYjQvY3E4L2RYQkQybHRSY3JLZGVVTkpWMldhNkdTdnls?=
 =?utf-8?B?UTB0cVh6UmtJYit6UXhDSXljUkdpNnVJU0dKdjFEWDcvVG5uWnkxdlVJSFZh?=
 =?utf-8?B?NGY0cW90QlZLMkF5cEJadkhYbi9TRW5GYmRFWFBKUkNhZzdxUHhRMG5WQmJD?=
 =?utf-8?B?NjhLaVNadVF5TmplRDMwN3RxZUU3cE9VM0hpNUdtbWhsWGxVQjJtaWVXUUc1?=
 =?utf-8?B?cEp2NU9ZSUNRK2J3Mk5DN1pmQ3A3aVVmM2hDb29yc0xJa2paVmpFOWdrbEVY?=
 =?utf-8?B?cjh6Mmk2UlptWWwrMmVZTHFmVzJwU0VLaWJ5Y1NKN2l6dm9LVGRpUWZFZkVL?=
 =?utf-8?B?N1F1Ulhyc3ZhZTRuNHVERGhBY1g2amRQUnVibGVaMVAyNmtjME1DdWZ5NHkx?=
 =?utf-8?B?U0RNZkFCS2lxREp6cFlrVlk0VWUyQmZEMXRKbThzSGRNeGpDQkdiV3NqeGpT?=
 =?utf-8?B?Z2xZckg1Z2VKZkxlam5XVGNPRjF4QTVNTzFRY0duNUcvcW5hazZEUUcvVzd4?=
 =?utf-8?B?aHlhQmxYOEdXVGZTM0NUUWZReHRBa2FlV2dRSlN4OEtSbXVIYmtlZW56Vk0r?=
 =?utf-8?B?RDhVTURaT1pwNnJvRlJkTFRBSzhCQ0JNRFl1L0FEVGZYSGRESDhjOTNSNGhM?=
 =?utf-8?B?dVNXczlXbDkyZytldnhlb05VbVl4U0RMYm82ekptSkd6bXlQUlNOSmhEYkpp?=
 =?utf-8?B?NkZZTk8ydXRZNXBLU21NaEg2NUw3YTZPQTBVd0hKV1M4OERFL3Ewd2dXSnp3?=
 =?utf-8?B?M1NUa2ZJaWxyYm9aOGRPeXpKV0l1Vm8zbUk5bmlubDUzWk1hdUxpME9vdUdj?=
 =?utf-8?B?cmVNRzNMVkF0dWtYWkNGQ012YktxSDdCQzhEVGRTK2VHaEdqYk41QXVsK1Rx?=
 =?utf-8?B?dXFKREFKRTh3b2NrOVB3Uk9heGRQQi8ydEJpNjNaMHp4WnV6MUh2WlRBZFM5?=
 =?utf-8?B?L3VYKzJqRTk4dmEvYnJrZTVoSHAzY05IcGZUTlBUSkFLSldWam9xTm1PM1pq?=
 =?utf-8?B?eWdrN3hHTEd5ZkpJejRhcnhMV3ljd3QwMHZZTnhxTW5iYUhiVVo1NlYycVhZ?=
 =?utf-8?B?S2lIWTJVcFlaakJ6UDFKa2hGcGlKc1BqdjgvZG1aSWRadjJDY2l0WFVtTjc0?=
 =?utf-8?B?TnMwYlZUQ2F4T1NFV21LWStqTFkzbkN1ei9jaTN1bjRQWWxWNjlqUnF0QU1i?=
 =?utf-8?B?Y2N2QjZBeTBuQW02d1FJY3VpbHJWbGhNbHhnd0tCM3QyUEI4cEZzYzAwcWxp?=
 =?utf-8?B?dVZyS0kydkNZSmhpbU5DQlNmR2Vhbml2NHd2N3FlNWhaemZPRk9zeDZkWmVw?=
 =?utf-8?B?Q3JDSkwvTWRSSm5hSTBHdmRjaXFPSUdPdU01VFVJZzlLMzl1VmhVNGJuMzVs?=
 =?utf-8?B?MkJURmpvRGlsTFlMVFUvelpjZnBuQ1pUR3c0Uzdvc1VYeXdGZU9wYjEwNWxx?=
 =?utf-8?B?M0lsU0gzdExWUWE3V3N0TEdFaTI4Ujh6VGtwdzVPaDJQeFhsZytGWHVta0Ey?=
 =?utf-8?Q?LEc4QegZ8lA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V3AvcHJyR1N0SDFGdDRraFlnTkl6WWlHdzNqbDlDM2JlV0dsQTlPaWpYSkdR?=
 =?utf-8?B?Q040b1VwUGRXVnlPdGxVZHEyeFkzY05jaWlnd2F1VnFuR1Bva25rU0VpbHJG?=
 =?utf-8?B?d1UxdWgvOG04VnpvWm5ic3FoazV0ZEZlaGcvcGlqNjBLRjVPMStPZjBtazhK?=
 =?utf-8?B?YVlRWnZrSFFFd1JYTm1XakRCSDJqdmN3NllzdkdESUhEczQ2ckxnWkZYVDBp?=
 =?utf-8?B?Rm1mWGRtQ3pVTkVEc2FrY08vVjJUNldpcXR0djRRUG54SFgyRmxDYW54YkQ5?=
 =?utf-8?B?MjFsbWttOUxveDRVbmhvN3VmREI0NlprV1c4d0F0TENRNFJwTkVpdTYyVFZQ?=
 =?utf-8?B?WWFyUWY2R2t1dW5FQkQwbkZaYmx0U05aaHZ3NW5iN1dpQjNwMmJmUmZPdVpH?=
 =?utf-8?B?NFBQU25nck9FTCsyRzdqMmFwOFp6UWtuaWtpTldRMmlwS0dGd1gyclI1Nk9m?=
 =?utf-8?B?a1dhNEx6VEIwc2tRQWcyUXdOTzFoSUR0QXlSb2dGR08vckdnS2xFbkEyaUZ4?=
 =?utf-8?B?RENRaEgxeEpGTEN4dDFQUEYyV0JreXZWc2ZwdTVmYTNBY0srYVJyUEZIcjhS?=
 =?utf-8?B?UmczalNZZ3RLYm9CWVVoQ3pBU3FISHQ5MHlURUNuLzhhT2puMWhzelNrb0tT?=
 =?utf-8?B?MEZ0amhMZ2RiUXNiZjBJL1JnT2FLS3UwVzBkcTQ2UE5VaDF1REF2dHN1c3Jt?=
 =?utf-8?B?aVlkRGkzdGVqb29KUHUyWTN0dDI5VWZILys4OHVaU3R4TkhZMWZ2bVRreWJW?=
 =?utf-8?B?VUxqZE5nSmhwUE91NmpCSnUwOE1SOU9TZXRjTGRxSjRPMDcyOFhnREhlclhI?=
 =?utf-8?B?M1dvSHk3L25OY1Mzc21DU3JOTUZPSm5lVHVOQzFIQUNuU3JxZWhLVUxVWjhH?=
 =?utf-8?B?aDhRNGNPencwcFo0b0w2RHN0WkRLWmM1UURPZnJzL09zSWVmbE9XZzcrMzgv?=
 =?utf-8?B?K1ptNC9LNHJ2K01HNEVhK1U3SXZjSFUyTWRpK1hUM3FJbGJkSUpzWlFUZ0NH?=
 =?utf-8?B?UmVwdFByaVMwMUdWTFBUUzM0cnJ1OFZRd2JjYVF2dUpKa09nUVZaNWx5aHBE?=
 =?utf-8?B?NDBNSmRqV2FES0JXaktxU2RncklmUFgvZ3RPdFZ0S3ZiODNWWUJIOGpSR3Vu?=
 =?utf-8?B?ZkZKdlQvYWEyM1d0RGVISUNrSTVxOHc2eGV5OThoTGcvMjd1VFIzQjkxQm1a?=
 =?utf-8?B?d2pPbTlsWHhSNEFzaTFPUnVvVEtHSWtjWW9aVkhXWnFhb0NXUlIwcUdpZmZi?=
 =?utf-8?B?QTEzY3N2Y3ZESGVzUFBpZUFObXVQQzVKSkFwdHc5c3prZktKclNZQTVTZmc2?=
 =?utf-8?B?dldYck43VjhodmVkR1NTb2d1QlRkaEQyeW9oZzRzQnF1dm9aRmtON25vQW5H?=
 =?utf-8?B?K1B6UllJSjJGdWNkdHVZeExXcmMxTWNabkFKbDhsYWh2aWFrc1FwMmdYM0c3?=
 =?utf-8?B?elNNNDRScE1ldjg5clROQjF5NkM2YUIvZ1M3M2FSOUJDSlM3amlZQWNiTkRv?=
 =?utf-8?B?MkIySlI5blRDTnk4WUFtK214U04rQ2ZFcWpJRHcwWlpjZk1xbEVNalhJZHAr?=
 =?utf-8?B?Z1RQVEJ0YVpqcm1RZjRxcmVidzFEL1cyNUkzUVhZZjNUcXZveW5ycDgxRVRD?=
 =?utf-8?B?MysrZlMvUFl6ajZaSm53aXM5ZUt3MXM1RStleEF1dnBHZjZLRk9vNG9NRUJm?=
 =?utf-8?B?ZTZaMUNJZ2VadWpleFNvVFoxMks4WmJvaWNrZS8yaUN1dGxPbGNIODUrOVhm?=
 =?utf-8?B?NVdNZk1UYlM0b1VFZ1RNUWF6bmY1RUZXejc0VS9TR0pBK2t1bHY2bkIvU2po?=
 =?utf-8?B?bHg2TU9iYzlVL3I3SGx4RW9PZEd0Q3VRa3R5MSttT0pDSWxXSU9MYm00dWNR?=
 =?utf-8?B?cTJVYjR3bWhhNVJxRlIxc0xKK0hKd0NIM1JxNFJGVTJyY21ncER1VFFrWkd6?=
 =?utf-8?B?TWtXRk1IeFJIVGpJbStEWFdWQ2Y0MktUalVndFQzYzZpd245YVppZ25ydGVN?=
 =?utf-8?B?UnhPVHE5M1lIS3E4YjdNUFFsamFlZWdLZUtmR2NhVkkvb2JoNVBQQm8wS2oz?=
 =?utf-8?B?MFhCQVhxdVJKZndJeS9rVFkrOC80VDN3Yy9ZelArbkZibVUzN29qTlQzNndu?=
 =?utf-8?B?ZXI3aDRSd2F0SzZyQkw3QkpwejQ0VjFPbjlHYTlhV1lvOFpKNklvWW94Q2hH?=
 =?utf-8?B?Wmc9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d689aa8-46b6-4c5f-b1b0-08ddbeb1eab2
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 06:29:11.5239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6o0yeus3wmspBX2PEuoX+4R+SsFHAsC2TQ1q+8FZZMO69UmzQs53QPaywi90G0MFYu55Bz1MS3lb9UYqFrYtM7sLBUVt2HhPVg66MYv0XmI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7203

Hi Martin,
    Thanks for your reply.

On 2025/7/9 00:01, Martin Blumenstingl wrote:
> [ EXTERNAL EMAIL ]
> 
> Hi,
> 
> On Fri, Jul 4, 2025 at 5:07 AM Xianwei Zhao via B4 Relay
> <devnull+xianwei.zhao.amlogic.com@kernel.org> wrote:
> [...]
>> +       div->table = tbl;
>> +
>> +       /* Register value should not be outside of the table */
>> +       regmap_update_bits(spisg->map, SPISG_REG_CFG_BUS, CFG_CLK_DIV,
>> +                          FIELD_PREP(CFG_CLK_DIV, SPISG_CLK_DIV_MIN - 1));
> Are you doing this to prevent errors for value zero?
> If so, is CLK_DIVIDER_MAX_AT_ZERO applicable instead (it has been
> discussed for the t7 clock controller recently: [0])?
> 

No, if add add flag CLK_DIVIDER_MAX_AT_ZERO, reg value will equals 
divider, see
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/clk/clk-divider.c?h=next-20250708
As follow in function _get_div.
         "if (flags & CLK_DIVIDER_MAX_AT_ZERO)
                 return val ? val : clk_div_mask(width) + 1;"

But here reg value adding one equals divider.

>> +       /* Register clk-divider */
>> +       parent_names[0] = __clk_get_name(spisg->pclk);
> Instead of using __clk_get_name my suggestion is to use struct
> clk_parent_data with .fw_name set.
> If you want to simplify the code further you can use helper macros
> like CLK_HW_INIT_FW_NAME

here I don't know parent fw_name, The system does not have a 
corresponding interface to obtain parent fw_name, only name (clk-core->name)

> 
>> +       snprintf(name, sizeof(name), "%s_div", dev_name(dev));
>> +       init.name = name;
>> +       init.ops = &clk_divider_ops;
>> +       init.flags = CLK_SET_RATE_PARENT;
>> +       init.parent_names = parent_names;
>> +       init.num_parents = 1;
>> +       div->hw.init = &init;
>> +
>> +       spisg->sclk = devm_clk_register(dev, &div->hw);
> My understanding is that devm_clk_register() is not recommended for new drivers.
> The replacement is to use devm_clk_hw_register() first, then
> devm_clk_hw_get_clk(). drivers/pwm/pwm-meson.c implements this in case
> you're looking for an example
> 

Will do.

> 
> [...]
>> +static int aml_spisg_probe(struct platform_device *pdev)
>> +{
>> +       struct spi_controller *ctlr;
>> +       struct spisg_device *spisg;
>> +       struct device *dev = &pdev->dev;
>> +       void __iomem *base;
>> +       int ret, irq;
>> +
>> +       const struct regmap_config aml_regmap_config = {
>> +               .reg_bits = 32,
>> +               .val_bits = 32,
>> +               .reg_stride = 4,
>> +               .max_register = SPISG_MAX_REG,
>> +       };
> Most regmap_configs in Amlogic drivers are static const.
> If you make it a static const then I suggest renaming the variable to
> aml_spisg_regmap_config for consistency.
> 

regmap_config as a local variable, it can save space.

> [...]
>> +       device_reset_optional(dev);
> I haven't checked the reset code but I think the return value still
> needs to be checked (drivers/mmc/host/meson-gx-mmc.c does so).
> Even though the reset is optional there's conditions where we must act
> for example on -EPROBE_DEFER (which must be propagated).
> 

The reset might not exist for this node, see relevant yaml file.

> 
> Best regards,
> Martin
> 
> 
> [0] https://lore.kernel.org/linux-amlogic/bd68352f-7f8c-4cbc-9f4f-f83645cc1f70@amlogic.com/

