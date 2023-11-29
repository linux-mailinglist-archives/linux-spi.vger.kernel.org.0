Return-Path: <linux-spi+bounces-90-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0927FD4E0
	for <lists+linux-spi@lfdr.de>; Wed, 29 Nov 2023 12:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92F0F282BC0
	for <lists+linux-spi@lfdr.de>; Wed, 29 Nov 2023 11:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8818A1BDC9;
	Wed, 29 Nov 2023 11:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grpleg.onmicrosoft.com header.i=@grpleg.onmicrosoft.com header.b="i41LSsIG"
X-Original-To: linux-spi@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2120.outbound.protection.outlook.com [40.107.7.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B8019AD;
	Wed, 29 Nov 2023 03:05:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MVgGbfHs3PZhdbuYPm3h+8co84Re9GY4cj+/+JLoLm+QkR5pRd21UlDHi6yCJdSIl0RziiI/Fj1MRjpsXeiL8GfO/DlzSc7oODhp/0wyV2p4x42tncUSK5hYRazy/imHwtwOQRcWQZ9n1gKWHNzEunWkXXLwNqUBvitlULl5hG5qrmd8koi5/gDKihejiBQ7NZB/JTS8JvKRYXdlbUzJHm9peMYA8NGsyzAGW5Y6vb70dH4VZ7dbZDHPt2AsVnV+RirA9i84nMZWe63mmLaNnavAMQTquYrbtAJwoZav6aaZuEhB/1qd0zkXZ4jRei6hXPMdw+Pe9iniioUcu3Yk9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/erZZk+Q6y6SyqAzC+fLeYukWLi420NFw2i3xpBb2FA=;
 b=IybDsxm4QTMVLj/G5d71DvagY8Vzlk6IJJ6MHrIKRTLcJrFJga/7t6UnnfjxmTmaAby62mKNSvJ5eGi9ha5uXi7a/RUAq5jcWLB/IImOnthU2xDsxoOs56XhjbT7Df77GR8oUqpp/DJtXduqTMSfDWoJskwFJi5cvAqJvN4VtTQb2Q3uKPXg+sv5nKJLuxxaljqzPzqDE1w/OCkXSPid0FSxqPNuwezmg+uXsp7JmSDCEwr8PgX/yu23euKIDCW3QscOn1lx0HtlQsSaQnkHDxDSKDeVp14hMir0of3jhej6v6mbnJrTFAyd35l6syy1wgRsahqR/GdVVcaeKybOoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=raritan.com; dmarc=pass action=none header.from=raritan.com;
 dkim=pass header.d=raritan.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=grpleg.onmicrosoft.com; s=selector1-grpleg-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/erZZk+Q6y6SyqAzC+fLeYukWLi420NFw2i3xpBb2FA=;
 b=i41LSsIGzDikdn4ipSg4lAxhZN32winRx7B05aCD0q9dOEl89vvlS7EQIIq6X4Hh+8dagQCwV3+kf9E9ZF9e6mkbkR9PsgJo7wr9PkvkIFCyyHN3N/YXNVum2NMpoBf25bjQBTCesgQJA0ZbhLv3ojn6NBpzsJctTbSfYquvDGc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=raritan.com;
Received: from DB8PR06MB6539.eurprd06.prod.outlook.com (2603:10a6:10:12f::23)
 by VI1PR06MB8712.eurprd06.prod.outlook.com (2603:10a6:800:1d0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Wed, 29 Nov
 2023 11:05:54 +0000
Received: from DB8PR06MB6539.eurprd06.prod.outlook.com
 ([fe80::98dd:e9db:b7d8:9001]) by DB8PR06MB6539.eurprd06.prod.outlook.com
 ([fe80::98dd:e9db:b7d8:9001%3]) with mapi id 15.20.7046.015; Wed, 29 Nov 2023
 11:05:54 +0000
Message-ID: <620e1474-9719-4127-81a3-38c923109ef9@raritan.com>
Date: Wed, 29 Nov 2023 12:05:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] spi: atmel: Do not cancel a transfer upon any signal
Content-Language: en-US
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Ryan Wanner <ryan.wanner@microchip.com>, stable@vger.kernel.org,
 Richard Weinberger <richard.weinberger@gmail.com>
References: <20231127095842.389631-1-miquel.raynal@bootlin.com>
 <a90feacc-adb0-4d7d-b0a4-f777be8d3677@raritan.com>
 <0ce4c673-5c0b-4181-9d8b-53bcb0521f3e@raritan.com>
 <20231129094932.2639ca49@xps-13>
From: Ronald Wahl <ronald.wahl@raritan.com>
In-Reply-To: <20231129094932.2639ca49@xps-13>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BE1P281CA0189.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8d::20) To DB8PR06MB6539.eurprd06.prod.outlook.com
 (2603:10a6:10:12f::23)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR06MB6539:EE_|VI1PR06MB8712:EE_
