Return-Path: <linux-spi+bounces-125-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1280803327
	for <lists+linux-spi@lfdr.de>; Mon,  4 Dec 2023 13:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D36491C20968
	for <lists+linux-spi@lfdr.de>; Mon,  4 Dec 2023 12:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C159F224EC;
	Mon,  4 Dec 2023 12:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grpleg.onmicrosoft.com header.i=@grpleg.onmicrosoft.com header.b="h18MxAXI"
X-Original-To: linux-spi@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2091.outbound.protection.outlook.com [40.107.7.91])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F10AA;
	Mon,  4 Dec 2023 04:39:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ARIUeQKGMQLTQ/VZ4Zmv4H7IajeWMIRpk9BcptZPJ73Qt6N1zki0Z8oP6h/7QXtQycoQVerl2CJxcb3FESUxlGdnxfnuTAwXJkgPn177uStXAwyJSejBCWulzDCiYJKFtOZcab55gFsi/wtK7Qvl6+7nvRlxc7BGzhal20I5iWXPgw5eSSk5UfoJlicjZ2Goveq4Llcv/hUGPqnit41ET7T6zcvGXy360dCHEsnrAcjC4OOHiZpehR2nPt2Gfyra9N+IzAa9bdcz8enPofecqIAXG+D4Qavep0i37iVhZ7Htpu2mxzaKmFHtGVHQs1ps0aaNzUhAvaWBZNWxg7Z4qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8IzhnmkV5N02rHYOsDijOAPkBTTy1pCUUmgS9RrXMLU=;
 b=frgEXsCCoMQflaVzQhd0qeyhut3X9StgKleY+ZvgpBNA90kTiJ/ltoILM12vjGQln8ClRipo+kCKYjPbdjqJOk/PAnA6IbhtWfdFujgJCc2HRFx1ulnNcGhVOh0Qzrc9wSCgTPM8ITJiMEFkRVneXtGY6SazydYn91YwBT5XIiFoQenOwAqEfBWMYg7FIFvvbnKzyuN2HwUVuoYVl8l2fwonK3RLuaDC+4gLGSfILWU72y0tbXc2pStr0WuR0mIw617pNx1SJbtkZ9x16/3sonpob59dC8DuZYotf4XnmPMs3woKX0FWoMvCHGLKyVku+0nczZQFmbV+Y/OWDtMCnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=raritan.com; dmarc=pass action=none header.from=raritan.com;
 dkim=pass header.d=raritan.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=grpleg.onmicrosoft.com; s=selector1-grpleg-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8IzhnmkV5N02rHYOsDijOAPkBTTy1pCUUmgS9RrXMLU=;
 b=h18MxAXIoZhgivH405s+RibUKMXNGRv6Vbwi1WYqiJix5zUM0ZAiPgzT2BBogD6Fcmwuvzu8dFeIJ5LFcJipShCV83KFD68KGfIYeKHYXxeQ5BVgGIHD8AQ3z9cwLvWsGtR7kd6FwdX8D7Ovvzu/WzP+8X+qZaa9Kz3mzM4n6t4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=raritan.com;
Received: from DB8PR06MB6539.eurprd06.prod.outlook.com (2603:10a6:10:12f::23)
 by AM7PR06MB6817.eurprd06.prod.outlook.com (2603:10a6:20b:18e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 12:39:48 +0000
Received: from DB8PR06MB6539.eurprd06.prod.outlook.com
 ([fe80::98dd:e9db:b7d8:9001]) by DB8PR06MB6539.eurprd06.prod.outlook.com
 ([fe80::98dd:e9db:b7d8:9001%3]) with mapi id 15.20.7046.028; Mon, 4 Dec 2023
 12:39:48 +0000
Message-ID: <9221ba01-ae23-4dff-9736-01567de53f36@raritan.com>
Date: Mon, 4 Dec 2023 13:39:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] spi: atmel: Do not cancel a transfer upon any signal
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>
Cc: David Laight <David.Laight@aculab.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, linux-spi <linux-spi@vger.kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Ryan Wanner <ryan.wanner@microchip.com>, stable <stable@vger.kernel.org>,
 Richard Weinberger <richard.weinberger@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>
References: <a90feacc-adb0-4d7d-b0a4-f777be8d3677@raritan.com>
 <0ce4c673-5c0b-4181-9d8b-53bcb0521f3e@raritan.com>
 <20231129094932.2639ca49@xps-13>
 <723263313.45007.1701348374765.JavaMail.zimbra@nod.at>
 <1192504136.46091.1701368767836.JavaMail.zimbra@nod.at>
 <20231130211543.2801a55b@xps-13>
 <d4ffca97-bb5d-4c42-a025-69b308c24f82@raritan.com>
 <4642281ef2e749a3b69bbea5474ecdf1@AcuMS.aculab.com>
 <c7980bbf-04aa-4c52-9c6c-f3a1169e90f9@raritan.com>
 <6f603fdd-12dc-4929-98aa-bee1f533e8e2@raritan.com>
 <79a34e2c-013b-42e8-80e4-52fa3c9e1194@sirena.org.uk>
