Return-Path: <linux-spi+bounces-10015-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8814B56E50
	for <lists+linux-spi@lfdr.de>; Mon, 15 Sep 2025 04:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C23A178572
	for <lists+linux-spi@lfdr.de>; Mon, 15 Sep 2025 02:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FCE1EA7CB;
	Mon, 15 Sep 2025 02:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="dbBZ+37z"
X-Original-To: linux-spi@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023115.outbound.protection.outlook.com [40.107.44.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87951C27;
	Mon, 15 Sep 2025 02:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757903385; cv=fail; b=NNFj74pQAvmA8KLJfdmCuVJqlVg6YmF8gWh2tZMdPOWPaUZqBkq9Yl1UKPCROuNu5ie8hWdlTmanfDvZpqUb6Dl2fq4wl/L9qkXgZsXYphveNQgjJeTHtzcv+SRv2ji4HkiCzvQL5ALydvCwQHDYHoYoVeFLAjvFnGsVMjN/gPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757903385; c=relaxed/simple;
	bh=mzqDRX8TZzPaGabifLY6WikitDoNZWRG2FMTfNibIKA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lbMMBEe2N1qSEg8RajGvO+h12mHpUK/uSciddp0G1hENOdhuc5HZYpGrwqIyWWeeNpJ6KPhU8APie0ieq+j3NyDTq9zBIqGCl7BUUCpnk+6Tf/h4On2E/guh6neqP+1QIlpHA1V8HZRtZTdrPpNDto//6Ul1hBAdsigcWivGiek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=dbBZ+37z; arc=fail smtp.client-ip=40.107.44.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cVacN0hFoxMxNMk20CVJZ7i1WriI6djZokzUbr7nbK/+UMnyYQb5LG1BtjiIRtEzzp2fyvBM2CUUbXRS4eDdUP1GyGt5dDVNPIRJzez/oIKD07XQLDHEz56M5kdbkMbxRYJMwKJqAEdsXMHFfCjIYd8rP6pTors9MVuSllIEH7K+XUsCA5MLwfAJb84Wct0E8LYgm9OjI9eKWE7H5giTn7I9xRDZFDvCADx7k5bafGLn2WzgEwdLvw3dvBa35OkxHU6mUXYUoXtgOQn4ohrSRP3cQFTnNpPXCZF3unwD7oliumm6vHAzWK3OZk/8pbS9D4JvAonex3KNa/xxhmcQXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SYBcZPfEZJNVTVyJkJq3/3hMpmfIuwXNScAL/r1Ch5A=;
 b=gLIkFqQ+0ZLgQOD/E7U70r/DpZRA8Kt3gHYvAaQU5kES9yYbsNeO1Ps3dKOzh/68LQoO5DT6rgw0arz8q6NDXQOoBjggpxrlavNQKZelmnBipZCrZkElsc5evWCZNDCoD7P61Oc49M7w9ZhvgMhmd2l+qTiNH9pBGDQasJoLoQ+vvzzw5rupSf33o6vGLnp4Xbhu8914GPfQQYh8mwImhFK2BigET0+9BSnW2QoGNOlTeImUpPFl+4aLU+4Pfp2XEOfDHqwEi6KBCNxCgBNkPdX6GRAOMM5OPTxFaEQZdb7OXbaqljrafbqm5RZ8TEx1RhPESsWDTKn3aDtgkQB9ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SYBcZPfEZJNVTVyJkJq3/3hMpmfIuwXNScAL/r1Ch5A=;
 b=dbBZ+37zmzQFblcsamODzNXZHTeYqGdptKRkVKMm13V3gv2unc0r3UiT7vA+4Nvqts1Amu6W7YBrOjV1NYQ6dpR+13BrSbmFu06ENVfkSENMLCtgeOBbtJ5PSbvVVBEqLa1Xq3JpxzdchJsBkzZON99kN2LJZBDaTdhSuHtfiwEhjQ3JG1vsqtHebmMqNEdPgWrg2de9RPqopX1XXf3k/JhHbk/LPdzEw1wV1wRLGFxz+qbG4O1/BM1i2aonp+Xr469pXIvKOmenmjHcRBzuGlB32aWUG9rsKci7/G2Gn42YpJyEONuEyQkUNaDst/Jy7S5gT/1L9R6CBOALp5onvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by TYUPR03MB7206.apcprd03.prod.outlook.com (2603:1096:400:347::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Mon, 15 Sep
 2025 02:29:39 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123%4]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 02:29:39 +0000
Message-ID: <93a8e900-cca3-43d9-8f5b-c8431e20cec6@amlogic.com>
Date: Mon, 15 Sep 2025 10:29:35 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: amlogic: Fix error checking on regmap_write call
Content-Language: en-US
To: Colin Ian King <colin.i.king@gmail.com>,
 Liang Yang <liang.yang@amlogic.com>, Feng Chen <feng.chen@amlogic.com>,
 Mark Brown <broonie@kernel.org>, linux-amlogic@lists.infradead.org,
 linux-spi@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250913201558.1338180-1-colin.i.king@gmail.com>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <20250913201558.1338180-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0206.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:385::14) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|TYUPR03MB7206:EE_
