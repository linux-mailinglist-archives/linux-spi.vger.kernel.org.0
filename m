Return-Path: <linux-spi+bounces-8486-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4827AD774A
	for <lists+linux-spi@lfdr.de>; Thu, 12 Jun 2025 18:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57ED13B02C2
	for <lists+linux-spi@lfdr.de>; Thu, 12 Jun 2025 15:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38FDF27144B;
	Thu, 12 Jun 2025 15:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jxhV5gIa"
X-Original-To: linux-spi@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013045.outbound.protection.outlook.com [40.107.159.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A8A299A84;
	Thu, 12 Jun 2025 15:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749743514; cv=fail; b=hzZKbgg+FWB+enZF0365hINPzKJQhEtOQrgkGyxon2fIUB7vd5z+FxqHorfXJoTDByH5ur3jm8HrX0aVs3SuHYCIj2PRbTxORY5RYUzxCPc7DmlRaT27hGp0UR1VHcI82CEI2TEVVmvtUhbHddOTEYwrcg06RM3qtiv1Nmnv4Ik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749743514; c=relaxed/simple;
	bh=2jUXVufV3WIrCGykg+MjJEzViOiNCNYXGs4pQC8mz78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FnVls0ZUa0DI8EaQFoy5gKZNrCFz+1GQCTCMlOhYC/lG6tc8hHl9+X38bWWYvtOVVnZ7JPhIlPSbbUiUx1OfwXvzrfomTRtmD/hILt9YrGFSomzuSzWZbV8vJIye3Ji5dbsbw8O+IK35FkmtdwFza/Mc5wXZ2fKuLQLl4mgWTqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jxhV5gIa; arc=fail smtp.client-ip=40.107.159.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WXDZNnnu4iBzR5ZiPMq7wAhYkkqI5ulj2YBVD26gfsd7y4DRbzNfgOfNjQwSdEu3NQd8wf/MfZS724yk8ttzJc2DmaqICGxbNVjA+cYVPVOZKk1bonmxQPPce/VNXbupCR0FKLayOajtNVIM3gZ/DMOHuz8HNqwGSoX1PuWNSiBYaVDvZm7vW46PrwcOxGqwj3O67iqtJR9LEq8PP/ymFxpCs8FVDEH9CV6TKWGvJHKW3mmS0wGi7PDhNlv+uxDtf3jy2C07+PDmQTliHEkv8Jsj/WO4Sdh15sMaAuP5tEaiuxkk5LrUSGsoEZD1L5L51QUQjdC3VuyLQIhJKLpQTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7fMLUUE4MTedQpYvVdCtKyb+68fRejAK8SxVOP4ls10=;
 b=ICYXAPvz+nQm3IYESGbcl6gd8RU+8kfR8s05m7jkWOrpfXALqQsxZlUDiQSeW23eiPTk0DwLUJFacOVHio1YIUUCPjWdkGYBCGK0p5zs18rm6AzlNBVRBE0k174VbDTYj2XGRZSXDv1Gy2JXd89hlCgSiEWy0EXEIUjkLKiLr2oCjhtGqrFxLSkcOc0VlMwTVv6cJlQqgnabHfOIiOlJweQQa1LvjlNP/e23zwANUAqJnicpt2ziRnaBQVUo5YXq69renj2Y1tRD2tRfPVGcMnoIRxRL8U2+GVrNraHhB+gGEYE+nTYjqzlggCMsakuWJm/XdXvpMN2XwjprDN1m2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7fMLUUE4MTedQpYvVdCtKyb+68fRejAK8SxVOP4ls10=;
 b=jxhV5gIa6mlvvw0t3fBd/VsBP6Sb+QKC60ZvJ68u4mAASDAa1lXVIe5K+zpOYFhD+tfCBXz33qv0XrEfLCkwLUhWrQZqb8o4KrTBQ35H6H8nDXnWprVqEY52pukXurbFjAYavNL7XE95qcc7E61Oc7IJpqJ1vGBAitzmbv6o5soRSO97IkaQ8R/vcFPe/UqrKZ20xs0HKvT3Y5DleTlwIre2ekkqaVmgB9TBGQOXPMQnNAtvJapyUwJ495JLMgw91/NsgDiJiEt5YH7xIgxBDK7SwNiqQgSZSex8Frv78JWFTLm+N0sy6kSl2xDjA3MlzRnGomH0W0TVjp+gkMaS6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VI2PR04MB10811.eurprd04.prod.outlook.com (2603:10a6:800:277::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.30; Thu, 12 Jun
 2025 15:51:46 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8835.018; Thu, 12 Jun 2025
 15:51:46 +0000
Date: Thu, 12 Jun 2025 18:51:43 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: James Clark <james.clark@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Frank Li <Frank.li@nxp.com>, Vladimir Oltean <olteanv@gmail.com>,
	linux-spi@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] spi: spi-fsl-dspi: Use non-coherent memory for DMA
Message-ID: <20250612155143.bn3xw5tf7hfvr5id@skbuf>
References: <20250609-james-nxp-spi-dma-v1-2-2b831e714be2@linaro.org>
 <aEhMBsqlx9I4XqJS@lizhi-Precision-Tower-5810>
 <de7142ac-f1a3-412f-9f00-502222b20165@app.fastmail.com>
 <aEhVsrEk0qv+38r3@lizhi-Precision-Tower-5810>
 <20250611090107.t35zatn47vetnvse@skbuf>
 <c65c752a-5b60-4f30-8d51-9a903ddd55a6@linaro.org>
 <20250612111514.rfb3gpmlilznrfxs@skbuf>
 <ad7e9aa7-74a3-449d-8ed9-cb270fd5c718@linaro.org>
 <56b158fa-5fd6-4582-8ca1-296863d6d2a8@sirena.org.uk>
 <78d77dd0-2ddb-4074-8f2a-debc7bc41fe1@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78d77dd0-2ddb-4074-8f2a-debc7bc41fe1@linaro.org>
X-ClientProxiedBy: VI1PR07CA0302.eurprd07.prod.outlook.com
 (2603:10a6:800:130::30) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|VI2PR04MB10811:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b96312a-ecf7-4d02-f4e7-08dda9c90925
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/Rw5D6jPyUtzYbs4wNUvXMx2ibvDhzFrbTeBbyRltVigih5qw103UgSxpcQs?=
 =?us-ascii?Q?8gXGwsM1J2fcF54sBYDOlDsFgyXFI+cro77mmBb5h1Tz+wx/oXHdV+A/cYUf?=
 =?us-ascii?Q?NhWx83/UwESNKMsBxZ5I6Kdgm2wpGXduKHPkzMz89W/v4AZV3Xdl72Jb/fFn?=
 =?us-ascii?Q?6Ltc2BjYsSSyxlfFKMKRgB53E1io+TBo282pNB1h63SE2pP9tikz7rP6LPMb?=
 =?us-ascii?Q?bIKrqY9MQnNClTkangyLmGJbL3Xj8Jqoycw+GFFC/v62OREO6z44m2PGchjB?=
 =?us-ascii?Q?XXXW8moahdc5xiwjc4ER+BDehQFZ0wE8RjzPGRRx+mBePQ+hWbD5b6McSP9a?=
 =?us-ascii?Q?JAfQ0Q6S+tcrlXTeUg8ApclmHlNpq3RaeK0wzGEGtfjp1xi0LKjwnt7tSyBA?=
 =?us-ascii?Q?E1QcdnBbEuLoNhJJGw4o+ATkKAUm2b5XtjhRTOFPAuRqDvGA52gVMwbDInj4?=
 =?us-ascii?Q?APrxzVdoWZc/i43BLLHc3PepxjqP++wQWkENtjKbqteo4+fy6JI9J/s3d3VD?=
 =?us-ascii?Q?8tcM0DqOniPc6W0PFy3kRBBN6OyXfdQcTt9aylIku5Ei1fuXR6BCSfkC24Lz?=
 =?us-ascii?Q?gTbVqQO9foS0qJkAAc2+J1AsW7vGw48f6Fov2SeTXm1LNPBDH0JLSvvxvjel?=
 =?us-ascii?Q?/OXQn8J10gCDtBWyqacRs3lT5P/cPuHtxN5iubiKwj/pjHdjDmnlJVRF7e+1?=
 =?us-ascii?Q?xHbVjfxqEN7DGhx/H8sa5T4DAmSnhWweIDAJkiULx0KiyEWHjfWWl7xyfHPq?=
 =?us-ascii?Q?ghXIolH9SJINwcB+hQ+73w9BOxdtxM4+6R1DrjnQT3jOybIil+MN/pIWmfkf?=
 =?us-ascii?Q?aH0OJOUZfjG2yTOhfroTNxIyllE1K96qlaP7BXN+fKjOQYI2nFuRqMOim/hF?=
 =?us-ascii?Q?rWTLORsoEmQ7mE3oHH9oILEfkfAhhoJB5xXC6/SxBEPcsc2AYDZyJebSWZ4O?=
 =?us-ascii?Q?eYQr72A5nS4j5xJuweZwkoKp6W2B/tTgZuLGOakynBSBdddqXRzFz+aiP2sp?=
 =?us-ascii?Q?1A6q2IJVMqSSFNb2jormVt3LdN1kiTWIslCdO/S7R15SpDoADLMrtmBWaYeQ?=
 =?us-ascii?Q?vyNYiani43rfdMAZcg9aDlrK/lVJsFyGG9LkDDRa2mrZ42Qbed+8L3JnLvgV?=
 =?us-ascii?Q?g1fkg0locEt3Cfe9XaIb+xyZ0Kw/M3v/lnmwVe2XQWa9TTPa/DviLxnwD4Q4?=
 =?us-ascii?Q?ibf9VUvBApNxk16xI/heErmfNzNgp2hTDQXgXS5a0Z6Gl/lczYlRAdfIOsQO?=
 =?us-ascii?Q?n2NfkkJyHthomjVFeBAxRe851a2MGHNyS7EvDymsKLdeeN0xJvlucSiiJXyO?=
 =?us-ascii?Q?BJXWUuXDR5clmm36FwgkBENVs6ib/piz45O6uEu1L/hVR3iDUatGKMcXjwP3?=
 =?us-ascii?Q?fyb0iiNh3Tdy95+NXrgWjfWNridO+U254IrpzDsQqUitkKhdCIGdebcN8sBM?=
 =?us-ascii?Q?uKnF/fSKy18=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BlljWIWwl7nwRYbzcsYLVu9R0y+R+LFU9QA4EkSP5i9817Zd1Lz4Cd+n7G4W?=
 =?us-ascii?Q?QLenCUFRccFFgcegvnPLh1DITx6hSStSTyUQZsm5Wm0T0JFozeQubqDCjBo7?=
 =?us-ascii?Q?hFQKVPGiAiKA/1nBoygxfpUiP7Uhi2EW8YwizRq8uOctoXKnfenYAWMV50u1?=
 =?us-ascii?Q?yKTsffJGsFFkUrWUH1X0vnfjivN4xS/rxB/jze62lkE84W1AFrFZASHWMSo2?=
 =?us-ascii?Q?c4jdBQMRceCphDt5Pq5ms/KA9oYfpWAMbJyRuh0TkZJBDfe28g4mmcDcSbFo?=
 =?us-ascii?Q?l7obS/pPOvC4+Qrb4x12P42JZ+Nb4Yt2MeqrwPD7yQvUB0mrvYnw8Up+wJPA?=
 =?us-ascii?Q?0XF7SoT1N5MUPvtgNpWRKNY4Rpc9Iqf2Ld9Jg3ZTn9ONtAKfk4GlkfBSFqTa?=
 =?us-ascii?Q?PHcy1JevV1c5Lj5clfTmbkyyeHRz8DZMsMK9r4v0C8eYD2tz6K9YOQn659j7?=
 =?us-ascii?Q?HPilkUy8DVSLgZfdrEqwSCfJnC4fO7ec7x2QFhabxdNsV7XLlEbGwcVx0GW5?=
 =?us-ascii?Q?mvkj9ERhSmECqAyDW3DK5qmqXkA7RJiX1rC3KDjaijlnogkcCjVl+gXeAstZ?=
 =?us-ascii?Q?OUQc86kTkbER84ZgFLVbli5nXnbE3cvjwRzdDcBkjVkc9vxNLuOX18yWcdsv?=
 =?us-ascii?Q?IpFwNwx5nBjM8nOPI7cfMB1cP3XOVpLx9vyKoU5cJlXcfeX0Uc1UIOAt5eB+?=
 =?us-ascii?Q?obHDmu+aczHalwLGG5hwswyZzvSB71iPyoidObdGAPfSmG5KsXzEPe/D8cIm?=
 =?us-ascii?Q?Xq4ZNo7dYoVsAib0+8Eb+UqXxaN5/qLuLtofzRxKAgRrUupB9RwHuhLNELmh?=
 =?us-ascii?Q?WwHj6vR20e1JUeBmq9ZuzXl0J1weixhZZ2cgDmlDFmVOZXKdEaeFCbQHhmjt?=
 =?us-ascii?Q?xyiYS2gQI3QvGyYIllZww0cOrQy4v06NbajkborBrvRE314o85LYsVOofxef?=
 =?us-ascii?Q?nzWrH3kI6u2+j2UpHKD81xPp/vByfXFwpFUcwp5Frik4MHX22WTCsjev4hi7?=
 =?us-ascii?Q?bmId3cT44QFATPnX2Eqa8JxPv4/wa2emI2mfyw42o3cKFZ+HL1+xIFvlptv6?=
 =?us-ascii?Q?HBm75VGmSpp1/j3pIrKebfPwJcSgkU5s0ImBnMbqoZ0EBta963cXjQkzbQId?=
 =?us-ascii?Q?mHPQ9kMYhhkKl9aNroptNt8m9+nVEKutegK5U6qQqVM9Wr+SfqXVCIBHIuXa?=
 =?us-ascii?Q?BrLrmC4eqJSwHu5oFKAJqpDQhC/IOm8a1OdmaVSUrWnjoyu2CzQL/NWA5o74?=
 =?us-ascii?Q?bY8wC1ucEGo3YUieKAGZl/DvlC3UYbslnL6WUXftjOrZGUsFohWdrkfdUmM1?=
 =?us-ascii?Q?J33ZD6Mw1ahi2MdF+ejGBAJ+W2RFsbqT5YbTneW6wbLbd6i920A+NSd9z8Of?=
 =?us-ascii?Q?gsN6OuXVjKickzspiJX/tufkVcYXDXtzp0NpAtcbbyMOTJarthC1a0nzcuIl?=
 =?us-ascii?Q?wPnViszWGEFoOVpayN/yExFJ0uBGn8a9TeuZoZXyYiOAYfe9FYZMQZ3c7Pju?=
 =?us-ascii?Q?VMKL32ar70h3BsRWZRlgrrBHhUGk6WbjBXvIoUQ+o6tAMxtk85/fU7iMdqRG?=
 =?us-ascii?Q?i/sv7PPgZoljVw4a7SyNh9R3U88vEpDa47VOjFiALEQE5Tx5PZ9EuqMmLwQQ?=
 =?us-ascii?Q?Hg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b96312a-ecf7-4d02-f4e7-08dda9c90925
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 15:51:46.4775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ai2oShm4vJJdwwAMP4xILZIjKPr0P55JjieayfIXJuBZdfyrrwon0TMsyAuFbEPA8M6E2AHVDo/ncePtJhj5NQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10811

On Thu, Jun 12, 2025 at 04:47:26PM +0100, James Clark wrote:
> > This is a fairly normal pattern, it's a big part of why the can_dma()
> > callback is per transfer - so you can do a copybreak and use PIO for
> > smaller transfers where the overhead of setting up DMA is often more
> > than the overhead of just doing PIO.
> 
> Makes sense. Although for some reason two devices already use DMA for host
> mode and it's not that clear to me what the reason is.

I couldn't test them and I've kept them as they were.