From: Ronald Wahl <ronald.wahl@raritan.com>
In-Reply-To: <79a34e2c-013b-42e8-80e4-52fa3c9e1194@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0171.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::7) To DB8PR06MB6539.eurprd06.prod.outlook.com
 (2603:10a6:10:12f::23)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR06MB6539:EE_|AM7PR06MB6817:EE_
X-MS-Office365-Filtering-Correlation-Id: bd0cce9c-4fb0-4041-610b-08dbf4c61a57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	svIrr9i2xFR7Uk65DzylUjlkfnfjBvDtvR6iQCAGmX7f/Zq5usAzlC3a+zdpJkUXkDqAWkbYOANnhvVyK93CPuDtFYe7BvxopGQ822HTDcYmsfS9Q2Li6hq11WVrzizf8M3HA8CQzOTpbUriKLiHuXOzxn2RfeibNF45PiETsTveJD5RdRl3lbeRwUNLZgZJt/6zpgcQJ8y/0XCRIyqG7nuvgDPTvaPoM27J6/TgdrdQ/9Dt4gC1KOvs2ODw6vUgevNjpLrfzYMBRBG9YrRwZo36hhWtSDY64X7FooEq6N9wDVbFJNtxFhqgP2oOgI4f1tKVkmjhXjf2UyR1x6E6ndHX0FndwKOw36VKm5wAdEjAonk2HruK4zY1jXPtnozkgSko5Jp6ePJlq7gHTuKLngKgvOlWpMrZ5+OyYmugZNFy/7Ct2zf64piE0ZzrZ3nKwTgse3Om0R4YFoosmcWFOE9EqFKNF0EJRVFOrqLrk2vnz0y9xBfEfs2L7BMGq2tyS6GToA+57JMTstrFHZXdPKfrb4XLpAMxdXZuKwZgIhIbwGvX1isLoa/zTreUBSTqiiwr46plyj+kNLQb4Af1fnoPEQI96gZDZT8Nc9E2mslPn91VFMxkPgvu2nwG5/77k3nUVkzISPOuFEQMsvsesw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR06MB6539.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(136003)(366004)(39860400002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(26005)(478600001)(83380400001)(6486002)(6512007)(6506007)(66574015)(53546011)(36756003)(2616005)(316002)(6916009)(66476007)(54906003)(66946007)(66556008)(31686004)(38100700002)(5660300002)(4326008)(86362001)(7416002)(8936002)(8676002)(2906002)(44832011)(31696002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eHpDUXRyRlR2K0NreTJISWNDUHR2RS8rMUpQMTBYdDR5YW54OFJEZmFYVlU0?=
 =?utf-8?B?NnM5Q1JzU1ovVG5yb3JhcUlzNXlvVEVnL0h2Y1dFdGd5SnhwdUl3eG44Sk1Q?=
 =?utf-8?B?RDU1cHc2RWg2bmRRcEJCY0pxY2lJZGhqak9TVzEyN3NhVU9STHI2MDVuRU8x?=
 =?utf-8?B?dUMvVm44KzlJc2lMOGxqUDNPT2JwdjdTeGRZdWxQWGRVdWp4M3ZyOUhHZG02?=
 =?utf-8?B?MW5OZU9DWWZGd212ZktrUDF6b3FGaHVZdDRVT0xTdytyR1pFK2tSZE9hUTNM?=
 =?utf-8?B?SnZONmdTaHdZVGNwUVVKMGN4UlNjNFg2NTBNTyt1VXU2eWNSdHh3dFZiMjZy?=
 =?utf-8?B?SUV6RU9rVUtoeG5vL2lNK0dEVkF6TUtXcmZ5K2MyMEVlRDV2bUpWQ1FXamRp?=
 =?utf-8?B?RU9KR1VOWWFFRGtOMTdqZ1Vyb2UyeEhSb0g3WHpNMThFMll0UmhOSnlHRTd0?=
 =?utf-8?B?RlFsOGJNaVdxYkU4V0tSS2Q5ZVpsek1EWGFqWk9QT2tYRDhrdkVXc1E0M0JG?=
 =?utf-8?B?NkF3elZnZmpvYkpWSFNwTUVSYjFqTytnUHlwZzZnUnluaU1DT29LajBKTy9U?=
 =?utf-8?B?ckEyVHFjdUR6ZFMwL2pveFVmNDJwQU5naE1YTDQvMm12b2hWRkFwQVY3anAr?=
 =?utf-8?B?djBOSVpxeHBqTUd1SjdxWkdIUlNTMmtsSHJkQWl5d1RCYzd3QUhNaVJidDlL?=
 =?utf-8?B?YVFhb2RXTFQyRytQSjVLczluNHo1SWZLYlpxM0V6a0EvcXdzd3dUcFBrN0c5?=
 =?utf-8?B?STJUMC9ONVZRTXNmUFNVODg1bXh1eXRsYi94SE5oZlh5c0xQUEp6K0g1MUFa?=
 =?utf-8?B?S0FYQU1nWHhCR2tvR3Bka0RFYkQ5MytVaXA4dmxKS0UweEJBbnVhTEl4UjBZ?=
 =?utf-8?B?TE5iYi9kZ29xOVlXTDlDUDhJK0hwN3BzZ0p0S1VtKzZneThKRzhjMWphenRK?=
 =?utf-8?B?VlN0TGJrUmlzcFdhc3NLWXp3K1VacERZdTIya2lBWFlDdkF3TDJlMUdickJz?=
 =?utf-8?B?K1RVa205TlpqRGh0Y3NHNTVVVTFQN3QxY3hoZlZKcUhad3FKRVR2SGlXVkE3?=
 =?utf-8?B?VVUwNTVoNkJQR3IvMVhnek44T2xpa3oxZmlKQ2R4MjZ3bHVQbGVLSjYrR05L?=
 =?utf-8?B?N2IyMFBKUlFxNVdDbjRoTHdENUdxcGtEYXIybVk4L3RHclh1bndJNi8rUVdS?=
 =?utf-8?B?ZFJPOHh6RFp1ZUJaeGdMaEdyYkxPU0s1T3JDbHBvbzBWRUF0dVBHQ0ZDZjdh?=
 =?utf-8?B?Ri9kbkFWWHpkS1JGVzM5QmlBS0hUYUpBWjZFQUJ2dzAyUnBwNHEwVHZoeVlE?=
 =?utf-8?B?cmtYUVZXRHhKaEJPR0lnOWNuOUxTVG9XVmNHSlpPdC9kVkFIaTRuWXRjcUQv?=
 =?utf-8?B?T1RPZUM4TjhZMUJ5eWRWVy9zOG1XZ1J5ckJaazh5Vks0cVN5QWNmNWJTQnIr?=
 =?utf-8?B?d3orUXppVGxEMVViSTJreG91NzVVaW9TNUoraEtmWTJGZ3JFQ1RkTzBUUkpX?=
 =?utf-8?B?Y21aRVpVSnJBRXZzKzdrUUlQUXBRMjVRNWZ5cjZtaTYvdUd4Tm9HRWlDSWU2?=
 =?utf-8?B?VytSRC92Wm9lZnVHRWkxS3V0QkZkSy8wc1YvNUNsMDRjOTN1dElsV2JLVU4r?=
 =?utf-8?B?OEVWa2N4c3lNNzNsOEhVNGNaUHZHQTE2ajdYekJsaGw1YkVSTW4wNDlhRlhB?=
 =?utf-8?B?L3pDU1hTZmxUWDhrWUdRVm9TbTdEc2xFblJGS29sUHl6OGoxeHpUbEU3QVY4?=
 =?utf-8?B?enl4TWhnTjNUL1E3K2ZJSXU4SFYxb1MwOTlwendvVldDVzZoZDlMcmwzV2hO?=
 =?utf-8?B?aTRXbStHVkp1cGQraHA3OTk4U2s1eStkU2dleHkyV0NIYzNMeE53Ni81Ym1C?=
 =?utf-8?B?dnhOcVFlSkxYNGZSRjRYeWpMVHYvamh2WGE3YnF6ekdIRm04OG5rZ2I3M1Bj?=
 =?utf-8?B?bm93MFR0dWhRaTFJekl3aVhpZCtDdVNuMlJ2YmJaNW9uZ2JEK01ZcTlybEpj?=
 =?utf-8?B?UzNyS1VCc0FUdUFuL2t3RWNHTWpMck1ZVmxod1VRVDJUMlZLTlMzdmRsRzU1?=
 =?utf-8?B?QVRlOHpzdzdQZ2xndExXS2MreGx1TUdpcjJGMVE4ZHJLMEl4UytaNzRwRmFE?=
 =?utf-8?B?a1JKazVQamNiKzVlY3A3T3hvdk1BMm9NbU1rZkRmK3MyQTdNSHNKWWc3Q0Vt?=
 =?utf-8?B?bnc9PQ==?=
X-OriginatorOrg: raritan.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd0cce9c-4fb0-4041-610b-08dbf4c61a57
X-MS-Exchange-CrossTenant-AuthSource: DB8PR06MB6539.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 12:39:48.6897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 199686b5-bef4-4960-8786-7a6b1888fee3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2N0DKvNbDuK9o/NI+7Q/F1Q6EnmzXRaolA9BDjXaqsvHps6qNO88VejJIwNYuPxyNPU6Ft0XIJ9BUpCwZB14yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR06MB6817

On 04.12.23 13:26, Mark Brown wrote:
> On Mon, Dec 04, 2023 at 12:54:50PM +0100, Ronald Wahl wrote:
>
>> Revert e0205d6203c2 "spi: atmel: Prevent false timeouts on long transfer=
s"
>> and the two new patches that are already added to one or more devel tree=
s
>> [1/2] spi: atmel: Do not cancel a transfer upon any signal
>>        commit: 595d2639451d3490c545c644ece726a0410ad39b
>> [2/2] spi: atmel: Drop unused defines
>>        commit: 28d8051efae17b6d83544f3c1cf06f6a71677e91
>
> If you want to submit changes please follow the process in
> submitting-patches.rst.

I can actually do this but I wanted to give Miquel the chance to do the
work.

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

