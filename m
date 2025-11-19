Return-Path: <linux-spi+bounces-11296-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2687CC6DDAB
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 10:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E446C3435BD
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 09:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9100D345CB9;
	Wed, 19 Nov 2025 09:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="d6t4c6YE";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="SGjYQ3Bd"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78593446D9;
	Wed, 19 Nov 2025 09:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763546310; cv=fail; b=X7cA8OWtzkO7I79sO8M22ovL6XP41WfHSLueRhVn9LsRm+E4+1Xy3PGzO1fEvY8F7zM7dQgxdffX/pU/JR+m6PZZzaOJGGG0q36LdIfJvD3jetfziDcxnV/yhioRL53EvcUHS50uec3ayli2olEcUrjPcSZucRDln2dZCmUVLqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763546310; c=relaxed/simple;
	bh=Qu7NKxbQwzNMe93UblWi+OWYCRnznqhQ+a0OmqKlhr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nSIjYhBA67+4xIlvEdUDWamFImlSgTNSklfs3GJt5pEXG5Q2B8DJYMbqKzCR8KceUBsS1OfVp98Kg9SAIAGN+a8kSLKg9Rk13nauJJReUGFhhw25u94BpUsZhqUll6nGIFyyp/SmaPE4I59VAz0BBNmLk9+7zuQxBZSkRlATunQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=d6t4c6YE; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=SGjYQ3Bd; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AJ6MD7T2221820;
	Wed, 19 Nov 2025 03:58:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=K490tYj3nJQUuhAQwmrQeqYRaf09gsAnzfbyov4m6qA=; b=
	d6t4c6YE27Ze8dfgZsRzEMz+enyKmVTk99QWKbsLYte7+hgmaVAIFs7I8uiF7qG4
	onoHQYo1slYcsIs1/iINbi7mLEahiz3oS9yiLI/Q+oFgz5lXRvn7g0Ju8M1Pg3C8
	lGdiHEQ333xrieV9IzqBG0thpE1IkPeUCbQNeHFhpB6Mk0q5yNzEhAzTt0WM0avD
	QcIGTDRVKTuCtNAkK9sbUHPE59G1WV9+PPGc8XR7iF1E5AihbI6mbXtLucHsalDg
	rbm3cvoteo3TgJMWWr9UjmKATkrRW6bZK6J+MdWl245zfKMBiuTt3J8G4HNIlqrm
	LJdn40htjWpAfCMjaluC/g==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11022075.outbound.protection.outlook.com [52.101.43.75])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4ah1bm8ntp-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 19 Nov 2025 03:58:04 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P3srJND8GwgTPuRfBHC1IHhQXeF/vpGKA3k8LcfEZjGPDjhEIUmhgmwVQYlrafXnBSYX+7n1QdMEGB0i431gH9jGFhanilkkqqusvvBXqriUShZT48dA6xQZ6Cyuy7uIezB91fQBMqunfm9gEX/DQk/iYW1o3CfXGVffrLUDJticpJmNBsDExiqM20z1mqPMMfsC1/FIqqP8rf1aTK794Gt+0UcVXQAACBBS8MtqQzcsKJLMlPf/kezh9InrM8v/d4tvn1axjrn/8ny+HdX4sbx3szN49GPrpnG45icIVQC1CFIO1tMOyhJnNK3GWVIMPaTwJvf2wytrv08cVSre5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K490tYj3nJQUuhAQwmrQeqYRaf09gsAnzfbyov4m6qA=;
 b=i/Zx0Yjiy1G+fKW/0SIyDq7E6Tjkz5n5foqP0a3rTnFDwE5H5g4MGfWOcOYsG4T0iyIYr4Su1EAIw9o4qgNGmx+vEqnFajRr/XwmmEWUax7sKm9GQI+ENNxv21IgV5Z4YGiQ6fBSWjUlqtNWnYS5zNL3k3JUE8K8Km+PHz33iKBHQ0VNvViT7ttvpfAXBo51RYRfi9DMgSNmTbfsSMB7ZtnrNArMId2GrEMvahW6jv71GhtLXKMe92sIMkQpjKYTQumBTdEkAJCIlZRsT+/L872C4UGpN1aka94oECsdC32bwJy4TTrRPjJRa5c08s6YORN5q/yGVhMgr9Gy9bxwzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=bgdev.pl smtp.mailfrom=opensource.cirrus.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=opensource.cirrus.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K490tYj3nJQUuhAQwmrQeqYRaf09gsAnzfbyov4m6qA=;
 b=SGjYQ3BdZMPmGNqQ67Hgow0c6xAaURP1IcKumPy7OagThfjdE7KbBjX/rY10CKF1hfM2hiTQTthJOE/B4nT+XSthPENJa3Tc2WmXJFkCkbtlS7mMrLyH7HPXLH+ik9M5xULgTz0j74AjFQpR3oGIwZ5Hja4rXP8XM9o93Ep27s8=
