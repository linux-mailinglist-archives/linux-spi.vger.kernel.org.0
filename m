Return-Path: <linux-spi+bounces-9765-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C05FB3B40C
	for <lists+linux-spi@lfdr.de>; Fri, 29 Aug 2025 09:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ECF31B2514A
	for <lists+linux-spi@lfdr.de>; Fri, 29 Aug 2025 07:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C9021CA0C;
	Fri, 29 Aug 2025 07:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="PPS2u3nw"
X-Original-To: linux-spi@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023138.outbound.protection.outlook.com [40.107.162.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F211D2940B;
	Fri, 29 Aug 2025 07:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756451665; cv=fail; b=FTiIbJZDa7R4j1vxhuWpCNUGmZbKX47pwyNF4Z5WRcAo481r6bMaU60mCP6aVZTEMlxy/KuWgz1r0cs+vnmpmF77m+b00wQCJmbTkGaM6duSLsxAmg5DI+0okLGZIQHICs9OpMvdxTN7AWCUupnkPTWEBpUbw4IbsGFQ37WY8cg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756451665; c=relaxed/simple;
	bh=zWoY+hRvpL9saUM78E100BQWM/gLRE+XQY0O/0ibvzs=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SWVcisEiUScQbUzQBPSkqKj4BwO3TA33+fBUelm0fqAd5Av6DHRY8uxw/hKU7SvHjrQ00NGzb9KXrZI1/TeV3Noz1xb3lodqFaC1YcWrX4+yqMhdELTlZB3OFqpBXI1qEdif0w1RlStiUkb2wOdbxI/dS0NXNPk0Hn32YLE8EfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=PPS2u3nw; arc=fail smtp.client-ip=40.107.162.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=efTpA2dQr4VbfdfdeLp4wmMjZfUSOSoLy3m70sMEXx89RXlXe2jM6uDEUy3+g+/M/yy0ylbmOAgoo7Ul+WtsnAGfilEIwQgUBTWX8jWKHu03Fds6p6eWRQrsqoP2K02pksN2nWjaVnYMNFeddCa4pAuqRJ1LcvQhrC9Yz6NdAe+eTjI7a3psniwvu/KJ3SfMKqL3olLxlUcxwZ41zcRy+gmgWkJNBjiWphXxcoC1TigsDBUUbI+bbHnGyOZX5rS+rLEYKg99OTMGdOzth2JYkgaDRE1t0vX0L0e2jiEqhlfxJNTVNHsYO22bDJnDFhJQdbGSQUO0KvRK/T7PK8eLxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rqr2ua6jJFmJR8C2srES7iW0Wi412Iy1jdZfZZw2aNE=;
 b=uDzBcqwgtWMCJhgt+iD3KD1Mm8SZJ59Ix8FrBuwwUCqUAsHFFZI4chmsdbqnDnXM0n+fEIViilFKh5y1OxmGPZaC9aCdQzihlw05E2igxgSf4BLYwSkGoEcV4e0bUL5ve7zz+nK2UJEH0hBaHzXGJcRbjsvNSTiGfak2ST4qAd56p706RpktChWz0G90E1MmEFffpdNvXM7Ftqx8gOdu9TMeQabf00CrEUSBcidB97rcta3JtLaVE0T3Z7Fj+728tnhKzeEiKgJ0+GXGb6rJapKGw1eZnc0xH3QHhYsBahEZAwmxJoOrTQfWhAiFnq3J8lnjtvgxpTrAnwhQpdQ2jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rqr2ua6jJFmJR8C2srES7iW0Wi412Iy1jdZfZZw2aNE=;
 b=PPS2u3nwA5km/xSZLje5akNxnM8TCHJlzC8AwvE6LqmCZnoQ7R6UafhN6JpATKRdz1K9Odkq5Aczwg3q/v957GZt8odzrai1TbFTf3fJRjYRx839s9Ce3MbaIq0qa8vD2qNgjrcrSazTqMDhrQdy5KNAuYYA7EalXMq9rWBut7NHvn+n2Hq7DPlZagwmWuHKoVJdYtNX0S59SeIKXABpvl7K3UYxUuqw5t4bBBFL13iS12rvzgzLO67iYSlNKP2rju/Ge4q2WoZ5p/dKdv9Yk69qMebHMkAH21S++Fu7WZ9xW9obHduMuz3u/4y2ksgazbf56PMHvc0WGAf48oTBxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PR3PR08MB5578.eurprd08.prod.outlook.com (2603:10a6:102:83::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.15; Fri, 29 Aug
 2025 07:14:19 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Fri, 29 Aug 2025
 07:14:18 +0000
Message-ID: <11fcd899-390c-40b6-b1a0-7286dc1e01e4@iopsys.eu>
Date: Fri, 29 Aug 2025 10:14:16 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/13] spi: airoha: driver fixes & improvements
To: Lorenzo Bianconi <lorenzo@kernel.org>, Ray Liu <ray.liu@airoha.com>,
 Mark Brown <broonie@kernel.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Andy Shevchenko <andy@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>
References: <20250823001626.3641935-1-mikhail.kshevetskiy@iopsys.eu>
 <20250823160116.3762730-1-mikhail.kshevetskiy@iopsys.eu>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <20250823160116.3762730-1-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV2PEPF0000452A.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::34f) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PR3PR08MB5578:EE_
