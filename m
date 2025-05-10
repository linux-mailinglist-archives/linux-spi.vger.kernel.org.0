Return-Path: <linux-spi+bounces-8055-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F19AB232F
	for <lists+linux-spi@lfdr.de>; Sat, 10 May 2025 11:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0541D1BC02DC
	for <lists+linux-spi@lfdr.de>; Sat, 10 May 2025 09:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70AD2221726;
	Sat, 10 May 2025 09:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="l++9sY61"
X-Original-To: linux-spi@vger.kernel.org
Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010006.outbound.protection.outlook.com [52.103.68.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0883C20EB;
	Sat, 10 May 2025 09:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746871059; cv=fail; b=nwLA9esrhtMjawawsB4wY6M+RcyisLNXvnli/ddE7XmaWD0U/C9dSzRMyMCRYX5/ABWWI0zjdr3+EQUPdxasUqsczn/mqDDS+Bt1ipkanaGCaDrt1cFHARvtORytSIYA78RTpB/I4cKFHmae+95tX8E930OPuRCNoRNB/0BYRPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746871059; c=relaxed/simple;
	bh=vAYJXMK3ZzARERbPFmIFwOItCl06bVdrRl2DH5VHpEY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Yvb7KK+KI7RGayt3Qfueycy3h4ew0cLEGB3E29JOAhlQq/P3jnkYjddS1MrMtX021drPNNAWUJbgFh3/mO6jusrLD8B18I09aB8OlfOZhCSbuIm46QZNow9RvIhLoX3S+ZgYRWEBfHc+cZ7FqtcCz5CYEpNBrAIduRLbRfeLjkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=l++9sY61; arc=fail smtp.client-ip=52.103.68.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QzZPws+dbXwbypGENfEQfB2xjbd+kfLgjo2SPqj4aI+CjT+y8D0n1TPsu2xcLFGcU1umFkgOs02MSGTZ6Jpx/NopSlHA60WpGWZQjkQBoc1tJukAMRtgBObOdP7QNkh6XzFcvdtdBJTni+NataQFGnEdVytcy9CAesESHDQpI4rrW6NFCHqSqinpMG5D90/wvXp7b61yImn4M+BMDwuR/u6jOdRERzwd0PohIptVj/lvxg0XxNrDCU2Baeqxfxiq2TKIkU9tY88OSPFiw0vGOWP3uL7Skzgq06MSZXJVSNG0nstS+vm0qVwjbr7EN2KR0vS3FKUNDIhTL+DKCttM4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vAYJXMK3ZzARERbPFmIFwOItCl06bVdrRl2DH5VHpEY=;
 b=k4p/WeC8w38KbKO06xaH3AhB24Eaor97t5y65fb7AODgioV5ivQ9n9pcsRp8DQ4GJVZq0tXKNVZZs8m+w36xnVy+Z1Hlk6gfhaGSZXWpZOlWM0DKohGc8JYNo2VF9gO7p22YxtIuL27UNWxdV14Qn2g+JXw1wqEYqve8qchDTMMNmiykaGjxv5tU8leO9LiA9Ke6UTJDsuYWJaM8rrU8HnBi31xrVPslqB17P6d3ZwtK/bIC+nwFQpOc4EHbukn0XaBXEjOyi6Yf6f9GnGp9fhsJMf4cMVSp1Yak7TkZ1y9bA4c155/7cqXg6whW71C3fvX0wPBNHv73Uvo7lwEXJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vAYJXMK3ZzARERbPFmIFwOItCl06bVdrRl2DH5VHpEY=;
 b=l++9sY61klDceqAqx/owYgtY17MemnBXbHMLwZA1h3T4GlD+/jzQOQ5GgewtdbMH9dK/Hamjxqdj+4Lu7IdPcXq18MxZhJvMQ04dsnbgC75+ZA8LYbAijWEQiQUXytKVz7LKnDOm5oMa4PIwzO6V0HXW0ildGIRBH0ZwK1plbjxBJPg9BuGMfxWEldtvbzVAAvQBGExONzzcAp9WBiXSK35111bePGPjLd4kBLyK1uV8odFF8Dpw1+S0wDj+xZdo6GxJ9ZeeVoIlb7fIQ5WL3yrmW6PEOk7Vm2/3+j1/A2yHUXEG2iPW4znpcEzXZAVryCgYeUk3R65QLW40hAgqzA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PNZPR01MB10921.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:292::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.26; Sat, 10 May
 2025 09:57:30 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%4]) with mapi id 15.20.8722.027; Sat, 10 May 2025
 09:57:30 +0000
