Return-Path: <linux-spi+bounces-147-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3E3804DB6
	for <lists+linux-spi@lfdr.de>; Tue,  5 Dec 2023 10:23:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 087841F212D3
	for <lists+linux-spi@lfdr.de>; Tue,  5 Dec 2023 09:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534C63E47E;
	Tue,  5 Dec 2023 09:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grpleg.onmicrosoft.com header.i=@grpleg.onmicrosoft.com header.b="dv8WL+en"
X-Original-To: linux-spi@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2133.outbound.protection.outlook.com [40.107.8.133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB74194;
	Tue,  5 Dec 2023 01:23:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dfEboF0+T8CDGPuESpUCXN0edPQaUbsIOEvxmvSGx3GxXorOeHV+2oc97N/PxnreuZ4tjSW8ftAqd1nvlM0TcLgOG9+sovq+APA5UtYzCPCeHeEzPGjnIQI/s9Vk1w857jjkq3JDIOUpbWPnsXyIwRi6BXmYj/OiHSd0m6W0nNek7l1qJtN0N7AfcWPaab71P6FW2eTm1/Wu4jcSfalfFd0XCBrbDzald6mSfqr2EMJUsRPkRDHu3XoD+p8/Dg58/C/TWRCoj7qPn4bOIVyuWcQmuk3wPG/8f69eR1NOIG+BBZMtPuc4cOe8nQQdXsItWv1Ti5sQJk+NqEecpBV6rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vqMQ8ir5jYTffo81eeZESSaHo7J1wK/lWvEeFg21PbE=;
 b=TQ8pha0oDur7i4zBN+sAbbE4Yy+2oux4N4tWy8eBLJifAXMuqUHdCjcZoi/8EibtycY1DTlakyMqEAlBD1qbSaTK1hNh+KzGnAEvCOBzNSkyoREh+zmS9hmj+DvyiYtDxkzNNtkw391Nobqq8HFy4KgLiHyIDk2Vlcd1i4Lr4Vo8DKRMbP7stVhnuUCvY/WO8IFT1TYCFXoTwC0L+WriX7SLn3kUWgewgExoq/2MKTxtBxwHup5FXefoIXB3Tkjuhba52m/tmdK1D6mr1600voGioIgalQ4DLHE0B8JBOSDgUyjFydqxGRWh1/r6Bzn/vWsXFnGGQeb7VPY3H18mFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=raritan.com; dmarc=pass action=none header.from=raritan.com;
 dkim=pass header.d=raritan.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=grpleg.onmicrosoft.com; s=selector1-grpleg-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vqMQ8ir5jYTffo81eeZESSaHo7J1wK/lWvEeFg21PbE=;
 b=dv8WL+enYeBHmI/4QmFR9YAIhR6bRJU8GQLatHG2iYRHjfd+wr/gdqocTJCvXf6XPPXXJbkzs1JzG70BtMAQYgnFSR/qLhti/jvEOmhjXBIdQOxJeB+O3Ztc+oi2twGimgYPu0ygdBDbpAAv7vzx3RW6GGY4FdgwGyT8q+F1iGY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=raritan.com;
Received: from DB8PR06MB6539.eurprd06.prod.outlook.com (2603:10a6:10:12f::23)
 by AM9PR06MB8036.eurprd06.prod.outlook.com (2603:10a6:20b:3a3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 09:23:23 +0000
Received: from DB8PR06MB6539.eurprd06.prod.outlook.com
 ([fe80::98dd:e9db:b7d8:9001]) by DB8PR06MB6539.eurprd06.prod.outlook.com
 ([fe80::98dd:e9db:b7d8:9001%3]) with mapi id 15.20.7046.028; Tue, 5 Dec 2023
 09:23:21 +0000
Message-ID: <011847b9-fa03-4361-837b-155d58bf0729@raritan.com>
Date: Tue, 5 Dec 2023 10:23:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: atmel: Prevent spi transfers from being killed
Content-Language: en-US
To: Miquel Raynal <miquel.raynal@bootlin.com>, Mark Brown
 <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc: Richard Weinberger <richard@nod.at>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Ryan Wanner <ryan.wanner@microchip.com>,
 David Laight <David.Laight@ACULAB.COM>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
References: <20231205083102.16946-1-miquel.raynal@bootlin.com>
From: Ronald Wahl <ronald.wahl@raritan.com>
In-Reply-To: <20231205083102.16946-1-miquel.raynal@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0256.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::9) To DB8PR06MB6539.eurprd06.prod.outlook.com
 (2603:10a6:10:12f::23)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR06MB6539:EE_|AM9PR06MB8036:EE_
X-MS-Office365-Filtering-Correlation-Id: b95e514a-1f82-4c0b-56dd-08dbf573d2d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	od7VrpUTWFTgqCFFxst2I185iRxzP7NWM8Ur+zJJF/VEnQuH9t3GYuTfZOHcnZ50+dpx95HF8GzBwMz3H+4+6SaoxRaqPQSSb5GyHpAsCnfqMWk8axpWkd9pYa33BjWGYHz6zjdaPfkSsQ2DxVNDOS9jY6nYgEQYKYSEWWhvtwk0TG8/iqX7Y/wvS3LWHFYr42lWdSBAbcMXRilP351oonJIPqCyH/8LCTs7uV1K6QH4tTNVubpeihwJpiRHJVCJOY0Pem7WAeSGUTBZz4/xcYpmwMYhrVthqgXfyeh/NLwgp8f+ag0n1GG7TX0Gy1v8kRntH/Ou2K1DLLs0XGq7rHkilOnn53MfPHsmszJe+SpZh5+K1wcorX21q6h1Zha3lxQSmsfoj0ZUPCIXJf4NwRjGLSIjIXN3SX9EIlhSkSTVkUlz6dEld8IExALP+gyMasqAlm3BKLUib4hboVhc1b3HdzRyv8z8n98o/lknmrOdSFmlx0uz1mJYLX+AIFIJhy9Qg1f87O5SuH4d48gI6lKTb5w6PkbXQZarHIg+vaX/V/nPCz+M+iTNjlOx+Q5wTfeaoVJG90Tq79DtXPsAs2zmQVTxNkLWa1+ujEzbd6UYvQnHVq9Sk2G/T87Vh1sx
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR06MB6539.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(136003)(366004)(39860400002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(6512007)(26005)(38100700002)(83380400001)(66574015)(31686004)(6506007)(2616005)(53546011)(6486002)(478600001)(966005)(66946007)(66556008)(66476007)(54906003)(110136005)(316002)(8676002)(8936002)(4326008)(2906002)(41300700001)(36756003)(44832011)(86362001)(31696002)(7416002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aG1qYU5uQXV3dnlTSmNZWXZNRlJuQm10NTZGNlQ1alFZZ0p1NGNiejFYdEo5?=
 =?utf-8?B?VTArdmI2NXBJQ1VjLzlhclpsb0szWFFFbG1hNXA3eFVKQm0ycXpJVGtZVW8w?=
 =?utf-8?B?bmw4RlhYd0xpM2pzbEV2UFNWRmdLejdRMmIvRUxKa1dZaW1xL01WcVluM2VM?=
 =?utf-8?B?dE90amJ2WSsyc1VRSzBGd0dId3grQzkyM1IyY0hGbFh5Z20yOFp6aTV0eldI?=
 =?utf-8?B?YlF6cUx5azNmMzM3cTIrZEFXRmpXV1ZTNHZnYVc4cHMxMmE1N0w0emZ5QWlD?=
 =?utf-8?B?dTBPS2pWOWx6R2VKbzUzTEpqL2UxOEN6YVVPaWFHMktoUWZOOHVoQjRQMVdE?=
 =?utf-8?B?Q0tOcDlybTFkeVNLb3RmS3d4dEkvZG5meWZBYkNqYjloY1ZwUXBYZHdOUGRH?=
 =?utf-8?B?MG5VYTdkdys3NWhFMUhyUSsyOTBTYW9JbXRmTGh3K0gyNm1UNElPRjM3OHFJ?=
 =?utf-8?B?L0tFKzBrYng4S2R4NHpqYlg1Y0VzUWxwWGs3aEp2RGVTOG1tL0RmN09yY1gx?=
 =?utf-8?B?ZTdESVkwVEZvT2dVUnBhaFhmR2twRmRCSGdBcW1GTTQvUlRSVmRiKzZKT1pn?=
 =?utf-8?B?eW1sUzVZM3NuQXo3Z1ZiUHNDWWR0QTZMSGJndnkrQVBMQ0NTaEJvUFJtZzNJ?=
 =?utf-8?B?QkR4TGFOamRRS3NUS2dvZ0NYS0hnK2RDdDAxZEplcFhQWHZDVml2eHZFWTVk?=
 =?utf-8?B?aDhOOHMxS2xlVU9CVWREa1k0dVJkbmk0MnZDc2djSTBWUDFWWnBMMnlQbnNa?=
 =?utf-8?B?SFFUbklwV3RFdDIwMWkzQWlFT3dhb2VhejdvY1lqWmY5YXVTODJ4U1F1N3JO?=
 =?utf-8?B?QW1PRHJrbXBCQjM3WEFoc2hKS2pUNVIrZWV1dVBZcitqSHc3c21KUFMwR3hj?=
 =?utf-8?B?eDdtdE81M2xoK0c3VlNXZDRINFFsUEhVUkNyMDJ3VmQ5YTZMeld4Z0QrZXRV?=
 =?utf-8?B?NzRRWWR5dGJYK3c0clV1TUI2YlNWWEZZQWFONlJkenFhSE1vQ2t5cm9KM1VV?=
 =?utf-8?B?Qld2Q29JdEN3YjU1QWJZWDloTWZnSEdtbE8rR0VJckk4MzhFbE5lbzJqdDhw?=
 =?utf-8?B?ckYwaW1RZGNJenM3blB6NEp5UE1INTBleGxPREt3eThVWng5R3dzVnJTekV6?=
 =?utf-8?B?Vjl5ZldYUmFHQzB3Q2xWRWt5Y29BV2N5RHNCbG5reDBCVE9IM1FnVWVoWlBs?=
 =?utf-8?B?TmkyY3kxb2lEekhtcHExbnh2bm9JMnFMT2xFbjNUcHR3bENNS2N0R2dGby9s?=
 =?utf-8?B?V2pmR3hqV0c0VjE5OEtLYmtyUlFDelhGaHR2U3YvY2V3NUlSSERJdkZ0OHE3?=
 =?utf-8?B?L1ZVeWljTUxJREsvQWl0SThuV005bGFmQTEvOFFtN0l1a3hDZ0thVDRiVFdy?=
 =?utf-8?B?cnZFdmRhZ1BPKy9aRm94N05uRWJHaENrUnV1UldpWFlCWTdBd09QZG42MWJR?=
 =?utf-8?B?VmpCS2tsRURzK2lUdXhRTmZ2aWRGR1QvOEhaT2F6bW5BbkxhejZrSFVwN1Zv?=
 =?utf-8?B?d2N5Mmg3STlBdzg1RjRFOVQ2RnVYdThzNlJwVmxTTHpGSXV2R21lYWtmb0Jq?=
 =?utf-8?B?cVVHVzVmT2Zhb05EaWZ0R2ttSWI1aTI4UlR0cU1BVU9GMno5MDQ2MUlvMytm?=
 =?utf-8?B?ZGRzeEZwTEgxRm5zT05XNFNHTEtSQUgvcTlHMGRzb1NwUDRWSEwwUnFOa2Zj?=
 =?utf-8?B?RmlVWWJHbTJGdmJZQVl5RndXQ3hQcTd0Wm05bU1IZXZCYXhOVzlPaXZYTFYx?=
 =?utf-8?B?QXh5OWtkN0RYVnRHdUlyV1lYR3hqQng4Q2dHT1hTb0M2OXBweUZpOWlVeGZa?=
 =?utf-8?B?TGVNZHhEamhjaTUrMWpEV1VqVncrM0JDUFFjY0VHd2dpeFJNMGpQTmRDSFVz?=
 =?utf-8?B?QTErcDk4enlnMEhWWnB2Y1FMdkdVRWdMMm1WUGpFai85UkV0ZjBXdHEvdTRt?=
 =?utf-8?B?SVVqVG8vaFBQTWZxVW1LZkdvdmVhYnMrRjhlcEMxbkltOEtocm9LVXdqRHQ2?=
 =?utf-8?B?ZytFWlVyUE84Sno2MUljSk4vTmhqbVQwY3BobzRRTDdwYUQ5aHBKMUVxcFJi?=
 =?utf-8?B?L2FNeXI2a0taelo5ak5iOXVPVlJWYmtFVk5NL0NValE5b0RVUzNodTg5RFVa?=
 =?utf-8?B?bkJvN3FpOUd1b29LMXZCaEVMc3VROTV4YzFvcDErQzFmd3VjMVVEZ3V1N3lt?=
 =?utf-8?B?OEE9PQ==?=
X-OriginatorOrg: raritan.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b95e514a-1f82-4c0b-56dd-08dbf573d2d9
X-MS-Exchange-CrossTenant-AuthSource: DB8PR06MB6539.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 09:23:21.4135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 199686b5-bef4-4960-8786-7a6b1888fee3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DL5W/+GT7u+DmNbPPlwrfH263+Qn+CFQvrzLnx/P78l9mdsfLqRRI/rV0UELMYEHJl5GDmsS7jPMB6NuomGqnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR06MB8036

On 05.12.23 09:31, Miquel Raynal wrote:
> Upstream commit e0205d6203c2 ("spi: atmel: Prevent false timeouts on
> long transfers") has tried to mitigate the problem of getting spi
> transfers canceled because they were lasting too long. On slow buses,
> transfers in the MiB range can take more than one second and thus a
> calculation was added to progressively increment the timeout value. In
> order to not be too problematic from a user point of view (waiting dozen
> of seconds or even minutes), the wait call was turned interruptible.
>
> Turning the wait interruptible was a mistake as what we really wanted to
> do was to be able to kill a transfer. Any signal interrupting our
> transfer would not be suitable at all so a second attempt was made at
> turning the wait killable instead.
>
> Link: https://lore.kernel.org/linux-spi/20231127095842.389631-1-miquel.ra=
ynal@bootlin.com/
>
> All being well, it was reported that JFFS2 was showing a splat when
> interrupting a transfer. After some more debate about whether JFFS2
> should be fixed and how, it was also pointed out that the whole
> consistency of the filesystem in case of parallel I/O would be
> compromised. Changing JFFS2 behavior would in theory be possible but
> nobody has the energy and time and knowledge to do this now, so better
> prevent spi transfers to be interrupted by the user.
>
> Partially revert the blamed commit to no longer use the interruptible
> nor the killable variant of wait_for_completion().
>
> Fixes: e0205d6203c2 ("spi: atmel: Prevent false timeouts on long transfer=
s")
> Cc: stable@vger.kernel.org

Tested-by: Ronald Wahl <ronald.wahl@raritan.com>

> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>   drivers/spi/spi-atmel.c | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
> index 0197c25f5029..54277de30161 100644
> --- a/drivers/spi/spi-atmel.c
> +++ b/drivers/spi/spi-atmel.c
> @@ -1333,12 +1333,10 @@ static int atmel_spi_one_transfer(struct spi_cont=
roller *host,
>               }
>
>               dma_timeout =3D msecs_to_jiffies(spi_controller_xfer_timeou=
t(host, xfer));
> -             ret_timeout =3D wait_for_completion_killable_timeout(&as->x=
fer_completion,
> -                                                                dma_time=
out);
> -             if (ret_timeout <=3D 0) {
> -                     dev_err(&spi->dev, "spi transfer %s\n",
> -                             !ret_timeout ? "timeout" : "canceled");
> -                     as->done_status =3D ret_timeout < 0 ? ret_timeout :=
 -EIO;
> +             ret_timeout =3D wait_for_completion_timeout(&as->xfer_compl=
etion, dma_timeout);
> +             if (!ret_timeout) {
> +                     dev_err(&spi->dev, "spi transfer timeout\n");
> +                     as->done_status =3D -EIO;
>               }
>
>               if (as->done_status)


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