X-MS-Office365-Filtering-Correlation-Id: 37a3750c-0af6-4369-6ba0-08dbf0cb27fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	d68iaX0LvFphAjvFgIzSVArgY7Vuxa9xULUhJIRYnok8GZplPAgcGB64SGinOjdPhnw+ySFeUB7T588gELysZveqJe+zHw/k37Us1m5gOMKnVShbmsD/WXaKMoCbVBgCxrfIH4RuW1NhhzUEnv1XkrHKXX0J4pUQ2TcJ3tWCHVir9yPJNK3TctlIp1NblLIMFCbMka5hJwr2joe9V0xVUK/bUyWMKaiVlcKBkYm68+7xqHMG85wfKzYWjCi7avafKTHxeJJz4mwVt/hFwPpuVowJFIhIkxt20CNSV72n+kHZmOegOASGYXx28n7ZfVqhUaySQtTyc6+/v6UzhEvYGNUIZHrcYGbeLzwFF/9sgSTjqWDSWqiTzFvKj5sZTEMtsHqV6uVnyf0DaeoaCnzHhg0j5GzmeLMAFI9zDrVaOLp3jdKcJ+nJdCTxOLZXj0lV1CwTk28HypR4nrxkKcOXcFUt56C/74PHv6gNkM9FSWsvinTfzhfUdr2tDDPBaPa3e3ROCKXqujG7chxzkvyYC+sQwmXPDNdd/3R0aBUoP/Wahehpggd8pelq7dsB8re+ttHzyehKED1NpgDrPpLoc7E+ZmrJKOaC6bJAlNS6sbBIq6BQJy4baaTtXxWVFJQnqUcsz8JF0ulZ6/he/UQ9C5j7apygbnTlMc9oE/w2l9uP9Lc8CRZ2x6jATg2mbVGQ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR06MB6539.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(366004)(136003)(376002)(230173577357003)(230273577357003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(44832011)(8676002)(8936002)(31696002)(4326008)(6512007)(53546011)(6506007)(316002)(66556008)(6916009)(66946007)(54906003)(6486002)(478600001)(30864003)(36756003)(38100700002)(41300700001)(31686004)(86362001)(26005)(66476007)(2906002)(2616005)(5660300002)(83380400001)(66574015)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d0FKKzBuZzBQSUl5My9HT3BPMk9VV0IrUXVwa0J2ZEFzY3B4ZTVESStwRlN4?=
 =?utf-8?B?dFZqc3NQa1F0ck5GZDNRTkhOR2oyQVduQ3JyZkpEU0xvME4yNFlnSUxUMENK?=
 =?utf-8?B?MTY1SE5hZ2c4Tzcxekw0NjhWeFFHZUphKzV4NDdIcGNuVkFseFlTMEc2dG8x?=
 =?utf-8?B?VzErRzZmcnNUM29RVzFFQzE5SjNZTGpPWFlSMS9SaEVuNGpiWWsrMWt5VEJv?=
 =?utf-8?B?MVFFbDBQd2t3Y2xpY2tVQmhrcU9ZcEowNU1OZGJaT2lOWHplMHhVMGRmdXhB?=
 =?utf-8?B?T0ZjN21HeUtqUStwNEFpZnJmYTlOc1Z3c25OaWhCbytjN3BkQ1N5UGdHV20r?=
 =?utf-8?B?VkdtSnRIdTRkQ3F4bnJNM2RBNE9YeWVreEZVeCtPT1daQitRTW9IWVhISDd1?=
 =?utf-8?B?S09YYVJHckRabURZamJnRmtGVld1L0Y4cVppc0JYMmc1QmNMandNY3k4d1Jn?=
 =?utf-8?B?eEgxZUppdSs2Mldld1g0V054dlhzcHl2MEtxdnVLRmQ0UGhWNy9LZ0J2ejVl?=
 =?utf-8?B?RENzT29FOU8zL2ZURjBLUUcxSnlmNmZzUWRaSTJXMmwzK3dKMmdNZi9Ca1Bn?=
 =?utf-8?B?czJxeHU0NnRYWlF3UmJDNFUwZkkzMzZrUHZ3WndkTHhJVnVUdDlFNkswUnNP?=
 =?utf-8?B?SForUGRhbnRvWnc2eVpsM2Fjbld3L0Z3RFJnTmtwR3Z6c2xMSll1RWhINm5q?=
 =?utf-8?B?cWxHKy9RMlF5cEM1dVlkU0lSOWQzbElqQ1dzNFVRTm5qK1dNV09wdmdBZHZo?=
 =?utf-8?B?bUpRci93Y2JHWmtWRVJsOUZpdlBrQk5NR1R3VUIvcERKZjRYeDlEd3dJV2hT?=
 =?utf-8?B?K1pVa3o1N1N0bVlMbmVjM2IxZHZrYkNPTFdBc2RSZ1hjR1VlbEswOGxsaHZq?=
 =?utf-8?B?NjBzdmt6MWRZdlVsRzVvempleDZ3M2hERnlCYUJCalNUUXJqZDB4OWtadU5m?=
 =?utf-8?B?eklFdE9ETFBibjhWSDkwZWpZUXpjODJMamdLWEtLVWwyTlNaUlNVcFUxRVJt?=
 =?utf-8?B?Y0FVb05XdVFocGJrVG1ZV1JYVCtWWU9TM1Nmbkl2MzBydUwyaWJ5eU1ZMlRz?=
 =?utf-8?B?QzAyYXFDVFZUQVNuLzlVMDNIMlBzOTZFYTNCTGM0Ylk0NXFaYTlOTGRMVUpK?=
 =?utf-8?B?SG9ZQ1pwUFpGU01jNzNOTklQMys0UVZiRGtUTkV6aWNQZ3RUeGxsejB5RGxM?=
 =?utf-8?B?aUdFL2thWjhISzFDZC9GeUdxaHl5eVl4SVdhaFBuY0c3VnJoeEphZTFnUjhy?=
 =?utf-8?B?MmUvbXRSNFA3QjR3Sk8zQitXOHJnemc1cWRDcFBCRW05QUxWU0wycjZxY0Z1?=
 =?utf-8?B?TXpWVU1iVXJPTEZ5YXpEL0Vob0FnTXgvV3VXbzJoK3dxZVp0aEJXbHBVVkdW?=
 =?utf-8?B?TzZZTW8wdnJ2cmEwL1E3TUE3SDA2MzVaZmV1d090S1JVTTBQRitRVHozbVJs?=
 =?utf-8?B?ZjduZmRZVTAxL1VPaTZUWGhhYTRCa0psUEdLTWRrYWVCbG94a09hcEg2bXpY?=
 =?utf-8?B?b0Mrc3NLTXBIMEpaN3ROSjBmUW5odnFFWm9ZbkJiU0hFdlJTTVl5ZE53Zjc3?=
 =?utf-8?B?cm9uWVQ1NVlrOG5yMXBPR0ZMVm52b3pNY1FtQno2TmJwZ3JZRUx3ZHpNbHFZ?=
 =?utf-8?B?NkxyNE5xcXhmcU1vZVI4ZFYxdjZYbFJuT3UxbVdWYjAwT3BHSWU4UGJSbURH?=
 =?utf-8?B?YW9tcllXVktrYmZvY2l4N21TTUZLbWFtUDI2TVJkYlFZb0U5aExWcU83WkF1?=
 =?utf-8?B?WEtuZGhhSUJZdUh0OHhIN0hUanB0WjQ3QjRlQVJzNTNVYi9CYzhRNGxBRHNp?=
 =?utf-8?B?WGs3SUtsdjVtTTY0WktSOHA3cTgrRnJUd1RDK1YwUGpuUy80clhYVll1RGts?=
 =?utf-8?B?bGpRSlg0dVM3cTJwWWRuYmpON2s5N1RxanpHQk5oKzJWeC8wdkZyRGJMdExD?=
 =?utf-8?B?R2ZaRlZkQ0VSQkJkeDZTK3Z3WmZZZHB1cUJsejdvQzc4TGRQem5NRUNobUh4?=
 =?utf-8?B?SzMvQk0wNnRvUjR4YWd0bDEwdmIzUU96SUo5UW5yVGtlN2F5Z0NsWVdFQ1Zt?=
 =?utf-8?B?bFBjRUZYaVIyVWh0VmJjUU1SQlhMTy9sWkFOZWJQamp4eGxsbVMzM1psSmp1?=
 =?utf-8?B?bFNYRFk5UFZrb2pRaDF6enBWVDJ1OUI0V01MNXRLWE9Ud0tDVWlDTWZCdXhx?=
 =?utf-8?B?bGc9PQ==?=
X-OriginatorOrg: raritan.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37a3750c-0af6-4369-6ba0-08dbf0cb27fe
X-MS-Exchange-CrossTenant-AuthSource: DB8PR06MB6539.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 11:05:54.4236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 199686b5-bef4-4960-8786-7a6b1888fee3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Q+eFvDad77MRouLinbENmzpm33RT+H9HTOvjm+cBUtXyDLiAcTe9spLPcAR3/9m5fcksV6a0UlXaZqtzbcsUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR06MB8712

Hi Miquel,

On 29.11.23 09:49, Miquel Raynal wrote:
> Hi Ronald,
>
> + Richard, my dear jffs2 expert ;)
>
> ronald.wahl@raritan.com wrote on Mon, 27 Nov 2023 18:54:40 +0100:
>
>> On 27.11.23 16:10, Ronald Wahl wrote:
>>> On 27.11.23 10:58, Miquel Raynal wrote:
>>>> The intended move from wait_for_completion_*() to
>>>> wait_for_completion_interruptible_*() was to allow (very) long spi mem=
or
>> y
>>>> transfers to be stopped upon user request instead of freezing the
>>>> machine forever as the timeout value could now be significantly bigger=
.
>>>>
>>>> However, depending on the user logic, applications can receive many
>>>> signals for their own "internal" purpose and have nothing to do with t=
he
>>>> requested kernel operations, hence interrupting spi transfers upon any
>>>> signal is probably not a wise choice. Instead, let's switch to
>>>> wait_for_completion_killable_*() to only catch the "important"
>>>> signals. This was likely the intended behavior anyway.
>>>
>>> Actually this seems to work. But aborting a process that has a SPI
>>> transfer running causes ugly messages from kernel. This is somehow
>>> unexpected:
>>>
>>> # dd if=3D/dev/urandom of=3D/flashdisk/testfile bs=3D1024 count=3D512
>>> ^C[=C2=A0 380.726760] spi-nor spi0.0: spi transfer canceled
>>> [=C2=A0 380.731688] spi-nor spi0.0: SPI transfer failed: -512
>>> [=C2=A0 380.737141] spi_master spi0: failed to transfer one message fro=
m queue
>>> [=C2=A0 380.746495] spi-nor spi0.0: spi transfer canceled
>>> [=C2=A0 380.751549] spi-nor spi0.0: SPI transfer failed: -512
>>> [=C2=A0 380.756844] spi_master spi0: failed to transfer one message fro=
m queue
>>>
>>> JFFS2 also logs an informational message which is less visible but also
>>> may rise eyebrows:
>>> [=C2=A0 380.743904] jffs2: Write of 4164 bytes at 0x0016a47c failed. re=
tu
>> rned
>>> -512, retlen 68
>>>
>>> Killing a process is something to expect in certain cases and it should
>>> not cause such messages which may create some anxiety that something ba=
d
>>> had happened. So maybe the "kill" case should be silent (e.g. level
>>> "debug")
>>> but without out hiding real errors. But even when hiding the message in=
 t
