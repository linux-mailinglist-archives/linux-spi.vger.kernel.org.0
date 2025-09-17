Return-Path: <linux-spi+bounces-10065-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 353E2B7D0D2
	for <lists+linux-spi@lfdr.de>; Wed, 17 Sep 2025 14:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4133B463641
	for <lists+linux-spi@lfdr.de>; Wed, 17 Sep 2025 07:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903F3303A12;
	Wed, 17 Sep 2025 07:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YHY41hDE"
X-Original-To: linux-spi@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011009.outbound.protection.outlook.com [40.107.130.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6534A271468;
	Wed, 17 Sep 2025 07:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758094074; cv=fail; b=OPSfpyWz2XAyu622DDw62CXHklNuCep6o55PYXwqXyb5ztbHKqIjOUjmwMzJIV/KM4dOq49hPhrG61d1k74EMeso2xfGHrNiQWKFvnOveGsLGvlr/3jOFTJg1XJiTfa8UG4ujAzZmXZXhgv0DfmwhIFWqLr7oZLRlemBvR6TJHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758094074; c=relaxed/simple;
	bh=+aJ92F3gnNgw/1jCe1LYU2CFm2OJgpxxN8BwsUKbwY0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=qoU0hX54A73PGHZuTX8hkz3tnbbDZU3gkbqtlQyISVOUuhZyDNcZDSwHf2Nf26Ky0m6caJYjoQaGE+6dqNYuEuDRtABylLW1NgylnAdwCnvavGtPFZ2UeQ8TupK0Ze3mE0OCI4iMYzoPSr9Em7VBfAbZ5Nf6sWpNFrwonTrl9aE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YHY41hDE; arc=fail smtp.client-ip=40.107.130.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WYwbTxBZ4uR6JH2Ppj1w4pJRLdsIYYX/h4rKjpR9qwqx2T4BKtemD+s6kMfQOxw8LJG/i0yHLliqzIKcZDqdXpGR8FYNmwufQUHZwiqmqndrlLYATac86ESU1JKSD+bkISaIvwhUvZhIOtaTdnFCxN63LtyH0KPYTA2+mtIpxj39pCMFvnh3ZDfxZIRlhS81VRUcctxIqcfAthS7uQbxwDADTTZM5Ya9fdWm069jkMHghVg900q9fyp/YVlyQulBdyeIt7Ly6VhXmKMiZYvD6KqARNZNl9xzwFXgmKMBuPlpQmezYkS2q8BpWtuH0I0s6YkavSdUJqj0kpWd72AAMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2jPe6vbW3xMGag555bqGSeSR94VvjTg6eNt7zQ+0na4=;
 b=PR28Vr3r+tdtxGJ01FtMoQnepnXaNJKGzhlERea1qEq7W2ERzMdUnXAAKqEvPzfKoyEtPgjlnwzs1pdMJ30N1pdCcX3ZFACsadQKHfbFP3SpT8oWuyKlLukPDNg+3vz71QbzbH9ZXTr29AolIKl0yZqrY0GNkEclkW9fRfm+262V9/LNtSpFURkYjvk1Zswy5+8O2l3rCRhBTfShZhD/eRedazvS10/xwEf+hEYX3sXgpL4Iy1+Lc6MLeK09WhBteQ6NHfpJSyKbWUjwr+A9XFqLo/thAWE+LELz8VNlJtwrQ2kE0OtPBPifN8hI+wxhsnPU7AqhwhybvpycUHrbOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2jPe6vbW3xMGag555bqGSeSR94VvjTg6eNt7zQ+0na4=;
 b=YHY41hDEANe9jBwgtHuBj4Qa9gOfICAZMQjH7ud9ATF4sY7p70DJ4lIfvGEnJf4vmYGE/EcBmtVxzhhIDNfx/Dv14LVnRIxHiCKAgxA3XwuU9jNqqcRuGtiFFq4ULHj+Kau2U6/FA/JtQ7MSxJgqRecYFtEcHspEbF0hI+LGGTQZGlcCS6EeVhEOGDCU12523dL6lnT/yJBf7Gl07THhv7HJqC4UkVpvtO0YpdMjcjncUQDMIgETNH4jM5ACuptosVzJEO2uOYTupcAWLOJD7Fmj/KRF3RVsWzO+UvAeP5j1NY9HfjyCOa0Ttqgtd4wuh4gFE8NztrxEFsKy/bmSUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by GV1PR04MB10800.eurprd04.prod.outlook.com (2603:10a6:150:203::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 07:27:50 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33%4]) with mapi id 15.20.9137.010; Wed, 17 Sep 2025
 07:27:50 +0000
