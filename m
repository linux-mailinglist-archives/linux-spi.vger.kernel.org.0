Return-Path: <linux-spi+bounces-4140-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5D6947A29
	for <lists+linux-spi@lfdr.de>; Mon,  5 Aug 2024 13:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 390E51F213D7
	for <lists+linux-spi@lfdr.de>; Mon,  5 Aug 2024 11:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F98E14E2FA;
	Mon,  5 Aug 2024 11:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hJgOUaJH"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2050.outbound.protection.outlook.com [40.107.101.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5051514C9;
	Mon,  5 Aug 2024 11:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722855674; cv=fail; b=NdgDX5aP6PPMHxugmGjCFf4O46ZB1SZ8LBN4XWV4oSBeJsCLKGjb+VrGrRp7hVA8qOt2Csli0sEqXFm4m/VDR2yXgd1eI1m+/qPIhq7l/CKYLvzUZcdX6jLLzr7B/jdvQv7PscQPL8LTU2cdLAmy3YdTMV9EIYzNShU4Piqywco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722855674; c=relaxed/simple;
	bh=u4zGHHNvCwELzRoEWNIKhk7pWCclbrHYSVjErgBG6H8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tXROH452aoN8iJmPy93zKlUmS3qhbScVsJ0Jb9Dnm3KDCYIuWnCC4AnOIbBLtZoKR43dlZg7bbffR2J6Lb8vWP7m+/inzKpLBSL5d4uLFs6F7uu0wN+ZwJV5KIKwBj0wm46W+S+DAuDPaQCnhZfljm0S/Z9kQGALCxAflzU36WY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hJgOUaJH; arc=fail smtp.client-ip=40.107.101.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tvYXjX835sr1xNPG7/FwjZ9zMcEeJxxvtLq6DMVCxNTI2VQ4EkKOmwsOtVeehGXdNPUSaqJi0oJzd9blTfaAQ2ld4VjnfisBBKrbNBHDDIhZut35p02cKfj9us3JNVrvgX4K5n248JWoeToe89GOeP/TFd8TQDhBahVW06tFrpRR1X+rrny5ocOPv2slYBPBZQk8cILvcfnxem7D5r55K1QGz7qHaPueD5AhbYkFh6zcrdjJYmQ0Z73oTU+/7pJcbDSvLSBgWYfPzqpawuBu5csJqGvUrI5a3XlmHaOefOXy2qyOcE7HUyw71ubKoTgD32Nrl4xbFn65TbcxWPurTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vbo23A1SlkC8BWYfrG46Q2gif3cx7rdi9xwlhU59K5w=;
 b=rNYH1FJrrbjSF+7w20nSOu8/IW/G9YBhRdrS9M9KROc1MFmxsXY3+D6D7PyllYwHTQkrwS3rZs5T4h4DvuBEHy4s1MHhK04MD7DL/aq6R1wrKMF1v9D1erktIccMuaTFcReUUSwHyFyU5wVBWQQKt0ymvW0a/bjXCGokYwEZEsvNL8kCmPzc+oFApPMlwweovmXmRQx1RvvryFvynYInyTu5LlY70EOOztbYvYTwB14/pA8wmfwndVa1PcNTWN7mpw2sj3gp9ewW+NN5Aj/pFH9V/Su66ZhnREn18FlNXiIrzwqyEQ1iRVfNg2DDH0ZdgQGKzDgK33kIGPOplSy4pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vbo23A1SlkC8BWYfrG46Q2gif3cx7rdi9xwlhU59K5w=;
 b=hJgOUaJHp9M5Q+wd83TEF0eJAqvANPN7E7YPpQAffATNAwey+yAyYakmNx7nWV4zSGNUeH07EWI3ApZ9BQ9ScdjVPsWIsIHJXesJ6OcFFaO/6q8I1RsJukkYLKZY9LlFNNzlVNUWQ2T1+JFYhDSAFYlql9w0XCALTrMZsUYSRS8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by LV2PR12MB6014.namprd12.prod.outlook.com (2603:10b6:408:170::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Mon, 5 Aug
 2024 11:01:05 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%5]) with mapi id 15.20.7828.021; Mon, 5 Aug 2024
 11:01:05 +0000
