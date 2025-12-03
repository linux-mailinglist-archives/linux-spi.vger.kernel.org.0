Return-Path: <linux-spi+bounces-11749-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EB06CC9EC05
	for <lists+linux-spi@lfdr.de>; Wed, 03 Dec 2025 11:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 76C87347760
	for <lists+linux-spi@lfdr.de>; Wed,  3 Dec 2025 10:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B562EF652;
	Wed,  3 Dec 2025 10:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IKEx7/ME"
X-Original-To: linux-spi@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011071.outbound.protection.outlook.com [52.101.52.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5794D2DCC17;
	Wed,  3 Dec 2025 10:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764758494; cv=fail; b=I3FsFC/9io6rvnfLIoqW2Qd4lvw6EJD8jT5Qirw4c63+OacaNucvgX3J0/6KN5zbegSvug/fSC2WJbeJczZkvW2gslaeWCEcVwbNAaQoBFCh2H04QV3vF51SyfI58StT9Gc9NbEHkS64ZjG2VaSyT/VspEDQ9G+eVGK+aK3ow28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764758494; c=relaxed/simple;
	bh=UKN7E1p2tYGGUa4AS9kU6ta+ls8HuFb3BVSJOK4cJj0=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bEv018lsDq5iKflFD1/ONa2uGjrcZd3UxNN+S34uEBgNNhkDXUjJkIpGBvuWYEm64cS4ZndclZRd4ga7NiB3nLFw6pslgJbBhNzF84gcqnODEbQNgZhXbesmh4Ox/1otnHycaZ/K/d5GXHkrOC1bftCk6x8fjPEGo/sbAQ1EyJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=IKEx7/ME; arc=fail smtp.client-ip=52.101.52.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GS8aK7KGQcWliM+Khq2eeoTOUvUurmcY+iS8VgQ1E7IBBTpesJ76WD0FQfidk+tjyGtpoTfiMIP91Nhk+qZezoHQEpGR/v9NmoVDT1qtYvK6gbI3V3fP8RqtBu+8OCjAZW+ubW24XJnLHXFP+WtGh1HBmoD0Agw4Mf44LxY68PyqB8ebtrd5EccuCtePQ9kvd3Fl5tIOdRSqqWiJtjFMFjjd2y27/ghDBPaQNqbnbWVZz3sGnvNi+YM5UdSYFqG6SuFdY08PGL0wdAhyOJSCPFV1UEbno9n1upghsdZFCEXOxxxrppFeWsZ78sVlmLICMRyE9dQaCe4BCoH8rDjsrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DolDGMCJlVEtCTFvBEg46ElUKKIeB/pBMOKlL7Arl64=;
 b=jLWp9mMrbHZs6BD95kyiWcVvzrc32WHfrQ9dhV7+6oaOEK83jttX7wb4dbWAIcnyQALUwrR2vOj3hD1FGoGrta541pJP7iFH4aOwX+noyJw0bb41OKG1vNuXeU9U3AgKD5+2V+tRmCmdmk9wH1fuozvDaUsgmXvzgXPq5RPzpURPbIaK94MVznIDJ6sv1FEceuZv2dKaq8XiD+7vKTaP0KN8QJK7Xl50Iod07AA54dIQEhT7w6sDfBxHBT5NWSRaR+srhP5vPo4Y+W8bKrC6m76x+R42OFxG04ims/osyeQlubA8n9hkYLfnK1A89e3vL6Kndk7dms2Zg8c42VLDzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DolDGMCJlVEtCTFvBEg46ElUKKIeB/pBMOKlL7Arl64=;
 b=IKEx7/MEN4Y8dMZVKAq351jASroMjWWIYIJ9LwzwxKth5hS0IHtVbxs+e3ZjOlnW7DZs2rhmFGVGT9Bk+6BqDdHPX/qB7vgf6y+c2faw6vGeum59x11cfq3NNxunpWW5H9aWR/5uc7BvKyyWQViNMpZ/LWaA9aSoWyFVfHXTNRg=
Received: from BN9PR03CA0251.namprd03.prod.outlook.com (2603:10b6:408:ff::16)
 by CO1PR10MB4515.namprd10.prod.outlook.com (2603:10b6:303:9b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Wed, 3 Dec
 2025 10:41:28 +0000
Received: from BN2PEPF000044A3.namprd02.prod.outlook.com
 (2603:10b6:408:ff:cafe::80) by BN9PR03CA0251.outlook.office365.com
 (2603:10b6:408:ff::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.9 via Frontend Transport; Wed, 3
 Dec 2025 10:41:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN2PEPF000044A3.mail.protection.outlook.com (10.167.243.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Wed, 3 Dec 2025 10:41:26 +0000
Received: from DFLE213.ent.ti.com (10.64.6.71) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 3 Dec
 2025 04:41:23 -0600
Received: from DFLE212.ent.ti.com (10.64.6.70) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 3 Dec
 2025 04:41:23 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 3 Dec 2025 04:41:23 -0600
Received: from [10.24.73.74] (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5B3AfK6q3886452;
	Wed, 3 Dec 2025 04:41:21 -0600
Message-ID: <b2c0f5b38ed01836c025f2672a883484765d91f5.camel@ti.com>
Subject: Re: [PATCH] spi: cadence-quadspi: Fix clock enable underflows due
 to runtime PM
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Mark Brown <broonie@kernel.org>, Francesco Dolcini <francesco@dolcini.it>,
	Anurag Dutta <a-dutta@ti.com>
CC: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>, <s-vadapalli@ti.com>
Date: Wed, 3 Dec 2025 16:12:04 +0530
In-Reply-To: <20251202-spi-cadence-qspi-runtime-pm-imbalance-v1-1-aee8c7fa21f2@kernel.org>
References: <20251202-spi-cadence-qspi-runtime-pm-imbalance-v1-1-aee8c7fa21f2@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A3:EE_|CO1PR10MB4515:EE_
X-MS-Office365-Filtering-Correlation-Id: 80bf7593-8eb0-4092-4021-08de325882fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZkZsVmV4RmZrSWNTQytXa1JCK25mdmRxVGhJaXowUUNZdDMxSThsYStGM04z?=
 =?utf-8?B?bndzNGNXWk9xWXRiSFNuVXNlM3llR1BJRm92Z1RBSGw2U0RXRXF3YzNrQjNR?=
 =?utf-8?B?TUlhZ2E5QkZmNFhNMmJYWEdqUGM5eGRqZVRtMG4xYlNtTVRUaXhJaWhnRmVC?=
 =?utf-8?B?TTUyKzZodkd2aVNUY1MyMldRcUtnbVg1Lzhtb0lWSjBmeU5JU0ZIU21mS3Vz?=
 =?utf-8?B?ejVrenFWeTVwa25rWmpzdTVhbm9XbVdKNG9tSXhjMkZ3NDNOVjh4bG5od2dU?=
 =?utf-8?B?d1NtWHNEa0N6QXJZUVhQMFRPK3hCSVdMQXdWanR0UEw0TmpNSXlkOWk5Yjgw?=
 =?utf-8?B?eEtheXk1WHhGbkwvWVJtTXA2Q24raUtXakp1MGJKRE5UU0REUisxOW15ZUw2?=
 =?utf-8?B?VWxiTytZRlU4TEZ1ZTZFdnk1N2JYK1FEWWN2Z05hdHl3SFpuUi9yS2pBODFx?=
 =?utf-8?B?MVJhd3drdmJ2UlhNNkRQakdQYW1ieXFlTG55MDZLMmxPQjVxZGxnNnpiUEdI?=
 =?utf-8?B?Y1VoU0puTERmUjQwc0ZDNWNrL0wyVkdhSVc1L2M1WDNhQnFlNzJwU3hYWnM5?=
 =?utf-8?B?dW9mejhyMmt4Zm41N0hSUmMrTDJhOUFrcVEzVlRHQnN5cE1GNEh0dnE4bytU?=
 =?utf-8?B?emQvSVd3azBXaUhtV2twSWtPZG01WS9Xa3g4M1NOVWhnQTFNZTZ0MjRkUU5U?=
 =?utf-8?B?OGh3TWlQZkxDcGpzcm9vd2lYNVcxelpiTGNwY2xYTjNYdm1WTjFNQ09adlhz?=
 =?utf-8?B?d3R5U1djaUZOdnZMSHlZNjB3UlUrZUI2SndzZUJyR1l4WXh1dFc1d3YzZjlr?=
 =?utf-8?B?cmljQmxEejAwN0IvZ3ZWaWo0czRmZmtBeCs2NTF2dmJSTXhXMWkzUzZaWFN6?=
 =?utf-8?B?eVZ0YlVIbGdYWGxNRXBTN1R3VjI1cGxSQ3YxWGdGMzVGaGh4YVZYYTVlMUl1?=
 =?utf-8?B?T2tENllsNlp0bzM1VmZGM1dLSE9WeTJjOFRpRnRHL1lnWWpScEpoaXh6UGN0?=
 =?utf-8?B?VktDSHRqUm0vUVBwbjh1RktmWXJqM3MwRkNBSG9VK2MrOEh3MkZ2MUFyc3pN?=
 =?utf-8?B?WUlxSXVHRGRjYzN6OStxWHRjbnlNVXFlOHpoTDcwdk5SeG5kakZKZ25BYTBx?=
 =?utf-8?B?ZFhicU5aOFZkUXBkVXhjTVFnaFM0cUQ3R2c5Q1VWNnpSRWZySjJaK3RiU1p0?=
 =?utf-8?B?NlpZU0JKdElzb2Z5NkhPS2tEQ1hRcC9Eb2c3cXRRYnhWbmNNZ3F2dUJhZnJx?=
 =?utf-8?B?QnZGL0FjWVFaNTNuWWQzTm4yblg0bTNGckREeG9NYzhxMi9MTFRreE5XT0Vj?=
 =?utf-8?B?K0xxSkRSNXFROXk4c1ZTNGhwekp5UzNtbEVQV1NjSlFsdFJISzJDeEV6QnRN?=
 =?utf-8?B?cUd4VElnZFZuZXR1YXVzbHA3UCtidFJmK21BY2lodEgyMzV1V3g4UkVCNVBa?=
 =?utf-8?B?L1BHUmVZQUFrV0QrNkhLV0EwT2h6STdrWE5zTjlpbCtTZlorMitaYXJDZDVt?=
 =?utf-8?B?QnBSaldwNVdsQ2tRQmhXVFBjVElWTWdXMUFVTUpRTnFORXV6TElBYzM3RXBL?=
 =?utf-8?B?c1huTFMzTnZEUmdsdEFZNVdtTEhoMlI3YUQvMzB5ZHhxOGhzOGZ1YlBmdVMx?=
 =?utf-8?B?N1VjQ1JkQWJXV2pncXlZREtEaStUamlGQStjMmprbmU1ZzZSZlVXenJuL0JT?=
 =?utf-8?B?bDBOczAwQ3UvTEw2U0dIajBOVG9VUHJvTE9uMGpaQThScUtsWjc5UTlIMXo4?=
 =?utf-8?B?eE4yaWh3V1hjcDhXUUI0TVBtMVdNOWQwTzRCYUE4L2tPZWFsNWNSUDBpa0Nj?=
 =?utf-8?B?N0ZUSjVCVmlZTk44cDB4ckY1NCtNV1RVSGt5QkIyNC81cDdLRzFKTHBScllP?=
 =?utf-8?B?TUw0NjQ0aEpGSWpYbWFGakdNYk03UmtBQVM3bWc2QjArdEZtSzdqeTdDaVZZ?=
 =?utf-8?B?Ti90VlZHOVVvcUVtZEMzdWJZcWdacy9aaDZNdjRRamlkLzdLKzJYZEk3cU5L?=
 =?utf-8?B?YzlGcE9zZXZ2U3hUTFAyRi9uMk9EUmpuWlYwdUV4azBkK3FPSnVTRzBZQWtL?=
 =?utf-8?B?S2VCbGw2TWRoU0hKRU9sbEREVFAzei9ad2Q1eGQ5Qk1mNmZOM0V2Vlk5K2Fk?=
 =?utf-8?Q?fuVU=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 10:41:26.8173
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80bf7593-8eb0-4092-4021-08de325882fe
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4515

On Tue, 2025-12-02 at 22:53 +0000, Mark Brown wrote:
> The recent refactoring of where runtime PM is enabled done in commit
> f1eb4e792bb1 ("spi: spi-cadence-quadspi: Enable pm runtime earlier to
> avoid imbalance") made the fact that when we do a pm_runtime_disable()
> in the error paths of probe() we can trigger a runtime disable which in
> turn results in duplicate clock disables. Early on in the probe function
> we do a pm_runtime_get_noresume() since the probe function leaves the
> device in a powered up state but in the error path we can't assume that P=
M
> is enabled so we also manually disable everything, including clocks. This
> means that when runtime PM is active both it and the probe function relea=
se
> the same reference to the main clock for the IP, triggering warnings from
> the clock subsystem:
>=20
> [    8.693719] clk:75:7 already disabled
> [    8.693791] WARNING: CPU: 1 PID: 185 at /usr/src/kernel/drivers/clk/cl=
k.c:1188 clk_core_disable+0xa0/0xb
> ...
> [    8.694261]  clk_core_disable+0xa0/0xb4 (P)
> [    8.694272]  clk_disable+0x38/0x60
> [    8.694283]  cqspi_probe+0x7c8/0xc5c [spi_cadence_quadspi]
> [    8.694309]  platform_probe+0x5c/0xa4
>=20
> Avoid this confused ownership by moving the pm_runtime_get_noresume() to
> after the last point at which the probe() function can fail.
>=20
> Reported-by: Francesco Dolcini <francesco@dolcini.it>
> Closes: https://lore.kernel.org/r/20251201072844.GA6785@francesco-nb
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Cc: stable@vger.kernel.org
> ---

Thank you for the patch. The 'clock already disabled' issue persists on
J721E SoC with the patch applied:
https://gist.github.com/Siddharth-Vadapalli-at-TI/a664f59366ad681856b862d62=
1487b7f

>  drivers/spi/spi-cadence-quadspi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-=
quadspi.c
> index af6d050da1c8..0833b6f666d0 100644
> --- a/drivers/spi/spi-cadence-quadspi.c
> +++ b/drivers/spi/spi-cadence-quadspi.c
> @@ -1985,7 +1985,6 @@ static int cqspi_probe(struct platform_device *pdev=
)
>  		pm_runtime_enable(dev);
>  		pm_runtime_set_autosuspend_delay(dev, CQSPI_AUTOSUSPEND_TIMEOUT);
>  		pm_runtime_use_autosuspend(dev);
> -		pm_runtime_get_noresume(dev);
>  	}
> =20
>  	ret =3D cqspi_setup_flash(cqspi);
> @@ -2012,6 +2011,7 @@ static int cqspi_probe(struct platform_device *pdev=
)
>  	}
> =20
>  	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM))) {
> +		pm_runtime_get_noresume(dev);
>  		pm_runtime_mark_last_busy(dev);
>  		pm_runtime_put_autosuspend(dev);
>  	}

Regards,
Siddharth.

