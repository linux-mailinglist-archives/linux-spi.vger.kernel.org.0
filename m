Return-Path: <linux-spi+bounces-12191-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5101ACF901E
	for <lists+linux-spi@lfdr.de>; Tue, 06 Jan 2026 16:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AFCDE305A472
	for <lists+linux-spi@lfdr.de>; Tue,  6 Jan 2026 15:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BE0337B87;
	Tue,  6 Jan 2026 15:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="TWzR3UBu"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F1C1684B4;
	Tue,  6 Jan 2026 15:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.182.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767712453; cv=fail; b=TDWEpkyQTHlMC1PPKBRVISj0Rjab5geOeGMNOnVghIE9715AwLQ+KCXxeQtwitU9lmMMgUzKYImWh+AcLQbAWhs4M9GwCIz7QMK2kKMfx1ClEP7Cnsmf+U27wGhnE5esV/GY1SZi1jmo68y7th4VKhBcfLSwFC73iKXIV0fEPsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767712453; c=relaxed/simple;
	bh=R3s0A6vl1aPam4N90S3kwkqCIHu0LvrOrjbDrsHpR3s=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U0l/oedMRA43lBOdLsQsV/leOf6bUBqBda2joO8Obqxo/ovhp6geFazPR+V5x6Z8yvjcWYa6gTm0veJ1tVt8wd9g/gZfHx0HIXOHSMXPt/FP8Xyy9ToaTr0Se5KThGxQ45oc0dxXT467MY64+83EoI7RPcwZn3jxYuHIjwtp1Vk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=TWzR3UBu; arc=fail smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 606EraOb1670665;
	Tue, 6 Jan 2026 16:13:56 +0100
Received: from osppr02cu001.outbound.protection.outlook.com (mail-norwayeastazon11013064.outbound.protection.outlook.com [40.107.159.64])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4besdkswyu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 06 Jan 2026 16:13:56 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DbXql3RvDWd2mWSes0F1qalvK1LSIznRjewjm9fNK4zBnBD+e4TWddavh9le5Q0IAKV93esrl9ZdJtDf0tPc9hYZFum2a9diFwdauY66TE8Lz5scedG/JhaD6WnbfJ4Yp7k/xnDAuoq2ShmKGN6ylz/N0VPVmp72LjbcygJg7O3fE5yQDjcvqYeW9emfDV2VfN/+bSHGOet/uivFu616FHHco+A/2pOSIqJjXi3/ONtDqJLGImMYj83AIu3GcJQ0tUuEts10u+O6mVW7yYt99NTi6u/4qCNTaH++g4f2y0WxBcxyfUPsetUTPqhy03WqvTlE0nAAgsh0qB/Hk98eiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IllgvvjBgIQxwiVw1wvuaNE1rugnsiPetfgokk/hnZM=;
 b=NFJ0MCjaDwuGDJEpBMBRmLzfx0DyztyVXQiWLAb/+hkm5Tu97ByquAkP5hriMzxiBjvz3InL4aPQYL5fPvsy9LT+BJQ+uthv0FcWIk6eL/aADk0GMz8N2CY1pZoBNj07lOE4SsWSH0RfAaKsNPRhG4BUeivbcvmNwFTgQ1VFr4XbtBsClmXzAia+jrgXcR+fm9u1pkiNtkYjsCCObiPUJtdOPxHILyN8OkxkI0oLvpRLydXnYArUii4vxZNgdHg42nfOIMKdECm1TS8D1uUcmHF39i0NlNfDFsZEsUnhR/AszxijRBP5KM0mGaS0V+wKxuXhddZPKM0udh9oRkfDTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IllgvvjBgIQxwiVw1wvuaNE1rugnsiPetfgokk/hnZM=;
 b=TWzR3UBuxd4R4pVlFH/N+ItAuoyiC6YH/bXpNFD8hP9FM3LrxTV8xOgyHF5xf5d2ySXsLEPsPLnDwDflrGs/NpvItb0ZOc/AZlT5dn0bjy3CbmKUGqFYSdmmqumVZL7Zu3BNs7juriL/z8H/pb4gAjT+4WK0qlwArMaT0pszPprA0tRaR3rFnd/GeE1brSk90uH+fhRbuGdG6Xn1qMPgeP6f6FFhMjCeOZsttni5JDzGRgX/arJ9GlnaTeh/nIoHGKQhNIvJPsKQpdnQn3XUaYmpM1mUfsLI9yOVmBF2o1NUYwxCcdLqQsDQf4+3lIHlnHVe+9h5FUkc71ATaDQwfg==
