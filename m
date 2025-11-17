Return-Path: <linux-spi+bounces-11250-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 44002C6335B
	for <lists+linux-spi@lfdr.de>; Mon, 17 Nov 2025 10:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7A4FD368555
	for <lists+linux-spi@lfdr.de>; Mon, 17 Nov 2025 09:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2373271F7;
	Mon, 17 Nov 2025 09:32:20 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023098.outbound.protection.outlook.com [52.101.127.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE5832779B;
	Mon, 17 Nov 2025 09:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763371940; cv=fail; b=VkPe/T0SYyFHU7zPM7UJAEmxjNVVX0oNBN4Wel3Sgy5q1iLKjn6/mHV72+Co/qjeBhCeyQLzF+e9JD682SxTE2gWe9QGWk2GtXYH9s8msantYKDAjJbm41rBxbUuaKCQtNTTh1FTngfoCkgmpyY1GYl+C90Y3eIiaLlqhQV+tjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763371940; c=relaxed/simple;
	bh=9qGpgIBujIbDpOQya92P6b1tMLNw0DjorodsoLwj4M0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AF7ND8CR1sJGa2nQsarn6z1C4FGzElmOjxGn3WWbRJI7b4E1HHdDTAbYZY6sIk+u6oFFtTz7hb4xLS+FdpCnrAe1sFQHUNJyDtU6vvnpKqCstzUhX4MT5ZCGFW/XR+9aRxQRD8N6/yPTPPSdpiO+nExA0jMkl8l6JzTIBVjMitc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.127.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lpVuO8psbfTjm6EZS2DM30lKaRvarACpwPQTcPjXAIUlxVkNVP6EuVSTlBDFr9HWamx0ny5PZ0M16oHEeT5kT+zJyDlKcoWwcNr0UeSo+UMmVqCfKFz40GBpMrb6OeUa0AAMiH7P2dLhbVtWCf3OlfFGtI2Rw7weoiwx+knhH//yENCsG6J+JUREk4tcVwn49R8En7OWAHmLX7wobY8tVu4thCGNzw1ivpMLYhEH0ZLPDAtrkK/myYt8ERTHzNOYMYfMbg3iVdt39X0nDsnMDp5D7GPFtcsyiFmCC4JMyv4ko5qjSwi2Z+y//VzsD/a6Ou9TMQq0mX1U28yAXUPY9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7E7WiAQ8nMpI6y33yPslhWFJnkDpf0YV+3TomhWwhtI=;
 b=Kcy7/Wm+m/zuvg2fqqCWH8bJNV/WPiPxY+x8ty3DV+bv9D1wDAZwMS1+IxyrfTRfmzwx93CgrbLjGAWTE7rDApr9hivAQbrh3LcqhifHK7oqUEOiyX/ndX5KW8EC4jzd+Xe8K4jfurZb2nCPixLVBgViKPhuDOoEeSEmlrvSHhd1gS9dhZXkLvC0Lr5Y9H1PpaE2l0x5gjM5kjaR25E2ZVNVjC3eeryBbzQoVa6/TWVx1uvekD61zpt6hAbPKhbgHBOxQ2J+M3yUnhJUxm6fVeo7URLmJgJsobJxGzs9ROcp5gLaURKleqbZPmqKt+/wgxMLnYlB5L/BT+k1Rr0hyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=amd.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SG2PR01CA0191.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::6) by SEZPR06MB5691.apcprd06.prod.outlook.com
 (2603:1096:101:af::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.19; Mon, 17 Nov
 2025 09:32:14 +0000
Received: from SG1PEPF000082E5.apcprd02.prod.outlook.com
 (2603:1096:4:189:cafe::c3) by SG2PR01CA0191.outlook.office365.com
 (2603:1096:4:189::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.21 via Frontend Transport; Mon,
 17 Nov 2025 09:32:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG1PEPF000082E5.mail.protection.outlook.com (10.167.240.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Mon, 17 Nov 2025 09:32:13 +0000
Received: from nchen-desktop (unknown [172.16.64.25])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 80CC541C0143;
	Mon, 17 Nov 2025 17:32:12 +0800 (CST)
Date: Mon, 17 Nov 2025 17:32:11 +0800
From: Peter Chen <peter.chen@cixtech.com>
To: Jun Guo <jun.guo@cixtech.com>
Cc: <fugang.duan@cixtech.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <broonie@kernel.org>,
	<linux-spi@vger.kernel.org>, <michal.simek@amd.com>,
	<cix-kernel-upstream@cixtech.com>,
	<linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] arm64: dts: cix: add a compatible string for the
 cix sky1 SoC
Message-ID: <aRrrm5kEYGIG-aP_@nchen-desktop>
References: <20251031073003.3289573-1-jun.guo@cixtech.com>
 <20251031073003.3289573-4-jun.guo@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031073003.3289573-4-jun.guo@cixtech.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E5:EE_|SEZPR06MB5691:EE_
X-MS-Office365-Filtering-Correlation-Id: 66f21231-15d5-4262-334a-08de25bc30a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?M/uDj3SeoeCPGbNB50f47nAYHxdcOJKAn3lHezBVel23ovXiLhonSAW9T8Dj?=
 =?us-ascii?Q?SKUq3/IeBVK7yIcUAf93xDlyPO5yef4vmWr1oyKx/WI0qb0FTEA7hYsUP5V/?=
 =?us-ascii?Q?W+JNXAtYHr1HsFFylF1tBnBLX4FWZFBgLKcdC1kAxjSHIGYBbjFwRXr0Ylig?=
 =?us-ascii?Q?HEu4GYotIMm3bcFsj+RebashnpeNPMB3aFlDvEdQcRNN3YuIMUSJ7HBdVBe9?=
 =?us-ascii?Q?bb4LIhQRWoyVRTe3orPd5Q5JGnoH+YzJQgaRO1PG+Zd5FKIQf+CgwL9ZGy3z?=
 =?us-ascii?Q?L1b8q/odmInZmk087iqx6vXBhYh9o5zO7gdReNIQ7oTkTpjnH8RQhG+s96pr?=
 =?us-ascii?Q?WC7yW4kGUoDMDD4Im9K54HAsP7wxI8eczB5mKtfFoubD+Obe4BJ4Sj8/3fBg?=
 =?us-ascii?Q?d389aqORyAR1vkUyskH1kj6PrFVouM50ELQpuqpvZKsbbMImoeO3MvRdZTfv?=
 =?us-ascii?Q?A9FSZjpMWg0eOk3CaboIB0wyqIOF7iqHLfJsadgGJhpaDLMXO9OZ06QHHXzR?=
 =?us-ascii?Q?DCUf0bZ5GeK25WGYrQR79i0LNRO1vXL8NLHU+N+9fpFtdXj1P+hT6YQIQTDP?=
 =?us-ascii?Q?N+Y1djAgzFrISZZQHaA0lUtfo81lhtWTxn31hG+h/qHGaXnBvMnWugW6Xmp1?=
 =?us-ascii?Q?56Dfl/V8PdhF7sYpnsehDBNBclpvw+GqptuLxmaSwDkHiNEcn1PqTvoiVr/j?=
 =?us-ascii?Q?ZJYXukjosJ2krhoO86TOu4juC0bSHCfSGXcihPfsL0f8VrdIdqspaW91g2aB?=
 =?us-ascii?Q?3dW4uxuAWiOkUyEnHuRxzrxHwMVOmrYGG+7L3Bonax5LNbRaytkYa41RzFuT?=
 =?us-ascii?Q?881bu/Htt6KVuz0EkNwQDgyhgA5i2d4nF/K3/XagB/xUeBp08fx5XBkjIqQN?=
 =?us-ascii?Q?z7jYNYXnPeTXoBTA+brxyL5Gw9NUMwvxZZ1OwfA6HsDrl1ymfI6E7k0/uF5C?=
 =?us-ascii?Q?xP26PuS9VfhtWm6iD5Bu5ArZsi8w0wYMB1Wh93E5JUl4xH+yRRUFD0Lb811k?=
 =?us-ascii?Q?jvucdA1SNKxYvopjD7PdoF7SnXV6SGMrfs24+ATJNDyuQhwG+OcfSWhIZEBe?=
 =?us-ascii?Q?YwJjsrJ2pRrXEV3mOVr/WPbM1xxVGvfyHcCYh8HWFM2CG92B6ACWeLiPNTdF?=
 =?us-ascii?Q?fsFwoFVP3tRgrxi9TpKFTJSRBFMfykhcAM1hKyZIhEc8x3eXKjCqwE2hoBiW?=
 =?us-ascii?Q?nSRjKCuo68tcX0oLohC9upExnnS03/AD88/TRBSjnuMt5051Im80swwBQVbe?=
 =?us-ascii?Q?kL7zG8fUG0RdPOqyACIGjjinzYDAdNkzNMChKegP0HX3O9M8f4iSBlc0jqBj?=
 =?us-ascii?Q?QofRuXpiqmZ3XDHBegemZ7V5+uHh9egZNoITmBT7Ar37W3TXkJWHp7kIt6Kq?=
 =?us-ascii?Q?3dF7PwKVyroOYDqFNTq4HQPqld7++sgFygz/DkNpqfqmRU/s6tbkQVFBpldY?=
 =?us-ascii?Q?B9Yep/TY4C/oTuxm9yZxLwZf487hHMGjyoHHK9om66N0PEWvvDtsfqrOZA+V?=
 =?us-ascii?Q?dCt6XLSluxjsugdVyziq6fMxUcWx81qfyAAk91terq0qghPym1a5gZ/DXLxr?=
 =?us-ascii?Q?gJWCRDH54QBRaM1aFug=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 09:32:13.1352
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66f21231-15d5-4262-334a-08de25bc30a1
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E5.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5691

On 25-10-31 15:30:03, Jun Guo wrote:
> The SPI IP design for the cix sky1 SoC uses a FIFO with a data width
> of 32 bits, instead of the default 8 bits. Therefore, a compatible
> string is added to specify the FIFO data width configuration for the
> cix sky1 SoC.
> 
> Signed-off-by: Jun Guo <jun.guo@cixtech.com>

Applied, Thanks.

Peter
> ---
>  arch/arm64/boot/dts/cix/sky1.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/cix/sky1.dtsi b/arch/arm64/boot/dts/cix/sky1.dtsi
> index d21387224e79..189b9a3be55c 100644
> --- a/arch/arm64/boot/dts/cix/sky1.dtsi
> +++ b/arch/arm64/boot/dts/cix/sky1.dtsi
> @@ -265,7 +265,7 @@ i2c7: i2c@4080000 {
>  		};
>  
>  		spi0: spi@4090000 {
> -			compatible = "cdns,spi-r1p6";
> +			compatible = "cix,sky1-spi-r1p6", "cdns,spi-r1p6";
>  			reg = <0x0 0x04090000 0x0 0x10000>;
>  			clocks = <&scmi_clk CLK_TREE_FCH_SPI0_APB>,
>  				 <&scmi_clk CLK_TREE_FCH_SPI0_APB>;
> @@ -275,7 +275,7 @@ spi0: spi@4090000 {
>  		};
>  
>  		spi1: spi@40a0000 {
> -			compatible = "cdns,spi-r1p6";
> +			compatible = "cix,sky1-spi-r1p6", "cdns,spi-r1p6";
>  			reg = <0x0 0x040a0000 0x0 0x10000>;
>  			clocks = <&scmi_clk CLK_TREE_FCH_SPI1_APB>,
>  				 <&scmi_clk CLK_TREE_FCH_SPI1_APB>;
> -- 
> 2.34.1
> 

-- 

Best regards,
Peter

