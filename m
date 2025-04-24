Return-Path: <linux-spi+bounces-7733-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88ED9A9A446
	for <lists+linux-spi@lfdr.de>; Thu, 24 Apr 2025 09:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 440F1188D7C4
	for <lists+linux-spi@lfdr.de>; Thu, 24 Apr 2025 07:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1762248B9;
	Thu, 24 Apr 2025 07:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TZv8Qa9S"
X-Original-To: linux-spi@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2052.outbound.protection.outlook.com [40.107.105.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A71223DC0;
	Thu, 24 Apr 2025 07:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745479934; cv=fail; b=tttBkQKLPWU9UA+k+SIuz6Ljg3fSyrNxs2Fb/+62gVTP7T+C9T8MidFhsqmLNzExGsfIqkOxqHT8iRZ5VfAAiydO9bVyw+Aur/OOTkBcEk7v3ih0DhwO1zuKi/BQSIZh+7JgNEcQdGSMTu6qjqOxKWJprLkIsYyJ2raALENQLrM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745479934; c=relaxed/simple;
	bh=IP3p/KtBzS5yNgxKYF3tz8DY4yRZ+scAAK7FWlHzYiY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=UeAsvp/W1AzZW4dPj0I4G36FeLjFTw3dqW4Yg2C1BYMKq6PE3WaTPEGhp8B7lc5iAC9eF4EHahr5blUh9exikpDQSleSqD5SXOmZbgX7bj6g6J3LqkHhTvEgabTO6nE2siKcbc/IjEnTpkoSEoEkWNmivN2SyzlDOZXd5Zbhhag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TZv8Qa9S; arc=fail smtp.client-ip=40.107.105.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mE2gnatWV+KgdwGf8wPX6sYLn6bvPcRaSaN8z7Upx6uPMfc10qT8sdwZ/e3T9cUrHM+gw1wqyd5n7Sy0IQrYUgf2t9hkbdv3F1QgQH8HNz0Aryplu9MaC7I6fZop+tkQhaR+XC/ZcpppY6avA71E+li23sq7rpSqu2IzWZFsdQLVA54g5wfUqYJJUcO7Csd1UgFt4dnbfVaGO+zoE5dx/UYWJb9IUOJ2yckGHOd79PcvB3dyBbU249bnE1dEN6qzCp9s3ce4yaKSYrxENFXstcqxmit8WkwCwJVrhLx4fLqU11SGi86acdOtx6qlvrU/LXGSLESFi51zDiUMJHcZRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1dKCRkh0xRvmKLB+F++gZPJINuURNVf2TYJdNTjAgLU=;
 b=jxqBKENCR6ZHgWj+RPtp5LcgqxK6bgROFdA61hUBbFx8oBeHJi49YGI3ruU+5SzYOb13RjfHldbTM9pFrus7hIBKbemmozDGjqozacsm51eN3a7pK+i1JNhBS4y4x0ao/45LkXvbuDy3eL+kKnXT8yWooPlglZp13qkirxcouTDsj/nvtVqOosHPebngdKmx9ztWpMOH5ovqa4Dz+CG+WSm4nsb30/lHlsX5iZK8bnd3AqRZj4oUOYprTWQJKR0bcYqkmD/Ho0YTuBKb6Fd+JE985e0HyK3N5Hg2UY3oGDbV6adCOrQL1f3EE+xHTu7wfwPSC/wC3TovvAHnPlLMUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1dKCRkh0xRvmKLB+F++gZPJINuURNVf2TYJdNTjAgLU=;
 b=TZv8Qa9S54ce6WD8fWqTijhz9g6xjvdxcW4Bb0Ny06VS3iCkdOuONVKv7LKpMA8gi3xQfiHmA6S9oordTi8pKG7BfpW85NpAt3QeEC1CaYjfrp/1pGqmu/Mz4cLtFg5KqkJrjYoCBgIAokx7DEIWJQ9hJJP0PUup4V7lCtFgrEz1aPZbNmeLepPEXTroREUcJe4F2ZAHrgrhAz33jYJmjj5rsM6vR8h0H1EyXjGV9AGCf4nMQvxT8NqMSfXFqZFxhbzHEvpNafaiie1KuCt2mRdJHJl8RZMQUZg7TFNCtiqKIiRhqVCgKU200l+oaR4boB2SZdJY2jp0iTclFBZ3Ow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by VI2PR04MB10594.eurprd04.prod.outlook.com (2603:10a6:800:26f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Thu, 24 Apr
 2025 07:32:10 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%5]) with mapi id 15.20.8655.033; Thu, 24 Apr 2025
 07:32:10 +0000
