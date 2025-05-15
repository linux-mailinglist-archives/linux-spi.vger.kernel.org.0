Return-Path: <linux-spi+bounces-8131-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9B5AB8220
	for <lists+linux-spi@lfdr.de>; Thu, 15 May 2025 11:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79D253B9CAA
	for <lists+linux-spi@lfdr.de>; Thu, 15 May 2025 09:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CB61F12E9;
	Thu, 15 May 2025 09:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gsHK2zjJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963041C4A20;
	Thu, 15 May 2025 09:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747300190; cv=fail; b=NN8Z/wrvrqQd+YiZXRIUmkSKChjTbAViqaPIjx2s/xALO8UZMhnvQ7/Vkak7NVPyMCxGmTtPJj/Apk2iKv1kiI6ZXc5iKtwm2Yl3LkOMXZ8TgMgQVKa9JMaMdwWz5zxTsVEeApHu3qAWN/CLJ2EFKB6KScvsp1p6dI8HCJxGGoU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747300190; c=relaxed/simple;
	bh=uI8GU1k7OBha+19D1zSaDQzs94V01DrKG3QwAyG3lXQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cc389NrOiiUUmIBSLUzJpJWFj1cxfEyvSUEYKvqgpEhIAE9Q+smvgGOmTlg7cCM2dPqnYwTyV4wddI9AV/NeMUMEfsms8SErWPHaqH1oOkbsE6rAkRoqFt0OkrDubaIzQgoe9Fh3Z9EfUJJDPzxC9A54Q1QiVB0QQfMVsrylfWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gsHK2zjJ; arc=fail smtp.client-ip=40.107.243.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oeZIiXHK6YnzFJa3Lqeftdvo0kLv0EHelBqWlYifj/kTI5DH5ahQ+QiodaNedeIPRNu+uekOBVbD1ERZt/1BeyUliFmsOydwz1Bh4wlubsQDWDlcbzkwRpHETYpKsiuT/igezbnpmqJA/e0EMqgx5MkbcuQbu0mcfvZs+JU0u2tj5y4k68iZdV/TB/7QgRj00RZFeHsjhrr6AxnwboKLMjXi2EyT0GEpnLZijhwZ49IPgbcCNZqKhBT5uiw1iwGbIF/XwpPZzbVMTvXwmNGLDd4UkN55yrg7+pbcnAjZr18d+Q5ew5rCI0LufNE5DOQauZ1pghFP2BgkrAVCjFn0nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RDkwx0kYIMNkSBORkwCuF5mXK+BYhqBBz1YId60Q2pA=;
 b=nc2LFZOtrMv/sYlA4eRY2g6OM6JRavz5FSp5I3owvAoO3M29seGaxyswmWipTxfHiWCcQWnoXsQTdwrT8kbsUBZ0LzENhbmglGGWUjDaT+6iahe+R6oBeKjGGNljDSpwzVCu7X0/erPN2M6PHGaXZX6dCRrHOntTpzx76gpV20zyj17sSr/O+0ZVfgv63MpRVfnIbRR/TyKA3ApPsye8CATEJg5QOQVgzaxZcAeGh+ITwVWK25D4Dct3S+Kj04VrOrsHvVFaPgm1ZfBjkbvNFVc79oN+7Z4AZ9wmeOeKnusWRC9JhdnaKXxnNwH/VleHPrSJRx1kBPylvD34sB1iGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RDkwx0kYIMNkSBORkwCuF5mXK+BYhqBBz1YId60Q2pA=;
 b=gsHK2zjJ53MFOdCzjkuQL21yuPeR83r2UFumJaPSvqzTCvDXnaIO7Ue/iOdE9TYbkswyv1eqsEvsduO1EJ+0HRTZxDgOSC+MnUHPZ016sITqvJzuhvZvj0PvJ9alPKdiG5cAeXKhGEQPEL5CPyXj2Kh8jDAvbjKAZsEVQW3vre4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6395.namprd12.prod.outlook.com (2603:10b6:510:1fd::14)
 by CY8PR12MB7244.namprd12.prod.outlook.com (2603:10b6:930:57::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Thu, 15 May
 2025 09:09:45 +0000
Received: from PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5a9e:cee7:496:6421]) by PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5a9e:cee7:496:6421%4]) with mapi id 15.20.8722.024; Thu, 15 May 2025
 09:09:45 +0000
