Return-Path: <linux-spi+bounces-4079-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F168940ECA
	for <lists+linux-spi@lfdr.de>; Tue, 30 Jul 2024 12:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA5F71F23574
	for <lists+linux-spi@lfdr.de>; Tue, 30 Jul 2024 10:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF91C198A31;
	Tue, 30 Jul 2024 10:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="HZ9oT61T"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6368E198A2C;
	Tue, 30 Jul 2024 10:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722334676; cv=fail; b=rGAZrt9LzoFfOJrRCoGbeKOqlj6+VSSR/+ts4mSwccv0sVNxc2EIR+8IJmTJJdXJDf17yzMGBP8m7q7xFXckwfACDchKixMSbI2R3JvDfp7Jio4cB9dmg2DZYiDk8BmZSstREbtEecLBbO9Bxhoc64X3dG0M1lw2fkkXM3xKFWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722334676; c=relaxed/simple;
	bh=B7GWLUfAXHgcEDHCSkPL5LUJmbCIJDinZsn05J9Eaqs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FQ70P+/U2K5KO1480n9yrI5qslajm9tJWOjQDZCtjrkOva2SOhEZ5VAYCX/M6NkUxSI8HYYaOWZUemT8S1LOeyS9eQmez7dD91Da87ePgweOxYmg3MLnnOykH6dx67XCMigmgnikE2Qa6c0/4t3Xxk8IcMMiizSX81LPPLS3FiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=HZ9oT61T; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46U0TE16001890;
	Tue, 30 Jul 2024 03:17:46 -0700
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 40pnp5hrkd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 03:17:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SiMcRCE0FcjOWcB1ki827IN9hxVxD3Cc/ujfvbZkTdRSrZVcvEICY/+81uBWImaTsM4J9iccW5t1N+Wuqs2+5rcf715lQVUWkIMSrcoebeKUJ0d/jz4xEap6Ooi8SjrT1yhcoAwrNQpP2HMmldjVvCDxaskTNxsQRN/07r0naquK0ryZSuc2bPIDPo7bD5TuuquqrGaN2FKOiugrAuxHgNYmBTcL8vv0YkI8h1tVWqMBV2DXfoLB1WPeW0QZ/yS+tPrnOvsaPjFN+IntWrrxbFyt8ar6Rq3xD8md1Tku8L+3k3vziqZSLC01Qrn3FMczIM7KEmqo+QvF+2s9GGozCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bbay8HbqUwbh443S1+Tr/HgHHgt2EDTMO75tgYH8jNE=;
 b=DPoy1LcBwkpmRZUuRC7kColgn4pWLoe0p1aCqg5PAdU4zaY7F5WCRPwBZhvQQaRCFUDMQt6G5kYOfOsjoNuUMH7JPey+qxvlUINccTZyDkWh9EM1sVlBMZ7kVUF2PIao3J5cImstTe4fO0bOcCvjPdTOkLPxp6xlYRL1WgHbrVknxoJbiY6qRx2Ey6IzXj1ynLxMxiEdjR9VYm1iWcDEwTADgHUJlUX19Qm3CxbuCR906RApCo3h2kCD0dD5h/RwxnCxiW3Pk17DtffZc//HdFnHF/N1tFf9kIKX13/js5R+lxnenv/W4LzaSHmHLmN46NOMGM83CCjUNunMj4U2oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bbay8HbqUwbh443S1+Tr/HgHHgt2EDTMO75tgYH8jNE=;
 b=HZ9oT61TJXCnclXePesG2iJYbv0wuKd0+K1WKo/F5d+DshWejdTjbBFWnuCWbDQq7IUaaJiD4Lw6FtSGmjtGTFd4zUQi08gm6eNVBqhac8XUcoBuufELox9yLdKVBa6qFZdhdH0Uq/BY/vsTL/u/go0PsmkfNIRaxm8hEX9QxmE=
