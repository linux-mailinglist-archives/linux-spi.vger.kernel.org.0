Return-Path: <linux-spi+bounces-8439-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD19AD46A5
	for <lists+linux-spi@lfdr.de>; Wed, 11 Jun 2025 01:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71D533A710E
	for <lists+linux-spi@lfdr.de>; Tue, 10 Jun 2025 23:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44798260593;
	Tue, 10 Jun 2025 23:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="Ge5pIdCe"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3CA2D5401;
	Tue, 10 Jun 2025 23:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749597763; cv=fail; b=NQHx0iZpQrpG67h2uVZ0DHtXCx1rew62zalocR7epE857D/V14nQfw78VD6rXWLDadQ4oEMBVWFwAy7K9qJ/CVD9nRyI9ZXMMCLPz3qATkJI5CzKfNicbAS0SF8y9eZ9NaocFVVbw4AedSGbXtrn3QNfuVqb1kD+Ry1ZGrvDx9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749597763; c=relaxed/simple;
	bh=jjOuNNl68GJ4fBeYoSHFQpNOW4CAU3YOp5odG9u42Dk=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nn02NN0bp3oHGZhvXlyic8bOYoL0g/GcRCZ6oxHjTINzqDtXLLzBUOAjgkNDOGTSm+R0mqlvgdWWcT6Z10P+YhSI02Jr4Tsi/ufORNMzPRpz1doYovcl/Wm4hOvJDVHu9bru6gEpDIdKNa5VInLQCWJtu3vQc8NVPhEByUd1Khs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=Ge5pIdCe; arc=fail smtp.client-ip=40.107.243.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lUknGayWg12L+4pYSeofx0zJPGp0zLZGWW5L5OAcE354ErrBm3YguyURl5A4gJ5FTIB0zHiUApXjgHGkaPNxEtsru7BN2vuBT3UudvcNJ1SAVl0uHk6RbsvUtsyBrFgtxr4ZjHhgmp9nAAXX4//FGYd2cU1wi3dROq/8IkONb/z+ADdhsT715H9PVB+ELyZ8IEUj/YmUvGVngiKLGRdwidfJ9XGXUNkpMacfjgA9kPmYxKrVpG57mPJlrFcNnNm+tKaCWHOOFOUQ4tSf2jUA7iL6Khzy4Anry5Ynq6HrdkxuDq0cTStQ8gPacrweNOQGS33TeMHI3tgbPwCEOt/e1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=klvpqcwyXau2l+IgUgPFCotYArRphaJECVnPMDtTs2U=;
 b=FP8MzPGX9hEEMvr/oJ8Rshh/+fmzWZVGu8CmTVs/baOW1pQL2HwJv9m+oc7nt+MY3NlxLwfl+dyMXgLQsx0nunh/AZ+PxDJGJctM0u0fkPkjg43N6Nkm/OOPkWi+SozbfkAOcbVU5cFxz9AmcMBMF2xY3lBuY7uVZuHvZw1bdrZwsZfvYE2UsNUdEik44KSdYF4lpFNyIxMXVKrrgvfE8cJtmrD+H8SFs7BnZWp69aL5/MMlXRKjb3jWYp+gzKJX2XTH3odrJR0N7VnWZZ55QTbgpeQDImcEbGQI/lO51Wv5s2h9l/+GKg5YcvcM3q5Odtpj5RdWH8CZn4qHcM5nIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=klvpqcwyXau2l+IgUgPFCotYArRphaJECVnPMDtTs2U=;
 b=Ge5pIdCeo42OvniuHg8zz9UcRvyiFDjrFf0jqKWoKdxuaAvwqjoDeOTE+gwl4YCBVioifEtfgtZ/x/DNR7LI6FcUUqB+7MmNWAqkTh+zSdgcjwwcAX5jGRp2PY31GfT8EP0dWlbDK84vvEt7xhwJCuUISyGc95qGgiWQWExCR7RI9hQV18yB6rbM7im3kxYc6PDnbmnovn7s/3IBEc2jmJAB5FCmT90+mpEhd4qbeVaSSw/Zt8/YhMQMENHVSvnwbzW8Iyxcdc6SUAce1/2cW/johVaY+M40xl7i5X7atGDPIVkDAFNDHolHt4msu1bJOkPaoIo3hDqaS6SOOD/CKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB3461.namprd03.prod.outlook.com (2603:10b6:a02:b4::23)
 by SA2PR03MB5707.namprd03.prod.outlook.com (2603:10b6:806:11f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.40; Tue, 10 Jun
 2025 23:22:39 +0000
Received: from BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c]) by BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c%5]) with mapi id 15.20.8792.040; Tue, 10 Jun 2025
 23:22:39 +0000
