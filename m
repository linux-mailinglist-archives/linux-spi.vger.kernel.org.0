Return-Path: <linux-spi+bounces-9603-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CACB8B31642
	for <lists+linux-spi@lfdr.de>; Fri, 22 Aug 2025 13:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1D756040BB
	for <lists+linux-spi@lfdr.de>; Fri, 22 Aug 2025 11:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D342F90EF;
	Fri, 22 Aug 2025 11:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="Wlhx7XsN"
X-Original-To: linux-spi@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021125.outbound.protection.outlook.com [40.107.130.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E182C2F6184;
	Fri, 22 Aug 2025 11:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755862062; cv=fail; b=exu3BrQPgCTI61Qx8vbWywnHya7xk8YFiANwsRlvVEq7dcNeHUsXJ5B5eK00rPGcUZLsm5TmLIk7BdGZMvJdZr/w4b0jSNmgLg/JAn4KDMu1654LLvchJ9Tt1TGSR7NLyuFdouHfYLXw7r5JD2fdUfLKgx0fMHd6GNcyKl1kXGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755862062; c=relaxed/simple;
	bh=FzWYFxFuRH4x1pUcIrVp6lr3wNkaceWJQ8hOKWB+988=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d8I5nwxDeBM68ekxpXsunpFfsZRQHHiw7hmdqYP0i79nqz25YjNwo6PYahi10mJhlDz/2NSF9Y+NqtJ3SoqsdEoUByrKnMrfLPEJuECvvJAl8kh5h89FbvHX+9qS1IRtbGMMflcrzDAIrv6MlKxTPTwE18G5tg997CtflawhSwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=Wlhx7XsN; arc=fail smtp.client-ip=40.107.130.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Utk1pnqM8GzSkeLyzJ1zEdtalHFQB/9yTsj+yyKk86z3FQoG70BuqDSsenZOwMpDPrcQSN+/OTXcbdCSfCRKbNSBqGGDN2iWxrWG/QYIum2rDITVYkxQzA0X/IroOuP5aMhXGg2hbf1GnOiMfQCnj/tYAFGFSdPpnFeTMzqKJzBYut8itGWXjv3XocMVZfAY5ibxf8IqYUzGjs9rlIqOPtq+W0gw43WTZJmaDupWcNjkov3GeqKT0lWUExfmo80ar7u8PUO/RhjyKfd2hM+lXAc91LkGbtOCtGT5xu5AkN1Y2YSB6eUnEcV0GziRhk0M7mOiYp3LU27ahe2OQsSaxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WQoE5UhLKnOxQoi7UEsmWiURPrkdJ5JlC/F9VyycwFs=;
 b=Hp30QEpe6L0e6iqVU8wpfgxR+X0DlHFXBaZAY3jQUJT246NST7s1ztBMdpn7HVg3GgYESkSULCoUVOP0ZZuYdQFZJS6hcYqW+jjzNDBXgeErfzLS8xGaanFOXKrBogIb6GGVHUUtZHgbayn4gBC5Ri8M8Th3WYCPbjxBmJI5sKm/zSvHgDWnxKJi8qGu+c/LkImBapzrG3Wi4Skyemy8z2y5JTpr9uMSr+YZdCKYwql/KEaKpRfgq9FOSqHjo1UJRri5DWmA1P5LVwXnDX4rFGiVhagwLja2+A4+QIaWGJTeG+x1bp2zJ9kxVgih8k8JU0HJn7X/dcJxKm9Tno2U9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WQoE5UhLKnOxQoi7UEsmWiURPrkdJ5JlC/F9VyycwFs=;
 b=Wlhx7XsNsDeeKT4+EVa7mqAnGfKWm/ZSWv1L7eFKGkCAil8G/F8FxDSRCtmkAyDuQiw8hSysu7+whLXyJo54CkIKvv4oFzJBIDSH2h1hP1LJd0k2/fgf3kF2IyarlDVoyz9BBPZvkT5Orc/ReclULEYLUzRf6ltdbA4EpqLUZNCmnTzaYJ6j0nAWrPsBhYkjKOijjOnE+mMPtVZ3rXkHoSeOlqqBp2qLG37BZhSpRI8WKN5gp4xCzo/MYzGUV9AaDM4OQwqVRX8cSGPbThjWRIHrxhKfGCUV/Wn+c9SvFYwZKNorLljkYH4UK/GheieYwKzLklBUWPoHGbR/BDhDAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS4PR08MB7878.eurprd08.prod.outlook.com (2603:10a6:20b:51d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Fri, 22 Aug
 2025 11:27:37 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Fri, 22 Aug 2025
 11:27:37 +0000
Message-ID: <616a6567-e69d-4c66-a64a-ab0fae17568b@iopsys.eu>
Date: Fri, 22 Aug 2025 14:27:35 +0300
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
X-ClientProxiedBy: LO4P123CA0153.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:188::14) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS4PR08MB7878:EE_
X-MS-Office365-Filtering-Correlation-Id: 07eade73-bd79-4566-8ca6-08dde16ee577
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NGhQS01xSUtsU0RIMGRzSlBlOWJvUnBOWml6alNRN2ZXWnFNWmdzMk4vSzZv?=
 =?utf-8?B?eDUxSXhabkdhUnN1Z0JBUkt5Wk5WZi8rVGtVVEF0a2VDd1p5ZTQ0TlhLM3Fy?=
 =?utf-8?B?WDFIS0IvVzZLY0hPdG00UmM3RFoyWmpHK2FnTjlnalU1VVhKdzgyVHhEamNH?=
 =?utf-8?B?cFhjQ1FjY0U3YlBDa0tJbU1kNmxEaUY3dzNhdHJ2NitROGdpbDBZeFkvTTlB?=
 =?utf-8?B?SnVIVHVhRlRDZUlhTnFVUTVnTm4wMTNWU3ltUHV3blZJWVB6K0VGQmJiTnVk?=
 =?utf-8?B?M241U2sraDJQQXcvRGIwZ3RTY2d4VFJ3QWxkU1ZicVY0M0ZQVHl4MmtXN2I3?=
 =?utf-8?B?ejgwcVNYQkgrNWVwUERXdGdKSXo4VTAxY2tDMVFmZHhXeG1SSHUyNVJqcU8r?=
 =?utf-8?B?L2VhMGFkWEpVaEs3MnoraDNmZnlNUmt3c0gxSFcwMzNWdzg2VkV0Uy8vbFc2?=
 =?utf-8?B?R0pYTWQ2OXc5WC9XU2ZXSlBMZGw1ZVI4RXhMcHU0Sy8raThVVHkvME00Q1kz?=
 =?utf-8?B?QVhTcTd3eG1OUER1QkRtc0tMZHhUSlBTM2tRT2ZBR1ZDb0p0bkdBRWx3c2RQ?=
 =?utf-8?B?UHlmLzhRMWppWWVSSnZia1dJOWdhTTZ2amhFcG5Ybm9FWloyTlpRdnNpRmNJ?=
 =?utf-8?B?cm9YeDBObkMrSTBRYWJZcVlUKzlncWxtbUVpQXJsMFI2ek80YmhJY3d2ek1V?=
 =?utf-8?B?Sk5YVitwb05BWThtVDY0Sm1hT1lqK3lpRWNSWWNjUTVJQk9LdkNJS01qOXVQ?=
 =?utf-8?B?V2xLWjVYbU5SNmtHa01wNEViamt2cUtRVkNXZzk1dGFDb1N3eGQxNktuNE8r?=
 =?utf-8?B?NnhjUWdyMWsvdGswa3lzUUw1UFdMWTFjWUgzN2d4dmJuNVpDTVRpTjZBaHpW?=
 =?utf-8?B?MUxNRjU1cWxyZU9YZFpERkw4L3BBdGZuekRDVUF5dE8vQ3N2OWwweWhXd0dI?=
 =?utf-8?B?UTlnMzFJSTNvZHhSbmt3amRkenVobVI0SGZNUTN3ZjFvU3VvTzI2SlVQejJQ?=
 =?utf-8?B?NWdCZlJadnlWTWMzSlFhOUxmL09xZFN5RTlvc3ZJMFFTLzVTQ0t0Q3k3K3dW?=
 =?utf-8?B?UkFGcCthWHBPZjNOY1gvZUtOVzlzRTJMajZPc2Y3NTltcEVZMWRrNzlRUE5r?=
 =?utf-8?B?a1hlNm9UT3VVT3I4M1B1TzBSWS9IVStvZEpNYnpISUVwSG9WUVJxUFNLVDFu?=
 =?utf-8?B?aVpUZlhKTFBZUUs3M05uL2E1T2VQdDMrMFpFKzNuSXo1T2I1cG1DVGw3VFlW?=
 =?utf-8?B?M290U3R5TFRVb1RPYlNad1pVdkF0QytOWGNDSXZIQmVhbUhlOW9pQ0FJSzJ3?=
 =?utf-8?B?Y0UvV25EQnBmVURwaW1HMGJ4cUk1NjdIekF0bDNOT0Jtb09lN3k1WHljTDh1?=
 =?utf-8?B?SGlwTUhXM2R3OTJFaFhKTXZ2bm5ScGVhN2o2MWVKd1UwbEtJWmtFSmZnYm9m?=
 =?utf-8?B?bFEydHRMUVFCemRYMmhsN2VsTU94cmN3ZHhFbC8xQXRkUFY0aUhtSkp4SDJS?=
 =?utf-8?B?QU52SldCVjRNUVN2TmI0ekViUjBKb0R0QWVscERoUk1DQzhIWlhFWXZ3OWxm?=
 =?utf-8?B?TmJUM2QybU5pTzFUYzJFVlhYTms4L1RWeUpjUUV0a1ZHZERCSXl6MDlpN2lu?=
 =?utf-8?B?V1Yya01VZUovdDYrU1pvNW5vWjM5eGpCRkFidGVXMGt5ZmpmR25hZks3UUFC?=
 =?utf-8?B?bjNHVXAvVmx2ZUNhQm9QYktyQ1NCSkZzYlBNS1JIeTVvOEVGWTMzcWpXUDFq?=
 =?utf-8?B?RDA1cCtCaSttbnc2TUFJVUJPbG94NVR5bWhNSlhBZUxMeEFCaWt5MUl2ak5S?=
 =?utf-8?B?U3RvVnNRYWFWUENzbFg5LzFUL3NwMTFGaVVjUDM2RnRwbXExaGJFblFyUG1Z?=
 =?utf-8?B?QzJRWU5SMHRkeWloREUvS3V3RjhKWWNZdnlrMTNLVUQ1SVlOeUFQRnJYeDhI?=
 =?utf-8?Q?gF+lXmDpRHE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d1VsUi85UHlUa2RvYnlZeVRJNG5CbzE2eFhIa0FKejVBc0lhdURyUTd0VFJx?=
 =?utf-8?B?cWk2Z201NERwNEw2OUs3N1lzc1liNHpqdEtINThydElmZVk2ZWI5elR6VnV5?=
 =?utf-8?B?QU1BbmR1cFViaW4vemhLVE9xQm9nekxNRjNCWFA0YURUR1ByZTJnUXNnaDNK?=
 =?utf-8?B?STlDOWgyS1hEdW1HMnFNUDk4N0ZBRmZKK1MrSG0rMjZpdDVMS0N2UzNiR1Q1?=
 =?utf-8?B?MU1RL3Rvdi93c3ZJTUlNMXFPYnBqNFQ1a2RFTjBoQTB2QmRXblFoWDhrWVln?=
 =?utf-8?B?aTNUMVBWSWdvZlJRMnBNdDk3dFlUTHhyWTc4QkhUM3BDUk44WEFzQlBXMGwz?=
 =?utf-8?B?bk4wT0hlOHVCbHhHbERra1hBSXlReUdNUmxkUmVpV3Zoc1BBNHU0VGRoZzNy?=
 =?utf-8?B?WFBTQU50aVpmRHB4dXBJWmptcklLZDY0cDc5ZmJHclAwRDlPMzlwRVhzelpm?=
 =?utf-8?B?Zll6RnBnME9wNGIzbHozTUQ1UTE4d014TlVGTHVpZUdYbU1NTVYwRCtuMXFm?=
 =?utf-8?B?WXN6VXl2Z0FtSmRSUHJhdHc2eGN5TjVqUk5XejduMHdWMTFBRzArK0xLWGZZ?=
 =?utf-8?B?Zk9SUlJzd1N0ZXRUa1R1ejlYUEhieHBKdW15UDlUOEJNTWc5RHRQSENmSW1G?=
 =?utf-8?B?RkFSNEowZE0vamhYNXRMSHdITnk5R1JSWXlNUGZZMXlyNVlpSUluZS9BeGJz?=
 =?utf-8?B?YUIzZFVnU2p4Q2x1WUdRSjU4YXhnL3FEQWxrWThrSkpJNm9QdFo1WDUzZmZu?=
 =?utf-8?B?OUE1WTl5YkZ0VkZrWTZGMEhHRmFTRExNYzhEVXl3RXJDRk9OWjNETnhqeEtu?=
 =?utf-8?B?K3l4OFpNM2JqV2h2UlRrTGM5N3hFQUE0dTJpU2FaZUplc3ZOQldkRU5IK2Rl?=
 =?utf-8?B?K1piTDFnRXMrSzVzdERmWUpGb09xRFJPeTU2SjB0NWd2TEVGdC9aVVBreHI2?=
 =?utf-8?B?ZzJhbGplNkw1bVFOTVAxSmQ4VW0raFd4bUdsbnloVUtpbU1UaXNWVk1EeFFs?=
 =?utf-8?B?ZVBuMUNUQ3B6aVFMMXFlOTNnQjhvTEJvem5pc0gwQkFZa3ZPNnQxNmxDK1pw?=
 =?utf-8?B?WHVlRDlib0lqVzNoNjJ2ZVN4Mm5TTURYNjRRMFlUQ3QzMGFWTlQ2dGtBZlln?=
 =?utf-8?B?YjVEYWtrcTJWTmdldDZmaml0TFhwcjlvSnllNnZaT1hIOHhzR2RRZ3lleFJt?=
 =?utf-8?B?N1RXRFd3UUVESEtuVzI4UTUzOHRJdGFLdEpzay90MUJtQk1mZEg5Sk1LUitt?=
 =?utf-8?B?VG5NRTdEZjZEUEp1cjZxSmVHaWVuNHR3YjhLcE5TV0RReW9uOHp2NGNOM2Zh?=
 =?utf-8?B?SkoxUzludFBqL0dxSGRESnFETXhkckFpSWlUUy9zMWVjU0R1Z2FiWDFkWlQ0?=
 =?utf-8?B?cFZvb0NZVU5tVkh5azZnN2ZVZVgyRU5taDZiZmp4NWF5bXUxWmhkMkJGYjVt?=
 =?utf-8?B?a0NhK0dqelQ3UFg3UnFwUHYvT3BrZm1SOGVLVERJeGVHTE9lbWc1QnZSamw3?=
 =?utf-8?B?RjhGajdQYTNiL3l2NEwzb29SSVNsN3BTcjA3bWRtMDZIcDBjMXZyeUw5OU1Y?=
 =?utf-8?B?S1FiTis5LzNsbzl2d0QzcWUwR3dZNFlPNTNkWUNXK2tQbEZsbUZnaWV4MjBS?=
 =?utf-8?B?WnpEdEUvUXh1N29vRmJmMFpHSHVQRk5iL3hJZDgxc1g2UXc5Z1IxWmhzdytV?=
 =?utf-8?B?dndCY090TWdKRWxzT3RUOVVPZE1MOUQ4MUpBdmFnK2JRMkwrSXg0WmlrTExY?=
 =?utf-8?B?bnNYQlNZbHVCVkIvRVF6TEVYRU1rQ0h0RFB3WU83VEJ6a1IxOG93ZDRaQTkx?=
 =?utf-8?B?R3RhOWZNenNpYjNHZU9zUjJSTGMzanpaWXFDV1NBTHR3dnExTjkraXRWUkti?=
 =?utf-8?B?MDlUSkx6YzZoY2JFam1PNGdOQnp2bFFOTlpKbXJKa3VwWE1iTUQrUHRKTkVM?=
 =?utf-8?B?alBKQXp3RHJWbHNMdmxWS05uMjJGeEVYRHhmM0VwcnNVN3NvZitQYlFoSjhH?=
 =?utf-8?B?NW43dnFwbXFnQnFDWXhGTjJOUmhTaFRxdkZYelp0UDZFSzRiVFVFeU5WdXVy?=
 =?utf-8?B?UE1QbXRZcmkvZVhSOUVQa2xLVDExaWZJZzBhK0lzbDQyc3g4MktTNmdhczNF?=
 =?utf-8?B?aURSYXdFdkNySjcxV2ZOTENETFVFcDM0dEtBcENicDVVZnpWb2dJV3NOV1RD?=
 =?utf-8?Q?nkTT7M/RetMbBj1gQ4huwKQ=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 07eade73-bd79-4566-8ca6-08dde16ee577
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 11:27:37.0367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QYlwrjnNXyraZNN5sO8szRKulqLApS2GWi8VlH1qgbROmS2SxygRZZUH2NWrXJAKmEGyCr+OtqqeWc54QEqn43K95KG7vY5rlk9snAw/+CQ=
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
> improvements (or penalties) in read/write speed?
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

Is it enough to try tests on bl2 partition or it's better the whole flash?
By the way the current partitioning is bad -- there are flashes with 256
Mb erase block size.
So ubi will not start on the erase block boundary for such flashes.

Mikhail


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