From: Aditya Garg <gargaditya08@live.com>
To: =?utf-8?B?QmVya2VsIErDtnJn?= <joerg.berkel@bfh.ch>, Robin Murphy
	<robin.murphy@arm.com>
CC: Baolu Lu <baolu.lu@linux.intel.com>, "linux-input@vger.kernel.org"
	<linux-input@vger.kernel.org>, "dmitry.torokhov@gmail.com"
	<dmitry.torokhov@gmail.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "regressions@lists.linux.dev"
	<regressions@lists.linux.dev>, "linux-spi@vger.kernel.org"
	<linux-spi@vger.kernel.org>, "lukas@wunner.de" <lukas@wunner.de>, David
 Woodhouse <dwmw2@infradead.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, Joerg Roedel <joro@8bytes.org>, Will Deacon
	<will@kernel.org>
Subject: Re: [REGRESSION] applespi from 6.12 onwards
Thread-Topic: [REGRESSION] applespi from 6.12 onwards
Thread-Index: AQHbv3J4Ewox49Qdu0O+OtlEA0OygbPH/0CAgACa2oCAABeX+oABu+sAgAE2xnc=
Date: Sat, 10 May 2025 09:57:30 +0000
Message-ID:
 <PN3PR01MB959708DEEA1567DD38447D5AB895A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <4dada48a-c5dd-4c30-9c85-5b03b0aa01f0@bfh.ch>
 <PN3PR01MB9597D8E327CC7910673849D3B888A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <122a1f90-ddd9-4e74-96d1-57e21e580ae2@linux.intel.com>
 <f1b41874-1535-4457-9747-eee3d816091a@arm.com>
 <PN3PR01MB959764E908600CD45169348CB88BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <c0bbfcc8-1275-43de-be40-acb8f2653359@bfh.ch>
