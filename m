Return-Path: <linux-spi+bounces-11408-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5A5C7439A
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 14:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 4A4B72B3CA
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 13:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F203632D0EC;
	Thu, 20 Nov 2025 13:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="OV01aKMS";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="abXtOOyz"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7C9337699;
	Thu, 20 Nov 2025 13:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763645170; cv=fail; b=YulEQ/Go4YTeov5mTH4OxBGDox1erEl+3Vs7aZRwNAZZvCNehOWWtQWvH6hM5oucb7WjvAiEfCMg5E+Or036J8ngVEV3BSuyPsCejHILbGsAltT6i09ixcJXd59hWXapWhfAT9anOkxD3Nx1/syLgwkuNurQHP3pCxltHWfVRrg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763645170; c=relaxed/simple;
	bh=KyTZAE3/FZNtAbm9nE9DOu17cpMvfoHq5YMSCsDFHgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lV24oni0b25MIk0BovXYigs6X3eb7BgvFq1o1DG0alPQm0bh9dmvQq5Q0f+0deFuJJi8st0baipGzgDkEFiKq0xCMd6/itdmAJX1P6oha6IVbRXD04zwWQII7LsdgNhbfKYONrt6Omd+IXimXRn4pOfSI3YqqiH6B3caeILkafk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=OV01aKMS; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=abXtOOyz; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AK4fZa6247388;
	Thu, 20 Nov 2025 07:25:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=vZAwGXdsCYkUGfdHES
	3miZFD0JFQo76AOC+RMrqH638=; b=OV01aKMS3IMyCwxXyE8RWpqkZpd6Uggold
	BhgGbdV/9PMZWYxDCF3O+PRlBgHxa0Sk3yNxYAneGfAFAEN0LZgjN+VbKVuUnJJj
	0IExgWcC6QbmRcxmKlxw1Vj2YFMO9MwDF7JO0Ueu5CVtmV+m3ANg4kbcCdGYOk/z
	XTbMmBO2I8hRChRdkVhcyf7L/67vSr3M7uE6a14+xN8oOMBCJq345tSzGJTuZ1xi
	sRFhLNsmiy2GGfp4hIMPDDc5+iw5ogWvW+rYGmkoaup/fsM5Wmbmf7Bcb0gnChEY
	YosAfCLxgdALQyQqjF1bPZEoBJHhoFqmkDRQBrzaJrUlY7BeM5Lw==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11020124.outbound.protection.outlook.com [52.101.61.124])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4ah1bmae9t-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 20 Nov 2025 07:25:55 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wPgO0SdJk0p4qVzE6WfIL0ofKMHUGJzvYM4lQIpv3Cm5ZVZ9RpD6t1DWOk07aD5gMR6lH7AFm+IkJG6juG52OHW1YNAvXDOem66SLp8VeLixeuZckra0vJd6+oQPZUDIIy9gc+AK568U+b5JJtIQkop3LeEo290jjFlIWEh+Pcp7SRDxcQ2KKXwnbrr8U53CslXVhyveD2ObSUyxDI9/1aVN1HwYXIbdo0Pq5At81aw0zYNV41viYDm3XRgiXxpTKMi3Zp7nhxISKrw5weP0Rh/2VXaLwnbzEHeIlWn5ldxaieza+bMoh2GqEKnJnL8VXJXnoyL7lsAfYVIQbPEU6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vZAwGXdsCYkUGfdHES3miZFD0JFQo76AOC+RMrqH638=;
 b=W9BVdWervqQCcY3D+/xrZ5zOfF3zRjfWimyDwPKOtPh4mZgFEcX63twHgj10QH+KTKFvBmXOtTn8ikoIl+t6MbQzq76R/LjieQPSzd0Kvwbw+FSomPYZbA6sVWgPYA6UrrTiD9vb3H8AtGq5v1CjE/Pvgbr9oNepQX7rAllTSS8wu8JJmzfMOtyai9bOGeg2samSqtC+3h5Hd07DXN4bkx65mhdSgDF/LvzD6JBafszYjZXiHG9BVJFHz79BhWIXJSa7DzpWcE1A0tzirgbrAbj6NBs4LonwcLZl36kf8qpwiV3l4S5jQqxJHPb/EnsT6ukNqZlBWM+zoHMz/XczjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=bgdev.pl smtp.mailfrom=opensource.cirrus.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=opensource.cirrus.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZAwGXdsCYkUGfdHES3miZFD0JFQo76AOC+RMrqH638=;
 b=abXtOOyzWPjpSmYjfqE3uGQpWcM/yhXNlYPnrc7X7pVxu3obDdNfeyooDrU9ThutLTWTGvUx4mMD4b7J5Cl9/EKAuRO3+XMv6NsxrXBIufhQDOGY39Wve21dYwEAZG6vmccN/4Rc8F4C99/D2VWKWvEmxVEVCZ9tfqvnB7pAhI0=
