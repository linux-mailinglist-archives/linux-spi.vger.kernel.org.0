Return-Path: <linux-spi+bounces-502-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1854831CBA
	for <lists+linux-spi@lfdr.de>; Thu, 18 Jan 2024 16:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A7DCB24089
	for <lists+linux-spi@lfdr.de>; Thu, 18 Jan 2024 15:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92DF31DA35;
	Thu, 18 Jan 2024 15:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="E2UkbXC6"
X-Original-To: linux-spi@vger.kernel.org
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2048.outbound.protection.outlook.com [40.107.14.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1F11DDC6
	for <linux-spi@vger.kernel.org>; Thu, 18 Jan 2024 15:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705592615; cv=fail; b=UQGmMvBpvdLeYV5+GZ8Jj0olGBD2mo134iOjxpomNroX5jr0bY56jVI+MUOnZKUMOqiBdQUxLN4ygOriQ3j2Z9XyYIXBEQwXwM3hAHOBwYTh+HlgUFY+S0Joj1uSj9RsPwh4tTZi7bGl4PyyrtkAuVm4gDx7xHjOoI1uK2wo/0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705592615; c=relaxed/simple;
	bh=8hWYHr+203yxrdFo+fB1BD1Z6yVzZcH9aGq999RnQgA=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 Content-Type:Content-Disposition:In-Reply-To:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=KxknkBBokq96YIgrZ0C12XMuWezkZ+gHUUwyRtmNDg9dg8AdS4XERGtU74R9/gS7t1xztzeja3hU+PhTV7X8ySD32ybb7biCjHb4kmbl0p5N5dIfKsqZvp7fMTiFKPlEPK4b0lJCJTJ9aYrRtvsSNLHPdNHMq0ExqfxE09Gwpeg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=E2UkbXC6; arc=fail smtp.client-ip=40.107.14.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JTUSTPSVgDu9pltniuwIRq0zhxb6ZR7c+bRmiWfIOYfeo4ddeg/WXXRcE/KhhXB+IDsfU0VWHLeSA2Fa3OB34EiBI9+SeYxIj5Cj1/XNJwXFzl78MWw/+xuwzS9WuNaPH6qFgTjYsIk47j8ZpybLB8ZXDMmyTwBsYd+UB+QfQHdYF89zHOXsl5KAtc10WL3E4AKyFiIEDvLMIbeOBB15lZuLY3vlS/HCMLW0wiABplvYDrJGh0l6bHn/1LZBtm2w5fyfayEmlD07CAHN8Rc/OrlftZLNP4eZi30YG4lTOrkfonLYZj5KADNKD2pNmyFjF/doySkJrGnGaPfPCPvl+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sI3bqrgH4gFyiGZgZOOxSXeGg0gp2ByGtc8VDtDnaXo=;
 b=dlVM0FaWx7R5+BcJ/bsGU14i+CiEEP3GVbPyOhu91HLVFwEX6chnAYsURRO58cIMbogZT8MJChcN6qIBICvaf0qT8QH6aiQ/ppQM5oNMXAKETR9Y1SPD/RgSvU4x7uFV/7ZcquRxWJOJPkASWPUmEQ+0NEWoljMi3zTMdP5y4MMBOyljRNmHRoNUxfoSXE1sFasja/tzZdRomf96b/RUwf4afiCQYQWDrD+jXU35gVqq3CuNcUSXw7gipuLljXGECp9O51LQmea4qCLJnHINqLERIFuU7ydwvobgqy2uVyxUeWCBOBGLPUZg1Zm1J0R9IUtqC6h1qh6J1hsFiXsRhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sI3bqrgH4gFyiGZgZOOxSXeGg0gp2ByGtc8VDtDnaXo=;
 b=E2UkbXC6NvY10d4cqR77BIP0cgZUU6F/k6qXvrVsyvroOeEb7lh9PeZCV4yg734Ywz1kl0jn4FV3PwMwl8HhSLvGyvxcOMZDVEcZJrBEv3yd43bdON6/dqAWH9Mu/o1+p4ZrfH1qTZgo2aZhw6qKe+pKLrUrwdjQrI3KD1qnaVQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9071.eurprd04.prod.outlook.com (2603:10a6:150:22::11)
 by AM9PR04MB8524.eurprd04.prod.outlook.com (2603:10a6:20b:433::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 15:43:30 +0000
Received: from GV1PR04MB9071.eurprd04.prod.outlook.com
 ([fe80::45f1:a6de:ef4:698c]) by GV1PR04MB9071.eurprd04.prod.outlook.com
 ([fe80::45f1:a6de:ef4:698c%3]) with mapi id 15.20.7202.024; Thu, 18 Jan 2024
 15:43:30 +0000
Date: Thu, 18 Jan 2024 09:43:23 -0600
From: Han Xu <han.xu@nxp.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Haibo Chen <haibo.chen@nxp.com>, Yogesh Gaur <yogeshgaur.83@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Subject: Re: [PATCH 1/1] spi: nxp-fspi: Adjust LUT debug output alignment
Message-ID: <20240118154323.rj3qf2i7tusk22nj@cozumel>
References: <20240118121016.3734770-1-alexander.stein@ew.tq-group.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118121016.3734770-1-alexander.stein@ew.tq-group.com>
X-ClientProxiedBy: BYAPR08CA0058.namprd08.prod.outlook.com
 (2603:10b6:a03:117::35) To GV1PR04MB9071.eurprd04.prod.outlook.com
 (2603:10a6:150:22::11)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9071:EE_|AM9PR04MB8524:EE_
X-MS-Office365-Filtering-Correlation-Id: 45e6a71f-e5d2-4b39-c068-08dc183c3862
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wtIPR8RMZSDjf6WAJFKeiVbPUGiDuX9Y5N/01I8yA7YRQsBuGZlnnKEl/fWohPrfZAyAaRB4Dwhj+Rnpzyeq6v9BszBON/1VzIHmGzdVz8atwgB7POTLbAoF46oVzebI+ziBhVFtaAbhBhbV006R6jueidonRddIUE+QvuB53qwlcsXPGekTTeAUVpinybs9vcz2XFESgnH+lrDiEmSKYCJ4VLrm03tke7LZNKVoEA4HMmHlZrJ1AVWy/cV3nLv+ewzyStaXag1tcCBxr+cwylCM1/NajicKaXy4xdaco/5Hm5kdVXEydsQTEjzE8Q0BlAS7Im1yHKjVCKQ3zSif4XRXeT/J9peMQdXPqlAhGagFlYa3xCqntYhvisrkGP2PGmh7LUEZGS4/0Tx8SdQVTrmDuNqtU7nAKBsuw/yWmvUvYnvgxtkkJcy7S5lCKgjoEjJAFvU/MogYi3+0oyHyxcR1uPXYtGdEMH2ZaIpZzhMkYe1UF/CKCGSsvuvIqL40wn3Zqz0CIidbBS7m2dyzu1uyTfEwepwA2eN2RW0lTn85OvqeK0ZQbcCnX6O/q907tdMIlEVgHw20D1DnJdNa/0FHIsePxmi1ZzwTisTxiTcsHsLyHWoPxYIC3HVJBeVv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9071.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(376002)(39860400002)(136003)(346002)(396003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(26005)(83380400001)(6512007)(9686003)(52116002)(1076003)(38100700002)(5660300002)(4326008)(8676002)(44832011)(8936002)(33716001)(2906002)(6506007)(6486002)(478600001)(6666004)(6916009)(316002)(54906003)(66476007)(66556008)(66946007)(86362001)(38350700005)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s7B6CJ7h57sxZl9kxVByczl0ZfchQa0nkAlAIrO/VQwcSGYXHB9ywUBYyGW3?=
 =?us-ascii?Q?k8d1gkgBbiBN7UYbSr7Lx61q+Bufb/s9iRol1R+i9WWIdgn6XHKxLeHNvYEE?=
 =?us-ascii?Q?MHWisWPlxkmYATA6+Qk4ieSTT1nHpp+y8Qg6e02HqTSohgnesXaSwTlbB/sZ?=
 =?us-ascii?Q?QY/WLI2/mSJZM94CZZhqIO0+GROQBXzv0mCchiB8iu9mYibxb529cO+9ETFF?=
 =?us-ascii?Q?3KdhT+CMHjAdAPKD7A3RzAysJxqfz66Bf7ZG8DtlvP9Iz0xi56fOdp0HcX7D?=
 =?us-ascii?Q?m0vNMFSvhVeHb/ibKy4yAZoRJSkJBBDPA36IcBIb2duDZZ1Mszk1wZgs/O0y?=
 =?us-ascii?Q?n1boCqDsUAVjTyACKMceHKwLNyPbCXUlJjUqQxrcyRW7DI8rlVfffZXeB8a3?=
 =?us-ascii?Q?P6+M1cfHBehazrCGqZM8dayfN0PivWPcqPBrWwEqbZFyRKpRXBoTq2CQe+JZ?=
 =?us-ascii?Q?37sGKnXs3AD8jKMxay1waID8/TIE7jigLpQX91S9ByN2Zi2EDZNZYeuPBkn+?=
 =?us-ascii?Q?uYAR+xFxJomcK996iKDPOjvLxCWK1ksiY1p1jSBxCPe322FJp7UmlsDMPZsQ?=
 =?us-ascii?Q?5opwIRxZJJOi3BZ8m29HOnlCRZ6kp2g6E5wCNK8VUVVCbpKfqsytp4BghHh2?=
 =?us-ascii?Q?jOBZkfYFD/+3q8n1ezD352oYSZ/9UltdkV+ouaJnJLfpC6Gcjd7tUBQ7Hyqq?=
 =?us-ascii?Q?Nq+pl8tAh1v9E97qUIO3pJaGGBfefgmXbZjQiVTi5jGrMMDPY5oIsRj3n+tX?=
 =?us-ascii?Q?andXNOWramIDEd0UHNRYQr0fRsh1xZ23HvWNaupUdOiRBfBW8O8NZfhcZtVD?=
 =?us-ascii?Q?dpDk6m0gP2Kdb+RU0OE9jHPn1WFZLfnslSEcapgOyK3puvuW8OUUdY4bjAJw?=
 =?us-ascii?Q?JN/u+Ja+RNtUlQOsru7CWOKsjAgGex6pPbhexSSqkUfxUUM3PBlwHKEOGfV/?=
 =?us-ascii?Q?15T+QBKN+c+Qj8w+t45iO4e2fWn4vZMv+c/kgBh8Qz7cQEa6u+IespbECvqZ?=
 =?us-ascii?Q?Za85W7gkr5idG+6pdIry2wne4zLnnGBSOwBby+jyHjsBohd3VBBCOuuafp5k?=
 =?us-ascii?Q?ln5IzcYsDvoiENgrvJDu6LDWSaX8Vfkvrq4t8mLUusxf1iNtbhVBNQfXMOWP?=
 =?us-ascii?Q?CBsW30z7K+tZrsGhQiBp8+6+NIOxZ9QTGq5lyg3jrwaiMuJjKSzUk7b+fMzP?=
 =?us-ascii?Q?r2lv/wIiB/9XjoL1MrKJSD4wkuMtpxvQbLgHiKGmedVmWQWjeBI9HCsfHo6T?=
 =?us-ascii?Q?dZRds3cZmfPTOdhJ8xVrTrklBhdTpugL31loGVsJ0KnPEQgr6mFqyv2FnHbM?=
 =?us-ascii?Q?NiWqJChzNaHqDnxa3SLNtgzZOhIIus7hIA+JOzELxBe3jiVvoXxnrOROoLys?=
 =?us-ascii?Q?isdaHkjJXRQ6JtinAwFhQU6VBFG9lY4f7MatStrbswRwSSyQvz2g8W7s4+Bv?=
 =?us-ascii?Q?VAL0AYwKoZ78N8b30m3b0H88KF/cceMvz2oUfcX9DsiUantD9GW5eGKNYZEc?=
 =?us-ascii?Q?8j6BymFGCSMRiB+lDulclERpIiGinWwTlbd0f3CgvQyWwkuDIuwmAvSj0bzC?=
 =?us-ascii?Q?pdCpy50glCzhzJJF7VmuZ7MPalsCshHWHpWoy0gl?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45e6a71f-e5d2-4b39-c068-08dc183c3862
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9071.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 15:43:30.5269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GOde2MIoqtGbQTo6epbYIb+gwDUo59jpfE/nihvPA/wbOg+7w8lfc4tMFcsjH6fy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8524

On 24/01/18 01:10PM, Alexander Stein wrote:
> Ensure the command value and LUT entry values have a fixed width. This
> way consecutive output lines can be read much easier.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Acked-by: Han Xu <han.xu@nxp.com>

> ---
>  drivers/spi/spi-nxp-fspi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
> index e13f678f23952..88397f712a3b5 100644
> --- a/drivers/spi/spi-nxp-fspi.c
> +++ b/drivers/spi/spi-nxp-fspi.c
> @@ -591,7 +591,7 @@ static void nxp_fspi_prepare_lut(struct nxp_fspi *f,
>  	for (i = 0; i < ARRAY_SIZE(lutval); i++)
>  		fspi_writel(f, lutval[i], base + FSPI_LUT_REG(i));
>  
> -	dev_dbg(f->dev, "CMD[%x] lutval[0:%x \t 1:%x \t 2:%x \t 3:%x], size: 0x%08x\n",
> +	dev_dbg(f->dev, "CMD[%02x] lutval[0:%08x 1:%08x 2:%08x 3:%08x], size: 0x%08x\n",
>  		op->cmd.opcode, lutval[0], lutval[1], lutval[2], lutval[3], op->data.nbytes);
>  
>  	/* lock LUT */
> -- 
> 2.34.1
> 

