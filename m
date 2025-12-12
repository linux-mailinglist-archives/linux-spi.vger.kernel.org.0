Return-Path: <linux-spi+bounces-11873-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD9DCB817A
	for <lists+linux-spi@lfdr.de>; Fri, 12 Dec 2025 08:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3906C3081D5A
	for <lists+linux-spi@lfdr.de>; Fri, 12 Dec 2025 07:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD671277C86;
	Fri, 12 Dec 2025 07:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bLs5yNco"
X-Original-To: linux-spi@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013063.outbound.protection.outlook.com [40.93.196.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309A93C38;
	Fri, 12 Dec 2025 07:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765523681; cv=fail; b=CK9gTlhGRKimPZuikl/uNCREsvRUXTvKyut/INlCkLtvYq/WUbQNBiuDHZmDyRMwyWBGqb2d0YxpuRIStVWuht5ZxYCx5dXDaYTUBjo6guEuz7AizfYZEzezLY2dDMiRlSQgTLgX+hq/2eN5lJQXd6iQwUUAcRTWpm6Aaq5NKsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765523681; c=relaxed/simple;
	bh=1+fcJUpHUu+Ec8FlFbbmdTbzS/i2iwv1LTcIBNWVs7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=V1A45DLtAotJd9K+OjHEmSg5igO6CnkhhIfjL/HGYyPgwJmQqpoRozW+9fbtwLpMUqM6DRskpyckwiUoUHPbqIQsACp7GKLeQyKBmcLMNPpQUBhkHJPq52RSRiHx+b2QO+0SOTqZavWXzSUI/VSk5pqAzLAK0EY0O5rxO9D2+e8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=bLs5yNco; arc=fail smtp.client-ip=40.93.196.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rQDiIk1xPD/YT1zI8B+2idAXS1xeXbUfFN1UIgWW+a4YhWDOfJARDYyv5MzqOTz0P9aUsr/lfxDzhf0c8h7Vv1HnQEUkLWrTVrpYgZC81UGaQlVVW90JsJdw1SEWmnXxUw/ni6MU+xhze9Meqh6rPFtj9wyH4BcyvMdF1OeutQYmz+QVoM7h8oDzC4BtxUQaridLTWYwxWHdXmulivYp6cbEFliXs7yM4gzHxcL072Cn9WEBGurU8voiasRNBX/WlGoqn13nirAO3VPxP+uTYq5k3Ei4TKeKbB4zbIZn6cseZaZbj+1BHxLkt94ufAUle+H9B6PZsZ3Bs25h13KTLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pW0JQmBXsatu+YyC2ytVt/07N9jnggsTnyWuJ2kCvJ0=;
 b=MotFz9zyed5aVJKnj2J88cah+GPaiXksjAwjPHh4Iw+aSXpmxkChlPHs0Vl1rw3Y1uZvraDeiX0GsV2xIWxWAN8bObeSFBG1jN35w2awvi1GRW+qp7Uqky4wGDghmcszQILen4rmAMRzsIyNYD/QUfxReiqFwlZp5D6rSSKkDl249Iv35VMwhLGLFq8CZxGNMY92q7zJY2UlglVgvnICULlUXSapdZFvRub1C3uyD/N8nYPBjoN8yo8bgDTzUnKCBfOtO3JxX42mK8/90ZlgfWy1BILhv7bGzM2c02Hb0da6dawP6YBXznxTKxGq7yI2U/bWTV7MK5T3APrmIsoirA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pW0JQmBXsatu+YyC2ytVt/07N9jnggsTnyWuJ2kCvJ0=;
 b=bLs5yNcow5H28GO791F2SgmQVwrDxeyo3UW3eZoR6N9AT7AjN1GNKyTowhC+gLha01ZdMWVEq6fqINv/Ud38SsJDc1QCiZ1kTYIkmj3R6C1upXnYog4FU1a96vqNkAssbvTgV9LWrJXhkc8Ml8EG//X1j+z9UE2rDE9TT/QXsWM=
Received: from BN9PR03CA0358.namprd03.prod.outlook.com (2603:10b6:408:f6::33)
 by CH4PR10MB8172.namprd10.prod.outlook.com (2603:10b6:610:239::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Fri, 12 Dec
 2025 07:14:36 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:408:f6:cafe::4b) by BN9PR03CA0358.outlook.office365.com
 (2603:10b6:408:f6::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.16 via Frontend Transport; Fri,
 12 Dec 2025 07:14:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Fri, 12 Dec 2025 07:14:34 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 12 Dec
 2025 01:14:28 -0600
Received: from DFLE211.ent.ti.com (10.64.6.69) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 12 Dec
 2025 01:14:28 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 12 Dec 2025 01:14:28 -0600
Received: from [172.24.21.18] (ltpw0bk3wf.dhcp.ti.com [172.24.21.18])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5BC7EPEm1792237;
	Fri, 12 Dec 2025 01:14:25 -0600
Message-ID: <367c82bd-7121-402f-b459-d48feccc887b@ti.com>
Date: Fri, 12 Dec 2025 12:44:24 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: cadence-quadspi: Fix clock enable underflows due to
 runtime PM
To: Mark Brown <broonie@kernel.org>
CC: Nishanth Menon <nm@ti.com>, Francesco Dolcini <francesco@dolcini.it>,
	Siddharth Vadapalli <s-vadapalli@ti.com>, <linux-spi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, "Gujulan Elango,
 Hari Prasath" <gehariprasath@ti.com>, "Kumar, Udit" <u-kumar1@ti.com>
References: <555e9f6b-b8b6-4cc5-900b-63aaff8b4e6c@sirena.org.uk>
 <20251204140530.xax5didvuc7auzcd@problem>
 <4d6b857e-4bfe-45ef-a428-6e92f218f0c5@sirena.org.uk>
 <2fcf5235-cc94-4202-9164-4889356c5264@sirena.org.uk>
 <cd95320b-6852-476e-bc8a-2e8d1ac77a9e@ti.com>
 <f804d7a7-4ffb-4d2a-bbaf-ca0a076a11ab@sirena.org.uk>
 <5525272e-7220-4352-bb08-ac66631108e0@ti.com>
 <cf8e7003-ebca-4817-8350-f29332d75fab@ti.com> <aTf6RRAveRdVnWQZ@sirena.co.uk>
 <1542ee8a-620b-4349-92fb-ab1f6c5b5eab@ti.com> <aTuxGAn_XvIK-mJG@sirena.co.uk>
Content-Language: en-US
From: "Dutta, Anurag" <a-dutta@ti.com>
In-Reply-To: <aTuxGAn_XvIK-mJG@sirena.co.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|CH4PR10MB8172:EE_
X-MS-Office365-Filtering-Correlation-Id: b0e37878-9436-4de4-05fa-08de394e1a98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TmdzcGYwS20rMmVoQXkrNVhGNFVvblo0ZUpzTGpaZVZWSFlNc1pnOTBIZVRP?=
 =?utf-8?B?aTdEcHhEcFNvcC80SzVLR2hFellEL0o0TU13QVpVeTFhWEEwUzZUSkl4ZTkw?=
 =?utf-8?B?dlJJNlFMN2oxRzVlQkZtMlZCRzIvcFNPRzJSTkV1TzZ2b1d2YUU4dDNpbkVr?=
 =?utf-8?B?NGEvYjFQTDZ0KzhidHlRVkprazhUK05HMEx1aVdMb0lZNExmY3ZFaXdIMGRE?=
 =?utf-8?B?RFZBQURhMGMydFlpQ081RzFoa2toeDk1eUVablBSZXdXc0tGTnR3RXV1RkhB?=
 =?utf-8?B?akhkZkFvcjJuVHNRWTcxSnA0S2NWbkZNbzk1ZlNDQnpJdmUxalZYSk9xWTRW?=
 =?utf-8?B?N0VHcURTNmRTc0Z0R3BpMHZtQTU3OFFwZVlsNERYMUprZmlGRFd3Q1dTSmJ6?=
 =?utf-8?B?VnVRT09TUTZxK1RvOUtFd0llMDliKzJLcWpDSFZiclNEZFdjVVI0dDJlUDlt?=
 =?utf-8?B?eUNIZGhLcGNUL05sSDBwNWlMWW5haG1PRTVRckhXdXBLRDRKeWxPVnM3QzZr?=
 =?utf-8?B?RkJ6MXdxL2ZzVUxEY29Vb1RHdWNZcmpQVEZsZFA0VVBZWk1Kd1BDbVdqQTdZ?=
 =?utf-8?B?VWs1WkR1YUQwWVRaZnZWRFZLZEJSNzNCN01hNXI3Tmh5cVhja1h6Nyt2ZkZK?=
 =?utf-8?B?c3JsWjdhczZCcTZtQ3NQeldaWHUzMVhKa29vNXVRc2lwODVVNWk5K1BLZjRX?=
 =?utf-8?B?Rm5FZTBybUg2YVJscHhSOG0zSnZKNW9tbnFudkx1WU16aVF2ZmN3azVDNGZD?=
 =?utf-8?B?czBCQkg3Y3dLR3Q0SkR1dlhOeTJRZVcySExJSEtsSllsdzc3ZWhnNVVBbW9o?=
 =?utf-8?B?cmxTL0NrdGE2QUIwWUhkWFVCcERzR0tNcVAxemZnTVFmRnFqVE82YU9SVzlK?=
 =?utf-8?B?OUtDZ3JUUTJjRWVlemNqTlBJckJTcnNLaVlKYUkyVkVyVUlqaWNreks3Um82?=
 =?utf-8?B?Y3NqRVFJM2cxSVVFT29sTHhaRm9LSGlFL0dMV2h0SHBxM2tUdE95dTFIL2ZT?=
 =?utf-8?B?YXRmeEd6cVJLMzYwQVBmS25CTHB2dmhyVGpIeElZbHB2YkljZE9KSjJpZFU2?=
 =?utf-8?B?MVI1Y0dtODd4Nng3ejZ0cy9ER0hoQVFFTUNSTWhDcHVjY3VsZXZES2VXd0Vt?=
 =?utf-8?B?dHZvSmFnRTZjdUJpZkVCclZoUzhkSTFiQTlmc0N0ZmZZRWdvdGJ1ZG1saUN0?=
 =?utf-8?B?dkdJS3FqOGtrU28xVlZ1VG85RWlsSjd5L2FMY3dUZDU3cExqYUM0N3pKM1hj?=
 =?utf-8?B?ZjZPckhzRVh1OVY5cVN6Z1pNeFJGTC9oMUxUNUEyMWFndXFOSWtyc2NURnhh?=
 =?utf-8?B?b1lhdFlnd253NnlabXN0TUpaaCt5R3VwaHI5SHp1TStOWkcxekNHcWIxUitI?=
 =?utf-8?B?V3VjcUNxc1ljcHdRTmR2QXNVYVZzSVZzSng2TUNXU1dFSys2bWxIeHlXL3Uw?=
 =?utf-8?B?dEg4QTZ3V2hsenV6VzZENnhRcDJPU1AvOHF4T1JVYlJwVkY2NExIVGkxa1hL?=
 =?utf-8?B?cEZHVjlFRUZhcXdLNyt1YUwyZTlWNlFTd1BHdUx1R1pFTUVhMERSQTdDSmY2?=
 =?utf-8?B?dTBhYURzQnk2dENpKzl0Si9FVDBodkZtcVFTcDFvVUUzaGpVMy9PWjBDVkVU?=
 =?utf-8?B?TVlwdXIyUVRGYVppeE5zUEZDd2ExMGlEUmFqSnAvYWtxQVFvZkM3UEdxcFl0?=
 =?utf-8?B?bnIvbnRVMCs0WnFnNkVDOFFBbnpyT2xkZlBJKzBNNjludXlWek5uTFFyZ0dI?=
 =?utf-8?B?aUdiUWtPTkVFalFPR21PSG4vdTVIWHJJL1NHeUJtWVY1VU82djRocm9jbS9U?=
 =?utf-8?B?Qk5sbjloQVA4SW1xelE5a3hKVEdmaVJ0L055NVhVenNWcVk2bFVpYlUwMHpT?=
 =?utf-8?B?TUJlRjFiNngwME5tTU5xQ1pPTktQYVQwOCs4c2F4MEVXU2t1S21iWEtpMEJh?=
 =?utf-8?B?c3NOcjZwa3cxaW5LWm5LUnFyMEV3S0RoZGhwNFErbE1sTmFuaHlSY21NK0NM?=
 =?utf-8?B?SGtMNFBiZ25OWE10R09PY1kraERMUEZWWE91STlheHBxS1R5Q3Nuc2RIaFVy?=
 =?utf-8?B?WU5qMlEwUjJxdER3Rm8xdjhHQjZJUkhrZ1I0VGNoS1k3eTliT1haejJSVXdu?=
 =?utf-8?Q?rqiM=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 07:14:34.8378
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0e37878-9436-4de4-05fa-08de394e1a98
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8172


On 12-12-2025 11:37, Mark Brown wrote:
> On Fri, Dec 12, 2025 at 10:04:47AM +0530, Dutta, Anurag wrote:
>
>>> Let me send a patch with pm_runtime_get_sync(). If changes are required,
>>> please let me know.
> BTW note that we do need to have a clock disable for the case where
> CQSPI_DISABLE_RUNTIME_PM is quirked in as well as the with/without
> runtime PM cases.
ok, will remove this :

if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM)))
because pm_runtime_get_sync() >=0  will be true even if
pm_runtime_enable() is never invoked.


