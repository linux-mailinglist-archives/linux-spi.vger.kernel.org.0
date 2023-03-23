Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3116C5C61
	for <lists+linux-spi@lfdr.de>; Thu, 23 Mar 2023 02:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjCWBw7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 22 Mar 2023 21:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjCWBw6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 22 Mar 2023 21:52:58 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2062.outbound.protection.outlook.com [40.107.247.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554FE30C2
        for <linux-spi@vger.kernel.org>; Wed, 22 Mar 2023 18:52:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AZLvlV7lXD3AWa5c3h7qCyFIXocTwF6iaVu1owwjOtdTqkn73nbAPXhkE1zNfYQc3K3kZFL4qz3JCEJJ29AuiHYfAluoIcGPiS+wWW0Irqr+U5XhFrWyoQatleY72DiIjOl/CjYHkWcFDgybq8AxYLJYthAlS38F3mOfsk+BArL0E8lizvkS4HxOuzQ2aLT047xvgAxooU5vW1FMTeX2nEUO1IXdnU/wEnOKUeT66z1rCsew08eVIk9dh1UJwnNOIS6CNbEXt+q9WTwQPaWFR+M7WdY2pSOat7/XRVWgSRMdMN1v1rs9kmRvMIMk7x2NNswTNRIEU0XwFYUrL6Z4bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G1TmuFcktKvX+ljUoVKZXerZuLXpHlU4BcEnRtMUPN4=;
 b=EJh1SkKJTd1foxSpugd6DmVoJ2WDDGkwTJOR+44B5mf1z59X+aebLKA/nahbio4vhZYB68HLaEqjG5F6jNlcrnS754tlysrz+DeawF3tKWGp4cIrcpGgX6mWg1tAdHYWKGDxo+OBzSBkOZ7Tr/r3p7yEZ/+5grNCa56tFomceq/wbAos0FYVjqOjn27U0Ps+y8UPJYWGSw/EgJcT3dx443QeAmrY0+1PHWY0TEqAG3wwsSf3VnVB2MdRWtak3pZPvYMkNwKwK2DCpZZL7vgvM78FHo2aMvoORxNMG3HS9aPpMbB/BMjUUZp13ylGU1CLZ7QqRZcdNNeHVJBjPaiqSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G1TmuFcktKvX+ljUoVKZXerZuLXpHlU4BcEnRtMUPN4=;
 b=HoKQVKJeDe5PPkm+nDfbRDwe3FUvEK/AEOho8k8HErb6KuDsawmU0jD1KWQfRtMOaI8lC7HRxpzZZU5iUrLVO+sQAhDsoVE+0Vo9FcVLZBfigyo0VDChCQPmgCnB46/FBYD1KGOFvCt86UOCRCj3XgI3tlf0HewXSI+YEdHBcBg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9071.eurprd04.prod.outlook.com (2603:10a6:150:22::11)
 by VI1PR04MB9980.eurprd04.prod.outlook.com (2603:10a6:800:1d0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 01:52:54 +0000
Received: from GV1PR04MB9071.eurprd04.prod.outlook.com
 ([fe80::2606:1eb4:ec83:8787]) by GV1PR04MB9071.eurprd04.prod.outlook.com
 ([fe80::2606:1eb4:ec83:8787%3]) with mapi id 15.20.6178.038; Thu, 23 Mar 2023
 01:52:54 +0000
Date:   Wed, 22 Mar 2023 20:52:44 -0500
From:   "han.xu" <han.xu@nxp.com>
To:     haibo.chen@nxp.com
Cc:     broonie@kernel.org, linux-spi@vger.kernel.org,
        yogeshgaur.83@gmail.com, linux-imx@nxp.com
Subject: Re: [PATCH 2/2] spi: spi-nxp-fspi: use DLL calibration when clock
 rate > 100MHz
Message-ID: <20230323015244.f6lnnoiwmdx6mj7s@umbrella>
References: <20230322090451.3179431-1-haibo.chen@nxp.com>
 <20230322090451.3179431-2-haibo.chen@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322090451.3179431-2-haibo.chen@nxp.com>
X-ClientProxiedBy: SJ0PR03CA0167.namprd03.prod.outlook.com
 (2603:10b6:a03:338::22) To GV1PR04MB9071.eurprd04.prod.outlook.com
 (2603:10a6:150:22::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9071:EE_|VI1PR04MB9980:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a2926f0-c433-4a80-cabe-08db2b415104
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wb/gnqNosX+vnY0UUcjN7pH6a46elzltqHVUEV70QbfOyfJrkCknhy+2X60ShfrbkEtlRuN21K6rPfefZDKJbUNQY/LMtECDyjMa4FGBTmQTAgbyPrzYCZCny/lqpk2ljphEQdMHSetsSNRW/fxyBV3TZnb3Nodf42eMdiPanQwbsEFVDvFXBeBCceRxZiuoiIRgyxbeWKXElEt5UrSDC9UpB35lkeck4hAwmDFXvGvGz4qqg1LP+vtgi6eBbpkobM++8/hPvkji8rbw7UEsHuUWYM+7XUJc7w2YuT0h/khuKBStdVtNg5yBLLANNWK+yNwS4WQ5qPjGH2u0Lt0KF+Qu4KJjk03ECXRIZTsx2RIo8LSl+FDBbRa80ltyJz2kO5J96nXZ/+zp9wBF7Vj/NpWRbmeHzwMfUN2M4Fvsg7xIh4SEnL5sm38RATrBMR7pAHWp/e3RJEGn5uNdPGODgfHdKhNUgwUbMlJ33+Zw76naS8fDVJVJmgWYqZlUJSrhOYsAvBtuvk/c8JzOCq/xekpO9DeH2KxD6kiQl9u3KcKxPOP8PX4hZqb0Vozz1VdjdGd5X5x66HiSPoO93Vzs0lRa6EtQpkYX+jXl81NBFi1BlHARHk/A8PFQMz21DRB4DYA2i2bIRr3fZXjppPD9WTDQ+tqwnV8CqVLvJHtaqhUtsTjkSKV0huy/UxGUTghhAEn4Eem9NfB/kZdVhDb7WA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9071.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(4636009)(396003)(39860400002)(366004)(346002)(376002)(136003)(451199018)(26005)(1076003)(6512007)(6506007)(186003)(6666004)(83380400001)(86362001)(33716001)(38100700002)(38350700002)(9686003)(8936002)(66556008)(8676002)(66946007)(66476007)(4326008)(34206002)(478600001)(5660300002)(316002)(41300700001)(6636002)(2906002)(6486002)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N5msO8nVrttwEzrXlTIXiZPaHJ8HQaV7DnaYwIlPgFZ+CAMIzpPJ2pwZB34C?=
 =?us-ascii?Q?fI4yz5+DmEt5rfGz61Hix4bCRGqAj8uOnrqBkqoe63wyQ5qWyxTyurv7xyZD?=
 =?us-ascii?Q?ACctoTSkqfFiUnf6aSFeAebe+4aTIPCHk0Be1Vq2wFMshrKXmezGCx3Zmeyx?=
 =?us-ascii?Q?djb5isxSaDinn5PV9pFKZgXKGhGtabUQ7IFdckl1qjdbge1xhevILc6z1z4K?=
 =?us-ascii?Q?GgRMHw7g5uljAcDDvkUbYWycXLo8o6xMVyCgpzZ56fLQ7igSco98oRIZej35?=
 =?us-ascii?Q?/0v+IyM7dhJFR2P6ww596qE0hsyaQqcYdsi3zPC5XyI/W3jZe9OM6xM+8STZ?=
 =?us-ascii?Q?ItQDwtPmkML29l1pLZSVeCXx0LuJKwANTcXOQLJ7c7Z/qbE2jNvlEOXNMc/f?=
 =?us-ascii?Q?zM0a7h8VhUvNd29z1GRpdYvaB41pNDiPHYTvE4A2VBnELBYUQbWQC+HM+cuN?=
 =?us-ascii?Q?XFW8aGFswnv2BIuAhTDuHpVWMK8XT8qlkdLIPyp0jT3tEkeJDBalg/JncjEr?=
 =?us-ascii?Q?WSRNTtJVU8ORYjx54nO8umi0fWRIOs+VxwKP93pu7/YG8Qc0G4wVxhqfjgDR?=
 =?us-ascii?Q?C0wD3JhEBz3IPXuEKfJO+lZRD02KBj+L6kDa8reVUg65URVimz2xAYZd5aSs?=
 =?us-ascii?Q?6M9KnkHLwNo/S0OpNp+cFTa+9Hmp1wWVyfsYty9rTEHB6knKDj9f8NR5xgW4?=
 =?us-ascii?Q?XIIcc4bZdVLS3RpCsKVnKJBnvLn0G7Ku1Hork9jz9xrQQt94/rIjNauKRTvn?=
 =?us-ascii?Q?lx/yImTeynn9re+d7ft9j7YezopbhFc9Dmfe9frcXYiJssJXJnakM5GWG2n/?=
 =?us-ascii?Q?5AcF6mOYp6xlEK2E3WlMSM8A2i+KSizGcFpUL/9QwlweTPw8xn1ce1eDtXpZ?=
 =?us-ascii?Q?nr1g9gQYKfZiI4DyPmVaAln6MdMWHhQJQkahwoDx0DHRTIA/8a9ttSqSiln2?=
 =?us-ascii?Q?Lf8YPCXRhJQKJBmgnvwuLHcWN+gkF7o0SYwbYsEgxeQVv+q3EaCkrLto2Q1b?=
 =?us-ascii?Q?0e668lF7XSQOGbwotzaBMkaxPE41S8QnTGvhuXq4J5Ai3OTqDjuERG5thSIj?=
 =?us-ascii?Q?j/Nte/j2K77T8hAoV+KMLCWvSW4WUUZMaLD1T+ovaUlrOtC2GSyMJpNt55p1?=
 =?us-ascii?Q?e7+G4/5iB5NXTQd5Av3wUnfMKDtfCzp7ZbC1uQ5QYauEDT6yTh7pxJsrgUC1?=
 =?us-ascii?Q?6VFihVzegYYO18z/niBI4+Y7fCgKs16vr4wzIwbtz2NsKd1tNtaTAWfLHVpR?=
 =?us-ascii?Q?rF4OG66l8shHllgnKfHv703caGCf85NsnWJOG07ot2OcZTxlyyx6N2WpP2/y?=
 =?us-ascii?Q?xJH7xXDGNtNxESSf4hynkGNQl10khfFltACNpkbGzI55lsSlQllgH/gVg77w?=
 =?us-ascii?Q?bHQqYZ0+pR+PcPIV2DeewRuedRSaOsibcJL+In2i3sveiDTCYXs1ZUSrRLcv?=
 =?us-ascii?Q?X4Bt+83kFe0xJwUxxyiVNqiLwrwPBU/vgCBQbb0Y3vd8mTFQofGXoctta6iL?=
 =?us-ascii?Q?4Lop2rOJPZmuVIoo0uVnFrdpnhGXW7ncj3Kar4NBu0/VGM/m65kEf7Elsd59?=
 =?us-ascii?Q?+508EVTUx4LOjiLAL5FJsHo3/KiwFQBAcqcsGMHs?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a2926f0-c433-4a80-cabe-08db2b415104
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9071.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 01:52:53.8943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q+KIPqwVPnI5xwPQoaaaVWOUro6HA9xFDAUva7rElwxiMQywKUTsg1yf2XAAeFR1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9980
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 23/03/22 05:04PM, haibo.chen@nxp.com wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
> 
> When clock rate > 100MHz, use the DLL calibration mode, and finally
> add the suggested half of the current clock cycle to sample the data.
> 
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

Reviewed-by: Han Xu <han.xu@nxp.com>
Tested-by: Han Xu <han.xu@nxp.com>

> ---
>  drivers/spi/spi-nxp-fspi.c | 52 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
> 
> diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
> index 6735c22b9137..544017655787 100644
> --- a/drivers/spi/spi-nxp-fspi.c
> +++ b/drivers/spi/spi-nxp-fspi.c
> @@ -214,9 +214,15 @@
>  
>  #define FSPI_DLLACR			0xC0
>  #define FSPI_DLLACR_OVRDEN		BIT(8)
> +#define FSPI_DLLACR_SLVDLY(x)		((x) << 3)
> +#define FSPI_DLLACR_DLLRESET		BIT(1)
> +#define FSPI_DLLACR_DLLEN		BIT(0)
>  
>  #define FSPI_DLLBCR			0xC4
>  #define FSPI_DLLBCR_OVRDEN		BIT(8)
> +#define FSPI_DLLBCR_SLVDLY(x)		((x) << 3)
> +#define FSPI_DLLBCR_DLLRESET		BIT(1)
> +#define FSPI_DLLBCR_DLLEN		BIT(0)
>  
>  #define FSPI_STS0			0xE0
>  #define FSPI_STS0_DLPHB(x)		((x) << 8)
> @@ -231,6 +237,16 @@
>  #define FSPI_STS1_AHB_ERRCD(x)		((x) << 8)
>  #define FSPI_STS1_AHB_ERRID(x)		(x)
>  
> +#define FSPI_STS2			0xE8
> +#define FSPI_STS2_BREFLOCK		BIT(17)
> +#define FSPI_STS2_BSLVLOCK		BIT(16)
> +#define FSPI_STS2_AREFLOCK		BIT(1)
> +#define FSPI_STS2_ASLVLOCK		BIT(0)
> +#define FSPI_STS2_AB_LOCK		(FSPI_STS2_BREFLOCK | \
> +					 FSPI_STS2_BSLVLOCK | \
> +					 FSPI_STS2_AREFLOCK | \
> +					 FSPI_STS2_ASLVLOCK)
> +
>  #define FSPI_AHBSPNST			0xEC
>  #define FSPI_AHBSPNST_DATLFT(x)		((x) << 16)
>  #define FSPI_AHBSPNST_BUFID(x)		((x) << 1)
> @@ -615,6 +631,35 @@ static int nxp_fspi_clk_disable_unprep(struct nxp_fspi *f)
>  	return 0;
>  }
>  
> +static void nxp_fspi_dll_calibration(struct nxp_fspi *f)
> +{
> +	int ret;
> +
> +	/* Reset the DLL, set the DLLRESET to 1 and then set to 0 */
> +	fspi_writel(f, FSPI_DLLACR_DLLRESET, f->iobase + FSPI_DLLACR);
> +	fspi_writel(f, FSPI_DLLBCR_DLLRESET, f->iobase + FSPI_DLLBCR);
> +	fspi_writel(f, 0, f->iobase + FSPI_DLLACR);
> +	fspi_writel(f, 0, f->iobase + FSPI_DLLBCR);
> +
> +	/*
> +	 * Enable the DLL calibration mode.
> +	 * The delay target for slave delay line is:
> +	 *   ((SLVDLYTARGET+1) * 1/32 * clock cycle of reference clock.
> +	 * When clock rate > 100MHz, recommend SLVDLYTARGET is 0xF, which
> +	 * means half of clock cycle of reference clock.
> +	 */
> +	fspi_writel(f, FSPI_DLLACR_DLLEN | FSPI_DLLACR_SLVDLY(0xF),
> +		    f->iobase + FSPI_DLLACR);
> +	fspi_writel(f, FSPI_DLLBCR_DLLEN | FSPI_DLLBCR_SLVDLY(0xF),
> +		    f->iobase + FSPI_DLLBCR);
> +
> +	/* Wait to get REF/SLV lock */
> +	ret = fspi_readl_poll_tout(f, f->iobase + FSPI_STS2, FSPI_STS2_AB_LOCK,
> +				   0, POLL_TOUT, true);
> +	if (ret)
> +		dev_warn(f->dev, "DLL lock failed, please fix it!\n");
> +}
> +
>  /*
>   * In FlexSPI controller, flash access is based on value of FSPI_FLSHXXCR0
>   * register and start base address of the slave device.
> @@ -690,6 +735,13 @@ static void nxp_fspi_select_mem(struct nxp_fspi *f, struct spi_device *spi)
>  	if (ret)
>  		return;
>  
> +	/*
> +	 * If clock rate > 100MHz, then switch from DLL override mode to
> +	 * DLL calibration mode.
> +	 */
> +	if (rate > 100000000)
> +		nxp_fspi_dll_calibration(f);
> +
>  	f->selected = spi_get_chipselect(spi, 0);
>  }
>  
> -- 
> 2.34.1
> 
