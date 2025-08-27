Return-Path: <linux-spi+bounces-9674-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF474B3779B
	for <lists+linux-spi@lfdr.de>; Wed, 27 Aug 2025 04:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A49A33BB6FD
	for <lists+linux-spi@lfdr.de>; Wed, 27 Aug 2025 02:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595C6259CB3;
	Wed, 27 Aug 2025 02:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="HCGXkjr+"
X-Original-To: linux-spi@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022142.outbound.protection.outlook.com [52.101.126.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569A91E51E1;
	Wed, 27 Aug 2025 02:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756260882; cv=fail; b=Vnm/S6QO7P952g4b1lpK11/DFv4Dh9+YHLxMjakpmXTyoejLXAi7qFplFf3/3ywbdljgOhgOLBgN2xHkSbxn0v7bbfGip8dLXFflMly0R+9vp+dQjI0LG4M8AViiZPEQRky79eXQps1mpZfbPp/FgGs2bzHw3CQqAEsGRfNjP9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756260882; c=relaxed/simple;
	bh=nvZ0863IfHuY8mW3Of+ITinCm2UaaEbNjYdO2qP/bxc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Gdt63k3Dq+7hZQc1/TzfyZp35tH3XFBWLzS09Bm8e8AoRZFZgLxwBqbjFeZHQiicdFQjB3LQCTRzb4GEPhbanCXGTUUsezm6+xnxKRouS0yakd3DA8qK8czCDkcMDA5YDNDV3FWI6lkLhzw+3wmEdwe/v7mjdxoztYq975yGOmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=HCGXkjr+; arc=fail smtp.client-ip=52.101.126.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dGw5UxoDbqkVcGjOPD9u7Vr+CKYRJik2DZpTYqBLAYXEzY+1fFLTL/hTLxCGRUSFmvNO6zCyPGfYiV8rsMozWSaYH4D0C0ZnV2ICk9cRhjiY5SnmTMUR3bIt5MC3tYKDM3Pgo1jTG8F+d7aHDoJkYgP62EMYmBZ3cM9/DbI7B9E7bJGe1tJZqGmD8YHuqAAUJ7zA12Ph3dwgdLxAkpoGT46WsluOKTRsHLvuB3p3bx2d2FSd4atEVn1bDWkxR6F5HlTGZdRzW8+YEYag+MWkQHrjC0PNLZX2kRY/6UltPyDDfId/1Q79jkx4Uka9REaDimR+tpJTEyG90KLZznjTdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QsthBpvSnJnQiSeGckG+c3mObBKfI5XfIppeaKsBh5c=;
 b=Scy0TOhoyMjoktg1JcF0M8/B8wHkmVhyPDNYjjmEWdNHZnBDkx8b8WoXWe5NZ6rRTPdwjHBAS88wzI5WPBRedJ49NYcWFrRdl4XjA17N761wmfLKShAyrxj208puh1/exQ5fFkh3hMCcuXQ6BzDtneqPMFzO4UEW4jyPzSvkPhszFQHUVClDy9zMgvh2mmTva46+donMMWBXTRkMLilmIncVYjtz6qQiPfTB74+AslJgqHQOOn+QvV0O1DiSJ2EFZJyfbilwhSxTd747IZ4pzQATx+/MWwmrFY4B1KSnpPgo+RZtUBAJgukWrhe2oQv462TAql6lhAd2x7kYGAig9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QsthBpvSnJnQiSeGckG+c3mObBKfI5XfIppeaKsBh5c=;
 b=HCGXkjr+CrjAwkXr5MgdBJ7h/LQW8snWE87z4bKaNr5tJeCSsifj+507rpLydOvoD32SaCgk/WT2R1EowEBcMwPp0gX1Ey8Er/l46rJ/bJgpw8JB25ElGshNC/LRF0uZAR5tPtAYHmC7cTFkzM/zm9jNIvmP+HREKmX0LdBZvMozA2VBdZN1fpPhaisgICIf8s1iJJc5vRAXkXDzktg1kCKPVegnAMQg+BQ7KGc+8dwVztW/fwrc6HIzOqvNdmFk94/TIrZhIl+5Q7OS3NklEDcDjJVjnNGxAXJqGVNoYixjN8YMT2Ennci6ZlH8u+01We/xCxogoLGn1sawnkEqJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by TYZPR03MB8411.apcprd03.prod.outlook.com (2603:1096:405:74::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.24; Wed, 27 Aug
 2025 02:14:37 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123%4]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 02:14:37 +0000
Message-ID: <220e4324-ac16-40be-8793-48c0b3e2ca0e@amlogic.com>
Date: Wed, 27 Aug 2025 10:14:30 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] spi: dt-bindings: add Amlogic A113L2 SFC
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Liang Yang <liang.yang@amlogic.com>,
 Feng Chen <feng.chen@amlogic.com>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-amlogic@lists.infradead.org
References: <20250826-spifc-v3-0-7e926041d7f6@amlogic.com>
 <20250826-spifc-v3-1-7e926041d7f6@amlogic.com>
 <20250826-scratch-cleft-a3f7b36a3cb5@spud>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <20250826-scratch-cleft-a3f7b36a3cb5@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0025.apcprd02.prod.outlook.com
 (2603:1096:4:195::21) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|TYZPR03MB8411:EE_
X-MS-Office365-Filtering-Correlation-Id: 71b4be71-aa7a-420b-7951-08dde50f7892
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WnVGZUU1Y0lud1RzalJsdFhVeGdHa3kzbXQ0aEtPVDNRdGxUaHloc2hKQVJy?=
 =?utf-8?B?UitRTG14T2lnWnBWa1FXNUhKdE5CQ1R6YVZtMmVkYlVDWEEwMHg1cDJvQnZk?=
 =?utf-8?B?MjVFVTM4eCt2VEVCVUVuajNpaGRUYkhmeDJveW1RSTY1MUZCZkV1OEMzSnpE?=
 =?utf-8?B?a3JVYjE3d3VPY05ac1VDQngzeUZ2eUdGY1JmZytiMEEreVBGWFVsVDRYOSta?=
 =?utf-8?B?bGF3Vit6VG1CUWptaDN5bnRQRktxeFJYN1ZiR0l0YVhiaVZEL2RlTEhJdDBL?=
 =?utf-8?B?WEpDaWtzVU44WDhMK0hQUndXemI4SWQvVWFwVktiMERDWDgvY1g2Smk5ODVZ?=
 =?utf-8?B?WnVkQytyRVV2cU8zVG5lald4ODdNRDcvczdUT1ZHVWpmb0IrZFArZ3VySFFG?=
 =?utf-8?B?eEZUYkxJVm1LbEFNWUYycnRNRWVIMWkrcDJjNkpCZWxWekxDUk1SdzA0QW5F?=
 =?utf-8?B?ZGZjRzQ2VTdmNlEzRGhRcGZSeSt3MWllT2I5bVJLYlMyd3dzbGZ1RXN3WG1D?=
 =?utf-8?B?bW5JdnJ1Q05FdzZDVFpMeEdicGtYbEc5NUpkVHV4TVl6Y0NQakVyNU5BMjlY?=
 =?utf-8?B?R3puQWp6R0RIdkhRdFZrZWdLWTM2cXVYUG45M2YzYmIrTFBxbHN3Nms4SWVm?=
 =?utf-8?B?ak1TTllkU0IvNTl2V2NlRHdQdjdBM1pVampyT0ZwWlc3UUliR2FDMm1wcnZa?=
 =?utf-8?B?WS9FelZERG5QYldJd0xUWVZ2TFFvZ1FkYVdUSW9Rdm5KcjZlazlrNlNmQ2Nz?=
 =?utf-8?B?TWNEeGljeGV2TVdjaWJUQXIwUm9Qb3o2aTBwSzBuWVQrL0ovbU5Wa0VSQjJM?=
 =?utf-8?B?M1ZsTkx6aWNrZHpPYzBmdWg1OTd5c3RUR01ub3BKaEo0a1pLYnNOZXdUMGV3?=
 =?utf-8?B?dllJZlJIOGNJdVZhL1dVYWNTNXIrUmM1ZlgxczZsL2pXN2FTVzEvTFRkYktn?=
 =?utf-8?B?RVR4U0c4NkZvTnpkMHhoYnIrTTdsbUF6aWRFMVBuRTkxV1QxNVZKa0kvSDNw?=
 =?utf-8?B?bmdrNUdOZUxFM0ZpYXVPTWppdEdhOUNUUTNSUDRMR3NUaHZSU2VIWUp4cWFW?=
 =?utf-8?B?aEhOOUpXQVIvQnYrbVZudXRvSDBkd3Nrb3c5OTV1Q2wwanhkRzQ2OWtWT2lL?=
 =?utf-8?B?Yk1nUGlvSm1wekxsZVQ4MzIwS0I2bEJjZ2VVNENBdEgzeE82NDZpNnBOSWdp?=
 =?utf-8?B?OVZ2THduajB3WUxsTkVTM0FXcm05Y1h3NTgwTTlVWXdqK3lWY0licmhhMWI3?=
 =?utf-8?B?TlRJWTVFZkdkYUl4ZG1nY1JIaTdEcGh5R2FYa3JoT1phNVM1ekhqMFVkdndY?=
 =?utf-8?B?VkFKNTNLSmV1Wm1kZ1dEMDdSbVZMVUNGVzR4Yy9ZbkdycGpxK0t3TFh2Wi9H?=
 =?utf-8?B?c3FMK04xMTY4am1XaHZDRFNXSlV3VGJJTXkrMlNGTXk2Y0VqMG9veFI4V3Bj?=
 =?utf-8?B?dWNFM3E4TUFFWGFQQUNvWG16RkllT21kai9Qblk3OGdCWHVlWlJEVVpyUlN6?=
 =?utf-8?B?ME5QMUI1WjNRMjNIQWwvaCtUaFl5bWZ5eEtRTUhrTHEvVGFIemlLMGJMRHRT?=
 =?utf-8?B?cldTRFpYMlhkQmJnWDBidE9tUnVzNHlrbE1LNEZ3ZVRlcC9tb05tN21QSUt1?=
 =?utf-8?B?Y21HTXFKVXJOYWNwMVdOcGIvWXJscVdqMVc5VU95K3hBL1c4Zy93OFp1czM0?=
 =?utf-8?B?WU1Kd2RSNE42SWJHbVh1NDhQNGtoUXBOSEJOVjhWaGE3bXU1WWhBOUdHaGxr?=
 =?utf-8?B?KzB0ZlJ3L2xIUmJvRU1OYjZJRUpSaG1UbEJsMjVDalVoSUlQaFZjcE5pMVlP?=
 =?utf-8?Q?8cogc88blEqrU+Xu+PrxNQJDPzz5xY4nrp+gU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a3QwOW8xbnpYYnZKYXRsd0pZUVh5NEJTQnJNcE9SSlB0Skx5RlM3aCt2OUxZ?=
 =?utf-8?B?V21Hc1gvbGFrU3pGakxsSnYrT08vZENTSWpCZGNZUUxYQnM2WG0vcVQ3SVlr?=
 =?utf-8?B?QllpUGkwQmxJYjB0OERyZkJDZ2tUZWtRTy9hWWJYVlQ3UTZyMStoa0FEazA4?=
 =?utf-8?B?NXZPL0VMSE9GZTdBQWthU3Z5R1hkL1VCRXJRL3dMWWZZNHovR04wVkxsZmll?=
 =?utf-8?B?V2o1bjdrd2hiQWQrdFlqY2lMakxRQnJaTE5PdmpDZEZNamVac0tJbzBXaXhz?=
 =?utf-8?B?amd2Ym5oVFM3S2tSS1NiUkFCRjlWVFFFNy9JOG41MVFRTm91Z1ZRMHA0VjBH?=
 =?utf-8?B?YkNIRW1vdEJMdU5RVXNVbzlXOHRrYTNXUkZPWU50YnRIbmlGUDhpRXJUNGQv?=
 =?utf-8?B?VmZ5MVlHWktGRWcyTlUwczlDVm1peG5uUC8xUWRGNDFKb1l1Q05LZDNtbnFV?=
 =?utf-8?B?NFJsM0dQWWxjRTVvUUtyNXZuOHFMNThVUDFOaUVXYUs0SjNaYXd1WE1JL281?=
 =?utf-8?B?RjBaTm1lTitHNVEwbmRQenlMSmpRMVBrLzI3bTBGUDdvSXdURWRRUkZ5VTRm?=
 =?utf-8?B?UU13WUdlTFU3UEVtajlUTXNiYyt3ZkV1VldnRFVTU3ptblExV3Y4VU5JSVBH?=
 =?utf-8?B?dTlPWEN4NUNVMmpMdWYxMFE2Z2dYUUxqeGk3QlFiUEJVbXY4aldPekJEakZR?=
 =?utf-8?B?SWh2VGxURE1FeEp1TTY5cUZQV1lBYnJrY1dKdWQzYituN3RFc05ZTnZQM2JG?=
 =?utf-8?B?UlNGeExkZ2dpblRVeFlPbGlZK0pDaXpSSHBvVHg2cXFUQjBjQzhEN1hzdjhF?=
 =?utf-8?B?NWJZaTlBTUI1Um52RFUyV1hkTmVNdWo5RnhubFdFcXc1Sjc4ZG9ZTkdrbTJs?=
 =?utf-8?B?MXIzUnlqZHdEMzUxQVhjMjVCQUM2QTNTeVJnT3BTK0p2d2ZiMHhKTzBneUxo?=
 =?utf-8?B?NlVsVVpJb1RPNHFUVDRKK1ZnMG9LRVRCNTVoZHh4UEZHZWM4czIyby9tQUhz?=
 =?utf-8?B?L0twbzdmeGNHUEliN0JhN1Y2TXRUSmVpZ21CczUzOWlaRTJnOUZvb3Z5Y2FI?=
 =?utf-8?B?a1ZhSHBFSFIvRDdWREhoYTZRYzJRd3Bua3ExMkVOMjlnRThYbXFqQXZydzRV?=
 =?utf-8?B?cXBuMHFMSkVnWVNpb0pKeVVKTHNlZUFaNENEWmFNaVo2QTJ0ZGhsQUpyWnRw?=
 =?utf-8?B?M2RTMDNYTUFTN09kajBmU0huRGpoc2IzMVlhZk1zYVlBckNmOHVwNkhMNjlj?=
 =?utf-8?B?UkQvc3ZrYVBTUUxmZWtnOVBWRytrR09oVnlpZ1lkRGR4YURMU1F5alBiM0pP?=
 =?utf-8?B?MGlUNW5kc0ZUdUtyL21QUjNEdldKeXM5aVVZaDIyMG02eWhLMFpjUEt4Z1M4?=
 =?utf-8?B?WVJ1MjczWmhWQWRIT2diRy9mMkRBamd1TGFHbERzRzFYYU4wbHdBZm1Mb1ZC?=
 =?utf-8?B?Y3pxeTR4c2VnOVJjaWxrNnZOb1RLUkRETGRhNlF2VnhNYW8ybENydVFQcTYr?=
 =?utf-8?B?WEN3eHdsV3hqeVV5alNzdFpiZUZibUsrNVc2cW1wbXBjNVZ6MlBVZjRxb0JD?=
 =?utf-8?B?bDYyTEswYy9hdW52V1hsWWUzUnQ3d3ZEbGtrUGRZNWtUTUJKbUJ2QnF5YlFE?=
 =?utf-8?B?RDNmc2NRcHQ1aHMxNWduOWxCcHQ0RWZGRlRtRlhNbWhrSHJyc3pidXN1N0Va?=
 =?utf-8?B?L21hRmFZaUlmenEwWEpsTUQzcjB4SWhXbmlOcFpyWE55elRpUU1tT3NJbUw4?=
 =?utf-8?B?bjlGekdNZ0l6a0R3YldjaGcxNWprQkRWSEdrb3VlRC9COWpXYXJQQjdYbFMr?=
 =?utf-8?B?Q0xvNWwvKzJLbHlIYStOQmRRMUNBNVBOYjFNZm8rbVVFVktaSjFTaGtjdDY4?=
 =?utf-8?B?ZDBhd0Z6aHltZlhBNEJYbTBYTEJneFV1UkxYamI4WHNucnI0VGo3MGdRMytR?=
 =?utf-8?B?cDFickYxNVQ1bW1pdHErN0d2OHJyZlFuYXBrQVIrRUZOU1pKam9BTU84N29q?=
 =?utf-8?B?eVZ3all6Q2xGejlWNWZLK09FczNNcVBsQ1pLT25vNHJqWGpHVXBFVGxyY1p6?=
 =?utf-8?B?dGhSSEE5SENSenNUQUxDbFB1MDBsY05HdjIwRGRFZXNSSDFEQjlNNnJEbk1V?=
 =?utf-8?B?V29DVDZLdGNBU2FQdjlEV1lWOTdpNDJLUnJOTjAvcy9VeE0wb1FxbmYvOWF1?=
 =?utf-8?B?WXc9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71b4be71-aa7a-420b-7951-08dde50f7892
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 02:14:37.0001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x1QMXymxRhn8cy3dp9NvOMYKlH4h5cVlJBhsZXfB1rD1lbPgAI6He9A+j6G1Sz5nFwrpHXQHxptYnWWK5trJPw4G4m68WENXGyNECdrmZ7E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8411

Hi Conor,
   Thanks for your reply.

On 2025/8/27 01:51, Conor Dooley wrote:
> Subject:
> Re: [PATCH v3 1/3] spi: dt-bindings: add Amlogic A113L2 SFC
> From:
> Conor Dooley <conor@kernel.org>
> Date:
> 2025/8/27 01:51
> 
> To:
> xianwei.zhao@amlogic.com
> CC:
> Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
> Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley 
> <conor+dt@kernel.org>, Liang Yang <liang.yang@amlogic.com>, Feng Chen 
> <feng.chen@amlogic.com>, linux-spi@vger.kernel.org, 
> devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
> linux-amlogic@lists.infradead.org
> 
> 
> On Tue, Aug 26, 2025 at 10:10:09AM +0800, Xianwei Zhao via B4 Relay wrote:
>> From: Feng Chen<feng.chen@amlogic.com>
>>
>> The Flash Controller is derived by adding an SPI path to the original
>> raw NAND controller. This controller supports two modes: raw mode and
>> SPI mode. The raw mode has already been implemented in the community,
>> and the SPI mode is described here.
>>
>> Add bindings for Amlogic A113L2 SPI Flash Controller.
>>
>> Signed-off-by: Feng Chen<feng.chen@amlogic.com>
>> Signed-off-by: Xianwei Zhao<xianwei.zhao@amlogic.com>
>> ---
>>   .../devicetree/bindings/spi/amlogic,a4-spifc.yaml  | 82 ++++++++++++++++++++++
>>   1 file changed, 82 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/spi/amlogic,a4-spifc.yaml b/Documentation/devicetree/bindings/spi/amlogic,a4-spifc.yaml
>> new file mode 100644
>> index 000000000000..80a89408a832
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/spi/amlogic,a4-spifc.yaml
>> @@ -0,0 +1,82 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +# Copyright (C) 2025 Amlogic, Inc. All rights reserved
>> +%YAML 1.2
>> +---
>> +$id:http://devicetree.org/schemas/spi/amlogic,a4-spifc.yaml#
>> +$schema:http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: SPI flash controller for Amlogic ARM SoCs
>> +
>> +maintainers:
>> +  - Liang Yang<liang.yang@amlogic.com>
>> +  - Feng Chen<feng.chen@amlogic.com>
>> +  - Xianwei Zhao<xianwei.zhao@amlogic.com>
>> +
>> +description:
>> +  The Amlogic SPI flash controller is an extended version of the Amlogic NAND
>> +  flash controller. It supports SPI Nor Flash and SPI NAND Flash(where the Host
>> +  ECC HW engine could be enabled).
>> +
>> +allOf:
>> +  - $ref: /schemas/spi/spi-controller.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    const: amlogic,a4-spifc
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    items:
>> +      - description: clock apb gate
>> +      - description: clock used for the controller
>> +
>> +  clock-names:
>> +    items:
>> +      - const: gate
>> +      - const: core
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  amlogic,rx-adj:
>> +    description:
>> +      Adjust sample timing for RX, Sampling time move later by 1 bus clock.
> By 1 bus clock? Or by up to 3? I'd suggest rewording this to something
> like "Number of clock cycles by which sampling is delayed" or along
> those lines.
> 

Will do.

>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    enum: [0, 1, 2, 3]
>> +    default: 0
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +  - clock-names
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    sfc0: spi@fe08d000 {
>> +      compatible = "amlogic,a4-spifc";
>> +      reg = <0xfe08d000 0x800>;
>> +      clocks = <&clkc_periphs 31>,
>> +               <&clkc_periphs 102>;
>> +      clock-names = "gate", "core";
>> +
>> +      pinctrl-0 = <&spiflash_default>;
>> +      pinctrl-names = "default";
>> +
>> +      #address-cells = <1>;
>> +      #size-cells = <0>;
>> +
>> +      flash@0 {
>> +          compatible = "spi-nand";
>> +          reg = <0>;
>> +          #address-cells = <1>;
>> +          #size-cells = <1>;
>> +          nand-ecc-engine = <&sfc0>;
>> +          nand-ecc-strength = <8>;
>> +          nand-ecc-step-size = <512>;
>> +      };
>> +    };

