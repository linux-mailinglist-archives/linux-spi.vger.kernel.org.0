Return-Path: <linux-spi+bounces-10424-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19401BB2941
	for <lists+linux-spi@lfdr.de>; Thu, 02 Oct 2025 08:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85FA419C572D
	for <lists+linux-spi@lfdr.de>; Thu,  2 Oct 2025 06:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81FD62494ED;
	Thu,  2 Oct 2025 06:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rdQb/5MR"
X-Original-To: linux-spi@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013036.outbound.protection.outlook.com [40.107.201.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C149632;
	Thu,  2 Oct 2025 06:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759385218; cv=fail; b=FyPSQFzzolzTQrTVQpTldx6pHMBoBnHVFuqKCR38dSfm5wOH0vpuAwKe8t3TWDwDCrvc3iAei1ZkMs8YsYO64W8cnG1LGMBoprrDm58mPrcflt4z0QeWYUyGzc+VZpv/sfLpAZrpcNCQvCrJ9Vxk3jP5LrGb34PqTfjhJQNKYas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759385218; c=relaxed/simple;
	bh=eiSB7q5F+cG8qg/PSCmj/wffA0iX19bXTh9ga/NB0xI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=r8JLUfrLQHfUgE3vZyJfjzYrb1SOY4kbLuoUKoAn2MkvzEPnk7L1TQzKTOEd5Bb+GRB0KzCC6l/5mqauyDyEYa7ME57v/DzUQVEePokl0M1DZ6Jm+A5J0HJQTohPWomaVY123AtqNw59odfbMjZC9neyjeVEy6vFcP4myGfTyik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rdQb/5MR; arc=fail smtp.client-ip=40.107.201.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LdoDkniQZacYCkHNOfSPziyrF+7MCs2g9NOLcvMIgihAp53C9vSXNbvyV0bUJLGpdWrVB3gUdl4c0BAAqHU9zPfwQDONF/6eEd0zF0qLtn1b8gDuHpjfBIV8e53U94NBKx8jGRIEEKa0qq1tzjG1WqnRs2q06puua8hpB3cHv0cWmyd7BAfr/aA6BQIhBvjL0ZjVjAeZKPIl1Ld+o+Yc0E9tJHCx9ELD/IIIGQ6MbBJTzJIEQ5jUga9fvu4NQotPxxk2N5ZJips/w9/nzqdUBj8YMwsTkwYXlqC8/Az9PTCAgG2o09D+kjEd8eQm5HXTatPZOKvohbNIvvFGYF3DEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lnc9W7OJ0LlgvK62PgNgZLyUaLQ+jaAu2xobMZZB6r8=;
 b=VNukHQOPS35E0puzTGas5fgtZgvxzNRZ+eN3PNGlY11SQg7AjKjQnMQyaup3YTzLHihvG9JMvqZ5zl6IOF4hKJQQSr5+jE+Ublouze9bd5aFtM8L2XCilvn2qUTd5jfN25u8aQQTkOmvlP7izTXDGHDDZNmjYerByYVrZLvBqMgy0jdNd3cQqUuirarksQ0eMVEp6ZsO1cY4mR+ure3N216ZVZWCgN3Rnhbk38Dbv45N/w4tJQ90Png2pe/IrTH5j0kf8c4UZT/9qNmBWpvK9K2Z5eZQ/g7f3P676UfJOaN5/D5TH/mPhg/WyUrfHWv98KV6xFco3cT9CBn3TMKSrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lnc9W7OJ0LlgvK62PgNgZLyUaLQ+jaAu2xobMZZB6r8=;
 b=rdQb/5MR2pVyLxsFqtcOarunrzUtjfa7Ke95sw4oGhy/wObcdsTir8eg6dfTxTXxIqfmEFmxwfdmNYAEpSf4ZTIVVX2s3fBzjLwhTlXcmD1byAC97kh9jSM0bw622oz2nYqO23Tjr1WJHHzExA5u8klFk6lvObcw4uFOGv9BEso=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by LV8PR12MB9181.namprd12.prod.outlook.com (2603:10b6:408:18d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Thu, 2 Oct
 2025 06:06:53 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9160.008; Thu, 2 Oct 2025
 06:06:53 +0000
Message-ID: <101a83ba-cd2b-4080-aaa3-630652c33786@amd.com>
Date: Thu, 2 Oct 2025 08:06:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] arm64: dts: xilinx: add soc-specific spi
 compatibles for zynqmp/versal-net
To: Conor Dooley <conor@kernel.org>, linux-spi@vger.kernel.org
Cc: Conor Dooley <conor.dooley@microchip.com>, Jun Guo <Jun.Guo@cixtech.com>,
 Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20251001-basics-grafting-a1a214ef65ac@spud>
 <20251001-cheesy-shucking-c55431bbcae3@spud>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20251001-cheesy-shucking-c55431bbcae3@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8P221CA0058.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:349::7) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|LV8PR12MB9181:EE_
