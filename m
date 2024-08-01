Return-Path: <linux-spi+bounces-4116-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E03E94445A
	for <lists+linux-spi@lfdr.de>; Thu,  1 Aug 2024 08:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D809A28801F
	for <lists+linux-spi@lfdr.de>; Thu,  1 Aug 2024 06:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E773A28379;
	Thu,  1 Aug 2024 06:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UCMgHJFm"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2067.outbound.protection.outlook.com [40.107.96.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1411EB490;
	Thu,  1 Aug 2024 06:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722493349; cv=fail; b=Kxu/SMJzxzwmgcmTqZwjCcgtLVdyvLvaQ3BnA/QjSqZ15P8p7kgSxEGcO4HlQC22jVNzznjJhgTYx23/JaiHLbsz+7Lq8F9Tf5IvCMgjdO449iesnTgKGW4Vw0Xuh4YCKqGELrrg61ouNsZl7OGqodGoRi/TsFVkNmJDpSNnSjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722493349; c=relaxed/simple;
	bh=vxNDMfYCFXGFYndpmR9Yc1ekISm1f9IFqpu5Mxa24YE=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G/WYjG6Y0ltAoDu5IGqmDXsYIe3HHSphgZvC7U3zOctVnOH4A55wZCr2aVTDn8PpMFBQZulaA5Fz6TUk1VYKa9otbUoXXYKyRA1NMvfBDC7x3RjrwsqF5W7Im2RhdTQLor78K2mFIvWGS44gcp8rsoCLLJUP57Y1iXS5/gL/93c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UCMgHJFm; arc=fail smtp.client-ip=40.107.96.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KnOw98ATThMPVxd23rExzIMDLD7nUvSivP8wzT5DSgEfEgiCVmuSKfH7Rzo8wuHLvJuYxbCjdrrlMJQ9PjoBhMFJpgTjUNwmg8aEd7KyGnAMkMqeLVpSrDigjjjoJs+w26SZFU4bm/7hp4d9bPkPv3oafUeT2QIAgvlZXUmdd198dpmD1fTHIm5awC+nnA4FiteJ+UijkA5xjpQ+QMb2uYG7InPCp8EA9//aRID48SHmn7LK09ZIhzlAPRaravjNGF5W/Veqo64pjvmvuKPrxTc79KxrY05dV1cCKzOGGECarcV/YJQS17DMxj5WV90pcT4DW5u7oNakHUHq4Dssnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X2GWVc/9PCBvgmkE9/m2UzLIuxn6RyPqDl9w61DiB+A=;
 b=btGJlK7OOHburgY5Q9nC5v51W2uRwAraH8rGN4eKMEKnJUZOnwUA4v7Hn86SbpYLlRyT8esmD8naTNinDlFJiHpav5htzfOyFcqrPbJB10QtiAeJrlECXrBUFvIdlWQDH2H7RIcCifrIYpv5BvQO6ai0SdDyQetO9KT3wWoBo2of+mOZaRIQChTdSqEYHCPCO0bnw0CJwz9/l7+bQFCne97g4gbLsLT756DTRVVtWtjODmnqsCTSm3EXEGu5jEp18YcsZcSqs0pwasspUsDuOThRQ8eMH7ReHyWzt8KyxUHESJbYRFauWTX/MRfZfD1FkyWlVi2snEITAxEklQ7l4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X2GWVc/9PCBvgmkE9/m2UzLIuxn6RyPqDl9w61DiB+A=;
 b=UCMgHJFmtiTW5B9dsbgyYEn3Pe5CuBzYMc6OSYLNz6qBzkFmIah6KlEAjU66KjcUOnU3cXOJrHdTE6Ya9d2BHMnncn7WAx7qn6xKOvPOOAfG6mqLOb/Gn5DmkWO1g9Lx3hAAaPD/7SmX+hqI3p0HEFDPAnwxTGS1nKxX6EIUpPw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH7PR12MB7967.namprd12.prod.outlook.com (2603:10b6:510:273::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Thu, 1 Aug
 2024 06:22:25 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%5]) with mapi id 15.20.7828.021; Thu, 1 Aug 2024
 06:22:25 +0000
Message-ID: <c01d048f-ad8b-417e-8ff0-96f9252c87f2@amd.com>
Date: Thu, 1 Aug 2024 08:22:01 +0200
User-Agent: Mozilla Thunderbird
From: Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH v11 07/10] mtd: spi-nor: Add stacked memories support in
 spi-nor