X-MS-Office365-Filtering-Correlation-Id: 08b5d18c-8e1f-431a-a70e-08ddf3ffb857
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ME1JS2I2emYrTWdnTFgyb3JsS29xOVZxNjNjVE5leVMzczFZeHlKcmZLdVV1?=
 =?utf-8?B?SGFVOUd2aXNQcC9qRlhzTnZpU2ZEaTJPd2FraDB2S2k3U1lyVmw4RnZhZENx?=
 =?utf-8?B?d0NtWXdZTUZVWHRlU1N0YTBKa0pZRm1JU1Z4bU1wUUVaWlVEcnJNeUlXSnF0?=
 =?utf-8?B?NmExUVpDOEtUMVNJUUR1bklRZ3lhdEhXR0V1eERxMmU2YzZlREF0bUxXbE9u?=
 =?utf-8?B?MzB2anltb0pZT1l1VEhhQkFMQ1p6NEVwdEg3VlluU2I2Mm1yS0VnUTZTTmp4?=
 =?utf-8?B?MEw1QXZ1RW5iRmQvRFJ3QnYrMy9MVlF2MG9yc0hpKzgraDdWM2tLTHVpMnZI?=
 =?utf-8?B?ZnFJUHZBd2lIbTdtUXp0ajI0dzVaSVFVcFgxWnY1Z3dFbzdjbmJXTExzZ3V1?=
 =?utf-8?B?VFhmNDk5WlRJcnc5a3o5VitmeUtXeDVrSVY0RUdhdWZCOXpoRDI0VWEvS1R2?=
 =?utf-8?B?TDNFdHNQc2ZFRHZNYi9ScWdkaUVURmd6bDduWUk3bkpmbTBpM3RJZzJnRXcz?=
 =?utf-8?B?NEdEay9ZeEQ2V1BzN05rNVZvckFWSjMxZ1FkR0c3NUxaUThITzBSN0NCN25w?=
 =?utf-8?B?UXQwRUw1ZU8yeUVTWlVTVUt2c0k5TzYwMjFLV0QvWFM0QzZBSmVjZzM0TzJs?=
 =?utf-8?B?ZFdjZ0gwTFZ5RFJEN015OVAwSlRsSVJpZ2NiYmVkL1R5YU5ZSVFIeExYWlVJ?=
 =?utf-8?B?VWpFYlpRbzRUUFdTNk5tdTk3cjUvZUZ1dVBWQlIzeEF5OXBJMGoxcDF2NmV1?=
 =?utf-8?B?dUZ1NGlRQ0plVnhBQmt6MDVrRDRZKzZPMVovZUk5TkVWVGV2NWh3cks3Z21O?=
 =?utf-8?B?Tkk4bC9mTzdwcStkWWpuVi9SS1hKV0FITTBuWWt1WmNMQ2hMK2pYdXNuUDhy?=
 =?utf-8?B?dHlZamlXKytZUWQ3ZFRaMUhNMUI3cnZGNVdQZ3pUcVF3NEdCNThjL1dmSllG?=
 =?utf-8?B?aEdCZjBDSkYwNVV3ZXk3aTMrS2w1c2pwWThDekhRR0hOSEdHRVNlS051VlVx?=
 =?utf-8?B?eEhLcFRBVGNzZ0g1b1orYXNBY2ZZVDE4S01JL2krYjhDUkxNWUg2bzE4YzlL?=
 =?utf-8?B?VVZTMmNrSlZuUjJjU2d4MCt3YkFSUysrLytOa1dsYTBoUVZUODA4Sml4eXh4?=
 =?utf-8?B?OUphRjZaRE9FSHRkay92d0FsSXAwUW5CNUlqZG5ySTRJM1FtVmlVSGVkQjJp?=
 =?utf-8?B?cTlMZk5aRmJUWjRXeWQ1cStVc3ZzT0JoemFsdFlQQ1lXWU4xemZqSTNIdXZP?=
 =?utf-8?B?ZGZFNXV3VUtvL3gyaTI2WW93ZFhXRzdsTXoyL1ZjQW5QTXhjaHAwUjZSUGxj?=
 =?utf-8?B?Y0JZeW01RURMUkF0Tkk3d3BrQ2J3aEtHRUlhd0pka3BxaDc3dHZtWjdJeC9q?=
 =?utf-8?B?UXYrQ053NmVldFFUWmFvSHh3dkZyZDlnK1U4OEl6SkdFQmQ4ZkFsUVc0dEN2?=
 =?utf-8?B?ajZ4cHV6WFRXSjA0MWkzMzY3eUZtYWF4MTRPOXR6emV1Qm84V0RwQmoyU0FQ?=
 =?utf-8?B?L0hab0xhUERDczFQZ3h5cDc4cDFKRXVqQU5OcSt1TS9XazRkMi80cG0xVCtz?=
 =?utf-8?B?dDl6d2VTajZuSnpNdnk5Q29LdWpHK1QyMWFVL3JjMTF0MjdPZTd1UXhNV2VE?=
 =?utf-8?B?OEFBbWlPVjdXN1JKemJDWDZDVVRIUXp5UWhRNzM3NjZSOC9rZUMrNEttS2wr?=
 =?utf-8?B?TmNWMEQrbWhzbWNnVnlYQVdlT251WktGWFZvMVF2V2VZZkUyUGsvL292T2sz?=
 =?utf-8?B?UW1mNEN5U3ZPc2pWM1M4bWwva1BWTEM0THdNOXpaQ0RJOVc0dFBUQXJaWldt?=
 =?utf-8?B?M2l6N3dGSUdDQkdRdm5RTzEvY1FJU2NQRWFoUmhiaE9wYW5ja1ZrZG1Ka08r?=
 =?utf-8?B?MmxOVlVtMk9Vb1RvV3BjVzNncGFJYWdoMHBPTzRkTFBwQmdaVEJSZFJOQVBs?=
 =?utf-8?Q?CH723pK+29E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NGRDbTVVQTh1bGlIdTY0cnY2UDMrdnljUnA0Y0ttMzBFcTNRZEZoSmczU1BW?=
 =?utf-8?B?UnRiM1dJUzFBL05NeTdVU3p0a0JUNHFnM3llN0pUSFJZVVV3TDRKdGJBRkVj?=
 =?utf-8?B?eS85enI5N1g4SU9xM1R2OHltUHc2SVM1S052VDc4VWdQMXAzZm1uOWd4ZkdI?=
 =?utf-8?B?ZHVmUGJZOVQ0NGpDSVhPcjNyeVdSWTdMYXdBalIxeHcrd2MzazFzS1Y2YXdS?=
 =?utf-8?B?c3RkRnJYcEVMTDVqdkRDTERxVGMzS01CLzNyWDAwdkU2bjN6bEIxeFh4cW01?=
 =?utf-8?B?T3M3N3RzR1A5aUtlYWh0dEg5MDdTMm9yN2pPQzMrdTNXa3FFelhZK3pQUVBv?=
 =?utf-8?B?U29rbUJFVnllRGZRc1FwaXpVTEsyY3dLQzNVVVpkc1JITlFQek1SVUlMMjhl?=
 =?utf-8?B?Y0l3cHVTWG5BQlFxdHdrV3FBQ1hPWlQxaXU4VTZhOUM2THN5S1lRQzcxZStG?=
 =?utf-8?B?b3ZNTm9zY1RLVTNSSDQ5cnN5Y3h3TmJNT1ZQS2hDY2U0RVFPR1ppZXJ0bWdh?=
 =?utf-8?B?WjhzZnZuVGdPemZCdUxyR09WaVk3bUJyWEprZUNiaHY3QzFueXorL2FaVTlE?=
 =?utf-8?B?QzVmZlJoRUJ0RkhJTlJmZTlZMjBubUZnaGRYdFVSTU95ZFMxblBGN0NwdFVk?=
 =?utf-8?B?YTQyaXVsNGJCUUdwdE4xUVIrOTFTd3NHMnhIU21FMStSd1ZlT3A4cjRTOWZS?=
 =?utf-8?B?L3BaTWhWV0J5N1lhcktLU0tNYVJWNGZJSlJHZUUzSktNRkVLWUY4ekpJV0Rv?=
 =?utf-8?B?dm9JQStlUjJWcDExSEcwbDAwaVQrOVdMU3Q0ak1TdkRqeFduajZnNy9BOHNH?=
 =?utf-8?B?VjJlbUE0YzBHS2RxMlRFclQxZ1c2ZGtpKzc5Z2hNdG1QNFNueUVmdytLZ0Uw?=
 =?utf-8?B?dXNkYTlCSDhYYkFwU0ZwRm9HSWI5SU1oZVM2TVBrVWMrRWREWUdoaEtkZTYv?=
 =?utf-8?B?RUs5c3hGRGJEYlAycmQ1MXYrZ3ljcmNkVkR4bk1sZmxFVU5XY09TWTlnUzJY?=
 =?utf-8?B?VEg2NjNhblF0cFV6QXBOeGtEKzczV1J4RVVoY3poaEhSazJDRlp5MW5aVzIy?=
 =?utf-8?B?ampBeW1lYTg5a094eStMMkNtREhoTkwrNk02UWlDbEE1bEdrczJCUVpHUklh?=
 =?utf-8?B?eGJ6MjBzTW9hRE5Ld2JPMUg3dEtGNDJHRmFSaDN3dUlqQnlWWUhVZVpUQ3F0?=
 =?utf-8?B?L0N4Z2YzTndvWjh6ZG5JRUVZa1hzNXhaak1mbW0wdTZrWG1yTFZtUVhyTDh6?=
 =?utf-8?B?Y2FsM01lQlVhcE5lUHhURXdFRkcweUwyS01ieEhXeW1xTS9mVS9YbnFYUS9k?=
 =?utf-8?B?LzZLTjJPM3VpeXpJbXZGZU03Ym1jdGtDOXlUb095aFVvd3NMcXZieUNTSUd1?=
 =?utf-8?B?RlZjNWZYcFNhdWxvdURBcHl3V0dDaWVET1JKUmtkYkYzVXhlamF0Z3ZFMFJv?=
 =?utf-8?B?cWozUEZ1YTlrazlseVJDRWpBVWl1cHQ1SWlCUFNQV090K05HbytxSk10MDNU?=
 =?utf-8?B?TnJSZGplUWlDNTEyNTZ1cG9Xd29CT3BER01OcWl6b0pCdTIrT2N4NmZpbUYy?=
 =?utf-8?B?S3grS2YvNjNraEZ5N0ovL3AzaXJsdWh6a3JmTGVkb0dwZWIwb3BSOTJvMU5m?=
 =?utf-8?B?TTZiY0hHakE0UHRkSTRnZUhDdlc4SGJTS0FXYWo1U2lSNklRcy8yVFF4YUZ2?=
 =?utf-8?B?V0RiV1cvT245UEpQYUxQUEJORUV5YXM4THo1T0hkM3FqNUNDVUFEeDZaeUxt?=
 =?utf-8?B?cjdNWFdhZ3I1dnJ3TnFDQWp2ZFNWMVd1RTgzRWZDbDRqOVhUa24yZEFPeC9B?=
 =?utf-8?B?MGFobjRSUnFLbEFFSlkzNVNnVHVrbW5iemVUWEg2Z3ZLczJGazI4d0FWMmt1?=
 =?utf-8?B?akxwNUlsQ0pGWFYxa1dmQ3FJb2ljMVF4eTA3T1dFK04rZVd5T0JzMzBod05D?=
 =?utf-8?B?L3VjUHpTbE0xYVBvZlZIeXZ1QXZCbGpZU1dlSDdRVFlJQVR4RjBBbGZSME0w?=
 =?utf-8?B?QVFpWS83UTZNY0taT1ZQaUdDK0Zsc2FPWEl4dmppdVJ5WFYzaFpxeWNiT1kz?=
 =?utf-8?B?aU9KelZxa1AzUjZHbWVpbDI3RFB1N21hbzIwMFhuMXhFcEl0dkFMcjZsbys3?=
 =?utf-8?B?WUpTZDV1S2ZWU0Ixc3dzUUNROUgvZytGTXhMRzNrSS9MM1FsUVZhcEd5Ymdl?=
 =?utf-8?B?ZFE9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08b5d18c-8e1f-431a-a70e-08ddf3ffb857
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 02:29:39.4561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2OlDgbxvpIlUApxeAdZZ10gj3ZeGSDYp0Aojsedc8vDf70dvBAKRiEa9iGTr14Uw2oG69kd4mNqJuMY3qeh9q+ceWLM4BpEaSpMY848xEc4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR03MB7206