Message-ID: <65124dfd-3f52-45b4-b514-222f47ec8baf@altera.com>
Date: Tue, 10 Jun 2025 16:22:37 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] spi: spi-cadence-quadspi: Fix pm runtime unbalance
To: khairul.anuar.romli@altera.com, Mark Brown <broonie@kernel.org>,
 "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 Khairul Anuar Romli <khairulanuar.romli@altera.com>
References: <cover.1749516352.git.khairul.anuar.romli@altera.com>
 <e1ecafc55f7fc1b2450f7c7ce0c11b9efa68844f.1749516352.git.khairul.anuar.romli@altera.com>
Content-Language: en-US
From: Matthew Gerlach <matthew.gerlach@altera.com>
In-Reply-To: <e1ecafc55f7fc1b2450f7c7ce0c11b9efa68844f.1749516352.git.khairul.anuar.romli@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0095.namprd03.prod.outlook.com
 (2603:10b6:a03:333::10) To BYAPR03MB3461.namprd03.prod.outlook.com
 (2603:10b6:a02:b4::23)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3461:EE_|SA2PR03MB5707:EE_
X-MS-Office365-Filtering-Correlation-Id: 43209245-a5d1-420f-4eaa-08dda875b0f7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L3dXV3pxUHJtS09CZ2ZLMUpSdWFPM2dWZTFTQVhST3lvUEVRUDdDdWZMZ3dm?=
 =?utf-8?B?UnFRUVdjQnMxWWQ5R0tKWmZEU0dwT0dkemR4TDVKeFkvdndGTDlGMGQyS3Bk?=
 =?utf-8?B?NTUxdFJXOVlMZUtXaVdnMm5BS09sOGthUHZTMEF1SEVBTkptT3l4TGhoYzhL?=
 =?utf-8?B?VVRBK1lUcUwraC9WTE0xaVN5VlQ3TThaWE05QysxczByUjVzUDREMEt6Z0Zk?=
 =?utf-8?B?blIrdnZOZnFwRWxZUXlMN0JZKzJINWU0YVJkdFV3TXl0cmMyL0I0SUFodDVa?=
 =?utf-8?B?czRvSGluaGMybTJjUlJPbExBLzdvZmVKc3NLOWc0K2R1ZnVmL0w0a0lhMGdH?=
 =?utf-8?B?UFlsd3BuWWFiWndtN0c3YmlCRzhVajJ5VUl1eU1YZVl1aVA2bXl5LzZRSHBm?=
 =?utf-8?B?MFRZaStHanIrRzJKS0lHeU4wdVh3RWpWMkhTbTY4V1pzZGUvYkxmZnJVN0lG?=
 =?utf-8?B?amxFSHJueFRpYVRmeWFuRzNIemg5dSttRy9JUml5WTEzREtDZzZDSitxMFp1?=
 =?utf-8?B?ODRONEdaWnV2Z2NxOHM4aXczNzZtVUlwMUlmYmlkYmVzc1lGR2R3NUVTQkVu?=
 =?utf-8?B?QUdyY1JXd2RKL2czTDBZVU8xQjJPYzh5L2s1NjlQZE4xbVhEeWlTZldWakk2?=
 =?utf-8?B?RGlXSldGcDRkejFKTTVWL2dHbE1veE1EK1dxbklTREpoMkxTUjBTVTFRSW02?=
 =?utf-8?B?ak9CSENaYW5jZk1Xd0NFY082UkFEUnBIRklKbkpCMnNxanZyVkY4bHhEZmpa?=
 =?utf-8?B?V1A3NDJZeUp1MHhad0t6MTg1eXVDWEJkN3hZUVY0ajVCOWgzZ0RjNk9iMGdJ?=
 =?utf-8?B?OFJzYWxNdWYvazY2TTlySHJKN2Y0UVdRc2pnbEg1bk90empsVnVvZ3FrM2Uz?=
 =?utf-8?B?VytoMDdwNGxVSWVxUU5pdWZMVnNyT1F3S1o4QmRFZDlYNE12VHl3VFZadDRH?=
 =?utf-8?B?MnFYZHZ4S1pGMjJ5cE1mNGpjQ3lHUlpoR2xwcHhrRGFPdGN6MDM2M1M3Uk9x?=
 =?utf-8?B?dytyRnBraFVpS0p5NWJuRi9GdjZqRFhSRDFWZ21DaGFRTXVYNlFYTzFhSnZJ?=
 =?utf-8?B?MEdEK0VnQTB5Snd5VSt2QTJ1THlQd2tESXNyYmduVkM5SmZNZVRZQ1NJVVR5?=
 =?utf-8?B?YVREY3FNdXdXTFZCdmcyVHRiOGZUbGFrMzY1aEVuSUIzMjhrdjZKNGtWcFpz?=
 =?utf-8?B?Z2lDVzlLdzZQVnRNeHd0RGFkM3FJM3RMeXNDaWo3Y1FYZUY3NGtVTUgvc08v?=
 =?utf-8?B?YUUzUk0yVEZlVlpyU3FuZkw0bmtVUmROMUFOSnhtcjV0SnExeFdicmtLazR4?=
 =?utf-8?B?RWx1NTBMcWJaUnFzV0R2WTM4ZWZyNU8xTDVoYjBrdjNPdzRlRHUvMEtNOWZw?=
 =?utf-8?B?QUttMit3a2VBTmFhTGlzQjV5VWxRaTRGZzUxbUhrTGhqUTBUQkw5S2dmRXFv?=
 =?utf-8?B?NmJLanE2TmNZY3AzalRGbEFmSlNOOUhBQ1NzNWMzejlUR0FuWjBZd25ZSzM4?=
 =?utf-8?B?aGVCaUd3MmhDV0g1VVBIclc1RHpKY09HaFhZSGlWa0M4bUpXa296dzg3cU9r?=
 =?utf-8?B?eUtXOEUxK05DOFp1UHRid2o1QjRnYXhmUGYzV3QwV01XbUl5K3F0NmJTazlz?=
 =?utf-8?B?MGVmMlJtRUo4MUVLTjZNMWZQRzVaYjlaYlJQT0FHdzMyK1hEeXIxZktMSE9N?=
 =?utf-8?B?aVhleDk3U1pIa2Fqb1VhN1IydTJoRllUZEM3WE1TREd4MG1BWFpUdlVmTE9t?=
 =?utf-8?B?dFkvZUFqdVJFTDdvSW9USVNEdEQyYVNVeXBvRFRsd2tzN1RBaXFLTDh6Vm16?=
 =?utf-8?B?YSt0dXozUWlWTTM5eEo3a1ArbitVUHVkSk51WDlUVWRWdnNvcFg2ZFpCaWYx?=
 =?utf-8?B?QVpLbjBJSVBGamYrYlA4LzVDejBNVENxSGlFNDQ2TTVLRzlNcHBITFJjZVVQ?=
 =?utf-8?Q?6l/d09mu2A8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3461.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UlQwVVhFU1oyY0h3clVZUENQeDlaWEFwN1BYd3BpYkRFUTIwNVhzdk9ZVkhV?=
 =?utf-8?B?UjRZaHVmY1Iza1JRNmd1TjllTUc0ZmFqMEQ4QlF2K2ZEa0ZSdkRTYVpmRXpp?=
 =?utf-8?B?NGNnQUM2aDNtZXhJdjJmeWdLSmk0WHkwbFNycGg1eUVBVW91TGYxL3dnRDdS?=
 =?utf-8?B?TmJwekJQUzBzN3luN0hXRDBPaXlHTk5HcHlDVFJJSE9NdnNORnV2STZpYkRD?=
 =?utf-8?B?LzQ0QmJIZXpPWmFUaTZKcTUrMmlyZ0RIVzNsM2tqK1FpWmFkek40cnVYVmFS?=
 =?utf-8?B?STdWbHAwZXV0SkkwVU40ZVp3ZVhBbFhZNGJjcVJ3ZjVmbFhQZEdoNHNLL1Ro?=
 =?utf-8?B?U1gwOFJDWTZZUEVlS3JqUHBUdThvWVdWa0l0VmNISWtaOUpUQm0xeHVZeG1r?=
 =?utf-8?B?VVd4QkxEVEsyNEtqR3AzMk5uTHc3dm5rd1RaVThYRlZYWkJQTzFvaFRqbHlQ?=
 =?utf-8?B?SElFL1U3SVRiRzJXcStwT0tFRzJHZ0hqaVdRcUo3WHBZdnV6RmdCOHh0TkFX?=
 =?utf-8?B?bWN4cTRIeXIrdFNLNzQrZHJaWkxQN3NCZjVjRFc0OEFETWQvV2ttVjU5bytB?=
 =?utf-8?B?T2pBNkdPaTVMaTk0MEZLdExpNVJBc3VtRHZjYUhTU2hPbTg2RHczNE9aWEhG?=
 =?utf-8?B?Qk85WnZvckhzMXBUM0plajYzTEYweFhldzBHUk1WbHNWR3JuR2MvWUtKcHN4?=
 =?utf-8?B?SDdhMHBWYkVSWjl2bVNmblRyMjl1Q3dPT2swQUgxcGd5N1hyWDEwSENYTXVY?=
 =?utf-8?B?M3VIdkJQY1c4N3hXR24vQnlxUE1mSnFTeFYxbUhWMWhnZXNuNWJBTUZJVlpK?=
 =?utf-8?B?dnpKTlNUMmNjQ1F1YUNzTThkb29BUHI0QU9jZkRVUWhJVVpVWlNGelF0bG1i?=
 =?utf-8?B?NVlXY09Rd25tTEgyK0dCRFpreHNBZC9UQjBKVkU4MTgza2dhbmFxcHZ2NzZs?=
 =?utf-8?B?WllOQXQ2eVdiejhFczNvL2NsYm1YVlk1Z3lYUmZyT2xaVEdNTXRkZ1dYa0dM?=
 =?utf-8?B?ZGdlRnJFYlhxY0RpV2pDMEE3eHNBbzRaS3JNM1hnWFN2K0RDeExTdS9FQ1Zp?=
 =?utf-8?B?MGNXMU1mNmRVcWdOaUsxbkt5QU1VelZRSlpyd2JHcGs4N0xCZHQvaVV0R3VM?=
 =?utf-8?B?bk5wSzZ1SHBkNFdPbWtiSVdCNWN0TU44Q2xKazZzYWxHYlV2dkljWm9OS0pC?=
 =?utf-8?B?SDJnWWE4ZE1LS1J4MndQRy80bGxqT0wvQ0ZHdFhlZnNhQVd6ZURIaUFOQ0tn?=
 =?utf-8?B?dnYxd3RBOUs2NTBUL1N0djlUZ3VmVzZ6cW8zODE2aDFYc3lqYXlCN2lIMWVp?=
 =?utf-8?B?MXdaYzNYUDNrV0FJZ2RRTmpCSXh6ZVlBTGVSYzRxbms0T0VpS29tR2lLVzFO?=
 =?utf-8?B?TjZYWDhMRUk3eDB1Wks3ZUpJV2xPcEFtOVl3VGVxMUs4elhhdlR3VEY5YXpP?=
 =?utf-8?B?K1pjN3UwOWhKbmVSRERTcXFFUHZYcFd5bUFSdXBHL2M2OXVuV1NNY3ZXWWJQ?=
 =?utf-8?B?eXZ2OFdwWkxoS1lJWHFFVHcvRWxxNnEvd2VvUE5WeG9jN05UcCtOTFFkSTJC?=
 =?utf-8?B?S3pYNjhyVlRqREgwK3BrTmlQN0lvOHArWkdDeWJhd2xrQVo1WWhheVlKVk9P?=
 =?utf-8?B?MWk3b3YraGdDUFRnNWFBOUdQdS9VREkrZnVlN2dwSTZPYlMzY1lFNnF5SW5u?=
 =?utf-8?B?b3p6Z0daNkdJa04wcnBHZmZxbmFDYkQ0aUZSb3Y5ZXdxeVB2Tng3VzBKRFdm?=
 =?utf-8?B?em9vc0hIaXlVdzl2YzMvQWZaTXN0ekhmZGZrcEk5WDZtbmNQZlZFNUxIcWJs?=
 =?utf-8?B?MDEwYjNQeHNDNnRkNEtkQWs4ME9KNVJCWlNIRTMrNHVjcnV1Q3c5dGJSZFM2?=
 =?utf-8?B?bXcxODQwTEFaWGZnenoxT0hoWFVKQUU3RUkvOFF4UGZUTHFXZ3NPT081bm1p?=
 =?utf-8?B?WjJxYUNMTGxoTHQ0eUtkSUkydmhyY3Q1WGx2L0laam9ZR3QzUW8xVE9GMDdI?=
 =?utf-8?B?SkJNNVNOaFJDZEhXNmZRT0h4eUNac1d3YVlkbkZBVXRHbkl4bTI5Wlp1bzZu?=
 =?utf-8?B?WTIrVm1ra3NYa1Jzam1ZekErejI1YVRCT0pDTjFva1FSWTZXcGNyNkVvUnNo?=
 =?utf-8?B?QW05dzNoamFkSlgvdk5vb3FDYzJORXlGNmwwYysxdUd0enNOKzRpVDF2QXBP?=
 =?utf-8?B?Snc9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43209245-a5d1-420f-4eaa-08dda875b0f7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3461.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 23:22:39.1823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kcMNDRgGKIVgGG7+y0R0CPVU7vL/AZFKu6+GGHGvsKcyu5+ED7koxRs46eKfPeXn447HkO4u1w0KLD8LNOhVJGrI4/29QCT2/872HYzR8qI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR03MB5707