Received: from SJ0PR05CA0015.namprd05.prod.outlook.com (2603:10b6:a03:33b::20)
 by CY5PR19MB6448.namprd19.prod.outlook.com (2603:10b6:930:3c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 09:57:58 +0000
Received: from SJ1PEPF00002326.namprd03.prod.outlook.com
 (2603:10b6:a03:33b:cafe::2c) by SJ0PR05CA0015.outlook.office365.com
 (2603:10b6:a03:33b::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Wed,
 19 Nov 2025 09:57:48 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SJ1PEPF00002326.mail.protection.outlook.com (10.167.242.89) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.9
 via Frontend Transport; Wed, 19 Nov 2025 09:57:57 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 4C4B5406547;
	Wed, 19 Nov 2025 09:57:56 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 3177D820247;
	Wed, 19 Nov 2025 09:57:56 +0000 (UTC)
Date: Wed, 19 Nov 2025 09:57:55 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Lee Jones <lee@kernel.org>, Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Maciej Strozek <mstrozek@opensource.cirrus.com>,
        Andy Shevchenko <andy@kernel.org>, linux-sound@vger.kernel.org,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH RFT/RFC] mfd: cs42l43: setup true links with software
 nodes
Message-ID: <aR2Uo++k1NKkk2sj@opensource.cirrus.com>
References: <20251119-cs42l43-gpio-swnodes-v1-1-25996afebd97@linaro.org>
 <aR2OU4se7lxcMtGW@opensource.cirrus.com>
 <CAMRc=Mc==X3wERStdXmr5A9p0sPe7wdrPE4GZuqPLaKoBb9O9w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Mc==X3wERStdXmr5A9p0sPe7wdrPE4GZuqPLaKoBb9O9w@mail.gmail.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002326:EE_|CY5PR19MB6448:EE_
X-MS-Office365-Filtering-Correlation-Id: 47d95187-e596-4cbc-36e7-08de27521e32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|61400799027|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dk1OZmpNaURZSVdxVmVvRm54aEczc0M4UGxWUWllM1JOVldVOFliM0NFSG9L?=
 =?utf-8?B?elJuSTUzMllheXRvL2todnVjVjBadjM5ekhsbDZrWUJqWXRacktSY1ZuNGhW?=
 =?utf-8?B?MU1Fb0pBM0JoUkFJOFFvSUs4NGZEL2FMQ2JORUNiMENTcHFsMXA4ZE13R0g0?=
 =?utf-8?B?TDYyNHRmbGlnT1JhMEpNT0o3T3hGVGVKckJpMHR2V05kekcyTzJEekhwL3ZM?=
 =?utf-8?B?Vk5YbTBGZ3IwYjBSeHphNE0rZ2pkc3YvSHdNeFRsN0lQcTVmYmNQU3Y3VzJt?=
 =?utf-8?B?aE94MjB0NFQyQzV5VkhEb0RoNjNmVjkwMHVOWjZRd0JtR0JEeHloZU85a0tY?=
 =?utf-8?B?WE5lV0hZRUp4dGo1MUZyaWtDak5NZ2VUemgvbHFxektKeFNnRnNJWTcrd0VK?=
 =?utf-8?B?ZlhTUjhrOFIwSi9lU1NmRDZpSTdMZEVYQmZUKzRTS2t5NkR5eWhFVjZCTnha?=
 =?utf-8?B?UndybWxEdHg1VjNSSTBBNGJKZXpvWGZ2ZElEbUtRVW5pLzQvVy9KZzNSRlJk?=
 =?utf-8?B?TFpPb1JNZG9RVW1xWmp2UUdLWHRZdnEvR0YzTUc1K21aMk1wcVRFRFJLcDhk?=
 =?utf-8?B?clM2LytKUGhJcXBQZXJGU1I1c1pUcmp2SzdZVU5sTWQ0N1c2ZEE4dHh2elBE?=
 =?utf-8?B?d0ZrLzFJemwwaGNqRkNTb0Mra1lXRWo2cVZXRzArQmxWZ3lTQlZZL2Z1WlBt?=
 =?utf-8?B?cldWR2E0RWI1dS9vTnR1cDVZZ0JrQUE1TEt1VEl0WVZZMlhCTXNaWllTQjV3?=
 =?utf-8?B?SDU5YnhlYitKZlNWM1h5MjA5WXVBRE1jS2pNTjZYemhhVzRiWTJoK08wcDNo?=
 =?utf-8?B?cVZzN2NVOVNlWlYyUHV2dnN0K1c5T1RWdCtwbmw5SEpmQVI4Y20rUDg1eitW?=
 =?utf-8?B?SmI0emt2ZGZJeE9vaGVPTDRVMWpaeTVhY24xdVhwZ29ZZ28zbW5vbFpTbmwv?=
 =?utf-8?B?R2xvL0s1RnVXR1hWMEU2T2NYQ3BCTlNoVEFyL3JicDdKbVZ2WTZ3TnVCQzY5?=
 =?utf-8?B?a2phT2hQREdlbm1FcUhvUVhjSVdnTHJmTGJXZ0ozcVpHWlA0VHFiTnB5aTcv?=
 =?utf-8?B?eHZ1Q2N3NFFLV1RyakdmVmZsS3ZOWlNjcVh6WVp3N2NSUDhwM3NWVGxJVWh4?=
 =?utf-8?B?L05laGNsZEdGNnlWcml0U0V6Wm0zcGZITHBXbjN2Rjg2MFQ0dFBHNi80MlNx?=
 =?utf-8?B?ajlmMmxkWnZZZ2FnZjNyb1pLRUpmblVtWXc3V1JqeDZhWVVhRXE2ZTMrck9O?=
 =?utf-8?B?dGZjWUs5UitNdTQ5dnJmN05iYUhRZWgzRzRiV3M4NDdnWXVrMjVrUHY2Yy9w?=
 =?utf-8?B?aVl6c013bnV4NENmRzhKWmgxcFMwbWNLVkg3Uk14S1p5RU81TEFHNkJqS3dH?=
 =?utf-8?B?REppOXN4cnMxelZrMnZ5SVB4N3dydjF0d01wekZCUjRnZ1FPVmRHZU5CWm9p?=
 =?utf-8?B?NlpIejBZbGdITndCVVpSVnhsQ3QrZWErTGRET1FRNDdTKzN2TjJ6RGc2ckFF?=
 =?utf-8?B?U1FBdVoyVHMrck41aE5xUDdJd0c5Wk9rNnQxRUh2bWt3ajZwbHF2dUY0TGxm?=
 =?utf-8?B?VWdzK0ZKdGxZYzk4bU8yWTM2bEI3OEFhc0dqWWh5b3lXclMva01oZEsyL2Nm?=
 =?utf-8?B?eVFnd05mYnRDdXdOWDFKQlV4RVo1Y25LREd0NVZ1Qlh4OFF4YitsTytlNEc5?=
 =?utf-8?B?aHRLK2pHdGk0eGtVUjdBdTYrRytKa1JHQTV6amo3ZXZhWWpJSU9oamxIQm81?=
 =?utf-8?B?bW1vYXFqU1lFZ0JqY0o1RmdKMzdRZ3lxcTlIYW1sRTY4OWFwNlJGK2NQUmE4?=
 =?utf-8?B?UkFiTmVHQVNrc25VbjNVSWZYQ1NXZjdoMHljOWlvK1hSMW5xdUNad0RFL0JU?=
 =?utf-8?B?KzIrZGtHTUQzemtUUUxVQmo1c0daVE1pTlIzMkhIWmx6aXBseG1DVFB2ZU9z?=
 =?utf-8?B?dHppNHh4K2hpeXJoeUVrNGdQMjh3NlZsN2xNNGlnMWo4RnFyQzlvRHYwUUZF?=
 =?utf-8?B?SkFRTHcvTXh2TUxvcTYzazZjMk0xK0QyRFNleEFwcEo1TFVxSkFsR2crOEdT?=
 =?utf-8?B?L1ZLbjI0eUNyMTl1RHZSRTdTMDVYT2FwS1ZPTXpLZ1VySW4xR1FHZmlNVG5s?=
 =?utf-8?Q?7eP4=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(61400799027)(36860700013)(13003099007);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 09:57:57.7196
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47d95187-e596-4cbc-36e7-08de27521e32
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SJ1PEPF00002326.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR19MB6448
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE5MDA3OCBTYWx0ZWRfX6qO1VadS6LGc
 CO9uagSEafD7F9AWhxsckLpCgQ1YdR9ykO0xTX03hDRvAZertzlp/t0P792mNLm0OtcJGfKpi52
 4l9xHTsI+vVxe/Frmcucj0LSJOnmVAqgLwAdkfxPIGVBk2j2K16voGKdexx+eYHNeSK0/6jrzLQ
 jKrOfPaOq7AA2refPeZYModnOdqIhome3H/H/9Qc64iyhkHURaNnr3EaJFqJNHFQnkpSAK0wFJh
 80o+w6bkd6wAFH9cNrKwFvT+D0H6SwzrAEsBKfddeDVcPz+uO8PjxnR5hErGa3HcBIDX40agkv/
 jCP1fqVdFvwRyxyVDZPgTZltPMDQO/jJtYqPqZxJzgHvaxer0e6UIXjc71HLkfR8lpnt7A61pbQ
 B4rJaAKGs2W1yzl16bUVnuF86HLAJg==
X-Authority-Analysis: v=2.4 cv=XcmEDY55 c=1 sm=1 tr=0 ts=691d94ac cx=c_pps
 a=7tpojskyxclYbGypRN9vEg==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=w1d2syhTAAAA:8 a=KKAkSRfTAAAA:8
 a=LFQ0T4mkaSZdwojkS70A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 3lwmXv5Gz7wLprdRtbMjJJKXlkg8hwa2
X-Proofpoint-ORIG-GUID: 3lwmXv5Gz7wLprdRtbMjJJKXlkg8hwa2
X-Proofpoint-Spam-Reason: safe

On Wed, Nov 19, 2025 at 10:40:30AM +0100, Bartosz Golaszewski wrote:
> On Wed, Nov 19, 2025 at 10:31 AM Charles Keepax
> <ckeepax@opensource.cirrus.com> wrote:
> >
> > On Wed, Nov 19, 2025 at 10:10:24AM +0100, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > Currently the SPI driver sets up a software node rerefencing the GPIO
> > > controller exposing the chip-select GPIO but this node never gets
> > > attached to the actual GPIO provider. The lookup uses the weird way GPIO
> > > core performs the software node lookup by the swnode's name. We want to
> > > switch to a true firmware node lookup so the actual link must exist.
> > > Move the configuration to the MFD core and connect the SPI and pinctrl
> > > sub-devices with software node references.
> > >
> > > Fixes: 439fbc97502a ("spi: cs42l43: Add bridged cs35l56 amplifiers")
> > > Reported-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> > > Closes: https://lore.kernel.org/all/aRyf7qDdHKABppP8@opensource.cirrus.com/
> > > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > ---
> > > Hi Charles!
> > >
> > > Please give this a try. It's only build-tested so far. I hope I
> > > understood correctly that it's the SPI driver that needs the "cs" GPIO
> > > from the pinctrl.
> >
> > Unfortunately it fails with an -EBUSY on adding the MFD children.
> > I will investigate a little more and report back.
> 
> Does it fail in device_add_software_node() in MFD core? Is it possible
> that the device already has a software node for some reason?

Yeah it seems there is already a software node, although somewhat
at a loss as to why, the only ones we add are inside the SPI
driver. I will poke further and see if I can find out how it
acquires that node.

> > > +static const struct software_node cs42l43_gpiochip_swnode = {
> > > +     .name = "cs42l43-pinctrl",
> > > +};
> > > +
> > > +static const struct property_entry cs42l43_cs_props[] = {
> > > +     PROPERTY_ENTRY_GPIO("cs-gpios", &cs42l43_gpiochip_swnode, 0, GPIO_ACTIVE_LOW),
> > > +     { }
> > > +};
> >
> > This drops the undefined node, that is important as it lets the
> > SPI core know that device is using an internal chip select rather
> > than a GPIO.
> 
> I really dislike the whole concept of this undefined software node.
> This driver is literally the only user and I'd love to just get rid of
> it. HOW exactly does it let the driver know to use internal chip
> select? Can we do it differently?

The SPI code lives in spi_get_gpio_descs(). The basic gist is
it will use a native chip select if the gpiod_get_index return
NULL. The system came from device tree (see Documentation
spi-controller.yaml) initially, then I added an analogue to
swnodes a while back in 9d50f95bc0d5 ("gpio: swnode: Add
ability to specify native chip selects for SPI").  I have no
great attachment to this way of doing it, however, it does
seem logical to me that the system is at least fairly similar
between the different firmware types.

Thanks,
Charles

