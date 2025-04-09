Return-Path: <linux-spi+bounces-7498-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88540A834C9
	for <lists+linux-spi@lfdr.de>; Thu, 10 Apr 2025 01:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE81C8A85B6
	for <lists+linux-spi@lfdr.de>; Wed,  9 Apr 2025 23:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B241B87F3;
	Wed,  9 Apr 2025 23:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="JAt9x5Cs"
X-Original-To: linux-spi@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010012.outbound.protection.outlook.com [52.101.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9C71F94A;
	Wed,  9 Apr 2025 23:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744242342; cv=fail; b=GpUb0Q883gwRNY1lIruWD7KIk6uzJKiYSLf2YgG9NATscWh9S1rTD266ZXI7tg6vsqVuXUrr3fpNdzlSR5HadNO69QMz/zVMSZbIVrFIMbpVzdEDOuGZOGWG78elvPxM1iBN8E1zViehCJo8zEsPWOOkArq0b765T4Q2cnCTk18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744242342; c=relaxed/simple;
	bh=Qq8kg4rSWks0qDp4Vfx7VU4NTpFjRoAkmYFr35HqtuM=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=ovSUSjWrG9+r+U16l1JsnHOrDYGrilQGljGj4orci2gUF2k772dfYErmsR7PJpeHrP65bpNHpwPBMc1CSUC7I6OC94XQpCtAXOYsfoWt87j69WD3hUtLWU2nZJ8Ca0lZGTDzpihkQUQGOFH5bcnxqBrpPYtswrqpzGZpGVDh0Qw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=JAt9x5Cs; arc=fail smtp.client-ip=52.101.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QEaslmhbJmM5JNBOBzZhqWzPQpNT/lQHOsA0r+o9K4nAa5m3fiOd6UBOqCAaq0Zacutpkkd3c3KREt0J8G6pecf2UT2M1aFEqEdV43i2ImF4M+eOj8z2GBmX9ts/j1JkvOKItaSJSvWb0QSoCdzEu9Wu77jn/aKTr6EUWYiY2Nkxaa9onaXWqzKbs9A67Sr71p1+JXjvsTHbVeopX3eXArAR03sjDNn08cyfMz2Hb7mNSaXxzseTmZvHaieyOyEGV+rMffAUOIYjV0H1SDkGLPLftORg6801N5qsrx8U5iA1HstD0aRB18bN9iv/ZlEclXMecbscXW+sB7gi93P0Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/HVTRqXDP/nkXjC+JUBf97gF66CewHDec5LtmRMnjJI=;
 b=Rpl+X4OJKSHSPvJhTJAUB5rMMEUUKTxbu7caUdSdBJ+y5GBpFLe4R/t3Km+zBSQY4BWzouRYwLTVM1QwWPuB8CbAWiCnKSJ1XWB/UE8fnCqv9gx2CUVEk98l65IbY/gmJzppJs/UbcF5ywpG7VwJqxIrXHRrHWcmvrwHCpkvMeut3nET2LxfiGr77BuZC6pUGCsUQR03IrOAQq5BFhT4NjZASj25kTmR0mfjJjhybKbHaUYMkabUdcSTjbgAws4MEGcGKUE59SAmF/5E1BEPKGZwBjMAhR8luEGbntbmB+aBgidrZLPh/weYZpEO9X/Stz6wKvRPydV8xKzW3WTfGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/HVTRqXDP/nkXjC+JUBf97gF66CewHDec5LtmRMnjJI=;
 b=JAt9x5CscFWxqd99rNBUh+PIBEGDTJPQIJ2JYQxUL7puneUJAxL2iNwr5zAuOfmDEgt+8TKK2fOTzbD+jpbnzNYxp9y+vrCM3lfvofWlg8hMzlkdiqxVmZ8aD17RXRhyWbf7W+xKL9o305/PxbUZxTxXyHHACwpql02UGHXQ6x0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by OSCPR01MB14454.jpnprd01.prod.outlook.com
 (2603:1096:604:3a6::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Wed, 9 Apr
 2025 23:45:32 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%5]) with mapi id 15.20.8606.033; Wed, 9 Apr 2025
 23:45:32 +0000
Message-ID: <8734egnbl0.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Conor Dooley <conor+dt@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Takashi Iwai <tiwai@suse.com>,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: Re: [PATCH 6/7] ASoC: renesas: add MSIOF sound support
In-Reply-To: <CAMuHMdWL_C-Vg3d+fAK_nXvzeZNNPDkkzPjB1oHRKHh16rZUHw@mail.gmail.com>
References: <875xjeb0wu.wl-kuninori.morimoto.gx@renesas.com>
	<87wmbu9may.wl-kuninori.morimoto.gx@renesas.com>
	<CAMuHMdWL_C-Vg3d+fAK_nXvzeZNNPDkkzPjB1oHRKHh16rZUHw@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date: Wed, 9 Apr 2025 23:45:32 +0000