Message-ID: <1b726ef7-e25c-4a19-aaa8-77fdbdd8bcca@amd.com>
Date: Mon, 5 Aug 2024 13:00:40 +0200
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
 <c01d048f-ad8b-417e-8ff0-96f9252c87f2@amd.com>
 <D37U3QPX0J5J.21CTXMW2KC72G@walle.cc>
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
In-Reply-To: <D37U3QPX0J5J.21CTXMW2KC72G@walle.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0174.eurprd09.prod.outlook.com
 (2603:10a6:800:120::28) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|LV2PR12MB6014:EE_
X-MS-Office365-Filtering-Correlation-Id: 48e3e644-3ad2-4eb3-a8bf-08dcb53de69b
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UU41Wm8ycnVKbFR6S2VpTEN2RDFGL0dQejIyY2t6dVJxeWxqRjU2YVUzcEpK?=
 =?utf-8?B?dmRyWVo3VmxvSUN6VTh3bWFuRUdSbStlY1c4MjYrZFFKbXZjQVUzY3huUjBm?=
 =?utf-8?B?S2UwNzE5bnM3aVZMVkhPeUpjS29wT1ZVVXY4WE1yU1ZhNXQ0czdXSThBL0la?=
 =?utf-8?B?NmRhRUx3N0d6YVpwcGI2czRiQkN6MjA5SmR0UExudDlwYm1NQURoZTBKNUlr?=
 =?utf-8?B?ck8wNkZKcDJadEtEdVZ4b3k2bjB4ZWNpVHdSNThtcU9rYzBEZ0pRQWI2a2Zo?=
 =?utf-8?B?NzhEMS9XTXpaVlBmK3B6cGxISk45eFZ4amNJN0FPZXJRUHR1cHo3UGtOVTkx?=
 =?utf-8?B?R3dnQTVrV1M2emdwOWw3NjFUSGt3N0hEdndEM1ArR29aQ3Byc3A3Znpmd1JL?=
 =?utf-8?B?d094VitBZHVBVk94d3J4QWkvZGVzZEhuMG04MTBaNEVtZHN1SHlsVGZmbGJP?=
 =?utf-8?B?bUFsM0NnaUw5QUk0TXdrK0VoWDcrNEdvV2JUNmRoT2pQWmQyK2U2SkRqNGtx?=
 =?utf-8?B?S24wZXhqUjFwZTJvd0tuaEdvL2JSR3QvSTlvRjc5bG1tSUhkYVU4YUtvZ0Zl?=
 =?utf-8?B?am1KYUlhdGgvWEMyWXFpZ1o2NjNLZGZKcy9EQ0JhWC9USlNzcHh6TGorT2Zy?=
 =?utf-8?B?UmRKc2k5MXZ1WTc1bHFoY3lFdU51ck1aOEY2ZmJ3RThUVE4rUVlrWWJESTRa?=
 =?utf-8?B?aDlZNTU5MXZmci8ydXgwNkR1aWN0alFmbEc2UU5KdFR6aUlCM3JqczZ1Lzkv?=
 =?utf-8?B?ZVpLbGtKMGkrSzVJOWR0VHJlWnJaOW95YXhPYlVWOWpPcm9ueXBDSU1SVnU0?=
 =?utf-8?B?UUtQQU1uQU9yQjFTN21UUWhKTUFHUzhsYy8xOGJVWk9TUE1KMXorcThBWCtq?=
 =?utf-8?B?Y21ZRUtHYmRIcndzdW1YNVIyWHJGY1Bud1pEeStibkRZUUVyM1ZOYXFIZmxZ?=
 =?utf-8?B?cnZVUFRINTZnYnFYMnpBMnpmMmdUTGlSNlcwWWNkUjBRbkNtaksxZnpCNVU1?=
 =?utf-8?B?V2NsS1RxN2ZxZWNoNzJGeUFOWG8zc0lGY01oY3dKc01NcHQ2OEUzZk1DaWIy?=
 =?utf-8?B?VlBJL3RJMVZXSCtwaDJqZHRNTWE2L1IvRDhKdXAzU3p1cktJQXhxeDFnQU51?=
 =?utf-8?B?bVJsOXVsZ3dpbHQ3ckFtUlAzN1huRHByd2hKbGRiUS83NnIyUXVRcFB3TXZZ?=
 =?utf-8?B?cXg5QTIxRU5YY3dLWWlneUZWZk1QWUdDbXN3UjNqeFcwTk9xVnl0VHpSN2dL?=
 =?utf-8?B?WktTWU13b3NiYjcxRG04emFzS0RyRXY2UGRtOGVjVzZvZURXVmhDYy93QnA0?=
 =?utf-8?B?YzVyMmFqR2hyUTk3MlpaM3NvK2EyRSs0MEN6bi9UTU03K2xZYTZuOGtKdlVV?=
 =?utf-8?B?QkZsMnJpbUkvcVQ0RWJCL0pNTlJBSWJ0NFM1Y21jRHM2UEErOW1WeFhBMXUw?=
 =?utf-8?B?TElpNXNOMkZHTDlHVUZFanRyMlVvM25KOXByQ3ZWbkJpc1RTaVJ3NmtYVnRZ?=
 =?utf-8?B?R0xCRk8vKzFMUGh2NXArazVtZ0k4bGhYYVBmRzF1ang2dlMvVHhsTTd1eU8r?=
 =?utf-8?B?WEt0ZGZ3NHBSbG1OVC9oK3RHNmt5WE1NcWZZV1hibDQ4RHNlOHdYbzMzZ3lM?=
 =?utf-8?B?QW91MzZ0dFpua092L0luNFU2R1cxT2ZDNUt2UTl6NURCRG91eVBRYUJheVRC?=
 =?utf-8?B?UFdGN0JNalRRcjVoRUZPR0Z3K0dpL1oyenF6OXJMdkNnRFEvbnkwa2tSc0xy?=
 =?utf-8?B?SHRPcEtORVYyN1VIQ0RTdHFHT08zRTR1WTcrbjFraUpSUkFKT3pubUp6THM2?=
 =?utf-8?B?OFJpSTJja1hRUmZOQkVNclV0T25KNFVTSEdhcVJJemZiU2hrV1QrMXFrR1E0?=
 =?utf-8?Q?40asSLL0YzlRQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TFk3M2E0Z2plc2ZiOHB2WXY3M2kzUS9qOHJFTkdUTjF2K3FxVUV2b2JVMUZF?=
 =?utf-8?B?WHo2MUdnSGlrSi8zMU9FOVYvai9ycjBhWkJwY1ZzZWtxWUxWcHFESlNtMnhw?=
 =?utf-8?B?am5icEwzQkMyaEt1WTJ0bGIzdC9CVC9mTXJyYm5Sd1pSbGxseVBLbkRhWEZx?=
 =?utf-8?B?akRtZVloeGJqcjFRSGQ5Qk9wNHBkNW95dmJZUk45Q0VZU3lUYmpBUmxZYS90?=
 =?utf-8?B?OThveWxWRkVFWkNnZEkyMDN4ZE5NRENYbmZSSnF5MFU0VzNKbHhKSlJlSDU2?=
 =?utf-8?B?bnBjMlZHTUNUcFczN0RkSHNWeGhKQ0pkTXJEZmtsdVMrekY3UEdETSs5dlhp?=
 =?utf-8?B?NEVCZVpXQVhLTjhnSmNnRVcvVFR6d1FxdHU5Z2IvZndObWxVaysvWHFzZTRM?=
 =?utf-8?B?cE5JRU4xVytMYnVTQlFwTUIyLzFUOFliTkNnMjNwQUpLWlZaRWU2Q29YWTY4?=
 =?utf-8?B?ZEE1bTJxVGd6c2FpbDBGaFgydzBXVGVtVHh0dlQ2bjkxOFJpRGxhM095QWcz?=
 =?utf-8?B?dTlac1BrMG55VzhNdXhDaEY5OTNvM1RmNmJsUXlZMmZ6cUlnZkJ0RVdtb055?=
 =?utf-8?B?bmVlamtWdkNZS0VEM0lNVWUrM3p5N1RaMGdIS2pTZTN2ZHo4S01EaGN1cmN2?=
 =?utf-8?B?cFpqaTkzMlVZd3NibDV2S0JkQ2YyQ3BBdk9MNFBLanNzNGtCcGEzREhSMkNC?=
 =?utf-8?B?U0RvMGNHSHFQY2RuNVFMbWJ3c1JhL3RURDZnZEJKaGxYdUtRWTBrUlpwUXhh?=
 =?utf-8?B?V25DOEh2SVk4YjhJQmhxS1ZVT3N1dHVTazkxRmdaMzFMMmFhb1hoa3daREM0?=
 =?utf-8?B?Q2NnUTlzMUM3K0M3ZDRaVnhxdmVUYkMwdjJWdWVVUVBRQ1pMVURZL1pMRWJk?=
 =?utf-8?B?dzU0d1E5L09MTTM4M0pNTkxwOU9sOW83RFNnbDRVU1dMTGNHZmRVRjBkcUZK?=
 =?utf-8?B?SG42bEwvUWxwQisvdzQ5VUZpTGI3cHBvaVhKdFlzZy92N1YzeklsN09sRlJO?=
 =?utf-8?B?UmZ6L2c4b2NvMmtZbnB2YS9oWWd0T2RXSG9PVXpiRUMxSlhiaFdPMitaZnI4?=
 =?utf-8?B?aXRHM2ZqekhNUFlCRjJ2QVBzaHU5OEZ0L3BLQkcrN1hEM3dXMzY2MEFtNnVJ?=
 =?utf-8?B?dU9PbEl5NkJXT045aDY0cTY5cUNIMHRUaGJFRFZpY3hhUEs1Si8wSkxUTGlw?=
 =?utf-8?B?RExuamQ3Q3lrT01na3NKTHh3R3Q2RGpBdDVHVXcrUG4zUzhMKzJwZk1JYWV5?=
 =?utf-8?B?S0xyWDdTTk9tczQ2eDBYc2dzbFlSemZqdVhjODFSVWMyM09QUXNETzVvMi8x?=
 =?utf-8?B?RThHbkZWWTB0VlRVS3FQOUJFWEd1anhGazVCQmU2ejF5ZExtVjI4VE5XM2FT?=
 =?utf-8?B?S3IyUTRoR2MzYTZuK0RnNDlrWlQ4aW93TXNmbUcyM0hqOW1VTVBWK0o3UDZr?=
 =?utf-8?B?OEJ5bUxPZzN3UzVzRUZid2lLSnVNRDA3QmZrZzZuR3FPY2RhYjdIWmZpd3VK?=
 =?utf-8?B?MlEyNmVrNGZDSnNUbkhIbzd5QTJYbENHQ1V0RzJncWNkUk83YW1pR1cyMWRC?=
 =?utf-8?B?S2o1akVweGl1QktDaTA2MlZxMFFZL2RtNUxEYmsvaU1xU05OWUI0dlpYTXhI?=
 =?utf-8?B?OG5obmZUMkpvaGd1WndDVjdMOGlTRlJrTGhCalV6dlQ5V041ekFKYmErTjRM?=
 =?utf-8?B?NktwWGZWY1hvdk9rTjZGMDVseEFHM1hnRW92OVJLRGIxVUxKdytxaWkyMGJO?=
 =?utf-8?B?bkd6Rkg3NnlKOTBlUFVtV1pDUVdYTlJSZ1I3VzdlUE5KTG0xMjFtbTZMdEVI?=
 =?utf-8?B?a2haSXUrOUIvelM1aHhnb3dpYTZ1M0ZiNU02Y2c3OWVEaGZ4U01INWtVZnpx?=
 =?utf-8?B?L2ZmUXJTVE03R2FZcVVvQkxoQ3EzVjlNcVZDTGhGWVJlVzI4RnRmSjBoZlFK?=
 =?utf-8?B?ZTdNb2VyWS8zbTJucFEwdUovK2dDSktnQjVLWi82UmZGZnhVR09QclJxK3VF?=
 =?utf-8?B?ckpheTZ3ZjVwTWg4ZFg1eGFOVXhwRWxVVXFIaUNRQ1VWaDQwdUJvRFdwQ3BM?=
 =?utf-8?B?UXF4L1lYYzFVVVZ1NGZLWkVRR2NlNDhMQmxjVXd5MlRUaGZMQWZaMENwWXpR?=
 =?utf-8?Q?fUskuUII2QUbdmUFf9rODKFsS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48e3e644-3ad2-4eb3-a8bf-08dcb53de69b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 11:01:05.0677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lx89rO16LqFzFQTu709ksPAEzwWwmvAZu0VEgpe0MfEi533rtHgMjI3aE/zO9baO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6014

