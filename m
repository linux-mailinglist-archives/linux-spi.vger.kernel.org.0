Return-Path: <linux-spi+bounces-3347-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2630890087B
	for <lists+linux-spi@lfdr.de>; Fri,  7 Jun 2024 17:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A68431F24B5A
	for <lists+linux-spi@lfdr.de>; Fri,  7 Jun 2024 15:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49EA2194C68;
	Fri,  7 Jun 2024 15:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="KKACYwEI"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635A518732F;
	Fri,  7 Jun 2024 15:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717773353; cv=fail; b=ZYr293PSAfQet9QBNOVbkWQTbFF6oh/AFWEfAeL82mPQbInF3SF9V22z2U7uPm8K6EmNPrYBlmxYFlIORtC1dg+7Bs4zizhjynZcT0qooWVeIq3HnLYy/tFAdw2lqC69uRJS0GYIBtY6+HARFLxCaea/2ZTZIY4nHILtx1z6LsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717773353; c=relaxed/simple;
	bh=86rcjQHV7sXgsSq5cDKSCbICM6pxzJg29kI54JJap84=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ks9uAMYQoKkVa2PXpehe4MeMwAp3ZWLC0AHVq79YbQHSrxpiJkE/Hq8wegzBLsplqNSdF3WE5RfV9+jtj5SH8Lu57NH5Mqo+FrKP9JRoX2RDzm6Wxsk6/0XV4n3aXeXKMIeqhz1DK9IX3xCyc6jqmzdFkNAqNts2DV6oUpfzXoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=KKACYwEI; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 457AExXv014982;
	Fri, 7 Jun 2024 08:15:45 -0700
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2046.outbound.protection.outlook.com [104.47.70.46])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3ym09ngwmq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jun 2024 08:15:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BBy5iDW93Eiypaomq8zWK2De+PHz5MY6XhYtoFJsgE0i+M3yI4y26mc+4C/hQxQUJWiLOAXC5Rn8saeyXzLYOInUBgwRNeI/C8J3RdSxnp3T2GRZgkSa/NCRJsVV+tR5jEoJQ/WXmNKDrC5AWoCv8tbt4Bof26eIs1i0PvOqyUGTlNH8rjveHibfyV5SAEGS4rG5PEz3hxJDLNaE6xcYs27AE6M/jUxqHOmpTbJxuEWMpJFE9Ep3s8Ot0jmw/RsX3lLgR3AwznvlZdoPWoDHbJZ/ECX1OeuJUR/oHr7DGLdXDFFmFJz1qbAdf6LmPo4fQLG6EBjsofIjY7aN8FJYtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JnBGkxS7Fb6/pzvWQparREfk5p+rChV3JNSzf8hHudY=;
 b=ggmwDbS4d3RPsIj8GmJr6eXLvMW6Qhlzg5gp9NjIAKr7ERN9kDm6evaYdLM7qZktSvApO9CSsrSZ1QC1DdP+hbxHeIxMOYWJOJ6/ikUqw1NdEheaZO6gEtq3a4lgFIXuKXJNBYdusA9AxDJIOxglQRpuI8hslLGgh29CC2fvYZitW5k43ZnN3mPQUi83+DUeLfxdST3l6aGmMZHDAT376CDy5en5pmkAFOromO2wIYxUShbmPRzWWNy6rm6WtJkGE5QmGyddu2hdTn8MxHLOGVlq5oYxLPNw1LWVgL5Ibf9GgXNDtOTvNqEP/yVei+A4ekyBzBq6qjn8oYLTat0FhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JnBGkxS7Fb6/pzvWQparREfk5p+rChV3JNSzf8hHudY=;
 b=KKACYwEI0/05Ehk365ofH0gNTB63HsYW6uIbO9/I/PxwZKUO7IdSq3v51DwDzc0UDZ0Qj7rr1FvlTFf41tacqS/c0E8SWOZ8cXqDJuPyNe/46ZQx2RJ9hfJ14NAXvSbdS69tFlE8cIIgRQG1wmEWz3O9WDZq4yjfv2zFO0j8IVs=