X-MS-Office365-Filtering-Correlation-Id: 42c28a5a-c8a3-459e-f19b-08dde6cbaadb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z3NQUGViWnZGT1JtUDQwQkRZeHRjTXJqWFh5Z3cxUGVlcW0wWHJTMDZmWjFB?=
 =?utf-8?B?VGQ3ajBQM2laWjBxY0dNN0FaS3BoU2d1RWhlOXZ2YWpnZ1lzRk5VbEhPMDBE?=
 =?utf-8?B?L3pIM1J0Q1d1MGFETmR4V2JLUW9zeGhIblRJaWUxamxXUlVUcklEMXRjWDUz?=
 =?utf-8?B?Ynp5R3BGVTdEMXRENUpGNExXRTg4aUpEd0NNN3BGc3FzRjQ3czFleDRaMXc1?=
 =?utf-8?B?QmJmMlMxZ24zWUlscTVRMDlXRUd5Q2xGbVFyTWNOMWVVeHZyUVBpMDJXMnFM?=
 =?utf-8?B?azFOTEVLaVRHVXRYNzcwamRoeWJCZnNLM1NvbWp1WWV6N3lmMUhYOXdMMG1s?=
 =?utf-8?B?M0NpdDhnZ01yM1ZBc05vZUJ0T0MxeVFaZmNkVnFuMnBtMFFoZEQ3S2xqcUp6?=
 =?utf-8?B?YVM3VS9KWTFHc1lqOUxGZ3BybGpUUG1lS1NuSUpzaTcxanZ2b2J2Sktwc05W?=
 =?utf-8?B?b3gzL3dGRnFTekx5S2pPSGM0ajdHcnhBYnh2aUxYeDdVK1NHdG5CZ1pyTmZH?=
 =?utf-8?B?SVF6M1V2andxL01FeE1JTEgxaElVVmNnZDFhMFNKR2FHeW55K0hnbVEwVlZw?=
 =?utf-8?B?V0d0WXdDTDBtcjl0UE40a05kWFNQbW0zS1E0NVZmZ05FRy9wYnBXMjR5L0F6?=
 =?utf-8?B?ZEtmRjJHaldkYjJENHJMbGlmN2NoQ2FVYmlhejM2NFhpSFBNNDhZNE9XZ2hE?=
 =?utf-8?B?K2FPRFVJYkpmTllGRDhCelBwNTdRclMzL1RKMThxajZMSWpsRDhtSGFObG0r?=
 =?utf-8?B?VWFIWVgzem5lMFM3d05iUW9ubEppYStKeVNzZjhBdFJidlZFcDVDY1Jiclpl?=
 =?utf-8?B?bWhwZk5IMTZ5MytNVW5pd3g2bUE2RTI3Nk0rS2tDMnhzWmJMSU1WSHgvVStI?=
 =?utf-8?B?ZUR5OFZGMitna1RUUjk3M0loL1Fld3cwazlWM0lISDNMN0hEYlBaN2xqakJ3?=
 =?utf-8?B?NlNIbWxBUmduMWRsa0w0dSs5OFh0UlorUEZ3Zm1Fd01YczJwd3VqSm5sZ0dU?=
 =?utf-8?B?K0FzajVlbHBvcTVYdFdJRzdpajFGdU9KTmVCQWp1T0RxWFN0ZCt3QlNQQk1m?=
 =?utf-8?B?NnY3NFRxdVR0a1UyRDlFWVpidG4ra1o5N3JoSFUyM2VmaEp6bC8vRXg0bG9Y?=
 =?utf-8?B?TDZFYnRDa2cydG9OeWxaMmlqMUJRMzZkN3lBMEkzMGs1dHVCWHVUOHp4cCtk?=
 =?utf-8?B?OU5ZamFheU5oVkhsWVMyVWlyNHg2ZHpTKzNvS3d6N1VaeWlqQTRoWmN5WGxt?=
 =?utf-8?B?T0Z6bFUybjFsY0loRlRaZjdtTkF6UzErQUpSblBDcVBpVHMwck1JdjRRaC9u?=
 =?utf-8?B?ZWRHR0h4ekZpbFBuaUVMWG5CY0RIWTU2YUI2Qkora0xPVnFkL1ZoNEFLV0Jt?=
 =?utf-8?B?ckpHdk0yR1dLaTNlaUtFcmFxMmNwZVQ0dVd3NUdXY0drS3RubHhuQS9GTkZK?=
 =?utf-8?B?czkvbHNaSkxTS3E1T1gzaVE3dGh0OUlDbGZ5dUw0VmpWeEJRemVQeFcyMGk3?=
 =?utf-8?B?V0NQSGIwRTN6WG90bDVoSlVhZHhYRE1LTlZqOFlHQzMyYkNoV0lrUnNraktV?=
 =?utf-8?B?dnpqZlFqSUE5dnFGb3BneERpWFpkTmtFVCsvWWVaRDg4NEdxUU1OUUhlc2tw?=
 =?utf-8?B?RVkyVW1sZW9wZ2NWeFB3bUNiM2NxQlQxdXhSVVMwd2g2N0dBQVk1WkNXa3J2?=
 =?utf-8?B?M29BY291d1ZmMUNqWXMra0RGVzBKTGNnZmV0S1BnSXlWTWZkU1FPV3FiTXMr?=
 =?utf-8?B?akRycGFXbitPT2hPT3oxbEszOTBENmdDbmI0cFZhRHN5LzB6ZVdTWXRsSWhM?=
 =?utf-8?B?RkpoYzFtM29TYVFaaWN4UHlGeVBUMXRER3hqdDg3UzY0UTVzdGN5cVc3UFFo?=
 =?utf-8?B?RXhOcUYyYm14L0w4djdaZkE2bEF6aDZVTzgyODg0TDVkajdGaWp5MWliM0Nw?=
 =?utf-8?Q?yt0trv5BVUc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q3J6WC9Ja2FPaXlBc2NoaUhaVnRnNVZnRkJHZ0dNK1VQNmJEbkdjNEhmUTlS?=
 =?utf-8?B?MSt5R1JWMzJyZ2dwblJUcHFnTGZWQXU3Y0NZeS9Laks5VTQzeG1BMk9oNTRn?=
 =?utf-8?B?N241TFkzTXhCRnM2WjNpOTNPUnVRajAzakExdmxxdUFITWx3cjN4bHFaYWoz?=
 =?utf-8?B?WVRvMnIyT1E4bXp6blhRZWZMd3FYSnhrNDdmOE9VOEFJRzR4WE1LSkZPZWo5?=
 =?utf-8?B?RjltQVNPK0ZnYWM2VUtVSW9ZNm14WG5tejRIYXM5RlgvS1JHTTgrN2NaTFla?=
 =?utf-8?B?MTVIOEdrS1VjRUN5U0ltWW4xSGY0UTRjT1k2MEpBK1U5UEovM0ZKVzN1TDhu?=
 =?utf-8?B?U3N5K0U1bkc3YnlMMXhMcUhQdmRORUorUHlCTk41V2hSRUc3eWJMeEowUW12?=
 =?utf-8?B?WUlQd21pUGViWm1tRFZVdzFhT3RGSWZ6REFHQ2Q5MkUzNkR5dndJdTF5YXpx?=
 =?utf-8?B?Y3l5Qi9DZCszYjdaQWFHZTU0Y1FBR2xMdDc5R1d3aXpYc1o0OVpCRFhDcmpP?=
 =?utf-8?B?dmpZbE11L2JPL3VuZFhiQ2lrU2hWeWlpNUo1QWtIYmJDNlVzTnR0QllrVXcr?=
 =?utf-8?B?OHpVQTgzcTZhd29ZRDBIR2xqeVRiZEFSY1oyYW5YeFNOWTQ0Q0xCZkwzYUlr?=
 =?utf-8?B?MU9sK2NXdlV2a29SSFQ3TDlyMlFSRGVtUWtsU0pPdlk0c05ka21LelovRk1F?=
 =?utf-8?B?MThoVjl4ZDFEZUIrNy9FTE1EMG1qZWFXSlhLVXdpRVZhc1ZyMGlsTGdielZE?=
 =?utf-8?B?dzlPendINGx6WFhEdkttR3BMK25QQ2U4VDRpamNVR2JtdXNlRk5MZThYcUdz?=
 =?utf-8?B?eGc0NWN1NEdHUDU1bnJINGJEQ0ErUmE0dENGWE9oUWFVQ1BycjdtUG83bW1l?=
 =?utf-8?B?WkdPazJDRE1RN2EvSjRqdktTOTd2dFVHcWp0bitxUW85ZXVDVVlYUCtBOXlG?=
 =?utf-8?B?MU43MVVuWmdxYTFkbm5oT0VPQytkSGtpU1dhYXRJUStJcm9TU2t1SEE2ZHJs?=
 =?utf-8?B?NEpzMlh1QlIybXh3WTBxcEx5VXBVeW1sM0MxMDFSSDVKOUlBaSsyRERGWCtq?=
 =?utf-8?B?eUd3aURiQm9pM2JUUW90UiszNTYwejFWb1ZpMU80YU80VDVEVnlQTE82d0xW?=
 =?utf-8?B?QnBvSW44MHV5S2JtcnZzUWJWa1dFbzZ4TEZzQldzd1ZKTHN2VU91R3ZVMjZL?=
 =?utf-8?B?K0o3Y25FQ2NmRFVGZFVpQkFrYWlLMVRTNisrYStURklnTlE1c1MyVzZVbmxO?=
 =?utf-8?B?elVRNlVxMTRzQWhyamZkNU9qcG5qZ0lqN3dSd0xYKzZRWWVPS2JKYjU0SFpT?=
 =?utf-8?B?dGNsdWp4K0UxM3hVVHAzSzlVMUxkZ3NZM3pGbXI5N2hscXB5ZWJmZWlBcG9y?=
 =?utf-8?B?Ui9heVdGdDltVk9pUGF0Z29kU00ycUxJbEJZRXA2VzhxanNId2FjL3lDNHNS?=
 =?utf-8?B?NGV2VlM1Q2RFZUw0QjZ6dUsvM24vSk95VDV6S3NxYmkvcDhSV0tHdWEyc2Fs?=
 =?utf-8?B?THYzbXE2NW8zWHRwZGdkZW1lWGVKQ3ZaSkJVMWpKR3E4WkxjdzlLd1FLS3VX?=
 =?utf-8?B?UTR2U2d0TXh2K2pyblRURHhVT0s1N1JuRWl6R1dDcTZJWHc2RUY4S1Q4NlE1?=
 =?utf-8?B?NS9vWU15cEMzWi90K2xjbUl5enh1NjlsYUR5bFBOK1FaZFBMRjI4cFFqSkt3?=
 =?utf-8?B?NGEzc3lZRG9YZk1ETmMrVDFFK3BBdnBZOXZjNmQranBkOWN3TEt5WlNwM3E2?=
 =?utf-8?B?VzVKYVZDNUJUWllQZWk5V2lXQmZqV3RaNllMUG5BYkJUVnV3b3Jwb252b1lx?=
 =?utf-8?B?RWFwZGw5Y0M2VUZvekp4Vmp5RmdTWEdscUZwSVZDNEcxakZQTW90T2JBU2Fa?=
 =?utf-8?B?UGdjM1hGL3NSMWx4TklZcW4rNUV4SmZSVTNLODVIK3FObFpveFJRTkNyak1t?=
 =?utf-8?B?aDRUMzlHODRLRzZNUDlwQ2h0b0szSm8wWllTNnVoNEFzeHhkS3o1dzFUT094?=
 =?utf-8?B?SERzbmYzZjBZa25FQStRUXhycGc4K1FOcTU4RFZOVGZjN0lSNzVBeXlRdWhL?=
 =?utf-8?B?TTB1b3dyd1h5Q1lPeXY0ajlhTnIrN3ZLWmUwOHQveDVCbjJJVkJSUTA3YjBq?=
 =?utf-8?B?RkhudlFjSC84U1Q4VVR2Mmk4a25ScStXNGtBS1BxZ3JxNjhPRDRsZUVLcmpE?=
 =?utf-8?Q?RivYh4FzIpoZv8hIz+0CN4w=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 42c28a5a-c8a3-459e-f19b-08dde6cbaadb
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 07:14:18.4808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dYZcVg68Ol6WI502MUwIcEhLL22NNXpZFDqrAe+ShNRMGJvIedVEKoQqFq5FpMevImkezZMLy4MR4AtdoZS3qzt/JgKTz/v6TWNsRYakPP8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5578