X-MS-Office365-Filtering-Correlation-Id: ce8189b3-92a8-492d-18c5-08de0179e208
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bmdwa0tqOFNSclJ0bXBKdStyMWJkMWFwU05uOGY0OFQ5WW1zRUhaUjhJVXVK?=
 =?utf-8?B?WUxpTGN4WlVEYTZUd3VqUG1wMExhdnRjeWl1eWN6MStSUE1EYkRqMGtiUXJu?=
 =?utf-8?B?eWtBSWNEM0grSkEvZ00xcUhwTE5WbUdYNGxwQkdnQ0Z0Q3Z2eU9ZckZUYkt4?=
 =?utf-8?B?WThuV1pPT3FUZm9ZWkdYa1Rwbkg2M1RBWmQ1RE1laSs4WFcvOTdwUkxPeXNV?=
 =?utf-8?B?RkFqOXhsWlRqWjFEaVhmRDlZbkN4bUdBVGZjQUY2RmFNT3Z0QnlPcDBZNTBD?=
 =?utf-8?B?SmxwdnNUcUthU01XUUErREJ0ZG9zcjQ5MzdOUCs2bE0xYjFXM1RIazRkK0tT?=
 =?utf-8?B?YVhFTkd4elpKSmY1cVRaekRWMnRUQjFLS1ZtVXczN3gvTEdKRWVVWGdpM3ZK?=
 =?utf-8?B?OWo0NGxwa0loQzFkZjEzd2crOVB4eS90UXJlc1VpVmZ4OFlERWozMW5jMG1y?=
 =?utf-8?B?RHZKRm5tUnNtVk9kanRDNko0K0t5UTVjb3RWZnVnc3hmSTFaMWloV0xWd2pH?=
 =?utf-8?B?WDhDNFNHSHFmaHJ0VlBGdERjdVYzemxrT3M0REN4WHhxRVlobnh3cE1GeVBN?=
 =?utf-8?B?NEVlSGtBQmRTbHVycWZVV1ZyTTk5bFE5UHc1NmFLdFVkTkJVSEJ1Z3ludENX?=
 =?utf-8?B?RlhKR2o3VXJrUEc1bERmbFB1QlNDVXdPOXNCanh3MHZJeXZPNExTYXlRelhV?=
 =?utf-8?B?bHlYcjdaUTBzZEUrOXNLUWdYVVU5V1J2UXMrZ29lZ1dPekV2SmtMVzFNVnd2?=
 =?utf-8?B?cmhDRTh3dWZWaDM4L293MEVnM2IybzJjTlVENG9HdDBKYmlwU3dUR0NIU2Jm?=
 =?utf-8?B?bWhBTTR3Ny9hZlkrT0tvVEhvbCswK1hEU0ZoYXJadCtXNkZmSjdPQzVjVmY4?=
 =?utf-8?B?eVc3QU5ET2lUd2NkUmlHZHZaWVI3cS8wVGltTkV0V0ZHUXhSeVNZd3hWaXg0?=
 =?utf-8?B?Z21JSXBrMU4ySG9LNGYwVkFpelBOeElYUWtGR0xMSUFZaWNmVmRGN01DS2U5?=
 =?utf-8?B?U2NQYjNEVzRaNDd4MDh3TXMrbnVTaEtSZVNNcHZ2eHNSNzVkZHdPVGR6bDhX?=
 =?utf-8?B?LzNYUnowUHFPU2Z5Wm9jakFHWFptZEpQNHo2RGtuZVllVjlKbU1jWXNobTBL?=
 =?utf-8?B?S0o1Rmw3dnZEOWtLN0RSUU9CQ21MSWg4RlpjTGlYUmpqSGNzMkZFNjMvNEpU?=
 =?utf-8?B?a2ZMWFdhTmZ4VlhZQTZXemJrdnBTOTVHdFdkMi9CODZ4enJ6U3RJRjd6S3BB?=
 =?utf-8?B?ZUx6VU5wMEZva09semNUTlFLTGRCR2JxenhHclo2b0ZleTBPSVJVd1BRcnZH?=
 =?utf-8?B?b09xTUwwb2NKK3lPL2RtZjdYMGdLdGM4UjBmRFZiaHJlNlRxclRRUFZTUXVv?=
 =?utf-8?B?MDc5UHVTT2s3VTNHSmdWb0xVSkc4UnhCbFRiVXhwaUJreWcxU3BTRzk3dDU2?=
 =?utf-8?B?eEhpbU1tRTkzL1RIL1QxSmZ0TEJ2Q1k0R1BKakJ1blJlM1prN0Q1bHM1T1NK?=
 =?utf-8?B?WWsrcTBiVHR5T0JxSnQ3ZXNic204ZkJzQzV5czRWbmdRUDFZcFU5Y3U5Ty84?=
 =?utf-8?B?V1VoTDBrbHpGd3cxQzQxVTlYMkE1S0haSnFySzZobURQMUNHeDc5MUJWeDla?=
 =?utf-8?B?Sk9tS0FDY21BUmtmbGJHeUVnSlRjTmx5bndmN3pIaCtKU0xCRWhKS1g1VTJw?=
 =?utf-8?B?Sm9Tai9ab2FMWVVqSUFIV21ISGpueDJYTVNsUWd1Y3NKS1lmTDNrYmxwT2J1?=
 =?utf-8?B?ZHRjQ1lRbFJYNUl5RVdqRjYzd3lnbTd1dkxDMUFuczNaNy9zdVZ5Nk9mUnp2?=
 =?utf-8?B?ZjdKYVpRZ09ZUTBxYTBLMjcrNStHS3pESEYwWkVmdENYbk5ZNkZTaFBPemQr?=
 =?utf-8?B?NU9Ka1E3OGFJUnhkV2M5dHBuK1k2SjYxeFF1YUNPMGVnWHEwbFJvK1Q2OW9D?=
 =?utf-8?Q?6D946Mk22RLuAIVeQ/eh+DYTuOFkJ7tV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WTBKM1BUMTl2WWk1aXRobGJjSzRvVnVKUHlDckVjUkZHU2YxaEhHZG95QjVR?=
 =?utf-8?B?VnVJZVA0WTUwaDNiZHNaTkV1TmxOY3hyVG1GdkcrT1oyUm1tenRObUhSUmVU?=
 =?utf-8?B?d0pxNThuUHd1elY0eitkRzBPU1NId2xLK2hXd09hMUtzRjhpdGF3ckJ1d0JK?=
 =?utf-8?B?T0piS2FoZlYxNWpHUEUvZ1JGVUZ4VFYzeFJvbzBCdWVPaVlQZVVQQkJZTXRT?=
 =?utf-8?B?c2Y4MlR1VjhwNkpqek1wczdPSkI3V3pGcVkwRzRGaDFqcEtFUmRkMUt4cTMy?=
 =?utf-8?B?SERkYVRmVEhKK0lDQS9nOTFKcWkxNUsxL3JEVjY3UTZQWEdqMTZpV3hLME5L?=
 =?utf-8?B?M3F2aFd6ekZUVm1CM2QzQzJEOUtmUlA3OGNWT21DVFc0c2ltdHAxa2hOdXNm?=
 =?utf-8?B?UWtqeS80dmI1U29rZ0ZsWlYxcTlpV3BEQytYL05KWWtEWWQ5ejYyYWM3cEtp?=
 =?utf-8?B?VEZlT0wxRXhiSXo5MlVSWVZES2ZoV3RFdTF1MzVGaGJXS002UXRDekl1TlI2?=
 =?utf-8?B?NmFDcFVndkVHM0xiajJkWkRja2ZvaFFzMmlpS0pwcDVQMXRhN3l0RmVMNDNt?=
 =?utf-8?B?UWI5ak83bE96RllRSlBvTmhNTlQ2b3pGTlhpcFBvZk5KNkxkOVRDS1BrSWlD?=
 =?utf-8?B?TnFOeDcwcXdScHlVYVNvWXJBaTdhSUsxQk5wV0NPSm1pODFZZmdFdXlYeXU0?=
 =?utf-8?B?REhUV2VrbDdVdXVMcXVHd0NjdjlkOGdxS0VXczdJQUV3enNZUlBKckFzVHRB?=
 =?utf-8?B?ckdobW1GZGpSMnYrelQ2bGZLOXBqd285RzhxVUV6MTRha29YT1BiOGRsZHdJ?=
 =?utf-8?B?bkNwRGgyUHdITlJWak9kTlgrRnNpVmRMejU3MFFPdlNRY1JXS3hMK2NUMDgy?=
 =?utf-8?B?NXVIU0lkOHp2Y00veUFIUlA5QkdkOHQ2eXJkclR4UVVMZmhZQ2lXdzFRc3p4?=
 =?utf-8?B?V0duVWVSY1hLSURMNXFSbTZSbmdRdzdqc3JidURBcWIzZGdkUVMxRU5abE1O?=
 =?utf-8?B?NHg5OC8wbmdtdEVlb2NPNEtROExMTU9nblRxZkRYeENhTFlGY2pLb1ZJbWJp?=
 =?utf-8?B?dmJyamd0MHpReVA1dWY0VkdXNXd3WVN0OTlpS3A1WC9XdWJHZVZ1dkMzdS9K?=
 =?utf-8?B?YVpVOFlFSnpEeS9WaDhIZ2VnaXdDRThPYU9oUG41NFRMNE0vb3NoSHhIUzRU?=
 =?utf-8?B?ejcxLzlZYkNxYXl3ejJiRUlPVnVTTm1MNGxCdkhFd293VFNDazhHbU5hays4?=
 =?utf-8?B?U2Z1dzZCZjRFZzYwOXN0Z1F2Y2JPcFdyMEg4V3FDTnRTSnVwL3ZGRHA2YUVU?=
 =?utf-8?B?M0tNZ0VlMjdTNjhZUlNIZm1QT2FhcXZub3ByL1djYWVnWEd5ZXhPSURGbHd5?=
 =?utf-8?B?Zi8wTXZIMDQzWjRndGJTZ0h5TGUrYVVIdDFybjdlZXhHY3NsK281NDR5VTQy?=
 =?utf-8?B?WVBISXRaWWJJN2Y0MzV0TmYyb0YzbjJhLzdhUDV2SDZSTnhxK3FQR3FwZ2cx?=
 =?utf-8?B?ZWNLMFcvMTY5YkZDU2M1RU9yVzJXVHBBQThMdmdhRTFNdXdFWjYxQk5ZSHRi?=
 =?utf-8?B?dGZ2bHEyeDdZTThVa2Jrc3dzNmxTMnI0RG8zWjJiRUxzQTNjR2QwaU55UXl3?=
 =?utf-8?B?bmR5M1JSNXRvMit6UTJlT3doVXNNVzVMeGVncXN5NjIxUTJNNnJ3N0x6Q1Zy?=
 =?utf-8?B?Nk83dHpMc3ZIaDM4NFJhMzgxZXFFcWkrcHFsNDJDRmpoUWZGcUgxV0FKUXli?=
 =?utf-8?B?d01vMEYyZEJScHlac3RhdHN2a3o3dHprbTVQYk42eGd2aktVeTJXNi9iNlcz?=
 =?utf-8?B?S0RhL3ZWRTR0b1dmdVMvNjMvUnZ0c1NVdzFDdGg0VjU2RGpub0xFSFA5dHVj?=
 =?utf-8?B?d2cxVVc5YW93djRUSU5HdHZhNnhVQ3Y4RGV2R0lYY21RNXBicFR4MDVnZ25m?=
 =?utf-8?B?M2dJM2xUdG1veUF2T0o2bmUzcm13d2tra1lEc3NuakFiK3p2RENGTG9WVjI3?=
 =?utf-8?B?NThRbzRoc05naXVuVmhjOTlCTThqZ0ZkTUU0RlR3clczZEJSeFJpVGFpSU1P?=
 =?utf-8?B?UDYwcU41ZGM0ZFNrSjJuMmFRdDdNUS9zWXQxTXFtdTdLdllJT0ZCc3RWTVRZ?=
 =?utf-8?Q?iyR1dt3OK1dV7Dfw9OI+RscYJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce8189b3-92a8-492d-18c5-08de0179e208
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 06:06:52.9732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e3aEXKBZW561v0wtZwg40+ZbAQZUi7onBwnd9aEb9tXb8SqPCu+C8JlUENwAcKTQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9181