Reviewed-by:Xianwei Zhao <xianwei.zhao@amlogic.com>
On 2025/9/14 04:15, Colin Ian King wrote:
> [You don't often get email from colin.i.king@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> [ EXTERNAL EMAIL ]
> 
> Currently a call to regmap_write is not being error checked because the
> return checke is being performed on the variable ret and this variable
> is not assigned the return value from the regmap_write call. Fix this
> by adding in the missing assignment.
> 
> Fixes: 4670db6f32e9 ("spi: amlogic: add driver for Amlogic SPI Flash Controller")
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>   drivers/spi/spi-amlogic-spifc-a4.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-amlogic-spifc-a4.c b/drivers/spi/spi-amlogic-spifc-a4.c
> index 4ca8e82fdc67..4338d00e56a6 100644
> --- a/drivers/spi/spi-amlogic-spifc-a4.c
> +++ b/drivers/spi/spi-amlogic-spifc-a4.c
> @@ -420,7 +420,7 @@ static int aml_sfc_dma_buffer_setup(struct aml_sfc *sfc, void *databuf,
>                  goto out_map_data;
> 
>          cmd = CMD_DATA_ADDRH(sfc->daddr);
> -       regmap_write(sfc->regmap_base, SFC_CMD, cmd);
> +       ret = regmap_write(sfc->regmap_base, SFC_CMD, cmd);
>          if (ret)
>                  goto out_map_data;
> 
> --
> 2.51.0
> 

