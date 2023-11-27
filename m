Return-Path: <linux-spi+bounces-46-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0247FA425
	for <lists+linux-spi@lfdr.de>; Mon, 27 Nov 2023 16:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24E48B20FD8
	for <lists+linux-spi@lfdr.de>; Mon, 27 Nov 2023 15:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7413D3175C;
	Mon, 27 Nov 2023 15:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grpleg.onmicrosoft.com header.i=@grpleg.onmicrosoft.com header.b="B9hp8hUP"
X-Original-To: linux-spi@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2099.outbound.protection.outlook.com [40.107.104.99])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED4BDE4;
	Mon, 27 Nov 2023 07:10:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CXItKOvDbMyu+sqUsC4vac44KRNSUgqO4GiOvECgDTQyDyunUNzernIUN434TVkz84m0wqgvZShXtG1lQ+Uhqa1qD9jURGUQwYlmzK6DnZ/OioeIRl7Y/OzgZ08jwqRsZaQxa3X8TXj2GLfaxbinTz+USDBr/6TNegHf9DH91s+XDiNZ67IPex6PZjnK+/0FXz0zFKzaDTd7F6GC1BoNo1zscahPCficgDsKf76QhmZpcT6OqngKAaG5pvXZ8NHOn4EtgomcpAwwJxhYS++PtsOGZp6j2zFymA5rSMh5Q+zekf7KTAfYWm++6k4wFUIvZUo6K8yj6oFacSgsTXXzKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mzG39pOOH5gEzp/kfgX3idU4DUk2XJeS7WlfhRA8YEs=;
 b=MuOw1GKbTxgvytgOOjbbr49xodyJa0l9tNP4//oja5Jj43g914MjWYPCQDHaqe2Op3j1NWHOiqQ3RHs5Ws6BnSCVm57w+eaJ8gmjpuNKD8vFqmtiy30RCjyduTv0uOTNVvqxsBFjWy+t2MXdAdNC5ECcPxiePKQIJlEl2owNDTLr7B4xlCGUQXgDm+sceUUbN9T/aplV3iRF16DRa+nWGOlgLxioyue5zCnATCnAhE4ckb90NgEwHEQ0s1YwrxtfIDqBzgIjIIifpskIPcRuAUy55wLnA8nbPA1i6DYK7cT31Hpffg2E1kkXbrb7+QxSXzkyA4Et/6ImqNBSAxC72Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=raritan.com; dmarc=pass action=none header.from=raritan.com;
 dkim=pass header.d=raritan.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=grpleg.onmicrosoft.com; s=selector1-grpleg-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mzG39pOOH5gEzp/kfgX3idU4DUk2XJeS7WlfhRA8YEs=;
 b=B9hp8hUPbLnJVYxWM/QA/4BfdguWrUvAqE05x6iOyQGM7j1sEwFSyE7iNmHyS/8/g3IhUPDLNlJa+UdGkuwhgxSa2oqMqea037vXrjfhKv3WYnuvB68l3RLy6cOtMqNi5D3QSVeqPgBrwC7HbEYW+p8jvI25LkyKRgu0/2/6JWM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=raritan.com;
Received: from DB8PR06MB6539.eurprd06.prod.outlook.com (2603:10a6:10:12f::23)
 by PA4PR06MB7181.eurprd06.prod.outlook.com (2603:10a6:102:f5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Mon, 27 Nov
 2023 15:10:30 +0000
Received: from DB8PR06MB6539.eurprd06.prod.outlook.com
 ([fe80::98dd:e9db:b7d8:9001]) by DB8PR06MB6539.eurprd06.prod.outlook.com
 ([fe80::98dd:e9db:b7d8:9001%3]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 15:10:30 +0000
Message-ID: <a90feacc-adb0-4d7d-b0a4-f777be8d3677@raritan.com>
Date: Mon, 27 Nov 2023 16:10:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] spi: atmel: Do not cancel a transfer upon any signal
Content-Language: en-US
To: Miquel Raynal <miquel.raynal@bootlin.com>, Mark Brown
 <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Ryan Wanner <ryan.wanner@microchip.com>, stable@vger.kernel.org
References: <20231127095842.389631-1-miquel.raynal@bootlin.com>
From: Ronald Wahl <ronald.wahl@raritan.com>
In-Reply-To: <20231127095842.389631-1-miquel.raynal@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0004.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::14) To DB8PR06MB6539.eurprd06.prod.outlook.com
 (2603:10a6:10:12f::23)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR06MB6539:EE_|PA4PR06MB7181:EE_
X-MS-Office365-Filtering-Correlation-Id: efc1262f-1067-4e36-740d-08dbef5afec4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4e2unA58RvbtLB6nvDJlnPL2rP8uFObxZt2YysnSkEaUMOIbKJHi5flyLA6M9mwNoK2rwc39OL3r/IwZyZTRD2KiTz2KaViUtNpKbeWfZtVVY1PRrm9c9Fmgsfu2Nv8TxRd0PY5Z07N0JjqmvypSt62T5Dq+LEy+ulZkksMDk11sB2n3KcbAqs8alO5k1nX/UfQ/WSaV24LfFkWPRJjQzx2W68THOPZabqN75EbOcjdxKOuZDyaBvrBoY4IKC8VaphpCz4ZZR5vFdFnSe0jeAR6UYJ662Z7R1cN+AYBZfnxMMDXpJS4rvkQ9VdGPLT3Qn7SmCDUZqEcYufUg0lSrixv5ch8uIvL3LkpSoggq1TmIyjh5v/QJx8Y38jPnDFJTwMqggrWwOe/dWCelqnoOOh83MkSL625BjaoRlh2423gPC7394WDrVN+Jp/7aXEw+LIYTwGk5Ce54rvFkP3PZoUNs+QxhV5++np/ufJcRrjWDY27Lc8XVPMbcm346FzBvdramrNbYHX64aVeTvEV9eFyew5sTc6lW3Waw+kYVuRdffFdUck1n1laLH4nokBE7vcPwqRN8n6VRoKJhUUQfTq1KOFvNPU8TPHmwHuHzFu/AqTAWZA9VDeENzmkLbXL8+MPGxHYxLrVKzNzh2XcpsQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR06MB6539.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(346002)(39860400002)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(8936002)(8676002)(4326008)(6512007)(6506007)(53546011)(66556008)(66476007)(110136005)(66946007)(54906003)(316002)(6486002)(478600001)(36756003)(38100700002)(41300700001)(31686004)(86362001)(26005)(44832011)(31696002)(2906002)(2616005)(83380400001)(66574015)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WFpqRzk5Z25LNzJ1SnRDNTh0azVHK0kwcWVZZWgvVlZGc0w2SG1wWkdqb3Np?=
 =?utf-8?B?NndnREdPNmFGeXhVWjd3NGxIaHZaTUlRSHRNTkoxS3BJRm5uT2JWZDZ2aWV0?=
 =?utf-8?B?Qy9Obnh3aThQTTRuOUlFVW5FcC9rd3prV2d0VlJVamV6cHh6dlU5TlNOaS93?=
 =?utf-8?B?NjJkam1nL0hMM3NnalkyNjB4VXZNQ3VsN3Y4aWVnbTBLMmZFZ1h5bHhDaXZr?=
 =?utf-8?B?MVA3UHVSbDVBbGUyVDZTd2l1SVIxdTdHM1BoZ24rRlhzdjY3MFFUSVpqZEdW?=
 =?utf-8?B?dk4wZlFQY3VPWW5Hdnd4dzc4MnY4QWFJN1o4WnVmeGtqZHp3N25hSVhoQ0Fa?=
 =?utf-8?B?a2FFN2JGRWxxT01HSHdybWs0bitwS3EwTG5pSUIvRVhiTEJkVTVSYVhDZW1S?=
 =?utf-8?B?RVk0SDFLMUZ5TGhwT0VLcG5QMVhDRUZVcXhtVjBMQ0RoMTdUWnZYbWRMZTE3?=
 =?utf-8?B?MjBQbFUweit5dDA5VHZXSWF0YVBWMlNsVXM4cnlWSHRyang5cVExUVo5YVdO?=
 =?utf-8?B?cFVvYitKQXFrSU9DSmVYNGs1WUhXOUNPcHRFR0wvRVFaZVc3eTVWUkt5TUJs?=
 =?utf-8?B?QkhRM0t2WFdZZHhtSEdkUUxSMVZXMzFrQjFQTzVBT2MrdklzbzdNNThYK0Jo?=
 =?utf-8?B?L0ZseVYzTEdCcTFiQzgyWktKUGZ0bEk2K0NpY2hpSEFmSE1JY1NNNkRlS1lV?=
 =?utf-8?B?R2t1TEhYVVg5WmlHQmFyZnRvZjFyRmQ5VXVJU1hFaXB4MkxPQ3dZcWxDOUt6?=
 =?utf-8?B?R0sybmZFYStUT0pIRjVCOFZhVGdJN05tQm5LNUVNMlNLUWpNNUZuWWEvTU16?=
 =?utf-8?B?VVZQN0pWYkZFLzRIbi9GU3J3bjRpM1JvWjArSnVBUjV0NFlpUVhZalNwMHVi?=
 =?utf-8?B?NFh1UUpnTTFlN2VmUThFcDVRQWtST3VCbHNzcFlVSlpvUnlNSFY4c0ZYelRO?=
 =?utf-8?B?ZUVpK2ZaVW84S2lBbnczL3JvbTQySXRUTFoyMkw4R01tNVY4ZkZCcU5oY01N?=
 =?utf-8?B?SWE0TkF0dldLTmV3OVRWdGJISVBza3dnS2tpbXgxRk44VEdmVUo1anRZa1Yv?=
 =?utf-8?B?d1JncVRqUERUQ085U2lwLzFWR3lYTThqUmN0M21nVVUwMjZEVGowQXBCTlpZ?=
 =?utf-8?B?aXlyQzUwa3MrbW4wWUl5YkdJamttQktRNHEwMkJHQWZNYndMY3ZGSC9lMDlh?=
 =?utf-8?B?dzhqcitNTkc1N1dyTTA4cWhwMHNESXVxTGh2ZzZpNDR3c2owcldlWmZVckZz?=
 =?utf-8?B?eTRkSWlhejJHbVplcTFoUlVrZThncXNheUF3STl2RFRkT3FhUGlUNDljVTJS?=
 =?utf-8?B?WjhKRG4zTDRtY200dnlkYXMxbHZacytpOUZjdloyV0d4VUcvbzRjck9mSFFy?=
 =?utf-8?B?SjQ5eTkxNmhYWU53L3c3S1VFaE9hTUlHa2tVaktKaFJreUlvRXkrMU9NSUtx?=
 =?utf-8?B?bjFKendhNHRVdyt1djdWOElaMzBIMVJLb0R2cFB6cjBhYkkzZzJRL1FxUklL?=
 =?utf-8?B?SGRXTVgvUlB6YldxYXgrb0lxTENUc2ZjSmQrSVFYZHJ5Ym9vYnJNRHRkVjV5?=
 =?utf-8?B?TWR0Uy80elpVK2twSjRXV1Z1U2tRY1BuL0VMU2tIRlJuS21xbnVheXhxczU5?=
 =?utf-8?B?cHpvL3VqeitYa3JvaUg3S2J4Nm1oV2pSdjRPRDhxMTlnYlVQK01qbDFXM3FN?=
 =?utf-8?B?MWF0WWMxRnhPc01Yb3FCMTdORzRwajNOMDdiTkFNaFlnQW10c01iaEFTamla?=
 =?utf-8?B?UE1SNHhieWUyRFRkWDFDRlFKaVphRXF1MVlUL1hEZjhpeVdISFZaS0VpWDV4?=
 =?utf-8?B?b3NxSDdFMUQ1aUoyaVNveE12dVVLTDRIUUEzMXljZi80SGpXV3djVlROUSsw?=
 =?utf-8?B?ZllkSUNsYzBMUDJSSmRKeWovSzBmdVVITlc4R1BVQUdUYkdEd0QybVl0d0RH?=
 =?utf-8?B?anBlZGNiSGl1SXRxMnBUQVFzdmJESmFMMVlyaDlPSy9uNWF6alJvVEo2YmU1?=
 =?utf-8?B?T3NicitvQkR1SlFFV1VVNlprYVZNUjlCOE81c05OMVpXbGlGbzVPQndrekFp?=
 =?utf-8?B?cmNYY0lrdStFdEhBTTQ1bXlGeU56cktHKzdDa2xNVk82L3VYQzdaSy8yK013?=
 =?utf-8?B?eE1Ec0M0cTUyMzVRK09yL01LSndNOHhlbHRxVFMyNXlGMUtMU2g1YUMwaGg0?=
 =?utf-8?B?SXc9PQ==?=