On 10/1/25 20:31, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> Unlike zynq, which has a specific compatible for the Cadence spi
> controller, zynqmp and versal-net do not have specific compatibles.
> In order to "encourage" people to use soc-specific compatibles for new
> devices using this IP, add specific compatibles for these devices, with
> a fallback to the existing compatible for the r1p6 version of the IP so
> that there will be no functional change.
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> CC: Jun Guo <Jun.Guo@cixtech.com>
> CC: Mark Brown <broonie@kernel.org>
> CC: Rob Herring <robh@kernel.org>
> CC: Krzysztof Kozlowski <krzk+dt@kernel.org>
> CC: Conor Dooley <conor+dt@kernel.org>
> CC: Michal Simek <michal.simek@amd.com>
> CC: linux-spi@vger.kernel.org
> CC: devicetree@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
> CC: linux-arm-kernel@lists.infradead.org
> ---
>   arch/arm64/boot/dts/xilinx/versal-net.dtsi | 4 ++--
>   arch/arm64/boot/dts/xilinx/zynqmp.dtsi     | 4 ++--
>   2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/versal-net.dtsi b/arch/arm64/boot/dts/xilinx/versal-net.dtsi
> index fc9f49e57385..38af1a4e34f7 100644
> --- a/arch/arm64/boot/dts/xilinx/versal-net.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/versal-net.dtsi
> @@ -610,7 +610,7 @@ smmu: iommu@ec000000 {
>   		};
>   
>   		spi0: spi@f1960000 {
> -			compatible = "cdns,spi-r1p6";
> +			compatible = "xlnx,versal-net-spi-r1p6", "cdns,spi-r1p6";
>   			status = "disabled";
>   			interrupts = <0 23 4>;
>   			reg = <0 0xf1960000 0 0x1000>;
> @@ -618,7 +618,7 @@ spi0: spi@f1960000 {
>   		};
>   
>   		spi1: spi@f1970000 {
> -			compatible = "cdns,spi-r1p6";
> +			compatible = "xlnx,versal-net-spi-r1p6", "cdns,spi-r1p6";
>   			status = "disabled";
>   			interrupts = <0 24 4>;
>   			reg = <0 0xf1970000 0 0x1000>;
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> index e11d282462bd..89c565bef274 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> @@ -1076,7 +1076,7 @@ smmu: iommu@fd800000 {
>   		};
>   
>   		spi0: spi@ff040000 {
> -			compatible = "cdns,spi-r1p6";
> +			compatible = "xlnx,zynqmp-spi-r1p6", "cdns,spi-r1p6";
>   			status = "disabled";
>   			interrupt-parent = <&gic>;
>   			interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
> @@ -1088,7 +1088,7 @@ spi0: spi@ff040000 {
>   		};
>   
>   		spi1: spi@ff050000 {
> -			compatible = "cdns,spi-r1p6";
> +			compatible = "xlnx,zynqmp-spi-r1p6", "cdns,spi-r1p6";
>   			status = "disabled";
>   			interrupt-parent = <&gic>;
>   			interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;

Acked-by: Michal Simek <michal.simek@amd.com>

Do you expect to go via SPI tree or via SOC tree?

Thanks,
Michal