To: Michael Walle <michael@walle.cc>,
 "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>,
 Tudor Ambarus <tudor.ambarus@linaro.org>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "pratyush@kernel.org" <pratyush@kernel.org>,
 "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
 "richard@nod.at" <richard@nod.at>, "vigneshr@ti.com" <vigneshr@ti.com>,
 "sbinding@opensource.cirrus.com" <sbinding@opensource.cirrus.com>,
 "lee@kernel.org" <lee@kernel.org>,
 "james.schulman@cirrus.com" <james.schulman@cirrus.com>,
 "david.rhodes@cirrus.com" <david.rhodes@cirrus.com>,
 "rf@opensource.cirrus.com" <rf@opensource.cirrus.com>,
 "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>,
 Neal Frager <neal.frager@amd.com>
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
 "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
 "claudiu.beznea@tuxon.dev" <claudiu.beznea@tuxon.dev>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "patches@opensource.cirrus.com" <patches@opensource.cirrus.com>,
 "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
 "git (AMD-Xilinx)" <git@amd.com>,
 "amitrkcian2002@gmail.com" <amitrkcian2002@gmail.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 "beanhuo@micron.com" <beanhuo@micron.com>
References: <20231125092137.2948-1-amit.kumar-mahapatra@amd.com>
 <b3d3c457-a43b-478a-85b3-52558227d139@linaro.org>
 <BN7PR12MB28027E62D66460A374E3CFEADC93A@BN7PR12MB2802.namprd12.prod.outlook.com>
 <e212f9fa-83c5-4b9e-8636-c8c6183096ab@linaro.org>
 <BN7PR12MB280237CDD7BB148479932874DC93A@BN7PR12MB2802.namprd12.prod.outlook.com>
 <576d56ed-d24b-40f9-9ae4-a02c50eea2ab@linaro.org>
 <BN7PR12MB2802F288C6A6B1580CF07959DC95A@BN7PR12MB2802.namprd12.prod.outlook.com>
 <c6f209c8-47da-4881-921d-683464b9ddd5@linaro.org>
 <9cdb7f8b-e64f-46f6-94cb-194a25a42ccd@linaro.org>
 <BN7PR12MB28028B63E69134094D50F3E4DC2A2@BN7PR12MB2802.namprd12.prod.outlook.com>
 <IA0PR12MB769944254171C39FF4171B52DCB42@IA0PR12MB7699.namprd12.prod.outlook.com>
 <D2ZHJ765LUGP.2KTA46P1BL75X@walle.cc>
 <e1587f61-f765-4a22-b06e-71387cc49c4d@amd.com>
 <D33M26RLVLHF.3Q5YARPBNSBOY@walle.cc>
 <9fb60743-3e89-49fa-a399-3cf2607a7e41@amd.com>
 <D33S9T73M6ND.G7CCJ4PDVYQU@walle.cc>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 xsFNBFFuvDEBEAC9Amu3nk79+J+4xBOuM5XmDmljuukOc6mKB5bBYOa4SrWJZTjeGRf52VMc
 howHe8Y9nSbG92obZMqsdt+d/hmRu3fgwRYiiU97YJjUkCN5paHXyBb+3IdrLNGt8I7C9RMy
 svSoH4WcApYNqvB3rcMtJIna+HUhx8xOk+XCfyKJDnrSuKgx0Svj446qgM5fe7RyFOlGX/wF
 Ae63Hs0RkFo3I/+hLLJP6kwPnOEo3lkvzm3FMMy0D9VxT9e6Y3afe1UTQuhkg8PbABxhowzj
 SEnl0ICoqpBqqROV/w1fOlPrm4WSNlZJunYV4gTEustZf8j9FWncn3QzRhnQOSuzTPFbsbH5
 WVxwDvgHLRTmBuMw1sqvCc7CofjsD1XM9bP3HOBwCxKaTyOxbPJh3D4AdD1u+cF/lj9Fj255
 Es9aATHPvoDQmOzyyRNTQzupN8UtZ+/tB4mhgxWzorpbdItaSXWgdDPDtssJIC+d5+hskys8
 B3jbv86lyM+4jh2URpnL1gqOPwnaf1zm/7sqoN3r64cml94q68jfY4lNTwjA/SnaS1DE9XXa
 XQlkhHgjSLyRjjsMsz+2A4otRLrBbumEUtSMlPfhTi8xUsj9ZfPIUz3fji8vmxZG/Da6jx/c
 a0UQdFFCL4Ay/EMSoGbQouzhC69OQLWNH3rMQbBvrRbiMJbEZwARAQABzSlNaWNoYWwgU2lt
 ZWsgKEFNRCkgPG1pY2hhbC5zaW1la0BhbWQuY29tPsLBlAQTAQgAPgIbAwULCQgHAgYVCgkI
 CwIEFgIDAQIeAQIXgBYhBGc1DJv1zO6bU2Q1ajd8fyH+PR+RBQJkK9VOBQkWf4AXAAoJEDd8
 fyH+PR+ROzEP/1IFM7J4Y58SKuvdWDddIvc7JXcal5DpUtMdpuV+ZiHSOgBQRqvwH4CVBK7p
 ktDCWQAoWCg0KhdGyBjfyVVpm+Gw4DkZovcvMGUlvY5p5w8XxTE5Xx+cj/iDnj83+gy+0Oyz
 VFU9pew9rnT5YjSRFNOmL2dsorxoT1DWuasDUyitGy9iBegj7vtyAsvEObbGiFcKYSjvurkm
 MaJ/AwuJehZouKVfWPY/i4UNsDVbQP6iwO8jgPy3pwjt4ztZrl3qs1gV1F4Zrak1k6qoDP5h
 19Q5XBVtq4VSS4uLKjofVxrw0J+sHHeTNa3Qgk9nXJEvH2s2JpX82an7U6ccJSdNLYbogQAS
 BW60bxq6hWEY/afbT+tepEsXepa0y04NjFccFsbECQ4DA3cdA34sFGupUy5h5la/eEf3/8Kd
 BYcDd+aoxWliMVmL3DudM0Fuj9Hqt7JJAaA0Kt3pwJYwzecl/noK7kFhWiKcJULXEbi3Yf/Y
 pwCf691kBfrbbP9uDmgm4ZbWIT5WUptt3ziYOWx9SSvaZP5MExlXF4z+/KfZAeJBpZ95Gwm+
 FD8WKYjJChMtTfd1VjC4oyFLDUMTvYq77ABkPeKB/WmiAoqMbGx+xQWxW113wZikDy+6WoCS
 MPXfgMPWpkIUnvTIpF+m1Nyerqf71fiA1W8l0oFmtCF5oTMkzsFNBFFuvDEBEACXqiX5h4IA
 03fJOwh+82aQWeHVAEDpjDzK5hSSJZDE55KP8br1FZrgrjvQ9Ma7thSu1mbr+ydeIqoO1/iM
 fZA+DDPpvo6kscjep11bNhVa0JpHhwnMfHNTSHDMq9OXL9ZZpku/+OXtapISzIH336p4ZUUB
 5asad8Ux70g4gmI92eLWBzFFdlyR4g1Vis511Nn481lsDO9LZhKyWelbif7FKKv4p3FRPSbB
 vEgh71V3NDCPlJJoiHiYaS8IN3uasV/S1+cxVbwz2WcUEZCpeHcY2qsQAEqp4GM7PF2G6gtz
 IOBUMk7fjku1mzlx4zP7uj87LGJTOAxQUJ1HHlx3Li+xu2oF9Vv101/fsCmptAAUMo7KiJgP
 Lu8TsP1migoOoSbGUMR0jQpUcKF2L2jaNVS6updvNjbRmFojK2y6A/Bc6WAKhtdv8/e0/Zby
 iVA7/EN5phZ1GugMJxOLHJ1eqw7DQ5CHcSQ5bOx0Yjmhg4PT6pbW3mB1w+ClAnxhAbyMsfBn
 XxvvcjWIPnBVlB2Z0YH/gizMDdM0Sa/HIz+q7JR7XkGL4MYeAM15m6O7hkCJcoFV7LMzkNKk
 OiCZ3E0JYDsMXvmh3S4EVWAG+buA+9beElCmXDcXPI4PinMPqpwmLNcEhPVMQfvAYRqQp2fg
 1vTEyK58Ms+0a9L1k5MvvbFg9QARAQABwsF8BBgBCAAmAhsMFiEEZzUMm/XM7ptTZDVqN3x/
 If49H5EFAmQr1YsFCRZ/gFoACgkQN3x/If49H5H6BQ//TqDpfCh7Fa5v227mDISwU1VgOPFK
 eo/+4fF/KNtAtU/VYmBrwT/N6clBxjJYY1i60ekFfAEsCb+vAr1W9geYYpuA+lgR3/BOkHlJ
 eHf4Ez3D71GnqROIXsObFSFfZWGEgBtHBZ694hKwFmIVCg+lqeMV9nPQKlvfx2n+/lDkspGi
 epDwFUdfJLHOYxFZMQsFtKJX4fBiY85/U4X2xSp02DxQZj/N2lc9OFrKmFJHXJi9vQCkJdIj
 S6nuJlvWj/MZKud5QhlfZQsixT9wCeOa6Vgcd4vCzZuptx8gY9FDgb27RQxh/b1ZHalO1h3z
 kXyouA6Kf54Tv6ab7M/fhNqznnmSvWvQ4EWeh8gddpzHKk8ixw9INBWkGXzqSPOztlJbFiQ3
 YPi6o9Pw/IxdQJ9UZ8eCjvIMpXb4q9cZpRLT/BkD4ttpNxma1CUVljkF4DuGydxbQNvJFBK8
 ywyA0qgv+Mu+4r/Z2iQzoOgE1SymrNSDyC7u0RzmSnyqaQnZ3uj7OzRkq0fMmMbbrIvQYDS/
 y7RkYPOpmElF2pwWI/SXKOgMUgigedGCl1QRUio7iifBmXHkRrTgNT0PWQmeGsWTmfRit2+i
 l2dpB2lxha72cQ6MTEmL65HaoeANhtfO1se2R9dej57g+urO9V2v/UglZG1wsyaP/vOrgs+3
 3i3l5DA=