Message-ID: <df28aa12-176c-4761-a901-a2dd63a61b71@amd.com>
Date: Thu, 15 May 2025 14:39:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: spi_amd: Add HIDDMA basic write support
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: kernel test robot <lkp@intel.com>, broonie@kernel.org,
 oe-kbuild-all@lists.linux.dev, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org, Krishnamoorthi M <krishnamoorthi.m@amd.com>,
 Akshata MukundShetty <akshata.mukundshetty@amd.com>
References: <20250509181737.997167-1-Raju.Rangoju@amd.com>
 <202505110641.zLT16Dv7-lkp@intel.com>
 <e84f5483-a203-4095-82cd-23fa94c87700@amd.com>
 <CAMuHMdUAE2umYggDdBjYZJY2-mYwim=P_=4Q00k9b8gB1tNY+Q@mail.gmail.com>
 <8c89410b-80f2-47ad-97fd-6ac10752c040@amd.com>
 <CAMuHMdX_ugjS475udqa1oOOfbOJ+0s_JAKcCyCcdQfPhhaWOTQ@mail.gmail.com>
Content-Language: en-US
From: "Rangoju, Raju" <raju.rangoju@amd.com>
In-Reply-To: <CAMuHMdX_ugjS475udqa1oOOfbOJ+0s_JAKcCyCcdQfPhhaWOTQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0181.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::7) To PH7PR12MB6395.namprd12.prod.outlook.com
 (2603:10b6:510:1fd::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6395:EE_|CY8PR12MB7244:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f1d3a92-05a6-47e1-a50b-08dd93903c50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L1N3UFQzQi9idlN6cHZSL3VaNUVabVd1REFwWjJVVUdWU3FFVjRQRm9aK1dT?=
 =?utf-8?B?aGZQSDRaRUtRdjJQam8vaHRtcFRaY1UxZHZnUXNSbDJEWDByNHlJWjBEbUNq?=
 =?utf-8?B?eTRMaWs5dktmRnNzbXJERkV6T0tubXBGOFdZdnFwRmhOZDJ0bkNuTUwzTTZZ?=
 =?utf-8?B?N2Z6NXBXZHQyTEdFY2lKZG9GUFFLMy9JYlk1MW9ldWVaUUQwOS9qbzJ4MzZk?=
 =?utf-8?B?c1pqdG9NNGU3c2wyMUtzKytrc1dpMXNxSkhPVjRIbjgzZnNXYlo3YjZaaElC?=
 =?utf-8?B?TmJTeUFCS2k4ZXk3UmNaNlNxVmZVeE9LNHNtTnZmR1hXeThWQ0lMT3dGcG5p?=
 =?utf-8?B?MmtpTHBtdGlSTDVGNEk0ZVU3N3l1bWg3eGVYSHFUNWNmSlpjamQvQ0ZPVTJr?=
 =?utf-8?B?T05xMURBbVhBd2MrbzdwbG9sajE2OTROZHhCb01DM29ISlBNdzZCWTUrTkVz?=
 =?utf-8?B?RDNYWmo2OENuMW5iOUpVbUw1dThFc2RsYkVyazNhUW05OEg2WW91ZXhqcmlG?=
 =?utf-8?B?dmthWXJuR09VTjN2c1ZISzhVc29QL0JrSmdrQnQxZmVaNXo5NzR3VVRVTzRh?=
 =?utf-8?B?WWM0K2huRDlHUlRGNVEzanJGN00vdTlNL0dKWUxPNlhGSFg1K2lHOVk0M1Qw?=
 =?utf-8?B?S1ZTR2h0Z1UvNmhmYzN1Snd4akhYV0VpRmRtQXZ2UW1USjhkQVFUM1lFV00r?=
 =?utf-8?B?TFhHK203QVRMMExMaVJqb24ybWpOV3Jtbitacm5za3BheFhBSkc5T21jdVE5?=
 =?utf-8?B?MEtNZE5jRjVlcVE0Z08rb2xvWHJRdEFZQ2NXbFR5a1g3ZUExdjlseFlaNmZp?=
 =?utf-8?B?anc5U1NONldva1huMGpya1B1VlpOZWxCYkk5OFVlUGhmQmJFQnZIREd6MHBP?=
 =?utf-8?B?Y0tybURscTFFa2R4QmxUYWNsQzAzMGJVaEFSRHhaZmJJa2lITFV4LzBhYzlp?=
 =?utf-8?B?WHNrSUFXc0YyNmxjUVVUam5pTEo4UWdkOVNhbDBUZ00wRk1pYzhzQ3FqOTkr?=
 =?utf-8?B?QVhGczczb25rcHo1TmtxNEVmRkExZ1dSa3RSOVE4OTdaa2pxYk1CQzJtNGJ0?=
 =?utf-8?B?Z0xWQ1R3c2JhRXJlZlArV3FVRjZ0ekNURlNBMzh5ak9Pb0xtMXFUakh1eWtT?=
 =?utf-8?B?cFBTdmhRREM2SGRvNkRjMHl0SHBRakRrblZjRk1OV3Z3a1ZxMjM2ZXcreHhz?=
 =?utf-8?B?WHMwV0E5STFWT1hoNHVLWEgyMkk1cUpJeTdWOWp1S3YvQmgyTUh3UjZLRHRX?=
 =?utf-8?B?YnkxOVREdSsyZ2lIQzN6UmxLSlFJeHQ0MFNJZzNSa2M3bC9TQlhhSlJJaThz?=
 =?utf-8?B?aE1wNldZK2hTS2FOdWk0aU1yRVpmczBHSnpFSjNUNWh1ejFreFVXY3cvWHNJ?=
 =?utf-8?B?RWhOMnFpSUpnelZVcGV2RTNyVXFmYUR0bWFzMWtvaDZzdmJmUGlNdW14MkxZ?=
 =?utf-8?B?QUl5blQwZFRCMVRPMWhvajJDK0NEWUtQUTZ1M0pWLzVvMFozbGtRSkVVWWFR?=
 =?utf-8?B?aDJnZFNvdm1Ga29ndXg2VzNCU2owbkIwZjlYOEpYRE1JMTNlZ1EvWjZZQm5P?=
 =?utf-8?B?dXh5TUN5U2t4TlVSTXRKbXZPTFNTUmNzL3J1OTQxZVZPaVdxRHRIRVhSeDVP?=
 =?utf-8?B?YmREaWhrcjBDSTVubVRhSmF6eE5OT2NmZHo4M1hmSE40dWUrK2Q2K1pLNzR1?=
 =?utf-8?B?YVBRcGhzVTdhVm1GUU8zQ1dhOWNOVVBBcGV1ekRhVXV3WThNOVk2bDBCb0pP?=
 =?utf-8?B?emc1aldRS0RjMDJ5ZVV2bnpnOW96YVJSZXVWcFFBcU94eXVIZkRqQTNxL1gx?=
 =?utf-8?B?ZUM0T2xwYXYzS1RVZzIrRFdXMER2cnM5V0Q0OFJBdmUwVVFUaTlJY0ltekx1?=
 =?utf-8?Q?lYDT3gW1SPHMN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6395.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V0Q2VlA2UnJjQjRYQlBCZGV2SEZvRENVSHpJNHlNU25ZcUllbC9WQTN0YUlu?=
 =?utf-8?B?MTBIQXJlTlI2SS9FaTNWcnRaR1FvZVkwTTlVT0NEbWcyMk1lR0pmV2xraTh4?=
 =?utf-8?B?Q2xQVUx0K28rOVgvL01oWHNmNlZEMEMvemhjRzFrSjNWZXVkakxDS2xBRk54?=
 =?utf-8?B?MFNLOGlBWjQzc0NPOGI4STNOZk8vcVNRRVFnMEd6NWlBOS9Qa2pqekRITmdj?=
 =?utf-8?B?ZWxnVlZEaGE1RzllZDFxSGE0aC9mOW9JdnIvekE5QkZRUmpiRHcvOGxJbDF2?=
 =?utf-8?B?RTVhYXRTT25TKzVHMk1Zdi9jQU4yb3ZPWVJseWdSZnZYbDZDUEdWUG5WWVBJ?=
 =?utf-8?B?aFJ3bkw2emNrK2EyZWEzOHJKQjJvRGZTOFpZMXdRanZKd21ERlhId0VGMkxO?=
 =?utf-8?B?WnlGdVdPaXRYVDhSdmFQaTZqZysrSmVuTE4rRzNTcitSdEtFVm1EazBLYnJh?=
 =?utf-8?B?NEN1Qmd1ejFEV0dVTG1XRzVmZkhUMDZOZysxVGhnSDBqTzg3Z2dnWFBxZzF2?=
 =?utf-8?B?WjhWWHBuQ2p3RjVDYU5KMzVMait3SjY3ZFFBTC8yZFM1WmIwRVhydlZ5VUtU?=
 =?utf-8?B?OERNb2E2NjE2TTR0UjdweVVuVXdZRzVubkZ3ei9qYWpTY3NYai9UdloyOGI4?=
 =?utf-8?B?S2dRSlhrbGtIMkdmWmgzYWZSRnNoYTlpSDFKeGFVRVdncTR1bjZFTWx1U2tm?=
 =?utf-8?B?cDczM3E2OE5xL3Uwa2ppNmxSMEZNVWtpU01lcHdUeDR4YmV0MDI4ckd6U3VI?=
 =?utf-8?B?NU9MNmIwWjlqQlVuQmU2VDQ3MVhnb2pIMWdwSTFnMmdoUVJ3VE9DRnJZQy85?=
 =?utf-8?B?TkVSZ3ptbXIrYmJPSVRKSUtVaXFWdEltZ1QyVy9aTWcwTXBaazcwa3dDNXNM?=
 =?utf-8?B?cmMrMnQrUGZRakpra1BnSkczY1YzTm5SS1QyUEw3VkhOKy9nWXFmK1g3QmU4?=
 =?utf-8?B?M2N0VnhEU3Z0SHI1MXFEa0ZSdlNiVytTdU9TTS9xUWFUT3JRZmtocklOVnF5?=
 =?utf-8?B?a3FsWEMySDB6Tmd5UENRdWtpUmY0ZE9mU2I0d2MrQXdYU2dyZ0NkTlY1Uk1Q?=
 =?utf-8?B?WGZocEYwZGUxUXlOdUtiWGpoaUQrc1Iwa3hpYmdnVkFnL2dqTHM5YVZmVVVs?=
 =?utf-8?B?dFZiZUVQZVBKN0Iwck0wL0VMb0NpNExqNlVTOG1UU1h1TDlqS2N2V08zMWRp?=
 =?utf-8?B?UStGRkYwSHFrcUpoU1JpUlZPWGxQRFA4RXNlSDhNN3c0cnk4b1ZLcTZrK0p2?=
 =?utf-8?B?VVN4UWV1UHFqa1FNQ0ordEYzaHFDZlJtbk1jMWlVbm5EUjZRNzY0c0ZlTHBL?=
 =?utf-8?B?UTFvYjNZbkRWOUZEOHdBVGkxd0s5ZDhXUTFPQlIxUmdvMW1YanBFU3ZqS3BY?=
 =?utf-8?B?djNONjhCcEEveU9IKzJnQnBlVUQyV2cwdlQyWXNVQUFRQmpTQXI5bVVqMzEx?=
 =?utf-8?B?Mi81TS8xYURTa2pXTzlwNHFqMng4NVZEbWRvdWsxeHhDU1VtLzBzMDlIRGdz?=
 =?utf-8?B?ZXBXdG9qbVZRajVkU1lNVmhyTWhGQTQzUzk1K1haa3Q1NzIwOWw2YVRaUVVE?=
 =?utf-8?B?YUFaWHVpTFJPTkxxMW1uTmhxNUwrMm5jZU91SDIzQ1l3MWRyNFROUXFtT1Y5?=
 =?utf-8?B?eTgrT3VmZU1hU0dYT0tzTnVCN050M0ZPSlRtdHp0WVM2QWhVTGkvTVR5eGEr?=
 =?utf-8?B?dytvclg4c0FuZzdIakJvcnh6RFhGVUpFd0xEbFVZQlIrdzRybzMvVnZXaGxx?=
 =?utf-8?B?VXhacFJrR1hyL092NFVrWjNJdSs3cUltckJhMC9lVWhGREVJR1o5MXVabDBy?=
 =?utf-8?B?S3BBNVBJN2dNWUZjWFNpcjVpQTRrbmlSNTRzaHpzaUtFL1hFVEZqdm5SSjhq?=
 =?utf-8?B?ZHY4RGI0UlZhYlY3YUI4bk1UZU5UMjRhQ1hNL3lHNE1CNkh6OEkxem1HKzJZ?=
 =?utf-8?B?RXRONXZwNmpRR3B4cVkycXJVQ1lBem4yWU5uck5UTkNGS0JKTXJrTVc4bk5U?=
 =?utf-8?B?dmdNOW1PSVdtd3daUW9kVTZZcFZZQzB4d2QySE1ITFp4MWsyemVFd0pFRmJZ?=
 =?utf-8?B?RjlXeUI2aGFMclRQZFhnOFZFS3NkTE50R0xmUTlVSlROY1BrZjVJUEJ3M2ph?=
 =?utf-8?Q?eTPnIPLnOZu1ZGPKm3bQiKuA7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f1d3a92-05a6-47e1-a50b-08dd93903c50
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6395.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 09:09:45.6896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f9QGb1QQQodAH7pQOAF/SyA/AKlKE3EKzi00Pa+FSA5YRh2blfGetH7RA8lGOeD8hoR4HFvh3BuOqfJ+RhMxbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7244



On 5/13/2025 12:04 AM, Geert Uytterhoeven wrote:
> Hi Raju,
> 
> On Mon, 12 May 2025 at 19:55, Rangoju, Raju <raju.rangoju@amd.com> wrote:
>> On 5/12/2025 7:47 PM, Geert Uytterhoeven wrote:
>>> On Mon, 12 May 2025 at 09:29, Rangoju, Raju <raju.rangoju@amd.com> wrote:
>>>> On 5/11/2025 3:51 AM, kernel test robot wrote:
>>>>> kernel test robot noticed the following build warnings:
>>>>>
>>>>> [auto build test WARNING on v6.15-rc5]
>>>>> [also build test WARNING on linus/master]
>>>>> [cannot apply to broonie-spi/for-next next-20250509]
>>>>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>>>>> And when submitting patch, we suggest to use '--base' as documented in
>>>>> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>>>>>
>>>>> url:    https://github.com/intel-lab-lkp/linux/commits/Raju-Rangoju/spi-spi_amd-Add-HIDDMA-basic-write-support/20250510-021954
>>>>> base:   v6.15-rc5
>>>>> patch link:    https://lore.kernel.org/r/20250509181737.997167-1-Raju.Rangoju%40amd.com
>>>>> patch subject: [PATCH] spi: spi_amd: Add HIDDMA basic write support
>>>>> config: m68k-randconfig-r111-20250511 (https://download.01.org/0day-ci/archive/20250511/202505110641.zLT16Dv7-lkp@intel.com/config)
>>>>> compiler: m68k-linux-gcc (GCC) 14.2.0
>>>>
>>>> Thanks for reporting this. We do not support m68k.
>>>
>>> All write[bwlq]() functions take a volatile void __iomem pointer
>>> (https://elixir.bootlin.com/linux/v6.14.6/source/include/asm-generic/io.h#L174)
>>> while you are passing a void *, so sparse should complain about this
>>> on all architectures.
>>
>> My bad, with the following flags included, sparse now complains this on
>> all architectures.
>>
>> -fmax-errors=unlimited -fmax-warnings=unlimited
>>
>> And sparse is right, this driver is using MMIO
>>> accessors on allocated DMA memory, which is just plain wrong:
>>>
>>>       amd_spi->dma_virt_addr = dma_alloc_coherent(dev, AMD_SPI_HID2_DMA_SIZE,
>>>               &amd_spi->phy_dma_buf, GFP_KERNEL);
>>>
>>>        for (i = 0; left_data >= 8; i++, left_data -= 8)
>>>               *buf_64++ = readq((u8 __iomem *)amd_spi->dma_virt_addr + (i * 8));
>>>
>>>> Will re-spin v2 with necessary changes in Kconfig.
>>>
>>> Please fix the real issue instead ;-)
>>
>> We are using read*/write* calls instead of memcpy to copy data to/from
>> DMA memory due to performance concerns, as we observed better throughput
>> during continuous read/write compared to the memcpy functions.
>
Hi Geert,

> Perhaps your memcpy() copies backwards?

Nope. The Source and destinations are in different address range, so we 
do not do backward copying.

> https://lwn.net/Articles/1016300/
> 
> There is no guarantee that read*/write* calls work on normal RAM on
> all architectures. It may just crash, as some architectures return
> cookies instead of real pointers when mapping MMIO.

Okay. We will copy the data to/from the DMA buffer by iterating 
(ensuring that memory access is safe) by avoiding MMIO accessor usage 
(`read*`/`write*`).

For example:

u64 *dma_buff = (u64 *)amd_spi->dma_virt_addr;
...
for (i = 0; i < nbytes / 8; i++)
     *dma_buff++ = *buf_64++;

We will re-spin V2 with these changes.

> Gr{oetje,eeting}s,
> 
>                          Geert
> 