X-ClientProxiedBy: TYCPR01CA0206.jpnprd01.prod.outlook.com
 (2603:1096:405:7a::17) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|OSCPR01MB14454:EE_
X-MS-Office365-Filtering-Correlation-Id: 34660c50-1b7d-4540-d028-08dd77c09dcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fAGDd/Fo6+kGhIZtBmXK2yy4t+41NhBnIR7NdDHPb+YngkXyN9HkUCwk3fTK?=
 =?us-ascii?Q?MeCMUc1AaCUOPxEeJUQn5Pkj6EI350IdQhTAJX0eumaePPsYBHStk5nrcW+q?=
 =?us-ascii?Q?oQdECGOw2QZ4AWGqfhPH9lBAV+tSHE0Lwa80HkznhnMUoyqxQPoPgfDWrn4b?=
 =?us-ascii?Q?L6c14JaDl+TU1M2SW4JDl9PIxvpNBAyNSPVi9xEQ3FvQ6giGBBPW2S2fxPZq?=
 =?us-ascii?Q?QeyTE+8udY6S9Mr/9jFDuCYjY/FUIZ73F2+ZO0R28fxY3dmUuF2BRCRhC/4G?=
 =?us-ascii?Q?3uOw/O6eYLqLOcb3DrrUhsITBJ1EN9JtdfGrZ+RJfE+c95VVjpFbeqwD7Fj+?=
 =?us-ascii?Q?R8J/T4CimMT77G28p6gUA2u9Qlf2BlR28gjOkqEdNeJdAWBPgR8TidJuVT69?=
 =?us-ascii?Q?2kZslOKHAHHrfpOZ1Ty+Gm8TsPJlwepoFuLPtPegYuK+Ua+UqGD7VcmAeC2+?=
 =?us-ascii?Q?kgti2t9O8B4oetU4X7uAq8yQLqRhGPssZ67Rd75gjaBKliz/ouCGbvlG4VH9?=
 =?us-ascii?Q?ebiiSh4Cvidd0yYE86EMXCwDoE5AT4opi5kaINjNegiFwAHTQcf1eK312K0A?=
 =?us-ascii?Q?Jip/OSD7VUlS4A0BlB/4HhD5EJnePjrhNt4YjRJG84N4s87NvbHe9y4Uy/1g?=
 =?us-ascii?Q?lZXFXnvW9mQ9MnHFnF8GGLfv/atmB77ivqPhdmF5kM5V4f+2fl/aUtV7g42B?=
 =?us-ascii?Q?ACD9dBFyEpgivYY6YjQcxbcmdkZAEeU0kV6/gZVyVry/m1Fd71k5Lbj2DW48?=
 =?us-ascii?Q?5/hbyQnq1x3jobNOMSdH4aXLP24BO57m2YxaFBJVAHUeCOp0kuXl8tiSipT3?=
 =?us-ascii?Q?/kyW07Q+JMsikHu7Dqr3O6IzNKVsPiWxDbV6xdKSFoBDb+Q9qChDUjr2Htaf?=
 =?us-ascii?Q?ClOp+LL3wxGj/NKY6L6JQ8dzVUDaVBdXx/Q822ai7F7ov5oUguIm4MrNLnz+?=
 =?us-ascii?Q?RodE167RvPtPzqei+TEwnStL63pmZwlpaWqISKZEFDLwya0uumpfxnxohnTa?=
 =?us-ascii?Q?MxtTGHjgOW5K/XKWWi+0Yh5yohL9oIP9NUHRCX0EdWDs7Il4f8D/OGC3MAH4?=
 =?us-ascii?Q?FmBE2Khjwqo4GGOp6l7/gGBtKEYn+sMGZWWsjpjGHzoEntBY5wUdnRkW9F/q?=
 =?us-ascii?Q?FhIqlcM5stuVJbw5G0RVSbtQnzMUwUdy/JMBSqXgkvfT6L1EWGNHOzA87xh/?=
 =?us-ascii?Q?g1SJDnPCrdQ20iEjh80zU1v053gOegzp90i5cwShEE7yVnNwIUACBM63MiPk?=
 =?us-ascii?Q?7JSUsGDd8n2OfHOczoNdyPhEUn6CYCZs+UC5kB+CFta6nq4cl6XfCt+BCruZ?=
 =?us-ascii?Q?xcSf0pQX7mMakOOl0lAnfW5aC2h6zln/ZMxymM3gKRYvUYx5V/foEJvGyZgz?=
 =?us-ascii?Q?FqIJV6OoMt9E8MkzHbLsWHJDUN0XVuV83fAd8zAe+wjqzQajaI7OI46camOI?=
 =?us-ascii?Q?foQI7/ICYSK0shQytbWlGPU/+Ut3WXJnYAp/BynWnF2Eg2Oa/eWD+g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+33lJ73H/r0oJWaUpyT8m03o0/zj1+Ho9M2cDMXFpjO81sq5pgwMQcHdtlbO?=
 =?us-ascii?Q?cPDDuSGQZmpzzgg3u+kBiwdS9IbzLILC3aXZvTkMLBl6rgCp6gexxpSOSTP5?=
 =?us-ascii?Q?Pjyz5zhQD9LFBPFxHZTgoioUFVaZY4N+QI6V2NdM7FJYyed65Zt1Eb04fHrg?=
 =?us-ascii?Q?vHsKlSsasz5SYg6BJ6kvgb3/Qh/Mx33ygtCAw5gF+RAjkRV96mlWg2RkqsBy?=
 =?us-ascii?Q?0VkYQcSQWM7HB4Qut/0wGWOIAItttbK8a7eb6boUbdI7a4xv6r0veMMxBeAO?=
 =?us-ascii?Q?L+rzKQGUSIvGxumkBj0Mxufd9Uk3H9QFHwZusp5HiJ/dOnr2NSXlXLiTdL/+?=
 =?us-ascii?Q?CGx4uZ8r6c8Iaz1OXIYJ6fd8GK//q7+sSXOE1tYnjaugsJHi2om0U8bzPp0o?=
 =?us-ascii?Q?DbgnvOQx1olSYBgJwbOSJMTbMUX9dfe/Vg2kxDoDTCZTTSGsgLNbnlqfvrxI?=
 =?us-ascii?Q?K8TSWPazu34GzVctTQUhLZXoi7z2NnlT8bBGjY8aBxZ4nB/o/1/1tCfNT0wP?=
 =?us-ascii?Q?vbxVkCQLLnKoNQlN/PdcLYcGqnhucKoMwYPEWhA+a698pSQsrXR0K41cghQ5?=
 =?us-ascii?Q?0q4YX4Iu08rM7342iR1DkYNo76+mRSh+FMN47miu9sqvX13p0FFz3qcE3F29?=
 =?us-ascii?Q?Uf6TAgINBMr5kT87F36hQvCb4RnXYCZy2tL6ZxDqMcGxU0HosHoSASxLP/zd?=
 =?us-ascii?Q?WxRksQury+mbymthWYlsVXJRQnimlKCwO7liVpqkJ8Ro0/iabEmnu5drXvDr?=
 =?us-ascii?Q?hfNFf7LybkFonvHVHNBdWGZtchdeshEOGaHMYhcqOt7iJUbdhyZgzQrQ6Q8C?=
 =?us-ascii?Q?mDenmCrlyBKTC7LRlfyhhfS4mwB3QZTjcKQ7VvavB6TJkIKUrwLfmuZ4b/0T?=
 =?us-ascii?Q?M9DtRKhiktTaNZ1rR7BuWjnl2z+s6r+RwXwjEpkNIfB0TlXFJpncPNjO5tmr?=
 =?us-ascii?Q?qJ5ioet8oKF5HQi0HnLgoIp6MDvnFohFlXjM+VMMvlaCQQwAXwhxOXsBQvKL?=
 =?us-ascii?Q?KCqCmb2NyI2SQjbligUxcj2J0c9G9NbWlnCdlea4jUnn7shRKnRhQjO/+D7p?=
 =?us-ascii?Q?Ar+koHOD4TrDOUGjeR2A4y8+3gnq7/P/lW8uH0NH5qYc3dwfmigjLpmMplHj?=
 =?us-ascii?Q?qi3rbVrsWPTK7n2UyVJRiZTY20nDO5Y2XzIMM4HQuL5RfPQ4wSv1U2CEGeer?=
 =?us-ascii?Q?6GAR9W5T2Zc4enTerbd29p2S9kNUf9YJql6IWDENaxEksANdjq8Mqt0gKmgc?=
 =?us-ascii?Q?WbwK85lExcgD13PiaQxFw2d3qUXelns1P5jd/5gAp/ZNu0HvcAG65fW+//jy?=
 =?us-ascii?Q?obFIg14BDJa143cjO0ZMeb18tTKaNoR+MAB3OcaEj21hVmCHNvv+oB/AVu1v?=
 =?us-ascii?Q?ONmWvJuc7vOYoHCXHuO3d6SHcoxwKs4cZAOIQJRiDWF4D03/9ROcpmi8j1Su?=
 =?us-ascii?Q?osnC4+u8zuHrhNdrP5034Pjdhf+CiuJ5UGffEsrfOmOkzRRGzn/JD25AHD7e?=
 =?us-ascii?Q?b8y4m6WNsFKzXFucFMJ23yyK25HrQGrLVcs0BlA1oAmOhlq/ozlvaYi5UTuw?=
 =?us-ascii?Q?050qOKSuKNUFrKcfmz0TYCgMrvDf6sc5vZsMnvrvGFGrbT4tpGAlQ8EMCb9j?=
 =?us-ascii?Q?bYzJ4DxdzxfUPagYRx9SHqU=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34660c50-1b7d-4540-d028-08dd77c09dcf
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 23:45:32.2808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LrZzEx8k5efbXww8iMqJR2ZSgyf8q3xTZHjl+6Cas038SDCRvPUYf633UBzxTX4few/rCBY/z7l+ftGPQtwUsVO8wScLj1wtkIePBQEBRMbiBpcPblr5LS0IOZktbBIY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB14454