From: Haibo Chen <haibo.chen@nxp.com>
Date: Wed, 17 Sep 2025 15:27:10 +0800
Subject: [PATCH v2 5/5] spi: spi-nxp-fspi: Add OCT-DTR mode support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-flexspi-ddr-v2-5-bb9fe2a01889@nxp.com>
References: <20250917-flexspi-ddr-v2-0-bb9fe2a01889@nxp.com>
In-Reply-To: <20250917-flexspi-ddr-v2-0-bb9fe2a01889@nxp.com>
To: Han Xu <han.xu@nxp.com>, Yogesh Gaur <yogeshgaur.83@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Frank Li <frank.li@nxp.com>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Haibo Chen <haibo.chen@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758094070; l=2074;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=+aJ92F3gnNgw/1jCe1LYU2CFm2OJgpxxN8BwsUKbwY0=;
 b=wasocU6rYgQVf6YX4dsrjUdX64W4eqt/bM+n/Q1aVR0RpUa5x/VkNXlLYvp711cpcQmSE/pRd
 rubQzqQU4XTCNrZSBwbvKUDN2OagpdLlVoK4lK4eHtZ06Qo36FLMuUO
X-Developer-Key: i=haibo.chen@nxp.com; a=ed25519;
 pk=HR9LLTuVOg3BUNeAf4/FNOIkMaZvuwVJdNrGpvKDKaI=
