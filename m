Return-Path: <linux-spi+bounces-4111-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68238943120
	for <lists+linux-spi@lfdr.de>; Wed, 31 Jul 2024 15:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AB4D1C20C66
	for <lists+linux-spi@lfdr.de>; Wed, 31 Jul 2024 13:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8471B14EE;
	Wed, 31 Jul 2024 13:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DMDLE2WI"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E0E1AE843;
	Wed, 31 Jul 2024 13:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722433256; cv=fail; b=BsyIhKd7mfUDdGtcS7UxY2/Br50Nl/3TzE21Jm72qg3gPl5WbTjHIwz1Sz0r3do41NwGM3PV6PrsOJJUmGD4lGnnfUFTN3xKWV8ztfV4G/TN+6RvAMBK2xcJ2gywr8xomD/kGvRONFe5cLM/VtjNhkci9c8FRD34IwxVb2oFY+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722433256; c=relaxed/simple;
	bh=VE3HKuQhFgEVQYMFuzZC6kA6DGXRuFf6DTcEg9ihqIM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fn2DvQ4W2/MYTCgjLnRIdUO1zRc4TWY7o2GGPv/xufdNHb75lWYLiNyF+qilOyGMXr7ktjlCIJcs/Xai3Wx/IeC3ZVyz/kFdQ+0jMiwAbp5/r5vLHwYOY2IIiaO61Iv5t4cISZggi8EppRoxmLMYpUCOQmuvs0nXDM/bmDYLuT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DMDLE2WI; arc=fail smtp.client-ip=40.107.220.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MJUvCBYVBAEyvynizNzKl+PggqABYxy5r4zsvpgE7sCikAgNAyF37rLTNTA4eQ7ys6dhRfaZPwnL2VNg0hu8Ct8y9FN71u+HL+Zd+XAf1XMkCDx3O98MwqCNDPRwHQ71H3/jda+6Wriiko9fFAPJ6depEZMM6UTlL2InjUAxDcToe9hl2Wt+fhAN7ltybOLzl+rh24cv0yo4+JvC/AFmOaqRaeh0d1Q1fx3IC9Fdpmnh1Rg2KaahfEzcFvFO5+j1vnjqMfQfDdCMgdqXBMY6teA9klHgmfhQ87fuMSWT3GRCZuSeq2MiZdf+rr96YHrZ3eLl4eZNi3Btz0BBybmQuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ksrbx3E953A3UYG/+kxmk7mwcTb3I6qK7fehWGl6YCU=;
 b=IDxHGTyIyl/DjOF+nKqhseITYmstGdXYWFXYzVBvXgyrtNKywvPTDyv/ksVr3yrPV9Ar6AxyIs45kncUe8DoV6DJ+ZB2sXmMo37cSsYqZnwyY0akFdwn3tcDY4RCtsQzq1010zSYvP7M5Q7UcBHDh6MxWbXYRaHAyoe1CSkDyanUnPeaxTz9+XNaDpIyBLyRVxDGth+hZjVReqFhBb9eUTWw25ZM8LoagUYgL/mYOpYZnIYjuCl7tn5188lim2XqcerJVwcbcquiiEL2NtWNfzbnFhNMbDEWTCueVjkOyeZgJLxG16wpBv8OcnJnc5QMC1oSVcwXkwNKro3ShL1eUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ksrbx3E953A3UYG/+kxmk7mwcTb3I6qK7fehWGl6YCU=;
 b=DMDLE2WIZr+xYFFR73l6wDJYwoegyWxQm/UrnicHOeEp2wcMDx1UmZ27uqkZXiWBnOYfdIIgRMge4ZdsGXzhh9Yuj8VY9fQ5Lr5Eu4t/r50wDq70cNJfxCLUogQorDEU7k3JMZAt+YnZNBMjadA8KJp8LipW5m0E/UgzASViZtA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DM4PR12MB7574.namprd12.prod.outlook.com (2603:10b6:8:10e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.29; Wed, 31 Jul
 2024 13:40:51 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%5]) with mapi id 15.20.7807.026; Wed, 31 Jul 2024
 13:40:50 +0000