X-OriginatorOrg: raritan.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efc1262f-1067-4e36-740d-08dbef5afec4
X-MS-Exchange-CrossTenant-AuthSource: DB8PR06MB6539.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 15:10:30.4784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 199686b5-bef4-4960-8786-7a6b1888fee3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tdzEMEYnq0lKQ+vNvE90BF77v8uf89Ydm249mZI0Iuz7BSNhncg14vQPuFd8il8myQh7qCBafd7/Q9Yn4wIXag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR06MB7181

On 27.11.23 10:58, Miquel Raynal wrote:
> The intended move from wait_for_completion_*() to
> wait_for_completion_interruptible_*() was to allow (very) long spi memory
> transfers to be stopped upon user request instead of freezing the
> machine forever as the timeout value could now be significantly bigger.
>
> However, depending on the user logic, applications can receive many
> signals for their own "internal" purpose and have nothing to do with the
> requested kernel operations, hence interrupting spi transfers upon any
> signal is probably not a wise choice. Instead, let's switch to
> wait_for_completion_killable_*() to only catch the "important"
> signals. This was likely the intended behavior anyway.

Actually this seems to work. But aborting a process that has a SPI
transfer running causes ugly messages from kernel. This is somehow
unexpected:

# dd if=3D/dev/urandom of=3D/flashdisk/testfile bs=3D1024 count=3D512
^C[  380.726760] spi-nor spi0.0: spi transfer canceled
[  380.731688] spi-nor spi0.0: SPI transfer failed: -512
[  380.737141] spi_master spi0: failed to transfer one message from queue
[  380.746495] spi-nor spi0.0: spi transfer canceled
[  380.751549] spi-nor spi0.0: SPI transfer failed: -512
[  380.756844] spi_master spi0: failed to transfer one message from queue

JFFS2 also logs an informational message which is less visible but also
may rise eyebrows:
[  380.743904] jffs2: Write of 4164 bytes at 0x0016a47c failed. returned -5=
12, retlen 68

Killing a process is something to expect in certain cases and it should
not cause such messages which may create some anxiety that something bad
had happened. So maybe the "kill" case should be silent (e.g. level "debug"=
)
but without out hiding real errors. But even when hiding the message in the
SPI framework it may cause additional messages in upper layers like JFFS2.
I'm not sure whether all of this is a good idea. This is something others
have to decide.

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

