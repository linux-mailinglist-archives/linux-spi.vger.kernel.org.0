Return-Path: <linux-spi+bounces-11333-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FAC1C70103
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 17:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E3A30347B42
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 16:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9C636E57E;
	Wed, 19 Nov 2025 16:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="BZnU2+8Y";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="z0w4eFnc"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FC1327BFD;
	Wed, 19 Nov 2025 16:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763568805; cv=fail; b=EocdqvvIYGs4IDUA66qN/PxZQTf64+IQT5xXwpafHn7F9bLrgUN/X7Aq1rMcLY1AgoMDxzCsTz1EST6U6/CPfXi4dWNOlySSGpqAVF5iCa4YBHzIe79AQkgo08WlFaNPztNA+foTb7nQQPV7uKy2pHYZMx4RVtdGqPgyk4Eqxt8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763568805; c=relaxed/simple;
	bh=KjnzTLlQ05V6tA1dInPLl5B6VH5PA5rokliVN7uQS5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L98ylOT5y21ACHgVceSB7a2pBm+iodBD19UkI/Kx1t4Hf0l5eg80MbQmYcOQjH+9xz3At9yTGTHShLSoIYA9SiJOi5J3zYoun2X47USwBmUBVgxxPQuGYe5UT0VwjZSCoSR5iH9bdm9cN4K+iAiRjHC0gSJGUp6pVfYfUg9JqEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=BZnU2+8Y; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=z0w4eFnc; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AJ60kqB2358492;
	Wed, 19 Nov 2025 10:13:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=7lKkl3oE9OFG08y+PoIzkYj8IiD2rfgELOXFHR3T+nI=; b=
	BZnU2+8YAzEBITjTr+TeoTtqvXggAnnhoHnir6hbVrwp0m8cIp0+7yYcK4RNA+S5
	SIjzk5o1VVjdRwEdIIMp0QZcquzxjTfvq/pOO9QzBdkgi1sSZbyS5sZj+OQ+ugMy
	w+6nAYxgsIlpymN9jdrIOcpnwKNAqo8OMHVfTznld+EayZzgESRF+unocTbLfy0K
	3wjNYhaLXa26A93i+y6AcN9PkQX5uPfTy5Lg3zbHfQMjV8z5QvpV2qHXYWfm6YuT
	dKuP1BqnuOj8/Wkn5W9k6n4PZZ/GxZjLq1cFVJE7Qv5B+LDa1bALh3PsBNjtykl6
	RejGoJqMC+ePPt9JHEtzXw==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11022133.outbound.protection.outlook.com [52.101.48.133])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4aeqt1d79n-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 19 Nov 2025 10:13:14 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=njpmgT5mHLigZ/n8ZapD8MgzWXk/fd9S2cIq3tYKSU+djqyNfII3n22Ee51c67x3QgA7x3VGKXsZ4PJAOVAZcizv8q54x0T8l1dPnmwOIvkXB2ADi4w7mNhz3MvSIoN38oh86bFpDoq+/x0FzcUrVMcrCmGIRDuxvJ8JzM53mCB2pftA7UzirgAW16c8RGdeFdlUKAeKHTNGOhbKNot5CyBgrJIH8CdHtnG0ZtATuC2nY98BPYWP+uK7eNRxgANdev7ag0lmszSVpA6C8wOOnUynCjWkuPftO/eh7fw3Klq2iY3zuf25+ijhP5pPmvYp/7yDyzKqGew5UoYllY0J7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7lKkl3oE9OFG08y+PoIzkYj8IiD2rfgELOXFHR3T+nI=;
 b=AqsRr/YOPZdk2vBTuDQ2XjY/018GsY823QpHHwxz+yx0Ccsgup6RKYKyaOjXB9j8TmecDFIuGY/wILRfF4hzfoAZl+4xFDBuhUbJuZVkiUiFnvP6kQIzySkpp3M+RVBTYRMSRYFBM1xPe5UoUD/MNVv810iHe6mmrgECXDrx032c4SCLrDZ+nffQfmr4n4eXOg7hBZLU4aLJH8CMssYH8dsNbvVLvsE4/dJKASMUP3wkOPwZbeD6/vHwdBDXOW0T1JNBHgdvJq+HVqlHZMccBDdZGkfTH3S0qa1PFi1WCqV7a0xorXKFss5xQBujg5oW+b9iYuvIGtKdkIev6smyqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=bgdev.pl smtp.mailfrom=opensource.cirrus.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=opensource.cirrus.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7lKkl3oE9OFG08y+PoIzkYj8IiD2rfgELOXFHR3T+nI=;
 b=z0w4eFncokpfrINf7xXhoLf1rOoR4zjJAqgXEVxnQ0IIYbz57TiQm4hSc5gIjR8KcNyCQyLtDUcygoG5NtLTGCsruU0r66FyfC8fg6XMfPRfvJBmvG8hTHo6x0d4LdGssmlNtqO7O/BG8zlHMFLAMusUKCM7utcxtg00BM9XMMw=
