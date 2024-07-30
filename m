Return-Path: <linux-spi+bounces-4077-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A447D940E9B
	for <lists+linux-spi@lfdr.de>; Tue, 30 Jul 2024 12:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 322FD1F25A2B
	for <lists+linux-spi@lfdr.de>; Tue, 30 Jul 2024 10:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19373198833;
	Tue, 30 Jul 2024 10:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="XBDvlkQq"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88240195F3A;
	Tue, 30 Jul 2024 10:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722333985; cv=fail; b=sZQdrJzkUjjSSQqW4jMEjZOJaih4JNbbKqROL4j+tLAbTdcvf1QXdDLXcpg6RXeovYzuxAswqMg+yZg9UAeV7KlmJMKPtzwFYAqTvpoeBG1kcrca8Q77fs82xctlVVB0nmvqahEsHMAYIHGAl0vG2SCYILCmxONcD9w17lRTaCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722333985; c=relaxed/simple;
	bh=HKaifQ4HSdOFexH03Ae8gx7jtMhxVl1ltj8yRMGO9jU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DymOu8jQYHFLDn3rDLUp4ksn9/iaxpn7giUo3JxKrmJQLzIpS9bUXX4XOwI6yNE8ioJxyKxtzZjiAKEGGLs7WWHbTOSv5OIhchdVrUQak9UNg9XiOBDXeIabAv5XrlXrliBLAAvQjQJimhfPUzSrbRK048Q86cfWFpLU0Ye+5QM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=XBDvlkQq; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46U0TEpD001901;
	Tue, 30 Jul 2024 03:06:03 -0700
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 40pnp5hqcv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 03:06:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n6Z+tQANf89Fv2BHFqCqvgNZrLMV6oRtFg1b01UtlPRdim45DOPncoQgJepyp/jWx0paXV/01q/ZH8EAhhN/7j6k6wdno5w4cmOumNlBjrrZdVSIo5nDXjTr2CqgjTTFMZBcnaJMpZDwVzUv+qGF1KbRGVUJMeY1GPNm1HJC/1AFqs81y4jD++jXFXxyJWIDHDCGjzn7E5+771tCeiRxwk75Yfr39xV1n2ODJ+1hRAh+aOFBTQTLSQDO4iv3J0vg0QoajMOxUfNkVJagEyLOqQJmMUuhrFZkaPptLg4b4lh/1tM+XC2o0WUxEaRGBS1xsJjV1gu1aqwpR7m3k3xG0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n08uEntZRK8EMmIEvzMBtp4SgziNdFLuMRpTi9EYVN0=;
 b=NXt+lnbcDTIMxXL/qbixoSb8UZBy3qOALx65RHwm0aT3qVjrAX14XGlXbb2aPxFv0HOhy1YDTprarLVHOYjZwM26P4ThZSWzzcRTZkB435zZFxQlvQgpnNwPv+fMx3oLNgD3qdJzPaaUewxTxE6Gl+bwXryV4izjv/zqAnphrq0kRuUvsLHgSRWLoSdrXRg+RwD8gc57basrIyaVO9L5+5OWtlWDwepcnCT+YhdcfCjFSmnloH1lVF0qvyqijk9ED2I/2Zcvlyy5yly4hfgoEoYZI7mIu8cxNbqQ7wOK48qm2eK8mnFJDWmUzb1sZsz5X4D6TTDIOuFxrJz56Wl0OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n08uEntZRK8EMmIEvzMBtp4SgziNdFLuMRpTi9EYVN0=;
 b=XBDvlkQqIVxExNEcmcPlV2rHJUOmEtG5wFDe6hnrtuI16KTcbIRk+d78fIzAh1eGS/ILQ22ZKLTrJlfF5dVer0USsbRK1AlvbCEqaghS4NTg8cahR2EzIT7D7SZpTrUV0v1OUzJpk+ktPJj08W9/ZMT4rQxntc4SlqelSDoZdRo=
