Return-Path: <linux-spi+bounces-4653-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1985D96CD28
	for <lists+linux-spi@lfdr.de>; Thu,  5 Sep 2024 05:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EABD1C227DB
	for <lists+linux-spi@lfdr.de>; Thu,  5 Sep 2024 03:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE08145B27;
	Thu,  5 Sep 2024 03:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OG3WGsSL"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010037.outbound.protection.outlook.com [52.101.69.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68ABF31A89;
	Thu,  5 Sep 2024 03:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725506569; cv=fail; b=oqgc+kSmUlabRllAM/Mw5jblMFjm1tV7rPvD4CUJRwJr/gB9RKnudtZhGshwdHunPVfA9zfSj/siVUHMUmZ1cMeiDXOgdj5xGp49VCXzIn5hJAuWK+X5aCb8K/QU2rezaPn+Up1DlDdIlYLkbIQPhnxmNOprlNr4aN4EMLI7/hQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725506569; c=relaxed/simple;
	bh=swjyrCvyNDEY71mdlLED+7k7MShr/UT8lk7+OsgmDEY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VOaAMST8w5xKnSM+CqZvcHieBbNpZYm0N3dbQEhjC9VO+Fdk2ja8IGomVYY7FfCUGL93XQFtO2y2bWU7qNkUfhnFm6fsbFRYWFdkxFrPGonHYstDhXHkhknAaiUfDcsUE62KtxJ9CeCahAZ2qibg1B6lHiASl864+ymbU3E9ewo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OG3WGsSL; arc=fail smtp.client-ip=52.101.69.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NI29i3HqkQNhoZiWCd9tyMpPk/eL50++/sIuclCJTlRA8UOmxog72lyoQjzp4/KYI0eh51mJ1zUv12RPNKb2A0EBk7Xhskq2vScb0pmPTW9zLSy3v6FXMJmsaEfe0fqeLSi8B8P2zQoHG3pMh0suL5sbDVbAilVSjLEcB63E4/o+G8PJvXQkpC/EmS/ih7jnUdukjEKc5LBN1mZxZufhSP4wxQXAdNgtKXykgo5S8mx1qqkOsxDV8+OJB01AMZ/5c1ei+YcjLbX4Zutwiu1q1Mtze6I3w1ZF96CKV2oR1qzOdck2kslYt+ckKvVyORwNpxoMlZI6MYQcd0avuDdilw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=swjyrCvyNDEY71mdlLED+7k7MShr/UT8lk7+OsgmDEY=;
 b=F+fRTVDDqejUsAXZNFozzCOL0pg2rN/gDFTwJ4419g0021vXQMYT5Yxzzc8fYI3dQUFTCcNQwmdv9xa9UsJjo0y36eFwXTq+/PHaI30Q4RQ+OAXFKA+FWlFnEFfp8ufkUH1TYixDA9jsMX0pXSczOReV207pk0R0+KTnSla2nphCjUH87IfdwC3DXDmiIpiTTtRvaNLbHYNCAK7ORFUDfaqvHXa7M8AwyaW52wMLOrFGsNc8Ii0lyAu5e1GNiu1HD8p50mHS7qmGyKvUBPVv21qRbajjtPgMf0WhHAKIIp3J7X6tP963qDtC5o/t5wEZHCb39swrQb5N4MmsO1sgKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=swjyrCvyNDEY71mdlLED+7k7MShr/UT8lk7+OsgmDEY=;
 b=OG3WGsSLGxzXjjf3LoG15v8+Al4Ri315Vr2c9ioieYYVMTQ++muSc12Q7Bp1VOa48jMza21WffKYCM8phslBkbl73wRlke3Mire6wfE3jjQKQ+tun7l2lEbL5wmBqTVTD2AijBFxz8pd1PR5zhCS/JgEqa+beh1g9DVtT8PRpfMSikT6+YSphu90V+a7U9t779TrFEz5BqryrvUg+zkgjx+fW4WBE/jA+xpSo1Wd5NR0QBnW1tWnuZ3pBy8jpylEXLKPfkAtcA361BGLe9q5c5drvBX9LGrYVvfS1KJ5oz2DTO9IF1p98TW8K586g1G/ffwOpowXmCh/NoTFQG1hCA==
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by PA1PR04MB10503.eurprd04.prod.outlook.com (2603:10a6:102:446::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Thu, 5 Sep
 2024 03:22:44 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%4]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 03:22:44 +0000
