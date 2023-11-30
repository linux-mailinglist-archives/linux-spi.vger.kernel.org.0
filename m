Return-Path: <linux-spi+bounces-108-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B99597FF97C
	for <lists+linux-spi@lfdr.de>; Thu, 30 Nov 2023 19:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4183228165C
	for <lists+linux-spi@lfdr.de>; Thu, 30 Nov 2023 18:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD172524D1;
	Thu, 30 Nov 2023 18:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grpleg.onmicrosoft.com header.i=@grpleg.onmicrosoft.com header.b="K8S+TRmD"
X-Original-To: linux-spi@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2113.outbound.protection.outlook.com [40.107.247.113])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9EB10D0;
	Thu, 30 Nov 2023 10:36:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N7WGC8GeEo+CCPx+zcx1WacIHkhBSBKzhyPrpvXcv5XWUGozjToyimaK2Fhdv9BUSil8o+R1NU3Qq0o/6wOPl8oneBY1SOPgP8g9IrufgCBEqbgIfST3Zdih1s2GOdqUFa5whoAgaDAueP6GSVyh34+LnU/dRjg0WtAVveeqUfBC+cUrUnI5Q/Q5n6d73IXJ3pmQToeOp2AbSFV+cYjqgXaSOfYvb2OYLxpvVxLRVL5ZqBkqjsov1UzBhOsNA71637mTKHdpPYtbpIr2m4h5tjOzTUv022mQmKwEmEYQx+KJmpdFM9h5fml7n/OAiVK8wp2WG8oPM5Ln+eem0cd+UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VOx9iiCBBUTKKbElOQ4nkJYbrf4B96H+0jxxcf0oS6c=;
 b=my1iQ89rH+dd434iOp13g4I+UFbRFoqZ15c7D75/tUYubkciLSnHU+SKFDAWehwCjV/bi9ccFUeyDv73JjsPdb+4vKG3ePwDfn1PNeW4MY9h661eCsWBv2XxKZac5+ZfW8d2IQkG/CPjxp70SphMjoyQU16KQ44KqRxEbZZqDvhnEOU67rzanYMv7gZIe+ddyyQcLYGyHxzz/T/oBV5QhbMFWkNA0+Clzjxh/UP9m5mWJUQXcakK4l1UgmHGfwtdYQ9nXedtrzDhVCXlNMXeijbVNelDgyhnHwIqa6nARKu3BeA6ulUWWMIPlxFSlHYq9n86TfFJMWk1stqAJPpIBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=raritan.com; dmarc=pass action=none header.from=raritan.com;
 dkim=pass header.d=raritan.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=grpleg.onmicrosoft.com; s=selector1-grpleg-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VOx9iiCBBUTKKbElOQ4nkJYbrf4B96H+0jxxcf0oS6c=;
 b=K8S+TRmDwH9p08wQu1R9/BWZeajfC5c0y5Jf2u8wC+2DhePgWymn8LVB7BwZvFHz90UKCX+F2xs7W4EZpi9C4O8ohSc3HLvsgzJ9af6a8EvYkIsrJr+Z9isJaEvBIpliIPjhBqgTrYNjwUBBGxTCU1O+kZZgGdq9znPiNmefA/0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=raritan.com;
Received: from DB8PR06MB6539.eurprd06.prod.outlook.com (2603:10a6:10:12f::23)
 by AS8PR06MB8412.eurprd06.prod.outlook.com (2603:10a6:20b:44b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Thu, 30 Nov
 2023 18:36:41 +0000
Received: from DB8PR06MB6539.eurprd06.prod.outlook.com
 ([fe80::98dd:e9db:b7d8:9001]) by DB8PR06MB6539.eurprd06.prod.outlook.com
 ([fe80::98dd:e9db:b7d8:9001%3]) with mapi id 15.20.7046.024; Thu, 30 Nov 2023
 18:36:40 +0000
Message-ID: <cc8ea2b4-eb2a-40fc-9dbe-d545d68b9905@raritan.com>
Date: Thu, 30 Nov 2023 19:36:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] spi: atmel: Do not cancel a transfer upon any signal
To: Richard Weinberger <richard@nod.at>,
 Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi <linux-spi@vger.kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Ryan Wanner <ryan.wanner@microchip.com>, stable <stable@vger.kernel.org>,
 Richard Weinberger <richard.weinberger@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>
