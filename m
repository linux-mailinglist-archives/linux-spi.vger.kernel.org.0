Return-Path: <linux-spi+bounces-8097-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C93AB409F
	for <lists+linux-spi@lfdr.de>; Mon, 12 May 2025 19:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B5177A19A2
	for <lists+linux-spi@lfdr.de>; Mon, 12 May 2025 17:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0546296155;
	Mon, 12 May 2025 17:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iqgBv6dt"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2076.outbound.protection.outlook.com [40.107.212.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C01293B6B;
	Mon, 12 May 2025 17:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747072516; cv=fail; b=bGbf27EdVYDkg9BOxdgstU7uZuOzPOSjkyU1H1kiCR5Hbo3SEaKrk2yaZV9G9vJrWn++TfWUhxv2U67NWB8bwDbkjwvvudaQQDUTO3ikq0/1QqJeJXdSUnXFyyXFjpyJ82s04ObkZmhQu7xlzpew+ijWBmRxKSjKNSr4MOBkzPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747072516; c=relaxed/simple;
	bh=4uVeOToRLCZEkPdISine1Sf16N82QVRYxEcpjNJxHmA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KUIBQ1yjKJ3A0GCaZSjYlA3dPtMA7NYz0C5HeoJ/ZmaZTimaeb34QCVUFx0Y6TDfEoBCrIkExmFBIyJmLOjXqYACkPINvtr5KhHWzJE8rygFXEukOiMOV4vcN4b70mZxYeNNK24pl03I7yemi2qEoSpb4UyQI2T4bf14zxv4LoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iqgBv6dt; arc=fail smtp.client-ip=40.107.212.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gFHOUKauBkLxUNX4N8Pu+iQffA+ifojTTM62mE6ObCkVu9pV6SmoRNA5a4WtcaHG7iBqZjkpGcxFKSh26BfKtWqa+sZXqDoxNfVJFe/JFby6zsxtxiBXNJwrU96jaEFme2taisJkNB83ZOS9LXvueoPgDZ22pT5z3b+gz34G719T+3nnNkJg+2f/y4xJrRPwiVxSxreBiyNhBMoMfqExC6zBA4jtiquQJZuK88I7RHbjoCD2zaXsIikhf5YvZ18EQ9gs9rG6/l1fqdbq4+Si4aWpPjUqkQQtRj3UseWuRvreXN6q9eyD0ypTRRgYJ4YXGC+yNO8jVVC5S9qadT74DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=elPcZdZfS9OrQbw+vpB0Es+p5EncP7w+9Ihnqv+snQg=;
 b=mhh+NDJvMD+LwG5pm3t/RSu97137XvR2kPKZAHo9hnyL2d3aQkmTM0VQxjrYL23IcNWSEEmLpzijb8JO2A+KKT2Crwt+sWMSe0ymEhvHywZudbBvnvnfuNZH5oAKMlEZ5bTAJNSrSlIeBHbtY5UHn+Qj5GrmXtH3jZ6JBDXB5EQmaWJZO408+uas4m6sC+9o+yiAu3niOtV3qjyLnhZNWFoD2KXO3YjNijyV4wME4B6VXSZzyZZnX+e/rkmLE9PbND93rgZ7GxEvQA8gXsFdty2kw982k741MaHqgheuQh1oTuo1QkJ2UOA4A/Tjuh51zKNWHNEPYu6z717iSBE7Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=elPcZdZfS9OrQbw+vpB0Es+p5EncP7w+9Ihnqv+snQg=;
 b=iqgBv6dt0HjlahY8HJWDDG0es9Pp9wXVt0CNi3jfIR3httjpwp35N01DtOZmc1YzbRz+a8W0GnkRVEBjEVXazWH5UoIq+RAKmo4T1vOz8Kq9PyLcJm6jVyz7h4qFk09Bkc6Yh1AktMc9UnR7GW3yhMR+/ro4sqmVaekp1x9PuUI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6395.namprd12.prod.outlook.com (2603:10b6:510:1fd::14)
 by DM6PR12MB4481.namprd12.prod.outlook.com (2603:10b6:5:2af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Mon, 12 May
 2025 17:55:11 +0000
Received: from PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5a9e:cee7:496:6421]) by PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5a9e:cee7:496:6421%4]) with mapi id 15.20.8722.024; Mon, 12 May 2025
 17:55:11 +0000