Received: from AS9PR0301CA0046.eurprd03.prod.outlook.com
 (2603:10a6:20b:469::6) by DU0PR10MB6980.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:418::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.5; Tue, 6 Jan
 2026 15:13:53 +0000
Received: from AMS0EPF00000198.eurprd05.prod.outlook.com
 (2603:10a6:20b:469:cafe::8b) by AS9PR0301CA0046.outlook.office365.com
 (2603:10a6:20b:469::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.5 via Frontend Transport; Tue, 6
 Jan 2026 15:13:45 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AMS0EPF00000198.mail.protection.outlook.com (10.167.16.244) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Tue, 6 Jan 2026 15:13:53 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 6 Jan
 2026 16:15:01 +0100
Received: from gnbcxd0016.gnb.st.com (10.130.77.119) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 6 Jan
 2026 16:13:47 +0100
Date: Tue, 6 Jan 2026 16:13:42 +0100
From: Alain Volmat <alain.volmat@foss.st.com>
To: Mark Brown <broonie@kernel.org>
CC: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 0/4] drivers: spi: st: use pm_ptr and remove
 __maybe_unused
Message-ID: <20260106151342.GA1667031@gnbcxd0016.gnb.st.com>
References: <20260106-spi_st_maybe_unused_removal-v1-0-8f5ca7136e96@foss.st.com>
 <fe48d1c2-07c4-451c-a2e7-338570557e93@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <fe48d1c2-07c4-451c-a2e7-338570557e93@sirena.org.uk>