>> he
>>> SPI framework it may cause additional messages in upper layers like JFF=
S2
>> .
>>> I'm not sure whether all of this is a good idea. This is something othe=
rs
>>> have to decide.
>>
>> ... and now I just got a crash when unmounting and remounting jffs2:
>>
>> unmount:
>> [ 8245.821105] spi-nor spi0.0: spi transfer canceled
>> [ 8245.826288] spi-nor spi0.0: SPI transfer failed: -512
>> [ 8245.831508] spi_master spi0: failed to transfer one message from queu=
e
>> [ 8245.838484] jffs2: Write of 1092 bytes at 0x00181458 failed. returned=
 -5
>> 12, retlen 68
>> [ 8245.839786] spi-nor spi0.0: spi transfer canceled
>> [ 8245.844759] spi-nor spi0.0: SPI transfer failed: -512
>> [ 8245.850145] spi_master spi0: failed to transfer one message from queu=
e
>> [ 8245.856909] jffs2: Write of 1092 bytes at 0x0018189c failed. returned=
 -5
>> 12, retlen 0
>> [ 8245.856942] jffs2: Not marking the space at 0x0018189c as dirty becau=
se the flash driver returned retlen zero
>>
>> mount:
>> [ 8831.213456] jffs2: error: (1142) jffs2_link_node_ref: Adding new ref =
28b
>> d9da7 at (0x000ad578-0x000ae5bc) not immediately after previous (0x000ad=
578
>> -0x000ad578)
>> [ 8831.228212] Internal error: Oops - undefined instruction: 0 [#1] THUM=
B2
>> [ 8831.234996] CPU: 0 PID: 1142 Comm: mount Not tainted 6.6.2-sama5 #1
>> [ 8831.241587] Hardware name: Atmel SAMA5
>> [ 8831.245478] PC is at jffs2_link_node_ref+0xe/0xe2
>> [ 8831.250360] LR is at jffs2_link_node_ref+0xb9/0xe2
>> [ 8831.255473] pc : [<c020969c>]    lr : [<c0209747>]    psr: 00000033
>> [ 8831.261893] sp : c974dd78  ip : 00000000  fp : c09c6a5c
>> [ 8831.267428] r10: c1572f18  r9 : 0000e002  r8 : c2849964
>> [ 8831.272801] r7 : 00001a44  r6 : 000ae5bc  r5 : c14df4a8  r4 : c162020=
8
>> [ 8831.279647] r3 : 00000001  r2 : 40000000  r1 : c090ce3c  r0 : 0000009=
3
>> [ 8831.286340] Flags: nzcv  IRQs on  FIQs on  Mode SVC_32  ISA Thumb  Se=
gme
>> nt none
>> [ 8831.293974] Control: 50c53c7d  Table: 21470059  DAC: 00000051
>> [ 8831.300025] Register r0 information: non-paged memory
>> [ 8831.305239] Register r1 information: non-slab/vmalloc memory
>> [ 8831.311220] Register r2 information: non-paged memory
>> [ 8831.316427] Register r3 information: non-paged memory
>> [ 8831.321630] Register r4 information: slab kmalloc-2k start c1620000 p=
oin
>> ter offset 520 size 2048
>> [ 8831.330796] Register r5 information: slab jffs2_refblock start c14df3=
e0 pointer offset 200 size 248
>> [ 8831.340219] Register r6 information: non-paged memory
>> [ 8831.345422] Register r7 information: non-paged memory
>> [ 8831.350784] Register r8 information: slab kmalloc-4k start c2849000 p=
oin
>> ter offset 2404 size 4096
>> [ 8831.360032] Register r9 information: non-paged memory
>> [ 8831.365243] Register r10 information: slab pde_opener start c1572f18 =
poi
>> nter offset 0 size 24
>> [ 8831.374137] Register r11 information: non-slab/vmalloc memory
>> [ 8831.380041] Register r12 information: NULL pointer
>> [ 8831.385140] Process mount (pid: 1142, stack limit =3D 0xb9d2bb39)
>> [ 8831.391215] Stack: (0xc974dd78 to 0xc974e000)
>> [ 8831.395884] dd60:                                                    =
   000ad578 000ae5bc
>> [ 8831.404242] dd80: 000ad578 000ad578 c2849dec c2805e00 c1620208 c2849d=
ec 00000000 c021130d
>> [ 8831.412762] dda0: c1572d50 00000694 0000069c 00000036 00010000 c29377=
55 00000000 20061985
>> [ 8831.421280] ddc0: 0000069c 00000000 c2849964 c2805e00 c1620208 c28499=
64 0000069c 00000008
>> [ 8831.429799] dde0: 00000000 c2849ff8 c2849000 c020c40b c09c6a5c c974de=
34 c974de30 00000000
>> [ 8831.438154] de00: 00000004 0000069c 00001000 c2937bc0 00000208 c16200=
00 00000000 000a0000
>> [ 8831.446665] de20: 00000000 00000000 0000000a 00070000 c2849000 000000=
00 00001000 00000000
>> [ 8831.455184] de40: 00000000 00000000 00010000 c2805e00 00000000 000000=
00 00200000 c2937e00
>> [ 8831.463704] de60: 00000000 00008000 c0975a98 c020e02d c1001300 000002=
00 c020f3eb 00000dc0
>> [ 8831.472062] de80: c2937e00 00000000 c020f3eb c2805e00 c156fc80 c29b94=
00 00200000 c2937e00
>> [ 8831.480584] dea0: 00000000 c020f42d c29b9400 c156fc80 c09c6a64 c29b94=
00 c1298c00 c156fc80
>> [ 8831.489100] dec0: c020f5c9 c02a853d 0000003a 00000000 c156fc80 c020f5=
c9 c974df58 c02a85ff
>> [ 8831.497458] dee0: c156fc80 c020f5c9 00000000 c020f5bf c156fc80 c156fc=
80 00000020 c016fdc3
>> [ 8831.505976] df00: c156fc80 00000000 c1374780 c0115c75 00000000 000000=
00 c156fc80 c0182209
>> [ 8831.514497] df20: c2937e00 c974df58 c2937f80 00000000 c2937e00 c2937f=
80 00008000 00000000
>> [ 8831.523015] df40: 0006d71a 00008000 00068991 c0182307 00000000 c01504=
8b c1360d90 c18b3a18
>> [ 8831.531370] df60: 00001000 c2937f80 c2937e00 00000000 00000015 c01825=
39 00000000 0006d71a
>> [ 8831.539881] df80: 0006d725 00000000 0006d70c 0006d71a 00000015 c01002=
3c c1374780 00000015
>> [ 8831.548399] dfa0: 00068991 c0100041 00000000 0006d70c 0006d70c 0006d7=
1a 0006d725 00008000
>> [ 8831.556908] dfc0: 00000000 0006d70c 0006d71a 00000015 00008000 000000=
00 0006d938 00068991
>> [ 8831.565263] dfe0: b6ea606c beb82b9c 00039818 b6ea607c a0000010 0006d7=
0c 00000000 00000000
>> [ 8831.573779]  jffs2_link_node_ref from jffs2_sum_scan_sumnode+0x1a5/0x=
320
>> [ 8831.580860]  jffs2_sum_scan_sumnode from jffs2_scan_medium+0x2d7/0xab=
0
>> [ 8831.587595]  jffs2_scan_medium from jffs2_do_mount_fs+0xeb/0x356
>> [ 8831.593958]  jffs2_do_mount_fs from jffs2_do_fill_super+0xf7/0x182
>> [ 8831.600332]  jffs2_do_fill_super from mtd_get_sb+0x61/0x98
>> [ 8831.606176]  mtd_get_sb from get_tree_mtd+0x4f/0xe8
>> [ 8831.611241]  get_tree_mtd from vfs_get_tree+0x13/0x7c
>> [ 8831.616648]  vfs_get_tree from path_mount+0x409/0x4d4
>> [ 8831.621891]  path_mount from do_mount+0x33/0x40
>> [ 8831.626593]  do_mount from sys_mount+0xeb/0xfe
>> [ 8831.631367]  sys_mount from ret_fast_syscall+0x1/0x5c
>> [ 8831.636591] Exception stack(0xc974dfa8 to 0xc974dff0)
>> [ 8831.641961] dfa0:                   00000000 0006d70c 0006d70c 0006d7=
1a 0006d725 00008000
>> [ 8831.650314] dfc0: 00000000 0006d70c 0006d71a 00000015 00008000 000000=
00 0006d938 00068991
>> [ 8831.658818] dfe0: b6ea606c beb82b9c 00039818 b6ea607c
>> [ 8831.664195] Code: 6a63 b085 990a b903 (de02) 6ae5
>> [ 8831.669135] ---[ end trace 0000000000000000 ]---
>> [ 8831.673902] Kernel panic - not syncing: Fatal exception
>>
>> The previous aborted I/Os from a dd may also play a role here but the cr=
ash
>>   is
>> clearly a cause of the interrupted transfers. It's a bit odd that it is =
an
>> undefined instruction but probably it was a stack overflow.
>>
>> Looking back in the SPI driver history I see some occasions where interr=
upt
>> ible
>> transfers were changed to non-interruptible transfers because filesystem=
s l
>> ike
>> jffs2 used SIGKILL during unmount or maybe other reasons:
>>
>> 775c4c0032c4 "spi: stm32-qspi: remove signal sensitive on completion"
>> 26cfc0dbe43a "spi-zynq-qspi: use wait_for_completion_timeout to make zyn=
q_q
>> spi_exec_mem_op not interruptible"
>> 7f3ac71ac3b0 "spi: davinci: fix spurious i/o error"
>>
>> Having them in spi-atmel now seems a bit off and even a source of misbeh=
avi
>> our
>> and even crashes.
>
> It's not just spi-atmel, any spi-mem controller might be tempted to use
> interruptible^Wkillable transfers just because the timeout values can
> be really big as the memory sizes increase.
>
> One solution is to change the completion helpers back to something
> non-killable/non-interruptible, but the user experience will be
> slightly degraded. The other would be to look into jffs2 (if it's the
> only filesystem playing with signals during unmount, tbh I don't know).
> But maybe this signaling mechanism can't be hacked for compatibility
> reasons. Handling this at the spi level would be a mix of layers, I'm
> not ready for that.
>
> Richard, Mark, what's your opinion here?

I think you will need to revert to uninterruptible transfers.
Just tested with the more modern UBIFS:

# dd if=3D/dev/random of=3D/flashdisk/testfile bs=3D1024 count=3D512
^C

[   74.281739] spi-nor spi1.0: spi transfer canceled
[   74.286768] spi-nor spi1.0: SPI transfer failed: -512
[   74.292090] spi_master spi1: failed to transfer one message from queue
[   74.299002] ubi0 error: ubi_io_write: error -512 while writing 48 bytes =
to PEB 38:4224, written 0 bytes
[   74.308884] CPU: 0 PID: 1129 Comm: dd Not tainted 6.6.2-sama5 #2
[   74.315070] Hardware name: Atmel SAMA5
[   74.319159]  unwind_backtrace from show_stack+0x11/0x12
[   74.324597]  show_stack from dump_stack_lvl+0x25/0x3e
[   74.330020]  dump_stack_lvl from ubi_io_write+0x1a7/0x220
[   74.335616]  ubi_io_write from ubi_eba_write_leb+0x91/0x1dc
[   74.341554]  ubi_eba_write_leb from ubi_leb_write+0x99/0xbc
[   74.347311]  ubi_leb_write from ubifs_leb_write+0x4b/0x8c
[   74.352923]  ubifs_leb_write from ubifs_wbuf_sync_nolock+0x141/0x1d4
[   74.359649]  ubifs_wbuf_sync_nolock from ubifs_sync_wbufs_by_inode+0x51/=
0x6a
[   74.367061]  ubifs_sync_wbufs_by_inode from ubifs_fsync+0x6f/0xa0
[   74.373340]  ubifs_fsync from generic_file_write_iter+0x8f/0x98
[   74.379632]  generic_file_write_iter from vfs_write+0xbd/0x100
[   74.385659]  vfs_write from ksys_write+0x45/0x68
[   74.390636]  ksys_write from ret_fast_syscall+0x1/0x16
[   74.395958] Exception stack(0xd183dfa8 to 0xd183dff0)
[   74.401352] dfa0:                   00000001 01a97008 00000001 01a97008 =
00000400 00000004
[   74.409709] dfc0: 00000001 01a97008 bef2abd8 00000004 00000000 0005b94c =
00052ac9 00000000
[   74.418234] dfe0: 0005b1f0 bef2abd8 00015ecf b6f0e6f6
[   74.482699] spi-nor spi1.0: spi transfer canceled
[   74.487825] spi-nor spi1.0: SPI transfer failed: -512
[   74.493205] spi_master spi1: failed to transfer one message from queue
[   74.500095] ubi0 error: ubi_dump_flash: err -512 while reading 48 bytes =
from PEB 38:4224, read 0 bytes
[   74.521967] ubi0 warning: ubi_eba_write_leb: failed to write data to PEB=
 38
[   74.529254] ubi0 warning: ubi_ro_mode: switch to read-only mode

I think file systems need uninterruptible transfers to ensure that the file=
system
structure stays consistent. With interruptible transfers this is just not p=
ossible.

Maybe a device tree option could be added to enable interruptible behaviour=
 for
people that really need it but it would be unsafe at least for filesystems.=
 I'm
not sure if this is something which is acceptible by the kernel people. I d=
oubt.

BTW, the "Internal error: Oops - undefined instruction: 0" in the JFFS2 cra=
sh
was likely a BUG macro. It uses an illegal instruction but the trap handler
should see that it is from a BUG. It is obviously broken on ARM32.

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