In-Reply-To: <c0bbfcc8-1275-43de-be40-acb8f2653359@bfh.ch>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PNZPR01MB10921:EE_
x-ms-office365-filtering-correlation-id: b27c27de-f08b-4264-65b8-08dd8fa913c7
x-ms-exchange-slblob-mailprops:
 laRBL560oLR0Ybdxcp7KTbjbpYD2CblCo4vQ/olt3WHxhAGnW1eZ++2GHAwqp56zyCitk5gGCGLi7yp9PUn6V1hrcMMViYoOhd9Hiv8l6G5xohzPToKT/cc123UacHtHld6b0MqPWfSb6dtbS4wUuzgUf30MDsmNFePbyDQB5/eF5mXA07h4EkfbC4SpYKtjSxGcfiwBGE7gew9wgbTlF55JzHx28UfSbiwJrjo2WKe/9b1JYOazoRl900M/jNj+zsCsiVPmYpFBWqAVJD7GAqPZCHpE/OtbEBlsbxjMOoSarWYBnG1jiSx+CiVXaiskrZIhsj9rEf8Wds5rJRKU+809yd7f/sjI2oaSX0Toe4CUIxcT24Er/7A2cbJQMJCOUyOE7p75nQD6XLEdP9Waq18XEZ0sr7HI/AlUYKPFtiajmVLrU8xUiSPNdFSJwK6IrmQdaa7Cs0xIFdsUt5ljclETCgFXpPGhiXogDDOxnxeQEZSj0pRXPrqsmjbqrkQC5h/eKalzQn5Bee6Zesum0u7FXmyUUa2b+cFi5K1nS5hhDgJQ2YJQQLfnWymMEwmsmv2Ab4iysSAsmwUf1PA+YWHv8dgtl6yLerL6Kn99sKoabP4x3afFxaiJsglUq4uS5jT7euOwJlZ6re2LO1UYwCdH1NWgyfRdFi7jltAPZwTW/79qCUpssse8cO9ie9uegAmvWvKDxc8GZyPkWCnmj37OKfepHkHBHYb1OLSXJpq2mPCaiE5TH8k6FU7Ex6FLyjswVr1DHGEEB0rirLDhq16Yg2E1B6Hl
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|15030799003|461199028|6072599003|8062599006|8060799009|7092599006|15080799009|19110799006|1602099012|3412199025|4302099013|440099028|34005399003|102099032|10035399007;
x-microsoft-antispam-message-info:
 =?utf-8?B?Q2hzTkd1ZlE2RzUxKzdQTnJIMnFORkxnNEI3ZGhLMXBWd2s1OEZrOEhJWHVu?=
 =?utf-8?B?L2xSWUQ3T3FwdFdESVJLTmVweG1QbFEwYTB1cUlmZ2QvUXQxTGxyU2NhcDNO?=
 =?utf-8?B?M21ESnl1djNGa1dzRXNlWUhZSTV4ZHFWd2hGelNXOC83RXhxcVpTYzdHTnhC?=
 =?utf-8?B?S1BGa0E5bjdrTGY3SlpLbU5YVTVQK0MxYkd2T1BrZkFLZGg5NE9teDZsSGxO?=
 =?utf-8?B?YmRxcFZrcFJMQkY0V2J6VGhkTTg2TzV6N01DWnRWWUlIZFgrbWtBSTliTzNX?=
 =?utf-8?B?U0Y0NEREY0tLMjZ2R0hmVXVuL3crZC9RK3hMbmkxSHhkYm16eGJaSkRDMjRP?=
 =?utf-8?B?MXp4YjBkZ3N1ZTNMNmJxRURSTTdPbEZrQXVLbG1WeW4vVW11aFFwSjRzL2tq?=
 =?utf-8?B?aHBIYVNKaTJOeEgwS2RhZEpsZGY4ZEphSUQ3dUE2cDFhYnlUY2FOMTgyYlp2?=
 =?utf-8?B?bU52YUxzNDZBbjg3RXp5WFplZm80NnZQZVMybW4zT0E4ZnJOSTU1YkhpZGpJ?=
 =?utf-8?B?bWlPd3hiZ05VZDg2dUNpSEs2YWF6MWxLc2xGQzh6dUVFTWVxSkRQaEhXdUZQ?=
 =?utf-8?B?bUhGZzJhYVl3QXZIaXZNVnB3SGFJandia2dPZERMcmlxOWJ4Q2c5SWVRQzlP?=
 =?utf-8?B?N2pWaEVIOCtiZmE4dVkyRitPeVpsRHhpMlU1YmFBNXM3RWd6cWo1VTNzTEE0?=
 =?utf-8?B?MEJnbWVFUE9EQ3l4UEVtZS9VQUtJMWxucHljM1FIN29JaDUrYTFOK2swRGFH?=
 =?utf-8?B?UmJaK1lIMzV2SWhQc3h0eHUwYk9ZQ3diVGtxZG00OUVpZjFVUitqcUVMZ2lO?=
 =?utf-8?B?T3lGL0JxUUxXeCs0UXBlWXNzbE9BbU9PS2tmYm9vQjR5cDJIUlVaNFZYVDhw?=
 =?utf-8?B?TnVVbnprVEtvekIzQmw5dlMvTFFUQW0zeFBRWG5IREFhY1E1cDh6YWlvbmpn?=
 =?utf-8?B?eUVFS3RLdHdsY3ZDdU1hRUxMUnB2S2ErN1hlVm5YMDVBWVJPb1QvbkRZL1Qz?=
 =?utf-8?B?V2ZrTXRSSDNKNldBTjRUNFBQTWNEMExkZXhyWmtucFMzdGV4NzNxL25YRkpj?=
 =?utf-8?B?MmdLK2NKNDFqTUJRb3RSeTIvUXVObUtoZjBuNkJkT3doa1JNalpmY1ROTnF0?=
 =?utf-8?B?aVZxVm5HeE5zclo2WFp4czZKalpjQlFueXB1TVh5eWRIbnY1cjBnTEhLN2xx?=
 =?utf-8?B?NUNhWXVXa1dqRTROelcvdlIrRnZHMEJkV3llRnJDaDAyU3lwOUNieCtIdW4v?=
 =?utf-8?B?UVhHM1dEejA0NGNQcllROFFEOUFOaTd6TG1udjkrY1o4bWYzWEhkRThvcG1D?=
 =?utf-8?B?cVlkRk9XeWd3dDdHdkwraWNmS2hVWTVWaWVYMmpsTVZoQkhXdkZQaUNnSGZX?=
 =?utf-8?B?U1czUVl2VWs1VUdyYjc0UFZndUVJVVU5QlJGMDc0VFlMdkhXUzNoU2hkbHhk?=
 =?utf-8?B?OVFlMzlLd2ZkZ0hLRkdSbTI1bExJS1dLY29hM3Q4emwyNmNFeVNTN1NCbmxD?=
 =?utf-8?B?cUhhbVhuMjRWZkNtZzJPTmNhbTlGalNCUzNqR09zU2U1Yk9kQkxYdFMyazhj?=
 =?utf-8?B?ZFZsNTlmS0dKUkdtRjJUYm93UjhJalhIRko5OGVTcWswditZVTVCNS9mRDdu?=
 =?utf-8?B?NDVibDV0NER6V2FuN3VsVjZpOWk2dGFYRDkyRUt6TFFJTjE4cXF0ZFJTRXAr?=
 =?utf-8?B?cmxQbTZHbmJXVldVOGhuZWd3ZGJNcVF5RlhUa2M1M3dDVXlNUTlOcFd2MFd5?=
 =?utf-8?B?MWEvRFVmd05Ob29qaCtMZ0JuZ2JaSFBtQm5MZmlNQll4TXB0NDRZRnZnR01l?=
 =?utf-8?Q?QTWRVRSmiUruGEBABEzMhEHkwpv+OO1phL74o=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TDJXSk95TGREN3pkZlJ0ZGZkR2RmV2Z0dVRkN0lES204RkJNdGhtbnFsNCtS?=
 =?utf-8?B?eXo0cmc0aTd5d0tQMkpTbzh0ZEdDdmZYS1pxOGpKWEltbDZqQ0dPY3lJZ0FY?=
 =?utf-8?B?NWErOFBtT1lVUERkRHNCZEVKa2cwVkhwQXZOdlVxVkpsUTVjaDljYmpMRHc1?=
 =?utf-8?B?ZzVOazY4RVNHWEx4T3E3TjFKQnNWKzFYN0pWSExUdForZFdadER3QXRQU3BR?=
 =?utf-8?B?TVAxblVwRFNvemtCNU82UHJhemFCc20reVdhZ1NiaEY4b0ZlYU5VY3RpVkhU?=
 =?utf-8?B?eERHMEg3YmlBNDN2MXgxNWVENG9VT3pNdUdhS01RaXhURzd2T3hjVU5nUkQx?=
 =?utf-8?B?a1NGZmF6ZDBZNmdrWThISk44N1paaXNOV0czN1BXSXJRUDJ0S2QyblhLN3Rk?=
 =?utf-8?B?WlBPcUJ0V2YyVkcxbUxYRDhrNThkZlo5cEQzQUd0V04rb0tVcERrSk5kL2Q3?=
 =?utf-8?B?WjhXWDNuZW1IRHIxZGlQYS9rRUk2dFRVekhqVFFNeFozd1pHcVFpekRLNlow?=
 =?utf-8?B?SEJtd1RQeDkzd3hEb1NxakF2eEV0bXEwRVp6eEtkOTNxekxETHNPRkZDRUR0?=
 =?utf-8?B?N3dFV00yZTJaRTNvNThLcURueHJiZVJqQkwxNmZ3a2JMRTJiQnhxQ1NrNS9N?=
 =?utf-8?B?RXEvUXNTbHNUb2hLWU0zL0tnNDV1RlUvVXFYbDlXUXFzdXR1a2IyT2tuTENT?=
 =?utf-8?B?SG9abWFzZzZ0VG9rbDRjcmpHMTRFUU1ZSDBQSWtNU0NCRWh6dktKN0Frcmhv?=
 =?utf-8?B?OGN5N1djVjB4elR4eDI2MTR6YnN2eWk1R0lwOFJ2UG1xOWd3bEFsZllrcFQx?=
 =?utf-8?B?eHdoMW9DU2FWR0FaUjlYMVBBV3g0UDhadmQyWTY2UVBVdTdaU0RwYUIvYlV4?=
 =?utf-8?B?UHRFMkRMZjBWdDhaS05BM0wrR25rMVcyLzZnN0laVi9uclRKWnViZWVlTC9C?=
 =?utf-8?B?VFQyeEJDYUdQUTFwaWIrMys5NDByVGI5WWJ6ZUFDYjRJOGs2b3NTY0FnTFdt?=
 =?utf-8?B?dW1qMHNLNWlTUHByU1JLRk9pSlMvdlZTSTNLVFZUYWZyR3BRWk92Q1JwMExu?=
 =?utf-8?B?YStrVS9KV3U5anp6K0ZJLzlpcXFRWnU4N1h5MUhyUHpxYWVRUVNDUFhLYnlV?=
 =?utf-8?B?QjhhWUxjOHZCbXZ4akNUbUQ3c1A5Ky94VDA1YUtLQS93Y01kVG9IdWtIQWs2?=
 =?utf-8?B?ZGR3V1FIUEVzUU1Jemc2N0tUaDUzQVhrcG5TZ1hPUWVkS0N1NkNWem40TDNH?=
 =?utf-8?B?MEtjWjc0RmREU3lZR3R0YjA2dTV3KzgraWdsSklKUmgwZ3dLR1F1Mm5UUEYz?=
 =?utf-8?B?MXB1SFZnSTUzeVhTRnluVkNxSUVUeVo4dXNiZnJ0bys0UTlHOUdvYVppbUty?=
 =?utf-8?B?alB1ZllFWGFqUElycVc5Y0xxNkhwWnZnZGZhQVlQZkIrMnZJSy9PMncwTjJw?=
 =?utf-8?B?dERSeFVhVS9sUTI5a1JIM2x1L2xUa2pMNGZHSk5hdmZsVVlPSy9NYWdRMjl1?=
 =?utf-8?B?ZUordlJtNlhoblRTZm5pT1dETjBROXJYRTRIZkxFQTYrejFOQzRqanpCa1Ix?=
 =?utf-8?B?cnEwNWY4MEYzM0twc0F0SzJqdzFmZEVlcDk5U3FJdGxLMHdvYWlKekRQblpN?=
 =?utf-8?B?cnFaNFJWYSsrbEtZcTRHdTZ0MzRXdjcwUFp4bTRMVHBHVkxnU091Qm5xR2Vp?=
 =?utf-8?B?SjlXcmQ1dEhETXNmU0tDbG0zNVErNXYwZmJ4NzVCczJLZStHbGtUKzZwSVI1?=
 =?utf-8?Q?nJoFJYbg978U+dzT7k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: b27c27de-f08b-4264-65b8-08dd8fa913c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2025 09:57:30.0137
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNZPR01MB10921