Message-ID: <8c89410b-80f2-47ad-97fd-6ac10752c040@amd.com>
Date: Mon, 12 May 2025 23:25:02 +0530
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
Content-Language: en-US
From: "Rangoju, Raju" <raju.rangoju@amd.com>
In-Reply-To: <CAMuHMdUAE2umYggDdBjYZJY2-mYwim=P_=4Q00k9b8gB1tNY+Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2P287CA0002.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::10) To PH7PR12MB6395.namprd12.prod.outlook.com
 (2603:10b6:510:1fd::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6395:EE_|DM6PR12MB4481:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f130003-28d4-442d-326e-08dd917e23f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aTc4dDdBTndOei9JQmRaK0FFQm5oZ1YyeFVGQVJpTE5UTkR3azJFRUNUYXZE?=
 =?utf-8?B?NVVpWmlnN3dENVNwdTdhNUtsUmdGWlpVYWlYNWpIeXpXUysvbnltYkpuZHk4?=
 =?utf-8?B?MjhPUWQyMVZuVlZHOXYvVzRjTVU4TzZYM1N1TjVsQmJNOWxsSUVRMmhqeU0v?=
 =?utf-8?B?KzZ4V0VXUzVDWTZOVStVaDBRV245L2dtL25BTnA0YlpwNWlnVDkxdFo2eGYz?=
 =?utf-8?B?VXpoR2N6aTRoNTZnZVpYWDMvMGhEdHZOekZYRVlld253SjFuVWdsWU9rcDVN?=
 =?utf-8?B?amhaOGxDR1hJSXRBaVlGMGNkdVZLbk1RKzBEcC9qTEVtUU5KY01tcWRwT3o2?=
 =?utf-8?B?bmFLNm5nWnVDdFAvSFJHd1hBbldldXhrVjQ1TnBRc0VBRmZkTGpyVEFnVHVm?=
 =?utf-8?B?QXRybzJCTHJrdXgwQWVWcFlHNGRYMTN6OVhuRkFTWmZBQkQ3RGNaa0Z4SXlw?=
 =?utf-8?B?dS9OUW0xL25Hb3hScnJlakw0WXZ1aHRqU2VjemlUNUJ2N0tKV3F0ZjE2eUFK?=
 =?utf-8?B?N1o0UlZ4ZHZzMXdlVm1maXpUNUxIMmlaKzBObDVTY3Q3NTgzU1IxN1I0bnhW?=
 =?utf-8?B?SW9TTHJpMWJaVWltbHo2QUNyNWdsSFM4YlhOZWhQTWFzNWZrUklhaG5nczFN?=
 =?utf-8?B?L2xUcXUyVTVNMWI2Wlc2b3lmMzIrL3FLcXB3WDRuMmc0TUdkQ0ZiZ1Q2MFR6?=
 =?utf-8?B?ZmMwRjEwUFgyTFJ1a1NpSStiZmlQM0xaenkxZ2dJWTIyV0x0M0pwakNNYVk1?=
 =?utf-8?B?ZE4wTjRIMC84V2lVWHA0MzJyWldCSUZxaE82V3ZMY1NVWlRqMmszeStDVFRV?=
 =?utf-8?B?SzNTNVg4WkE2cXBGdGkrb2VQZW93WDhmWFhXN2hHYURzb3B0ejFpbXE4dldP?=
 =?utf-8?B?MkpyTytpcXNqWWhUYUdNQzVhSUg3VURwdWdEL1ZISUs5aW0xVGppYTRDMUl1?=
 =?utf-8?B?QnhYUEl5SHU5bWhRRCtPZmhKc1k3eTBVVnAzaHNqd2l1ZGdJb1FDampNVlp4?=
 =?utf-8?B?a1M2enBDRUNLc0ZLYXVKMXZ1UmFFNCtpME90L05LcWgyZDl6T0kxQ3JwZFpR?=
 =?utf-8?B?THp6U1VkZlFTRmNnOUs4eXZoOXFLQUZyQjkzRGNiSjZNblBoeXpoYzhRc3Rn?=
 =?utf-8?B?cldpdE1NNVJwY3V5ZlhzQld2UjdxaEpVM3o0LzZucDhUcjI3RDJsWDdENHpF?=
 =?utf-8?B?RHlLQ0lzaG1CWlRNQmx4a05ITnBvSk84WUd6eXlaNXgzS3Y0YUFIZ05VT0VW?=
 =?utf-8?B?bDVqWmFJNUV1SndJVE9RSkVuRSswUmRPNXluelVPcWFtMEVvTW8yekcvaElX?=
 =?utf-8?B?Umhhd2N3S1BORzFUOGRNdjliWlgyRFFQUmtrLzQ0d3ByZU02cEJadFpSUHF2?=
 =?utf-8?B?WTVzQXpxbGF4UTlaTGpjZ3pUU1NxRDFPZ2VuN04xdk1kaC80MDNFdnp2ZThE?=
 =?utf-8?B?YzdZamdrTzh1dWZXWWl1T0l0SG9LZ1Z5d3ZzTERWYVUyWkUwQkRwNmFqaTkz?=
 =?utf-8?B?WXRheFdaUzFUMW9pNTh2MUZqeE91eWxBd0Z4YmlQN0hneHFEbEdnbldNcHVW?=
 =?utf-8?B?Qnh2QUhXK1RLYUM1TWhaYWxIZlgwMDVOVnJZenlDcFc4Z1ZxaDZJS1pyc05s?=
 =?utf-8?B?SHZVOFlOQ1ZuV1pka2NEdDJubzJ1R0xHbkF1d0wyS2lIY2xQamp6NTZidFgw?=
 =?utf-8?B?cGVnWXdraVVmdDNGdWdnNUV6T0JOZmVsUXVIRzhncVpicDY4eXlROGs2UzJM?=
 =?utf-8?B?VTVVL0w3MHN6V0NCTTdEK21iYlcybkg3RS9BSnZmZGtTV3dQY0RkekhnVFZt?=
 =?utf-8?B?ME8yYS9pMDA2TlFsK0NEY0RnQVBuUjRPM0w2ZE9Wa0VMRzlHblo4TDBOSlpE?=
 =?utf-8?Q?q1dhrDYTuViFe?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6395.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aEpWSW12WE1jaXV3UWdEQklqeTVHR2JPNjgxdWQ1R1pDNmdQT2x0RjZKRHYv?=
 =?utf-8?B?cW0zUFlOcktvb1NXWHRNMVdTb0xvUFVYUXI0NFdqY2tlTEcrNnV0WTdPR3F6?=
 =?utf-8?B?TmVXWDg0Rk1HQlJTMFdNU1hBYWcrNGFrNm0xN0RIWDhhcndGSkZaZzJOdmEr?=
 =?utf-8?B?QWVlNTFnK0xaaTZWWmx4R0RsdFk1d1kyNlJYdDIrUlJwRTZ3czBLazhINVA4?=
 =?utf-8?B?RGdKaWtaRVNRbVl2SjhwN2NidGRxWXFUdTZvN0xGbGJvbFhVQXJ6dTE3SHNm?=
 =?utf-8?B?anpWeUNTRnlJR2RvVDJGNXFwQlpxTFZpemduWDhkR0dsWm1aRlBOb0M3SmtQ?=
 =?utf-8?B?ODNXVU9VRlRTOGN3TlVPVCtOMXpoQ3dlNjc4YkVIRHVHMUpsMHp0K0szWGdK?=
 =?utf-8?B?Z0pGUHMwV1JGOW1hMTBOTE10ajhpL3pGQS83d05aL1JQWUV4dzQvVG5vTWVw?=
 =?utf-8?B?a0FHbWFkak9DbnppUEpzTDZnMllzeTdDUDAzbCtWb1RMc0pBZmhVVE93R3dR?=
 =?utf-8?B?Tmg4Q2JYWktYYnNyRUNvbTFvOGFjUkVDbFhPaWhRa3NPTlRqWEIxU0ptV1BW?=
 =?utf-8?B?REV4OWI3cHlOU2ltU0RvR1NVYXl3YWtqN1pWcmxjd1MwejBOT1dBSG4xNnNu?=
 =?utf-8?B?WDVkZzJKQTJocHRsSUI3OStUeTBKVWNZYWo0b1diU05tOHplbXRVRldiS0tR?=
 =?utf-8?B?SUw3WDRYYWorSXIzUTljUE5KeFozaTVOR1JmMVBCVHh6RlQ1SmVzOTlvWFVT?=
 =?utf-8?B?OE1YTlZWbGRkdWpsZVdxNUc4MXF3Q3ZvQm9nQjhzVkxWbDR0bXArcGxTeWFw?=
 =?utf-8?B?UGRnZEVidm8ya2NLSUNjL2lYWitqd0FSOGVBNS9vUjdwQ0d2WjQ2Vmt5a1Zy?=
 =?utf-8?B?RU9yYS9FRDBMZzE4QnpkUWxoYnhPUlFkM0JXcXF6VExLQjUrcU1UazI1V3Mv?=
 =?utf-8?B?YWR4a3hnZy8vMERiWDBSQmRuYXF4U3lPYWx5alFxbElhanlndCtlT2JpQWRz?=
 =?utf-8?B?OWM3dW5pQ2lvTllwNlhqc2ZDRXZXWEU4S2dWWkdhRzVYejRGR0lVK1cxcFV6?=
 =?utf-8?B?NFZTTWxIUW5SdjdxN1VrK1AwU1RuOXBYVjhnMDZRVXlkb0k0UTl3ek5EU3JK?=
 =?utf-8?B?TGFJUXBGRFZTNFRpS2R4czRVQm1lRGlheXplQUprRWl5b2ttV2tiQzcxenlY?=
 =?utf-8?B?REVRRzhnMVhpaFg2RHgwQ2pDYkxIdTBBL2QvTGt1V3lobTdhajJpMERwT2dB?=
 =?utf-8?B?c0VLT04wTEkyOHA3SmtRVjd5TmxvbW5rMktPSUtuaTE5b1ZNT0JKT2VaZVN5?=
 =?utf-8?B?RkJzQzNsaE96WE1VY0ZMcjM0RFF3WUdzRFRJODJEMGVIa1hxWncyT0FYNity?=
 =?utf-8?B?VjFDTDhSalpzU2kzN2tOSldhSmVSTjk4Q1I0SFdZWk4rU2NHWlh2L2FVNkc4?=
 =?utf-8?B?V2IwV1owYzBENlZMaFVmL2tmN3Q0dWFMUGlhNWNkaVhmYkQ5SXo5ZkhOL2hX?=
 =?utf-8?B?RVNNM3JIeXpMMkxXZTdtTm15a3dxQzZEM0E1V3RoekVDS1JEejFQTytYL1pa?=
 =?utf-8?B?cmNNNEc0cUNSZmxSL2tlVlR0NFpVVnpBZ3JEZ2czVG9aUVdMMTloSUkySzY1?=
 =?utf-8?B?RExzODJHaDI3Z0lhU1pnTnIwNU9ZN05KWEh5eHZoREJLZC9SREF1Z0pjNkVH?=
 =?utf-8?B?SC9BOTVkNktKWDNrTXhxdTdlYS8weWdESkd5NGZqa3ZWNUlpalVrSjJuUU85?=
 =?utf-8?B?dy9ERk9KOG9mWElJQk55VG1Ib2o3Y25GSURxQ2t4L3hqKzBPZWQrZVFsMkJG?=
 =?utf-8?B?VmtmbW1URmNNREprUXRZNmlEc0ZzcnNpV1dSUUJycXJHTmRHcklNRUxVSkhr?=
 =?utf-8?B?YUlYSU16VitaQzZOTWFUSnU3SWhMYk5JZXk3ajBsSEVTbVJianpOSGZGc3hi?=
 =?utf-8?B?K0JUTkowOXk4ZTVsU0NBdDlSN2RYSnBFbjZRZ2xQV25wT1NsaEo3bEI1WnRO?=
 =?utf-8?B?OFdablFkeXJZUjFxSTlSaXcwR0Fza3NBSGpVSjNud1ZZN25yZzU4ZHBVQ2Vh?=
 =?utf-8?B?ckhuaDdZTmtpVC9LOXRIeW85ZW5SSjgvZWRYRk9HdG5yQ0JHSHhxNnROY0JB?=
 =?utf-8?Q?WTIBW4oL6o7SBWYAdWkjiWNfY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f130003-28d4-442d-326e-08dd917e23f2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6395.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 17:55:11.5175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GPbM70/JrEzaH2Ei/oltcErDO7IuuNzcPyzLkWaL5NT6QgLCj7E0QIkkqykQysFL8rqTnRRZKsWIxtZ4VHtZyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4481



On 5/12/2025 7:47 PM, Geert Uytterhoeven wrote:
> Hi Rangoju,
> 
> On Mon, 12 May 2025 at 09:29, Rangoju, Raju <raju.rangoju@amd.com> wrote:
>> On 5/11/2025 3:51 AM, kernel test robot wrote:
>>> kernel test robot noticed the following build warnings:
>>>
>>> [auto build test WARNING on v6.15-rc5]
>>> [also build test WARNING on linus/master]
>>> [cannot apply to broonie-spi/for-next next-20250509]
>>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>>> And when submitting patch, we suggest to use '--base' as documented in
>>> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>>>
>>> url:    https://github.com/intel-lab-lkp/linux/commits/Raju-Rangoju/spi-spi_amd-Add-HIDDMA-basic-write-support/20250510-021954
>>> base:   v6.15-rc5
>>> patch link:    https://lore.kernel.org/r/20250509181737.997167-1-Raju.Rangoju%40amd.com
>>> patch subject: [PATCH] spi: spi_amd: Add HIDDMA basic write support
>>> config: m68k-randconfig-r111-20250511 (https://download.01.org/0day-ci/archive/20250511/202505110641.zLT16Dv7-lkp@intel.com/config)
>>> compiler: m68k-linux-gcc (GCC) 14.2.0
>>
>> Thanks for reporting this. We do not support m68k.
> 
> All write[bwlq]() functions take a volatile void __iomem pointer
> (https://elixir.bootlin.com/linux/v6.14.6/source/include/asm-generic/io.h#L174)
> while you are passing a void *, so sparse should complain about this
> on all architectures.  

My bad, with the following flags included, sparse now complains this on 
all architectures.

-fmax-errors=unlimited -fmax-warnings=unlimited

And sparse is right, this driver is using MMIO
> accessors on allocated DMA memory, which is just plain wrong:
> 
>      amd_spi->dma_virt_addr = dma_alloc_coherent(dev, AMD_SPI_HID2_DMA_SIZE,
>              &amd_spi->phy_dma_buf, GFP_KERNEL);
> 
>       for (i = 0; left_data >= 8; i++, left_data -= 8)
>              *buf_64++ = readq((u8 __iomem *)amd_spi->dma_virt_addr + (i * 8));
> 
>> Will re-spin v2 with necessary changes in Kconfig.
> 
> Please fix the real issue instead ;-)

We are using read*/write* calls instead of memcpy to copy data to/from 
DMA memory due to performance concerns, as we observed better throughput 
during continuous read/write compared to the memcpy functions.

Additionally, the DMA operations are entirely handled by the hardware, 
and the software's role is limited to copying data to the DMA buffer.

> 
>>> reproduce: (https://download.01.org/0day-ci/archive/20250511/202505110641.zLT16Dv7-lkp@intel.com/reproduce)
>>>
>>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>>> the same patch/commit), kindly add following tags
>>> | Reported-by: kernel test robot <lkp@intel.com>
>>> | Closes: https://lore.kernel.org/oe-kbuild-all/202505110641.zLT16Dv7-lkp@intel.com/
>>>
>>> sparse warnings: (new ones prefixed by >>)
>>>>> drivers/spi/spi-amd.c:594:57: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>>>      drivers/spi/spi-amd.c:594:57: sparse:     expected void volatile [noderef] __iomem *addr
>>>      drivers/spi/spi-amd.c:594:57: sparse:     got void *
> 
> Gr{oetje,eeting}s,
> 
>                          Geert
> 