Received: from DS0PR17CA0015.namprd17.prod.outlook.com (2603:10b6:8:191::23)
 by MW3PR19MB4377.namprd19.prod.outlook.com (2603:10b6:303:4c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 16:13:11 +0000
Received: from CH3PEPF00000018.namprd21.prod.outlook.com
 (2603:10b6:8:191:cafe::37) by DS0PR17CA0015.outlook.office365.com
 (2603:10b6:8:191::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Wed,
 19 Nov 2025 16:13:10 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CH3PEPF00000018.mail.protection.outlook.com (10.167.244.123) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.1
 via Frontend Transport; Wed, 19 Nov 2025 16:13:10 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 3FEA0406547;
	Wed, 19 Nov 2025 16:13:09 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 1CBDD820257;
	Wed, 19 Nov 2025 16:13:09 +0000 (UTC)
Date: Wed, 19 Nov 2025 16:13:08 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Lee Jones <lee@kernel.org>, Mark Brown <broonie@kernel.org>,
        Maciej Strozek <mstrozek@opensource.cirrus.com>,
        Andy Shevchenko <andy@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
        patches@opensource.cirrus.com, linux-spi@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH RFT/RFC 2/2] mfd: cs42l43: use GPIO machine lookup for
 cs-gpios
Message-ID: <aR3slKbafBPFrv6P@opensource.cirrus.com>
References: <20251119-cs42l43-gpio-lookup-v1-0-029b1d9e1843@linaro.org>
 <20251119-cs42l43-gpio-lookup-v1-2-029b1d9e1843@linaro.org>
 <CAMRc=Md4jHrHxHUOM=eFuWRSaEO9jFEoHGTjEEJLj9w6E53gOA@mail.gmail.com>
 <aR3noZXxma9vOXEI@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aR3noZXxma9vOXEI@opensource.cirrus.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000018:EE_|MW3PR19MB4377:EE_
X-MS-Office365-Filtering-Correlation-Id: d3baf881-54e8-43ea-018c-08de278688aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|61400799027|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WTZxSU1hcmdOclFGSFhzRmxLUytORUdaalVoLzJycjN0Y1NLUzl6dVZuV2di?=
 =?utf-8?B?cXdNR3BxRDgzQTZncW9OWHpUWk00RXBxQWdPRFIwYzRvc05KdmVwRi9LNmNk?=
 =?utf-8?B?QnFZQXBXU29HZHNpK2lhMC90Y0ltVWJ4QlgyWktjVmc0dUFqUG9pK2p1VkNj?=
 =?utf-8?B?MWxhdDlKK0xnbERPNDZXQkRySlRrd3JPNGZ1Q3ZEcVNzWnd0VjlDZjZLT2dv?=
 =?utf-8?B?d0FsbGUxZ2VhV21DUlNpU3FSSlBTNWFpTjJBOWFsUG1mOUtaayttQ1JrSUxF?=
 =?utf-8?B?U0VYWlZNQ0NlSkY3QThqRnFaNkFjaHczYk9SeFppVDRZUGdYbEtaR0RnekNQ?=
 =?utf-8?B?UzhjbC9razVaSDhTWFN4anRrcm1md2h5cDNqSkd3SVFyMC9kVGVhZjB2WUNQ?=
 =?utf-8?B?emFnakIrR294ZFkyZk5uYVQwYlNtVnZUVFR0MTRNeTg5UU5IZmN2MktMNitu?=
 =?utf-8?B?c0JUaTNCbXRGT2p3WDkwUjZMMzZ2MnNDUkRjTGNhZC9FNXh5eHdnSzM3MWVq?=
 =?utf-8?B?MVNVUDZCbVE3UzRiMU9Jc0JZWllaUWFDQmR0aDFaakhXRUFZMGVMWEZ2QkEr?=
 =?utf-8?B?Z3hPaytJWXo1N2hjclRlNFdzTjg3THBWOTlraDd3WG1qQ0ZjWUZveDg0aW5Y?=
 =?utf-8?B?QnBkOTg1MElmVStNNGRDRVhTWUlEU2ZDNDM1bW5lWEhyaUovRGl4MnpwZ3l3?=
 =?utf-8?B?VkVJckMzRzVTQkVIMXJIS2lwNGdLdGpFWlVPUU54bElqRkpNNTE1M01wZS9t?=
 =?utf-8?B?dy85cW13akc4M00zOEVVcFdUdnZheTA5RWRKUXpkZzhZYzBEVVc1MEdBQ0Ev?=
 =?utf-8?B?dFF3ZldRSlpiQ2JlVk5VZjRWaEZRZDJRbUdKNzBmNlU2VlI1SGh2L3gvS2lY?=
 =?utf-8?B?NUlpdm91U3BGZFpNcW1xQjN4Ky9hY2Y5dkFWR1U5WThYRk0xbWNRV3pQZ0E1?=
 =?utf-8?B?V3FYVVE3TDdXdDNLNkV2RDYrcGlIbmVNeWtMbnJ5REZIREphU2FCMnVPdXB3?=
 =?utf-8?B?aVlUR3M2eWlMbXdibGFjQmI1Wnl0ZndvSGhLazFOOTIwcSs0QzhNSkZLS1Zt?=
 =?utf-8?B?Z0htdUNtOGJRcmdFWEMwUHp6MUlFcXRmcW9GbHZTTk1lcllueExlUVNlSDRO?=
 =?utf-8?B?Z0Ixc3YvdWdiUjdmT1VoR01LRkFBblhVWEFja05XMFdsbzJrVG5obEVWd2lv?=
 =?utf-8?B?d3hqYmpKWGdVWjJlLzF0RUVpN1AyZ3J0b0MxTFY0eGxXZDR3b1lWSDc2KzY0?=
 =?utf-8?B?L2FhUEpaUEhha1pYSWxZRWRrUG9iS3VwdFpIZGdUL2ZTWnJ0dTJyVjlsZEJR?=
 =?utf-8?B?eDd2bGVxeW1PTFRtL0FneDFxRytwQmQ4Y2VDZjJqaThxN29adWs4SW9uSDkw?=
 =?utf-8?B?b3F5c1AybVgwOStoUHp6WlhpTzZtb0RuOHJNZXR1czhPc3g3TjFEakZjRk0y?=
 =?utf-8?B?d2krUTFseFBjM2U5enhHUTVVYUd5ZUk0MW0xNFl3RDFxQlh0ZWllNEhtOXgw?=
 =?utf-8?B?amZTS2F5R1JaRmVZenVVQUJvcHNHMWNvT24xbFZPeFNZNjJSZVV0ckpadExV?=
 =?utf-8?B?QlFlZzlRSThjU3l5RnAyMjNsRDJSZ3Z5dEUzMDVCSFZEaWRkRmpQUkVaSXJS?=
 =?utf-8?B?QVZWNk9CNTYwdFZJdjB5bWtCT1p0VHptSjh1RW1wVWhraFc5Rit0eGhhVmJx?=
 =?utf-8?B?RmlwaEcycEs1TkFhTDFtb3ZTU21YdFl2aHd4RlRQUXFMTUh1ZnFTRkZnYUFL?=
 =?utf-8?B?YmV4N2lSbjhKTXhaT1dsVDRLeGllUjFPMUQxT0ZtdVptQTB4MXZBQVE4cno3?=
 =?utf-8?B?M0E5dE5IRDNBOGJDZ3RZTGYxMWhjSzMyeEhXcHMyTWxQcmJhc21QQWpraktn?=
 =?utf-8?B?NDhRdVFpM081djlOSEdZelhHMHJTUnhBNzhERGM1YlV4VUlIQmloblRhbWJw?=
 =?utf-8?B?bnVpT1BhcWJOZEdsMElTOGVlNXAzSzZTQWlKVHRkUm9XcnpiSVh6ZlJ6NllE?=
 =?utf-8?B?RFJKMjlFSk5SKzdFblRzRnRBNkwwU2t4dFF5RmZBYzl6SFZSaE1GOUhYNUFv?=
 =?utf-8?B?N09KYmlGanZHUDREMEMySXVZakZKTHA1QU9mOUtHanBTcTFodUFDZjR6bmw5?=
 =?utf-8?Q?WdLg=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(61400799027)(7053199007)(13003099007);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 16:13:10.2746
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3baf881-54e8-43ea-018c-08de278688aa
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CH3PEPF00000018.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR19MB4377
X-Authority-Analysis: v=2.4 cv=OOEqHCaB c=1 sm=1 tr=0 ts=691dec9a cx=c_pps
 a=/xE45K41/b7qeiroFAFKVg==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=w1d2syhTAAAA:8 a=KKAkSRfTAAAA:8
 a=iF_agFKQqAFWA6pzTFYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: KRXjafvsg8grztAMPBOBCFJUINdcDhG4
X-Proofpoint-ORIG-GUID: KRXjafvsg8grztAMPBOBCFJUINdcDhG4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE5MDEyOCBTYWx0ZWRfX+Cmie+ynVS8g
 3UDsYxTks4D1bjyj07hbOvPZ8i8GtFlnbP+kF1UBvNPLRnvkaB1J72ix0tinzrSlZVkOodEdqQy
 QkQ2KCNXbyxcMp3i3GZvpKsutX9JpfL2WuN53q2ZuzQBTYYnWqzfGaliRAjhyTn9zRKkOkr/piG
 TA9CHfwjOuIzoo1Zz/LKyq6Db2k+PbyM98PtE6T0+PHYknQAlgrOLYwL7/xt4jPIVxpO8d0tDr8
 80uB6U/RvOGI1o+TXQOLomywTP0VsS6gDcWiyQSmexYxYGRwYyYPH1HYuzpu/basjygtpohAkOw
 0Nz+Z0Ao0CdokmGTEnvtD3Cu9f8t2Pp+Q1hvIoFeANpDwsg4VaMNC2NarGFISjf1TvhlLl4yAiO
 o7OsKt4myMsa7JrFOUh57Wg+rejoCA==
X-Proofpoint-Spam-Reason: safe

On Wed, Nov 19, 2025 at 03:52:01PM +0000, Charles Keepax wrote:
> On Wed, Nov 19, 2025 at 04:35:07PM +0100, Bartosz Golaszewski wrote:
> > On Wed, Nov 19, 2025 at 4:21 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > Currently the SPI driver sets up a software node referencing the GPIO
> > > controller exposing the chip-select GPIO but this node never gets
> > > attached to the actual GPIO provider. The lookup uses the weird way GPIO
> > > core performs the software node lookup by the swnode's name. We want to
> > > switch to a true firmware node lookup in GPIO core but without the true
> > > link, this driver will break.
> > >
> > > We can't use software nodes as only one software node per device is
> > > allowed and the ACPI node the MFD device uses has a secondary node
> > > already attached.
> > >
> > > Let's switch to GPIO machine lookup instead.
> > >
> > > Fixes: 439fbc97502a ("spi: cs42l43: Add bridged cs35l56 amplifiers")
> > > Reported-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> > > Closes: https://lore.kernel.org/all/aRyf7qDdHKABppP8@opensource.cirrus.com/
> > > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > ---
> > >
> > > +static struct gpiod_lookup_table cs42l43_gpio_lookup = {
> > > +       .dev_id = "cs42l43-spi",
> > > +       .table = {
> > > +               GPIO_LOOKUP("cs42l43-pinctrl", 0, "cs", GPIO_ACTIVE_LOW),
> > > +               GPIO_LOOKUP(INIT_ERR_PTR(-ENOENT), 0, "cs", 0),
> > 
> > I sent the wrong version, sorry. This should have been:
> > 
> > GPIO_LOOKUP_IDX("cs42l43-pinctrl", 0, "cs", 0, GPIO_ACTIVE_LOW),
> > GPIO_LOOKUP_IDX(INIT_ERR_PTR(-ENOENT), 0, "cs", 1, 0),
> > 
> > Charles: Can you fix it up yourself before testing?
> 
> Yeah can do, but I am still very nervous about how this approach
> interacts with device tree and ACPI systems doing things
> normally. Is this also ignored if the firmware specifies the
> properties correctly? I feel like if we go this route I am going
> to have to bring up a few extra things to test on as its quite a
> big change.
> 
> Apologies for the delay on my suggestion but something weird is
> happening deep in the swnode stuff and its taking me ages to peel
> back all the layers of in abstraction there. It seems something
> copies all the properties and somehow the fwnode I want doesn't
> make it through that process. But the basic idea is like:
> 
> props = devm_kmemdup(priv->dev, cs42l43_cs_props,
> 		     sizeof(cs42l43_cs_props), GFP_KERNEL);
> if (!props)
> 	return -ENOMEM;
> 
> args = devm_kmemdup(priv->dev, cs42l43_cs_refs,
> 		    sizeof(cs42l43_cs_refs), GFP_KERNEL);
> if (!args)
> 	return -ENOMEM;
> 
> args[0].fwnode = fwnode;
> props->pointer = props;

blargh... and of course that should be = args;

Thanks,
Charles

