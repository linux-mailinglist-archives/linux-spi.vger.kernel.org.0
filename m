Return-Path: <linux-spi+bounces-3512-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 566E5910DD9
	for <lists+linux-spi@lfdr.de>; Thu, 20 Jun 2024 18:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 104612812DC
	for <lists+linux-spi@lfdr.de>; Thu, 20 Jun 2024 16:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9A01B47AC;
	Thu, 20 Jun 2024 16:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rUT4tZie"
X-Original-To: linux-spi@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2067.outbound.protection.outlook.com [40.107.21.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC601B3F3E;
	Thu, 20 Jun 2024 16:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718902739; cv=fail; b=pnFvR8tEzYRuZ8txdOBVtI1gBPyj7S2P8y/3HUCxZt24zVFxwPWVjGIJ7VUQmH4awkzjGCYNxe6DB0EXISaxEwYOiTk+y5L+KktXUq6Po/xluYcsQ7LtulMa1Fen017dgZkILFZ2lPZ2i3tq7hRhqvLGZxRY3+nHpvz7E2jJG+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718902739; c=relaxed/simple;
	bh=MxLx60UxLPqA3/JaqR3fmiPeUnZUirZSyYTTD31/F1w=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=oHIgI/xCxfe+b77Zv8Db8VDWSpKrxonRM56NmQm/DC3I4QyCliX/or+a9zd5WnpxKdIET0flDnWn+NapIOOJtpQIrGAsBRcYbe+U9xKlHyfctRBZ3yN6Ljf7uk7f972Tn7EHKgv6ozk6K8auSeqF9AgjX0JENOCFj/6u/0j+NuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=rUT4tZie; arc=fail smtp.client-ip=40.107.21.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xg+rTt8f0DPYpBBxXuZwCVg/kNeD4owmD+4DaWWg7lhx//ARpevXiSETHjbU8E5UHpHYc8RI7an+BTM25F9cCWL8WpZTDLvID/kkOD/T9DB1OFPZKxx2KArZWBfEIreqR2iW6ETwFi6P0W7SsZ45km17rJb9Exj/MGlsfLf3w8QHky6Z8c3laVO7OO4rjPtiKRlYLMCwE5T30h3pjkm+PIkMQFafRa0W7yZadsxlaIzq4n22C1goXqtyW2fKcf29SSdXB+G1KoXrCuu8eL1cKW8f94FRcBlCQ9nO5hMtvhRqN1fjehkO1jXhBVvGaP+6+9ReScSkZ6yF1pHeErBQ8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2jYlbcarcwuIrebM8VfYyLt8aT9n6UjYjgSEaIlRc4Y=;
 b=mT1vNKJvfLuHTi2NPLBrQyUHmz+2ypD/ScGHBwiruZLrhqm+0Qh6Jgn2GwshBti1srCj4dZf0GmXD1C53sRfzbFJ6CHw4gdlAi6Qlu9S4cpwoUaMTb9IKc/+tItfakIg4CITuKfmRx/60HADk/YM+fBnUv97tKWPKhxNwuoxA1yHQ2yNXRO7A0vfqFOCXuQZ62SnSly/ZO9FZJifSZmAz6l9Ni0QrBrtvpo79Sh5Nj3NvdDu2MZwYtXj6k3Ch8IHthB+I1h7Gusg1qRSnjRKSxp7SO2G9fHY9PKRTwl4qR44F59Y5Xrb5QqGK3wa2hEOe6YWcgwh5THQZdxm/aw6NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2jYlbcarcwuIrebM8VfYyLt8aT9n6UjYjgSEaIlRc4Y=;
 b=rUT4tZiePgi0RzdSVDNoTTCcKxUsXSjaaSsDdB/YNNjIIRDeOhyeZc9A7GbECwoR0xbxQTMvbstRthirc2IFfP+c0lbHXJyo48yVdVfrpL5+a7wSxcO65WejHNQwfiUz4RS3w0x3hhIf37i4SbvsEhvXTJWby2HiMUvxoPSPVcE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB7632.eurprd04.prod.outlook.com (2603:10a6:102:e8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Thu, 20 Jun
 2024 16:58:55 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7698.020; Thu, 20 Jun 2024
 16:58:53 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 20 Jun 2024 12:58:29 -0400
Subject: [PATCH v3 3/3] arm64: dts: fsl-ls1043a-rdb: use common
 spi-cs-setup(hold)-delay-ns
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240620-ls_qspi-v3-3-1a2afcf417e4@nxp.com>
References: <20240620-ls_qspi-v3-0-1a2afcf417e4@nxp.com>
In-Reply-To: <20240620-ls_qspi-v3-0-1a2afcf417e4@nxp.com>
To: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718902721; l=1654;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=MxLx60UxLPqA3/JaqR3fmiPeUnZUirZSyYTTD31/F1w=;
 b=39WQA/Hu/tIOPWkkdvdUn0MRdriyyi5wrBt5l7v4NtX5CgrhC6vVFBxxD+5LcKwCI/SQyUAis
 XcvQDbiOvb2Dnsz/NmQAjOK2Pqt81MaGMaXH3EmSTvZYXcfjNE5WeLw
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY3PR04CA0029.namprd04.prod.outlook.com
 (2603:10b6:a03:217::34) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB7632:EE_
X-MS-Office365-Filtering-Correlation-Id: 77611bde-02fb-44b3-e7b5-08dc914a43ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|7416011|366013|52116011|376011|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bDF1WTRlZ0hscHhEWnE2ZWZwbGRFZUE5SkwxSytvcUNMbGt1QVZjMDFDdHk3?=
 =?utf-8?B?b3FhUFd2dUVnNTU2SVdCVEEySFNXWUNwZ3lncnFuRG5LZDE4QjIwT3A5Q0lN?=
 =?utf-8?B?eUpFeDNZZnNVS1NXV2RBdnBBWlcydEtpWXE0UDVBSksyT0ZUNzJadXZQTzZN?=
 =?utf-8?B?eldpQVlrcHQ0am81YXFQVnptMHZCbHFqRjF6VzZSOUtpeU5ibUprOGxyZ2dD?=
 =?utf-8?B?OHNDZjNKclRyS1dTOXhmeUlMdFM3c2RVSWVwcUNiRmYxemI2YlkwSitSQmlR?=
 =?utf-8?B?ZTduL09nUWhKaHFLaUhpYTVyNGVTb2tYT0ZaaEFLcjlRZWVzdHQyVXlleUE5?=
 =?utf-8?B?RDFpbWFmWEdYVGltM1g4eHMrTlRKazBYc0hhV3ZsRnVBTUJ1K2hUS0FFSGZM?=
 =?utf-8?B?cjhrcDdtdUI0TWUzdkp0QXA5UGk0eFdkalNJR1JNMzNDYWQrNEFLV3RqQTUx?=
 =?utf-8?B?bW9rT015V3pobEk0TGsxSytYVHFRWDJ5S2lqNWFVNVZhUkVFQ3BSK0JaK3ZM?=
 =?utf-8?B?M1JJTzJTMFRhaysrY2JrUmtWM1drS1ltSXRqYVVFUzFSUm96QlBpZERqYW5w?=
 =?utf-8?B?aHFOZnNmc010S1NRZXBINUNKRDRaMkFYenFsMFhOVGw4WUJiR2N2blFrdEMz?=
 =?utf-8?B?VlRPTzlOUGtpelBPNnNzKzAzby8zOXNCV3hVeXhZdTNwTXcvNnNFZExNRmZH?=
 =?utf-8?B?SEUrVTFZZlNRYmtmSWl4MG5LcFdYVnp4ckJTRHhUcVpSa3dVWmVuM2xxRERn?=
 =?utf-8?B?Y3libTY4QkhCV1FLT2FIM0xBamJQYWpwUVJ4UDdSU251QkRzNnZhVmlqM2NR?=
 =?utf-8?B?Yk5GNnF6ZFl0bGlMM0hVaXV2QkphNGU5dGVETmhtZXlEYkZiYWVVVUgxL283?=
 =?utf-8?B?SWpBSklLRGtCN1hwK0VabmxkU2tWRS91bVkrRjZybkRWVkFqNTJieHRyOUJz?=
 =?utf-8?B?M0tWeWpZOG1rbTZTdnpSSDhydCtRTFhDYUE3Qkl5MVlOUmYzN2gyS2hmUitB?=
 =?utf-8?B?Y1AzL1o4NVpiRE1Gejd1ekhjRkNtSnVaWCt2aVFTWVp0ZjhCb3BWbjhpMEk1?=
 =?utf-8?B?QVhTcUZieTQ1dnlDaE9BTFJ1MTd4TE5MUDRaL3o2a3RsVnZSamx2bWI5ZHJy?=
 =?utf-8?B?d0dUMlhQaFBhNHZ2OVc5VEtFbDZldnNVSFNYaVppM0orejd5b2xGVHN2emVV?=
 =?utf-8?B?WjFFL0JNWWZ1Q29tRXlFUGlPSWRoVHBqMWpoRTNhQnpoQ1JCZjdYMEZDbDNp?=
 =?utf-8?B?UjVWVnN5NStqUkVhTU1IRkpwNXdzb3VKdzJ3RFlJMVAzay8rNXlRZUp0N3V5?=
 =?utf-8?B?WVdsYW9aMDR1a3dMTVdycXVNN2c0UDFVWHRQeExZZG9KUm03RUFLRGN6Z2Jn?=
 =?utf-8?B?MXFEcGxINWZqSFRzdTBYUlNYUCtrMGtsNGJuSDdpM0liTlJ4UC9oMVlNUWNv?=
 =?utf-8?B?M3VSSVRTVE5OcStsczFHamg1ZUJoV3MrMStTUExQSGhpbnVHSU1HYzY5aFRq?=
 =?utf-8?B?VnlxK1I2eCtjMGJHMDZWMHhOS015aGdkWE5ja0NBMG8yT1lpUENpa3Frc3Q5?=
 =?utf-8?B?V3ozNTZ6dFdUaUp5a1F4dXQ0YVZVVjY2ZXZHeE9teW53RFFuMjR3TnpYM1NU?=
 =?utf-8?B?cXdoWjJOWW5vZFMwVWlkWjlqSDc5V1VtNnFhZTRaZnNxNzhBVzBEUDNIM0Fl?=
 =?utf-8?B?WUFyVWI0WjhNWXg3TG94NE9zZjJiYlN6cGF3ODFCcUp3VUladHB0OHl5VzFo?=
 =?utf-8?B?K1lBbkNiV0RLUTBkU0hkK2hZeHlNcnpFckpiN1F0ZUl4RzYwVkY3WVFWSmhL?=
 =?utf-8?Q?W3Z6ql4aGq9okM0JgNomwArczpa9g262lB5IQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(7416011)(366013)(52116011)(376011)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OFNZNWdSSXAxY2JBV2VMR3M0K1k4KzZlVHQ5RjNKSG1yNXRkQkszMlUrc01i?=
 =?utf-8?B?ak56WFVUcmZDYVJzNFNDR1pwQ0NsN1BsZ0hrcEpqZExFSzhlY1FWRFM4bnZN?=
 =?utf-8?B?dkdGT0Q5M1hHWUJENGFBYVFJdWhRMFNJanpkTTJjQ0M1MWJkMmgwYUNoMlBJ?=
 =?utf-8?B?Y01FYnVzMTYrV3pJNVBZNFhSdEJkZ1JaUlM5cHhQYjVPNlhEam1RUGVyRkc5?=
 =?utf-8?B?NDFnMVlYU3lST3VXS2hMMUROYWl6aXpZUUJOVmltRVB6RlpqK28wRUFQUVhu?=
 =?utf-8?B?OWpPNDFCemNNYzZzVUZTbVlRYkdrQTlNdDRsTHNGTGRwV1RlWmVidW14WlZJ?=
 =?utf-8?B?cGcwVkZQb2gzOGIzMUZhS0FVM3Y3TElqcmxJRnJaVWlpekp0MTRVUDRZYjlT?=
 =?utf-8?B?SUFZdXRFQTlHNFhsT3gyc2pUaDNlaUZyTlNMZ2kybDU1K2g0dzNlellEMmJI?=
 =?utf-8?B?UmFsMjVVMW9uaUxRUnRFUkdjdGRkSThaL3JraUNxd2VpSkhyTDBBd005dFEz?=
 =?utf-8?B?UjN6aVo4YUp6ZXV4bTJTdE9BYlBDK29FOEtZSmdWczJRemR4WTJQc2ovMkF0?=
 =?utf-8?B?a0xDSmFWQngvenhuUldqUFlmQzNhMXkwNlUxTTdNMGdKRlUySkFPVlVodW9k?=
 =?utf-8?B?eHFnZG4zNnJoc0ttVHY4OGlnSDRVanVRQ0JhZmZ6MnZwcGdYUks5L2grYUQ5?=
 =?utf-8?B?RnJBeFA2a0FxU21XL1lrNkNWaHNkVENoK0NMSXYvYkZFd0k0SmRMSWJoa1VC?=
 =?utf-8?B?Nkx6U3Bic05DckN2TE5xZXVKbFB1MU1pMnp2ZUJZM3lhRjZuWlFmRWk2Mnd4?=
 =?utf-8?B?R2hLa0VTLzEwUFR4SGt6TGZjSWZ1eXF4VHN0MVMyMXNrL25scUJ5LzhmaFlD?=
 =?utf-8?B?eDdiV3MraWQvMlB1ZVZzenVvTzN5Wk5xMXNIMlNKV24zSHBjU0NLalNrZit3?=
 =?utf-8?B?K1U5NFB0ekV2ZFl6T2FMWTJwWXdEY1p5Uko0NmhMTU5IQjhOSTFYTXBPUjM3?=
 =?utf-8?B?akFIMTAvZ3VJWHNoYlBtOURMdnJGczcyUC9XV2M5Nm4wVE5pallUNDdpOExy?=
 =?utf-8?B?QWFrSHJDalg5WVFaQzdIUERZZUVlNXA1TnV5a1RoT216eGRqSXd6Y1U2QVZ1?=
 =?utf-8?B?TWx0bnR1d1JIMGF1elRmV0MrS3dTbmtCRDJMV3VaV29xVFZYaTZFWE9GQi80?=
 =?utf-8?B?WVA2eHJVQzEycmRCUDUzVjlNem5aZWlvRUM1SURTa2FPSnJ4eDF3UU5pRnds?=
 =?utf-8?B?aTBVMGhKellpUitpRXdDVERjVVFiODhjdnJnRDB0TmhlU1VPQkpqZGNIQnRI?=
 =?utf-8?B?NGNzclM1djIydk01M2NNN2Z2WnZHZHM1SmRTQ0JzMzh5NHZjc3h6b1dzajdz?=
 =?utf-8?B?QmRFY0puSmJaZ05YaUtKMEM1eCtOamNFQ2tqckVxUTBCdzNGVzEzcVdxczgx?=
 =?utf-8?B?MGxJNlp0VTJ0aExTWFN2Tk9OWklubkFNQncwZmxvc1pZZzNjWC95RW9vdFZL?=
 =?utf-8?B?bEtoMkd4V2pUY1loOWJPc3hmeTA5VjQ4bHVPRFAyWUJOVGs1NUF1NlVxWXNE?=
 =?utf-8?B?c0luSTNZcmsrbWJQQ2RkMTgvN1pxNkhueDFIOU9ydFAxNzdBUFVRMXRnL2Zn?=
 =?utf-8?B?QVNsQjJZWGxqOURVSTRxQ2daLyttRFhqS1pjUUZ0RERJYytyUjVadmRaWWxG?=
 =?utf-8?B?bkxxM3NTUXpROXhONTB1a1BaemNuTmcwOFNoQWk5b3BZdGdCWjBiOHc0N0x4?=
 =?utf-8?B?N1ZsWVhwTE12WmVkSGRGQmhaY21WZXY0THM3RHVESU5ZcVdYYXgrcytTQzlJ?=
 =?utf-8?B?allJSW15MSt3bC8yRXJLMTVHd1JXa0VpekNrTnRCOGZqT1pqMVY3UkY1Z1NJ?=
 =?utf-8?B?ejhsbzgwZzduZlAweXVOR3hjUGFUcE45elNNMkZVc2pjZXliNUFKL1hFNlNW?=
 =?utf-8?B?VmdoOHBQMTVJMmt2UGNNR3dxbEgzbVFaTHduZmdRbEY5VjBRMXhCaGFxeTl4?=
 =?utf-8?B?V0o0RVNvSHk3R2VUUU9XT0JjeXRTcXJtQ1ZwZzRUU0tDblVJamxyTkNJY1Jo?=
 =?utf-8?B?SENBZExGSFR6SFhMTzRFWjR5YjJDb2dvbkRsRTNqeFA0SGNRZXE2czg5aUZF?=
 =?utf-8?Q?J7f0ggx1Ay1zscnBp8ysxk0Cb?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77611bde-02fb-44b3-e7b5-08dc914a43ef
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 16:58:53.4076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0vTbU8ZxjCYLYuYV7GJP7icfANO1Cq21kDhy1WJqjxh+o82noWS7nI/bU9fcbJ3V+lVBmLtVxTBhRMZhh8grSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7632

Use SPI common propteries 'spi-cs-setup-delay-ns' and
'spi-cs-hold-delay-ns', mark private properties 'fsl,spi-cs-sck-delay'
and 'fsl,spi-sck-cs-delay' as depericated.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
index 26f8540cb101b..fef3534157a1d 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
@@ -104,6 +104,11 @@ flash@0 {
 		compatible = "n25q128a13", "jedec,spi-nor";  /* 16MB */
 		reg = <0>;
 		spi-max-frequency = <1000000>; /* input clock */
+		/* Add common SPI property */
+		spi-cs-setup-delay-ns = <100>;
+		spi-cs-hold-delay-ns = <100>;
+
+		/* Deprecated below property */
 		fsl,spi-cs-sck-delay = <100>;
 		fsl,spi-sck-cs-delay = <100>;
 	};
@@ -112,6 +117,11 @@ slic@2 {
 		compatible = "maxim,ds26522";
 		reg = <2>;
 		spi-max-frequency = <2000000>;
+		/* Add common SPI property */
+		spi-cs-setup-delay-ns = <100>;
+		spi-cs-hold-delay-ns = <50>;
+
+		/* Deprecated below property */
 		fsl,spi-cs-sck-delay = <100>;
 		fsl,spi-sck-cs-delay = <50>;
 	};
@@ -120,6 +130,11 @@ slic@3 {
 		compatible = "maxim,ds26522";
 		reg = <3>;
 		spi-max-frequency = <2000000>;
+		/* Add common SPI property */
+		spi-cs-setup-delay-ns = <100>;
+		spi-cs-hold-delay-ns = <50>;
+
+		/* Deprecated below property */
 		fsl,spi-cs-sck-delay = <100>;
 		fsl,spi-sck-cs-delay = <50>;
 	};

-- 
2.34.1