Received: from CO6PR18MB4098.namprd18.prod.outlook.com (2603:10b6:5:34b::5) by
 MN6PR18MB5467.namprd18.prod.outlook.com (2603:10b6:208:46f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Tue, 30 Jul
 2024 10:06:01 +0000
Received: from CO6PR18MB4098.namprd18.prod.outlook.com
 ([fe80::5331:f53:fcd:d7e1]) by CO6PR18MB4098.namprd18.prod.outlook.com
 ([fe80::5331:f53:fcd:d7e1%3]) with mapi id 15.20.7828.016; Tue, 30 Jul 2024
 10:06:00 +0000
From: Witold Sadowski <wsadowski@marvell.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "robh@kernel.org"
	<robh@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org"
	<conor+dt@kernel.org>,
        "pthombar@cadence.com" <pthombar@cadence.com>
Subject: Re: [EXTERNAL] Re: [PATCH v11 4/9] spi: cadence: Add Marvell SDMA
 operations
Thread-Topic: [EXTERNAL] Re: [PATCH v11 4/9] spi: cadence: Add Marvell SDMA
 operations
Thread-Index: AQHa3eDeT7hCoHXe6U2h+hko158rtLIO+EEAgAAbc9A=
Date: Tue, 30 Jul 2024 10:06:00 +0000
Message-ID:
 <CO6PR18MB4098B578E6DED1FF39C3ECF1B0B02@CO6PR18MB4098.namprd18.prod.outlook.com>
References: <20240724154739.582367-1-wsadowski@marvell.com>
 <20240724154739.582367-5-wsadowski@marvell.com>
 <CAMuHMdWnd8BOLVXpAy8CoFqKzYhp+vj6un=w7Umpo6OQ=Nxqng@mail.gmail.com>
In-Reply-To:
 <CAMuHMdWnd8BOLVXpAy8CoFqKzYhp+vj6un=w7Umpo6OQ=Nxqng@mail.gmail.com>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4098:EE_|MN6PR18MB5467:EE_
x-ms-office365-filtering-correlation-id: 58c19f04-b910-48ed-4746-08dcb07f36f9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?73jbzA5Zsb604cLbG1WTvJeklUAK9AJngB5DXBhS2x63rtYmTP18CcG8Ge?=
 =?iso-8859-1?Q?euRFUCVKbtLtmXXGKnGJH8YaTGFjog0KFLL18EkMXBjWWUe98fbfrGSSwA?=
 =?iso-8859-1?Q?OFVwfHUnUrge5I05ObIq6tk5Lnl40ssdlKrrpflx/QPVFp1gVuz9hXhE/r?=
 =?iso-8859-1?Q?m8rIdrVXuxqlAKBYe9up3wz/0vGmlOiaeBi170A1uzmjsltuBSaFscWEUR?=
 =?iso-8859-1?Q?Y08lKljPFbO9PKbEVtekxjjQywK4mQ7dSn4u+gLEv0n3TgS04IWO43fKA0?=
 =?iso-8859-1?Q?KfSPvh9rDcf4kKSbILcXUN6vOWxk3iSAaz1IDLGMU00KntumUYLBDwS/33?=
 =?iso-8859-1?Q?U0eaYboTLe22VD22Vud0jlGVzmH+trogEuYW9r1xrOI1i3fEyq1cgkTBXN?=
 =?iso-8859-1?Q?1f7X9RkdZyqj97aZIcBTj5B6V+KFnqhmt4fniHjlpzc+Tat5KYItjAI0CC?=
 =?iso-8859-1?Q?DXwIPGUi5UbolbAuXX9Z5CE/sAsNTFkSKdSxuZPznINCbDjdPY9A2lNAKe?=
 =?iso-8859-1?Q?35srhiZmNQEjygWDvtPIIk8X4jxJPEquQGVbRPZy4Yod5qYocsKD29EpK8?=
 =?iso-8859-1?Q?tFqedUNyEp2Et8ev4EiLExNFEBb7t/UMj86W1SzBOhmKfT86XKW73CZrNk?=
 =?iso-8859-1?Q?Z5K342Z4Tu6UtFY6mTCIfx+pzCnFH01+a9Jm9aniiM2RNvthFPb53OnW7w?=
 =?iso-8859-1?Q?e3eLUvSrXX22aD3+uMNlnJfkUNQlc0mTjLaNb+i6rFqduA8e7eRznGfgye?=
 =?iso-8859-1?Q?lhPsW/3iytcH9L/S38VllSys8D8VIGtJ6V7iRo7NM16jGcCIB2nG9+qKsr?=
 =?iso-8859-1?Q?uosQxmj3BvgZjaZlKYc7g/YsfFN4OpWne7/o1iTSel/PzS7JoU8pQ51t7V?=
 =?iso-8859-1?Q?bwQMgXTtjf20Po+Q/vGSUs267Dtj79VKlicuIlVk96w17Uch0MhKEbM08Z?=
 =?iso-8859-1?Q?1oBbJ2Bkn77oMZneHTZcmyx8o4+M1cxmDzhYpXIMrt6/Qk/jnBHXMy7OHf?=
 =?iso-8859-1?Q?X33I2hFYuoSnpDD1n2W46ay/rE9vOmcZpw+ybQ0vDGDTdHSqq9WiKwqznO?=
 =?iso-8859-1?Q?8QY6Px772i2eJJV7R8L2TJf8OdaW8eVCKPi7MgzQcy+An91bMzNhqBLL6H?=
 =?iso-8859-1?Q?dTvmIRM31G6XyERbZKNVvxCTLbwXjUsv9pKnE68IX3lX1n+jvGUBSQIIYn?=
 =?iso-8859-1?Q?x8BUKphEQfWZ81Pnx37ezOmBx06oN1YlcoolibwZfad4/K5OG1N6yiMJwE?=
 =?iso-8859-1?Q?CMYHOAkGvkaTFzzuI0eciQpQbM17tVv58T5l58bf3iBfwomIXogBvrQ0E6?=
 =?iso-8859-1?Q?vj//46Yi2RiPFhp/vh1LiHREfIv2aFX0/pdw6PX2YouCuLr7Qjt1i3wmbK?=
 =?iso-8859-1?Q?AisUGPI99+Yketyb73d8diXu9xOsFQqiUuZV1PXSDGOwA+Mg4+p/RJpcSy?=
 =?iso-8859-1?Q?u7zeW4XTlRqSMcuXjgaNldhW67LE2ZY2aOtX/Q=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR18MB4098.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?mYxNCXbkDiTUShX682tLkD1AydKB8KKcJhYWaMpIj0b9NqWM/fziRJxsN1?=
 =?iso-8859-1?Q?/i0gnxCK0ZSG2NkqCOIEaTb3D4tEu6Wv+6sZALBzeg9ncSbUuzcv9vf81o?=
 =?iso-8859-1?Q?mvc1rO2ke9OzwkTdht05pYnioSrd3r2hlZZdQij0mq1KCwVomSYMNTnngD?=
 =?iso-8859-1?Q?YOU8OIGEACVEbMGLZBMbspisdJ5BKQ84lSnC9xe05/T51oa1cq2osqA+N7?=
 =?iso-8859-1?Q?4OzD/7gSv5Zlj6ZNq27fN4TZ7lFBKuF5prVTsTHgrIyv3ErJslGdbK3RT6?=
 =?iso-8859-1?Q?Tyeh+JN1PYQkkptHoWG5sNTEPmcK1n9mwaLuelIVZpSelHYsrR6ddg8P6P?=
 =?iso-8859-1?Q?QHKZKqiHTPSUpNO1CACxvyqhH9QlSRgHofsj1U9DzD0niFSuea4kVFwq2V?=
 =?iso-8859-1?Q?TzP1AZVqpEejK69AJE+kg2VUoxvJFFDXo27fgRofvaLqgtYeikgMhH3/Az?=
 =?iso-8859-1?Q?0YoutEoeucDAb8Wkzh7ttys6NvqcDI0x+Wq8KBgL3lflNNTEqv3bJTXQHq?=
 =?iso-8859-1?Q?jCiFTLxuZ2h2/g3H4nfVTp0QroY9Cf7TT7ufxYeLUp72kwBFhPKfd6XuB8?=
 =?iso-8859-1?Q?bDyp7PqMgs9PAka0vKOarmPl8fg/ZV2CoxeN/un1tq4c30DMR8an9Rbgw0?=
 =?iso-8859-1?Q?VC2zdZYBK/z7YJ25VkodtFtqMxf4ZmoYU3BLqSz+l555kCE7nSGYohjtnq?=
 =?iso-8859-1?Q?VfAikGM11Wh/i3FELEe8Pa/4DtzY4Fdc/coy3a/nqIgi6d2z+GBZe5aEs1?=
 =?iso-8859-1?Q?msCkDH4zmpXPt9u/bSyToKY322fL2bJBMBw3/4W7tZ11sjstjFtlX3CZUL?=
 =?iso-8859-1?Q?E2M8st2lqELrexRX8r0j/6m6kHbUNKOiIATvHCYB7pv4lgoBGUV4C5cZz4?=
 =?iso-8859-1?Q?zjr1Mnm82gUm80z7aVaOlJ21ghVtR6NsothSnjYQqesOP1eeo5iH6uZe0a?=
 =?iso-8859-1?Q?KLtBEt24KwcRa1MU4eH37Vu/3SLSO03ptlbWna1wJC0pH3M272JtvTe2UD?=
 =?iso-8859-1?Q?TxZmW/wbwVEnze3uYBGlTqfuR9eyP8/IHUa1A7e3IdKYGT3s8SYJodN/fl?=
 =?iso-8859-1?Q?03X+81QnidfemO6LpTSdc6xvFn7aKY5syhxIpJEVQAytXlJ0xMFi0f0S2q?=
 =?iso-8859-1?Q?qsM7kS4nac8egD32R6O/FoVR9Fn1hOWZwELIALctC0jfrUWTaQEbOnCfVx?=
 =?iso-8859-1?Q?9+anZFeRJQA7lmhCLfgwaD+Vsfrw3jBlTV9fgiQjpCMDABJ4SmTRJEev8x?=
 =?iso-8859-1?Q?uTbrbRo1noxSEvW34D15J5R5Hh4ek7yrOQ57nnFS+yYkez1vQC8SBtHaOE?=
 =?iso-8859-1?Q?FH6sB9MhjyCnL2tn1UY1/gmm0QBWintvHAwWuzMD8dV4fwVhHDOJTyWy0N?=
 =?iso-8859-1?Q?JYEcaSglnhAVctNzKBjLQKhiOw28JW7XzpY+yBRwq5mt8Dqy/OV+7fp92/?=
 =?iso-8859-1?Q?RZIVTiq2qiVWvD/7aGhqSfZjylBORn9TlcPkiSI7j5HEX/vZx2LnbjAJnB?=
 =?iso-8859-1?Q?wVhMW642ynQ2MDT7OLKucuIjM0EWFII4ZGIqoEJieUkRvDcSUoVtDMyzM8?=
 =?iso-8859-1?Q?nGTSi0iIhY0bLvrRQ4ZI7FouzEcL8YLeqda5BA1BNyyZPeGjbcq02whKWt?=
 =?iso-8859-1?Q?MJDqL7modZe7WSOWFZiAgpWoK/w10faCUA?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4098.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58c19f04-b910-48ed-4746-08dcb07f36f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2024 10:06:00.9216
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: crRXEzgR3SRRb7avGRDX6rJx1UBameX/ldPtDYUrIZva5NnQADjXP9oP3NSlXWUie3ro+WmHOdahQ+fXEOC0fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR18MB5467
X-Proofpoint-GUID: GRAi3idukjNvZfvV6VJfn4EYwoOXFXaV
X-Proofpoint-ORIG-GUID: GRAi3idukjNvZfvV6VJfn4EYwoOXFXaV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-30_09,2024-07-26_01,2024-05-17_01

Hi Greet=0A=
=0A=
=0A=
> drivers/spi/spi-cadence-xspi.c:612:33: error: implicit declaration of=0A=
> function 'readq'; did you mean 'readb'?=0A=
> [-Werror=3Dimplicit-function-declaration]=0A=
> drivers/spi/spi-cadence-xspi.c:638:25: error: implicit declaration of=0A=
> function 'writeq'; did you mean 'writel'?=0A=
> [-Werror=3Dimplicit-function-declaration]=0A=
> =0A=
> =0A=
> readq() and writeq() are not available on 32-bit platforms, so this=0A=
> driver has to=0A=
> depend on 64BIT (for compile-testing).=0A=
> =0A=
> > +                       *buffer++ =3D b;=0A=
> > +               } while (--full_ops);=0A=
> > +       }=0A=
=0A=
How can I limit that driver for 64bit test only?=0A=
=0A=
Regards=0A=
Witek=0A=
=0A=