In-Reply-To: <D33S9T73M6ND.G7CCJ4PDVYQU@walle.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0130.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::28) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH7PR12MB7967:EE_
X-MS-Office365-Filtering-Correlation-Id: 52dc9349-71d1-4f8e-0eb7-08dcb1f24f20
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?emNMaS9oR3hNekdJN1FSZGlCRjhZYiticUl1dmY3OWo5UDc3czVkT3d2UFNP?=
 =?utf-8?B?QjhyZDFNMUlRRnN1YVU4ajNNN1BzMjFDbFJ6a0wvcGdQOGZ3eXZKbi8zWGxi?=
 =?utf-8?B?Uk9wb0VhTmhTa05UT1RuRWRTc1YwdXYyTjBZVUJ4M3h1QU5GSjRoTWlMWnRJ?=
 =?utf-8?B?UUFLRkZ6MFQxUGRNVlVtVW0yMElwalV2Y3B2NHVKRGs5cVM4b0MzcEp1MnZU?=
 =?utf-8?B?MWs1a3dKQmZCdmF3SXo2UmVYMk5YTGw2ZERjK0ZDcEwwUWx3NkRCMVRiRmtM?=
 =?utf-8?B?elA3YlEzLzZiWXdZTTN5eDdxNTJ1VjYreUtRVzBMckpwL1YyWTMzaHl3VWxD?=
 =?utf-8?B?ZEd6WWx0cnI3UGZSaEQ1aGtNcHBXTkdsdXlubHhPd21SQlNnTGdpUXJRYVFk?=
 =?utf-8?B?eDluRjJ4NUh2NEhYaHVXVElWbWFxL25ueXFFNExjcEpicyt6L3BuM0RMMHJz?=
 =?utf-8?B?dk5vN0tGUVVQclhYaDZDQzRQMHp6U1BzRGE1VktMMC9KWnZGa3dlSm1ZL0Vi?=
 =?utf-8?B?UXRlMytyK1BoOGVFS3hVd2RBYVV2V2E3YlNTVEhBYWJ0cElCUnUwaXNtZll0?=
 =?utf-8?B?Sm9acVo0Z3NsRDliNVhJSFIwYTI1UE5jeVJBRmV0TkI5RXp6K2tkYU4yeXR1?=
 =?utf-8?B?Nms0YUhaL1VvOEd1ZmRLdFR6bklBbnl0bzVsOTB6OVpuUXh3emt1VnFkS2V3?=
 =?utf-8?B?VFlDRWVJOGs1aDBOUzhQanZjcTRyNTdpWmZ0cXdUK0R4bkJ2U3ducVJkR01C?=
 =?utf-8?B?UnVuRmVXSUdKbWlJZUNXY2xzNHNDdThaS2lHQnp2elYxdmFEVzlZQ2pFdFhz?=
 =?utf-8?B?c2tFcHkwajBQQkpBY0VMNGNod29HUU51UVZ4V2lYaEFBOFdhUjd5TGF3UVM3?=
 =?utf-8?B?Tjc1bElsbitUUHhINU5aY2J4TE1oc0REWHlPdjFCdGpKQkNJWC9OWE9zb05M?=
 =?utf-8?B?ck9yUUFpc1pwUFB4SEw1NkszWXFoOWRhQU9FNG1ZYm5lZjV6VDdwSzBVeHlD?=
 =?utf-8?B?YmE5U01oUG4yRUNzbTg4RjNHY1FyeTJ6QWxtUUxhblIwVkJ3MS96Qk5HWUFh?=
 =?utf-8?B?a2RSM2RFMzFrbzFqYzQ3YjBrdm1yOWxmTUlhdTJGMWN5bTFDQklYY25WelIz?=
 =?utf-8?B?K0gxcFJmZzloaHk1cVV6Zm50RDJKamVUOHFnSTBiVS9wWjJTNC9KeklobC9M?=
 =?utf-8?B?R2Q3clZGNzdPa3krZFZJVjE1OE90elpHeVZuNGNsdGE1MzV5S2JCRzlFYlpX?=
 =?utf-8?B?ejg5OFpjdnpsS00zblNWSGpFbDcrK2dqaE42ZzRYQUNRMkwxS0JJYUZvaFZM?=
 =?utf-8?B?Nk92bCsvbVRlS1ZwcDNtdy9vQy9CVytQNzd3Ty8rODUrbnYycjM1dk8wMHdz?=
 =?utf-8?B?eE53YUcrVWZnVlN3ZGFxTUs1dXBzaDU0ZmFmWmtRMHQ2MXVFN2JCdk51RVZ6?=
 =?utf-8?B?VWZVVnBEdXJjaEFhRDV3NnZlU21yS3g4UzB6czdjUEVJMXhySGdvTndvWjNI?=
 =?utf-8?B?UUp1TTlZY0t3TzVoMVBOaUZncVAyMHJUbk5WOXdveDdURXVqeTB2RTJjZWQ1?=
 =?utf-8?B?S21NU04ybzI4WldoUjdrSVpaRjhvSk9oV1ZxSUV1SEp0YmpBVkE2aVREQXFx?=
 =?utf-8?B?aGpaUDdjMWRaSThLenI4NXB1QU5vdlBTZlJzZzlURzREaDNBSDcxejlPTFho?=
 =?utf-8?B?ampJeXd1RHBQYjZHdlloVTNuTVJrNkMySno0OTBGN2xnckwxVERYbFgrOFRy?=
 =?utf-8?B?V1dQLzVvbHJmNnBMNmlFL3RJNjB2eWlvRktheUNtMG9OcGRGVDlkYVZrMlRU?=
 =?utf-8?B?RXlzM3U3aHA2UkZzd2d5N1RGMi8zUnA1dlhhUVJ1L2RGNjVpQ25SVXIvOHBr?=
 =?utf-8?Q?8N8SFKD0OIqJV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aUI4aVFjbUJkeUZyZkhhV0NPUlJtOGswUXlQTkhkclJXZVg0WGxVUytHWFE1?=
 =?utf-8?B?b1dXcVZuMFlCdVlVL3ZMK0pTOE1ZYjhWOVE3WmlWSkdIMEU2UlhMeThWZG9R?=
 =?utf-8?B?UXZySkZ0OFdyeS9HM05pK285YldxRU5wMWZLNnVMTG5SckM3Ri9ST01wYVY5?=
 =?utf-8?B?aG1mL1Y3TzhaT2RrMk1aeFYxMzU2WUxsamhoby96NTNWTnpHTmRobnpISUpw?=
 =?utf-8?B?WHNTay9wK0VwRlIyanNVT0JQcG1iOVNPZXYzSUh0UnpXeFhZNlhOakxqQ1Yx?=
 =?utf-8?B?K2NmeXM3eEdYaFlvNis2bmVyREdxR1JJMGpLb01SSlA4anNQQ3IzRmtGZjZP?=
 =?utf-8?B?am9wbVVWRHhPdHRsZHU2WEJzclVnL2pMQmRzZlZIeXNrR1U5T3FNcENOOHc5?=
 =?utf-8?B?dTMvdC9SWjZJR1RFUWVzVHJnTThtWGFzUnlHWTBtWlk5UEZkaTdxekpBVXhD?=
 =?utf-8?B?VUlJQWJuT09COVZTVlhwekNRLzBDR1VwUGVqVTNVdHlsWlVJNjRMQ0FESEli?=
 =?utf-8?B?TlVFVU9LMDBLbGt3M0xnVTdUZXduUDY3dnpzT3RHY2xZSlIxTW1YZnJJN1hD?=
 =?utf-8?B?Y1J2TytnK0NrZmoyWm1mcHZHMGNZY3c0MTRDNk9TZW1XUVpEUFVqbkxwZ1pi?=
 =?utf-8?B?aXhYZW4rYm9sN0VxenM2UHg2aWRHTCtEU014ajhmTVVEZzV4ZHRxY1VrQkFn?=
 =?utf-8?B?ODA2b2gvRnZpZmJjWUszRlBkbVc5aGRpSnRCbUZ1VlA5Qm1TRVZhaVFVUGZU?=
 =?utf-8?B?MFhFRXFkL3huZnNPYVpyWUJTbG1OK0ZJbHNLSGcybDE5NkhmRkVqRWE0SmNJ?=
 =?utf-8?B?dUZLMXVvRlA1WXNob29VNjJVNVdCcVJ3UlFIbjhXcTVCK09JaHpNZmR0Vzdw?=
 =?utf-8?B?K1FxODJMcTAxdkpyOGx0QW9UWDJpRGhEL3U1c0x4RFk4cjV2d3J5bGhXL0dP?=
 =?utf-8?B?OWc0dWFHdjMxbG1pdllZT0Ywd2t3MXl2ZHR3VDJIVzdRVmZXNmJKL3NMay96?=
 =?utf-8?B?YkYwVnVBNWxQS2N4SlR5U0ExNm5hTUdVS0RDMjU1V3d1UDB5MFhPbTFZUkVo?=
 =?utf-8?B?by9aazI0NmZrc0xDUVdTVEJTUjljMCtFYlFmY2RhZHU4dVFYRzNzWmZESURQ?=
 =?utf-8?B?VUNJUDlCTEtad1FrNDF5Z0Q2OUREWVc5Yzl3U0ZjZ044eUN0bXBUZVk5eURG?=
 =?utf-8?B?VFMyQ2JIR2xtNUp0aWt5RG1jR0pzdTVaZzRMbVc4cEhRTHl2dWcvdlZCVU5X?=
 =?utf-8?B?L1N4UGxtaFVDUllKcmNrVHRkNndLbXNTb3R6WmQyTGVJS1oyOWxIMW9KYy9a?=
 =?utf-8?B?ajRxSEx6SGdDZnVQZHJSa0dXdTFCUjdDUG9tU0tvYnRQTTBQV3BEa0JQUGcy?=
 =?utf-8?B?T3d4RHBRY0xHSVpXNFFPbGlxdnptWTY1ajdUcTlISmNTNkVPUmJ4VHZzZGhj?=
 =?utf-8?B?UFN5NFNYZ3pSYWw1TEFzQkplK3VGdk5XRk41VzZ6dUp4dDNRS1FrZHR4SmlS?=
 =?utf-8?B?dGxoZ3FZc1BhYnU4MXArTnh0TU1jVUIzaVV2ZS9Gdk1YZ0hTSWphQlFmbGdz?=
 =?utf-8?B?ZmtHeThERzN0V2JKblI3QkQ0d21ESGxYRzFSY21RakNwZlc0RnpsMFRTbDVK?=
 =?utf-8?B?MkJlSVBpbE1SMEJ1WTRJUUZzL3pzQnkwUmlPT0sxeUVzMFN6N29kVU9JeEhx?=
 =?utf-8?B?a2NoOEozUmo1S1VoSVFsOW9lNFdpcFB5eTRRRU5UYUEyd0JKV0VaMUFFeCtp?=
 =?utf-8?B?RGt5QjFVZnJWNDJjS1RKUVZUaSsxM1VHdDlCbS9JV0ZPdzgzalhwYkVhQW5i?=
 =?utf-8?B?ZHZaWkxwbjB5TC9tTjBmaldVOVg4VFg4amZlZDZhSWNDcTNua1pVcnJOcmQ0?=
 =?utf-8?B?Tkw4SXYxc0VUZnJBRnpDUWxSWHR4MFZGWTdkOTdsYWFqck9SaSs0SHg0WjQ4?=
 =?utf-8?B?TVFwcnpvL0s2Rm1KcS93L1ZMSERQSjR2a1lZWkdvTjAvalgwVlJZRy9nc3hF?=
 =?utf-8?B?TFIyeGlxaHZpYjdyc0REM2g2NU52S2s1K0thU2Q2YU1NcWJBU2J4RElHWHRD?=
 =?utf-8?B?M0ZOZWRYS2hLYWt4ZG1wUDM4TzNGTEwzU1dhKy91R0M3bVl1WG1JL0JQa0dh?=
 =?utf-8?Q?gDuUH984uRxcF0OQBc0VKPXgb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52dc9349-71d1-4f8e-0eb7-08dcb1f24f20
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 06:22:24.9817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: waOpE10q8NbUDfklXMphtj1qnGpHxZ1YgFYnIhww0iXpX7xDV8lm8ANbr+ndFwNh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7967