From: Haibo Chen <haibo.chen@nxp.com>
Date: Thu, 24 Apr 2025 15:33:28 +0800
Subject: [PATCH v2 4/5] spi: spi-nxp-fspi: remove the unchecked return
 value for nxp_fspi_clk_disable_unprep
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250424-flexspipatch-v2-4-e9eb643e2286@nxp.com>
References: <20250424-flexspipatch-v2-0-e9eb643e2286@nxp.com>
In-Reply-To: <20250424-flexspipatch-v2-0-e9eb643e2286@nxp.com>
To: Haibo Chen <haibo.chen@nxp.com>, Han Xu <han.xu@nxp.com>, 
 Yogesh Gaur <yogeshgaur.83@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745480038; l=966;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=IP3p/KtBzS5yNgxKYF3tz8DY4yRZ+scAAK7FWlHzYiY=;
 b=CkDNKGNajKz3+GFiCnzI1n78rSewxFIJdlOCqM8Y+xTrhYhxcncNp3d0E/oD2pVYs34zeSrXU
 ULjwH3y4hdrCOaJDK1Jsll8DiOTUuhb0lD1oiCIzeyUj5OcmGF9LOwO
X-Developer-Key: i=haibo.chen@nxp.com; a=ed25519;
 pk=HR9LLTuVOg3BUNeAf4/FNOIkMaZvuwVJdNrGpvKDKaI=
X-ClientProxiedBy: SI1PR02CA0055.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::16) To DU0PR04MB9496.eurprd04.prod.outlook.com
 (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|VI2PR04MB10594:EE_
X-MS-Office365-Filtering-Correlation-Id: 69843582-a00a-44a8-f66b-08dd83021fa4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?anVOYkFsSnN4b3oyRWRheUR0dHppcjZlci9qTFB6bnIrbHUxRFZZclk1d2s5?=
 =?utf-8?B?NjV3Y3o2Rm8xUWtQRnYrVWNJcjFqNnFjcENZOVVFcFJrdmF0NkFTdWJvR0k1?=
 =?utf-8?B?bThtMzF2TUNseVM2YlBhcjBRblg1Y01JVVdMdldjbWM1U0VFK3g4cEJ6WkJq?=
 =?utf-8?B?bFlEUk9DSVlRYzFabWdReXNTWHpVV3AvVVNpY25SczFJaFhOYXc1MXowRXlR?=
 =?utf-8?B?QXYyYkxpTGtZTk5vOFA1REsyV2lWZithS3pNbEFGYURxc2gzSVlhblpBNmtP?=
 =?utf-8?B?VHgvSGNWMmJra1JBcFZDTzNCQmQ3d0dBcmpsVU15K2N3MkE4dnZMQkgyVzk0?=
 =?utf-8?B?OElCNmxMeUdwQWxyb3JGS3h3ZXhVT3dQamQ4eDJUek93SkJadFhJUHdLTFVK?=
 =?utf-8?B?eFNsS01IWGFzS3c0S0dXUmRiUlV0emtITUJwUXkzcm83YjdCcnhudWNVUHBk?=
 =?utf-8?B?S052UnY1dGg4ZlpPNzdOM3A4Wk1QZVk2N3FBWURLdnBkVWVnZGpuOG03TXp0?=
 =?utf-8?B?RUlDZnJkd3JCcFo1UnFZSElDV1p5dmVqOXgzdXd1SVFkZy84NmZFSHVwV0dT?=
 =?utf-8?B?a1pibUk1SjN1K0t6VE5jVEFYZk1waGtwTERVNU5GZ3FkeTRtRTd5M25qMmxt?=
 =?utf-8?B?aXJrY1d1KzIzQnpOY2kySVNnREFqcnFCOU01aHQrRERrcWVhTjdTZlJSVkha?=
 =?utf-8?B?eWhNeDdXcDVUTU5NMXEzalZJaUo0eE9QM3VOYk1LN1RieXg1Q2RxSmlpMmlO?=
 =?utf-8?B?cE9RTHF2UVR5RnMwK0NzNnppS3RBdlJvZXhkWDdxUkNOM3JtZzZXOTNKTFJY?=
 =?utf-8?B?ejk3SXpic0ZmVi9hTy8wTkhoamdVVW0yRW9teDBkUnA4YVlLb1lqTnh5TFBE?=
 =?utf-8?B?allPdllvVDBjVzNEZjliSGJqK2tRbkRRb2x3TjUvSEl1WE1nTzN3VkZlQVg0?=
 =?utf-8?B?blpDNTFpN0RXM3VITWE0Vy9vZzk1NTN3YmZHUGk5RlV1Ykdqd1ZxSmFLRFcz?=
 =?utf-8?B?bXc2Q0s2cEM5V2NhbVR1bEU4TW1jUndoY0U2MGUwbk1NbGszY0NpdTJva3Y3?=
 =?utf-8?B?OWpzQnpVc3ZNdy9MY0dXbnI0SHNaMlM3NitsaDFYakxUYURUOUJlSVdwcENP?=
 =?utf-8?B?ZVdGTkk5RXhGUFNqOVZEYXoxTXRWY3VBOWdkWS9wT1hYVDd3enlvcHVWQzcx?=
 =?utf-8?B?bFFLRHRrc0cvL0hkN1FXUTdKdUJQVzlGc3JiQ1RBQk5CdjJHTThZNXU0TEhz?=
 =?utf-8?B?eG8xZFA1anlhaEl1QWlJUko3QVI5eFVEK3F2eFU5VjBBYmxyVEV0TFFoRVpl?=
 =?utf-8?B?ODc2dEpjTVFVU3F4Tm1BREN5bHNad1BVc0Ivalcxa2VicExvVmw1NGhseU9B?=
 =?utf-8?B?VnN0M3FVdURFNWlZenUrOVphM1FDaEh6d3d5LzVLeDkycWdReUh1Sm1TRmNq?=
 =?utf-8?B?OEI5S3crbWhQL3cvcVF1VE9CY0hvOWg3aEJ4aVh6OHNxRjg0OEwweXNSQmpo?=
 =?utf-8?B?MzdkakFsUnNoVzd0NGx6VUpxeDZFWXUrVjdUVTdpU0djeVFKaklvTU9SYTNn?=
 =?utf-8?B?QXFSdEMwT2dLbkpOazdaamloUWsxVzVsUUdkREwwLzJYQWt2WFN1dXo4Mk50?=
 =?utf-8?B?YXFzVG1oYm9QcWE4Y2UzdFV3TGRwVUh4aTVIY3JGVkJOSGk4bVpQQStsWFNI?=
 =?utf-8?B?MU1qWVpaTmFSYzIrcWZaMGo5aTBoa2o2Uzh2dG5TQ3NqYnNSUExoUENFV3Jz?=
 =?utf-8?B?NGFWMXhJcEZCTTNSQjl4T2kwenROWm9LUzJJdlVOUTBFWUpFb0hxWTI2aFhJ?=
 =?utf-8?B?ZzdEMEJDRHZqaUQ3b3laQ3ZERmhPS3kvc3M2OGh6azVPc3NrZjBCTWQxWDhv?=
 =?utf-8?B?b05JUWhaUW9CR2JHR3F5TERjM01MRjIzWGNCaUNsYzNJZFAzRm9FWjFZaVhn?=
 =?utf-8?B?SlJNRWUrQzVZQlVzRUlTYkRZbFBJMTVTdzVNcEdrbTYzMUhvZU13MjJCb3BQ?=
 =?utf-8?Q?GRazrGzCQCLMY+rEXJlqMveo8Pj3RU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WFpxMGY5eVNmSVRDd09VOFdySlQ3WmVQbEVRWmtmUkt2OC81MUZ6UHdKMHVk?=
 =?utf-8?B?MFZrVUFNM01LUVQrM3VVc3JldU5LKytjakVMMVR6S2t3R0RCYjN3aTJzTmhB?=
 =?utf-8?B?SFVOSXRxSnJLemU2akdwZmR3ZVZ5THRnNURWVTBKVVlnOHZZTWRhUis4OHRR?=
 =?utf-8?B?L2QyQnQ1dmxWQVoyWDFPYmVnY0MzYkc3UUM3cHg4b3FVVjk4VmFkeG1YVklM?=
 =?utf-8?B?L3VqSkIvS0ROb3czTllqMktmUWF6Z2NJYzhhZU51Vk1Jd3NDZiszektOSjYw?=
 =?utf-8?B?SGhWWEtHVk9mNHJQRFdpZExEWmF0cXFqemdnYkkzM0xXemlnSTZrNkgrMHBV?=
 =?utf-8?B?c1A2ZHdiVGR4a3c1c2tzdTVXbXlXdzFBdCtKcXJkM3JWbVJ4NmFwaDY4cHdB?=
 =?utf-8?B?Z21KWlhha3U2WUo3N0dCV2lFbkswK04vbHNqR2tTS0h3dGVwdGRQVS9LVThM?=
 =?utf-8?B?dExhdG1VQk1nWWljNDlEVjBwZklhYWhDdmhpb1NuT0tLei9IRFUrTCtVTUdJ?=
 =?utf-8?B?TjFmazJ0K0d1Y2lubUc2MEJ2Nm5kZ3lWYXlNaVluWnluU3lHdmNuTmFWcS9L?=
 =?utf-8?B?eEJLR2hYbGh6cFlwRlNjWFV6ZnJiSVVSbWxiV1gvRmdmeit1WVdYcS8waDU5?=
 =?utf-8?B?OGJqUHE0VG5CdG9FYXRWRHdqNXpZRzVmcnRvcnFTWnhBNDAyQzBvK2QwMkJV?=
 =?utf-8?B?NkRtQWpEUE9XMGVySnFkdlM4TFJubStaYjZ5VytDSDJoZWhFNi80RWJ2b0RO?=
 =?utf-8?B?RFpSUTlaMFpZd0tOUW10aklITHJiR1ExTThOYWRvb2VwNlJrdzRUWEVod1RT?=
 =?utf-8?B?UWppU0IxUnZUdlJSSDdQT2paQ3dwdzlLenZVbkEvU2VNWGNLZzhxQkxnb2hG?=
 =?utf-8?B?bklOVFRsekJTL3Z6OVlrWFVsRGJQS25QOWlrSTJBcHNRY1ZWR1Z3TnlDc2Yx?=
 =?utf-8?B?b1ViUmJmNGFLQTlBOHNCaVNKVHRKNjRMeEl0aDI3L0IxS2k3MFA0NVh5Vjgr?=
 =?utf-8?B?VFZYMVBUYU5xWG4xUitNenJjb0VValVhVjdXaXN5U3RPTkF0NWNwQkZlbEM0?=
 =?utf-8?B?S3FzSXBiNmxkNnlmaTc2UHNOQzUzWFMvcGVMV1RuY2F1eTFlVnZ4bFo2VnZx?=
 =?utf-8?B?cnREMFRadkd3bG9sc1ZwcVhkUDVGNXArazVPR1JEYjZxSEE5RG9FV3M0eUVO?=
 =?utf-8?B?TW1vSFpVc2Y5WkYvUEFOeTF2bXlrNTZ2alJpc0Vkdm01U3pLakdpQVJSdDVR?=
 =?utf-8?B?YlFIZnNBSTRUcytOaVByZ1FKaUY4OUF1OHZ6SjlEOUVWazZzc3hYZTc4MzVx?=
 =?utf-8?B?VllhK002TVpGUEl6d2ErM28zVm5xWG5uekxJNUh3NkxuU3lkaXhPeG1XYmRK?=
 =?utf-8?B?SUptazNORFhHdkNQbVJYQnVya3J3SzJIVmVQeEJMUXpPeC94ZnZVQ05iRU82?=
 =?utf-8?B?b1R6SStlVkhsR29WUVNIWnhSaGhUVWVheFp1bXJmUnZlK2ZhL1RPTFoxQXBi?=
 =?utf-8?B?SVJ3cHkyQ2lYSlFPZmVtekljbzdWaGh4WUEweXozS0NnV0dTMTZaaE5TUWpK?=
 =?utf-8?B?UHpvcnBIQlF3djN1THJKYnFhZVlNMUdjWU9KRFVoUDVaNTNrOG5KUHMwalp1?=
 =?utf-8?B?a294VWlqalJmNkNaa004TlZKQVVVK1NzdHdlSjJBRXB6VDZ6cVdSVDJaTm9u?=
 =?utf-8?B?OWhIREwzTGlTcHlNV21neHdoV1ZkRiszVVlGZHByVGZqOCtJanBTZFR6c1lT?=
 =?utf-8?B?RGlCbGtSNGpONExtM1Vsbm5CSk5KTVoyZW4vL04venJSQmxHR3F3M0hiRmpG?=
 =?utf-8?B?cnpTVlpwbXA0Zk1iUG9EK0pPMk5UeG9ZVFZ4L2pBenFXdXN5bFNkanN0c1BY?=
 =?utf-8?B?ZStoOU1Dc1BRYmRaaTdra21uY2t6U25wZi84NkFGMm53ejRGdUJQcW0xSU8v?=
 =?utf-8?B?UXoxQXpIOEgzN1Q0R0diL3oxRmhMVk9OUU5qRllnbjF3eWlFaTMvMVdrK0Jp?=
 =?utf-8?B?OHVNNlhEenZnNkdwMWF0ODBuYlUyMXhCUkhxbEhNY01nZy9tTHdlM0graGlY?=
 =?utf-8?B?SmdUd2hsZlF5aUplMU9vdlFuUG9EcEpId3g4a0h6dG9Kd21wME9zQ081RFN1?=
 =?utf-8?Q?D37OoDzKtW7/d44gFbfqCxiCQ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69843582-a00a-44a8-f66b-08dd83021fa4
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 07:32:10.2445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: POv7VojfOuCEYcoSsZkRAls1FZuuJLQPnDfYARKvB3hBDQJ+B3H4wSycEvXFXaFf/46bzCiw3XCnNg/ic5e2vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10594

For nxp_fspi_clk_disable_unprep(), no caller check the return value,
so remove the unchecked return value.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/spi/spi-nxp-fspi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index e001c7241269ec8d3fcae25cb6a36b5e47600066..5be7809b4a494e22ac79c07b99cfe8b2fa430ebe 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -634,15 +634,15 @@ static int nxp_fspi_clk_prep_enable(struct nxp_fspi *f)
 	return 0;
 }
 
-static int nxp_fspi_clk_disable_unprep(struct nxp_fspi *f)
+static void nxp_fspi_clk_disable_unprep(struct nxp_fspi *f)
 {
 	if (is_acpi_node(dev_fwnode(f->dev)))
-		return 0;
+		return;
 
 	clk_disable_unprepare(f->clk);
 	clk_disable_unprepare(f->clk_en);
 
-	return 0;
+	return;
 }
 
 static void nxp_fspi_dll_calibration(struct nxp_fspi *f)

-- 
2.34.1