References: <20231127095842.389631-1-miquel.raynal@bootlin.com>
 <a90feacc-adb0-4d7d-b0a4-f777be8d3677@raritan.com>
 <0ce4c673-5c0b-4181-9d8b-53bcb0521f3e@raritan.com>
 <20231129094932.2639ca49@xps-13>
 <723263313.45007.1701348374765.JavaMail.zimbra@nod.at>
 <1192504136.46091.1701368767836.JavaMail.zimbra@nod.at>
Content-Language: en-US
From: Ronald Wahl <ronald.wahl@raritan.com>
In-Reply-To: <1192504136.46091.1701368767836.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0360.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::13) To DB8PR06MB6539.eurprd06.prod.outlook.com
 (2603:10a6:10:12f::23)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR06MB6539:EE_|AS8PR06MB8412:EE_
X-MS-Office365-Filtering-Correlation-Id: 86d51bd4-11b0-4e6f-0cb7-08dbf1d34b3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tL6DGm7JCiTIsmkSdPloOYboeG5YmiJu/aMWp9b0QuOp8zZmapVvVoUEco149W2XNPP+nwM4Lmu1kySjRler1zV7l0OMgHlYX0DgLz7VJHubfW42bNQT3hs52tT/Y2IdqU1/6M89qR0GUNp2mzYqgUHOoauY349q+gq5shDfST2S2fBpY1NGNCJvhAuq3pqN6eK5RmK1SFf9FGuL+9icTWIBMpom4JTc1gvQ2yPHD28uvpoOSyFSPLH9V3FgQKQzU2nA++pHBmHLqoFlg94IceDqc5BAnl0t7gZn1xb/7MMPdvHSP62MA/g050gqO7hjnAEqzdoUKxBxl1JzHOuQKo1SWYdDtWnnr+GC4aeHEIh/dp7g7/22gEmDFPWRcDAAPPpL07XVv9Emk6oqdA7xRFyeegBS9p3DmqySUtQnTOkX2zrD6F/xM1t0dRApXwymTJTkYAZhopnYSOrJzIob0Tau1C6LgfIZIZiE/ohhSSySeVgouqQYVlbUtZvp6/vlYaBjQb16Wb7qCc9IMC6MNz7M8s/qLo6wg1LtBiOJ2KviPe5ObDboFazCyuQjZi56ByIcSvclL85XnoyXwU5ozAox1kQB0aAMPCHDcC0QtzNTXtI6trM4LBWSOtConmRLyxUZrRVihszDed2q4FQeJXgp9SrnrDWYZzD6hCKs0EpUnJspFXoI2leoe5k9knCdYXxix5/0YzVJb1ZnyLuF2e4AR2w1hohWW6c5urPLR8M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR06MB6539.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(39860400002)(346002)(376002)(396003)(230373577357003)(230473577357003)(230922051799003)(230273577357003)(230173577357003)(1800799012)(186009)(64100799003)(451199024)(31696002)(26005)(6506007)(66574015)(53546011)(966005)(6512007)(2616005)(83380400001)(4326008)(8676002)(44832011)(8936002)(41300700001)(5660300002)(478600001)(2906002)(110136005)(6486002)(66556008)(316002)(66476007)(54906003)(66946007)(36756003)(38100700002)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YkNWbERYTVZISkRsa2VnV0lYSC9RemZLWWVCaHpJR0g5NVMwRTRhSEdCZU5P?=
 =?utf-8?B?KzRmMHNBcXZiU2pGUUZHY0FNUGYraTRWeFRjWXZEWFl2RDhLeERSZlpna1ZS?=
 =?utf-8?B?eG50YUlUVDZLYlFGZXdOWjc3d3FqWHZLSitqcmEwZVdadVFWV2ZGWXZ0SVJ1?=
 =?utf-8?B?M24xOWMySEJENjk4bTNmR3ZxWUhSejFmc3E3YzQ0bjVkNStJVFRGT0VFb3da?=
 =?utf-8?B?bkhSWmd1Y0lTSVg4cFl4QVNEM0ROQ0Y3Q3lRNm9qZkVQSXoyaGE4TU1FZjda?=
 =?utf-8?B?TW1LdlNGS2dZbWxlOStvaWMwNUtDR1pXcDBjVkdJcng4OEFuT3hXZklja1NM?=
 =?utf-8?B?UTJaS1Q1MUEwaEZCT1g0ZnIrVGNlOHdmclFjOE12R0lJc0tRUzZjT29JSERI?=
 =?utf-8?B?Q0h1LzdCWWYxOFVIWlZML0ZjOVRmTldwSVV6bGVOR1dQNlA3N0ljMGxvU2x4?=
 =?utf-8?B?Ny9kalNoNkswU2RNenVaVVFUelhJeGZRT0pNMUZPTy9EWm9PZkhsYXE2dXVl?=
 =?utf-8?B?SmJrMlFYb0Z1WHlwbFBSck1wL1Y4djd4VmkzM3NXMXdHbmxuaUt2MkpERGIz?=
 =?utf-8?B?YWc1ck1DTXpCeGRrbGd0SGsxT2xLNGZuRjBQTllPM21DM2RqUEZLbHh6L2Fj?=
 =?utf-8?B?TTh4WWdkOFBTaFovbXRaTjBBZ0J5SG1sOURJak83dGdSeWRpK29sWHZJV2Yv?=
 =?utf-8?B?MUxKclRwYVJNNDV5bDRVNUpHbHVWaU1mK3FKNXRqeFhFNCs2cXpvdGgyaitp?=
 =?utf-8?B?MjdiMm5NSTdjeE81ei9ubU16U2o0ZGdTenFabWgyeDh0Z3NZQmV1OTBsUGJQ?=
 =?utf-8?B?dzR6MGVsbUpQZ0hiVHJQNkdpdGVnbWpwaWhyeWJrWS9OTTB2T0V0cmNxZkFJ?=
 =?utf-8?B?cGIvU3pXcEdmazZWM2ZIeUlKOXU2cktIYy96V25iU2tVQ0JqU3Rva0xoNWY3?=
 =?utf-8?B?SDhxUzlkL05yNHlKOGYxS29pRXRHT1F1UGIwSWpWVFRHMVZTNktEL0ZoUWR3?=
 =?utf-8?B?Ry96Tk92bklpWVRTUDlFcjUwWnhLY1dmUnpURndKVHZXWUhQOHM0cTQvbXk5?=
 =?utf-8?B?RUV0YzE0dE5hQVBqT0NUYkJHakpVaDdhL0xwbjFtYTFJZCtOYVVobWxxbTl4?=
 =?utf-8?B?VXlZc3orL3doaDF4cHh3eGlHZTJ6YTBpUjBrdjhLVGhMWlppSm5LZTZMbWt1?=
 =?utf-8?B?cUlQUWg0QnYycUpTd1lCZVFnZVgxTDhNK09XNVVmN2hoU3hORjBGRXltTVdO?=
 =?utf-8?B?MlpuSld4T1Jab2xZOEYxajd3VWhPSFR0aTJ4bXZEbXJEczBYZlZwRHhlM3J3?=
 =?utf-8?B?UmVCWG5kNExlOFpzZDREQmZzUkNvNFZLckJ3VWZ0ZVQ5aTZlSVVockxqdlZE?=
 =?utf-8?B?cUNkMjFLQ0Q1Zk44Z0t6enE0djZrY3VEalNCNjQ5eXNrcVFydmZ5Qm1McXhV?=
 =?utf-8?B?Z3ZqN1p5bDRTcEhJS3lLVVBTNEU0QUZsTjFwNEdwdXJKV0c1cnZaTDdJd1hl?=
 =?utf-8?B?MStTTUMwSSt4Sno2am9jWHFUckRaM1BjMy9FTERzYWxzVHdOQ2RCdFVmWW9h?=
 =?utf-8?B?SDNHWFNNaWs2V1p0azNSUGM4NjcwWFdtVDZra0hGSXorK1pJNlhwM1RqYVE2?=
 =?utf-8?B?ZkFkdVlaT25FMlN5Mms1Ui96bXlGNWZNQ0FkSVpwS01zcnlFRUVVVXYwcmQw?=
 =?utf-8?B?NkZhaEt6U3hjVUROeGgvVEgzYmdnRHNoUW5NRTlZb0VoUUhvakl2VTNkVTJz?=
 =?utf-8?B?VUZaYW4vN21sOU5GaFV3SXFYRk83d0NPYStLSXJiMTJlanVRMFJqeTlYbVNu?=
 =?utf-8?B?anZRNDJ3ZFZwbUo4SmtuVkJDOE15SFVjTFBOK3dNcE5DbWJSWitGV1RpbEFY?=
 =?utf-8?B?cmFrakRmRDZjaVNHTGw3ajR6a0U2WnJTZUdacDI4a1Y0VDBtTktjWVVQelp2?=
 =?utf-8?B?ZGRtQjU1MVVDQ3VpU1RXWi9BLzNQMlNmSmtNd2VJKy84aEtFK2tiUDJaZm1D?=
 =?utf-8?B?dEJYM2NrQWRSNDdvd0dvSlFxQmoyMXZyUTRhbE90ZGFvaFY1eVFjcW1zK3hs?=
 =?utf-8?B?Ym9NQWc5WDNwS1I5RkpEemZ5SjlRTGpEcE1zU2Z0dHJNVDM4S0VodGZmL3Vl?=
 =?utf-8?B?RElwUVJZbVBJR2tmdG9OWFhtL1hGZVNZR2hLT0s3WDRnOVY1VU53dlJxcUht?=
 =?utf-8?B?M0E9PQ==?=