On 6/10/25 3:30 PM, khairul.anuar.romli@altera.com wrote:
> From: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
>
> Having PM put sync in remove function is causing PM underflow during
> remove operation. This is caused by the function, runtime_pm_get_sync,
> not being called anywhere during the op. Ensure that calls to
> pm_runtime_enable()/pm_runtime_disable() and
> pm_runtime_get_sync()/pm_runtime_put_sync() match.
>
> echo 108d2000.spi > /sys/bus/platform/drivers/cadence-qspi/unbind
> [   49.644256] Deleting MTD partitions on "108d2000.spi.0":
> [   49.649575] Deleting u-boot MTD partition
> [   49.684087] Deleting root MTD partition
> [   49.724188] cadence-qspi 108d2000.spi: Runtime PM usage count underflow!
>
> Continuous bind/unbind will throw Unbalanced pm_runtime_enable error.
> Subsequent unbind will return No such device error while bind attempt
> will return Resource temporarily unavailable error.
>
> [   47.592434] cadence-qspi 108d2000.spi: Runtime PM usage count underflow!
> [   49.592233] cadence-qspi 108d2000.spi: detected FIFO depth (1024) different from config (128)
> [   53.232309] cadence-qspi 108d2000.spi: Runtime PM usage count underflow!
> [   55.828550] cadence-qspi 108d2000.spi: detected FIFO depth (1024) different from config (128)
> [   57.940627] cadence-qspi 108d2000.spi: Runtime PM usage count underflow!
> [   59.912490] cadence-qspi 108d2000.spi: detected FIFO depth (1024) different from config (128)
> [   61.876243] cadence-qspi 108d2000.spi: Runtime PM usage count underflow!
> [   61.883000] platform 108d2000.spi: Unbalanced pm_runtime_enable!
> [  532.012270] cadence-qspi 108d2000.spi: probe with driver cadence-qspi failed1
>
> Also change the clk_disable_unprepare() to clk_disable() as continuous
> bind and unbind will cause warning being thrown with inidication that
> the clock is already unprepared.
>
> Fixes: 4892b374c9b7 ("mtd: spi-nor: cadence-quadspi: Add runtime PM support")
> cc: stable@vger.kernel.org # 6.6+
> Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
> Reviewed-by: Matthew Gerlach <matthew.gerlach@altera.com>
> ---
Hi Khairul,
It helps the reviewers, if a revision list highlighting the changes 
between is provided under the ---.
Something like the following:

