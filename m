Return-Path: <linux-spi+bounces-50-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D7D7FA863
	for <lists+linux-spi@lfdr.de>; Mon, 27 Nov 2023 18:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEA51281612
	for <lists+linux-spi@lfdr.de>; Mon, 27 Nov 2023 17:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D093BB25;
	Mon, 27 Nov 2023 17:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grpleg.onmicrosoft.com header.i=@grpleg.onmicrosoft.com header.b="Mo7RIZrs"
X-Original-To: linux-spi@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2101.outbound.protection.outlook.com [40.107.249.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6104198;
	Mon, 27 Nov 2023 09:54:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XwLURkLFWoiNnYly7pS4hlDbPiXuyFFmTSw62dTJi+j6zCyTuwsHN4Ts9S3WFOjuiHicCFTqAmIBuCr8gK9d8cCTeECSeMi/RUABuxThBH3U9nT+fUrYTJlQjIbHbl8k8Q0waqRl1XYinPF+s/R0hJAVM3efrxxeYSJD2q2qnJTMWyOyAkgQYB3CJ5GJrwUf6IQEi6UX/KiLaTg3kAiCvxEa9JRnWTnrGqRGPkZ8K5RZTyrzHna18l9ilfrjPMooe9X9Ingtk9VMqsOX88aXzdRs9ZEFf75I3TROXKuvAfI7hw/q1h6WqNJJ9xByiKj69w6x80jqa8nftQ7iyl0TPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zL3OCZ9RaqjnRbvMMpFLxk8ceau28ovmtQbFFplhc1M=;
 b=hvsIEqUCabp7BEdMaQmiU15D/3Kir3GFi21+zQjD1aeQYj6OGE4VCvLnDhBoaenlKT0HYDLlti2s1LhNhyqzwx5khfRoMHlFwg74PFbhfdHgK75gGxdEa8LMS94XnJ6brUxU25QR98nTlxgXWMuvaFL7mPqrJE1fhQvPh5kQI45QSvHH3yaK+g5hmDB+YsxnFysCNwEXS7Pjx9ETZYtd0KOpbFzf/qJlkOkAXsZE9qY69jKcvIWu0RDIL6oPVu/Bfz6D4WjosEPWFhfMNJEzcrdTiZ83+Y0/wvRv1YEVlenhPipCtC+qVfVAkxLcr3n1xg3UhQ5B3XaGm+7j36lhTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=raritan.com; dmarc=pass action=none header.from=raritan.com;
 dkim=pass header.d=raritan.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=grpleg.onmicrosoft.com; s=selector1-grpleg-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zL3OCZ9RaqjnRbvMMpFLxk8ceau28ovmtQbFFplhc1M=;
 b=Mo7RIZrsZ46OhzcYr9MOfBH3zS9YVvLmQnxuZL1d7+Ljskz78A5rNhUfehYUpOY1BTOZj4QwE3FFRJvMk06IZq1u43degSVKKJQBg1Nmtby/PV8n7OPsNwlv4ZVNMcmJk/s+0uGxm2RVvMhkHPV6y6vrefXOMZWUcDiU3atCIfw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=raritan.com;
Received: from DB8PR06MB6539.eurprd06.prod.outlook.com (2603:10a6:10:12f::23)
 by DU2PR06MB8383.eurprd06.prod.outlook.com (2603:10a6:10:2f2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Mon, 27 Nov
 2023 17:54:42 +0000
Received: from DB8PR06MB6539.eurprd06.prod.outlook.com
 ([fe80::98dd:e9db:b7d8:9001]) by DB8PR06MB6539.eurprd06.prod.outlook.com
 ([fe80::98dd:e9db:b7d8:9001%3]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 17:54:42 +0000
Message-ID: <0ce4c673-5c0b-4181-9d8b-53bcb0521f3e@raritan.com>
Date: Mon, 27 Nov 2023 18:54:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] spi: atmel: Do not cancel a transfer upon any signal
Content-Language: en-US
From: Ronald Wahl <ronald.wahl@raritan.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, Mark Brown
 <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Ryan Wanner <ryan.wanner@microchip.com>, stable@vger.kernel.org
References: <20231127095842.389631-1-miquel.raynal@bootlin.com>
 <a90feacc-adb0-4d7d-b0a4-f777be8d3677@raritan.com>
In-Reply-To: <a90feacc-adb0-4d7d-b0a4-f777be8d3677@raritan.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0162.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::16) To DB8PR06MB6539.eurprd06.prod.outlook.com
 (2603:10a6:10:12f::23)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR06MB6539:EE_|DU2PR06MB8383:EE_
X-MS-Office365-Filtering-Correlation-Id: f9491854-f9ec-48d6-031e-08dbef71eefe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ntAdmYgrvZmpKjujFex4e/7zbqFlsk0mfwXKYbrr+Pq9wAC34hsNQ1NL+XSy2kEaiGjKaBck+uoh4vgDWtGwmMIe3ylN2Lo38tbm9bgk2XhBuiA4zhysOZTng3G6gI1Vs6p4TSvNzvNWI8hCiDqgqsjnC7ycLLVuw6XW7kBSStUDgKjWL4I+hvV3FfXc9VKE6vS7/nOvMTx6iUAbE9IHeIPM0VQYMLALZKSO/BueIpFadolqy1L7kBdi0h4bciXgGUtTCQtKSxHHA5xl9yYUrea4OoSOheUjU/4L9hRGBfesupytz06ya8N24s0dxyncFthpoy9xVSq65pFayR10IrguUHHlgviKh3Ojd6HfyOb2lGD68W9DlLR/u4yDIlPtxLn7LkQy7woB3YEWdTHl3a5mNtIH9yWJA3AWzlMt6uvX4XddSqjsYv4JqxIVaOFyOPW4LBu6CC0fNYwD5ml4Jvl8AXUALtpj5u0nTPP3LsEA3FGN9beAoI1BBKK0KZ3cDXOLsGx0fjHeElnwxYxm+B7/RMkBfTU3LrciveX3yHNY7WyEBQ29dJD9EsThthWKiWyaQumU86ZEfWF/WSzLjTVJrH+Exv4+c/+62aV5KiD82S2t2B0HIzCsWwf7BOYRrbo65z/kDZbFORtSH/+Big==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR06MB6539.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(39860400002)(346002)(136003)(366004)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(38100700002)(41300700001)(36756003)(31686004)(86362001)(83380400001)(5660300002)(66574015)(26005)(44832011)(2616005)(2906002)(31696002)(6512007)(53546011)(6506007)(8676002)(4326008)(8936002)(478600001)(6486002)(54906003)(66946007)(110136005)(66476007)(66556008)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mm1JVHBaYlBRSEJKMmVoWndGNU1MWHF1enZ5WmJ4eTdIMHpMZ0VvVUNBa0VH?=
 =?utf-8?B?OGJHQnV5dEhWR3FPdWZxS3lKWWJSQ0VYdmo2S1g2dWFtai9mZXhZY3FWS0M1?=
 =?utf-8?B?aFdaUEw5akY5bWNDTUNnTUVWV2gyVGdaVncyc0NVdHlRekRQdk96SnQvbnlF?=
 =?utf-8?B?UXlHL0Z4TkRqOVRtTnNQSlI5L2tYQS9BeVN0VjFydzgvL2dKcjhHbmRDNi9t?=
 =?utf-8?B?bTAvNVloZXlGQllCTXh4OTJVbldyN0x0ZHI2TUVpL1pwd2dCaGtmRG03MmNS?=
 =?utf-8?B?Vjdyd0lEaVFjUXBtM3ZKYkpMdGFRZFhtUVdteUliaFV5L242NldkeWwyL1Mv?=
 =?utf-8?B?NGM0YVRoSFZrKzhWUjRkZy9YS085L0JpVVAvTi85UjJuQjBBUnJvR2lUdGl1?=
 =?utf-8?B?Uk9rOHFKRVZTRFY3SDlTellYOFAwcVdqR0x1cm5mSkYyVDNveG5Mc3dGWXJQ?=
 =?utf-8?B?Tll3VEdPQ1F4N2xKMmkyV0pXdU9kQ0lWbExoeUgwZTh5bzM2UHBwZ0RlREpC?=
 =?utf-8?B?cXV0TUtCYVZaZXA3eDM4eDBzWCs0QXhwU05oTy9hSnlpS0puRFpTSDYzblRP?=
 =?utf-8?B?N3psRWpPOFJEMXR6Nzh5V3JScHNoczZ6NjVGUHhXdVRLU2RSbTM2aVJUeG9G?=
 =?utf-8?B?ZU9pUUxVaW5oSjJmTU9sZ25rT2Z2cHF1ZFVhSkowMVFtSnRQTndsa2ErMkM4?=
 =?utf-8?B?Z1R5Rlp3K24xNTJXTy91OGpXVnZDNmJXdVE3RzBIK0RWUDlGSy91S1BnUDNl?=
 =?utf-8?B?Q1VkcERsMkJHNk52QlRvVGc2ZnVuT1YyanRmaXlzVmsvYVpZT1FoY25WNW9j?=
 =?utf-8?B?U05tajZUZFl4ZzEvY015WlVBUVJncDNwNWhERk83Ky9iVFR5SEM5Tm9lSHVy?=
 =?utf-8?B?TEVycDdRbFp5VitMQUVwUUY1MUFtTzV4YjJQWUlPQ09yemgxU1U4YktzT1I5?=
 =?utf-8?B?dExQT1htbFk5Q1VmNVN4NEZLdnBldE92Uzl6VU5ZbkttVUVTb1RoMEZRa2ZV?=
 =?utf-8?B?RnpMeVZkL3VKNWcxNk1BSWFDWHoxYjdyQ1VOVmNCNVp2dlBENS9sQUptK1Ew?=
 =?utf-8?B?azN5dWhsMFRPeGNVa0hJeWlGcmZtMFlwYW5uMUdpUUc5TjBJclJyWVBjaW0y?=
 =?utf-8?B?MHBZckZ6bk5FNWEwd21wSHJ2VHVpVUlJVXBqaEZrcjFpSEYwWS8wZ0IveGFw?=
 =?utf-8?B?UkpmVTQ4Z3RSWmRJS2orOWhmMFc5NjRSNXlsL2VZNzEvdHYvT1RDQnorN05z?=
 =?utf-8?B?Q2tKRm5CRi9qcE8xbU1SZCtJbXFsY0lSRitKdEhpZGt0Qit5dlFTNGJET0Vu?=
 =?utf-8?B?NHZEa0VpK2ZPWDBhUTF0bEZHVmVnU2NDTTQ0REQwcy9Lb2VJcE9jdm1tOE5V?=
 =?utf-8?B?STExbDg3dm5JTWxWam5qbzJScWJ4TmZiRTZiY1ZiT2lDeXIxZFdjbFl6L2xy?=
 =?utf-8?B?STNhR3orL1p1THh6ZTVDeHZBMlhlbExlbGY3NnRxTGlHUW1jdDF1TDhJMDRJ?=
 =?utf-8?B?WjhTZ1JBbG9OblA4YVBaOUxtOVU1Ylhja1RDTXRzckdjc0hkVGxyenFGL1hD?=
 =?utf-8?B?ZG5hMkxQbEJNaHdOU3VDZ3RCandkb0lSMHdwUkpEUHVwMmE4aU9GYWZIVk0v?=
 =?utf-8?B?bHV6UlZvbXhUMk5lbHdpMHczR093UXZHL1pFa3M1L3RhamJOL3NLRHZqc295?=
 =?utf-8?B?T29FSG1HMHJCdkpkZjVuWE5TZ2dkSmxPTlBqUmc4Mjk4ajVqZkx3bGJubzlS?=
 =?utf-8?B?eDg3dlkxMU54c08rdk5jYXNhTy93bWlDODFPVjdTQ2gwSG5iZkVSaWoyYnlq?=
 =?utf-8?B?L0V1NGYyWTlaZnQyR01mWWhtZy8vN2NsSVI4YURHeit4Qk44RG5PVDdoMHZ0?=
 =?utf-8?B?TUwzR1pVWU4xVTRWcUdhYmE3ZlpXb0VqMzQ5NVpYeGtLUys3MG1CSm9nYnhM?=
 =?utf-8?B?VTJ4VzQ3blFxZ0VvbGwzNzRNWjcxRUd5Tm8wclJqaGd6aGJGVVRWU2gyTXBF?=
 =?utf-8?B?enJydlh5c2lxdjYzZ2NRQ2lsVmh6anBjUTZ1dHd0SkZCN2liYS9LZkxUQ3Mz?=
 =?utf-8?B?N2k4SGM0V0NIVHNKVGlaTzlBdzVWbzRmSFpoNzA0SVZqckNtUTBnYyt2U3Qw?=
 =?utf-8?B?ME50MDJ0OWRZYTEyZUpqdDJXQUQ1SWh1aTBsZHk3YU9pT0wvNVRhWXhtQnBP?=
 =?utf-8?B?UWc9PQ==?=
X-OriginatorOrg: raritan.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9491854-f9ec-48d6-031e-08dbef71eefe
X-MS-Exchange-CrossTenant-AuthSource: DB8PR06MB6539.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 17:54:42.4495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 199686b5-bef4-4960-8786-7a6b1888fee3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k09DMIaqlUs/yVUs6xwHtMehTnLktT8Pflfn0MRIHffXdbdbvmeEp/h5Ci4xGrEc0MMimRaDPXIohu0/8UcH9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR06MB8383

On 27.11.23 16:10, Ronald Wahl wrote:
> On 27.11.23 10:58, Miquel Raynal wrote:
>> The intended move from wait_for_completion_*() to
>> wait_for_completion_interruptible_*() was to allow (very) long spi memor=
y
>> transfers to be stopped upon user request instead of freezing the
>> machine forever as the timeout value could now be significantly bigger.
>>
>> However, depending on the user logic, applications can receive many
>> signals for their own "internal" purpose and have nothing to do with the
>> requested kernel operations, hence interrupting spi transfers upon any
>> signal is probably not a wise choice. Instead, let's switch to
>> wait_for_completion_killable_*() to only catch the "important"
>> signals. This was likely the intended behavior anyway.
>
> Actually this seems to work. But aborting a process that has a SPI
> transfer running causes ugly messages from kernel. This is somehow
> unexpected:
>
> # dd if=3D/dev/urandom of=3D/flashdisk/testfile bs=3D1024 count=3D512
> ^C[=C2=A0 380.726760] spi-nor spi0.0: spi transfer canceled
> [=C2=A0 380.731688] spi-nor spi0.0: SPI transfer failed: -512
> [=C2=A0 380.737141] spi_master spi0: failed to transfer one message from =
queue
> [=C2=A0 380.746495] spi-nor spi0.0: spi transfer canceled
> [=C2=A0 380.751549] spi-nor spi0.0: SPI transfer failed: -512
> [=C2=A0 380.756844] spi_master spi0: failed to transfer one message from =
queue
>
> JFFS2 also logs an informational message which is less visible but also
> may rise eyebrows:
> [=C2=A0 380.743904] jffs2: Write of 4164 bytes at 0x0016a47c failed. retu=
rned
> -512, retlen 68
>
> Killing a process is something to expect in certain cases and it should
> not cause such messages which may create some anxiety that something bad
> had happened. So maybe the "kill" case should be silent (e.g. level
> "debug")
> but without out hiding real errors. But even when hiding the message in t=
he
> SPI framework it may cause additional messages in upper layers like JFFS2=
.
> I'm not sure whether all of this is a good idea. This is something others
> have to decide.

... and now I just got a crash when unmounting and remounting jffs2:

unmount:
[ 8245.821105] spi-nor spi0.0: spi transfer canceled
[ 8245.826288] spi-nor spi0.0: SPI transfer failed: -512
[ 8245.831508] spi_master spi0: failed to transfer one message from queue
[ 8245.838484] jffs2: Write of 1092 bytes at 0x00181458 failed. returned -5=
12, retlen 68
[ 8245.839786] spi-nor spi0.0: spi transfer canceled
[ 8245.844759] spi-nor spi0.0: SPI transfer failed: -512
[ 8245.850145] spi_master spi0: failed to transfer one message from queue
[ 8245.856909] jffs2: Write of 1092 bytes at 0x0018189c failed. returned -5=
12, retlen 0
[ 8245.856942] jffs2: Not marking the space at 0x0018189c as dirty because =
the flash driver returned retlen zero

mount:
[ 8831.213456] jffs2: error: (1142) jffs2_link_node_ref: Adding new ref 28b=
d9da7 at (0x000ad578-0x000ae5bc) not immediately after previous (0x000ad578=
-0x000ad578)
[ 8831.228212] Internal error: Oops - undefined instruction: 0 [#1] THUMB2
[ 8831.234996] CPU: 0 PID: 1142 Comm: mount Not tainted 6.6.2-sama5 #1
[ 8831.241587] Hardware name: Atmel SAMA5
[ 8831.245478] PC is at jffs2_link_node_ref+0xe/0xe2
[ 8831.250360] LR is at jffs2_link_node_ref+0xb9/0xe2
[ 8831.255473] pc : [<c020969c>]    lr : [<c0209747>]    psr: 00000033
[ 8831.261893] sp : c974dd78  ip : 00000000  fp : c09c6a5c
[ 8831.267428] r10: c1572f18  r9 : 0000e002  r8 : c2849964
[ 8831.272801] r7 : 00001a44  r6 : 000ae5bc  r5 : c14df4a8  r4 : c1620208
[ 8831.279647] r3 : 00000001  r2 : 40000000  r1 : c090ce3c  r0 : 00000093
[ 8831.286340] Flags: nzcv  IRQs on  FIQs on  Mode SVC_32  ISA Thumb  Segme=
nt none
[ 8831.293974] Control: 50c53c7d  Table: 21470059  DAC: 00000051
[ 8831.300025] Register r0 information: non-paged memory
[ 8831.305239] Register r1 information: non-slab/vmalloc memory
[ 8831.311220] Register r2 information: non-paged memory
[ 8831.316427] Register r3 information: non-paged memory
[ 8831.321630] Register r4 information: slab kmalloc-2k start c1620000 poin=
ter offset 520 size 2048
[ 8831.330796] Register r5 information: slab jffs2_refblock start c14df3e0 =
pointer offset 200 size 248
[ 8831.340219] Register r6 information: non-paged memory
[ 8831.345422] Register r7 information: non-paged memory
[ 8831.350784] Register r8 information: slab kmalloc-4k start c2849000 poin=
ter offset 2404 size 4096
[ 8831.360032] Register r9 information: non-paged memory
[ 8831.365243] Register r10 information: slab pde_opener start c1572f18 poi=
nter offset 0 size 24
[ 8831.374137] Register r11 information: non-slab/vmalloc memory
[ 8831.380041] Register r12 information: NULL pointer
[ 8831.385140] Process mount (pid: 1142, stack limit =3D 0xb9d2bb39)
[ 8831.391215] Stack: (0xc974dd78 to 0xc974e000)
[ 8831.395884] dd60:                                                       =
000ad578 000ae5bc
[ 8831.404242] dd80: 000ad578 000ad578 c2849dec c2805e00 c1620208 c2849dec =
00000000 c021130d
[ 8831.412762] dda0: c1572d50 00000694 0000069c 00000036 00010000 c2937755 =
00000000 20061985
[ 8831.421280] ddc0: 0000069c 00000000 c2849964 c2805e00 c1620208 c2849964 =
0000069c 00000008
[ 8831.429799] dde0: 00000000 c2849ff8 c2849000 c020c40b c09c6a5c c974de34 =
c974de30 00000000
[ 8831.438154] de00: 00000004 0000069c 00001000 c2937bc0 00000208 c1620000 =
00000000 000a0000
[ 8831.446665] de20: 00000000 00000000 0000000a 00070000 c2849000 00000000 =
00001000 00000000
[ 8831.455184] de40: 00000000 00000000 00010000 c2805e00 00000000 00000000 =
00200000 c2937e00
[ 8831.463704] de60: 00000000 00008000 c0975a98 c020e02d c1001300 00000200 =
c020f3eb 00000dc0
[ 8831.472062] de80: c2937e00 00000000 c020f3eb c2805e00 c156fc80 c29b9400 =
00200000 c2937e00
[ 8831.480584] dea0: 00000000 c020f42d c29b9400 c156fc80 c09c6a64 c29b9400 =
c1298c00 c156fc80
[ 8831.489100] dec0: c020f5c9 c02a853d 0000003a 00000000 c156fc80 c020f5c9 =
c974df58 c02a85ff
[ 8831.497458] dee0: c156fc80 c020f5c9 00000000 c020f5bf c156fc80 c156fc80 =
00000020 c016fdc3
[ 8831.505976] df00: c156fc80 00000000 c1374780 c0115c75 00000000 00000000 =
c156fc80 c0182209
[ 8831.514497] df20: c2937e00 c974df58 c2937f80 00000000 c2937e00 c2937f80 =
00008000 00000000
[ 8831.523015] df40: 0006d71a 00008000 00068991 c0182307 00000000 c015048b =
c1360d90 c18b3a18
[ 8831.531370] df60: 00001000 c2937f80 c2937e00 00000000 00000015 c0182539 =
00000000 0006d71a
[ 8831.539881] df80: 0006d725 00000000 0006d70c 0006d71a 00000015 c010023c =
c1374780 00000015
[ 8831.548399] dfa0: 00068991 c0100041 00000000 0006d70c 0006d70c 0006d71a =
0006d725 00008000
[ 8831.556908] dfc0: 00000000 0006d70c 0006d71a 00000015 00008000 00000000 =
0006d938 00068991
[ 8831.565263] dfe0: b6ea606c beb82b9c 00039818 b6ea607c a0000010 0006d70c =
00000000 00000000
[ 8831.573779]  jffs2_link_node_ref from jffs2_sum_scan_sumnode+0x1a5/0x320
[ 8831.580860]  jffs2_sum_scan_sumnode from jffs2_scan_medium+0x2d7/0xab0
[ 8831.587595]  jffs2_scan_medium from jffs2_do_mount_fs+0xeb/0x356
[ 8831.593958]  jffs2_do_mount_fs from jffs2_do_fill_super+0xf7/0x182
[ 8831.600332]  jffs2_do_fill_super from mtd_get_sb+0x61/0x98
[ 8831.606176]  mtd_get_sb from get_tree_mtd+0x4f/0xe8
[ 8831.611241]  get_tree_mtd from vfs_get_tree+0x13/0x7c
[ 8831.616648]  vfs_get_tree from path_mount+0x409/0x4d4
[ 8831.621891]  path_mount from do_mount+0x33/0x40
[ 8831.626593]  do_mount from sys_mount+0xeb/0xfe
[ 8831.631367]  sys_mount from ret_fast_syscall+0x1/0x5c
[ 8831.636591] Exception stack(0xc974dfa8 to 0xc974dff0)
[ 8831.641961] dfa0:                   00000000 0006d70c 0006d70c 0006d71a =
0006d725 00008000
[ 8831.650314] dfc0: 00000000 0006d70c 0006d71a 00000015 00008000 00000000 =
0006d938 00068991
[ 8831.658818] dfe0: b6ea606c beb82b9c 00039818 b6ea607c
[ 8831.664195] Code: 6a63 b085 990a b903 (de02) 6ae5
[ 8831.669135] ---[ end trace 0000000000000000 ]---
[ 8831.673902] Kernel panic - not syncing: Fatal exception

The previous aborted I/Os from a dd may also play a role here but the crash=
 is
clearly a cause of the interrupted transfers. It's a bit odd that it is an
undefined instruction but probably it was a stack overflow.

Looking back in the SPI driver history I see some occasions where interrupt=
ible
transfers were changed to non-interruptible transfers because filesystems l=
ike
jffs2 used SIGKILL during unmount or maybe other reasons:

775c4c0032c4 "spi: stm32-qspi: remove signal sensitive on completion"
26cfc0dbe43a "spi-zynq-qspi: use wait_for_completion_timeout to make zynq_q=
spi_exec_mem_op not interruptible"
7f3ac71ac3b0 "spi: davinci: fix spurious i/o error"

Having them in spi-atmel now seems a bit off and even a source of misbehavi=
our
and even crashes.

- ron


________________________________

Ce message, ainsi que tous les fichiers joints =C3=A0 ce message, peuvent c=
ontenir des informations sensibles et/ ou confidentielles ne devant pas =C3=
=AAtre divulgu=C3=A9es. Si vous n'=C3=AAtes pas le destinataire de ce messa=
ge (ou que vous recevez ce message par erreur), nous vous remercions de le =
notifier imm=C3=A9diatement =C3=A0 son exp=C3=A9diteur, et de d=C3=A9truire=
 ce message. Toute copie, divulgation, modification, utilisation ou diffusi=
on, non autoris=C3=A9e, directe ou indirecte, de tout ou partie de ce messa=
ge, est strictement interdite.


This e-mail, and any document attached hereby, may contain confidential and=
/or privileged information. If you are not the intended recipient (or have =
received this e-mail in error) please notify the sender immediately and des=
troy this e-mail. Any unauthorized, direct or indirect, copying, disclosure=
, distribution or other use of the material or parts thereof is strictly fo=
rbidden.