Received: from CO6PR18MB4098.namprd18.prod.outlook.com (2603:10b6:5:34b::5) by
 DM4PR18MB4334.namprd18.prod.outlook.com (2603:10b6:5:399::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.34; Fri, 7 Jun 2024 15:15:41 +0000
Received: from CO6PR18MB4098.namprd18.prod.outlook.com
 ([fe80::5331:f53:fcd:d7e1]) by CO6PR18MB4098.namprd18.prod.outlook.com
 ([fe80::5331:f53:fcd:d7e1%3]) with mapi id 15.20.7633.033; Fri, 7 Jun 2024
 15:15:41 +0000
From: Witold Sadowski <wsadowski@marvell.com>
To: Dan Carpenter <dan.carpenter@linaro.org>,
        "oe-kbuild@lists.linux.dev"
	<oe-kbuild@lists.linux.dev>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org"
	<linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
CC: "lkp@intel.com" <lkp@intel.com>,
        "oe-kbuild-all@lists.linux.dev"
	<oe-kbuild-all@lists.linux.dev>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org"
	<conor+dt@kernel.org>,
        "pthombar@cadence.com" <pthombar@cadence.com>
Subject: RE: [EXTERNAL] Re: [PATCH v7 4/4] spi: cadence: Add MRVL overlay xfer
 operation support
Thread-Topic: [EXTERNAL] Re: [PATCH v7 4/4] spi: cadence: Add MRVL overlay
 xfer operation support
Thread-Index: AQHashOhcDTvSW4CPUa8u/IeOOVBtrG3XRWAgAUZpyA=
Date: Fri, 7 Jun 2024 15:15:41 +0000
Message-ID: 
 <CO6PR18MB4098D045C0C7F1256BB1E341B0FB2@CO6PR18MB4098.namprd18.prod.outlook.com>
References: <20240529220026.1644986-5-wsadowski@marvell.com>
 <096b0aa3-47b1-48f8-a0ed-89458506b7b7@moroto.mountain>
In-Reply-To: <096b0aa3-47b1-48f8-a0ed-89458506b7b7@moroto.mountain>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4098:EE_|DM4PR18MB4334:EE_
x-ms-office365-filtering-correlation-id: feae73ae-8f07-4f98-3c23-08dc8704b22d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|376005|7416005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?jbiq0J9wUKDDmJSBEoDaKtSS1SYKdsQzRHW4u2R7OUrb2kvrcvgNNHW8qbae?=
 =?us-ascii?Q?ws1Zb79/RRJa2KwtkO5uXVFvOEnDTsDvnsy/W3qDYe/zqrp11NhZ9906g3bn?=
 =?us-ascii?Q?RfWF7dUi9d8UDgp77l/mHM4GdKAU9FerngDix36uxXeQAPbphlmZiAKwaiX6?=
 =?us-ascii?Q?lhc6VU+lklgKGAwgMBE1DACnUb/JARKQTb13B3Vo70E7M6dC0cnrSZpDec4e?=
 =?us-ascii?Q?zZp9t4eddFtHRz5MXSCkqDTZGNFtYr3QYsMePz95rAhi9GlwmD6yibicIdSb?=
 =?us-ascii?Q?aTtXzLatjhHmLYW5N8lIlcxEnv/O43zemNl7IC5fvgSnQsstxNQmU7XeOfUY?=
 =?us-ascii?Q?m6JQWUUDLg8R/sK2VCJsVYMCjYRKyIjuLICxfQl6/KR67fpucFwJN+i/LEu/?=
 =?us-ascii?Q?O3jjWHsZKSB/6QD4d6xKh5sh0gvBCEBPgMlJkjCECy9Hn21mi0n2M8gLs8pU?=
 =?us-ascii?Q?XafpOYYIpRoWYeLr0WKFBid5t4/rAqHWjg7tEWDmGkMS0c88QUpHKZJ13yAN?=
 =?us-ascii?Q?kthBijOPVSwXIWQXMGzAigAvrhzgsOeYFqAfRGAgftskPoIZIGuHIXKqerOJ?=
 =?us-ascii?Q?jEDc17gDUL3zlT3LyDIuZfbx9+iZ+LBZVuZdF39GAexEAQtejRq2/ljZPolN?=
 =?us-ascii?Q?wJ6Syxr3wncSxNoTMjMfGOzVtur7vpuCxHif5zDyB/ZOW/WLL+VXYzFYSbyh?=
 =?us-ascii?Q?/RzOC8afNUxPd/VxkhOtDyTZvCiN7BuVPKcf9JeyMSFq3R2G9ux/jdpMJtFW?=
 =?us-ascii?Q?pxUdIOBolgSMJUEFo1ZgFXmPjnanArivUb9fDL3vYULnUuITlgLs6mI830yw?=
 =?us-ascii?Q?7QUNaS3jmXCfc1z6VcHbhfIJVCYBWhVkfiES8d+BlvaJT5l8Gny3ytfmaWAD?=
 =?us-ascii?Q?5bNfYjHxaEYPFJkE3MKFFccM6VkzVRo/Xx8w+4bM7jWW73t+HdEuiBJZwEQj?=
 =?us-ascii?Q?wsvKZA2rV7TbEEx3VNr4RHsqg+FpF+5hcHzEPRt8yMUCDjrS7QeVCA1kmwB4?=
 =?us-ascii?Q?eDdid4EUOPFFBEqQTncOX2MXL9ggPhRCcDAAPfjqtgGIBGT8Flh25b76n1qV?=
 =?us-ascii?Q?FtozcaaGe7jd5l8l3aZahDm6xMgsdeIC2lCcVo3dCP6HFccI4XrPXHN7aPRx?=
 =?us-ascii?Q?LvikZyMwpJ0ci/Sf7imwPe/KgAMk1F1LNNhlHux+0cLNqJN2TNOvLpEgLA5l?=
 =?us-ascii?Q?mxf501mG7gwjA7rbQVqaZ/vS2/cTngvaBT9I7y2YLnaKkSL4fxhm/4OpXBl6?=
 =?us-ascii?Q?kSEzZWsT9NMxR8BtWEwwXSgUd/zDQt36j66TrEBqUR2EeKwff0uGeCY1pTe/?=
 =?us-ascii?Q?VJ6u79n25DgSEVChcJDMOUQb?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR18MB4098.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?6F62qhfbIPr3uTnUrGnK7xnfWPCjsSlRCs/bj8wCJuN92Tss/T3Py46wPslv?=
 =?us-ascii?Q?O3oZSydGR0kkt7JFMF5gpg9+nLiNgjeK6nEElNdHhDPIFmAOT54Y7aWCrrYD?=
 =?us-ascii?Q?E42gsju/DUcaY0Zg/qskGX3BKua5v9oVhEm33VNUYYoKqgsqc96XdKRIbAQu?=
 =?us-ascii?Q?tZRWwli5FJqHECDHhLDb9qnkw9erMpMrH7woCbcjJ3tdSK3eW+WJ0e1IOdIm?=
 =?us-ascii?Q?h91VZSENGhNxoNjqwrayOV0LxRF4A+VewuHzGduMBfrjiMQH93oWa8ghdjEY?=
 =?us-ascii?Q?7/W8lb3hxdAfbmtP2Wx8b1xMpNKYYV1JmB9aW1r0alcRKcFBjfxHJg5luadn?=
 =?us-ascii?Q?Z86byB2dHaV7ILoaArQTne6R8WjWAWsx+SdJLy8f63tXnvWUPOGQDz6Eoo2/?=
 =?us-ascii?Q?B9L2zEzH1wNHyBoQSHEBZBt59KaaF4PYNWpEclXnIsNQ8feGdG4/oT/HZB+Z?=
 =?us-ascii?Q?5k7bASYM+14XLNx6Mu2dbnCF3BpyAqVE7htn5S9NV5wYZp7qEM75+35VH3EO?=
 =?us-ascii?Q?DOKsky8jOMFUGdMCEsDK42OhHhAmm7mwJxkJa52HXThKNOyigAUCzyq4G2Ac?=
 =?us-ascii?Q?6V81gh588FbZRz+uHQscLxByhTYYK2QvVbgV+UTS1waqMgbfHOQcjAqEc3IJ?=
 =?us-ascii?Q?rnW3pg+7JFLF/dCxEz8hYm2xmdnAoYyNAtobKEtEI2j44kDIylJpOci5Ro4K?=
 =?us-ascii?Q?rP2TNRHzezGraArBHcUiM8HNDyTTvPcB1ZdPq2nZKiOST9DGyi/FEvZ8CNTs?=
 =?us-ascii?Q?o+tgqbhThhogPPLjq3eTdA6dB7JJER81dXBD6LAjO/Y9+BUJ4b4uUgAIkinb?=
 =?us-ascii?Q?74vWl3PF62ZpBJ8PM1dCp3uKR8xw2U+FIGE5A5habLAEAgAVE4PFTepC3VjX?=
 =?us-ascii?Q?0oFU992YrqEykG1SnTLBil1N375NTYm5Xc3jinCeeHLgtIVxlsH2IxCPmkWY?=
 =?us-ascii?Q?xXK+09rwMn9wlwHTnUyXyJOkHoz3ny2gj088FpOmC/cBSwh+TB/pDRs1Rzwb?=
 =?us-ascii?Q?S0H4+3vWE0VnGFmXtbpIswi7TDlbxtHRxbEYK2HygBZZ7yHSVfqX+It/OQtU?=
 =?us-ascii?Q?4m0lCgphlp1Ipge2xj65pAnpVKkZJZZ4yTIRLC3Om2Y+vchDvsQLwbXwgsiE?=
 =?us-ascii?Q?1UryNA8/Kdy9m73UVRVtlxNkQ4F0VR2AIykhhw2FQp7tsTh/Z3KWZLriEXtt?=
 =?us-ascii?Q?ILgXA8DSteLtn6PQyQag1zMQNvpvXlBRRIwDym4wGdAupxDc6EgW4HiIOgGJ?=
 =?us-ascii?Q?NUcuByYj/pvyWzUOegiYhDQlMcciTQrOC6GY9BivUJ07xG3TkBA5slK0M0DG?=
 =?us-ascii?Q?fTlrl06G8HrFZoAK3i0TyRTgQYJcsaKh2lWPIFk7xJAOozATcGXpM7Pc+ukP?=
 =?us-ascii?Q?ehJpFNM/m7ojOldbj/6yC18HFeaxHT3j0+CkXKKvcSIoaI03iGn8zRZgFP+1?=
 =?us-ascii?Q?NA6dHTjyZNoysQIYeWRrzsuIGCGKh0+EORdOxzQ1if1jzx/RZk5RmcKNMF3U?=
 =?us-ascii?Q?90NGeb8xoolIJhAa2bu6+eQa+fGOr0H1PJ1EaKgSlJNHqB8urm3k4eeX4gwr?=
 =?us-ascii?Q?32Xn7sbLXfM1ldAbbqtlf3hFF3fboaWuaCWsNEky?=
Content-Type: text/plain; charset="us-ascii"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: feae73ae-8f07-4f98-3c23-08dc8704b22d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2024 15:15:41.8679
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NidqZVdO43bsCLK8cIr3uwsr4OemwcRbX1R3W7xZp27Ectq1a6xbASRqyhCiyZzJgPUF1n6cIaMso7+U598qhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR18MB4334
X-Proofpoint-GUID: 9K_sLoRqi20rrSXDgUqF2pUsAyYuPI6k
X-Proofpoint-ORIG-GUID: 9K_sLoRqi20rrSXDgUqF2pUsAyYuPI6k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_09,2024-06-06_02,2024-05-17_01



> -----Original Message-----
> From: Dan Carpenter <dan.carpenter@linaro.org>
> Sent: Tuesday, June 4, 2024 11:22 AM
> To: oe-kbuild@lists.linux.dev; Witold Sadowski <wsadowski@marvell.com>;
> linux-kernel@vger.kernel.org; linux-spi@vger.kernel.org;
> devicetree@vger.kernel.org
> Cc: lkp@intel.com; oe-kbuild-all@lists.linux.dev; broonie@kernel.org;
> robh@kernel.org; krzysztof.kozlowski+dt@linaro.org; conor+dt@kernel.org;
> pthombar@cadence.com; Witold Sadowski <wsadowski@marvell.com>
> Subject: [EXTERNAL] Re: [PATCH v7 4/4] spi: cadence: Add MRVL overlay xfe=
r
> operation support
>=20
> Prioritize security for external emails: Confirm sender and content safet=
y
> before clicking links or opening attachments
>=20
> ----------------------------------------------------------------------
> Hi Witold,
>=20
> kernel test robot noticed the following build warnings:
>=20
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__git-
> 2Dscm.com_docs_git-2Dformat-2Dpatch-23-5Fbase-5Ftree-
> 5Finformation&d=3DDwIBAg&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3DGKgcn-g6ZX-
> JmCL3S2qKgVQhvhv7hu2n8En-dZbLTa8&m=3D3T1y56pUB9HOjzo3-
> EL5gF5YmRfjS2So3PliL081jziAvO4ArfnIo9RLWQtkHevL&s=3D07hYvagESNc9n4j7O0lrz=
ZcF
> lmVTYeR4d95yszqqbbA&e=3D ]
>=20
> url:    https://urldefense.proofpoint.com/v2/url?u=3Dhttps-
> 3A__github.com_intel-2Dlab-2Dlkp_linux_commits_Witold-2DSadowski_spi-2Ddt=
-
> 2Dbindings-2Dcadence-2DAdd-2DMarvell-2Doverlay-2Dbindings-2Ddocumentation=
-
> 2Dfor-2DCadence-2DXSPI_20240530-
> 2D060250&d=3DDwIBAg&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3DGKgcn-g6ZX-
> JmCL3S2qKgVQhvhv7hu2n8En-dZbLTa8&m=3D3T1y56pUB9HOjzo3-
> EL5gF5YmRfjS2So3PliL081jziAvO4ArfnIo9RLWQtkHevL&s=3DL5rHOjcT7_LtRsrf-
> 8usYbyZ1nygU8VSbseBArBD4Gw&e=3D
> base:   https://urldefense.proofpoint.com/v2/url?u=3Dhttps-
> 3A__git.kernel.org_pub_scm_linux_kernel_git_broonie_spi.git&d=3DDwIBAg&c=
=3DnKj
> Wec2b6R0mOyPaz7xtfQ&r=3DGKgcn-g6ZX-JmCL3S2qKgVQhvhv7hu2n8En-
> dZbLTa8&m=3D3T1y56pUB9HOjzo3-
> EL5gF5YmRfjS2So3PliL081jziAvO4ArfnIo9RLWQtkHevL&s=3DZ49n1j1P9sWiOEwpdOUyP=
isI
> LleXaHHWL3gqPnZMnjY&e=3D  for-next
> patch link:    https://urldefense.proofpoint.com/v2/url?u=3Dhttps-
> 3A__lore.kernel.org_r_20240529220026.1644986-2D5-2Dwsadowski-
> 2540marvell.com&d=3DDwIBAg&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3DGKgcn-g6ZX-
> JmCL3S2qKgVQhvhv7hu2n8En-dZbLTa8&m=3D3T1y56pUB9HOjzo3-
> EL5gF5YmRfjS2So3PliL081jziAvO4ArfnIo9RLWQtkHevL&s=3DenzvWq1OJNu52elgRFFsd=
NYY
> M66--SRJXq13KKmZycI&e=3D
> patch subject: [PATCH v7 4/4] spi: cadence: Add MRVL overlay xfer
> operation support
> config: powerpc64-randconfig-r071-20240531
> (https://urldefense.proofpoint.com/v2/url?u=3Dhttps-
> 3A__download.01.org_0day-2Dci_archive_20240602_202406020007.yDo5EI4r-
> 2Dlkp-40intel.com_config&d=3DDwIBAg&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3DGKgcn-=
g6ZX-
> JmCL3S2qKgVQhvhv7hu2n8En-dZbLTa8&m=3D3T1y56pUB9HOjzo3-
> EL5gF5YmRfjS2So3PliL081jziAvO4ArfnIo9RLWQtkHevL&s=3DXlRP4onlzTi33VFScF3JK=
a8D
> gPsSALAwrYapdtVzgy8&e=3D )
> compiler: clang version 19.0.0git
> (https://urldefense.proofpoint.com/v2/url?u=3Dhttps-
> 3A__github.com_llvm_llvm-
> 2Dproject&d=3DDwIBAg&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3DGKgcn-g6ZX-
> JmCL3S2qKgVQhvhv7hu2n8En-dZbLTa8&m=3D3T1y56pUB9HOjzo3-
> EL5gF5YmRfjS2So3PliL081jziAvO4ArfnIo9RLWQtkHevL&s=3DndehxuXJ9Np2ZrPiPcWAZ=
V3K
> CIWkfsgKavjDFYmr5s8&e=3D  bafda89a0944d947fc4b3b5663185e07a397ac30)
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new
> version of the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes:
> | https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lore.kernel.org_=
r
> | _202406020007.yDo5EI4r-2Dlkp-40intel.com_&d=3DDwIBAg&c=3DnKjWec2b6R0mOy=
Paz
> | 7xtfQ&r=3DGKgcn-g6ZX-JmCL3S2qKgVQhvhv7hu2n8En-dZbLTa8&m=3D3T1y56pUB9HOj=
zo3
> | -EL5gF5YmRfjS2So3PliL081jziAvO4ArfnIo9RLWQtkHevL&s=3DoMyRM-yKxK3MXd83MB=
K
> | fR__LIwxmob86rs5qIz1iV6Q&e=3D
>=20
> New smatch warnings:
> drivers/spi/spi-cadence-xspi.c:955 cdns_xspi_stig_ready() warn: signednes=
s
> bug returning '(-110)'
> drivers/spi/spi-cadence-xspi.c:967 cdns_xspi_sdma_ready() warn: signednes=
s
> bug returning '(-110)'
>=20
> vim +955 drivers/spi/spi-cadence-xspi.c
>=20
> 66e19aa5a2e022b Witold Sadowski 2024-05-29  951  static bool
> cdns_xspi_stig_ready(struct cdns_xspi_dev *cdns_xspi, bool sleep)
> 66e19aa5a2e022b Witold Sadowski 2024-05-29  952  {
> 66e19aa5a2e022b Witold Sadowski 2024-05-29  953  	u32 ctrl_stat;
> 66e19aa5a2e022b Witold Sadowski 2024-05-29  954
> 66e19aa5a2e022b Witold Sadowski 2024-05-29 @955  	return
> readl_relaxed_poll_timeout
> 66e19aa5a2e022b Witold Sadowski 2024-05-29  956  		(cdns_xspi-
> >iobase + CDNS_XSPI_CTRL_STATUS_REG,
> 66e19aa5a2e022b Witold Sadowski 2024-05-29  957  		ctrl_stat,
> 66e19aa5a2e022b Witold Sadowski 2024-05-29  958  		((ctrl_stat &
> BIT(3)) =3D=3D 0),
> 66e19aa5a2e022b Witold Sadowski 2024-05-29  959  		sleep ?
> MRVL_XSPI_POLL_DELAY_US : 0,
> 66e19aa5a2e022b Witold Sadowski 2024-05-29  960  		sleep ?
> MRVL_XSPI_POLL_TIMEOUT_US : 0);
>=20
> This works but from the name you would expect it to return true when it's
> ready and false when it's not.
>=20
> 66e19aa5a2e022b Witold Sadowski 2024-05-29  961  } 66e19aa5a2e022b Witold
> Sadowski 2024-05-29  962 66e19aa5a2e022b Witold Sadowski 2024-05-29  963
> static bool cdns_xspi_sdma_ready(struct cdns_xspi_dev *cdns_xspi, bool
> sleep) 66e19aa5a2e022b Witold Sadowski 2024-05-29  964  {
> 66e19aa5a2e022b Witold Sadowski 2024-05-29  965  	u32 ctrl_stat;
> 66e19aa5a2e022b Witold Sadowski 2024-05-29  966
> 66e19aa5a2e022b Witold Sadowski 2024-05-29 @967  	return
> readl_relaxed_poll_timeout
> 66e19aa5a2e022b Witold Sadowski 2024-05-29  968  		(cdns_xspi-
> >iobase + CDNS_XSPI_INTR_STATUS_REG,
> 66e19aa5a2e022b Witold Sadowski 2024-05-29  969  		ctrl_stat,
> 66e19aa5a2e022b Witold Sadowski 2024-05-29  970  		(ctrl_stat &
> CDNS_XSPI_SDMA_TRIGGER),
> 66e19aa5a2e022b Witold Sadowski 2024-05-29  971  		sleep ?
> MRVL_XSPI_POLL_DELAY_US : 0,
> 66e19aa5a2e022b Witold Sadowski 2024-05-29  972  		sleep ?
> MRVL_XSPI_POLL_TIMEOUT_US : 0);
> 66e19aa5a2e022b Witold Sadowski 2024-05-29  973  }
>=20

Ok, I will rework that to return non-inverted value.

> --
> 0-DAY CI Kernel Test Service
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__github.com_intel_l=
kp-
> 2Dtests_wiki&d=3DDwIBAg&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3DGKgcn-g6ZX-
> JmCL3S2qKgVQhvhv7hu2n8En-dZbLTa8&m=3D3T1y56pUB9HOjzo3-
> EL5gF5YmRfjS2So3PliL081jziAvO4ArfnIo9RLWQtkHevL&s=3D7_g-
> spW_lOA62MlydcNUrv_58Ua2UFcfpe6GmRUHskQ&e=3D


