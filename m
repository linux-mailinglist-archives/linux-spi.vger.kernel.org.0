Return-Path: <linux-spi+bounces-11409-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C95C74463
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 14:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1729734429A
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 13:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E3233C19E;
	Thu, 20 Nov 2025 13:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Ma2Ip1db";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="Kti8rfqQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BA033C194;
	Thu, 20 Nov 2025 13:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763645208; cv=fail; b=knolEYczgQ1X3SdLny7tTeEgNlurJ5gCNDq20NDlotR9P2fDKxWKkAhnRkNLPgwQh+JrMFTs+3INErozU58z/JJCuGv6nDSVEOwJvxLRt/NGVvMPhkgaisREcgf9o8KGDsota3FoL1IhlmuEUw3KzeT9vWGXkISaFQJC4VZoIeg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763645208; c=relaxed/simple;
	bh=PkN3zRVA089B4G8hAjEPhFWY6+uTeZW2OqDT282uTXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OoeklMezeZNfcKrJ1q2S9j1XU8de6lNj1/ovIL7bC9kWhnQ5Bf5A1AT8BNFFq5GLlIRYO5FfNGODdiQq16Zg85TBIApXBC9WVRRdfQRP2CH/VwkrgMeLaofdQuJ9suAD3z46Iz6TUejNufBLeIVPcyg5HqK7Cz0VXTSxstx2w4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=Ma2Ip1db; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=Kti8rfqQ; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AK4kGrF255784;
	Thu, 20 Nov 2025 07:26:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=6qS1RvqijmvxtqdLog
	67Auh0gidu4m3NosyhIpT8TSQ=; b=Ma2Ip1dboOto48nU0tcLiWI++pxU5JUsW5
	uAPloIj+p3sLJlNhndW91gcf9bS8FpSJBBwqTl0S6S3sTnyFMKhMqCXmvKoe4YNk
	oNtA08uxu+C6wyIOh7N2D+hdZ93r/gkI1TgNv660QuH9VZ7HKRWNXAvDqcCRX3Gr
	8J9cS83OeHFKmu9ENb2F/dvKxiJLyA0PvzUtQ8jh3gdoexrvLvE+967H44YYFDvS
	OqEH+3GDH45foHWKIBmqWBikkP4cMp401q7ShrFO9cE2SoDKILPt//seOlqvEQ1+
	565mkfnSY4HRkqpA6cWwazkGi8jEvUjp+gGpnNeu+RML6Yq3V+ag==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11022088.outbound.protection.outlook.com [52.101.53.88])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4ah1bmaeb1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 20 Nov 2025 07:26:37 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LY76BoW66h7s0XPsXAjSLrdtP8FXOo+xlvlFbl3a5lW9cWi7xOnRxTzj/DnonS6yaykTi5VSP0NX42J0OadoNqzwB+aGDBiOjRsa2Yvbscf+4tA2NBCqXPylSQlOidBYj5YilTE0mmb1UEmnk6vKNys5A2zIWst78abwp4Ou1TeC46CU63MJzHy8vCBjxWclZePMjBdmhAGxPVekNM/mECl79yWnsuClk1/wEnD4Yt8xCBLe6ldQQwspUJod6hdIZZosmT5towZOpLl0+diTxrwbxxwiuiORswcCCRwgX9N0qPIUTPllqmvtDa6KunT5i4bSIkJ4QSArBi+d7et8tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6qS1RvqijmvxtqdLog67Auh0gidu4m3NosyhIpT8TSQ=;
 b=m7USfpE8qdX+5ojECVxVN9MoHzeyxPFuQ1BKjlrh8XosMIoOJbLtGxrK9owKWlm8Hp0+81k/PShnrl0HTHAfIQZ0FIDy1LUWXT9tBeum9TTPO/YHVisygSfW9g9kzFXFRk6cU1hzsVAc0OU5igIjHJIAbVIxm4yORp0OqQW/Q/8yJuNUp8xyyWQbboscZfTr0s/QAzjL+lOgzryvIfV4H2ChgCQnTWZ0vMnwZquXQ/4ozCAc1hvFVXbmJkssa4i5IFjL/Rv+emWSmSA5KuB4nNALL7iItQFDThm6PDTapoT1Tk8NKQBcssKacdE7+Oy/eXryI6OlFAWNcYbAImqRjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=bgdev.pl smtp.mailfrom=opensource.cirrus.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=opensource.cirrus.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6qS1RvqijmvxtqdLog67Auh0gidu4m3NosyhIpT8TSQ=;
 b=Kti8rfqQ/8COKA7RHChfiXUPDgkQBf/Ipv9Cs1a65Dhi7m66PD6f5l/+2M0U1DCFGt2FYDEt/SYuFQW3lBl/dmj5cFmdEvWQOylQJWFR/jhDl4trEF0xl8vJnRl7h2/s86vzsi9grSR3RYHK6IruQK8goH28/0vhp0gRd9ZiYlU=
Received: from DS7PR03CA0182.namprd03.prod.outlook.com (2603:10b6:5:3b6::7) by
 BN5PR19MB8966.namprd19.prod.outlook.com (2603:10b6:408:2ac::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 13:26:34 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:5:3b6:cafe::d0) by DS7PR03CA0182.outlook.office365.com
 (2603:10b6:5:3b6::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.19 via Frontend Transport; Thu,
 20 Nov 2025 13:26:34 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.9
 via Frontend Transport; Thu, 20 Nov 2025 13:26:33 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 2DE1340654B;
	Thu, 20 Nov 2025 13:26:32 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 1BC7A820247;
	Thu, 20 Nov 2025 13:26:32 +0000 (UTC)
Date: Thu, 20 Nov 2025 13:26:31 +0000
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
Subject: Re: [PATCH v7 2/9] software node: increase the reference of the
 swnode by its fwnode
Message-ID: <aR8XByQn/4NGtTS0@opensource.cirrus.com>
References: <20251120-reset-gpios-swnodes-v7-0-a100493a0f4b@linaro.org>
 <20251120-reset-gpios-swnodes-v7-2-a100493a0f4b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120-reset-gpios-swnodes-v7-2-a100493a0f4b@linaro.org>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|BN5PR19MB8966:EE_
X-MS-Office365-Filtering-Correlation-Id: aabf7069-e95b-43db-69a9-08de28386c74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|61400799027|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?R35ACaszr14NGl5I7ezH6LDyvoejOxMD4sk3GIgYsxqdejoWWtX3nnCvUTnC?=
 =?us-ascii?Q?zrY6zrWb11wNuJQ4bzKFUD3col3HUjCs3Uh9AFhlmM21b67DgWvEmZtJzhzF?=
 =?us-ascii?Q?HRFBCiHqRwfm/QJLRs3cwdf0m+HeO0tabnLS3qOQNcJUY+eSHcBfAX6gM2xJ?=
 =?us-ascii?Q?63/VQ94SP+lPupZcBDMlz3rlEUmXQA3BPFFUyPRfFyhoj/P+iluuXxk1RpTO?=
 =?us-ascii?Q?cAE1jqXi5i3p7OTV65ZgHDGwJtBDKN+wSTgF8jncGhTzHK5Nzj0Au1B2FATy?=
 =?us-ascii?Q?ejYjdpw2Q3YqiS1QsFwwPY1S2Js7Urb0NN8NxyFakh5zTv2GG/2O7h4w7Fkq?=
 =?us-ascii?Q?D7gjpp+nRmWXHPn6YP+F1ZKkysVxwCFi6ko5iA1VYdbLhalW76RFd/ciO9kN?=
 =?us-ascii?Q?wICEMV3r6aueRMeKU6nzHSFveJWmb5jnlPGgwTeg7KvOgw8bKVpBWSCbxobJ?=
 =?us-ascii?Q?YFVejHEqSbtl3ONg0HtuxKiniE0uHY0PKNIz5jHYyjCHeSsrsA/aG7vgp06d?=
 =?us-ascii?Q?fY8vDC0rzLvhDN5WHgSRRT8JZWVb0C4A3U/yWvPfMYKrPU6OyEZ9+UV4IkuK?=
 =?us-ascii?Q?xGcd6M5X1Ta2J70i187fB16G3RtekFX8CQWF1SFlYAAbS3/whwIAVKJJc0A2?=
 =?us-ascii?Q?a58r9sVYyhQV/4nhc8jnIbE0hh1557cn71De6YxfjZSTJw/g9LP6SQmcyyaa?=
 =?us-ascii?Q?J4u7ngKC/OoqD4Pvy8D8g7UB02+A+cM+a1lmeYTHZAv6JYx6w8IWnQimsuqA?=
 =?us-ascii?Q?CEaawb+XiFJJmyzHcx/shXf25RzBhq2C6YfN7zXeDJ6oMI6VpuNVcFFcyEV7?=
 =?us-ascii?Q?WmQiZA9OI8iCikIT2fiqAAyi9Uy78TGYIGQJ//s/EvTZAWSXrHAWMDptGZh8?=
 =?us-ascii?Q?Zr0gxTNEa0CjHQMVfDyD0nKPyG+pKlbOlxbaaGrB2Wu+/77ZT3X+wWr75dk1?=
 =?us-ascii?Q?/N1a8D93Ur+kwxtRV5IsgiwwqKkDjqTnYRi4X9ChymiU5zd0rX+waPwf7HR2?=
 =?us-ascii?Q?VuIAQa+wzW4p1rk/29cM30qdFQhhT7DCC6Xi+ly6+YXWCUmQy22Jmtv76A+T?=
 =?us-ascii?Q?dOoCeMdhsaRjqv04V9jIb4Zu7GiqHjDRAds/smFnhLEY44pXSF/YZO968/Nq?=
 =?us-ascii?Q?J2W7cG9KjwjTI+y/wYFtxYzbiNOVu3KaTr9HJDukXgQJh3t8uKHwQ1Qc3oF2?=
 =?us-ascii?Q?9NtBTKMik6NY8d+nF66I51g4axprkC1MGrNqQ2z47nlgAxgKzxNOLTRzzKiU?=
 =?us-ascii?Q?GQonTovyNnZvhJf4fmXVLpWAGdPfQL5nasgKWQLqolGiqRv+GG5of47xhdto?=
 =?us-ascii?Q?lZXnbIfwd6vXhD0P0B4YI3o4PQvRMzh4Lb4OjHw2zwMY4HgWiUFnZuL9hB5p?=
 =?us-ascii?Q?4l8RG3cDy775v4rTlz86cfVhz1tKVziSi+2rrSzsbbErg0KR0RbEyV+AANdp?=
 =?us-ascii?Q?1TsB6DCXt/MMhnaGf1Tn9T6mO69PZeq/Ez7dmmqpiRDz/qm8ozanY+DtQb+d?=
 =?us-ascii?Q?48UEYmeVnbvWGC8hcdAIdF0+uoJEUvCjAAwxv8sVLzKdIghSqfJmb07G5a+v?=
 =?us-ascii?Q?Ccl6UrHdNcTk5Prtyl0=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(61400799027)(376014)(7416014);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 13:26:33.3409
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aabf7069-e95b-43db-69a9-08de28386c74
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR19MB8966
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIwMDA4NiBTYWx0ZWRfXxZexG06pJPzd
 MJfiGLbDDPdWnh1WpvpEwRA0fH0tityHpSsWGSLvai05zpJgnTPI/gvFzVM5vdn+H4eZVc1KlGy
 gtpNqRTnblIZmHD+urrQIpAuNR2Xnv3jo6krWp83UEx6HqOC4lHbu+JJBKa9G8PCFrRvgvoz/g0
 WqF3ilDy4ZYFisTgGZVXtKrMkAGtGIKIfcjMAKDHv5vQqutYwXzlV7bZJA1NlInK6ki8yaiH0EN
 zu+PRYaNFVaDyq4rCq0pQv4zOKg13MLm02imacdpxOQgZvOjjqOADrnNrIKUXVpzZ4X24QZlcVI
 g5wEsSajlHdv6N646qf6FDOX2jqS7RHPaPRJ+cgS7hII7t5BGc0tLThElZ2/PhOpIhKIF6O6MUn
 zziBmAH2R/xSsz4sVttPBX8MdV6o/A==
X-Authority-Analysis: v=2.4 cv=XcmEDY55 c=1 sm=1 tr=0 ts=691f170d cx=c_pps
 a=Iwbv4f4Sj7MVFDRstb1XxQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=qKFBXPNsJB8zkw07:21 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10
 a=RWc_ulEos4gA:10 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=QyXUC8HyAAAA:8
 a=ag1SF4gXAAAA:8 a=w1d2syhTAAAA:8 a=X6cyTtrVTogoTExxKzsA:9 a=CjuIK1q_8ugA:10
 a=cvBusfyB2V15izCimMoJ:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-GUID: PP9CNXxgqoL-JRiwCzDg_vmoymA-DEff
X-Proofpoint-ORIG-GUID: PP9CNXxgqoL-JRiwCzDg_vmoymA-DEff
X-Proofpoint-Spam-Reason: safe

On Thu, Nov 20, 2025 at 02:23:57PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Once we allow software nodes to reference other kinds of firmware nodes,
> the node in args will no longer necessarily be a software node so bump
> its reference count using its fwnode interface.
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Tested-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles

