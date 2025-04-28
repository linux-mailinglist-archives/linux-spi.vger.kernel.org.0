Return-Path: <linux-spi+bounces-7783-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FC7A9ED82
	for <lists+linux-spi@lfdr.de>; Mon, 28 Apr 2025 12:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E705A189005A
	for <lists+linux-spi@lfdr.de>; Mon, 28 Apr 2025 10:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19CB2620C9;
	Mon, 28 Apr 2025 10:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="H9I/33Zp"
X-Original-To: linux-spi@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012040.outbound.protection.outlook.com [52.101.66.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F192125EFBE;
	Mon, 28 Apr 2025 10:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745834717; cv=fail; b=grFKUYOB5G0zfnNXDe6dx1mxrFnJ8wP08edT7iLnYqQPzimtXOAt7MJl712H7ncExMd6QMEDzXcsRbVEzlQ8uGo0bnPgSygl8jKAWdZmYnWrJy/T3V+rseAb3X1/3mKDDqsdWuwP6jZObZuK4rt2dhJlk/Lia8FmMb6i7KCH0Zg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745834717; c=relaxed/simple;
	bh=CN+YvT1LOIFdu7oACjSJfBPlYtPs88ub8EThrxI2rY8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=QvtKjdCN8fr087Z534nRIPqYg4HpVF0wj5IBzsrc6jggf7lc4IgAikK261NDKvO76/p2GTHMhVah2nsXW2vrABUNPgPe0KSHZJOzASQnGBttaXFxrn3bkKZhooZQoWU160KDcsQ6pKTwNVFeJWuPBV4SYoUP4Iw3q0dO3E3lJy8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=H9I/33Zp; arc=fail smtp.client-ip=52.101.66.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=alGxzVUSRMvbhy5zyEPlxx/OtJ+JfXW/qbPMmG7MUamWUjgS3WpoDRauVTHdzi+xJfe+eU4nbj11GFaN8ZsqzKn+k8cRMOGvkv3zaoGTftfStfQRv9t3l7lCE1+SO+qvccHoEJJtTVHI2/sIlAqm8jUgf1/hUK2Nfs8fq+Xk6FZ67jd9/XsVV3qSBQlnJ3qp26bQ1PHxHMrfIXCGl1XT96GBA4krXBWWFnnHm87OaUKUEE1YdB3tmEaRz3IP7QiumWWBkw8A8jk2UQST1ajEf0wMLX0BzTVRMzRhC0O3hwrmwjiArq0gsX4qkw5G449zkcJ60siB2nEg95lomtfWQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ma2Dc0LGQbYESGDWyjvQ3toRVmZFop6aP7od7bD2Ipw=;
 b=DTysF1KAmu75tGPTHatBtSweE7ZC5h+cxJFkLBFBp0C5jhcI4ldBeVujCtD6cjXVN8FBg3KnMiVGdcr7RTgmn8NfGbemQ7cMU5MmuCR0xUhoYwpvwsk0dycSQBYq/0b7wHfvL0DBYf1XsyRf8jMqQPjYyfREQoMld3/hHH9Vxx4jwmEPdYwELvs9OSlD5b1P7cPF8JcbILrfE8cL6J7gxmYQJDaRg5JjyZX1+egamX7YmSOWd8UyRBdat/VELlXz5xT6pFIuAncYDrS990kg11NVolhdhHJEFBMUtTq2ln0ZyWC8iC81KN4kP5V9Lwp0GjVupWmMayGtXhjljIrX5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ma2Dc0LGQbYESGDWyjvQ3toRVmZFop6aP7od7bD2Ipw=;
 b=H9I/33ZpXNJhS3tBydOG17DZEUbITR1kRkYnL4NvgZAxv3LlxHPpVbr+ieJqGGLVXkDtlk3skRYv8ZhIhCyxhyTPuDo8tL/kOGJ6xZIXb0UocunwPzvpWd9+NDb/Kefx5+4Beka2eCkgcXSDlIfZv51q7O7+Fu60FtBdXlVBIiofQ++LgudlksbIxY1wfxqvizAOduH+Ay2hTUMGdx3MlZkaBdig48Y/mW7q0Hghvak+p1W7TP8xlb9YRQgr1KnIxKcxvbA4zWmT2CrWB53rPmDTeJbyg0qCjvd1vYfYSDabVVPAEOY9kCK8Fn/ZScEVgBT0L4ocW2JVQRfZMDagqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by PAWPR04MB9862.eurprd04.prod.outlook.com (2603:10a6:102:391::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Mon, 28 Apr
 2025 10:05:11 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%5]) with mapi id 15.20.8678.027; Mon, 28 Apr 2025
 10:05:11 +0000
From: Haibo Chen <haibo.chen@nxp.com>
Date: Mon, 28 Apr 2025 18:06:45 +0800
Subject: [PATCH v3 3/5] spi: spi-nxp-fspi: use guard(mutex) to simplify the
 code
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250428-flexspipatch-v3-3-61d5e8f591bc@nxp.com>
References: <20250428-flexspipatch-v3-0-61d5e8f591bc@nxp.com>
In-Reply-To: <20250428-flexspipatch-v3-0-61d5e8f591bc@nxp.com>
To: Haibo Chen <haibo.chen@nxp.com>, Han Xu <han.xu@nxp.com>, 
 Yogesh Gaur <yogeshgaur.83@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745834827; l=1084;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=CN+YvT1LOIFdu7oACjSJfBPlYtPs88ub8EThrxI2rY8=;
 b=8XF63ETjHThXSPIpenKYUzmaXaLQCa61ECkw9DZU6KT9IOzezMN3RyravuSxIxc+Ld8tHE99O
 M+yWWEzXmTXBaQkWy0dP+YdAi4qWvuE6lRjfaEU+M3/gp3Ld5EPlS3X
X-Developer-Key: i=haibo.chen@nxp.com; a=ed25519;
 pk=HR9LLTuVOg3BUNeAf4/FNOIkMaZvuwVJdNrGpvKDKaI=
X-ClientProxiedBy: MA0PR01CA0011.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::9) To DU0PR04MB9496.eurprd04.prod.outlook.com
 (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|PAWPR04MB9862:EE_
X-MS-Office365-Filtering-Correlation-Id: 7134651b-7350-4682-c89e-08dd863c2990
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YVRPcVJ1V3hrR1lnUEwxQ0cxZVdtM0RjcjlucEVIS0tlQnRZMjE1ZUZNQ1k0?=
 =?utf-8?B?aUxPNHBoY0xBVVVpTGNXUHR2WUdCRHh0K3J1SEQ2S2xlUG13ZUxIb0kzSTJw?=
 =?utf-8?B?UGRCS0VwcVdaQ2tnMDZiUkUvZk5hWEozblpLbnlSM20wc0cweEZKOW1XUndi?=
 =?utf-8?B?RTJidzI3Z3pkVzVGVUI2aE5uZld3Zmt0YUdvT0U2ckV0cUMwY1JZUlozWWJh?=
 =?utf-8?B?elhwcFh3UmlBQjRUNEpWTHZ2bXQrUXcxMG00UHQ1SktHKzhlYStNQXFnYjlV?=
 =?utf-8?B?d29TSXpFQXMwNVA4OEFaNDFOL0dUQW1mRmpIamtpUnpicGo5Z3c0d0NVTlVB?=
 =?utf-8?B?NlplTmhVK1NsRjhaZzN5a212ZWxSaDdxcWtYR082YWtvU1dNd1BkMk4reldW?=
 =?utf-8?B?bUoxNkNKclJNcU5xdDA4MTdZUDRUOTNYUnJVSzRPNmw3aDRtaThVd0w3OFVE?=
 =?utf-8?B?UHIrdlUxWVFNWkJiNjgwU0pia3BtQU96QVhJSmVRTWpwZk1nUTZFRUdPSVFl?=
 =?utf-8?B?R0QyeTM4czlsdjF0UmZ4WWZ5R0RKZHJXRU1kYUFncFNqSTRaUmJnQTkyTEhi?=
 =?utf-8?B?NWVmN2JSSEQxcDZaOVIzUVJGamRjN2lDS0g3MGtJRjh6N0lTZWpEOGRkZjhn?=
 =?utf-8?B?Mkt0bVVZQlg4cHQ3djE4Slg3QUV0bzluVmlkVENsNjM4QlNtMGlET0pzM1lF?=
 =?utf-8?B?SkdRa0NvdjVrOC9FQTRVREdRbkJ3U3Y0UTRBbzB4WXp2cUVYYzl3WVZoL3BZ?=
 =?utf-8?B?VSs5T3VZSUJPWk1jNXhESlpsTkhyZUl1VDZmMmI1TEwxVjdBRFprYjFBNGlI?=
 =?utf-8?B?bXIvOXBRS2U3OU9Ec2VjTUZCeEtqeU1qOTdQRVFGTmJGQUgzazByQmVuOFJZ?=
 =?utf-8?B?S1l6VVdoTWtFeEV2NGdRN09pMW1xMUNLUWpZOS9yck5wMjZTMWlsQWRWNnJ6?=
 =?utf-8?B?Q2p3TXdlUlVhUjRkelBpZks5c2MzYmUrUVJKOUNJSERQRnFwZTVDYmh6YlRR?=
 =?utf-8?B?K0RldlA2OTVSSmZFZDVXVTIvL1BZSGdMN3VrYmlraWkwaXQxWEw3a3VGYmNT?=
 =?utf-8?B?cGJseTg0WDZBMVltSTdQb2c1V0cxOG1idlFNM0dNZDZmNkRzZXlpNXFnR3FK?=
 =?utf-8?B?SWJCTHVaZWkvUmVNbXEzZ2phK0VqYWRUMFdhcjdqcGJ0TnAwOWpMQlEvQysy?=
 =?utf-8?B?aThVWDVudGVUTUNQM2ptTmc5VHFxckdRb0lmZmRSTkZDSHh1TW9UcU9JeHJC?=
 =?utf-8?B?bmE2ME5HOC9jL0RqRjV5SlU5clZydkZPOEo3bUZRbHNadFVGM3MxWWs4bXpk?=
 =?utf-8?B?dlBQekNKRi9QTWZyaDc4VFBQSnRWRGF5NkpscmZ5K0FwcytKUStPS2thci9N?=
 =?utf-8?B?ekp1Z292RWlrNnBaN3JnYWN0b2RoQ2FNMUVXMlhENEs4K3N4ZmlPN2xJWXVJ?=
 =?utf-8?B?aml4M1UwZlB6NDJiU0J2NXVRcHZRck5aL0o5RnlXV0lZN3M4YXh6cEJvUGQ3?=
 =?utf-8?B?NmlLQVhxSXFlL2FJWUh4VW9BK0JjcUhGWkJmOXRNWGVpSnlLc2FoaGwxalM5?=
 =?utf-8?B?UUZpQy82Q2ViUkNjSjZRWC9JLzg4eTIyNm1ZZzdITi81QlErdXhBNExQaGox?=
 =?utf-8?B?Yk8zQXY3S1laWEhwbytTS0FlRmxyRmJScVlnUmFSTU1jUFhiK1grVi9qbm81?=
 =?utf-8?B?VFJTajlFalZHOXByaHgxVG1hOHZlMmlpQ1VreU04VnZISWpMNjd3QnB0QXZG?=
 =?utf-8?B?TEM4M2kzRytMQjkzclFqd2xlbzJicDliWVJxNERSVzFJVk1JeUdhanovVlJ5?=
 =?utf-8?B?OGRhRnhsWXFTL3pnRG1aNGtVVmlHRU9DU2cwd2JnUitzdDJyc3ZPQmIwcTFi?=
 =?utf-8?B?Wmk4NER2MnFhOXgxam1IVUZCbXhHeDl5N0xVbGNXbXd2dGQ2ZktNM1hGRzRY?=
 =?utf-8?B?ZklvbzFZUmJBK2pMQWMvaXVRMmRLZHhOYW5HdFBkb3FIYzJzaUp6Si94emRy?=
 =?utf-8?B?Zm5RalR3Y0VnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MEFZdG9MQzR2YWl5bmJWYmJMRGY0RUFkcFVlTlpaTGZzcmxETjNwcnRZQTZJ?=
 =?utf-8?B?KzlxN3MvbC81dVovR0J5MWVWRTF5VzVTR1pkUFdiZ2hqZWFleXY5S0tJelJy?=
 =?utf-8?B?LzVFNktSS1VPWFFTZCtpYUlvRUN1ZHRlamVidHU4SHh4K1ovMURZWDRSeUpq?=
 =?utf-8?B?OUZiQ3NiUldVQ1RHOVAxMHl4OFA4cUhnMVl4UUsrcmtneXlnZmtlQmxIczNh?=
 =?utf-8?B?Y3VJRHpwbU9rdngzbnF5N1FLZThDUjFJeWJTSGs2N0ZuejdCdG1QcmJJSEJw?=
 =?utf-8?B?Q2IvZmRLNmRXTGczaTQzb3l1STRIVUppVGNmTXNING1rQmh1OUlYZGpxSXJu?=
 =?utf-8?B?dzFUUGg4cmo3WUNMeUxYb2J3d3cya0JqN3lDTk80NHRTWEwyQlVOcytZdVN1?=
 =?utf-8?B?cUhpQU5FUzZhaStQdXJrNHlsNDV2TzVrVGZmUDdsL0EvM0pYOVcwMWp3S2RL?=
 =?utf-8?B?OHFndHViOTNCRzZNQjBuU0ZXR2pkejlXaWx0TkFQaGpzMHVWNThTTVhIbjNU?=
 =?utf-8?B?YW1Qa2tKTC9GdXlwelpGVWRvQTJxK1NJZ3VpV3EyY1Z6c1hLbUZ3RGxZb2s4?=
 =?utf-8?B?dVQ4eUUzMDNCejZkTzUzSEVwRmt6NU52QVNaZm45Y3RJUjFlZ2RnS3NDN2tt?=
 =?utf-8?B?RmRjTXNhQi8ybmRPS0tMakNXMkVEdHRIWmtxL2VmVktyQWgvaWowd25BRjNP?=
 =?utf-8?B?ZTA3THlFT0VWQnFSZkNrZ2lxMXJ3ZCtVb0JRWGFHcHo2SzBtV3hsTGFWamNC?=
 =?utf-8?B?WjNJTHpBb0dQSy82eWROTFd5eWorM1B1T0haU0taNmZMcmNGT250Y043QVo2?=
 =?utf-8?B?Q2QzSkpkRDIzNjU4OWRZZTV5bkJ0TXhvWnlLRGw4cWwzbWY0REkyb0xUMjNn?=
 =?utf-8?B?UzdXQ0R1YzUvRWkrVUtRdDdDdkRyRVRTZ3YwN0ZYQkc4ZlMwN3ljUmgyOVNZ?=
 =?utf-8?B?SkJUTzhtbFlPamRock9MRkxhcllLbDRKOFBwR0V4eUIyMlg0S0NLR05NR3d6?=
 =?utf-8?B?bnpyTU5wRUtyb1ZFVWpMcDBad0pmOUs5WDNvejc3SG9DL1E3T3N6dHR5RzFZ?=
 =?utf-8?B?MjQ3ZHRXM2sxWUs3WnRGeVpQZ01hYVdnYzdmUzJRL2RTalhFaEczVW5BOXYz?=
 =?utf-8?B?ZFdDVVZhbmhrcm1tMkphK2hHbUdwYndvcUQ4ZjV2S05rdTMwa1RFQUxNdWtD?=
 =?utf-8?B?MjIzbjR5SjA5MHRVc20vTDA4dGNvVkJtL1Naa3I4dWN4M2pjVklLclV5N1Ir?=
 =?utf-8?B?cEJBbzc0M0JzRnRhREQ0bnUyRTVLRHJvM0JUUmtoS3VZdkdaYko5SzJScW5t?=
 =?utf-8?B?elFCcmZvSnhkeldjeERZWHBSZDlrZUVRN2F6UE1haDJFZGhzaEN3TG8zaUh2?=
 =?utf-8?B?QkZMVnVsaXZwYWE1SU95OThrdzBMeTZEOGRxWHZBaTNCVGg5dGZacXRMZWo3?=
 =?utf-8?B?L3M3ckxGSkM1UHBhNVpLVTNjaEE0dGtxUzVlMjluTnNCTzVXL2QzRzkvT3pH?=
 =?utf-8?B?OUF1U08wbU4vUElMMkNSN0ZUNXFVWGE2aSswanVkVWIzaDlyTzFHQkRiRkZ4?=
 =?utf-8?B?YTI4Sm5DdERqSW8zbmgvQmlMcE80SnkxbmFmVGlHVkovYlNCTGd5TFpkK3M2?=
 =?utf-8?B?NUtGM2tLSHl5ZkRvbTdFME9zL084NFl6RjU0Uys4dHhBdEYvbDFmY1VmbHFy?=
 =?utf-8?B?M3lWb2J4TnR0QWFWY0hGcWpmUHRmR3RPVjNQMFNnV0cyU2U1UHpmNEg5eFl0?=
 =?utf-8?B?MnVPNVdDcno5RkxSRHdMMFRma0dwWWZ1WHM0ZU03aGlNV1ZVcjU4bm0zeE55?=
 =?utf-8?B?dTF4Zm9jUzFva0g0VWluZDI2SG0xbEZ1b1A0S3h1RVR2NnJqWm9ubXJqbGNF?=
 =?utf-8?B?bXVFVWxKdDFwN0FiTUFQc1dpekR2RDUzR20wUFlnQVh6MnlBbEQwdGZBYlg4?=
 =?utf-8?B?R1RrNXhiM0UyUHRhQllQYkVjTjZxUFdUWnNKMldkbmx0S3Jpb2FTb0RFbEhL?=
 =?utf-8?B?aFZGdndIVmZsdC94N2dRNjZXeGgreFMyTENKN0s0ZTFsVklsUnpyV01pRVdn?=
 =?utf-8?B?VFpxS2s3bXFqeTRUVVV0SHNySkx2RmFSdjRQWVBlSVRrVWl6dUNUbFlxYzZk?=
 =?utf-8?Q?6M046aTF9ZYwaJ9zoXmL2zK4K?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7134651b-7350-4682-c89e-08dd863c2990
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 10:05:11.3493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pxs7pRAi5Gwao3u3NUzJ9han3muHjFScTHba5EW9FMuWo7WaYiw9oLKcGcNrKzK6beulgYj3YpzrPs32sATZcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9862

Use guard(mutex) to simplify the code logic.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/spi/spi-nxp-fspi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index f7c3330a19009223cbffae8673d264246418e561..ca0b51a254c15f45a9e91907900d94d77f1d5dff 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -932,11 +932,10 @@ static int nxp_fspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	struct nxp_fspi *f = spi_controller_get_devdata(mem->spi->controller);
 	int err = 0;
 
-	mutex_lock(&f->lock);
+	guard(mutex)(&f->lock);
 
 	err = pm_runtime_get_sync(f->dev);
 	if (err < 0) {
-		mutex_unlock(&f->lock);
 		dev_err(f->dev, "Failed to enable clock %d\n", __LINE__);
 		return err;
 	}
@@ -972,7 +971,6 @@ static int nxp_fspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	pm_runtime_mark_last_busy(f->dev);
 	pm_runtime_put_autosuspend(f->dev);
 
-	mutex_unlock(&f->lock);
 	return err;
 }
 

-- 
2.34.1


