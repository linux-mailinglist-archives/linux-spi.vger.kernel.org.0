Return-Path: <linux-spi+bounces-11302-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 924FDC6E10F
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 11:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4497834ABCE
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 10:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB4032F75F;
	Wed, 19 Nov 2025 10:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="ofco1Xdq";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="WE5L3jIR"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7282EF67A;
	Wed, 19 Nov 2025 10:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763549302; cv=fail; b=sp1IeEB5/lXVDAxzI3O8nBFxoycvgUhM/Y2n+ycYUSqHOpQ2ZPWmvA3YCJIZKduUcP2uC6RLIezfUy9Hfc5tcZHCKBa2K74g8TxiUtog1GZlOjgFSp508qKW1Rxy+ct5/jqsjXGcoCARJtOq15N7J1VMNsk4LHhosT0cKZMlIY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763549302; c=relaxed/simple;
	bh=bVJLxQQwBtr20FYcoOyUqxODzWeXBt+W7zL9SsGR7wY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UFfLAuiQeI2OMs2DgCuBqfW+lMamnZFwvAxMbdqGhFOVEHdHde9c0SF2lEUJNIn4LjlYtxSUMsDRJwsviA3ULS8ckzcP+G8ZKpeDCbQ7qaawBVduoFDJ3SuVdfdKha5TZQj3mCeiqDwjEpt9n25xqg3G9JTUjG2GAia8k/zRQrk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=ofco1Xdq; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=WE5L3jIR; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AJ0QBX51832304;
	Wed, 19 Nov 2025 04:47:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=BJDMhaiTm02gVbboAnIAFUxhL45YwgNfbs82cT9SCrE=; b=
	ofco1XdqO0VFpFWPEiF57fzMGiNV8LPdzrI5gaEiu+D33qkTQKVRr5z3IqGMXNpH
	OqaGCVx05LJIY7uBV+HJ/41TRydw3D1qc0uvcmwanINM0/548PnnQwxv2nxTfUQe
	WQzKbQCmZKM5U3U/K2x9WipG+MB+dVvBktcwA/GUSV/lBqas4xjSNywUGy1ygK4i
	wmhe1MzrwnFYhxrMvPRXoVM+aOaGcVO1d0w1sIKOy+flVWXq+4qpBVr2EcuhZpsV
	eBwGPEWm2yn/hnSVzRXGzbL8QIgg0nCQ7SsBfYEwmX90ztxSJnftgVgdW0U5lzoI
	E53ot1DOswbGttvbiEXEbg==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11023072.outbound.protection.outlook.com [40.93.201.72])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4aeqt1csqt-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 19 Nov 2025 04:47:58 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SFYSdfMxHtwotK5uNoT6rmCZa4UhAXCYlxELPUi5smAFmNgGHSJ6z9ty4vEJitM0y46F2+02mDuQwUQzstkezn11J6BCvtIHr1xw3+ZgWAMJ3e5yqiwvOBQaqcz1p2qQpgSAafiYlhvnHz4WCWTfFDeMEZLjWgCeVjcM5jyw+YczDIYH7E36lIBD8cVTwJBitC9BKP0zdtIR8EfRUddDn9tiKgI4fdmHNzy10THmWpJZYvphZ2pmb6hnzEeEbd10wAy4mz2hQxQ0NWCMMEiKCh2AfCUF0XH4g+ae6eTNFkgM+cPCYiLsGuzvEfasjHKStRXR+48V0hFEm7r0OEatQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BJDMhaiTm02gVbboAnIAFUxhL45YwgNfbs82cT9SCrE=;
 b=bMfQ5ZV7Ca9oxwuhlvHwYXBZjrdp4F88D1ZZckZl7tj68lOGqPXkutcpfZTX9gg2toB723ZEbwzJqCusx5y2p8jrtfQdhLu1/G50kfadKkqxwy4+CGOC6mlB1+mA1kIVO3gWK4T1a0K+A7F8y/Z90vD2BDeYWR5xZySLEeNQRM4/dS6HXhUC6gN6q5zKUIZNFwWTWfFiopBy2vb45zn77W/+PVg1qgrIGE4e8IVHRAIl9T16Him9S0dAV0aEBXyvPz9UEQUBjvVnZOFmZUVREn/MoyRZCunUEvluuMq4W8qsj1M9Smfip4BD9hI1vOxrRolFPKMUJwngO7GabG3pdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=bgdev.pl smtp.mailfrom=opensource.cirrus.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=opensource.cirrus.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJDMhaiTm02gVbboAnIAFUxhL45YwgNfbs82cT9SCrE=;
 b=WE5L3jIRIrkeYso/8kcBGh0uPDzGOHXeL0yCUG2YSxxEh5+mukXHo9Ohn4IVeo3WtyJt0Jkm/8h5Tl0mAWeeV39mSHcPQVol6i8mMJorSf5nFpnbzCA4q5aR6LPsi7AYpX1xJtjdUeDb9QR+llaH0Pzqti/ifVUUaNmq8p01AeU=
Received: from SA0PR13CA0003.namprd13.prod.outlook.com (2603:10b6:806:130::8)
 by EA3PR19MB9301.namprd19.prod.outlook.com (2603:10b6:303:2b2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 10:47:55 +0000
Received: from SA2PEPF00003F63.namprd04.prod.outlook.com
 (2603:10b6:806:130:cafe::f2) by SA0PR13CA0003.outlook.office365.com
 (2603:10b6:806:130::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.4 via Frontend Transport; Wed,
 19 Nov 2025 10:47:55 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SA2PEPF00003F63.mail.protection.outlook.com (10.167.248.38) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.9
 via Frontend Transport; Wed, 19 Nov 2025 10:47:54 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id DF69C406547;
	Wed, 19 Nov 2025 10:47:52 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id BA6DD820247;
	Wed, 19 Nov 2025 10:47:52 +0000 (UTC)
Date: Wed, 19 Nov 2025 10:47:51 +0000
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
Message-ID: <aR2gVzKhfN38MHAR@opensource.cirrus.com>
References: <20251119-cs42l43-gpio-swnodes-v1-1-25996afebd97@linaro.org>
 <aR2OU4se7lxcMtGW@opensource.cirrus.com>
 <CAMRc=Mc==X3wERStdXmr5A9p0sPe7wdrPE4GZuqPLaKoBb9O9w@mail.gmail.com>
 <aR2Uo++k1NKkk2sj@opensource.cirrus.com>
 <CAMRc=MdFDAmqcJ3PMsTbeZUb9imM+fzHzQ_9mQ1T=syDoCcQJw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MdFDAmqcJ3PMsTbeZUb9imM+fzHzQ_9mQ1T=syDoCcQJw@mail.gmail.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F63:EE_|EA3PR19MB9301:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d238144-8673-4b33-2f55-08de27591848
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|61400799027|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RVNFbHR6MDRsQkdEL0FOR1ppa1NXK1BMQmg1K051VC9lWjFrMU5xM1A4bzdi?=
 =?utf-8?B?dHM5SEQrS2lmdTRrTysyTE5QRkxWS1NyTWdJS2Y4dGNneE9hVmRWdjY1QVNR?=
 =?utf-8?B?NFAvWWJoZWhCU3J4TitTaTRTSzd3WDMyK3ljZnFOODZKdFI0b21aTFZqS2cw?=
 =?utf-8?B?aFhUWCtuMzI3R0s2djlRTFEwcW01dXY0Q0lJb1owUzVTRCtTMWlFdDFJdG4r?=
 =?utf-8?B?eklHQWh6WkV1b0JON3RYRGJSNWhLVWVCckp1QnkzSm1CejRCWllBbUlnUnpY?=
 =?utf-8?B?bVV2MUhEaHQ5VXFkaHFLQklyZmJOQ1NLcXVCZVlSSURVUlplVklpQjFyZmNO?=
 =?utf-8?B?aWt0QlYvN3BZbjVvM0dXa3BQYXVtbTVhREN1RXBocTdDTU10Z2FoY3YrM1g4?=
 =?utf-8?B?c1NIbVh2M1llODZjejh2WlAvMHJZdVhjQmFnU0E3d3J5MVpZUVFzYlpGcU4y?=
 =?utf-8?B?SkpTbU5EK20yLzZXcjhNMFFjNEpHdktnUGs0aUdkZ3lETXJNRlpCSjlQelZH?=
 =?utf-8?B?Ykt6ZkpQSWtjZzlxZm9vTkpRMnorblRrbzg5cWpWamNIMHF1Y0lTNmtpSzN4?=
 =?utf-8?B?Um1IRDgwek5WM1JXQ2VaWGp0d3dRNzQraFpodnlrSzBxMHlaKy9SMVBKcjdK?=
 =?utf-8?B?enEyd0wyczY0YnQ4VXVYUHBqUWJpTzc0WFpXYTZWa2IrS0hDY3ptMDNaZERV?=
 =?utf-8?B?L3lFdmdGOHJLNm1rT3NVWjcrdDM0ZmdIMzJzQURmVGdiTW80RjhablhIaW1q?=
 =?utf-8?B?YnNyazdrbUdMM2pYOTRnaGwvWEFiRzVPdTlsYmVMMmtHajE2b2U3U0pVeHFF?=
 =?utf-8?B?a1Y1NFhrSGJEMUp0UnVmUjVrSjNhRXlZQm84aDNxd1RqMzVnejQwRE9JTmxI?=
 =?utf-8?B?U01jZi9aaDRXVUtNNzFka1Qwem83SEhuNEdKSzZqYWdHanFrMWpibzhQVWZE?=
 =?utf-8?B?ZmZrRlk2VzFhU2ZkTldRcEFXZU01a1g3NnZ4bmRxNnlwY0h0dlVBYVltT3hi?=
 =?utf-8?B?c21sSFdMcFBEL0hvaFc1ZCtPb09ZVDQ0anRrSmRpTVBsYjRBTllQQTh6UjNP?=
 =?utf-8?B?SXpiQkNobHdnUDB0azhwdXI2TkpvTkxrampSdEJRR3ZjSzFTSnhTemo4K2N6?=
 =?utf-8?B?VENOZ1FjRlFyaXAyWVZjS2taK2ZNQ0xyUnRnQi9nMDZ0R0NVQjU4UnRDT01v?=
 =?utf-8?B?SW1ORTdvVTJMR2NlUjNqNEtieWJSdEt2VUo1anFHRVFUTmN6cnp0eHhBeTVD?=
 =?utf-8?B?aDd5QUNpTEE3cisyd1VWY093SGJGZWx3eGJreWMwSW10Qk5WZkhoTkE2TTdH?=
 =?utf-8?B?L0ZiS1lmaUNrWklqeDkxaVd0NCtuVndoMlRMZ1QzMlMzcXBZekk1a2liMW1w?=
 =?utf-8?B?dUQ1RllHRE9tSlppZURrR1ROQVZxb21heXlGNWtIRmxkcmsvZFhpT2o2TFlO?=
 =?utf-8?B?SjJPZEMwNzNtMjVoeTcrQmFZR1oxR2YydTJIVWxWUU1UU204dVFjSTZTMEU2?=
 =?utf-8?B?ZGFrUU1sdUlrdlRLTGFnRDR0QlhCR2NnQ21Lb0xUNzFQb3JYUDFFdVI5S1E4?=
 =?utf-8?B?SHd4dVhBMFpYMDBMZWl3bi9mMGE3K1VZR3dSV0hyL01TUTRLb3QzeXBxaFNC?=
 =?utf-8?B?Rmh4cXJPakV4UGVCSUJuQ3BvY0JaSUtYRDIwWU1YMkVkdGRvQVZRbnRaL0Vu?=
 =?utf-8?B?ajRqNnhjRVVPM2xCaWVPM1J2MjU0MENXRE5Db0llTjkvb1V1aXlibW9hTEhk?=
 =?utf-8?B?Z295a3FKYVNKM0FiaC9zb2JVTzZzUFdWeitZdGlPNm1uSnBRVFpLRzhXOEpM?=
 =?utf-8?B?Y3RTUHpSS2NQc0MrK241UUtWZXExTXFPTUdwNEpYR1NlaUxmRzc4VE9leXlS?=
 =?utf-8?B?c2lVNkdXaGQ0akZ5L2hPemRFZmRGcW1HbDA3bXhTeWo4MzZxN3YzdHhtaUJZ?=
 =?utf-8?B?dGJoUVVDam5ZRk0zTDF4b3FnSU5ENzlvcCs5YjVrVGtyeStBNndXUEo5bnd6?=
 =?utf-8?B?R2NURUUzcjlkUVpKaTFtUmU4S0NRNU5ITDlIM2N3UFdBdzVJeVdTMTFPbHg0?=
 =?utf-8?B?dWR6OG1OVlgyTXZmSWtBTy9lU2MwV0JMc1RRQVZQT2VMRmJlTHRIKzFEVGxK?=
 =?utf-8?Q?2EWU=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(61400799027)(7416014)(376014)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 10:47:54.3278
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d238144-8673-4b33-2f55-08de27591848
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SA2PEPF00003F63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EA3PR19MB9301
X-Authority-Analysis: v=2.4 cv=OOEqHCaB c=1 sm=1 tr=0 ts=691da05e cx=c_pps
 a=a9BdPFFbNpLpmASqG3lITg==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=Z3mMv855LcLcIp2rJHgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: hVve_XxKNM9ioC5PAfQ4rSTA9VsvwxOv
X-Proofpoint-ORIG-GUID: hVve_XxKNM9ioC5PAfQ4rSTA9VsvwxOv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE5MDA4NSBTYWx0ZWRfX7wJHR+jUWxpN
 UDhNSEJsmGCplLOGTR2fdsZpLiLpYXS3phsnz0JpHVPD4SpmF79DAHEeeNZ8NyFg9Mli5lzOE8n
 MQFt8wdWa/gdnc2v83Zft2y41pxlITfRtlOdSTeczEOSHxtXKC4I5/cgkc/7hWmeF1sARHaPGau
 LK72bjNoioe7qqwTgZ6pe7vQzQPgz8vl/GTPzvLKA0ztAb5jNrR7GbsUs+j+kiiGLx23gx3QsOY
 2GrhfFl+S3CjYvyfCKCC/VSORv0RHy0x2phHOKZrqZxgXbpYKbBZZ8ozEMDI0d6cyGSwcIq6JxY
 qNd8ddwIEwSus6+f1WVpdzcI+v2DDKOd2ecQDaS876hrDLx+A0R9z79XnpJRkWoY5pvbZncomHo
 dYVKYNN8FC9NxQPkw4s4Itbc36IOdA==
X-Proofpoint-Spam-Reason: safe

On Wed, Nov 19, 2025 at 11:38:35AM +0100, Bartosz Golaszewski wrote:
> On Wed, Nov 19, 2025 at 10:58 AM Charles Keepax
> <ckeepax@opensource.cirrus.com> wrote:
> >
> > > > > Hi Charles!
> > > > >
> > > > > Please give this a try. It's only build-tested so far. I hope I
> > > > > understood correctly that it's the SPI driver that needs the "cs" GPIO
> > > > > from the pinctrl.
> > > >
> > > > Unfortunately it fails with an -EBUSY on adding the MFD children.
> > > > I will investigate a little more and report back.
> > >
> > > Does it fail in device_add_software_node() in MFD core? Is it possible
> > > that the device already has a software node for some reason?
> >
> > Yeah it seems there is already a software node, although somewhat
> > at a loss as to why, the only ones we add are inside the SPI
> > driver. I will poke further and see if I can find out how it
> > acquires that node.
> >
> 
> Let me know if you figure it out, I'll submit a v2 that doesn't drop
> the undefined swnode.

Cool, thanks for all your help here. Might take me a couple hours
but I will get to the bottom of the EBUSY thing, and report back.

Thanks,
Charles