Received: from CO6PR18MB4098.namprd18.prod.outlook.com (2603:10b6:5:34b::5) by
 CO6PR18MB3810.namprd18.prod.outlook.com (2603:10b6:5:347::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7807.30; Tue, 30 Jul 2024 10:17:43 +0000
Received: from CO6PR18MB4098.namprd18.prod.outlook.com
 ([fe80::5331:f53:fcd:d7e1]) by CO6PR18MB4098.namprd18.prod.outlook.com
 ([fe80::5331:f53:fcd:d7e1%3]) with mapi id 15.20.7828.016; Tue, 30 Jul 2024
 10:17:43 +0000
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
Thread-Index: AQHa3eDeT7hCoHXe6U2h+hko158rtLIO+EEAgAAbc9CAAAJ1gIAAAQ4V
Date: Tue, 30 Jul 2024 10:17:43 +0000
Message-ID:
 <CO6PR18MB409801B2DCFEAD204F784711B0B02@CO6PR18MB4098.namprd18.prod.outlook.com>
References: <20240724154739.582367-1-wsadowski@marvell.com>
 <20240724154739.582367-5-wsadowski@marvell.com>
 <CAMuHMdWnd8BOLVXpAy8CoFqKzYhp+vj6un=w7Umpo6OQ=Nxqng@mail.gmail.com>
 <CO6PR18MB4098B578E6DED1FF39C3ECF1B0B02@CO6PR18MB4098.namprd18.prod.outlook.com>
 <CAMuHMdUbTm++Vcf8f-wAnHgXF4wgJydE3dAn2hO0oAiTtMkouQ@mail.gmail.com>
In-Reply-To:
 <CAMuHMdUbTm++Vcf8f-wAnHgXF4wgJydE3dAn2hO0oAiTtMkouQ@mail.gmail.com>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4098:EE_|CO6PR18MB3810:EE_
x-ms-office365-filtering-correlation-id: 9a2a41b7-af02-4f50-75b3-08dcb080d9e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?AYnHU3CZ3R1FbUjnWovX2hjNqAfEMUsWEBEat34jMSOvwTlyfLTI9f+nc5?=
 =?iso-8859-1?Q?REetmzz5u2xcTwNPtiL+RGmB2arAnxts4GJl3bSsx4FwKJXlLZc6hXYbN9?=
 =?iso-8859-1?Q?NJddbPe85eNxh88w+k+gzTLcH2JX7hGycFH2Pr4LHahLbM7jSlH7V/W8Yg?=
 =?iso-8859-1?Q?AtgvRZy7xjPEhpK0UUgb8yVdtLvAvNjpcSFTsLtYpC3IXK7/It33/qIRzY?=
 =?iso-8859-1?Q?2ODR3T+oGiue/gICtWrHh8K+9FkxyCskH4s+CD4vRSGFHXw1s4PGFhK1Aa?=
 =?iso-8859-1?Q?Xexr7cUKBsWj++vZlMWpmDOMxWj05bGf92nddp++yvE0H7+VCk6qnEqDIV?=
 =?iso-8859-1?Q?aq6extSOLDdqAorCx6UMrZ2nrphDtPR2xu534sRpC26F5TgqA6i+OFeyuo?=
 =?iso-8859-1?Q?f6RWfY8VrDtpTK7NdtTV/TsO7gLkSg8r+6I/Wr7gGBH651SXm3JNGy89X4?=
 =?iso-8859-1?Q?akv/AeUhpO+jONae+8WGqS07KHSwykiVvz/su0ZiUrzRkUH3Di7AW+vYAs?=
 =?iso-8859-1?Q?/Gmm1VyUQrMXuaiK/El6vYICqEegeWTRamyuUFzetjHMnhJtJoXbjjeH4J?=
 =?iso-8859-1?Q?x+sr7cU6d3M5G1SdeEKljyebzLi6sQ+WcoJkr3xhuuKk8GEJ/7GIxV+/SW?=
 =?iso-8859-1?Q?FIyFzoZqZAOL1yJGV8ljXXFSGY/OIzcr5hb2/3+U79FpLP786Z+1Kumhrw?=
 =?iso-8859-1?Q?zG3B2sXC2nnn8EpAEQabTra5cbgGxt8/yaFvNCLSHr/+9FuvwniVFqlVIB?=
 =?iso-8859-1?Q?giBk3k/us2mYjoA/7Qx3r1ix+gBMSmNTe/gZuwdaLlCKAohK+OJVv/VbGX?=
 =?iso-8859-1?Q?nKhUBRjT6o8wmswXJz/ubRV3gCKu7tGaP8bmobARHyMgJA3V2203GjwHfx?=
 =?iso-8859-1?Q?ioqgEP6REzqqa1GNtdB48kZ3gvMDKaTdup8QoQG1xm27ekECUXSTLRFvRE?=
 =?iso-8859-1?Q?XY9E3SRwahQcrQy/GkAWu6ntZDiL/Q3mcSMCpVTfP3h0XorSIULqyU+UA4?=
 =?iso-8859-1?Q?G8hSepdPIwsGqNMxVLgV4YDgakDJG2t+viWEtY7k0vTPrUYKz5d5XCLmRB?=
 =?iso-8859-1?Q?eS7fyvOwBportk9Iv+46YBaHqJxNmr5hfOL9R0G9PiuF9sruAcvBwmdoJn?=
 =?iso-8859-1?Q?Lhjgc/XJM2ibFNmKQS1S8uMWxprNZUB+JHXDOuc8fBpJeywlATxt5XPz9B?=
 =?iso-8859-1?Q?31MphLayGYR39H8KdHBoL0JuiNDS6W6od6UZnqUab8izn5wbCQiMoeFS+0?=
 =?iso-8859-1?Q?5yjmvvJmJj1lUYiuDhpnS51k7m4YmAG2zAVBbFjjywtkvUavliPftc3OKY?=
 =?iso-8859-1?Q?cubucBUyktAEq3s6eUParvJM5lD0ygxLkdYMycf2VQQIz4EjHC6kzw+FXb?=
 =?iso-8859-1?Q?YwXh+lQRT2oz76DNkCQcuf7fC8m2aPZSzzNM8lZCaq97lC8G1IwwIZd4dO?=
 =?iso-8859-1?Q?IPSk2J/hNNj0yRnt0g0bRpxEIa2yn0YmLzAnCg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR18MB4098.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?t8z5UnTL4Rkt97KOfYvYeuhKA3sMP3m0scg7/EuVegdex77MRYE+RBiSRe?=
 =?iso-8859-1?Q?GInigV7DMJ/+FRd1PVMGnx0qO0jNl4Ei01b7RpTqpylMAIDqyI1QpbddxB?=
 =?iso-8859-1?Q?jSbs1SVOMWrsxEHTbSXgNJ4S4utoeF+QcV1dMY4P/U/BHpJ8j3QQK6CehZ?=
 =?iso-8859-1?Q?WEdNglBo2fi2tppjK9VVjp48++07km3MhEdxSAn1O20z4yhDYs2SGPJ1uf?=
 =?iso-8859-1?Q?Ru/QhQPBq3rS4YIT+tQ0I1P2Lbuil7Ioc/a1S7GS2NRAkFyOF/KBnjLpTe?=
 =?iso-8859-1?Q?Frwb9ei6dFsRFhjWwO3jUn3Afw9J1qLGxKfPaC5G/RvKL5U+g73XvEi1Pn?=
 =?iso-8859-1?Q?72GsLFjKyD2F5Ayb/0IlWtUOIy44Rg3b66RaPzOhNc7hGbIVopfZ5fr08H?=
 =?iso-8859-1?Q?VkqYDrTR3WYckXL6tXEZMRRDJNSYIMBGIT8TUzs1wAzVju0rqoWIVQF4lj?=
 =?iso-8859-1?Q?eufdEQ09MSaf97aoOO4fW7URAIZUT5fimHZsA+iuH0YUztH4X4FVdprQlH?=
 =?iso-8859-1?Q?rOQ+HnVddAVLwhQfV7I12TUmQ5bbFdQU7CgFamRmk3UWfCyOFMHF5r3ZVD?=
 =?iso-8859-1?Q?yKBmrq+0hNT4IXT4l1zWpHqEh9p6H6eYAAD24U4/l9fTlY7HA1hMuHh7yg?=
 =?iso-8859-1?Q?LuaueWmPhSEIkYsx8hn3UWhE08UNkbQ3PRRPzjMMLE2LRiDaik3uS47T4r?=
 =?iso-8859-1?Q?ZMFicWS2rm6TY7ucy6ZyQhtJ+XJGtbPxHxrk9RBKKZQMQzpHllACZjFHaI?=
 =?iso-8859-1?Q?V7ikLH9o2Kbqy5KEzRM9OVxvedwA42rVEeTuMdS8dNqL2uSJn4KaQSkYtW?=
 =?iso-8859-1?Q?/DyiKqXyW/9wnhxZ9q8YheTfQnNIMqD8JJ293pgitpN9SUUDSbo+wYhM0u?=
 =?iso-8859-1?Q?CBcsmQLOed67MCie7jOYTRjeEbgkVFN3jXuijzWRN+egG1NHNvG0bT4qjt?=
 =?iso-8859-1?Q?LAjUwa2gArxpVmjBJkZSIveBnPSDNVoSYK5KmUuQCbwh2yDphsLVqoQEMo?=
 =?iso-8859-1?Q?NSqHaZIFIFvrN2Iupfwnlaan/pZGyMM120XZYuP0adzZDm9CxxBEHOn2lZ?=
 =?iso-8859-1?Q?28o2fejokCij9ioPGKYQya/jJbUhSKZmksQX6LKGnnp3NbV4/BVlHZ6gij?=
 =?iso-8859-1?Q?YqoO4PcRR+e47zM79AF9izZ0Pbems7CyardwD2w7fs2NVEu8S6i9TLblVw?=
 =?iso-8859-1?Q?XgPo02micqP3xCjA1rgPpNmxSRhPCkoa01kjHW3uR5tkfQ1Lj/tTnynCP3?=
 =?iso-8859-1?Q?j5bpWcIoSYsakJ3/V4fcLl19PUXCihkRVLMKuG4h0c4SaXjTDvCyqFf1df?=
 =?iso-8859-1?Q?aK1PLyTDcI7VxdvRLZ/cq3K4hqsou5UOEKGx35ICfqAgxWixbi2EQ36VoM?=
 =?iso-8859-1?Q?KFxz70XCifmGKhCT5TXAXfib7WemXmDUmp6h1pXRHIM0rSaipahZE0cEZf?=
 =?iso-8859-1?Q?+0O9Uh5qUCNqppF5kCZnKdwLJlwf8MbgJCoD7wgG6uVu+3nkZZjoAb/Y3y?=
 =?iso-8859-1?Q?hOy+QnMn5jBuTS03OUODdmXy2hpU19KNPww5S4k9ybkzYuyr0r1liooaIv?=
 =?iso-8859-1?Q?IvL5M5TLyzvkyj62OurPt335i9uWPg1oEaRhzLQpzHLJChOPZQvczrOCNK?=
 =?iso-8859-1?Q?2MzhP/atJQ3Uvm6GGgI++TBoTafWteYiVD?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a2a41b7-af02-4f50-75b3-08dcb080d9e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2024 10:17:43.6920
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YysGY2CS2NfejKLm0gJjcLpdM3VajQszTMx2ebFkhJ2kgQ6Nfs7DoGRKQMqDMtgq3IojW7IfYMqSKcpv2CJWpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR18MB3810
X-Proofpoint-GUID: ob_wvxdwYhfa3d_p1kyS_wNC0G8Gszix
X-Proofpoint-ORIG-GUID: ob_wvxdwYhfa3d_p1kyS_wNC0G8Gszix
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-30_09,2024-07-26_01,2024-05-17_01

Hi Geert=0A=
=0A=
> drivers/spi/Kconfig, config SPI_CADENCE_XSPI:=0A=
=0A=
>   -depends on OF && HAS_IOMEM=0A=
>   +depends on OF && HAS_IOMEM && 64BIT=0A=
=0A=
Can that be send as separate patch, or whole patch series should be updated=
?=0A=
=0A=
Regards=0A=
Witek=0A=
=0A=