SGkgSsO2cmcKCkNhbiB5b3UgdGVzdCB0aGUga2VybmVsIGhlcmUgdG8gc2VlIGlmIHRoaXMgZml4
ZXMgeW91ciBpc3N1ZToKCmh0dHBzOi8vZ2l0aHViLmNvbS90MmxpbnV4L1QyLURlYmlhbi1hbmQt
VWJ1bnR1LUtlcm5lbC9hY3Rpb25zL3J1bnMvMTQ5NDQyMDAzNTYKCkFsdGVybmF0aXZlbHkgeW91
IGNhbiB0cnkgY29tcGlsaW5nIHlvdXIgb3duIGtlcm5lbCB3aXRoIHRoaXMgcGF0Y2g6CgpodHRw
czovL2xvcmUua2VybmVsLm9yZy9hbGwvMC12MS1jMjY1NTM3MTdlOTArNjVmLWlvbW11X3Z0ZF9z
c193b19qZ2dAbnZpZGlhLmNvbS8KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KRnJvbTogQmVya2VsIErDtnJnIDxqb2VyZy5iZXJrZWxAYmZoLmNoPgpTZW50OiAwOSBN
YXkgMjAyNSAyMDo1MwpUbzogQWRpdHlhIEdhcmc7IFJvYmluIE11cnBoeQpDYzogQmFvbHUgTHU7
IGxpbnV4LWlucHV0QHZnZXIua2VybmVsLm9yZzsgZG1pdHJ5LnRvcm9raG92QGdtYWlsLmNvbTsg
c3RhYmxlQHZnZXIua2VybmVsLm9yZzsgcmVncmVzc2lvbnNAbGlzdHMubGludXguZGV2OyBsaW51
eC1zcGlAdmdlci5rZXJuZWwub3JnOyBsdWthc0B3dW5uZXIuZGU7IERhdmlkIFdvb2Rob3VzZTsg
aW9tbXVAbGlzdHMubGludXguZGV2OyBKb2VyZyBSb2VkZWw7IFdpbGwgRGVhY29uClN1YmplY3Q6
IFJlOiBbUkVHUkVTU0lPTl0gYXBwbGVzcGkgZnJvbSA2LjEyIG9ud2FyZHMKCkFtIDA4LjA1LjI1
IHVtIDE0OjU0IHNjaHJpZWIgQWRpdHlhIEdhcmc6Cj4KPgo+PiBPbiA4IE1heSAyMDI1LCBhdCA1
OjAw4oCvUE0sIFJvYmluIE11cnBoeSA8cm9iaW4ubXVycGh5QGFybS5jb20+IHdyb3RlOgo+Pgo+
PiDvu79PbiAyMDI1LTA1LTA4IDM6MTUgYW0sIEJhb2x1IEx1IHdyb3RlOgo+Pj4+IE9uIDUvOC8y
NSAwMTowNywgQWRpdHlhIEdhcmcgd3JvdGU6Cj4+Pj4gS2V5Ym9hcmQgYW5kIHRvdWNocGFkIHN0
b3BwZWQgd29ya2luZyBvbiBzZXZlcmFsIEFwcGxlIE1hY2Jvb2tzIGZyb20gdGhlIHllYXIgMjAx
NyB1c2luZyBrZXJuZWwgNi4xMi54eCAuIFVudGlsIG5vdyBJIGNvdWxkIG9ubHkgZmluZCB0aGlz
IGRpc2N1c3Npb24gYWZmaXJtaW5nIHRoZSBidWcgb24gRGViaWFuIGFuZCBGZWRvcmE6aHR0cHM6
Ly9naXRodWIuY29tLyBEdW5lZGFuL21icC0yMDE2LWxpbnV4L2lzc3Vlcy8yMDIKPj4+Pgo+Pj4+
IE9uIHNpZHVjdGlvbiBJIGFsc28gdHJpZWQgdGhlIG1vcmUgcmVjZW50IGtlcm5lbHMgNi4xNC41
IGFuZCBtYWlubGluZSA2LjE1LXJjNCAoZnJvbSBVYnVudHUpIGFuZCB0aGUgaXNzdWUgcGVyc2lz
dGVkIHdpdGggbXkgdGVzdGRldmljZSBNYWNCb29rUHJvMTQsMSAtLSBzZWUgdGhlIHJlbGV2YW50
IG91dHB1dDoKPj4+Pgo+Pj4+IGtlcm5lbDogcGxhdGZvcm0gcHhhMnh4LXNwaS4zOiBBZGRpbmcg
dG8gaW9tbXUgZ3JvdXAgMjAKPj4+PiBrZXJuZWw6IGlucHV0OiBBcHBsZSBTUEkgS2V5Ym9hcmQg
YXMgL2RldmljZXMvcGNpMDAwMDowMC8wMDAwOjAwOjFlLjMvIHB4YTJ4eC1zcGkuMy9zcGlfbWFz
dGVyL3NwaTIvc3BpLUFQUDAwMEQ6MDAvIGlucHV0L2lucHV0MAo+Pj4+IGtlcm5lbDogRE1BUjog
RFJIRDogaGFuZGxpbmcgZmF1bHQgc3RhdHVzIHJlZyAzCj4+Pj4ga2VybmVsOiBETUFSOiBbRE1B
IFJlYWQgTk9fUEFTSURdIFJlcXVlc3QgZGV2aWNlIFswMDoxZS4zXSBmYXVsdCBhZGRyIDB4ZmZm
ZmEwMDAgW2ZhdWx0IHJlYXNvbiAweDA2XSBQVEUgUmVhZCBhY2Nlc3MgaXMgbm90IHNldAo+Pj4+
IGtlcm5lbDogRE1BUjogRFJIRDogaGFuZGxpbmcgZmF1bHQgc3RhdHVzIHJlZyAzCj4+Pj4ga2Vy
bmVsOiBETUFSOiBbRE1BIFJlYWQgTk9fUEFTSURdIFJlcXVlc3QgZGV2aWNlIFswMDoxZS4zXSBm
YXVsdCBhZGRyIDB4ZmZmZmEwMDAgW2ZhdWx0IHJlYXNvbiAweDA2XSBQVEUgUmVhZCBhY2Nlc3Mg
aXMgbm90IHNldAo+Pj4+IGtlcm5lbDogYXBwbGVzcGlzcGktQVBQMDAwRDowMDogRXJyb3Igd3Jp
dGluZyB0byBkZXZpY2U6IDAxIDBlIDAwIDAwCj4+Pj4ga2VybmVsOiBETUFSOiBEUkhEOiBoYW5k
bGluZyBmYXVsdCBzdGF0dXMgcmVnIDMKPj4+PiBrZXJuZWw6IERNQVI6IFtETUEgUmVhZCBOT19Q
QVNJRF0gUmVxdWVzdCBkZXZpY2UgWzAwOjFlLjNdIGZhdWx0IGFkZHIgMHhmZmZmYTAwMCBbZmF1
bHQgcmVhc29uIDB4MDZdIFBURSBSZWFkIGFjY2VzcyBpcyBub3Qgc2V0Cj4+Pj4ga2VybmVsOiBE
TUFSOiBEUkhEOiBoYW5kbGluZyBmYXVsdCBzdGF0dXMgcmVnIDMKPj4+PiBrZXJuZWw6IGFwcGxl
c3Bpc3BpLUFQUDAwMEQ6MDA6IEVycm9yIHdyaXRpbmcgdG8gZGV2aWNlOiAwMSAwZSAwMCAwMAo+
Pj4gSXQgYXBwZWFycyB0aGF0IGFsbCBETUEgZmF1bHRzIGFyZSByZWxhdGVkIHRvIGEgZml4ZWQg
YWRkcmVzcywKPj4+IDB4ZmZmZmEwMDAuIElzIHRoaXMgYWRkcmVzcyBzb21ldGhpbmcgc3BlY2lh
bD8KPj4KPj4gTWF5YmUgaXQncyByZXRyeWluZyB0aGUgc2FtZSBidWZmZXIgYSBmZXcgdGltZXMg
YmVmb3JlIGZpbmFsbHkgZ2l2aW5nIHVwPyBUaGUgYWRkcmVzcyBkb2VzIGxvb2sgbGlrZSBhIHBs
YXVzaWJsZSBpb21tdS1kbWEgSU9WQSwgc28gSSBjYW4gaW1hZ2luZSBhdCBsZWFzdCB0d28gcG9z
c2liaWxpdGllcyB3aGVyZSBhIGNoYW5nZSBpbiB0aGUgSU9NTVUgZHJpdmVyIG1pZ2h0IGhhdmUg
YW4gaW1wYWN0Ogo+Pgo+PiAtIEl0J3MgdGhlIHJpZ2h0IGFkZHJlc3MgaW4gdGhlIHJpZ2h0IGNv
bnRleHQgYnV0IGluY29ycmVjdGx5IG1hcHBlZCBhcyBETUFfRlJPTV9ERVZJQ0UsIHdoZXJlIHRo
YXQgcHJldmlvdXNseSBoYWQgaW1wbGljaXQgcmVhZCBwZXJtaXNzaW9uIGFzIHdlbGwgYnV0IGlz
IG5vdyB3cml0ZS1vbmx5IChjYW4gdGhlIEludGVsIDJuZC1zdGFnZSBmb3JtYXQgZG8gdGhhdCBs
aWtlIEFybSBkb2VzPyBJIGZvcmdldC4uLikKPj4KPj4gLSBJdCdzIHRoZSByaWdodCBhZGRyZXNz
IGluIHRoZSB3cm9uZyBjb250ZXh0LCBiZWNhdXNlIHRoZSBETUEgbWFwcGluZyB3YXMgZG9uZSB3
aXRoIHRoZSB3cm9uZyBkZXZpY2UsIHdoaWNoIHdhcyBwcmV2aW91c2x5IGluIHRoZSBzYW1lIElP
TU1VIGdyb3VwIGFzIDAwOjFlLjMsIGJ1dCBub3cgd2UgYXNzaWduIGdyb3VwcyBkaWZmZXJlbnRs
eS4gSSBkb24ndCBrbm93IGlmIGxwc3Nfc3BpX3NldHVwKCkgaXMgcmVsZXZhbnQgdG8gdGhpcyBw
YXJ0aWN1bGFyIGhhcmR3YXJlIHNldHVwLCBidXQgImRtYV9kZXYgPSBwY2lfZ2V0X3Nsb3QoZGV2
LT5idXMsIFBDSV9ERVZGTihQQ0lfU0xPVChkZXYtPmRldmZuKSwgMCkpOyIgdGhlcmUgY2VydGFp
bmx5IGNhdGNoZXMgbXkgYXR0ZW50aW9uLCBhdCBsZWFzdC4KPj4KPj4gVGhlIERNQSBtYXBwaW5n
IHRyYWNlcG9pbnRzIHNob3VsZCBiZSBhYmxlIHRvIHNoZWQgbGlnaHQgb24gaG93IHRoYXQgYWRk
cmVzcyBpcyBtYXBwZWQgcHJpb3IgdG8gdGhlIGZhdWx0Lgo+Cj4gQSBmdWxsIGRtZXNnIHdpdGgg
ZGVidWcgbG9nIGxldmVsIHNob3VsZCBiZSBuaWNlIHRvIGhhdmUgaW1vLgo+Cj4gSsO2cmcgY2Fu
IHlvdSBkbyB0aGF0IGZvciBib3RoIDYuMTEgYW5kIDYuMTI/Cgp5b3UnbGwgZmluZCBhdHRhY2hl
ZCB0aGUgdHdvIGtlcm5lbC1sb2dmaWxlcyBjcmVhdGVkIHVzaW5nCiJzeXN0ZW1kLmxvZ19sZXZl
bD1kZWJ1ZyBzeXN0ZW1kLmxvZ190YXJnZXQ9a21zZyBsb2dfYnVmX2xlbj0xNU0iCgpUaGFua3Ms
CkrDtnJnCg==