Hi Geert

Thank you for your review

> > +config SND_SOC_MSIOF
> > +       tristate "R-Car series MSIOF support"
> > +       depends on OF
> 
> depends on ARCH_RENESAS || COMPILE_TEST

Ah, yes indeed. Will add in v2

> Perhaps the register definitions can be shared with spi-sh-msiof.c,
> by extracting them into a shared header file?
> 
> Note that I have already converted drivers/spi/spi-sh-msiof.c locally
> to use FIELD_PREP() (which requires changes to some macros), so we
> may want to implement the sharing later.

Yes 100% I can agree about this !
I'm happy to sharing it, but it will be next step

> > +       /* SITMDRx */
> > +       if (is_play) {
> > +               val = PCON | SYNCMD_LR | SYNCAC | TXSTP;
> > +               if (msiof_flag_has(priv, MSIOF_FLAGS_NEED_DELAY))
> > +                       val |= DTDL_1;
> > +
> > +               msiof_write(priv, SITMDR1, val);
> > +
> > +               val = BITLEN1(width);
> > +               msiof_write(priv, SITMDR2, val | GRP);
> > +               msiof_write(priv, SITMDR3, val);
> > +
> 
> Don't you have to initialize SITMDR[123] unconditionally, as reception
> requires transmitting dummy data on R-Car (cfr. SPI_CONTROLLER_MUST_TX)?

Good catch, but I added 1 restriction for MSIOF-I2S mode.
I have explained it on top of this driver. The restriction is
"MSIOF-I2S doesn't work as Clock/Frame Provider Mode".
So, dummy transmit for RX is not needed/assumed.
I think it is one of big-diff between MSIOF-SPI ?

/*
 * [NOTE]
 *
 * This driver doesn't support Clock/Frame Provider Mode
 *
 * Basically MSIOF is created for SPI, but we can use it as I2S (Sound). Because of it, when we use
 * it as I2S (Sound) with Provider Mode, we need to send dummy TX data even though it is used for
 * RX. Because SPI HW needs TX Clock/Frame output for RX purpose also. It makes driver code complex.
 *
 * And when we use MSIOF (Sound) as Provider Mode, the clock source is [MSO clock] (= 133.33MHz)
 * SoC internal clock. It is not for 48kHz/44.1kHz base clock. Thus the output/input will not be
 * accurate sound.
 */

> > +static int msiof_probe(struct platform_device *pdev)
> > +{
> > +       struct msiof_priv *priv;
> > +       struct device *dev = &pdev->dev;
> > +       struct resource *res;
> > +       struct device_node *port;
> > +       int irq, ret;
> > +
> > +       /* Check MSIOF as Sound mode or SPI mode */
> > +       port = of_graph_get_next_port(dev->of_node, NULL);
> > +       if (!port)
> > +               return -ENODEV;
> > +       of_node_put(port);
> 
> Just wondering: don't you need to use port? Or is that handled
> elsewhere, in common sound code?

"ports/port" will be handled by "Sound Card" driver
(= Audio Graph Card/Card2), not MSIOF driver.

Thank you for your help !!

Best regards
---
Kuninori Morimoto