Message-ID: <9fb60743-3e89-49fa-a399-3cf2607a7e41@amd.com>
Date: Wed, 31 Jul 2024 15:40:41 +0200
User-Agent: Mozilla Thunderbird
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
 "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>
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
 <c3fa1e04-92ed-48ab-a509-98e43abd5cd6@linaro.org>
 <BN7PR12MB2802E87F1A6CD22D904CAEACDC93A@BN7PR12MB2802.namprd12.prod.outlook.com>
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
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
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
In-Reply-To: <D33M26RLVLHF.3Q5YARPBNSBOY@walle.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0139.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::24) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DM4PR12MB7574:EE_
X-MS-Office365-Filtering-Correlation-Id: b9b235ed-0a77-4cca-7e25-08dcb1666433
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UUllU2dtQjl6ejM4d0ZMbm9pSVlGSFp0N2FiT3hxNi9hSFV3OVZZck1YRW1v?=
 =?utf-8?B?MDdtKytrQkVCK2dLMUN4SFpRQXMwZ2FialZSTjZ6WUtCbXdXSVhjRHpTWFRv?=
 =?utf-8?B?djB1TWZadjBONWpPeDJudG1vWHBFOTZmUXJTTUhrRmcvdEUrc0ZwV0NOa3o0?=
 =?utf-8?B?TlRPd1QrL2p1bTNpR3dJWHE0ZU43YkJ4MGtKY1B4RkNOUURWM1JnUnk3cUJP?=
 =?utf-8?B?YUdqcFJkMTV3U0dua2xpVGJMMGxsZlJ5azYrUjlWZ2lhVkNQQ3AyVkgzWHRh?=
 =?utf-8?B?SDRPMmcvZHNTaGQrRFdqZ2QyNjlPWXV0TVFQaUd1STFTeUlRYk1wUlY0U0hN?=
 =?utf-8?B?d3AwZVRHaDMwWFdqOWFnaXhQYXpFVklRR2d5TWF5VEhNVEkzU011eXlSYjV3?=
 =?utf-8?B?VXNrenlhNG9lMFVMSHhWL2VYK203MWE4cVAyRjNDc29SVGZDN0FaYzVOdE1B?=
 =?utf-8?B?RW9zUUxpbHlHdkpFcDc0eVdQcFhNNHVxdnpMTEpLOUVpSmtpMVBzL1V2Y0V1?=
 =?utf-8?B?RDdHZWowYjRUYWhtaEdqZDcyNzlFVlRlT01qRGg2M1NXdTNQbUJhMkx6L1pR?=
 =?utf-8?B?VmoyS2l0a1BVZE5mZTZQZlNicVM5ZGFRcmM2ZmRnN1owM3V1Rmp4QVcrTisr?=
 =?utf-8?B?Umx0MHhkUDgyK0V3UkZSQTUzYXA5eUVSVUZEWW9ad284akFuUC84V1ZBS2tY?=
 =?utf-8?B?bVg5aFZianpxMlYyNTR1akhJa0pvTVE4cVhJaUhQN0lDQVdPYXZoODZCa01q?=
 =?utf-8?B?aUVJREhxeHN3Z1FvKzJoajdaeUdPTDBWbVpzeUdMbjg4eUk5anhXMWdvY09X?=
 =?utf-8?B?ZzJzZlZTUEt4TmtXVmZwQ3RyU1hCZWZJZXlJdUZvaUtmclhpZmNhRno1bVEz?=
 =?utf-8?B?azN5R2VGcER5c0x1dUgzUkhYM1czcFhSaWVsQ0NjdE9OV0RYMkIxVWV3TzV1?=
 =?utf-8?B?UmZsNDMvd2dDdEZpcDBZeDFsdjJFdlpmRmhHZ1BkT2JkaVB0SWNVREMyeC91?=
 =?utf-8?B?aVBGZXNOdU5JK0dXcEd6ZUNzSVlwY3htQjEwUXVkNUdaNkQ1UXA1VGZiZ3JF?=
 =?utf-8?B?a2JwSUo3R2VIZ3BqZFc1UysyY3ZBWVo4RkNNWW9DaVQ4M1JVZkhDbTk0d0dH?=
 =?utf-8?B?S0F4bmZpT0wxS0tLNlVkUjZ0U05ST3g5ZXhYMXJqYTNUOTNueERNdFdFNVBO?=
 =?utf-8?B?WE9SbzZGUTRjS293WGJDRmQxMDhaTW1DcFN0VENrZGVZdng4S2F1MXV5anpD?=
 =?utf-8?B?cDVPWVJ0RXNydXYrYXlTc2ErcUtlWEMzc0c5a2VsSEUzanpBWU9MNnlLc1oz?=
 =?utf-8?B?blRib1NXV3dFZm9UUGxqQnYxOGVYTHVLcUprbHh6dWJscmtPeUJJSGhVbkEw?=
 =?utf-8?B?TDdmaDRoaUN4TExzL2dobExyeFFSNEhQMVl1K1lXNHVmam5pWTJaRitqdVdz?=
 =?utf-8?B?ek0vV1R0T3BRU2cxV2FoSUE5MTFwV2hFU0dDbXJxTERsOTA3UUMzRnR2Q3lu?=
 =?utf-8?B?WTl3L0cxZWJZTGhVQ1RkMlZqQ3ZpKzkvaXZmdEZSWTRhM2wyMzAySC9OVi9j?=
 =?utf-8?B?TjMwOWF6MDBrV1ZCVHl4SHFsTytWNm1NQ05GMVM1RjJ6NDhVOVJnd0pkaHdy?=
 =?utf-8?B?NUxFdFYzOFNkYkhWZGI1Y2hLUGNqQ2lhYmU4bWhlMU8yUllERmxhYVBHRHZ2?=
 =?utf-8?B?dTROVERYRExBM1JsWElFbGVrLy9aYXVyandIUmgzMGtlT1ptdGtqTFRUcXVL?=
 =?utf-8?B?K2l0SWQyYTdYWDQ1VjVWVDRTSFY3Q0NteEtCVEI1WDRCRGZwbjJ1QkNwZ1JT?=
 =?utf-8?B?ZldrMm1KV0IyTUNKL0dqUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZVE0eTVnTUI1c0U5VE5MTHAyV09mdDc0ZVFOWkFSdFVGTlJXV3JwUDVqSlVr?=
 =?utf-8?B?UnloQjhmRXNCWUo1cnBaY211S1VyYk5PWE5xME5EcERaMW5rZ2FacjhEdmxZ?=
 =?utf-8?B?TmJzeDRmR3htZWJwSTVnbGRYL0NmMHJOVWw5L3JZNVJTbDl0c1c4ejBpV3Rm?=
 =?utf-8?B?MFVmTy9TakVBUElvYkdjZmpVSEh0TlRycENjMUZ1L3BCNFVhU3NYTmtiUEg3?=
 =?utf-8?B?Yng3M2g0S1E3ZWdheUs3Q2d6UHpiZ1ZQQ0w3QWdUWnF0K3Z2QkE4UEZSMVM1?=
 =?utf-8?B?U3FWbnNKOFJoVFRiY2VBYXpiK1kwSDdrR3FXdzJYRzRrVm5wTmNremViRmwy?=
 =?utf-8?B?NUp5YW93M3ZvZTNVYnNNblROUDhZYTFZbFB3TjN1ZkZ2V09FMlg0cTVRZmIw?=
 =?utf-8?B?QzVtQmJvREF0OUVvMDNqVXhZejhVWU8vd2o1Qkp1SjJGUG1sUEcrQjFlOXBB?=
 =?utf-8?B?Q25tMDJPd3RqcXNGN05EY0pZZjVPQ2pRaWRIUitIeGxaMFF1aDNjWmF1ek1S?=
 =?utf-8?B?UTRYN3lzVTlEU3BZbnNZRVhiSzVaRWU2Z3hLdS9EUzdBMDg1QVY4a21NOHVL?=
 =?utf-8?B?bUR0b1I3UnV2My9xdFYyQ052c0U0cjRpbjBXN2ozN2tHUGhUM2R3YXJCWnBn?=
 =?utf-8?B?TGNmSzVBZG0xdTBCTXZsWkFPci9rcXI2STdQMlVOWkZJTFVpUzFKTGJoU2tJ?=
 =?utf-8?B?NE5ETzZzSGR4a1JUc216QVFQYkVqVFl5NWZHUUY2aWplenhPM3QvRWExTnRa?=
 =?utf-8?B?NDBpZ2dwOHhZdHNENjBUVkJMQlNUbVUrbSttcVBLZnprTk1oSkxwcE4xU2lP?=
 =?utf-8?B?TGMwMFc3SloyN2twN2VLditKbjdpclRycHlLVzdaRzA3UDB3SGJHQ252SVh4?=
 =?utf-8?B?eUZKOGU5V3BBV1BzOU5sSGdQS09mcVFWem5JYUpiSUk1UlRBdnV2eHd6QW5V?=
 =?utf-8?B?eEhZSFNXWUFscW5XVXIrUkd2OXBhWVRDUG5RNzZueDRmR0VlZXo3ejVjTGNo?=
 =?utf-8?B?Z242SkhPU2Q0YWs0dFh5cFJnUjlKOHZnL29lMXdObkZvV3hPSE51UVRvQUVh?=
 =?utf-8?B?K0NsMEpaa25oWUh5OXZ1VWhHTWVaMXpLOTlsYXFyQVpJWVhUM1ljek1CVGJZ?=
 =?utf-8?B?ZHNSMG00eDF1bmJnVVJuSUxZelZuSkRVdkZyMG9GVERxU1lFRUJpdS92eXVK?=
 =?utf-8?B?dHNQVnp6VGc5c0l2U2hWR25jc2RxOVU3emRFQlRYaHQzbTh6VURGeXZkKy8x?=
 =?utf-8?B?TTNxN1V6bjc4SnU0WXlWN3ErY3ptT2RVM3Y3QjlwandoV3pna0tYdE1IWk1r?=
 =?utf-8?B?Nm5ROFI0cXFlTTJTWGdPRDVJRzF2N3ordmNma1lpNUhtOGFjWE04YmxqQ0hr?=
 =?utf-8?B?dTlhd2lmb1JLSW9JS0JwL3o2aE1lMngzdFBDMVZvUlRPbGJGR3B0VVpURWdw?=
 =?utf-8?B?cFBFeDdWTXBqWDI5TDhTazY0VzkxbWM4K25vaTVwRExzUnpKc0ZhRXFxQmx6?=
 =?utf-8?B?VHR0cjJnRDJubnNJWTNTMlZjb3A1V3gwQUhzZzJLUStnWUU4alUxTm9MTjZp?=
 =?utf-8?B?eU1PeXQ2bXBEODYvemhabWx0WDJJK04yMnBPL1VVNVpCemw4VkFNVE5ITjRk?=
 =?utf-8?B?UE45bzIzaXZRa25RVGt6c2Y5Z3o3WENpVmhscE52NGw4cVFFZld2TEhlOFFF?=
 =?utf-8?B?VGpUYzcyc3JpU1VDdzNZWTl6MExWWWcwL1Rxd3p5NVhqVDBMNVpOVmZKczJv?=
 =?utf-8?B?UlgvdWxCRlA5Q3BzR1hPVVlGUDZMakxwTDd3dVREb2kvRkNuaThVeWFVVUZL?=
 =?utf-8?B?RnhNRUl2Y0UrZ1d0QWNFRFliWDZwTUliK0E1Zm90YVNNbHorNkQ1VTNUMlNL?=
 =?utf-8?B?djhyVUNWQURiZ0FQWVFRUCtCNEo3S2NwRjV2Qk1VS0NONEtaTHJpUjU3Z1J6?=
 =?utf-8?B?RXdkMUFNOUVnUUNqY1pmRjl6bGFRM1hWdWpSMGY0V09tL3d1ZVJxVk9FdjM0?=
 =?utf-8?B?WmN2S0VLY2xuTXZoR3JyTm9ZV0F1NmNCN2JtVEdsN2ZqanZFdGNLTHo3WU1M?=
 =?utf-8?B?R2llclVIeWhtd1EvdEdjRXBIYUY1aTQwSnhmZEd4Y2w0cEVEZ01LR1NkKzg1?=
 =?utf-8?Q?0DnK5fIHjM9AYmTeOEtYmckkX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9b235ed-0a77-4cca-7e25-08dcb1666433
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 13:40:50.6497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CpO/gP5SZgUVoyPGOlj5ieEiFxGYLZg2b2qxtM7xHoW94e6gdFAMEP8ePx83EvPb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7574



