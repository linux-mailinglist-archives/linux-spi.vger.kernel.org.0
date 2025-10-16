Return-Path: <linux-spi+bounces-10706-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C36BCBE54E5
	for <lists+linux-spi@lfdr.de>; Thu, 16 Oct 2025 22:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 803A242823E
	for <lists+linux-spi@lfdr.de>; Thu, 16 Oct 2025 20:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59B91B0437;
	Thu, 16 Oct 2025 20:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="NKuLZU/V"
X-Original-To: linux-spi@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021087.outbound.protection.outlook.com [40.107.130.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F6D1A9F83;
	Thu, 16 Oct 2025 20:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760644875; cv=fail; b=XL/Jk86YyPoC61KCHpiHmFlTg+wFtRSOI1MfeP5Jzyolr398sKTchD5xPOiOMGjlyeLCcmIMnGK5gU9Z7ydARiMO1eyQJFdOOnLZp4ZaJw/zYmQi0sYisL8Y2pKqFOFjzMADabUGJHzQmhBOywtrqHrZGQ5VDzafDzhNBLZuOw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760644875; c=relaxed/simple;
	bh=bYE7fZjH2uQvhOZDNEwESqWVqoUWbldmwRWzrML/vyQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=r5KM+6cySaOKDHQAkQSc82TWDmbhCBt5ajHcT5i7YPkMN7cywJQUK/0SAHhFEiezznltWDAPo5zE5wTJSn56HziO+HeAhIFwhVRPKenfOmB3DlK1gm4TWPlWHVgMz2bR4+ZQZFQQ5rR+IcOB4PWx1Po3M+rehOfATqy+MzkJHbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=NKuLZU/V; arc=fail smtp.client-ip=40.107.130.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uht2/W3KLyzx90vanAbZCQuuwd/di9EU4RCOCecWz/dqH/6Al0w2yQvJUrVOUY4/aR98QBNyzBBEOt+USvUtlggi3Kx6deQU/9F5ihwWhqJA6Ml1zf5DEHS3zuwJSjQR7adMuwuAeBYc/JdTDvuNxaqxJSdhlnuJDb0u3/X0PgVkGIytsi5iob4NBmG9+KRlOjdmcpY4kXJ/ypwdrEEahixIpli11jSOO7nrYpbm7sjcqANkU2zvDoN7Lzl9We+DMrI1l63ygBnhZxcyn5IC1bakpykaMvU/TKK/qgrWTrzE7GSJmYBRSkbMyrmOUbIY5wPqllgW2/2KfhH3zZHmdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9kUJcAg20uC5MOTxtdKBQi7Kh2Lve9qPgVKBTJQUC0I=;
 b=sy7JoBH+tfYSk5CW7DspfErqQJwH+JUIgz4L01LpVT2kjyVWIx7vfjYX2ATiyO1KQrhjadugW1jw6UQ3yVOZUMOSovebhpZdxAEmpJHgWEyS5SKFxnEa2f+eoQt9FnB9pMULuvBHkDGlC/1UztK2UGKgwVgTpuEwv68Dr+QKv1jwSGQcShRCbesNw3chKvy4ES9j+LmkCgjvMLMbD4L3EA0+Xc2mU696zZBpg2Cu08st+EX+x1lEBD7m4AYSxARwg2CYBxFKipFTI3gBMfoyBu7t6YgLRqEdRZD1hKxAEGaTMsohe5bE/nKCorVHqq1gliztxx+mXxw8ebfYijbDzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9kUJcAg20uC5MOTxtdKBQi7Kh2Lve9qPgVKBTJQUC0I=;
 b=NKuLZU/VGoquFfZrlB6yNmf6a4GxvnCIJUTdwv2xK2NLWouy6mWW4pdhSFdYQ5mnMS+S9TAaKcWrvJkSt0v4Plhn0oBhbFa0S2dk+00Jsun6Ir0atNv2DFeBBqqAJy217uZDbDifRrQ6zbmMB4Mq5XN+gfietDbSLWum86DXuMLEiANckI3iR4RalWUL3bcF2WFVJ0q1/ujfx1IPqAJmGSkKHFmj6OoP6d1qAnjVDsHfNajdJrR5NzIq+UuvVY4CaChw7/ZYTifdAk/7Nht1WBw/MwU147C3HZ0j7ZVcfyzRlNs+eIO4VhzD2UkYC51N0sNGFh7YAL53y7h8/N/vcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAXPR08MB6510.eurprd08.prod.outlook.com (2603:10a6:102:158::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Thu, 16 Oct
 2025 20:01:09 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9228.012; Thu, 16 Oct 2025
 20:01:09 +0000
Message-ID: <6255f959-e37d-4582-88c0-f3808f9701a1@iopsys.eu>
Date: Thu, 16 Oct 2025 23:01:04 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [PATCH v10 00/16] spi: airoha: driver fixes &
 improvements
To: Mark Brown <broonie@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Ray Liu <ray.liu@airoha.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Andy Shevchenko <andy@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Cc: Andreas Gnau <andreas.gnau@iopsys.eu>
References: <20251012121707.2296160-1-mikhail.kshevetskiy@iopsys.eu>
 <176064054115.223781.11856902416382505599.b4-ty@kernel.org>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <176064054115.223781.11856902416382505599.b4-ty@kernel.org>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: ZR0P278CA0147.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::21) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAXPR08MB6510:EE_
X-MS-Office365-Filtering-Correlation-Id: f3f42d10-36ac-40a9-b541-08de0ceebf77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MTBlc0FySzZ0TGxzUE5Zc2JaemJvQzNCR3dTSjNzeXVSR0IwNUE2UkROZDVu?=
 =?utf-8?B?c2VQWFBvS082Zmw4WFFCNEZIY0gydlVWQjJ2dmFnUTJBTG00eFdmUy9qOVEw?=
 =?utf-8?B?ZCtWYTVUbVI2VURyQ2xBd1lCNTBNNE5lVGpSbFEyblVIbk9mVm1zelUrclE3?=
 =?utf-8?B?V05IYTlHWEFHRWRsQnV2YmQwTGlsZi9vUEFrREVrOXU5SzdLbU5MUzN6eW83?=
 =?utf-8?B?MVZkOXZuMFZ1b0hTWTM4RlhDdkE3NXRIV0FiNS9pZnRSV2c4RWt1YU0vQW1H?=
 =?utf-8?B?QWV1VUpWWkI5RmNLZkRqanhidFNRRnhSWmlTbkNJSkhzeTdzM0EwSWhJWjZq?=
 =?utf-8?B?eHhNenRaYmFDeC9IM2F4VzJaWlNVWjRIZk9qTHh2S2VjamhzU3JsSW9iRThO?=
 =?utf-8?B?Vldab3d2eUFta1p4MVFiS05OYzZNd1NwQ2Y5eEY5SHJKbjlTZUhwdlgreGNm?=
 =?utf-8?B?WFQ1b3k3cDNvUmtmalhNZXNnbUJ0QUdtMy9yMWFWaEUwSmdVS2JZc3VVdjls?=
 =?utf-8?B?VTlkSGJHb1hQbEc1Z0VYOTlFbW91ZTZNNlJBZkUzQWZ5bVYrRFdYYmllL2pw?=
 =?utf-8?B?NGNmWXRpZUx4REE0eVU0TVErUVE2djVaVWYyUDRoNzlFckdqc0dRaHVaOWdU?=
 =?utf-8?B?SzBYblhsbnVRSmJLTThZTUhuYURaR01Gb2l2d2JvUGRzSldQYUpLY1UwcWl0?=
 =?utf-8?B?V24yWWEweC9FY1hEL2h4THpkRzFJRUxhKzlBOWFreE9SUml2UTNaWDhhS0dF?=
 =?utf-8?B?OXpuY2w2aTRTQngwL3Q2ZVh2NkROM3FqSnpXTThnTlJmZ2orK1ArSS93bWRh?=
 =?utf-8?B?MGlxaDM1NVZCWThybXR6OTZKODVqL1dmUkVyOXkxS2JCZUlYZEpmMVozN1Zh?=
 =?utf-8?B?R01NVVltaTRJMWFoQWFGU0RvRG5ieWpyc0ZuMzJFRGJra3pyNkJHNnVYMGtz?=
 =?utf-8?B?djI5NUtJczJYRzNON3ZkZzhjSHdITGQrVHZrTXVwd0ZCZkZqd0pMSmVLSEls?=
 =?utf-8?B?alo1L1I3VlJZZkJTRVZ0enlQcStabDc0N1VKVFNmbE55L3pGZjNGSER4UzNT?=
 =?utf-8?B?L1NjR3BtU2U3eUVWYTdqOW5EcytnMmtDTzVCR1pvaUZTS3JENHRSQTF2alE1?=
 =?utf-8?B?UlRKMmtEM1BNT3E1ME8vbHExRVFEQXByTVF3NUFza0trbTkxN2pPTGxYRGZ5?=
 =?utf-8?B?bVAwM2NyaWNoRk9tcDB4SEZLanJ6T011cHlVTytGMzVDZnVzcjFRRlRmTjFu?=
 =?utf-8?B?SFhxMXd2UnQ3Wnk0anYrYTdEWEFMKzIvNEhqWEI0c0pwT0RUakx0SUIzOHA3?=
 =?utf-8?B?VFpvSmdLaVBYV0o0b1ZGZVlaOW9aY2YxMkpaYTZKa3lnbWZuQ3hRV3laV2Qw?=
 =?utf-8?B?ZGNMTVZaOWVUTmxuWmFlbnEzOTA5N3JYZ0VaNzZnczduNW4yRmFlK3c3R2tF?=
 =?utf-8?B?NCtBUGpnOFVMWkx2amo3bm9pOGdaeGhHZXhyeWlOSEtLK0FINnA5RjhhLzJU?=
 =?utf-8?B?OGN6d2YxZk5iKzRuK3ZlTmQ5UUZBaVFaVzlaa3Nqd25pUldEaXhHSmxWeHRm?=
 =?utf-8?B?WVhndFExU3hwakVkTnlTQnN0SXltU05MdHhmM213VTRsbHIvNWlPZW9Rdm1V?=
 =?utf-8?B?akRqaHY5elJEQkw4Yy82YlZIaHc4QmlSRVkxYzJKeDlqU3ZVckVyNElRMS9U?=
 =?utf-8?B?RzNHNnYxYnRRY1hEeW5kTWdMY1pXSGFld21oQjBwZjhiaHJWTFJ5YW1FdlBO?=
 =?utf-8?B?OTFHRWVOVDM3MENQUXdPMmVweDBYd0VpSFlROVUxYnA4Y1VlSk1UNjhDRVBD?=
 =?utf-8?B?SjUyMlNMSlpMNis3L3kvdkl0M2NmbGV0MzNLK2EzbEdrcmIveDQwcGVrZXdT?=
 =?utf-8?B?VnRmeGlsSml2elZhcjhGdzRkNmxsZGFuR0lVbnRnMEhJUmtoSHkvTWhPa0hS?=
 =?utf-8?B?WkwvS1VKL1hKNk12QU8rWCtHVS9zNm9KMEZGWnVmaVpsZFhrSno3cUNMSnNn?=
 =?utf-8?B?c25IYkVyU3IyaTl5SHJRV2MxRWJURUs5UEF3T2EvbWV1TDVQelJDT1puVU53?=
 =?utf-8?Q?iwa/+l?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d2NwZ3pWRllSV2VnVTludnNKajVZUHhkM29yYm92aGFHbDVIMDByVTBiYVY3?=
 =?utf-8?B?SklNYUUyT2Z3THduQUpBRE1oOTFnMkZ0UHcvUHhEY0lvSitMTWdHWW9hcnZu?=
 =?utf-8?B?UHA5QnhxMjlyNU5EakRudlY1MEFEQy90UHJucUFvVFFaQ3JrdU1qMUp0MS91?=
 =?utf-8?B?WnROeVhjb2hsMHdTcUdMeFpHZzlydThQNzRKKzBjd3FJc0krVXJlYnJTUkZX?=
 =?utf-8?B?ajJZckZUb3VFbWVkUzZEb2UzZnhDeDBFWHZuUjZ4S21aRW9GUkhWekowYjdO?=
 =?utf-8?B?NUhyOTFmK0JuQlZZNjVDSjl0VTN4MXhhVzBiODNock1vT0s5RDhTWkdXK1lR?=
 =?utf-8?B?UnVjWStlUjV4SDhtK2FQU0VzYklNZSt5cGh3VGZiWFY4M1ErZTdpR0V5ZmpG?=
 =?utf-8?B?U2hoRXpXcndIZUhMWndaTmdwOXhVbkV1RmxEVjhjQ281N1gwS2tZQ2hTWVFM?=
 =?utf-8?B?OTQ3TndvdndTRWFoU1dxaStKK0szb3FmaHl1cDZncW9pa3YyakhNWjJKWXpR?=
 =?utf-8?B?QkdPczBIUXoweTBRQXNjWGhoR0xCdEJjZkYwbnJINW9FcEZteEJwWE5VSzlK?=
 =?utf-8?B?YXRVMkgxWS81di9QMXd5SjIvN05iTjN5THF4VWM1cFhudFJsOXdMUitYRDla?=
 =?utf-8?B?dmh4alN3RGVMSVFWV2F1SHhGVzFqUGp4eWxhRTNOQnRQWkNubTRuMVFDcVR4?=
 =?utf-8?B?Sk1teEd4TU5uN0djMjdQcWQ4MkpRV0JjdVNOZGZzR0txcHpoTWJldVpKM3Fx?=
 =?utf-8?B?bW0zTjMybzB2UG5BY0oxMzZ4STlNMUVQbjNySFhFbmUrMDBPb3p5ajVhdjBD?=
 =?utf-8?B?MHpKalllWjBnODZlWEI2MzdhNDVWRmo0YW1WdzUzV0k0UVdNUG12M3RKc29M?=
 =?utf-8?B?UTA3aGpwTU5YdVEyNWRtNno4OUoxd3VwS2NRd2ZrUm11WkZ6N2VCcjArenZq?=
 =?utf-8?B?WnJ4VUhNWkdkRnk4SFQ2N0JORy84V01sQy9ITDVGbXJlT00rZmJodEtWWWZV?=
 =?utf-8?B?L0UvVHBabUdrN2NybXdWS0QrYVI0aUdtM2FBdFRlOXhUeXNwTnk4WU5GdzBC?=
 =?utf-8?B?RWdyaUJrUmNDUHlKYU5pdmpDdXE3N09KUXZoU3luUEdJMktvdzNlbGFORHFU?=
 =?utf-8?B?MHUyYzQ3K2NDZUhtT1d6cHpCaVFPeUlJWlZTdXJ4TGVjYklTVVhoQkJzV2ox?=
 =?utf-8?B?ZERrcjRwbVFsaitpWTgyaTdwN01QZE1pNUJhTFNqQUZDdUxtWTZtdENnWm1h?=
 =?utf-8?B?UDdxOUFVeEdwbnArMEVjOXA4c04wUGdGMHRlWHVkT1NHckhVS2ZLYnNWOEtC?=
 =?utf-8?B?bUQ0YnhQOUdiOENkNUNhRXFuWmFTOG5Ja1cwc2RWOHk2NE5CZ3ZIcVlYR3JE?=
 =?utf-8?B?bW9XUmhueE5hcVdTb2tNRFJDSUFibC9MRGdra0E2UWMzK3ZmSTlTSFRXbE80?=
 =?utf-8?B?ZkVJYy9CeTJIVit2VWl1NWlORW4yMlcvdnZWL0p0UG5kWWZBYVNLeHY3ZVFI?=
 =?utf-8?B?R1JyTnEydTB1amVQd2FPQWxwY0NtRFRXVm5JdnZKZFhJcEtWaHh3RGV6aDRm?=
 =?utf-8?B?SDBka2xRbW9xZ2dnMDNrRUdOTU8vb0V3YjNPQ1diTVhudGJwdEtuNmtLb201?=
 =?utf-8?B?VnNhVjN5aWVUTmZmdHFnUG5xNUZNWnNSY2lsWmNlNkZQZ21EY09zZXp6bUJl?=
 =?utf-8?B?cktQUnRHajg2bjl4RVcrR2dSNS9MYlBORlJkWUNHQlZiSXVqOGk2WHZ1UzBF?=
 =?utf-8?B?L3lwZXptTlVJSWZSU0NGOGl3NHROakZaVkZJNzRWVXZyd3R0MS9TZnpWT3Qv?=
 =?utf-8?B?ekxMTUIvNTcxb0VoMm1IUExhbkk0U3JzN0VFcTNUT0ord09BcnYyaUVRUklE?=
 =?utf-8?B?K0R5TDdMMGw4ZVR3c1Y5dFA2QkxybXI5VFFmdlJKbTUyR0JzSW5MR2hCNitB?=
 =?utf-8?B?ZGl1TmVRZnV2OHREYzljRklCcWZ6dWFRWE1Za0dMQU5hUXE2a0tPYUs0MFhY?=
 =?utf-8?B?ZEE1MnV6dm16OEJnb0tEc1VWeG9rSlYwQ2x2WEhIeWJOMysvS1NVU1N1czJJ?=
 =?utf-8?B?YWVzdlhDeFArQ2lTWnRiTVpIQU5NNG90NXJiSkZRRWR0YWFDUVZoSXdQZThB?=
 =?utf-8?B?cytISU1KMDZ5Y3o2K0JIRjQ4N05GZUxteXZQNkd3SnpMWm9yVkd3eHcrWm9p?=
 =?utf-8?Q?7fT4cQMwqU6vKsX57fAK67s=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: f3f42d10-36ac-40a9-b541-08de0ceebf77
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 20:01:08.9641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X7/VTmOzvhfS8mofuusdL5VleX3V4s6/HAI+s/lzyho3M0kPJd7bXRpiDS7a2u+WyTPJwvnApyGGb4Rhrl+ftNYjApEUfTJtIhJK385IgP4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6510


On 10/16/25 21:49, Mark Brown wrote:
> On Sun, 12 Oct 2025 15:16:51 +0300, Mikhail Kshevetskiy wrote:
>> This patch series greatly improve airoha snfi driver and fix a
>> number of serious bugs.
>>
>> Fixed bugs:
>>  * Fix reading/writing of flashes with more than one plane per lun
>>  * Fill the buffer with 0xff before writing
>>  * Fix reading of flashes supporting continuous reading mode
>>  * Fix error paths
>>
>> [...]
> Applied to
>
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
>
> Thanks!
>
> [01/16] spi: airoha: return an error for continuous mode dirmap creation cases
>         commit: 4314ffce4eb81a6c18700af1b6e29b6e0c6b9e37
> [03/16] spi: airoha: add support of dual/quad wires spi modes to exec_op() handler
>         commit: edd2e261b1babb92213089b5feadca12e3459322
> [05/16] spi: airoha: switch back to non-dma mode in the case of error
>         commit: 20d7b236b78c7ec685a22db5689b9c829975e0c3
> [06/16] spi: airoha: fix reading/writing of flashes with more than one plane per lun
>         commit: 0b7d9b25e4bc2e478c9d06281a65f930769fca09
>
> All being well this means that it will be integrated into the linux-next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.
>
> You may get further e-mails resulting from automated or manual testing
> and review of the tree, please engage with people reporting problems and
> send followup patches addressing any issues that are reported if needed.
>
> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.
>
> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.
>
> Thanks,
> Mark
>
If I do fixes or change a bit description of patches not applied to
linux-next yet, should I post a whole series or it's enough to send
patches based on linux-next?

Regards,
Mikhail Kshevetskiy