X-Disclaimer: ce message est personnel / this message is private
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF00000198:EE_|DU0PR10MB6980:EE_
X-MS-Office365-Filtering-Correlation-Id: 528785cb-02f2-42f1-9f7d-08de4d363459
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HsYWA8p5ovDeuLW8c/YR4cDMF0LAWafaJ2CtpTRmjbYopPqnZGA+gR4//d0l?=
 =?us-ascii?Q?f6fzzfekDSEyFC7njVvtgQzFfMItFZE5bK6/B9JWuM7gVOAB7+yD0j0ifEbi?=
 =?us-ascii?Q?t7p0hm5855OakUo835HS3eQ3jKW0XXstxk2BCihKlTDzwjMkUgX1naGPUShO?=
 =?us-ascii?Q?UdA3CDu2whi3/QTZ9jBIJXUhS81PiE3CP6J/dGBdeDF5yjXxWFahU2nW9bqP?=
 =?us-ascii?Q?79QiKqY1TFWclvD1ayWw9qk+OlAQU0wodBgtec25LHsOQgkexUyPU8xsK6NP?=
 =?us-ascii?Q?2O19LYLaes2C7I4LuQOy68PKK3o0Pr+iX4qs+Nrmw2VGBQXPY0xQkwNGG0DK?=
 =?us-ascii?Q?gA/r0Fv+UGAK0Htyr+pesnIJ2DhPe5W2Ei+Sf1NJ5EWPT7x5hqTtJNRa8TWQ?=
 =?us-ascii?Q?PmtFqxkOA3PTFBKXRqYC5IJVyWcj0JAqE5vo4L1fyOqplbMpA1moPwHcLdOz?=
 =?us-ascii?Q?iN/kw1OrLOUq2axN7ce1N7TwcDD7sbBBw2d37pBxv4JicUb6/aPcr2D/YhMg?=
 =?us-ascii?Q?Lu5G2g0IGx3c08bYGYzyX35mH1tDoH6WC0JowaHKgzbyY0cim+incTgV298d?=
 =?us-ascii?Q?x+Pqg0W+KJxEzMs7yNw/iGlvGhrvIMgP9u9yMdBj1IJP/US14a3aboKfo5pP?=
 =?us-ascii?Q?fZdu6QXseTBnT1lglb3hmHuhTruqOTK2yf/3/ozp2TiimrFZEtOin++DyP+3?=
 =?us-ascii?Q?pe71priPbDdQHUkoCkBvwUpWsoERDamxY8Jjy6jI0L5c/BEpN5ujqFEzBgAL?=
 =?us-ascii?Q?SAc1Msl9rdZfG0swJdPqp4oIKLyu6z8J3CXPRD/Ng2K2PBzv/9ZN4AVzGBhn?=
 =?us-ascii?Q?njYFl9QFqHZqO4Y2Ujb1Es6wFGVp6xz2zv1rnjnniXN8qYowOhC22VJqLohB?=
 =?us-ascii?Q?kyqwFIyFHDjrujSsC+erLkunmeWH7LPVKQieaCjWlf+1TNb0hAamd0S55ziW?=
 =?us-ascii?Q?JSAlGuN9cYQdfQOM8mg0u2wuSCP19uD4uDiUN4neW1KfUPM5cSg41yhQUIN+?=
 =?us-ascii?Q?yvawrnbJ7C+qwcMAem2IJhqBz4PqYEuGUqRlAElasD9AeKODKCqDgDaTxfsL?=
 =?us-ascii?Q?/YuKCNP1ADtVTztv0rZ0zlyyjZaXD6RGOusGQ8KNNXie+JXe8cMhIBPaEybt?=
 =?us-ascii?Q?IXgaeZRa1iAKjirwTND0xnHcUIUS9vi/eJtQKRDReyNkvwpR0n1YY17PYpJh?=
 =?us-ascii?Q?j0VnE/dbn+wLlPJBhaDLKmAbmqXNyes1rVun+3aPbgkCndk2+KZstYHfvYkG?=
 =?us-ascii?Q?xOOXl2EUvq9oPVAo/1nCcEdnPOxrNafSoP9H/vP+NZeEZd/At0XzlBCAkx7j?=
 =?us-ascii?Q?kH3Tryrv+AZoxFvhI1yd9V4mDyBjCqRIVanETijnE+e9LF0lM45dHMBm2PPd?=
 =?us-ascii?Q?VxqOUA/xYAuaRrVcNseJi8DjRVhw2yBuGNyFOcRvricinIH6e8hjThAaj/Fi?=
 =?us-ascii?Q?ZoKze8rRMtpFtAiAjygN7ravdD5QW+0jww5/eDKefCWL1LNyU5TcuFxmclev?=
 =?us-ascii?Q?hmsumF7T2FUsG/Nf2IATcB5azDzXLeRK+xYmSFMBDF826wV0s2uM807OUgNQ?=
 =?us-ascii?Q?295PP4hG9LIMUim06Mg=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 15:13:53.4226
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 528785cb-02f2-42f1-9f7d-08de4d363459
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000198.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6980
X-Proofpoint-GUID: MhNi8u0PEjg3QtDqrJtRwPhh675l4Wa4
X-Authority-Analysis: v=2.4 cv=Vskuwu2n c=1 sm=1 tr=0 ts=695d26b4 cx=c_pps
 a=JRzJ8T7PdTfL/uBtHARA3w==:117 a=uCuRqK4WZKO1kjFMGfU4lQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=n5dE7JB0mAkA:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=nR5M2XifhQzMGXY2llwA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: MhNi8u0PEjg3QtDqrJtRwPhh675l4Wa4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDEzMiBTYWx0ZWRfXwlYHxy+5sf6W
 mA1afV7mCJHe3BdBMDZwjP+G21p8d+aEYrHjKNwzKe4Tb2icUiF2BMXxZQd0dpa73v22ihY/C1m
 Sq+zRU9K+oxfj0OEsGMHKc111Zy1AXCaOif3FEBHU4Mwft6/u9fq0RKKXJ2l+mPEDjqxtTNuq2M
 Vl5xVu+MuLaJtLhOaAa2Mv9T5RRBJm29szwLoulf/dMFsCHw/+UZ4CUdyLjEAW2iMYnvCA7OLGj
 t71BwE/W4uRBOOJkIN9+5tR8QB3k14DvNQt1HZGPz3W/xaOygbXGfm8XgdjA4IRoCH3o0yhu1kX
 W5LmTz5g7Mm9V2RwLMltzGsXi7eR92Hx8mzCV8Vj60Pf0MDHbla/5xx3PdP8dpciwdpTv3KcFHb
 gWzasJqQReUoqfFSbpVlu4xBtgIzMpHv+BpDDjnovj3JWEKl+aMYgMatzMlLKN947KBQcJtOSUQ
 98pD2IGtmcaAqUrH97Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_01,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 adultscore=0 bulkscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601060132

Hi Mark,

On Tue, Jan 06, 2026 at 12:22:21PM +0000, Mark Brown wrote:
> On Tue, Jan 06, 2026 at 01:14:16PM +0100, Alain Volmat wrote:
> > Update ST related SPI drivers in order to remove the __maybe_unused
> > statements on pm related functions thanks to the usage of pm_ptr.
> 
> Please submit patches using subject lines reflecting the style for the
> subsystem, this makes it easier for people to identify relevant patches.
> Look at what existing commits in the area you're changing are doing and
> make sure your subject lines visually resemble what they're doing.
> There's no need to resubmit to fix this alone.

oups, sorry I missed that indeed. Thanks for your help for this issue.

Regards,

Alain