v2:
  - Description of first change since v1.
  - Description of second change since v1.

Matthew Gerlach
>   drivers/spi/spi-cadence-quadspi.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
> index c90462783b3f..506a139fbd2c 100644
> --- a/drivers/spi/spi-cadence-quadspi.c
> +++ b/drivers/spi/spi-cadence-quadspi.c
> @@ -1958,10 +1958,10 @@ static int cqspi_probe(struct platform_device *pdev)
>   			goto probe_setup_failed;
>   	}
>   
> -	ret = devm_pm_runtime_enable(dev);
> -	if (ret) {
> -		if (cqspi->rx_chan)
> -			dma_release_channel(cqspi->rx_chan);
> +	pm_runtime_enable(dev);
> +
> +	if (cqspi->rx_chan) {
> +		dma_release_channel(cqspi->rx_chan);
>   		goto probe_setup_failed;
>   	}
>   
> @@ -1981,6 +1981,7 @@ static int cqspi_probe(struct platform_device *pdev)
>   	return 0;
>   probe_setup_failed:
>   	cqspi_controller_enable(cqspi, 0);
> +	pm_runtime_disable(dev);
>   probe_reset_failed:
>   	if (cqspi->is_jh7110)
>   		cqspi_jh7110_disable_clk(pdev, cqspi);
> @@ -1999,7 +2000,8 @@ static void cqspi_remove(struct platform_device *pdev)
>   	if (cqspi->rx_chan)
>   		dma_release_channel(cqspi->rx_chan);
>   
> -	clk_disable_unprepare(cqspi->clk);
> +	if (pm_runtime_get_sync(&pdev->dev) >= 0)
> +		clk_disable(cqspi->clk);
>   
>   	if (cqspi->is_jh7110)
>   		cqspi_jh7110_disable_clk(pdev, cqspi);