X-ClientProxiedBy: SI1PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::6) To DU0PR04MB9496.eurprd04.prod.outlook.com
 (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|GV1PR04MB10800:EE_
X-MS-Office365-Filtering-Correlation-Id: 66c75660-85ad-4cfb-d453-08ddf5bbb4f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NFZPRVpoQTRzK0o3OXhtcnBqVGYwZE05ZUswMUhXamZBK3Z4U0lYNkpocDE3?=
 =?utf-8?B?aWZWaXBZUjR0aUdIOEZEZUMxWitUZGsrYTY0RDdkdXcrUFhOUTM2QTNUQklJ?=
 =?utf-8?B?OE1XUi93NjFrenpIZkEwdXVhUWRVUHZPalg5Y2RKaEw5ZCs2c09DeDYxMGc0?=
 =?utf-8?B?eDF3b0Fra2NBT1lUUGhGeWo2QUMzVE8zNCtnVDYva0NmVmt0MGIzcHozSy9R?=
 =?utf-8?B?UkhxV3pvRjVVK2hZTk9BSEFOR0Zsd1JnUmtMOGtSRWNsRjNNQldvWXlvdGZU?=
 =?utf-8?B?RitaUTBKelhzbktQa040NW05ZXI5cjRtMndvdkJNMkNVbFZiRkVldkwya1I2?=
 =?utf-8?B?dC9ZWStMbDFyQ3pYb1NxeXRybFBLSVloQ3BKNGF3Q21jU09lTVdCT2xKeWtL?=
 =?utf-8?B?R0JYaVVhUVpKRlJKT2l2S3plQXY0aDFzRTRKODRoREVMTzIrZVp3YnVXbDBt?=
 =?utf-8?B?bmErWUh0eFB3NzBIa3ZWaS9nVnd3SjhrNnZRM0tuTndqc0xVTS80Q3o1SkNN?=
 =?utf-8?B?eGRNNW9KV1RvVVBacFl5NC9SME9JUDFubWJyMi9UTGhjV3dad2lGZ1BVT0Rs?=
 =?utf-8?B?S3M0TDBkV3VsOElEbXVXZ05kQk0rTkpMc2lpWW9Xc1BrSm1hbytJTHpmemRT?=
 =?utf-8?B?SHlOSk1hL01tZGQ1TXVLRURaeDlSVEp2clZRYitVVUhDNUl6MEVSQUpaT1dF?=
 =?utf-8?B?R01ESWExVVFJbEJZL1ZJZm53TGxXcGhmNjF1bEVlZ1JkMzVtV09ibklYV1BB?=
 =?utf-8?B?S1MyU2Jtd1JFWFVSdEVPZjgrVGhGbEdhQ3l6V0hpTXJ3YldBbGh5b0hVbEJh?=
 =?utf-8?B?czJIVW5wNUJ0SFZTbDd0YUdHd0kwaDdMWVFDNnVKdEd1VjJmYnBtdFdRYWFD?=
 =?utf-8?B?dTh3OWllbXUyU3VabUFSRVFVc0dGVGxZSUh2QUk3RVlOZ0NQUUpycU9aUUhr?=
 =?utf-8?B?SmxJV2RaV2tZV1MvUDdBbVgvZHlmNTZ2cjVGZllpUkpZcmowMjlBTW9zMFli?=
 =?utf-8?B?bElhdkoydWhnK1paK3pDYWFQUGowdTRRME1zZmF2bGg1WXZUNjZ5Zzh4N1Zm?=
 =?utf-8?B?OVdXZit6aytucDRjNXBxdDNkNGZGNnVjdlQzOWU3U3RCWnVMUjVCU05yUGI2?=
 =?utf-8?B?cHVsSzJuanRmOXVCSW1vbDY3MEtQQ2huajNMWS9WNVJhUDJLU1N0OFlxUmhy?=
 =?utf-8?B?Z1JDMm03ME9JWng4bUQwdXN2T3ZzWWQ2ZTNKcjVKSUxKOTh3U0V2MnBwMmdh?=
 =?utf-8?B?Q0NOZDJ3VVJsZVUyMEN6VmI5VU9FWEdURTMzN0NLZnZPV3Z4Vk1YZnpxcFNo?=
 =?utf-8?B?KzRJRHVzQjVNRmIveWhsNkIwblpnSk1ubjIrZ1ZxL2VYdXlzbHQwTG1GUWtw?=
 =?utf-8?B?dStjb3BZWkg3S093N1hFMnpKVURMSmtQNDk1aXdhOGplOVMyQ2hlSXdNRjVW?=
 =?utf-8?B?OWpzNURUcnVyWmY2WFJ1WUdZUXREc3B6VEpweUQrRjJxNDJ6SHpsWTJmY2FQ?=
 =?utf-8?B?Tk9kNkdWRGp5UXByempvSTQ3SVQxbFJxVlB6U1EvQTdRYzZ3WWZoYVhZVkN2?=
 =?utf-8?B?NzVXYjUvWlppU2lkbUo3VmVDaExMSzZxQWhkTFdrOGI5TWNYME5CbC9XRGd2?=
 =?utf-8?B?cVkyYVZTODhwSkpqMHBjVCtSWlNQY3MyZ3J4dkVGNFl2cnp5VUw5YzEvWW9k?=
 =?utf-8?B?Mm9uU2hxcktBU1J3MTRmQmhoaXlJVW9Pdzk5YUhHYWp0OEhjckhyeEpueG9i?=
 =?utf-8?B?Wjh2eEZjU3l3cXdhRHFkTUgxUXpkMW5ocS9MaUFUUHh1UTlMMEptMDllQlkx?=
 =?utf-8?B?RVRuOHpxeGduQlJVSlY1M2tlNFJYZzd3TG5nQzlReU1LZm5ScHZGbVVRZXEr?=
 =?utf-8?B?dlBLRWlYejJkWTZHaUF4c3ZlMUN0dnRvbHFjbVZ4VlJJNHVRWWxOYmZ5RTJY?=
 =?utf-8?B?WXdESUdOL1daR3RWMkM1VUIyQlZYYkovZTl3VER3S3J4UHJROGJIY3NHWkc5?=
 =?utf-8?B?NVV3WHQwN1lBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(376014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bWJxU2JJeFVESHUvV2hkMUw0WTByZ3pUWGowQkdiR1IxdEd3RHlTdld1bDRK?=
 =?utf-8?B?dktwZVp0aThVaGZ5SnVLeXUzeEl2Q1ZtTnJJSEtGSjJuZGdmR3JWTnQwSmpD?=
 =?utf-8?B?d3JNeVdpYXVIdENBQnFrZG04Ri82MDdxTFZ5SGtBVmd3bkRJN0lnSFhNcFlQ?=
 =?utf-8?B?QzdyNWtwd0ZWUFcwR0VRNW5hRmlqNkUwZ1BnYTZmTVgwYzdCOENtWDg5WktJ?=
 =?utf-8?B?bjFZKzdtWEJTY2haQnMrb1labEtjeWUySjM3dW5zLy8zM2dqVTczcmNEV2VG?=
 =?utf-8?B?WExLMzJrN2oxakZjQlBsczViNmlTdXR6cmVpMnhHU0hucnBZWmMyQWIrNlg3?=
 =?utf-8?B?M0lvSCthalFkczdqNlFSUTVwVE9zeEtqYlV1S0JXRUpqRDBudmNhMVc3cGZl?=
 =?utf-8?B?dGVTUmZTNVd0Z2FpWndVaDhXMmNtblBpZ1NwVU1Hb1RrTUcwaVZkSlBkcitI?=
 =?utf-8?B?WVV2c2V2ZXhVSGl4NW1mNC9wLzZNSzhZbGVxSW5tY0NCOVB4V20yeVhlVklz?=
 =?utf-8?B?bHkvMklHNWRaclVHeGh1Yk9ONTdGbVNKY1NoWS9GWGpwc0xHY1pyaUV4NGdi?=
 =?utf-8?B?aWlHRjYyNjREaEwvZy9QTnVnSkcycEl5WnRzd1VHdndmMlZFOTVLTHg3SEVx?=
 =?utf-8?B?dEdRQ1MyYURXWFI2eDNsSWZDc3gxR2dXNHJ1S3pzUnB3djhLVVNaNE5SanBm?=
 =?utf-8?B?WFFDUnE0akEvSXdhcEFCbUx0SWhHTXVLNnlpbSt5Nndjbno4ZzYvRDMvelJZ?=
 =?utf-8?B?SUtKMHRrNDkrQUFoVmhzc3lieDV6cjBkZFRYWkJNdW5VWmMzMVFqV2V3UzQy?=
 =?utf-8?B?RTYwaUxpcnI3d0ZnL3JuVzU3TVFoTnB6eDRRWVMvdUZDYWpBM2pTRS8zS01H?=
 =?utf-8?B?end1WFgwaWM5UzM4MFp4aGh1VTlVQmhLWWRZUWZ1OXUwVktaYkdjUHQxYTVY?=
 =?utf-8?B?Y09lYjlGMWpiZVBiWkVtcW1LQXZxaU1kNTFvWlBiYkYwdlkycG5nclFZVmk2?=
 =?utf-8?B?ZytTU3AwZGt0TmtycDNtYlA4eWgzalNmRjJ3bWZXclczenluTGZLQnYwY1ZV?=
 =?utf-8?B?bGE0c2ZwT213WEREcWMwZUg4QnlSTlRTaGE1NkR4RGVFWkV2WUpNNGo2aWFF?=
 =?utf-8?B?aE9IQ1A2Nm1KeWU1RitKYWJ0Y214ZUo1TENQMURDeXZxcmZKV05PTU5YKzJa?=
 =?utf-8?B?eFpNSUpkR3pLRmxJY0EvM3dTUG5QNmFIcXp2ekRtK3ZLdHpja1k1UWJ1WWg0?=
 =?utf-8?B?eDlVQndXZEtrVTJJRjBCQ1hzMjkyeDUveURkWDJGY1pWOUtZSGRUcUN2dGNG?=
 =?utf-8?B?L21YQis4SWZTY3VzampGMEJvZ3pENzhHNjdnVjZrVjZJVmhqVjh0MG0rNDdk?=
 =?utf-8?B?U003ditvT0FaSDZ3V0w0KzZiNi9oV0g3SXRidUZqcURaVmw4cUhOaXUvVnJ5?=
 =?utf-8?B?TWhsNkRjQUN1aWhMMS9QOVpnaWhLN2JZVW90d3VGZVZKNjRJVjFxK1JGWW03?=
 =?utf-8?B?KzB5ZWhLbkpocXFSM0Q0bTFlcFAvUWRRZkdPRlFnTHAyTDhrV2RVbE83S01V?=
 =?utf-8?B?U0JFTHo5WTNXSEJTMzlOZU9TZ3FQNnRqb082WHBPTy9oVUJ0TW9vOGUwSVZN?=
 =?utf-8?B?empPSEFOZGpiemI3QXlPRDM4Ky9icC9Tc3ZKZ0hJRnJvOVo0aGo4dkMydWhZ?=
 =?utf-8?B?anFoendLL3N0cWhHZkhkWlNRakZ5bUlBUkg4akt2Z0lSSUhLWUV2K0ltdWx6?=
 =?utf-8?B?VEt0ZVN3ZCt0aWRFdDFKSFVSbG91Y0gzZGJBYnU0cGMxOG4rNE5JSGlHazdy?=
 =?utf-8?B?ejl4M1pLazlxTU5UN1paTDRwaTFHL2NKemdkTnp3QkxyMkt2eCtGNVYxd1Zo?=
 =?utf-8?B?MTREWGZCUzJKL0hGbWZqK2R0Sm5VTXhHRFJHelZxSWdTQjJJTVAvQzN5UjI1?=
 =?utf-8?B?U2NnOU92RmNoQXVKNHBNWk1HZ2FUeGVBeVpCNFdXejJWVUhtQzB6Ni84OXNp?=
 =?utf-8?B?SldZZVprS2lLdTROMGdSSTdhYXUwSUdhVVFId3VFbHFMbDQ1bk14aXBtdmdx?=
 =?utf-8?B?Y3RhZGtLSnNmYWxQUXJkSnY2WVY1QzZuWHJOMmdtQUFYaEJVKzhud3QrY28v?=
 =?utf-8?Q?vpPHedBGxHY14pr1ci5taRCqd?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66c75660-85ad-4cfb-d453-08ddf5bbb4f3
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 07:27:50.2710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: szw+jXv6Fhzyl2yWBTcg/CjgwqEJc0Zk1ycsIf1IqatcEDFrr4MYU6gD0sngj8OxmyxJVrkpscF63ispai6kHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10800

Add OCT-DTR mode support in default, since flexspi do not supports
swapping bytes on a 16 bit boundary in OCT-DTR mode, so mark swap16
as false.

lx2160a do not support DQS, so add a quirk to disable DTR mode for this
platform.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/spi/spi-nxp-fspi.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index d25679fafad7a94a7ea2a79d7e3da53f4939c9fa..f9371f98a65bdc7e5eaa612c0770a6228bdda364 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -330,6 +330,8 @@
 
 /* Access flash memory using IP bus only */
 #define FSPI_QUIRK_USE_IP_ONLY	BIT(0)
+/* Disable DTR */
+#define FSPI_QUIRK_DISABLE_DTR	BIT(1)
 
 struct nxp_fspi_devtype_data {
 	unsigned int rxfifo;
@@ -344,7 +346,7 @@ static struct nxp_fspi_devtype_data lx2160a_data = {
 	.rxfifo = SZ_512,       /* (64  * 64 bits)  */
 	.txfifo = SZ_1K,        /* (128 * 64 bits)  */
 	.ahb_buf_size = SZ_2K,  /* (256 * 64 bits)  */
-	.quirks = 0,
+	.quirks = FSPI_QUIRK_DISABLE_DTR,
 	.lut_num = 32,
 	.little_endian = true,  /* little-endian    */
 };
@@ -1231,6 +1233,13 @@ static const struct spi_controller_mem_ops nxp_fspi_mem_ops = {
 };
 
 static const struct spi_controller_mem_caps nxp_fspi_mem_caps = {
+	.dtr = true,
+	.swap16 = false,
+	.per_op_freq = true,
+};
+
+static const struct spi_controller_mem_caps nxp_fspi_mem_caps_disable_dtr = {
+	.dtr = false,
 	.per_op_freq = true,
 };
 
@@ -1346,7 +1355,12 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 	ctlr->bus_num = -1;
 	ctlr->num_chipselect = NXP_FSPI_MAX_CHIPSELECT;
 	ctlr->mem_ops = &nxp_fspi_mem_ops;
-	ctlr->mem_caps = &nxp_fspi_mem_caps;
+
+	if (f->devtype_data->quirks & FSPI_QUIRK_DISABLE_DTR)
+		ctlr->mem_caps = &nxp_fspi_mem_caps_disable_dtr;
+	else
+		ctlr->mem_caps = &nxp_fspi_mem_caps;
+
 	ctlr->dev.of_node = np;
 
 	ret = devm_add_action_or_reset(dev, nxp_fspi_cleanup, f);

-- 
2.34.1