X-OriginatorOrg: raritan.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86d51bd4-11b0-4e6f-0cb7-08dbf1d34b3d
X-MS-Exchange-CrossTenant-AuthSource: DB8PR06MB6539.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 18:36:40.6815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 199686b5-bef4-4960-8786-7a6b1888fee3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nyYlZeJWZxWjtoLlT66HSAlKkXBGXQqb4a4meQ2ZK9zorPIs46CDXmAPJO14/vBruEKXKySloNtRTekIJzY9tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR06MB8412



On 30.11.23 19:26, Richard Weinberger wrote:
> [You don't often get email from richard@nod.at. Learn why this is importa=
nt at https://aka.ms/LearnAboutSenderIdentification ]
>
> ----- Urspr=C3=BCngliche Mail -----
>> Von: "richard" <richard@nod.at>
>> An: "Miquel Raynal" <miquel.raynal@bootlin.com>
>> CC: "Ronald Wahl" <ronald.wahl@raritan.com>, "Mark Brown" <broonie@kerne=
l.org>, "linux-spi" <linux-spi@vger.kernel.org>,
>> "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>, "Ryan Wanner" <ryan.w=
anner@microchip.com>, "stable"
>> <stable@vger.kernel.org>, "Richard Weinberger" <richard.weinberger@gmail=
.com>
>> Gesendet: Donnerstag, 30. November 2023 13:46:14
>> Betreff: Re: [PATCH 1/2] spi: atmel: Do not cancel a transfer upon any s=
ignal
>
>> ----- Urspr=C3=BCngliche Mail -----
>>> Von: "Miquel Raynal" <miquel.raynal@bootlin.com>
>>> + Richard, my dear jffs2 expert ;)
>>
>> :-S
>>
>>>
>>> ronald.wahl@raritan.com wrote on Mon, 27 Nov 2023 18:54:40 +0100:
>>>
>>>> On 27.11.23 16:10, Ronald Wahl wrote:
>>>>> On 27.11.23 10:58, Miquel Raynal wrote:
>>>>>> The intended move from wait_for_completion_*() to
>>>>>> wait_for_completion_interruptible_*() was to allow (very) long spi m=
emor
>>>> y
>>>>>> transfers to be stopped upon user request instead of freezing the
>>>>>> machine forever as the timeout value could now be significantly bigg=
er.
>>>>>>
>>>>>> However, depending on the user logic, applications can receive many
>>>>>> signals for their own "internal" purpose and have nothing to do with=
 the