From: Bough Chen <haibo.chen@nxp.com>
To: Frank Li <frank.li@nxp.com>
CC: Han Xu <han.xu@nxp.com>, "yogeshgaur.83@gmail.com"
	<yogeshgaur.83@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>, "singh.kuldeep87k@gmail.com"
	<singh.kuldeep87k@gmail.com>, "hs@denx.de" <hs@denx.de>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v2 3/3] arm64: dts: imx8ulp: correct the flexspi
 compatible string
Thread-Topic: [PATCH v2 3/3] arm64: dts: imx8ulp: correct the flexspi
 compatible string
Thread-Index: AQHa/zKcqwZ/3KM8yEiSqV0sAe7IBLJIg2EAgAACQoA=
Date: Thu, 5 Sep 2024 03:22:43 +0000
Message-ID:
 <DU0PR04MB94967C22FBBEF9A0D35FAFBC909D2@DU0PR04MB9496.eurprd04.prod.outlook.com>
References: <20240905012617.1864997-1-haibo.chen@nxp.com>
 <20240905012617.1864997-4-haibo.chen@nxp.com>
 <ZtkgsO3tUkiNDWYH@lizhi-Precision-Tower-5810>
In-Reply-To: <ZtkgsO3tUkiNDWYH@lizhi-Precision-Tower-5810>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9496:EE_|PA1PR04MB10503:EE_
x-ms-office365-filtering-correlation-id: ddaacdcf-8d72-4f66-e0e5-08dccd5a01c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?a2lMZ0ZIWStRWXVRZkpzWVpDNWhoM0YydWJtOEp2TmpnT3FrRmF6T1hnMVUz?=
 =?gb2312?B?YUlxOS9UU1BKa1dKcGRhOHZQajlETXphUVc5Mm9qSm1hTDNIZzdITk9NWlg5?=
 =?gb2312?B?UWE5WlJpQWg3SzFTWEEweTRHajVzNXZsNTRZQ1AzMzZVaFBsWDQyc0VkcGNt?=
 =?gb2312?B?R0d6UTNKMHJmZGNhOVpDOVRIRFNoS1ROQ0VhYXljSFZSeHVNd3BpamNDaVJS?=
 =?gb2312?B?MUJlNDhYTEhsWWEwZSs1VG1FTXpMcWRhN0plUm9qTWpCclVWQmJ4SEFLbDVD?=
 =?gb2312?B?bG93cmJRdVdheGluSjhzVFhmZHgxOTlJc09pUjYwci94MXlRQVdITUhDODhD?=
 =?gb2312?B?dENGV3BoU0tuNUNQa1l6QnBKNEhCWk1pSXNyWTlZT1hHaW5aWnpOSktJT1lD?=
 =?gb2312?B?ZVprTS9tNEt0TGZBMDcvSHlrU3BjUnZUMExxMzIwclJnY0tEVFU3RTZrZDRW?=
 =?gb2312?B?di9maTV0aHErSzI3cWJncFdyU1hKOHFVS2ZPWWRVMUZBVEI2dkV2bUs2Skth?=
 =?gb2312?B?ekJsR1RmVXkrOVU1RVRrZ3RwYWdvU1B4NFFrbkN6Rmd4OUx1ZTlYdW9iMnNj?=
 =?gb2312?B?dGhuTUJQQld2STdQemQ3Rm5YdVZmd2NkU0dweXJiY3VtS1hJM2FCWTh0RmxI?=
 =?gb2312?B?Q2hWSlR3OFBaQU44UmxueS9xdUt6TFk4MzZra1RTRldlVWR0VmU3UFVQZkVO?=
 =?gb2312?B?dXd1MktuWGNwQU5sTVhOUk85dktEbFdlMXBxYlRJR0ZYMUFQdGRiS0xEeGVm?=
 =?gb2312?B?Y204MkhUM1o3azlNcnQ5cnI2SU84TE9Dc0J0cmVZOHdKdHVuRWNsRFpjeHNl?=
 =?gb2312?B?RXRpUzVUbG9URlN6ODdycG10M2JOT2dIQXJ6UWxuTmdTdjNPeThxV205cjRS?=
 =?gb2312?B?QUQxdkZhVzBLNmJXdUxtSXNmdm5sejBkelB2bW5sZG13ZU1ZakVlOFBGOXln?=
 =?gb2312?B?VnYvc1ZCdlliWXlacTdVNUZqTE8xNjBXd2hpN0NvVjMxVVRseW9mUE41WHZ6?=
 =?gb2312?B?UnRnWE9TRVhXaXI5QVFHVm1DS1hrdVR5R2FxMnUrSWxhU3l2Vmp4eVhxVjRP?=
 =?gb2312?B?OWg4MW4rL1lIUGVndXFUQ0VMRExEOVcwUi9HRTQ2TzdMRkI2akdIL2FmQlJV?=
 =?gb2312?B?ZkVYdDgwVERWOHJSQ0tEWnBrbXoyVkRCelUwYk5KdkhGUWpIK016MVFmeUNB?=
 =?gb2312?B?Q0ZtVmRmdXF6UnFCbC9NbjhnenYzZ2QyRVVldjlqYXFMV0wxckdlcUVpbG1R?=
 =?gb2312?B?a3FjZ2NZS3RiY1c0K0x1NTdjNHA1ekc1ZGkxZmpKRVBFaTY3VGVYcTNSSTRp?=
 =?gb2312?B?eDBESFhwQkZYVXZqVnl1cGM0WEIwYytrOExBb1I5dnM2d0JGNmY3bzVpT21L?=
 =?gb2312?B?UVVSMGwvNmNmL1kwcDhhb1lleTFzbis0azVkVVBuR2xjc1RhYS95c2xabUJS?=
 =?gb2312?B?UDFCYVpTeS8xVUU0T1NUR1BXWHh1bWVlb1VDRUVXdW5LdlBmbU5IcVRSM3BM?=
 =?gb2312?B?d1VFTzYwemVhYXo1dWVhQzRQREZHVXkxYjQrSU13RDRwYi81UHNob0tqZlBI?=
 =?gb2312?B?SG1VSDFjak5kMExqNWE5TndPTGFzV3dYYkR4ckc1SjJvRHBmOTlrU21tRmQy?=
 =?gb2312?B?V0MwZjdzQ2VUN1FaejdMS2V3VG5LUkJVc3VZOEF6TkcxSnFQR1JQdm9FQk43?=
 =?gb2312?B?T3NVTjNmNDRxZ2g3bHh6N29GZS9pbEpCcE1McDQxL3oxYlRJY0pPSzBvQW9t?=
 =?gb2312?B?SThSaVloOHJzbkdJSWxPQVNTZURJYVpXSjFrZ0FRcExLaTF6MTlheDZma0sz?=
 =?gb2312?B?MGw4TDRKRlVYMFJWbGNxbzUzOWorQTI0T3k2dk9RaDMyVlZWdGxGMDJPRU9O?=
 =?gb2312?B?U2QrK2h6MG5nNXVENkJCVHRCMGZhaTVBZkdpV1d4ZmVQSEE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?QXArRlVxZ2orVFRwYURBRnM1Nmtta0ZETTBDZ0JiQkk3Yk01blB6S3hkWjda?=
 =?gb2312?B?QnFKK0dOOWh4MlczNDhqRnA5eTlzQkFIOTdTc3ZwYkJCRm9RdHpWMWU1Y2w1?=
 =?gb2312?B?d1hZb0xlbFhlOFZQVHVxdlVZcnV2Z3NONUgvK2ZkSnNKbjA2NU5yKzg1c1pI?=
 =?gb2312?B?eW9tbTZxNWZ2QklWZTVHM2lpWnJhcXlhNjQvVWlRSTZSbmRTalJvalNJVFA1?=
 =?gb2312?B?RldFQXg5MTYvcE44YXlKUzZZNndUT2p2ekNSc2lXVjMxUUlhWWlBVFR1MVdI?=
 =?gb2312?B?WENpekxJZ2FoOFAxMUc3S05qalRkVkRQN2NHb2Jkd3R5REJaUHZ3Uitwd0p5?=
 =?gb2312?B?Z3JuTjA4TkFwbjJHaVhjTDB6TS84QUhwcGw5QVNhSGpmUnNUQko0YTV2TzRr?=
 =?gb2312?B?ZnNIZU9EZlhrWjBJWklNTTBZT0NUR29OYWRuU3EwQTFjeFFTdGdpWVVxd0Q4?=
 =?gb2312?B?L3JvSWk0UTlyMkttZFQxWVJkSWJ5Mk1HUk10RWdIRWVqNmlNNUZmVmQ1UWR6?=
 =?gb2312?B?WnliOVR5U3FwZFFhYVpUSFR3dWhnU29VYnVMczlYbTJKQkJvckNTNGhhb3ZL?=
 =?gb2312?B?Y29TZXJLdGxHa3hIdWdBeUZBNlVQVEFxc091M0lBR0daSEJWdkJOMHU0ZUJu?=
 =?gb2312?B?MGRRbVJhTjhSZHR2N0ZHcHpkLzlQZHVDcDdxMHp2eGdWdDdQVkx2V2hJdGZu?=
 =?gb2312?B?YjB2Q3d2cVk3WlZMdlBCRnp1d3FtcUdJbUU1VWZaY0pYeitMV2Jsc29uaUVZ?=
 =?gb2312?B?OUJhUGo2U1NWUEUwVlRYeEd5ZUJ5cVNNcFRIR0FkRndlT1FRUUJWeUhaSTJ1?=
 =?gb2312?B?QzVHQ2gvejZVTG9WSStyVUhBUWttNWx4Z1VLTDRSa0prRzdDdnVLKzNvSTRl?=
 =?gb2312?B?cTVpbmxQSk1RSjZIU2x4OXVGOEhoKzFkRTlRcnBGUk5JVG9sRnlGMkt5VDY4?=
 =?gb2312?B?ZGVVclNBU1FpNkpUaXA3NkNKRGg1Uy9FYjJYSDJmZGxDM1JNb2w1cUEzQTN5?=
 =?gb2312?B?dHUxOE4zRmhNMVdmV0M2TmdoS2dUSzlHV2dEZVV2TkVWL2p5dEtpSzhkYVM2?=
 =?gb2312?B?TGhrUmthQ3BxTWRpVVpUaTU3VkVBSzRIVUh0clB4OTNiT3R1TVJHVUN2VnJt?=
 =?gb2312?B?aGpQNWxjYTFtNGt1bmt3ZHpKeGJiWWlZbjZkekF3TC9FMTNKQjdKRHVJQ2pr?=
 =?gb2312?B?ZlNDTE1oa1pCSHpXVGgxRG9aY1NOc1JVZFRBSFpCdmpnaWlYbVpMWkYzc21K?=
 =?gb2312?B?NnBEb0dQb2ZzelJvSisrQkhVZ0U2cFpIemxncmsycmRWc0p0WldkL2FmcVpi?=
 =?gb2312?B?RVRtZllTZTBSSStYTG5qemV0a3ZKUStTbDNoQUZhSCtscVJCNU4xeTU0R0JT?=
 =?gb2312?B?MjV0QitnV3pPQjJTWWVpWGFJUnp4ZUh5WVBpcXZpMmNQd1psd1V6dndCWEM1?=
 =?gb2312?B?UnpBQVBCb0p4LyszTUFlVnlTeXdKVGZsVDhyWDkxcTJSd3NYKy9BdFNEUXpL?=
 =?gb2312?B?eW1wLzFDUExWamp3WUZEUDhTTFgySEdWQy8vOU1pUWd1WVMvLzk0VnczTW1E?=
 =?gb2312?B?LzdvcmhKREJNREh2bS9vc1NiNXVkM2VrTmg1ZGNCR2psc1NkRnRJeHp6YUl0?=
 =?gb2312?B?NXdNMnRFOVdFQ2FpNTdEb1RkdWlPd0FUNVdRNFRDbHI3WTAxa2JMdVpTUXZ2?=
 =?gb2312?B?NmQ5Zm5ReFNJaE1ja2gvbGRiSjIrbG94VFA1TkdTaUVSWjN3R3Q1aldBT0N3?=
 =?gb2312?B?VXBTdXVQUVM1UzdLZTh0c3hXbmRlMGtURW44RisrKzN3Zm1zWWwrcDJSVVBu?=
 =?gb2312?B?TFo4SndaZnViUGg5RGQ5TmtTOFVMQVNlT2pCbXJJdER3N25pQ05SRVJDUmJP?=
 =?gb2312?B?QncyUmhXUWpKNVJBdGRMK0FWc3RYMnNOQi9tRkdFd2hqU1dwL1A2aXVnbUlL?=
 =?gb2312?B?OTBhUTVpMVQ1RVE2TUY2TDVuYkltSXZNRlU5eXdzL0FvT0VNT0JpbG9CMVAv?=
 =?gb2312?B?WmRjeDVselhhQWZoQURGQXVTVkt6bGZ6eGMwNkthbjBKSEV3RndqM0plaDBR?=
 =?gb2312?B?QXpVYWdZZXhJV1ltTlZSRHJIeVdONEg3bWQ1NXF1RC9uTG1TK1BqbFNWR0tL?=
 =?gb2312?Q?gABTSNc6t/hIC386ZsP4OBMtX?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddaacdcf-8d72-4f66-e0e5-08dccd5a01c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2024 03:22:43.9614
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s++BTgzije01WTl8YnaJZvfa0o0flPRH4R7vcUoeoi0OSeiqO7OjA21MEp+pF5FX7Hb6YI31cUhoU/8X+qDRZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10503

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEZyYW5rIExpIDxmcmFuay5s
aUBueHAuY29tPg0KPiBTZW50OiAyMDI0xOo51MI1yNUgMTE6MDkNCj4gVG86IEJvdWdoIENoZW4g
PGhhaWJvLmNoZW5AbnhwLmNvbT4NCj4gQ2M6IEhhbiBYdSA8aGFuLnh1QG54cC5jb20+OyB5b2dl
c2hnYXVyLjgzQGdtYWlsLmNvbTsNCj4gYnJvb25pZUBrZXJuZWwub3JnOyByb2JoQGtlcm5lbC5v
cmc7IGtyemsrZHRAa2VybmVsLm9yZzsNCj4gY29ub3IrZHRAa2VybmVsLm9yZzsgc2hhd25ndW9A
a2VybmVsLm9yZzsgcy5oYXVlckBwZW5ndXRyb25peC5kZTsNCj4ga2VybmVsQHBlbmd1dHJvbml4
LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207IHNpbmdoLmt1bGRlZXA4N2tAZ21haWwuY29tOw0KPiBo
c0BkZW54LmRlOyBsaW51eC1zcGlAdmdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2Vy
bmVsLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgaW14QGxpc3RzLmxpbnV4
LmRldjsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnDQo+IFN1YmplY3Q6
IFJlOiBbUEFUQ0ggdjIgMy8zXSBhcm02NDogZHRzOiBpbXg4dWxwOiBjb3JyZWN0IHRoZSBmbGV4
c3BpIGNvbXBhdGlibGUNCj4gc3RyaW5nDQo+IA0KPiBPbiBUaHUsIFNlcCAwNSwgMjAyNCBhdCAw
OToyNjoxN0FNICswODAwLCBoYWliby5jaGVuQG54cC5jb20gd3JvdGU6DQo+ID4gRnJvbTogSGFp
Ym8gQ2hlbiA8aGFpYm8uY2hlbkBueHAuY29tPg0KPiA+DQo+ID4gVGhlIGZsZXhzcGkgb24gaW14
OHVscCBvbmx5IGhhcyAxNiBMVVRzLCBhbmQgaW14OG1tIGZsZXhzcGkgaGFzDQo+ID4gMzIgTFVU
cywgc28gY29ycmVjdCB0aGUgY29tcGF0aWJsZSBzdHJpbmcgaGVyZSwgb3RoZXJ3aXNlIHdpbGwg
bWVldA0KPiA+IGJlbG93IGVycm9yOg0KPiANCj4gTm90IHN1cmUgaWYgbmVlZCBmaXggdGFnLg0K
DQpJZiBhZGQgZml4IHRhZyBoZXJlLCB3aGVuIGJhY2sgcG9ydGluZyB0byBzdGFibGUgdHJlZSwg
YWxzbyBuZWVkIHRvIGJhY2sgcG9ydCB0aGUgb3RoZXIgdHdvIHBhdGNoIGluIHRoaXMgcGF0Y2gg
c2V0Lg0KU28gYWxsIHRoZXNlIHRocmVlIHBhdGNoZXMgbmVlZCBhZGQgY2Mtc3RhYmxlIGFuZCBh
ZGQgZml4IHRhZz8NCg0KQmVzdCBSZWdhcmRzDQpIYWlibyBDaGVuDQoNCj4gDQo+IEZyYW5rDQo+
ID4NCj4gPiBbICAgIDEuMTE5MDcyXSAtLS0tLS0tLS0tLS1bIGN1dCBoZXJlIF0tLS0tLS0tLS0t
LS0NCj4gPiBbICAgIDEuMTIzOTI2XSBXQVJOSU5HOiBDUFU6IDAgUElEOiAxIGF0IGRyaXZlcnMv
c3BpL3NwaS1ueHAtZnNwaS5jOjg1NQ0KPiBueHBfZnNwaV9leGVjX29wKzB4YjA0LzB4YjY0DQo+
ID4gWyAgICAxLjEzMzIzOV0gTW9kdWxlcyBsaW5rZWQgaW46DQo+ID4gWyAgICAxLjEzNjQ0OF0g
Q1BVOiAwIFVJRDogMCBQSUQ6IDEgQ29tbTogc3dhcHBlci8wIE5vdCB0YWludGVkDQo+IDYuMTEu
MC1yYzYtbmV4dC0yMDI0MDkwMi0wMDAwMS1nMTMxYmY5NDM5ZGQ5ICM2OQ0KPiA+IFsgICAgMS4x
NDY4MjFdIEhhcmR3YXJlIG5hbWU6IE5YUCBpLk1YOFVMUCBFVksgKERUKQ0KPiA+IFsgICAgMS4x
NTE2NDddIHBzdGF0ZTogNDAwMDAwMDUgKG5aY3YgZGFpZiAtUEFOIC1VQU8gLVRDTyAtRElUIC1T
U0JTDQo+IEJUWVBFPS0tKQ0KPiA+IFsgICAgMS4xNTg5MzFdIHBjIDogbnhwX2ZzcGlfZXhlY19v
cCsweGIwNC8weGI2NA0KPiA+IFsgICAgMS4xNjM0OTZdIGxyIDogbnhwX2ZzcGlfZXhlY19vcCsw
eGEzNC8weGI2NA0KPiA+IFsgICAgMS4xNjgwNjBdIHNwIDogZmZmZjgwMDA4MDAyYjJhMA0KPiA+
IFsgICAgMS4xNzE1MjZdIHgyOTogZmZmZjgwMDA4MDAyYjJkMCB4Mjg6IDAwMDAwMDAwMDAwMDAw
MDAgeDI3Og0KPiAwMDAwMDAwMDAwMDAwMDAwDQo+ID4gWyAgICAxLjE3OTAwMl0geDI2OiBmZmZm
MmViNjQ1NTQyNTgwIHgyNTogZmZmZjgwMDA4MDYxMDAxNCB4MjQ6DQo+IGZmZmY4MDAwODA2MTAw
MDANCj4gPiBbICAgIDEuMTg2NDgwXSB4MjM6IGZmZmYyZWI2NDU1NDgwODAgeDIyOiAwMDAwMDAw
MDAwMDAwMDA2IHgyMToNCj4gZmZmZjJlYjY0NTU0MjVlMA0KPiA+IFsgICAgMS4xOTM5NTZdIHgy
MDogMDAwMDAwMDAwMDAwMDAwMCB4MTk6IGZmZmY4MDAwODAwMmI1ZTAgeDE4Og0KPiBmZmZmZmZm
ZmZmZmZmZmZmDQo+ID4gWyAgICAxLjIwMTQzMl0geDE3OiBmZmZmMmViNjQ0NDY3NTA4IHgxNjog
MDAwMDAwMDAwMDAwMDEzOCB4MTU6DQo+IDAwMDAwMDAwMDAwMDAwMDINCj4gPiBbICAgIDEuMjA4
OTA3XSB4MTQ6IDAwMDAwMDAwMDAwMDAwMDAgeDEzOiBmZmZmMmViNjQwMGQ4MDgwIHgxMjoNCj4g
MDAwMDAwMDBmZmZmZmYwMA0KPiA+IFsgICAgMS4yMTYzNzhdIHgxMTogMDAwMDAwMDAwMDAwMDAw
MCB4MTA6IGZmZmYyZWI2NDAwZDgwODAgeDkgOg0KPiBmZmZmMmViNjk3YWRjYTgwDQo+ID4gWyAg
ICAxLjIyMzg1MF0geDggOiBmZmZmMmViNjk3YWQzY2MwIHg3IDogMDAwMDAwMDEwMDAwMDAwMCB4
NiA6DQo+IDAwMDAwMDAwMDAwMDAwMDENCj4gPiBbICAgIDEuMjMxMzI0XSB4NSA6IDAwMDAwMDAw
MDAwMDAwMDAgeDQgOiAwMDAwMDAwMDAwMDAwMDAwIHgzIDoNCj4gMDAwMDAwMDAwMDAwMDdhNg0K
PiA+IFsgICAgMS4yMzg3OTVdIHgyIDogMDAwMDAwMDAwMDAwMDAwMCB4MSA6IDAwMDAwMDAwMDAw
MDAxY2UgeDAgOg0KPiAwMDAwMDAwMGZmZmZmZjkyDQo+ID4gWyAgICAxLjI0NjI2N10gQ2FsbCB0
cmFjZToNCj4gPiBbICAgIDEuMjQ4ODI0XSAgbnhwX2ZzcGlfZXhlY19vcCsweGIwNC8weGI2NA0K
PiA+IFsgICAgMS4yNTMwMzFdICBzcGlfbWVtX2V4ZWNfb3ArMHgzYTAvMHg0MzANCj4gPiBbICAg
IDEuMjU3MTM5XSAgc3BpX25vcl9yZWFkX2lkKzB4ODAvMHhjYw0KPiA+IFsgICAgMS4yNjEwNjVd
ICBzcGlfbm9yX3NjYW4rMHgxZWMvMHhmMTANCj4gPiBbICAgIDEuMjY0OTAxXSAgc3BpX25vcl9w
cm9iZSsweDEwOC8weDJmYw0KPiA+IFsgICAgMS4yNjg4MjhdICBzcGlfbWVtX3Byb2JlKzB4NmMv
MHhiYw0KPiA+IFsgICAgMS4yNzI1NzRdICBzcGlfcHJvYmUrMHg4NC8weGU0DQo+ID4gWyAgICAx
LjI3NTk1OF0gIHJlYWxseV9wcm9iZSsweGJjLzB4MjljDQo+ID4gWyAgICAxLjI3OTcxM10gIF9f
ZHJpdmVyX3Byb2JlX2RldmljZSsweDc4LzB4MTJjDQo+ID4gWyAgICAxLjI4NDI3N10gIGRyaXZl
cl9wcm9iZV9kZXZpY2UrMHhkOC8weDE1Yw0KPiA+IFsgICAgMS4yODg2NjBdICBfX2RldmljZV9h
dHRhY2hfZHJpdmVyKzB4YjgvMHgxMzQNCj4gPiBbICAgIDEuMjkzMzE2XSAgYnVzX2Zvcl9lYWNo
X2RydisweDg4LzB4ZTgNCj4gPiBbICAgIDEuMjk3MzM3XSAgX19kZXZpY2VfYXR0YWNoKzB4YTAv
MHgxOTANCj4gPiBbICAgIDEuMzAxMzUzXSAgZGV2aWNlX2luaXRpYWxfcHJvYmUrMHgxNC8weDIw
DQo+ID4gWyAgICAxLjMwNTczNF0gIGJ1c19wcm9iZV9kZXZpY2UrMHhhYy8weGIwDQo+ID4gWyAg
ICAxLjMwOTc1Ml0gIGRldmljZV9hZGQrMHg1ZDAvMHg3OTANCj4gPiBbICAgIDEuMzEzNDA4XSAg
X19zcGlfYWRkX2RldmljZSsweDEzNC8weDIwNA0KPiA+IFsgICAgMS4zMTc2MDZdICBvZl9yZWdp
c3Rlcl9zcGlfZGV2aWNlKzB4M2I0LzB4NTkwDQo+ID4gWyAgICAxLjMyMjM0OF0gIHNwaV9yZWdp
c3Rlcl9jb250cm9sbGVyKzB4NDdjLzB4NzU0DQo+ID4gWyAgICAxLjMyNzE4MV0gIGRldm1fc3Bp
X3JlZ2lzdGVyX2NvbnRyb2xsZXIrMHg0Yy8weGE0DQo+ID4gWyAgICAxLjMzMjI4OV0gIG54cF9m
c3BpX3Byb2JlKzB4MWNjLzB4MmIwDQo+ID4gWyAgICAxLjMzNjMwN10gIHBsYXRmb3JtX3Byb2Jl
KzB4NjgvMHhjNA0KPiA+IFsgICAgMS4zNDAxNDVdICByZWFsbHlfcHJvYmUrMHhiYy8weDI5Yw0K
PiA+IFsgICAgMS4zNDM4OTNdICBfX2RyaXZlcl9wcm9iZV9kZXZpY2UrMHg3OC8weDEyYw0KPiA+
IFsgICAgMS4zNDg0NTddICBkcml2ZXJfcHJvYmVfZGV2aWNlKzB4ZDgvMHgxNWMNCj4gPiBbICAg
IDEuMzUyODM4XSAgX19kcml2ZXJfYXR0YWNoKzB4OTAvMHgxOWMNCj4gPiBbICAgIDEuMzU2ODU3
XSAgYnVzX2Zvcl9lYWNoX2RldisweDdjLzB4ZGMNCj4gPiBbICAgIDEuMzYwODc3XSAgZHJpdmVy
X2F0dGFjaCsweDI0LzB4MzANCj4gPiBbICAgIDEuMzY0NjI0XSAgYnVzX2FkZF9kcml2ZXIrMHhl
NC8weDIwOA0KPiA+IFsgICAgMS4zNjg1NTJdICBkcml2ZXJfcmVnaXN0ZXIrMHg1Yy8weDEyNA0K
PiA+IFsgICAgMS4zNzI1NzNdICBfX3BsYXRmb3JtX2RyaXZlcl9yZWdpc3RlcisweDI4LzB4MzQN
Cj4gPiBbICAgIDEuMzc3NDk3XSAgbnhwX2ZzcGlfZHJpdmVyX2luaXQrMHgxYy8weDI4DQo+ID4g
WyAgICAxLjM4MTg4OF0gIGRvX29uZV9pbml0Y2FsbCsweDgwLzB4MWM4DQo+ID4gWyAgICAxLjM4
NTkwOF0gIGtlcm5lbF9pbml0X2ZyZWVhYmxlKzB4MWM0LzB4MjhjDQo+ID4gWyAgICAxLjM5MDQ3
Ml0gIGtlcm5lbF9pbml0KzB4MjAvMHgxZDgNCj4gPiBbICAgIDEuMzk0MTM4XSAgcmV0X2Zyb21f
Zm9yaysweDEwLzB4MjANCj4gPiBbICAgIDEuMzk3ODg1XSAtLS1bIGVuZCB0cmFjZSAwMDAwMDAw
MDAwMDAwMDAwIF0tLS0NCj4gPiBbICAgIDEuNDA3OTA4XSAtLS0tLS0tLS0tLS1bIGN1dCBoZXJl
IF0tLS0tLS0tLS0tLS0NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEhhaWJvIENoZW4gPGhhaWJv
LmNoZW5AbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2Nh
bGUvaW14OHVscC5kdHNpIHwgMiArLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3Qv
ZHRzL2ZyZWVzY2FsZS9pbXg4dWxwLmR0c2kNCj4gPiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJl
ZXNjYWxlL2lteDh1bHAuZHRzaQ0KPiA+IGluZGV4IGUzMmQ1YWZjZjRhOS4uNDNmNTQzNzY4NDQ0
IDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDh1bHAu
ZHRzaQ0KPiA+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDh1bHAuZHRz
aQ0KPiA+IEBAIC0zODQsNyArMzg0LDcgQEAgcGNjNDogY2xvY2stY29udHJvbGxlckAyOTgwMDAw
MCB7DQo+ID4gIAkJCX07DQo+ID4NCj4gPiAgCQkJZmxleHNwaTI6IHNwaUAyOTgxMDAwMCB7DQo+
ID4gLQkJCQljb21wYXRpYmxlID0gIm54cCxpbXg4bW0tZnNwaSI7DQo+ID4gKwkJCQljb21wYXRp
YmxlID0gIm54cCxpbXg4dWxwLWZzcGkiOw0KPiA+ICAJCQkJcmVnID0gPDB4Mjk4MTAwMDAgMHgx
MDAwMD4sIDwweDYwMDAwMDAwIDB4MTAwMDAwMDA+Ow0KPiA+ICAJCQkJcmVnLW5hbWVzID0gImZz
cGlfYmFzZSIsICJmc3BpX21tYXAiOw0KPiA+ICAJCQkJI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+
ID4gLS0NCj4gPiAyLjM0LjENCj4gPg0K