On 7/31/24 11:19, Michael Walle wrote:
> Hi Michal,
> 
>>>> Based on the inputs/suggestions from Tudor, i am planning to add a new
>>>> layer between the SPI-NOR and MTD layers to support stacked and parallel
>>>> configurations. This new layer will be part of the spi-nor and located in
>>>> mtd/spi-nor/
>>>
>>> Will AMD submit to maintain this layer? What happens if the
>>> maintainer will leave AMD? TBH, personally, I don't like to
>>> maintain such a niche feature.
>>> I'd really like to see some use cases and performance reports for
>>> this, like actual boards (and no evaluation boards don't count). Why
>>> wouldn't someone just use an octal flash?
>>
>> AMD/Xilinx is not creating products that's why we don't have data on actual
>> boards but I don't really understand why evaluation boards don't count.
> 
> Because on an eval board the vendor just puts everything possible on
> the board.
> 
>> A lot of
>> customers are taking schematics from us and removing parts which they don't need
>> and add their custom part.
>>
>> But one product for parallel configuration which is publicly saying that it is
>> using it is for example this SOM.
>> https://shop.trenz-electronic.de/en/TE0820-05-2AI21MA-MPSoC-Module-with-AMD-Zynq-UltraScale-ZU2CG-1I-2-GByte-DDR4-SDRAM-4-x-5-cm
>>
>> I am not marketing guy to tell if there is any other which publicly saying we
>> are using this feature but we can only develop/support/maintain support for
>> these configurations on our evaluation boards because that's what we have access
>> to and what we know how it is done.
>>
>> Also performance numbers from us can be only provided against our evaluation boards.
> 
> Which is good enough.
> 
> All I'm saying is that you shouldn't put burden on us (the SPI NOR
> maintainers) for what seems to me at least as a niche. Thus I was
> asking for performance numbers and users. Convince me that I'm
> wrong and that is worth our time.

No. It is not really just feature of our evaluation boards. Customers are using 
it. I was talking to one guy from field and he confirms me that these 
configurations are used by his multiple customers in real products.

> 
> The first round of patches were really invasive regarding the core
> code. So if there is a clean layering approach which can be enabled
> as a module and you are maintaining it I'm fine with that (even if
> the core code needs some changes then like hooks or so, not sure).

That discussion started with Miquel some years ago when he was trying to to 
solve description in DT which is merged for a while in the kernel.
And Amit is trying to figure it out which way to go.
I don't want to predict where that code should be going or how it should look 
like because don't have spi-nor experience. But I hope we finally move forward 
on this topic to see the path how to upstream support for it.

Thanks,
Michal