On 7/31/24 16:11, Michael Walle wrote:
>>> All I'm saying is that you shouldn't put burden on us (the SPI NOR
>>> maintainers) for what seems to me at least as a niche. Thus I was
>>> asking for performance numbers and users. Convince me that I'm
>>> wrong and that is worth our time.
>>
>> No. It is not really just feature of our evaluation boards. Customers are using
>> it. I was talking to one guy from field and he confirms me that these
>> configurations are used by his multiple customers in real products.
> 
> Which begs the question, do we really have to support every feature
> in the core (I'd like to hear Tudors and Pratyush opinion here).
> Honestly, this just looks like a concatenation of two QSPI
> controllers. 

Based on my understanding for stacked yes. For parallel no.

> Why didn't you just use a normal octal controller which
> is a protocol also backed by the JEDEC standard. 

On newer SOC octal IP core is used.
Amit please comment.

> Is it any faster?

Amit: please provide numbers.

> Do you get more capacity? Does anyone really use large SPI-NOR
> flashes? If so, why?

You get twice more capacity based on that configuration. I can't answer the 
second question because not working with field. But both of that configurations 
are used by customers. Adding Neal if he wants to add something more to it.

> I mean you've put that controller on your SoC,
> you must have some convincing arguments why a customer should use
> it.

I expect recommendation is to use single configuration but if you need bigger 
space for your application the only way to extend it is to use stacked 
configuration with two the same flashes next to each other.
If you want to have bigger size and also be faster answer is parallel 
configuration.


>>> The first round of patches were really invasive regarding the core
>>> code. So if there is a clean layering approach which can be enabled
>>> as a module and you are maintaining it I'm fine with that (even if
>>> the core code needs some changes then like hooks or so, not sure).
>>
>> That discussion started with Miquel some years ago when he was trying to to
>> solve description in DT which is merged for a while in the kernel.
> 
> What's your point here? From what I can tell the DT binding is wrong
> and needs to be reworked anyway.

I am just saying that this is not any adhoc new feature but configuration which 
has been already discussed and some steps made. If DT binding is wrong it can be 
deprecated and use new one but for that it has be clear which way to go.


>> And Amit is trying to figure it out which way to go.
>> I don't want to predict where that code should be going or how it should look
>> like because don't have spi-nor experience. But I hope we finally move forward
>> on this topic to see the path how to upstream support for it.
> 
> You still didn't answer my initial question. Will AMD support and
> maintain that code? I was pushing you towards putting that code into
> your own driver because then that's up to you what you are doing
> there.

Of course. We care about our code and about supporting our SOC and features 
which are related to it. It means yes, we will be regularly testing it and 
taking care about it.


> So how do we move forward? I'd like to see as little as core changes
> possible to get your dual flash setup working. I'm fine with having a
> layer in spi-nor/ (not sure that's how it will work with mtdcat
> which looks like it's similar as your stacked flash) as long as it
> can be a module (selected by the driver).

ok.

Thanks,
Michal