is there any news?

Best regards,
Mikhail Kshevetskiy

On 23.08.2025 19:01, Mikhail Kshevetskiy wrote:
> This patch series greatly improve airoha snfi driver and fix a
> number of serious bugs.
>
> Fixed bugs:
>  * Fix reading/writing of flashes with more than one plane per lun
>  * Fill the buffer with 0xff before writing
>  * Fix reading of flashes supporting continuous reading mode
>  * Fix error paths
>
> Improvements:
>  * Add support of dual/quad wires spi modes in exec_op(). This also
>    fix flash reading/writing if dirmap can't be created.
>  * Support of dualio/quadio flash reading commands
>  * Remove dirty hack that reads flash page settings from SNFI registers
>    during driver startup
>
> Patched kernel tests:
>
>     root@OpenWrt:/lib/modules/6.6.79# insmod mtd_oobtest.ko dev=1
>     [  263.191711] 
>     [  263.193218] =================================================
>     [  263.199014] mtd_oobtest: MTD device: 1
>     [  263.202768] mtd_oobtest: MTD device size 268304384, eraseblock size 131072, page size 2048, count of eraseblocks 2047, pages per eraseblock 64, OOB size 128
>     [  263.216791] mtd_test: scanning for bad eraseblocks
>     [  263.221956] mtd_test: scanned 2047 eraseblocks, 0 are bad
>     [  263.227361] mtd_oobtest: test 1 of 5
>     [  265.077216] mtd_oobtest: writing OOBs of whole device
>     [  265.121767] mtd_oobtest: written up to eraseblock 0
>     [  275.174147] mtd_oobtest: written up to eraseblock 256
>     [  285.210279] mtd_oobtest: written up to eraseblock 512
>     [  295.241724] mtd_oobtest: written up to eraseblock 768
>     [  305.280167] mtd_oobtest: written up to eraseblock 1024
>     [  315.326883] mtd_oobtest: written up to eraseblock 1280
>     [  325.364049] mtd_oobtest: written up to eraseblock 1536
>     [  335.398609] mtd_oobtest: written up to eraseblock 1792
>     [  345.358981] mtd_oobtest: written 2047 eraseblocks
>     [  345.363694] mtd_oobtest: verifying all eraseblocks
>     [  345.386088] mtd_oobtest: verified up to eraseblock 0
>     [  349.830833] mtd_oobtest: verified up to eraseblock 256
>     [  354.276245] mtd_oobtest: verified up to eraseblock 512
>     [  358.721496] mtd_oobtest: verified up to eraseblock 768
>     [  363.166881] mtd_oobtest: verified up to eraseblock 1024
>     [  367.612694] mtd_oobtest: verified up to eraseblock 1280
>     [  372.058211] mtd_oobtest: verified up to eraseblock 1536
>     [  376.503820] mtd_oobtest: verified up to eraseblock 1792
>     [  380.914843] mtd_oobtest: verified 2047 eraseblocks
>     [  380.919660] mtd_oobtest: test 2 of 5
>     [  384.202620] mtd_oobtest: writing OOBs of whole device
>     [  384.247584] mtd_oobtest: written up to eraseblock 0
>     [  394.305121] mtd_oobtest: written up to eraseblock 256
>     [  404.342199] mtd_oobtest: written up to eraseblock 512
>     [  414.374204] mtd_oobtest: written up to eraseblock 768
>     [  424.409891] mtd_oobtest: written up to eraseblock 1024
>     [  434.453378] mtd_oobtest: written up to eraseblock 1280
>     [  444.494321] mtd_oobtest: written up to eraseblock 1536
>     [  454.534480] mtd_oobtest: written up to eraseblock 1792
>     [  464.490962] mtd_oobtest: written 2047 eraseblocks
>     [  464.495681] mtd_oobtest: verifying all eraseblocks
>     [  464.518015] mtd_oobtest: verified up to eraseblock 0
>     [  468.955635] mtd_oobtest: verified up to eraseblock 256
>     [  473.395502] mtd_oobtest: verified up to eraseblock 512
>     [  477.834373] mtd_oobtest: verified up to eraseblock 768
>     [  482.272717] mtd_oobtest: verified up to eraseblock 1024
>     [  486.712148] mtd_oobtest: verified up to eraseblock 1280
>     [  491.150704] mtd_oobtest: verified up to eraseblock 1536
>     [  495.589439] mtd_oobtest: verified up to eraseblock 1792
>     [  499.993138] mtd_oobtest: verified 2047 eraseblocks
>     [  499.997951] mtd_oobtest: test 3 of 5
>     [  503.404228] mtd_oobtest: writing OOBs of whole device
>     [  503.448822] mtd_oobtest: written up to eraseblock 0
>     [  513.480773] mtd_oobtest: written up to eraseblock 256
>     [  523.489361] mtd_oobtest: written up to eraseblock 512
>     [  533.506896] mtd_oobtest: written up to eraseblock 768
>     [  543.506268] mtd_oobtest: written up to eraseblock 1024
>     [  553.506503] mtd_oobtest: written up to eraseblock 1280
>     [  563.511266] mtd_oobtest: written up to eraseblock 1536
>     [  573.519567] mtd_oobtest: written up to eraseblock 1792
>     [  583.455111] mtd_oobtest: written 2047 eraseblocks
>     [  583.459837] mtd_oobtest: verifying all eraseblocks
>     [  583.499358] mtd_oobtest: verified up to eraseblock 0
>     [  592.382953] mtd_oobtest: verified up to eraseblock 256
>     [  601.267297] mtd_oobtest: verified up to eraseblock 512
>     [  610.150907] mtd_oobtest: verified up to eraseblock 768
>     [  619.034702] mtd_oobtest: verified up to eraseblock 1024
>     [  627.919683] mtd_oobtest: verified up to eraseblock 1280
>     [  636.821168] mtd_oobtest: verified up to eraseblock 1536
>     [  645.705487] mtd_oobtest: verified up to eraseblock 1792
>     [  654.520336] mtd_oobtest: verified 2047 eraseblocks
>     [  654.525134] mtd_oobtest: test 4 of 5
>     [  657.578146] mtd_oobtest: attempting to start write past end of OOB
>     [  657.584336] mtd_oobtest: an error is expected...
>     [  657.588974] mtd_oobtest: error occurred as expected
>     [  657.593848] mtd_oobtest: attempting to start read past end of OOB
>     [  657.599953] mtd_oobtest: an error is expected...
>     [  657.604569] mtd_oobtest: error occurred as expected
>     [  657.609450] mtd_oobtest: attempting to write past end of device
>     [  657.615367] mtd_oobtest: an error is expected...
>     [  657.619990] mtd_oobtest: error occurred as expected
>     [  657.624864] mtd_oobtest: attempting to read past end of device
>     [  657.630715] mtd_oobtest: an error is expected...
>     [  657.635333] mtd_oobtest: error occurred as expected
>     [  657.641043] mtd_oobtest: attempting to write past end of device
>     [  657.646966] mtd_oobtest: an error is expected...
>     [  657.651574] mtd_oobtest: error occurred as expected
>     [  657.656451] mtd_oobtest: attempting to read past end of device
>     [  657.662277] mtd_oobtest: an error is expected...
>     [  657.666901] mtd_oobtest: error occurred as expected
>     [  657.671774] mtd_oobtest: test 5 of 5
>     [  659.382333] mtd_oobtest: writing OOBs of whole device
>     [  659.388056] mtd_oobtest: written up to eraseblock 0
>     [  659.393526] mtd_oobtest: written up to eraseblock 0
>     [  659.704525] mtd_oobtest: written up to eraseblock 256
>     [  659.710187] mtd_oobtest: written up to eraseblock 256
>     [  660.021093] mtd_oobtest: written up to eraseblock 512
>     [  660.026752] mtd_oobtest: written up to eraseblock 512
>     [  660.338427] mtd_oobtest: written up to eraseblock 768
>     [  660.344048] mtd_oobtest: written up to eraseblock 768
>     [  660.655718] mtd_oobtest: written up to eraseblock 1024
>     [  660.661462] mtd_oobtest: written up to eraseblock 1024
>     [  660.970676] mtd_oobtest: written up to eraseblock 1280
>     [  660.976386] mtd_oobtest: written up to eraseblock 1280
>     [  661.286858] mtd_oobtest: written up to eraseblock 1536
>     [  661.292587] mtd_oobtest: written up to eraseblock 1536
>     [  661.605397] mtd_oobtest: written up to eraseblock 1792
>     [  661.611142] mtd_oobtest: written up to eraseblock 1792
>     [  661.918754] mtd_oobtest: written 2046 eraseblocks
>     [  661.923458] mtd_oobtest: verifying all eraseblocks
>     [  661.928812] mtd_oobtest: verified up to eraseblock 0
>     [  662.072499] mtd_oobtest: verified up to eraseblock 256
>     [  662.216152] mtd_oobtest: verified up to eraseblock 512
>     [  662.359956] mtd_oobtest: verified up to eraseblock 768
>     [  662.503238] mtd_oobtest: verified up to eraseblock 1024
>     [  662.646847] mtd_oobtest: verified up to eraseblock 1280
>     [  662.790603] mtd_oobtest: verified up to eraseblock 1536
>     [  662.934269] mtd_oobtest: verified up to eraseblock 1792
>     [  663.076329] mtd_oobtest: verified 2046 eraseblocks
>     [  663.081114] mtd_oobtest: finished with 0 errors
>     [  663.085647] =================================================
>
>     root@OpenWrt:/lib/modules/6.6.79# insmod  mtd_pagetest.ko dev=1
>     [ 1142.213082] 
>     [ 1142.214590] =================================================
>     [ 1142.220433] mtd_pagetest: MTD device: 1
>     [ 1142.224278] mtd_pagetest: MTD device size 268304384, eraseblock size 131072, page size 2048, count of eraseblocks 2047, pages per eraseblock 64, OOB size 128
>     [ 1142.238388] mtd_test: scanning for bad eraseblocks
>     [ 1142.243536] mtd_test: scanned 2047 eraseblocks, 0 are bad
>     [ 1142.248935] mtd_pagetest: erasing whole device
>     [ 1143.962562] mtd_pagetest: erased 2047 eraseblocks
>     [ 1143.967301] mtd_pagetest: writing whole device
>     [ 1144.011729] mtd_pagetest: written up to eraseblock 0
>     [ 1154.137933] mtd_pagetest: written up to eraseblock 256
>     [ 1164.265201] mtd_pagetest: written up to eraseblock 512
>     [ 1174.393365] mtd_pagetest: written up to eraseblock 768
>     [ 1184.525700] mtd_pagetest: written up to eraseblock 1024
>     [ 1194.650920] mtd_pagetest: written up to eraseblock 1280
>     [ 1204.773676] mtd_pagetest: written up to eraseblock 1536
>     [ 1214.896934] mtd_pagetest: written up to eraseblock 1792
>     [ 1224.942600] mtd_pagetest: written 2047 eraseblocks
>     [ 1224.947410] mtd_pagetest: verifying all eraseblocks
>     [ 1225.053133] mtd_pagetest: verified up to eraseblock 0
>     [ 1250.760034] mtd_pagetest: verified up to eraseblock 256
>     [ 1276.448242] mtd_pagetest: verified up to eraseblock 512
>     [ 1302.138825] mtd_pagetest: verified up to eraseblock 768
>     [ 1327.824020] mtd_pagetest: verified up to eraseblock 1024
>     [ 1353.532178] mtd_pagetest: verified up to eraseblock 1280
>     [ 1379.234385] mtd_pagetest: verified up to eraseblock 1536
>     [ 1404.943865] mtd_pagetest: verified up to eraseblock 1792
>     [ 1430.468816] mtd_pagetest: verified 2047 eraseblocks
>     [ 1430.473702] mtd_pagetest: crosstest
>     [ 1430.477717] mtd_pagetest: reading page at 0x0
>     [ 1430.482328] mtd_pagetest: reading page at 0xffdf800
>     [ 1430.487469] mtd_pagetest: reading page at 0x0
>     [ 1430.492084] mtd_pagetest: verifying pages read at 0x0 match
>     [ 1430.497668] mtd_pagetest: crosstest ok
>     [ 1430.501409] mtd_pagetest: erasecrosstest
>     [ 1430.505323] mtd_pagetest: erasing block 0
>     [ 1430.511511] mtd_pagetest: writing 1st page of block 0
>     [ 1430.517166] mtd_pagetest: reading 1st page of block 0
>     [ 1430.522505] mtd_pagetest: verifying 1st page of block 0
>     [ 1430.527739] mtd_pagetest: erasing block 0
>     [ 1430.532565] mtd_pagetest: writing 1st page of block 0
>     [ 1430.538229] mtd_pagetest: erasing block 2046
>     [ 1430.544181] mtd_pagetest: reading 1st page of block 0
>     [ 1430.549498] mtd_pagetest: verifying 1st page of block 0
>     [ 1430.554718] mtd_pagetest: erasecrosstest ok
>     [ 1430.558900] mtd_pagetest: erasetest
>     [ 1430.562381] mtd_pagetest: erasing block 0
>     [ 1430.567208] mtd_pagetest: writing 1st page of block 0
>     [ 1430.572858] mtd_pagetest: erasing block 0
>     [ 1430.577680] mtd_pagetest: reading 1st page of block 0
>     [ 1430.582990] mtd_pagetest: verifying 1st page of block 0 is all 0xff
>     [ 1430.589279] mtd_pagetest: erasetest ok
>     [ 1430.593023] mtd_pagetest: finished with 0 errors
>     [ 1430.597651] =================================================
>
>     root@OpenWrt:/lib/modules/6.6.79# insmod  mtd_readtest.ko dev=1
>     [ 1478.691648] 
>     [ 1478.693158] =================================================
>     [ 1478.698981] mtd_readtest: MTD device: 1
>     [ 1478.702829] mtd_readtest: MTD device size 268304384, eraseblock size 131072, page size 2048, count of eraseblocks 2047, pages per eraseblock 64, OOB size 128
>     [ 1478.716939] mtd_test: scanning for bad eraseblocks
>     [ 1478.722072] mtd_test: scanned 2047 eraseblocks, 0 are bad
>     [ 1478.727475] mtd_readtest: testing page read
>     [ 1548.352125] mtd_readtest: finished
>     [ 1548.355553] =================================================
>
>     root@OpenWrt:/lib/modules/6.6.79# insmod  mtd_speedtest.ko dev=1
>     [ 1617.353002] 
>     [ 1617.354511] =================================================
>     [ 1617.360332] mtd_speedtest: MTD device: 1
>     [ 1617.364258] mtd_speedtest: MTD device size 268304384, eraseblock size 131072, page size 2048, count of eraseblocks 2047, pages per eraseblock 64, OOB size 128
>     [ 1617.380150] mtd_test: scanning for bad eraseblocks
>     [ 1617.385428] mtd_test: scanned 2047 eraseblocks, 0 are bad
>     [ 1621.021861] mtd_speedtest: testing eraseblock write speed
>     [ 1700.915306] mtd_speedtest: eraseblock write speed is 3279 KiB/s
>     [ 1700.921250] mtd_speedtest: testing eraseblock read speed
>     [ 1734.931886] mtd_speedtest: eraseblock read speed is 7705 KiB/s
>     [ 1738.682742] mtd_speedtest: testing page write speed
>     [ 1818.818644] mtd_speedtest: page write speed is 3269 KiB/s
>     [ 1818.824058] mtd_speedtest: testing page read speed
>     [ 1852.913595] mtd_speedtest: page read speed is 7687 KiB/s
>     [ 1856.674492] mtd_speedtest: testing 2 page write speed
>     [ 1936.437284] mtd_speedtest: 2 page write speed is 3285 KiB/s
>     [ 1936.442869] mtd_speedtest: testing 2 page read speed
>     [ 1970.498124] mtd_speedtest: 2 page read speed is 7694 KiB/s
>     [ 1970.503624] mtd_speedtest: Testing erase speed
>     [ 1974.343389] mtd_speedtest: erase speed is 68316 KiB/s
>     [ 1974.348479] mtd_speedtest: Testing 2x multi-block erase speed
>     [ 1976.068855] mtd_speedtest: 2x multi-block erase speed is 152811 KiB/s
>     [ 1976.075309] mtd_speedtest: Testing 4x multi-block erase speed
>     [ 1977.790232] mtd_speedtest: 4x multi-block erase speed is 153301 KiB/s
>     [ 1977.796693] mtd_speedtest: Testing 8x multi-block erase speed
>     [ 1979.511905] mtd_speedtest: 8x multi-block erase speed is 153273 KiB/s
>     [ 1979.518367] mtd_speedtest: Testing 16x multi-block erase speed
>     [ 1981.230700] mtd_speedtest: 16x multi-block erase speed is 153539 KiB/s
>     [ 1981.237249] mtd_speedtest: Testing 32x multi-block erase speed
>     [ 1982.948381] mtd_speedtest: 32x multi-block erase speed is 153648 KiB/s
>     [ 1982.954918] mtd_speedtest: Testing 64x multi-block erase speed
>     [ 1984.665992] mtd_speedtest: 64x multi-block erase speed is 153655 KiB/s
>     [ 1984.672531] mtd_speedtest: finished
>     [ 1984.676054] =================================================
>
>     root@OpenWrt:/lib/modules/6.6.79# insmod mtd_stresstest.ko dev=1
>     [ 2190.651750] 
>     [ 2190.653263] =================================================
>     [ 2190.659087] mtd_stresstest: MTD device: 1
>     [ 2190.663105] mtd_stresstest: MTD device size 268304384, eraseblock size 131072, page size 2048, count of eraseblocks 2047, pages per eraseblock 64, OOB size 128
>     [ 2190.679846] mtd_test: scanning for bad eraseblocks
>     [ 2190.684981] mtd_test: scanned 2047 eraseblocks, 0 are bad
>     [ 2190.690389] mtd_stresstest: doing operations
>     [ 2190.694655] mtd_stresstest: 0 operations done
>     [ 2214.262705] mtd_stresstest: 1024 operations done
>     [ 2239.019612] mtd_stresstest: 2048 operations done
>     [ 2262.820899] mtd_stresstest: 3072 operations done
>     [ 2285.061376] mtd_stresstest: 4096 operations done
>     [ 2308.297322] mtd_stresstest: 5120 operations done
>     [ 2330.530459] mtd_stresstest: 6144 operations done
>     [ 2352.651759] mtd_stresstest: 7168 operations done
>     [ 2375.188275] mtd_stresstest: 8192 operations done
>     [ 2397.738174] mtd_stresstest: 9216 operations done
>     [ 2414.792572] mtd_stresstest: finished, 10000 operations done
>     [ 2414.798257] =================================================
>
> Speed test of original driver (with patch to fix support of flashes
> with more than one plane per lun)
>
>     root@OpenWrt:/lib/modules/6.6.79# insmod  mtd_speedtest.ko dev=1
>     [ 2894.142208] 
>     [ 2894.143719] =================================================
>     [ 2894.149556] mtd_speedtest: MTD device: 1
>     [ 2894.153486] mtd_speedtest: MTD device size 268304384, eraseblock size 131072, page size 2048, count of eraseblocks 2047, pages per eraseblock 64, OOB size 128
>     [ 2894.168888] mtd_test: scanning for bad eraseblocks
>     [ 2894.174023] mtd_test: scanned 2047 eraseblocks, 0 are bad
>     [ 2897.500416] mtd_speedtest: testing eraseblock write speed
>     [ 2977.807233] mtd_speedtest: eraseblock write speed is 3262 KiB/s
>     [ 2977.813171] mtd_speedtest: testing eraseblock read speed
>     [ 3013.906597] mtd_speedtest: eraseblock read speed is 7260 KiB/s
>     [ 3017.440320] mtd_speedtest: testing page write speed
>     [ 3097.833394] mtd_speedtest: page write speed is 3259 KiB/s
>     [ 3097.838812] mtd_speedtest: testing page read speed
>     [ 3134.004981] mtd_speedtest: page read speed is 7245 KiB/s
>     [ 3137.538423] mtd_speedtest: testing 2 page write speed
>     [ 3217.906288] mtd_speedtest: 2 page write speed is 3260 KiB/s
>     [ 3217.911883] mtd_speedtest: testing 2 page read speed
>     [ 3254.049757] mtd_speedtest: 2 page read speed is 7251 KiB/s
>     [ 3254.055254] mtd_speedtest: Testing erase speed
>     [ 3257.599146] mtd_speedtest: erase speed is 74027 KiB/s
>     [ 3257.604213] mtd_speedtest: Testing 2x multi-block erase speed
>     [ 3259.320945] mtd_speedtest: 2x multi-block erase speed is 153139 KiB/s
>     [ 3259.327413] mtd_speedtest: Testing 4x multi-block erase speed
>     [ 3261.044585] mtd_speedtest: 4x multi-block erase speed is 153098 KiB/s
>     [ 3261.051047] mtd_speedtest: Testing 8x multi-block erase speed
>     [ 3262.786520] mtd_speedtest: 8x multi-block erase speed is 151479 KiB/s
>     [ 3262.792979] mtd_speedtest: Testing 16x multi-block erase speed
>     [ 3264.509898] mtd_speedtest: 16x multi-block erase speed is 153130 KiB/s
>     [ 3264.516454] mtd_speedtest: Testing 32x multi-block erase speed
>     [ 3266.233403] mtd_speedtest: 32x multi-block erase speed is 153125 KiB/s
>     [ 3266.239961] mtd_speedtest: Testing 64x multi-block erase speed
>     [ 3267.957985] mtd_speedtest: 64x multi-block erase speed is 153029 KiB/s
>     [ 3267.964525] mtd_speedtest: finished
>     [ 3267.968039] =================================================
>
> It looks like a patched driver is a bit faster
>
> write speed: 3260 KiB/s  vs  3277 KiB/s
> read speed:  7252 KiB/s  vs  7695 KiB/s
>
> Changes v2:
>  * minor fix
>  * add comments to code
>
> Changes v3:
>  * add patch to prevent continuous reading
>
> Changes v4:
>  * removed non-needed patch, other patch was a bit updated
>  * treat zero buswidth as single wire buswidth (thanks to Jyothi Kumar Seerapu)
>  * changes were tested with linux
>  * test results was added
>
> Changes v5:
>  * reorder patches a bit
>  * improve description of some patches
>  * minor fixes & improvements
>
> Mikhail Kshevetskiy (13):
>   spi: airoha: return an error for continuous mode dirmap creation cases
>   spi: airoha: remove unnecessary restriction length
>   spi: airoha: add support of dual/quad wires spi modes to exec_op()
>     handler
>   spi: airoha: remove unnecessary switch to non-dma mode
>   spi: airoha: switch back to non-dma mode in the case of error
>   spi: airoha: fix reading/writing of flashes with more than one plane
>     per lun
>   spi: airoha: unify dirmap read/write code
>   spi: airoha: support of dualio/quadio flash reading commands
>   spi: airoha: avoid setting of page/oob sizes in REG_SPI_NFI_PAGEFMT
>   spi: airoha: reduce the number of modification of REG_SPI_NFI_CNFG and
>     REG_SPI_NFI_SECCUS_SIZE registers
>   spi: airoha: set custom sector size equal to flash page size
>   spi: airoha: avoid reading flash page settings from SNFI registers
>     during driver startup
>   spi: airoha: buffer must be 0xff-ed before writing
>
>  drivers/spi/spi-airoha-snfi.c | 510 ++++++++++++++++++----------------
>  1 file changed, 263 insertions(+), 247 deletions(-)
>