>>>>>> requested kernel operations, hence interrupting spi transfers upon a=
ny
>>>>>> signal is probably not a wise choice. Instead, let's switch to
>>>>>> wait_for_completion_killable_*() to only catch the "important"
>>>>>> signals. This was likely the intended behavior anyway.
>>>>>
>>>>> Actually this seems to work. But aborting a process that has a SPI
>>>>> transfer running causes ugly messages from kernel. This is somehow
>>>>> unexpected:
>>>>>
>>>>> # dd if=3D/dev/urandom of=3D/flashdisk/testfile bs=3D1024 count=3D512
>>>>> ^C[=C2=A0 380.726760] spi-nor spi0.0: spi transfer canceled
>>>>> [=C2=A0 380.731688] spi-nor spi0.0: SPI transfer failed: -512
>>>>> [=C2=A0 380.737141] spi_master spi0: failed to transfer one message f=
rom queue
>>>>> [=C2=A0 380.746495] spi-nor spi0.0: spi transfer canceled
>>>>> [=C2=A0 380.751549] spi-nor spi0.0: SPI transfer failed: -512
>>>>> [=C2=A0 380.756844] spi_master spi0: failed to transfer one message f=
rom queue
>>>>>
>>>>> JFFS2 also logs an informational message which is less visible but al=
so
>>>>> may rise eyebrows:
>>>>> [=C2=A0 380.743904] jffs2: Write of 4164 bytes at 0x0016a47c failed. =
retu
>>>> rned
>>>>> -512, retlen 68
>>
>> Ugly kernel messages are a normal consequence of killing an IO.
>> Chances are good that we'll find bugs in the upper layers.
>>
>>>>> Killing a process is something to expect in certain cases and it shou=
ld
>>>>> not cause such messages which may create some anxiety that something =
bad
>>>>> had happened. So maybe the "kill" case should be silent (e.g. level
>>>>> "debug")
>>>>> but without out hiding real errors. But even when hiding the message =
in t
>>>> he
>>>>> SPI framework it may cause additional messages in upper layers like J=
FFS2
>>>> .
>>>>> I'm not sure whether all of this is a good idea. This is something ot=
hers
>>>>> have to decide.
>>>>
>>>> ... and now I just got a crash when unmounting and remounting jffs2:
>>>>
>>>> unmount:
>>>> [ 8245.821105] spi-nor spi0.0: spi transfer canceled
>>>> [ 8245.826288] spi-nor spi0.0: SPI transfer failed: -512
>>>> [ 8245.831508] spi_master spi0: failed to transfer one message from qu=
eue
>>>> [ 8245.838484] jffs2: Write of 1092 bytes at 0x00181458 failed. return=
ed -5
>>>> 12, retlen 68
>>>> [ 8245.839786] spi-nor spi0.0: spi transfer canceled
>>>> [ 8245.844759] spi-nor spi0.0: SPI transfer failed: -512
>>>> [ 8245.850145] spi_master spi0: failed to transfer one message from qu=
eue
>>>> [ 8245.856909] jffs2: Write of 1092 bytes at 0x0018189c failed. return=
ed -5
>>>> 12, retlen 0
>>>> [ 8245.856942] jffs2: Not marking the space at 0x0018189c as dirty bec=
ause the
>>>> flash driver returned retlen zero
>>
>> jffs2 has a garbage collect thread which can be controlled using various
>> signals.
>> To terminate the thread, jffs2 sends SIGKILL upon umount.
>> If the gc thread does IO while that, you gonna kill the IO too.
>>
>>>> mount:
>>>> [ 8831.213456] jffs2: error: (1142) jffs2_link_node_ref: Adding new re=
f 28b
>>>> d9da7 at (0x000ad578-0x000ae5bc) not immediately after previous (0x000=
ad578
>>>> -0x000ad578)
>>>> [ 8831.228212] Internal error: Oops - undefined instruction: 0 [#1] TH=
UMB2
>>
>>
>> I fear this is a jffs2 (summary feature) bug. Chances are great that you=
're able
>> to trigger the very same using a sudden loss of power.
>>
>>> It's not just spi-atmel, any spi-mem controller might be tempted to use
>>> interruptible^Wkillable transfers just because the timeout values can
>>> be really big as the memory sizes increase.
>>>
>>> One solution is to change the completion helpers back to something
>>> non-killable/non-interruptible, but the user experience will be
>>> slightly degraded. The other would be to look into jffs2 (if it's the
>>> only filesystem playing with signals during unmount, tbh I don't know).
>>> But maybe this signaling mechanism can't be hacked for compatibility
>>> reasons. Handling this at the spi level would be a mix of layers, I'm
>>> not ready for that.
>>>
>>> Richard, Mark, what's your opinion here?
>>
>> I *think* we can remove the signal handling code from jffs2 since it mak=
es
>> already use of the kthread_should_stop() API.
>> That way we can keep the SPI transfer interruptible by signals.
>> ...reading right now into the history to figure better.
>
> After a brief discussion with dwmw2 another question came up, if an spi t=
ransfer
> is cancelled, *all* other IO do the filesystem has to stop too.
> IO can happen concurrently, if only one IO path dies but the other ones c=
an
> make progress, the filesystem becomes inconsistent and all hope is lost.

This sounds very logical. And as far as I understand a user space action
like
killing a process should not be able to trigger such a scenario. I think
this
is the reason why filesystems typically rely on uninterruptible transfers.
As I showed with UBIFS the filesystem immediately mounts the FS in read-onl=
y
mode when a transfer is canceled.

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