Received: from BLAPR03CA0136.namprd03.prod.outlook.com (2603:10b6:208:32e::21)
 by DS3PR19MB9653.namprd19.prod.outlook.com (2603:10b6:8:2e3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 13:25:52 +0000
Received: from BL02EPF00021F6A.namprd02.prod.outlook.com
 (2603:10b6:208:32e:cafe::f7) by BLAPR03CA0136.outlook.office365.com
 (2603:10b6:208:32e::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Thu,
 20 Nov 2025 13:25:51 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BL02EPF00021F6A.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.9
 via Frontend Transport; Thu, 20 Nov 2025 13:25:51 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id CC4FB406547;
	Thu, 20 Nov 2025 13:25:50 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id B7CBB820247;
	Thu, 20 Nov 2025 13:25:50 +0000 (UTC)
Date: Thu, 20 Nov 2025 13:25:49 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>,
        Maciej Strozek <mstrozek@opensource.cirrus.com>,
        Andy Shevchenko <andy@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-sound@vger.kernel.org, patches@opensource.cirrus.com,
        linux-spi@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v7 1/9] software node: read the reference args via the
 fwnode API
Message-ID: <aR8W3aiwyw5we0qp@opensource.cirrus.com>
References: <20251120-reset-gpios-swnodes-v7-0-a100493a0f4b@linaro.org>
 <20251120-reset-gpios-swnodes-v7-1-a100493a0f4b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120-reset-gpios-swnodes-v7-1-a100493a0f4b@linaro.org>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6A:EE_|DS3PR19MB9653:EE_
X-MS-Office365-Filtering-Correlation-Id: 16f2cb19-4f3c-43be-60b7-08de283853a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|61400799027|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DrDnds+0yCRws1K1N6XLDKWU3qUe2P+uvYuXsE45KQfAWHfAN/o7SUsMsWYq?=
 =?us-ascii?Q?cPCYzb3yl2iZfCrn7AdyZmTxdJkwo2lTHB88ZOMiW9yh58nlh34tSIipOkzf?=
 =?us-ascii?Q?Y0zl13br9mj8Pb7VyiPEDiboq8XKGXp+94z+2ttMal7Lqs5HhAKi7lucjwTi?=
 =?us-ascii?Q?XLLBxXK3ljtIaz9WeG/y8ZXlSzHzCCkJKxZldZP/q3xytZVhsND/08qCOiEE?=
 =?us-ascii?Q?kFnbdEAGH6OCsDuO/QBNIGSyyJWtPmrIrNY3PY44kOSt2GyKNTDuceC4NMxE?=
 =?us-ascii?Q?71Xvb90uHqGHP2lihc0OAdNhwBDMlTUWd/mUGf9lLiVb0QmTtDPFQkgrTatr?=
 =?us-ascii?Q?p6b8Q2oYH/IASUM4MX1Z/vh3OON0uH38b8MXam+kQ5e4QbOXGFbSoSCjDIeW?=
 =?us-ascii?Q?SB95u/l0YHVfRA5iZFFkXU57yr7U/zylIRsNxMxmPvVaxt+a0FN34jBNkE6x?=
 =?us-ascii?Q?41/uF0XMQKCtTf8HgZXliVcIFxWC6eAPVTI818VjwMznOk/zqUAeK0nnWAoi?=
 =?us-ascii?Q?NHiOh/fKAwXNoQevDOnQMFLUa/jzMNlzi1B+wQ/nF8pMIx1YcjuYokegW3PX?=
 =?us-ascii?Q?mqmkZceL7Okr1EzSU2c+G+Cuu8bVB5flFBN2u+qoniMHidFAsQt1k0kOzb3f?=
 =?us-ascii?Q?es1/3gNlIBZF7jhYfXFgDQ5bbSPz7qgYp5H8SdgPTGpfzMY3HVctL8bzcfgz?=
 =?us-ascii?Q?lD2FTFGfUvvE9b3WGdjLmSzExdThWJ70gILrwB7H4Pm4JFksgUUoMMtiEKcf?=
 =?us-ascii?Q?5I1yPgQzXlbXWwEwD9ZWGEN6ASu7R2Q+ndA7EzxmII8O9i2nnovpSFZBz2FA?=
 =?us-ascii?Q?XgoWliS3ZLSwZenHYUi1oHqG/7y/p7zs9SBkLpBuUPxXHryskGDaWmlfSMu2?=
 =?us-ascii?Q?PPkRYOkMfIotUjytOHNcQhwTEvL5GC/Lw2SC1ZIpCnLc6CGoSCTzGD2/SWVF?=
 =?us-ascii?Q?POKhmsqkQiSuAyAnrbRnBeIPB/0S90+QEkAWpzm0NsWN4GraQlw3AmF4i6r8?=
 =?us-ascii?Q?WD/ITdqzuX/0bwh9xb20ZykZVu2vIJi0+y4sFS5y2MsnDgM0UZwyRRiw4Qzj?=
 =?us-ascii?Q?6SEY0tWsWGI2F/5aoDRd4bsrTsD/D6xcoYk/ZCjjKiRHotrRmBC8lvt3JQPJ?=
 =?us-ascii?Q?ipjXl5+C//p8yraBZpdwu9E7P1MqyUKTaTwWblmlxo9X4TtPqfVlZoDj0Uwg?=
 =?us-ascii?Q?+0kb425jlr/cUfUfsPe31NU78WGdoSBwdXZmV2671rhbPq3AAYFepnzAGZOn?=
 =?us-ascii?Q?bqB6MTbrLY2vGfzE+Qqfyyha74Tj/25qhd30pEHdJEBfe4489idozp4sgGwd?=
 =?us-ascii?Q?ejzEuCV85wrbI6IkQCg+ga4Rxuz72WIAOMCCpBdxF32U5sYJ+UCG2+yIN34t?=
 =?us-ascii?Q?2CU3tYYN8BQlHYApCKY9SmHXI7LDfkI4LCfsYK1R71iDX/Ul+zA1PGy2CYD4?=
 =?us-ascii?Q?zjVAqTkFOYf9kjKW2ZjwfOv3UAn9/sSlVrXO9MjOL6uCFjqYp45wCrLPJz7J?=
 =?us-ascii?Q?+J23PcTCVk5tC596zYtHwYn8iqCbYqDaKHsT6aYioxvN0mERHQNE3q003uyI?=
 =?us-ascii?Q?l8sVCp3ej+h6OShoaws=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(61400799027)(36860700013)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 13:25:51.7705
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16f2cb19-4f3c-43be-60b7-08de283853a5
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BL02EPF00021F6A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR19MB9653
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIwMDA4NiBTYWx0ZWRfX6C5rYLH79vS8
 UC9kOj4y8HSGq1lbwElmWVCkaJwP2h0B8bBGexJ9khxBmD7IGA9bUfcRr0aekFpRRg0RnluDFtd
 s1B8Htuk+ENRiZgmB9uAQ5DqmzUT0HJgdFo8LeGQSd52DE9YEw90ztN6QBCwbx/BCyx7S+f98mT
 cDL5+TchrAvAhpnrtpsZIA8x4GukToIhPs+3TIP+QF0GVd9Q2ck0sFL0jko25SbUk/mZJCjysQo
 6856T+T/O9L0V1tCOWXXa3EMtlKT+csJheq/ZtuIPFKUYjait1igpnJKGN0vqKP4eHzd/usp1X0
 o0UD/Wu8fYoxIcvRMsRV3qjTLFryoK21NhNQTEczhPQVBCPricaffPasK/ncZuYriFNm3wvOQ16
 33Ykk5r6pXtd2mwk3yyk60vZ9zbsxw==
X-Authority-Analysis: v=2.4 cv=XcmEDY55 c=1 sm=1 tr=0 ts=691f16e3 cx=c_pps
 a=maKVojGk/Z2FVbpuIp3OdA==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=QyXUC8HyAAAA:8 a=ag1SF4gXAAAA:8
 a=w1d2syhTAAAA:8 a=g-cmFo-BY5rwPZxGFUUA:9 a=CjuIK1q_8ugA:10
 a=cvBusfyB2V15izCimMoJ:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-GUID: PQCyZojZbFe-RC2u8PHOIBGHXEstu1JO
X-Proofpoint-ORIG-GUID: PQCyZojZbFe-RC2u8PHOIBGHXEstu1JO
X-Proofpoint-Spam-Reason: safe

On Thu, Nov 20, 2025 at 02:23:56PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Once we allow software nodes to reference all kinds of firmware nodes,
> the refnode here will no longer necessarily be a software node so read
> its proprties going through its fwnode implementation.
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles

