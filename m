Return-Path: <linux-spi+bounces-11411-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 076E4C7454D
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 14:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0C4404F1F44
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 13:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCAB6340DB0;
	Thu, 20 Nov 2025 13:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="IH5lbwj7";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="S5gkYQXh"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F1C340A74;
	Thu, 20 Nov 2025 13:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763645259; cv=fail; b=aKfYjbDzL/l6g+mCKD5jAdCerWcs5HQdU7BrEljZMmgdyqrTa5KnPzb1iBgL0U/X1RHTWOmQwsfhSeeJrAR5ZEDT1QJN+LWa71PP1Sun5oGetQrlLfkUsT/1kN70aQgaYTVoNdhVvpu4nMPBmwt9srXEHwKHMxDxuzhsu33Th78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763645259; c=relaxed/simple;
	bh=i5KSUvNTy68VOqn3dLIiICuHqOy6plV4iUxa4NDeqQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qjdzDAIVdh/C3jr9xT/VES0yvKTBF8zLQnPU/L/buAc5SlR4p873ZxmxqMHl2sHjxlpZdyCgpEQOiTBVlZpV7hL07YJ8VMsF/kvVtmMhZioANj42szsImepYHkCwEhP8LFFW6vOqJEa25gI1NZs/EImEqex8Z9dinIOtSxjMswI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=IH5lbwj7; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=S5gkYQXh; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AK5Kma7311678;
	Thu, 20 Nov 2025 07:27:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=eWkatb4ucG846PyAfI
	cW1cTxsBDSXKYUMZkUCCVVvPA=; b=IH5lbwj7BRV4/A23PcNC5h9COTOu67R0Yp
	AIXa7XCgth41YqjcZqNh3tCiB2IYqS7KkCYpX6eq6xv8+MX1GKB2EMK4UDomPT/l
	i1oCOX3IQzgOyvK2i70dyyufAVxEh+k2v6Zb6WSX8KCR8bORrIO/4fCIn3xdoQV9
	/sMlQ8SetFFbmjMMFmZ7M7JApXrGEDEtvASXFmLBIOr7UELcolFVJDp4j82VkGb7
	nmdNHvEHyYGcLIA3NUhWLJy37+rTbokUvfBxeAJ7skkPvc9/kK5aAzN8YBuVsTe6
	qbZB+BMiN0jMiEdEzv5oEhJCL3QLAM4V+i5/No+nwsrQ9Kl1u6tg==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11021114.outbound.protection.outlook.com [52.101.52.114])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4ah1bmaec5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 20 Nov 2025 07:27:22 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X/5jEQbNpgLeC6syvQeSD3WTIzTpweVXVBa9QkOvPQKVequXwCrPtKHauiTAs9wZkYiLS95J6wW0c1JKwOBfjyl3elXnHQEg8XCwCrxxmde9s9X3pyE1yHXB+FA3lhiCU+iRtX4bwfR30w2AKMQBcnAI4JnELvy64saiVdh77y/wPeNRiBnL9hL5KqSaI/XuMNOU9Myc8HioR6MPfk7aDB7NKxSfamoNhLxzghP3v8jwC9ia3WBBMr3e5uBCzOuupWknmZ66OarZP86UQeo/quLCwZLpqCMdjcv0ttVDKxlouDHWpW86k723xHPgmAbFuctO5StMit53WNe+O9s41g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eWkatb4ucG846PyAfIcW1cTxsBDSXKYUMZkUCCVVvPA=;
 b=eY6O+v+PX3pA/NtEdHEx7YP4bJHKoERb2bop1YMcmW5HXlUOpAkBrZP4LrOD99kieAmDwvVv1cu4tGKpjwAHUaYgfGqmYtG2KSrequatdIoWKdcqdJqgzEPlEur18/nQmgU7G4Oxc9JKtUjiOI+l3hHS4bxeodVZoYdHiQbm3cImFjCI3L6i5wdroxvp9YQHw7jlNb0WYpTn3NhcG8VRK+JhutrMmZJ9eXPWGFE+uthKdl8rhS7YSqVRv4m+xiAtZybgd9k140nAhjzDeW/F6eIiVnrTgauuxhU4JjRRoW5hYiXi9F7WM8GEmX4PodWyCQqQO1NShE2NPSaDLU2tLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=bgdev.pl smtp.mailfrom=opensource.cirrus.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=opensource.cirrus.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eWkatb4ucG846PyAfIcW1cTxsBDSXKYUMZkUCCVVvPA=;
 b=S5gkYQXh1sCQGfTDur9pnknOmodo/htihy9baE6N080GMLDyRcmxwut3WnXLxNTAU/42MZvEGSyIVtFAufOp7eO7DK3HIlfdQv+Eg1mx1J2CRO7k4ODz5+UmtZf+xvFZ/fzEaAYJLn6h1Jzcj9E2zByEamzFuDwYmIWRASdul74=
Received: from CY5PR15CA0221.namprd15.prod.outlook.com (2603:10b6:930:88::14)
 by BY5PR19MB3972.namprd19.prod.outlook.com (2603:10b6:a03:225::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 13:27:18 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:930:88:cafe::e9) by CY5PR15CA0221.outlook.office365.com
 (2603:10b6:930:88::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.11 via Frontend Transport; Thu,
 20 Nov 2025 13:27:17 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.9
 via Frontend Transport; Thu, 20 Nov 2025 13:27:16 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 9C622406547;
	Thu, 20 Nov 2025 13:27:15 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 8AF7D820247;
	Thu, 20 Nov 2025 13:27:15 +0000 (UTC)
Date: Thu, 20 Nov 2025 13:27:14 +0000
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
Subject: Re: [PATCH v7 3/9] software node: allow referencing firmware nodes
Message-ID: <aR8XMrLQWsmcrzY3@opensource.cirrus.com>
References: <20251120-reset-gpios-swnodes-v7-0-a100493a0f4b@linaro.org>
 <20251120-reset-gpios-swnodes-v7-3-a100493a0f4b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120-reset-gpios-swnodes-v7-3-a100493a0f4b@linaro.org>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|BY5PR19MB3972:EE_
X-MS-Office365-Filtering-Correlation-Id: 08b6e084-c106-4ffc-81e0-08de2838866e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|7416014|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YbX1Cruqdqo5zrwcvtWHJdR8Fuj4gPVf89bWTloJrawu8WQzHgh01sITvywq?=
 =?us-ascii?Q?JCwPN0omiaYSeQu0gr2rIjnlPb90ZLmlniEocitOjH4Ah6lW/Way5qVoDz78?=
 =?us-ascii?Q?zt77TmIPq+YeY1T5xEVDl4i+jaBzsgiMjPRVnMB8G3HDI36WEs+xSENQqKxH?=
 =?us-ascii?Q?l6X89Mu8QNUzpAVH6YhxRdFaUvwbcTyRsMe/TY88v7TijqSk/RXSuo7vNDKA?=
 =?us-ascii?Q?lynFa1itlC8/Bk9yNi+fZ/BD/vpd74MXs+XDQd0DhFHBIX+izzg4abC5uRXG?=
 =?us-ascii?Q?VMSj3Ivhlm3MmmztUGSFBMP6KIpbRYNV7ZdkjU1R2f+NepP+swkmqLOWYPnM?=
 =?us-ascii?Q?KmUeI0ZCzlHdljUZMNB2oo+euq/+XBuGMJWHlFqPkMmHUbv3l+Gasty+zlKo?=
 =?us-ascii?Q?rAkp1lFfKuZrFmTnccGOnhfDkDBnvDk7JPM33EFu+8a/N3+4PSQK3HmAIGDq?=
 =?us-ascii?Q?b/vaK/9LzbOFP06gweFyCBO8r7WVJNxuuYcmZPkn/2MP7ofxVtEG30tSSTJf?=
 =?us-ascii?Q?vxmfvwcVxws74GD5A8LTWWOYuJuM7obl9Kwm2n3BTLGww3aWynoSdZd5kUi8?=
 =?us-ascii?Q?k0gp9huc0em9+feCKsohmEPEwhcRtlHJYyTLyZKVR3GEiHVXcEFN0NCZ/LBj?=
 =?us-ascii?Q?mrQ7oQYNmkkDmFoTDmaWo32yEKZc+VEjtt5a2Bol7P/HpejwRYzM/p2MOVtD?=
 =?us-ascii?Q?hSfINd2QlmNr1yxsbJeFNt7iX6+jF2rp2hvJ90wH8urSyEoQkiZYpz/SebAP?=
 =?us-ascii?Q?UswZxaQYJ2BU3cuaVv9VhXc0idBEG586HR9UQFj+IR5jJFl/fKQddSZRbJeL?=
 =?us-ascii?Q?CmPInjc7b9IFfbhmPhhVsVcUJMD58JO0ZVkt/PGWGlvZQMy7xA463BpcBl2a?=
 =?us-ascii?Q?DUN+uQICEtxg0iBQiDjAxPz+40lI4WNhjPQ5e3imJ80j+jxJSdw6VVYCb2fM?=
 =?us-ascii?Q?qih8d8MD5ZoOJ+lwY9TN/n4VZJiALGcwW2sIyOBlR9w7jClC3qYjX+CUkGHf?=
 =?us-ascii?Q?3LU/0NeHvKF7IXkRLhW0jorItUIkT9pWeQ0fYmoNYEw3mb41v5ZeoqymZZgx?=
 =?us-ascii?Q?Sp2UcN0U+ty/hlkvwupBrx3N7XYXKIZPd1FnfWB5mdR9uVwSaUB/a31/8nco?=
 =?us-ascii?Q?Xf4vSFLKowa1SI5dIdQVSsCrURXsWhlOlZb/T4ku4jXAk0ZVSwA/KGBTEFbF?=
 =?us-ascii?Q?El3DSR2FvhOr1LW2ynSioF4bMqBSoko8LFaC1LzSTCltW1Ea3r2XmA3bXDoD?=
 =?us-ascii?Q?qKcmgikTZMHnNXEKvQk1H0sNhpgWcirYoB1V006marxw7d27JN8GHl9XJ9nE?=
 =?us-ascii?Q?6u3yZLOCi33+P9F3BTAvKk9xtKKrXTxn9hjLvBV2w55iXx8TdGlZzMEUNUtR?=
 =?us-ascii?Q?+tQrgDHWbCD2qi2BvcRuA93uHmH/VbswL1UetG2GFcPPgSQxdHTbGFUZX+xk?=
 =?us-ascii?Q?BKBb9pQz534Da+ymLit7wBdzvmtCi78K8jhDydxNk2jxEpYpkYYaxYxlAC7U?=
 =?us-ascii?Q?Ln7DF8bfmG7s03Xac8BpMnwgUvKXsvW3KJdaDjeVqswYQhsOtX7/vfTsyUDn?=
 =?us-ascii?Q?c1Qrhsr+rM9P5GjWNjI=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(7416014)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 13:27:16.8850
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08b6e084-c106-4ffc-81e0-08de2838866e
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR19MB3972
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIwMDA4NiBTYWx0ZWRfX5W6eNAcCIyWY
 D3K5cVhQPHyPW7FXMrcAIcyCpgAAVjLZAXmaZZtlxuYgWJ+Keg+umDaPK9IHVZzl+q7jcP0N+t4
 Wy2WgQCC75Ayq/lapUUw6IxAXLyzaKubOPXZHRgx2u8ODhUPbh9BcrIGHJI5NM65zJ07ikkq7ex
 OJT0TKRfflW4+sQaNu0s6IXMhd2XE+5wNZrwbLU/P5YHd3TgATV3TdIz3xjcUPg/HVuF/y1VaQ6
 Xt5ZY40LZCoMSHen9Pyw51ZD/7PNpECiQXBgUxcNlW3v8Qgkgd2SGdFvwU4N9+dHEyMEaN54ssD
 TtPV7BC7X6OsdL7y3wFveJsmamxFchqqTGU655LQnr513qh6Y+OOdbmLca20E8RX8Vp0Oq6bFJZ
 SevnAcac6S/n0BcCc7Ihu6+e1RJU1A==
X-Authority-Analysis: v=2.4 cv=XcmEDY55 c=1 sm=1 tr=0 ts=691f173a cx=c_pps
 a=iJ0/73tnBOJCmN8OdmQeBQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=QyXUC8HyAAAA:8 a=ag1SF4gXAAAA:8
 a=w1d2syhTAAAA:8 a=ehmILwYxfDksx4Y_Cz4A:9 a=CjuIK1q_8ugA:10
 a=cvBusfyB2V15izCimMoJ:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-GUID: 7-gt8eBNuQixQR_tMbveyGleVB7FR-rd
X-Proofpoint-ORIG-GUID: 7-gt8eBNuQixQR_tMbveyGleVB7FR-rd
X-Proofpoint-Spam-Reason: safe

On Thu, Nov 20, 2025 at 02:23:58PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> At the moment software nodes can only reference other software nodes.
> This is a limitation for devices created, for instance, on the auxiliary
> bus with a dynamic software node attached which cannot reference devices
> the firmware node of which is "real" (as an OF node or otherwise).
> 
> Make it possible for a software node to reference all firmware nodes in
> addition to static software nodes. To that end: add a second pointer to
> struct software_node_ref_args of type struct fwnode_handle. The core
> swnode code will first check the swnode pointer and if it's NULL, it
> will assume the fwnode pointer should be set.
> 
> Software node graphs remain the same, as in: the remote endpoints still
> have to be software nodes.
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Tested-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles

