Return-Path: <linux-spi+bounces-9602-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA68B3163A
	for <lists+linux-spi@lfdr.de>; Fri, 22 Aug 2025 13:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01C521CC3BF8
	for <lists+linux-spi@lfdr.de>; Fri, 22 Aug 2025 11:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1712E284669;
	Fri, 22 Aug 2025 11:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="ANk2s219"
X-Original-To: linux-spi@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020118.outbound.protection.outlook.com [52.101.84.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D45393DE1;
	Fri, 22 Aug 2025 11:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755861750; cv=fail; b=sKpWsTGYD5k4HXafIU7lMMi+FeBK5cVcAsPx9nMUVr0sCaCAN9Qumg0VPN9Y293BXv0fW67FV9/wvXupSFYSvc7xhfzs9S19VJGSeTku7gwXMIRFfU9SG40E9KxUsnT74/MRkMHylgZQ5bOIiF+EHqcrmgHh95nwlB0xs7TIIcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755861750; c=relaxed/simple;
	bh=7nmp17J2NZQKHgMSopSUHAnCgOm6LzmpBeAZ0LkDPSY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dU6eEV37O6syDvT8P9uxvPEzD29QhhSzMkAGwo0c68B+TXm5Pky3lc8FSJnwEhQXMutnSiL4bqZcT3PDb6PCnTAWxxgyWfH8C9DS7tYI0QUQdmYVFz04dSDCsmUpE34vznJvRrO9MhAxr8YNC2B7D3QBViYTla4EzAttfVHvEig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=ANk2s219; arc=fail smtp.client-ip=52.101.84.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SfwQxjniATmgWoiCoxNQEgN5h3uC8SmR32WtugJYVp504RoKmw6qocGusbLZ1YVBtM6rDO6xbhwCE6IWw2qLQTHULugE7X6mJ9FygkUk1RZxapbbS98FCzBzVYZA+7lB35f4QcLmrMC2JFkyKgojSSARchwRwFRgrsG4sSqMij7HPB+J8BSxY2P+zkCeAgKCo1Y+hrs7hRF5L3RN+5BGRa1/pCDGtamOZnVEjq5BRKTHgpz0XAKK0/S4mynLke5PApHuTTavTHRrq0a1UAmCFaBnP2heA4XFvRrMWjsTTeBma3L3kIl9h/LF30aSgenJqCzoG9TIOyrrB8Tun5cf7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tbzkyc84FtUfM5Y52KD5POzjnw3BC64XYufs1hqRFUs=;
 b=uaqvO7V3MWNM/eQ5/9MEQ14uqT9h340JbbB6v93fU0ZN8xNfaUFeGIR8x8cUSxkA8KmkpFr8LzOI1U7Nz+ZnxaePUBRNH7769LkqV8DhYazEnBgYN+j8DiNyh1qR1fms7ih6u5beZ+XzC3Ms5IcAgpPrq6JWKTPqZo64joLXOgKF0T12IfpqbfGA6wkk9Ms3ZO+Fe4+AnJE0TWylbsAun+CeLN5wzrPDut+1Gpu7xghP1yjlLnJzvMb5SW9cYBPXnyDy+Kl7y3hukFa8PUbxrLoIWfufgwq/RpK07zvvdX2BNbw373aOrd5fKGswGoWeiLF5JZA3Lh1m4MCdu+rE7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tbzkyc84FtUfM5Y52KD5POzjnw3BC64XYufs1hqRFUs=;
 b=ANk2s219RO57Vyn5/Hd9LixTdh5Bz5PMvYI4cEENfY/dgiAb2mDUnPQw8/Fxjyox1CLr4Ihew1SDSaBhCawYJWcP8xBQD/K9o00w6vCZG6EsTk/gxtWENfuu87j0xaKbTpRJU4HNFPeRobSfYBOHlJA4LU89FLvScIGS08ib2NZwvkCcLfTrNNFWsQA60UvEcKxRxzifjhw6Tk4pcOelbzoTnFomZefG96ijGu1rdMMXt4qD6XOaXVKFkespI/wPAWVheVkAg95Vpm4nieFgmwZu7mMcWQmdDOa+DqsrdTFRqNDBcFRtIf6lbrkYk802WpGGZWLaQW6WLHqWwGoHzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS4PR08MB7878.eurprd08.prod.outlook.com (2603:10a6:20b:51d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Fri, 22 Aug
 2025 11:22:24 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Fri, 22 Aug 2025
 11:22:24 +0000
Message-ID: <1d053317-24a6-4bba-aa30-ad42460ec19b@iopsys.eu>
Date: Fri, 22 Aug 2025 14:22:21 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/14] spi: airoha: driver fixes & improvements
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Ray Liu <ray.liu@airoha.com>, Mark Brown <broonie@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org, Frieder Schrempf <frieder.schrempf@kontron.de>
References: <20250820123317.728148-1-mikhail.kshevetskiy@iopsys.eu>
 <aKbDjIZhJuWo3yFu@lore-rh-laptop>
 <7bca8089-09ad-4550-93d1-35a365bcd167@iopsys.eu>
 <aKcEYn_hX0ZIusne@lore-rh-laptop>
 <eaea681a-cda8-4066-a58b-61a35e2b8b55@iopsys.eu>
 <aKgSY7bOrC8-qZE3@lore-rh-laptop>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <aKgSY7bOrC8-qZE3@lore-rh-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0348.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::7) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS4PR08MB7878:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a9b293f-a221-49c8-d59f-08dde16e2a9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZitncjR1MTVraWhGaDlJMGYzOWpHcFpJYWhtTk03blh6dlg1c3l5Z2MxK3Vy?=
 =?utf-8?B?MVNqNklXRGhxb3hyODJQeVpIK0c2T2JrZC9IZTk3eXk4L1BTTEYzMmd1NlV4?=
 =?utf-8?B?eWk1N2I2QVpDdUJVTm5WV29ZZENyMGlRVkxtMmMvL3pOclMybzhvUzVzUVZO?=
 =?utf-8?B?M0NYcHBCRU1mSi9Mc2UxYnh1M0JTQll4azZpbXlSSzV2UjQwUS9jSzNzc0Rz?=
 =?utf-8?B?dXVCbW5LL1FEV1IwOWRxSXdRV1RNTzBiZ011amVFQURlRGl3OUhQbEpDbXdQ?=
 =?utf-8?B?UFpqdWNaOXVWdm9RZFFsZ0JIcUdUZVFKa2ZvemdXTEp0Yk9FV2wwQ2hHTUNa?=
 =?utf-8?B?MXRxaWw4dUJxY1l2WnFjcnlaMlhOekYwWDd3RzFIZVBISGIzSjIvQ2NyVlpl?=
 =?utf-8?B?OGorTngvdDNOUGlhdW9GcEZ1TGFNUG9iVTdUT1NkVDZJVGxaT3RUdmhiTzQ0?=
 =?utf-8?B?ZkNranppNUxLdTJ3bWJwOHVWaVQ4V3ZpKzJ3OG41UktRakF2ckJyOTB5OXdK?=
 =?utf-8?B?L0loTUtjbm9nbFM0aTg2T011cVY5RHBxa3ppUUlDT3dtU3hqSFFNNHQ4RThM?=
 =?utf-8?B?aG4yT1FQYkV6QUpPRnpBY0liMFZKcm5DWGtCYlBrSEhqR21URENJRVlwQ200?=
 =?utf-8?B?V290eTFQaWMwYlBsL2lDS0NhODNQVHBqK2hoS2dsN0xmZU42ZFRxcXVNRGYw?=
 =?utf-8?B?ZDdXUTloUTdLYTVNVVZCeEt6ZHQ0UklobnVtOXl4eTFpRFZoRFZRWnNJUkpy?=
 =?utf-8?B?QldGQWVHd1JzMVV1bkFRd0diY01NR2x0RkFqSkxDNFJZaFdPYUhJbVd4QTdx?=
 =?utf-8?B?VjBzUjMzZjFnTEIrSXRqMnBNRTMxS2JHSjUya3R4RWtzM0lyNEhZbmlLejJn?=
 =?utf-8?B?OTVFTExHRURwbllXZ2o2NWJFS0x0QUx2cmJ3RXlVU3o3UHNTbUpwNkhTT0Zu?=
 =?utf-8?B?bzl2Y09ib25ReGtFZUdNMGFlM1gvR0VBTWdHUG1VczNBTE1lMzdXMDdOLzhF?=
 =?utf-8?B?cTk4NVUzSHJxcjF4Qi9SbUZYektBN1NoWmVyMkZNdmpNZ08zOCtpdmo1SVRS?=
 =?utf-8?B?Mjh6NGE2cjJPNVB1enJiaVJmamdUeS9TWjNwN2RGT3BLSzl1UmVRais2NmdN?=
 =?utf-8?B?bER2ZnQyRC9NY1E1M1U4WEttTUdBdjh4dmMrSE9WQUdFNnJuTnUrbjdLUW9z?=
 =?utf-8?B?VlNJWkRaRDk4S3JRclBtUW02M09MKzMyWUdRSmRHKzVBbmJuei9qQ2tkV1dh?=
 =?utf-8?B?a0xOUXlUejg5a2RlQ1dGYXNtaUZrb0NHeGkvZU1XL2QvU2NibmZkSWpsNHJT?=
 =?utf-8?B?eUlUWmRzYnVLclJPazlxTW5kaDdhMWhjQ2RkQ1FVTDJsVHo5cGtQd2d1ZjBn?=
 =?utf-8?B?Sm5HaGRJcCthRDkzU1U0Y2RYRXVWTjE4UlpLRlJHSGVYUVFqWGwybk4rUmVa?=
 =?utf-8?B?R1NpTWRPNjlMVU5nZkwxSnBGbVlQVU1YZFExaTExUnFMSnhrWUZjcWJramN5?=
 =?utf-8?B?Y1BoV0hEOEI3VHozRWlndXIyb292NG80bHNlWWVEOHFWcENMLzRyOWR5RFM0?=
 =?utf-8?B?LzZBbG9rRGNYNzZIRU5SYk1Sa25WeE1hN0hJaHVhdFN4Wno1WVZpaEJCYnZW?=
 =?utf-8?B?VWJQUmJlZEZIdlFKQnMrUW5lcGNmN1VJb2kxWEdkQXo5OHRiMkVnNTVsa0JG?=
 =?utf-8?B?Q25lVFpEanlKOEtmOCtBaVUyWmVZMFBoQW9GalBPZlU0bGJpTmJrbDRQVUpV?=
 =?utf-8?B?bmw4RXY3L0cwMGJyMmRiNXNzZHhFR1JtRjlDVTB3TCt6bVIyM1cyOEdqaDQ0?=
 =?utf-8?B?bWJ0V3pnZkJBQkppOXpEU1JzdVJMUko4bTJScXpKYXNiTmZwTi9PT1dIMEsx?=
 =?utf-8?B?Rkw0TmlUWGdGam5VKzl1NHJiWGhUQW5QYjA0cFBTOEU4QWFNUktVanhvNVNp?=
 =?utf-8?Q?8Be+oOv16LI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bGZNZmRlZkpXcjFsYnY3Sk1KaEVVYTkvMlAzYUhqVjJjUzZLdjMvS1hBaS84?=
 =?utf-8?B?U1k5OTMvekJ2MzZFd2J0Um1mUHhrRk9kVzJFWko0UFBLL3NwbFptOStOYkVI?=
 =?utf-8?B?Y1hFOUh2bWxIazFEYnZ4U25hNWIzV3hXYmdPbW8zYXB0NS9VMzBFQWRTcTU1?=
 =?utf-8?B?THlDZ0JPckx3RjhpM21WS1pPOUNMSFZPWE5RNEllK3dQVFdIcXJRSktidlh6?=
 =?utf-8?B?SzdMVVQxWjA4aWFDNnJTaXFBUFh5Q1RuZEVyZDdNb3JQL28zcDMvMEJ0anFi?=
 =?utf-8?B?SFNXdElqWmlTTnVDbEQxZE96azQwc2NsWHlmRmVrd25pRkI3cjdlQ2lmUDJK?=
 =?utf-8?B?aWQxbStPQmNkUE1tMWl3RTY5QXZEaVpMN05MMGYvQXJDbVgxam1MRGtnb0tU?=
 =?utf-8?B?MlowY2Y3QlhQRG1PdVJCWGo2ZDB6M25kS212TlFRbXpCUU5oaUw3NnVXWkhq?=
 =?utf-8?B?d1BXQ3ZGLy9saFlaWTdaY3BaMkpCK0FhQmlKVjFCYTVnSFRHVGJsb01nYk1w?=
 =?utf-8?B?a0ZxVGR2NXRsRmRQQ0VmVWY1OTZtamt2SlNQSE1YcGtIL2FkVHpvNHNWcUFL?=
 =?utf-8?B?b1Z6Z2FtZXBsNTdTbDJEVWlkUXA4WmpENjdpMkRybDFkNWxoTU5WZTBUcnFh?=
 =?utf-8?B?WndFYjVtMmM3Um1kbnIvK1l6bkxuL1BySGhNVDlXMVFFeC92eGljMGNJNTla?=
 =?utf-8?B?Uyt2RmRKQXd6dnhVMFljSWliRUYyZFcrdTV6dWtFbW5jOXZnbVpDNUYzN2Ro?=
 =?utf-8?B?YWtETndPRC94cXd4OVdLcjhLMmZaVHJoRXZhS3pvb2xieXVUUG9kOFBSay9r?=
 =?utf-8?B?YXE1V3pVaGpyMzc4dklyZU91djNIeGljSEh1bnRseno4UmZ2U1BraGFKMXl4?=
 =?utf-8?B?c1JCaW9DTGlmM0JieG9zNUFHdkNlNjVnNko1SUdtaUd0T2JCemlKQnM4d0ZT?=
 =?utf-8?B?djZ3eW5GTHFxRSt3NUpiNGk4UEpoamYyZmNKU1pBQ2N4ejA5QlZwajdJNktI?=
 =?utf-8?B?YVQvSVdlc1dGQjhQT3A4VUNUNkc4NDdlZU1JVzFWL29Fczluamg1QnJWUk05?=
 =?utf-8?B?K3d4Qy9HUnpwcHloaUxJS1ZFa2NhVkcrU2R0UzZnRXpiM2daZ2FFRzkvaTdh?=
 =?utf-8?B?RXY5REphNEJZc1FCR3NQbTI1RHE3YW5KNm1pd0tHN3BPeHowdWsrYjQ1K2lS?=
 =?utf-8?B?QmFIRHFuYmlsbVJxWXIrZU9kWUc5Mk5vaWhHUkM2ZHZMeDhuWlFGbm1GenJH?=
 =?utf-8?B?SnlEVytJUEd3azhBVzdEQUV1djJQNEZMWEp1aG1KWHkxaFlOV0JXeVM1ZG5H?=
 =?utf-8?B?RVMybThGQ1JXeHZiclZkQTJPK0MyNjJSclU1Z3F3YTFFZzk1ZU1BSzk3b3dY?=
 =?utf-8?B?S29ISEdFY1JpSXYzcVNreStMc3BIckJHMXlKeXVtb2Q2SGVFUEFmeWpMSE52?=
 =?utf-8?B?S2tCejk0V2ZtOU1rWTF3bHNabitGb1NEeW1FYytUTUhOTmpLY0tsRzNYM3lR?=
 =?utf-8?B?TmhQSlJjNWpOMEwrRWxmL2dPVUVFNnhkVi80dG83ajV2TS9zeGZaMEFObTIy?=
 =?utf-8?B?bTV3clZTY0J0TUROcWtuWU4xVVdWbVJxUkxVd3IrcHJ6aHlsL3YvU0I2TGJ0?=
 =?utf-8?B?cEVTMDFheXdjcWFYVkF1Rkh0Znh5eEZnSzZTSTg5aEZZS2Y5REhzMzFnaEN5?=
 =?utf-8?B?bXk2dEk1VUVjSHpIVEx4T1Z4SG5iQUFFNDJKQWpnbXpEVldPR0ZlU0VKbVJa?=
 =?utf-8?B?Tjl4b0NGYTJhTkxHRitGYUs1S3ZsZ1h0MUZ0dEp1cTJnWkJrOUdZc3lqLzBF?=
 =?utf-8?B?OFhTaGNIRFo2NE80RFNHcUNydlMzMHUyL2lUQVZLZ2dEVXYrMnZkWENnZnhy?=
 =?utf-8?B?VFNoR09hcG1oWnBGSE1LekRzUGdTRWF3ZEVCZEZPVWRLeTVEcjZyWm80ZHJZ?=
 =?utf-8?B?blJVL1VISXVpZmU4cmdyUjNMelgyQ2RKbXk0K0VsQ0ZsRVAzUjIrUFA2QVlJ?=
 =?utf-8?B?Z2RDVUd5eUl3NWxvd2ZCK0R2Mkh2MXdodjhZZmcvTHlyMXFHZXVVRTBIcENE?=
 =?utf-8?B?NitCU3V0RXRwN2xTUU8ydjhxM3YxSGt0NFZMY0dlQXgycTFVTnVLYjBIMUli?=
 =?utf-8?B?VTg3UWVzaW0zeVNCemtEZFhJWGlsTjBZV0dLMC80MEs2QWV6WWxqRTNXNWZa?=
 =?utf-8?Q?vwPHie44cTKmmA2U2JJhT78=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a9b293f-a221-49c8-d59f-08dde16e2a9d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 11:22:23.8442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UcqmB5aRV7Oemt+j0rzy4nppYf4/1QiQIyjyXgnQMvB2QkUgqbz1qNCXeKvQJhDeZwYN7ye3Pg2g8ZxXcecd3Cs/PS8D6daNAAk/1ak3FHY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7878


On 22.08.2025 09:46, Lorenzo Bianconi wrote:
>> On 21.08.2025 14:34, Lorenzo Bianconi wrote:
>>>> On 21.08.2025 09:58, Lorenzo Bianconi wrote:
>>>>>> This patch series greatly improve airoha snfi driver and fix a
>>>>>> number of serious bug.
>>>>>>
>>>>>> Fixed bugs:
>>>>>>  * Fix reading/writing of flashes with more than one plane per lun
>>>>>>  * Fix inability to read/write oob area
>>>>>>  * Fill the buffer with 0xff before writing
>>>>>>  * Fix reading of flashes supporting continuous reading mode
>>>>>>  * Fix error paths
>>>>>>
>>>>>> Improvements:
>>>>>>  * Add support of dual/quad wires spi modes in exec_op().
>>>>>>  * Support of dualio/quadio flash reading commands
>>>>>>  * Remove dirty hack that reads flash page settings from SNFI registers
>>>>>>    during driver startup
>>>>>>
>>>>>> Unfortunately I am unable to test the driver with linux at the moment,
>>>>>> so only the following testing was done:
>>>>> It seems to me this is quite an important rework of the driver. I would prefer
>>>>> to have some test results for this series. Are you able to run mtd_test kernel
>>>>> module for testing?
>>>> I'll try to build latest openwrt with this patches  and mtd_test kernel
>>>> module and try it on one of our boards.
>>> what board are you using for testing? If it is based on Airoha-7581 you could
>>> use the following repo for testing.
>>>
>>> https://github.com/Ansuel/openwrt/tree/openwrt-24.10-airoha-an7581-stable
>>>
>>> Regards,
>>> Lorenzo
>> What tests do you suggest to run?
> IIRC I run all of them. Can you please report even if there are some
> improvements (or penalties) in read/write speed
Do you mean to run it twice? with patches and without?
>
>> I have a single flash I boot from. It have only 2 mtd partitions:
>>
>> [    2.980849] spi-nand spi0.0: Micron SPI NAND was found.
>> [    2.986102] spi-nand spi0.0: 256 MiB, block size: 128 KiB, page size:
>> 2048, OOB size: 128
>> [    2.994493] 2 fixed-partitions partitions found on MTD device spi0.0
>> [    3.000856] Creating 2 MTD partitions on "spi0.0":
>> [    3.005651] 0x000000000000-0x000000020000 : "bl2"
>> [    3.011247] 0x000000020000-0x000010000000 : "ubi"
>>
>> Most of tests are destructive. So If I use "bl2" or "ubi" partition for
>> test, next time I will be unable to boot :-(
> yes, I flashed the device after carrying out the test.
>
> Regards,
> Lorenzo
>
>> Do you suggest to patch u-boot & linux to have more mtd partitions?
>>
>> This is the results of the only read-only test I found.
>>
>> root@OpenWrt:/lib/modules/6.6.79# insmod mtd_test.ko
>> root@OpenWrt:/lib/modules/6.6.79# insmod mtd_readtest.ko dev=1
>> [  159.121706]
>> [  159.123220] =================================================
>> [  159.129053] mtd_readtest: MTD device: 1
>> [  159.132898] mtd_readtest: MTD device size 268304384, eraseblock size
>> 131072, page size 2048, count of eraseblocks 2047, pages per eraseblock
>> 64, OOB size 128
>> [  159.147008] mtd_test: scanning for bad eraseblocks
>> [  159.152141] mtd_test: scanned 2047 eraseblocks, 0 are bad
>> [  159.157549] mtd_readtest: testing page read
>>
>> Mikhail
>>
>>>> Actually patches can be divided on to parts:
>>>> * fixes of current driver (patches 1-10)
>>>> * change of behavior to avoid reading flash page settings from SNFI
>>>> registers during driver startup (patches 11-14)
>>>>
>>>> The changes are based on the code we are using for more than 3 years. I
>>>> adapt it to latest linux/u-boot code.
>>>>
>>>> Up to now the only known issue appears on en7523 chips only. Here a
>>>> corresponding patch description (not added to this series)
>>>> ====================================================== spi: airoha:
>>>> en7523: workaround flash damaging if UART_TXD was short to GND We found
>>>> that some serial console may pull TX line to GROUND during board boot
>>>> time. Airoha uses TX line as one of it's BOOT pins. This will lead to
>>>> booting in RESERVED boot mode. It was found that some flashes operates
>>>> incorrectly in RESERVED mode. Micron and Skyhigh flashes are definitely
>>>> affected by the issue, Winbond flashes are NOT affected. Details:
>>>> -------- DMA reading of odd pages on affected flashes operates
>>>> incorrectly. Page reading offset (start of the page) on hardware level
>>>> is replaced by 0x10. Thus results in incorrect data reading. Usage of
>>>> UBI make things even worse. Any attempt to access UBI leads to ubi
>>>> damaging. As result OS loading becomes impossible. Non-DMA reading is
>>>> OK. =======================================================
>>>>
>>>> Regards,
>>>> Mikhail
>>>>
>>>>
>>>>> Regards,
>>>>> Lorenzo
>>>>>
>>>>>>  * Driver compiles without error.
>>>>>>  * All changes were tested with corresponding u-boot driver. U-Boot
>>>>>>    SpiNAND driver was modified as well to match linux-6.17-rc2 with
>>>>>>    additional fixes for continuous mode.
>>>>>>
>>>>>> Changes v2:
>>>>>>  * minor fix
>>>>>>  * add comments to code
>>>>>>
>>>>>> Changes v3:
>>>>>>  * add patch to prevent continuous reading
>>>>>>
>>>>>> Mikhail Kshevetskiy (14):
>>>>>>   spi: airoha: return an error for continuous mode dirmap creation cases
>>>>>>   spi: airoha: remove unnecessary restriction length
>>>>>>   spi: airoha: add support of dual/quad wires spi modes
>>>>>>   spi: airoha: remove unnecessary switch to non-dma mode
>>>>>>   spi: airoha: unify dirmap read/write code
>>>>>>   spi: airoha: switch back to non-dma mode in the case of error
>>>>>>   spi: airoha: fix reading/writing of flashes with more than one plane
>>>>>>     per lun
>>>>>>   spi: airoha: support of dualio/quadio flash reading commands
>>>>>>   spi: airoha: allow reading/writing of oob area
>>>>>>   spi: airoha: buffer must be 0xff-ed before writing
>>>>>>   spi: airoha: avoid setting of page/oob sizes in REG_SPI_NFI_PAGEFMT
>>>>>>   spi: airoha: reduce the number of modification of REG_SPI_NFI_CNFG and
>>>>>>     REG_SPI_NFI_SECCUS_SIZE registers
>>>>>>   spi: airoha: set custom sector size equal to flash page size
>>>>>>   spi: airoha: avoid reading flash page settings from SNFI registers
>>>>>>     during driver startup
>>>>>>
>>>>>>  drivers/spi/spi-airoha-snfi.c | 508 +++++++++++++++++-----------------
>>>>>>  1 file changed, 260 insertions(+), 248 deletions(-)
>>>>>>
>>>>>> -- 
>>>>>> 2.50.1
>>>>>>

