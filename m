Return-Path: <linux-spi+bounces-10489-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F13B7BC8208
	for <lists+linux-spi@lfdr.de>; Thu, 09 Oct 2025 10:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D64791897BA7
	for <lists+linux-spi@lfdr.de>; Thu,  9 Oct 2025 08:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046982D3221;
	Thu,  9 Oct 2025 08:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="UeDk6Y6c"
X-Original-To: linux-spi@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023140.outbound.protection.outlook.com [40.107.162.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33222D24B4;
	Thu,  9 Oct 2025 08:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759999904; cv=fail; b=ek1wH4SHQayvyQRf3LkmBTu8L/c7ZX1ZOMeCFHFw1lgsw+/CBu8LuB7PkSPM28a4tTHIFw+VNZPiRXUt/3nbe9M8EFTyIq3xxbMejfRgn4CZgUilh9GanPONNkeXVvd/qskBUCObPylbibK0I3ZNpztp7xQqMjEYLlYvhGEqn80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759999904; c=relaxed/simple;
	bh=/ZCakZ64AErXswneiygzdVfbFt3gP+jU5le+UAWQMgY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FBYhpLCIPNIformhA7JrxZknEt7AZG78/Kncf8cLJj+Y+f+GRWnQTatOKev06N8zpRjMu0RJVUQC0vi3Hx6KAr0bVRMrk3YzZy7fGH1kk4elZTX86xDnKv47a1oISZQ6VHatnC7hx5Ko+1flL/LcSYvPypm6O3C77qnKQCupVvc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=UeDk6Y6c; arc=fail smtp.client-ip=40.107.162.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TgKBeHIMnMVJfhh6HiBKykfOSeXOi5slTLgbwTZZmWZEZmTYhWjwdmhypZ4oxdmYMI+TjOOdBVYg0P+1wxBYCaZAHbSfwHA3TAfZoHaiRc9QJU+++P31y3qxKfaDKPGkKqtkzKPU8QLbB7oa7n7kTofIdUCuNsDisX7Hv2Pmb45s48WevZYTgnpaMHl63MIwB9+cij0bo8s5TKJyzHgO/3M78rkYt9RbsFDdPibRa9QVhxEV2BjPBj+h8tDcal8Wexjf3gLmSsTjmJ+KlrMotamuMv74/HkHBwMjBHeccIcabe7Db1MznvWrYKKJ7gsF4E8Dt9SgWTVKYIvc2v+lfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ZCakZ64AErXswneiygzdVfbFt3gP+jU5le+UAWQMgY=;
 b=ddn0W/lnfEbz9rASk5H62sfizYvVWSdpE6Oujb06G9FWAvVyAX5q6vegUVK8Ty+rwSdcJvPHnNIXY70b7a4/INyCXPcshBrXD2QR+qfZAiv5pzIVXU3bXPx+jRWr7/kpxFRvhl503GC13OhmkvPSKjXuioRd+WpitJK8wP3yxGRJCocESAfnYOc5laET6plZRB/VufeTk8QH+nBn1tQ9A/JjiUxhY9XLEk/qjh/c0zhFhxInxTANgQJDSQ6gnZrvsuw2jOSbRRKlfOFJHBRvstEq5dUlmN+2us+0Y39BmcSzemQmstb3Op+ojB9bsRa3iETUDQdkNeaO0iMh1C4mnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ZCakZ64AErXswneiygzdVfbFt3gP+jU5le+UAWQMgY=;
 b=UeDk6Y6c4l//XUie83VTEDyV3WKSlTw+Xt2lU+ucxZj838lv5NodS577UrsRlFA0UdTOgM39DBfdOceiOkvUqxEHKE7f8zMZ6s93UZreoUaiXr2Urwnm7q9ueVXlsu4abr4lfCAvLyLzA6NdgXo77lWkkMlWKPKs5ov4dzKnGg7LE3/Bi4KxWsM5xYCFqcQb2E4qZS1Io7k2U0Jj+P0sDM19vzxgaoGNJ+uKhjvBjnhCiiHMqMBvTHfw2S0AbGwzBxSBvoB4VYRfFqZo9y2gJ0XZvPvAnyMn5XmFEP+EaQaP4MnVtB2BRwTVtwvezDFGhN2mSsEMS0Bifwa15y90vQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB9PR08MB8434.eurprd08.prod.outlook.com (2603:10a6:10:3d6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Thu, 9 Oct
 2025 08:51:37 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Thu, 9 Oct 2025
 08:51:37 +0000
Message-ID: <cca2729e-dec7-402a-9102-4038f73f68fa@iopsys.eu>
Date: Thu, 9 Oct 2025 11:51:34 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 13/13] spi: airoha: buffer must be 0xff-ed before
 writing
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Ray Liu <ray.liu@airoha.com>,
 Mark Brown <broonie@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Andreas Gnau <andreas.gnau@iopsys.eu>