Hi,

On 8/5/24 10:27, Michael Walle wrote:
> Hi,
> 
>>>>> All I'm saying is that you shouldn't put burden on us (the SPI NOR
>>>>> maintainers) for what seems to me at least as a niche. Thus I was
>>>>> asking for performance numbers and users. Convince me that I'm
>>>>> wrong and that is worth our time.
>>>>
>>>> No. It is not really just feature of our evaluation boards. Customers are using
>>>> it. I was talking to one guy from field and he confirms me that these
>>>> configurations are used by his multiple customers in real products.
>>>
>>> Which begs the question, do we really have to support every feature
>>> in the core (I'd like to hear Tudors and Pratyush opinion here).
>>> Honestly, this just looks like a concatenation of two QSPI
>>> controllers.
>>
>> Based on my understanding for stacked yes. For parallel no.
> 
> See below.
> 
>>> Why didn't you just use a normal octal controller which
>>> is a protocol also backed by the JEDEC standard.
>>
>> On newer SOC octal IP core is used.
>> Amit please comment.
>>
>>> Is it any faster?
>>
>> Amit: please provide numbers.
>>
>>> Do you get more capacity? Does anyone really use large SPI-NOR
>>> flashes? If so, why?
>>
>> You get twice more capacity based on that configuration. I can't answer the
>> second question because not working with field. But both of that configurations
>> are used by customers. Adding Neal if he wants to add something more to it.
>>
>>> I mean you've put that controller on your SoC,
>>> you must have some convincing arguments why a customer should use
>>> it.
>>
>> I expect recommendation is to use single configuration but if you need bigger
>> space for your application the only way to extend it is to use stacked
>> configuration with two the same flashes next to each other.
>> If you want to have bigger size and also be faster answer is parallel
>> configuration.
> 
> But who is using expensive NOR flash for bulk storage anyway? 

I expect you understand that even if I know companies which does it I am not 
allow to share their names.

But customers don't need to have other free pins to connect for example emmc.
That's why adding one more "expensive flash" can be for them only one option.

Also I bet that price for one more qspi flash is nothing compare to chip itself 
and other related expenses for low volume production.

> You're
> only mentioning parallel mode. Also the performance numbers were
> just about the parallel mode. What about stacked mode? Because
> there's a chance that parallel mode works without modification of
> the core (?).

I will let Amit to comment it.


> 
>>>>> The first round of patches were really invasive regarding the core
>>>>> code. So if there is a clean layering approach which can be enabled
>>>>> as a module and you are maintaining it I'm fine with that (even if
>>>>> the core code needs some changes then like hooks or so, not sure).
>>>>
>>>> That discussion started with Miquel some years ago when he was trying to to
>>>> solve description in DT which is merged for a while in the kernel.
>>>
>>> What's your point here? From what I can tell the DT binding is wrong
>>> and needs to be reworked anyway.
>>
>> I am just saying that this is not any adhoc new feature but configuration which
>> has been already discussed and some steps made. If DT binding is wrong it can be
>> deprecated and use new one but for that it has be clear which way to go.
> 
> Well, AMD could have side stepped all this if they had just
> integrated a normal OSPI flash controller, which would have the same
> requirements regarding the pins (if not even less) and it would have
> been *easy* to integrate it into the already available ecosystem.
> That was what my initial question was about. Why did you choose two
> QSPI ports instead of one OSPI port.

Keep in your mind that ZynqMP is 9years old SoC. Zynq 12+ years with a lot of 
internal development happening before. Not sure if ospi even exists at that 
time. Also if any IP was available for the price which they were targeting.
I don't think make sense to discuss OSPI in this context because that's not in 
these SoCs.
I have never worked with spi that's why don't know historical context to provide 
more details.

Thanks,
Michal