References: <20251001222347.3386506-1-mikhail.kshevetskiy@iopsys.eu>
 <20251001222347.3386506-14-mikhail.kshevetskiy@iopsys.eu>
 <bcfb637a-79bb-42d8-a2b9-508a2fab6025@collabora.com>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <bcfb637a-79bb-42d8-a2b9-508a2fab6025@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0236.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::10) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB9PR08MB8434:EE_
X-MS-Office365-Filtering-Correlation-Id: f2632b2f-d6aa-4768-52c2-08de07110e12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T2RjcGs3Y1NvRU1YWjczd1ZNbW5pK21ZNnpIdlJZdGlnRW5ZbEtWZUlMM3NC?=
 =?utf-8?B?NkN4RHYyUlQwc0pQWkFLbGVZZnhIRTduNkpuWW13L3lYUXdFVjgzSFpYZ0F4?=
 =?utf-8?B?ZWtOMkc0VzVsb1RxajltUGpiQVdoSW9aQnAyb3FOVGR3NXNnOGR6VStVRXgv?=
 =?utf-8?B?S0dVOVNQV1FvejNRK1R6WUoxVUh6bzVPZ2VtVFpmYWxrVHR0SGl4WTBWS3Q2?=
 =?utf-8?B?VUVlY0dqSmRDdnRaS04xMDlTZTQxLzJVZ1pzUFZMY3RQNmE5TEhrSk9xMW5h?=
 =?utf-8?B?c0toOTFqd216ZGJxeVVvc2xDbXg3bmIrOXg1MVBRNVNlUjRoMWhLTmErRDQv?=
 =?utf-8?B?RE1ZYWRDbmxXcjhLcTNZaHJzUThQYmxsblFWS3AvWEFzb3VVVk1CeVFtd0ZU?=
 =?utf-8?B?QTNaQ1lkNnpiN0VYOVVWbFVRWkVTeGRoMzFvUlFtbExDb0JEU1UzSWg3UFMv?=
 =?utf-8?B?Uys4MXBhRGowNFViMTgxcEhlcTc3QUR5UHAwb083YzdvMjQ2OFkzY29yVDBN?=
 =?utf-8?B?bGFGaTBiODBMcjV0Y2lraTJLL01KMDVTTjE0bzQ3eEdicHgzSk5DenY4aGFG?=
 =?utf-8?B?bXp2MTQ3OFhTb0d0aEtaTHFaUXlWUFBydkZSTlcvUHZlNDdmMkN5L3hsalY1?=
 =?utf-8?B?NlFHY2ZkZVV6YTcyLzZ6MEZJNmdLRkVIcys0N3Rxc3ZNYmx6SlRKczcyRG9G?=
 =?utf-8?B?NTBJTWtSSWp5T0NEeGtVSzFoYUxCWUlSOVdDN25Pa2hxenhySHN2STcvRTdk?=
 =?utf-8?B?V0hwV2s3S3h6bk9Md1FXaTFsc1hSemVUM09PcnZLc1Z1WisvOGVkc3dTQ29i?=
 =?utf-8?B?b0Z0aWNxdWFPSUpza0FJVXNQcDB4c2huS3kycjcvajdSZmJDVGNPR3BZWkc3?=
 =?utf-8?B?blpJUVc2elFWZFJMMm9OTm13QkY3dlArOEY1MXNNRzdBbEM3SE90aXlBdXRX?=
 =?utf-8?B?eDhnYTFHYXpUS3hqcHdybjBmb0dTWmQzSjhZQ0Yzek5lZHFxOERIRjgzMUMw?=
 =?utf-8?B?UmZmVlZVbldaYlMySmNNOTlqQm5JU1M0OFBvZnhBNjV0ZVU2a092Z2JYL21m?=
 =?utf-8?B?eVNoMkgwWmY5c1pnazNoWHhjQ0dJVHJxU3dBUjRkSHUyOXpKS0F1K1huTlNt?=
 =?utf-8?B?aGg0bEFkYVpiSEdGTHJXd3NpekpuV2VMaEdkSVZUVTdOS2hHTmFFUnB6SVpx?=
 =?utf-8?B?ek9lL0J3Qjg1U2JRK0RWZ3VaZzEwUVRRVGxNYnpra2JNaHkrTHFQRytpSW9s?=
 =?utf-8?B?REtCNnBkWUROdlR6Z1U3enJmMzQzTUFrdGZ0OFM3ckxDOHgwanJYVkZCQ3l4?=
 =?utf-8?B?OW03NTRjUXE5VXpOYzJWbWRRbHdibFZvQU9QN0xOOC9wbjdMWXlORU9Td0Qv?=
 =?utf-8?B?VWc3SURKOXdSVVN0ZmwzTnVXOFkvbEF2VU45dlBjZDVHdzV6S1VRMjViSGRH?=
 =?utf-8?B?Q2N2REhKMWRMb1F0L0ZTbFNlanh2NEttTkoyWTlFOTZQMDVyL2dteG0yTjhJ?=
 =?utf-8?B?YWQ1T3IwSXhzZ1ZxVTQxZjM3MHdjTUhwamg3QXV1MFpRKzdqUFd2VU1rMFNm?=
 =?utf-8?B?WXhicFVEdmNFaVpXWFBldU5PSVVYdmdwVXJFcUVYd0tkL0YxbHBBVVloQ0Zu?=
 =?utf-8?B?RGZhbjM3V2tRQlhDWStiZ0JBaGNaSS94L3ZiaGtidFlobUxQRFF4N0kwSTB4?=
 =?utf-8?B?dEtHMEtiMEd2V0ZLSjk0YVFLVk8wVlFWNkp4YzJscTBWSUppSzNXajliU2g2?=
 =?utf-8?B?S2hwZEV1amx2MlQ1SnRoQXE4QTJIYlV3ZlhlSWY4NkFOaHoreTNEVDIyTzhM?=
 =?utf-8?B?NFYxdDdheHRtdllXbFM3NW9JdjlLbEFBR0w0QkwwZzQyVVhsbWJNV0VqTitw?=
 =?utf-8?B?L0NKUWxLVFpHYnBnV0RCM3BpaHZRWEJ5VUZLRVhkNEtKcTd3Um5ydFFDejZG?=
 =?utf-8?Q?bBNz+FtQkIBKE2HeuoMFZtgg9xRBICjB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QSsrY0pTU3hUR2p5NkZoMmN2Ukk1ZXRIZUZtcVdHaktlWi9oUDlIMmFTR2pB?=
 =?utf-8?B?b0dLWDYxTlZVamFqOGpDSHhLaFEza3RvNGRwakF5NFNOakZGUEJxSFpZSW5k?=
 =?utf-8?B?UFRTOW02VGpxaXpSSnFNbHRBdGwva1dweE1mNGxlaGRaNzBxM1pyVVR0d2I2?=
 =?utf-8?B?eWFaUk5jbk8xWk9MYlNBbmdwZmJYbDJBbExhWHhNVG5RZTZIMFlJa2Y0Tm4x?=
 =?utf-8?B?VGFRVHE2MHBHUGY4SDA4SjBFQnNWdkZibXZ4eC9FTWlBWEpOQ2VocnVCMXpN?=
 =?utf-8?B?Vjg3NE1WOTVOdUZadFpmcm9uYk9uaHB1eXpISmJwTm5hVXN4cTgrOFVZbFpz?=
 =?utf-8?B?TzZCR0FvaXQ4d285bE83Ykphc1NadVdDWHhpWHhyYWczSVdFSmI2NW8rQUpN?=
 =?utf-8?B?bS9KRlM2WUExeUo2azFDM0JrcFovM1pqNlViYnI4aVE1akw4Y1ZIbmt3Tit2?=
 =?utf-8?B?SzdpRnRqaE9TZTJEc0czTEZSb2x6aUNheGdadTJtZzZyV3JKaEloaHA0ZDA2?=
 =?utf-8?B?aE5LYXlNS2VIMXNqem8vR25xTmw0Ly91YWRRODNmRDdGVy9wZGg2UTk3SFdE?=
 =?utf-8?B?RFhEb3psSVA1MjZ2anpwSFN6WTc2R1Exa2RoN04vaWp3TXpTYzE1TWUvVkRi?=
 =?utf-8?B?YWg2Kzd6UXRVQXhjTHRMZVdjU254STNYQ3Y4aGFNaWZzb0FXVGNoNFhCVmxI?=
 =?utf-8?B?Ri9MTWdnekl4bmQ3REhLWFJhRGltQXNSalphZER5KytTOEp3UHBvNEtWcmo4?=
 =?utf-8?B?T2tnWjJkbkZiVThxcldyeFUxV0RCMGJiS2hwMm5lRWZUcTUzS0tteFBsWUdq?=
 =?utf-8?B?RXpONEh0ZHBSMWJlbGNWdExpVm5vejZDRllXWjRRQytrcGg1dTFiNWxqMUsy?=
 =?utf-8?B?dlJjQ3VBcXNTNEltb09oV2J4UWg0eG4ycGg4Q2ZQRERQOVZvL21sR291QkJO?=
 =?utf-8?B?VGNuVko5NFJNbmtUbDdXNU96MmlkSGcrVjlRU1M4L0t0VmVqRXdwV0hqTW9M?=
 =?utf-8?B?bXF5S25RdTBHNnpJQnZUOFV3YTJTb1BqbzN4T0x5RnU3d3hJRmlYSmRtb2sx?=
 =?utf-8?B?SFFsWFBjSFYwUlNNQXFMNkNyS3Y0RDlLWUhtaW9WSWJQa2RqdkJhWTQ2WU1M?=
 =?utf-8?B?empKNElTQ29oc2Fycm1YempycXR5WCt5aWhOV09WaUlDdUVGQkdaZlhMY0M3?=
 =?utf-8?B?VVl3ZWhOaGZ0Z3dVejFJN0Z5bU9UNEpTL3kzL3dyUXFHVjI1MzFHaW1FRTc1?=
 =?utf-8?B?U0NuRVhvd2s4L3pJTVdNWEs3Umx5S0h1TFNRYStUU1VoWkNMcWt6b1k4L09R?=
 =?utf-8?B?VGVTLzc3L2lZZG1EMS8zUjFzN0dJL0tlait1OGkrZkZibzlxUnBmMmFHVlAw?=
 =?utf-8?B?aWxUaFlySlVSV2p0aEkrOUVXMVJhZzVpWWpaOFh2TmExMDVmRkZqb0xJQmpp?=
 =?utf-8?B?c0tMa2FOQWU3bmlpR3R1VzFDSWt4b0p6QUVMS2dKZDZMVEZKUXdETXZQMkRJ?=
 =?utf-8?B?R0piN0Q1VjFjbGpjL1pMWkJGUDJHR2xNUTJGbVRmNEQ4WFpxMExVU0tVb3BM?=
 =?utf-8?B?T2hJUm00T2hWU3JSVWFiL2VKWDhNb0s2cDNLR0c4M2FqcS9nYlJYMU1UQ28w?=
 =?utf-8?B?R0U3Y01sUlVISFdyTDdBWnBic2NYdzEzWloxK1JJOElRNG9mRW1ZT3RQSnZ0?=
 =?utf-8?B?NEt2R3BMdzY2d0JwZnl0UnM5cWhFdGdxMFRrSG1Ed1lEUTg0YkFXeU95UDgv?=
 =?utf-8?B?ck5JbFEyK2FKWjhVUXRyOFRpT3BkTHRQUUwzNWxCVTA0U3I3cUMyM2FNbFpz?=
 =?utf-8?B?SkhLbkEwaFRtUHdGL3FPZGNicXVpK2VYcXlzQkNzVWd0QzVCYi96UXJzcjl2?=
 =?utf-8?B?ZThjYWRaWVV0UkhHYjQ2UXBkUjV0M0ZwaUtHOHR3bklSWi95UDBDWUl4RGJn?=
 =?utf-8?B?TUxPMzFWRFF2NllnWFdmVXhyQ3RONzhvMVhGRENQaGd6SG9GcVpWandyZ2Yx?=
 =?utf-8?B?WEtlRUtWS1Eza28xVFVDQ1RZeEpkUVRmQXNUbFZ5Q2dUekx2Ny96KzM2Mmxn?=
 =?utf-8?B?R3R3d09rTjNSaTIrakRHay9TQzM5cjBtUFhQUjVZWVllS0NvbEdYQlVLUDZ1?=
 =?utf-8?B?QWRlMmdJQXlVQjVybEdXTU03bmtwUGhrRm11ZlRBdEFPRjhxQnkycmpCNHRB?=
 =?utf-8?Q?9qu/SkvK2RHchMPqPqyuMzs=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: f2632b2f-d6aa-4768-52c2-08de07110e12
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 08:51:37.1817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Litu4/6yt40Hk7qj1aK9pQ1X3e3FeQuUfG8gD6C5ARAZkfD4LmW3xZlB7EDwFikD5xmDU/9eQA2YhcwsASjE0jcGGp1lyV6cg/1xN/GSZNM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8434

Is there any chances get it merged to linux-6.18?

Regards,
Mikhail Kshevetskiy

On 02.10.2025 10:44, AngeloGioacchino Del Regno wrote:
> Il 02/10/25 00:23, Mikhail Kshevetskiy ha scritto:
>> During writing, the entire flash page (including OOB) will be updated
>> with the values from the temporary buffer, so we need to fill the
>> untouched areas of the buffer with 0xff value to prevent accidental
>> data overwriting.
>>
>> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
>
> Reviewed-by: AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com>
>
>

