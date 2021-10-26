Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 740C843B4A9
	for <lists+linux-spi@lfdr.de>; Tue, 26 Oct 2021 16:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236056AbhJZOt2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 26 Oct 2021 10:49:28 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:53314
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235809AbhJZOtZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 26 Oct 2021 10:49:25 -0400
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id BCB523F197
        for <linux-spi@vger.kernel.org>; Tue, 26 Oct 2021 14:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1635259620;
        bh=sGvC/moOvdyUz5BgWBNn++QElNeJtVEkhjy6Xzwoit8=;
        h=To:Cc:References:From:Subject:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=tTEpThVMckOVdRCkGaKZtaK0DpoNm35vn70zkEvJDH8465UsbXo9aIsnVjzfHf5W9
         RJayEMiSDIkw8Io8SK2iWJVkZSjFikgjYaQU9V/5JzbsPZNnDWHw6jiZeNKAIDk9+P
         S96ZkRv4lDiXgKggZ8MI4dsQzim0u0AeUw4HZCEIj0ooaxmjE2HHUvXnTWzYO42zES
         LgT2Riy+kkSd82DjnT/E9X7aba+YP/ixC61rGNErMaWXHOnNmk7tNRc55XSDkcaTTh
         N+yUA6nVMyeTY6AGdrOFJtKLKM2Y/e+vsnD1TszBDqz/NqRp9W5CtbtTQoPi9pVqar
         RV0qnFj5JEl2Q==
Received: by mail-lf1-f72.google.com with SMTP id x17-20020a0565123f9100b003ff593b7c65so6269518lfa.12
        for <linux-spi@vger.kernel.org>; Tue, 26 Oct 2021 07:47:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sGvC/moOvdyUz5BgWBNn++QElNeJtVEkhjy6Xzwoit8=;
        b=qJiDMAQubJbtKbYD9JnsumCJIhxXlT02ZESwEiTeLHvz889lpEd9gDffDFIAQr2bk+
         14p5FSwdFhVFnYT02/PaY1kwOLbPqcWJ07QbpKlMMpclQABGjSXNoJwV9A2FmliOW9aM
         38sQNdV4X6corl/vVNHE17pbkE2FxKQU0PLXbItFKHYwiiUNsjOVU8Kq0adH6+hni1PO
         OiGsk88OaEDaaKj3/Ee/MOIqYzQ1J/8NJPWtYskDTs8CWaA30I+0KifR1Ss+UieIVYKU
         a0EYnpIlt/1CNLIf1hzYp8ersm+JkppXOzndg7z3I90CFQWvpchG9O2noh9dcNpvmwqX
         38PQ==
X-Gm-Message-State: AOAM532P8xZ30rKWKfPmsjc1woiaJaRNDC2DnCF7lxuNzYSyOktqrRTy
        GiP2qPEgdEqduJiW2OngjZt7p67vAiDkLSRYXLhL4QChQlI5axaJcb6jDFRklBmUwBeFAuQkHtT
        ALkJ3td1dShnDLZxs51Q0Jr6wYeP+aLUj3Uwtjg==
X-Received: by 2002:a2e:9a44:: with SMTP id k4mr27138535ljj.149.1635259620088;
        Tue, 26 Oct 2021 07:47:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzId5LC3CECZNRGA5TXwzhpCrfWJ3jxLerU06SuBsMlTmuewBOjpfWson2aDsP9+nWnmzeFEA==
X-Received: by 2002:a2e:9a44:: with SMTP id k4mr27138506ljj.149.1635259619839;
        Tue, 26 Oct 2021 07:46:59 -0700 (PDT)
Received: from [192.168.3.161] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id u1sm1369162lfs.21.2021.10.26.07.46.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Oct 2021 07:46:59 -0700 (PDT)
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Mark Brown <broonie@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
References: <20211025205631.21151-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211025205631.21151-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH v2 7/7] memory: renesas-rpc-if: Add support for RZ/G2L
Message-ID: <3739744b-0a10-6d6b-8d1c-9c82b6afe0b3@canonical.com>
Date:   Tue, 26 Oct 2021 16:46:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211025205631.21151-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 25/10/2021 22:56, Lad Prabhakar wrote:
> SPI Multi I/O Bus Controller on RZ/G2L SoC is almost identical to
> the RPC-IF interface found on R-Car Gen3 SoC's.
> 
> This patch adds a new compatible string for the RZ/G2L family so
> that the timing values on RZ/G2L can be adjusted.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v1->v2:
>  * Updated macros as suggested by Wolfram
> ---
>  drivers/memory/renesas-rpc-if.c | 72 ++++++++++++++++++++++++++++-----
>  drivers/mtd/hyperbus/rpc-if.c   |  4 +-
>  drivers/spi/spi-rpc-if.c        |  4 +-
>  include/memory/renesas-rpc-if.h |  8 +++-
>  4 files changed, 75 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/memory/renesas-rpc-if.c b/drivers/memory/renesas-rpc-if.c
> index 0c56decc91f2..8c51145c0f5c 100644
> --- a/drivers/memory/renesas-rpc-if.c
> +++ b/drivers/memory/renesas-rpc-if.c
> @@ -12,6 +12,7 @@
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/of.h>
> +#include <linux/of_device.h>
>  #include <linux/regmap.h>
>  #include <linux/reset.h>
>  
> @@ -27,8 +28,8 @@
>  #define RPCIF_CMNCR_MOIIO_HIZ	(RPCIF_CMNCR_MOIIO0(3) | \
>  				 RPCIF_CMNCR_MOIIO1(3) | \
>  				 RPCIF_CMNCR_MOIIO2(3) | RPCIF_CMNCR_MOIIO3(3))
> -#define RPCIF_CMNCR_IO3FV(val)	(((val) & 0x3) << 14) /* undocumented */
> -#define RPCIF_CMNCR_IO2FV(val)	(((val) & 0x3) << 12) /* undocumented */
> +#define RPCIF_CMNCR_IO3FV(val)	(((val) & 0x3) << 14) /* documented for RZ/G2L */
> +#define RPCIF_CMNCR_IO2FV(val)	(((val) & 0x3) << 12) /* documented for RZ/G2L */
>  #define RPCIF_CMNCR_IO0FV(val)	(((val) & 0x3) << 8)
>  #define RPCIF_CMNCR_IOFV_HIZ	(RPCIF_CMNCR_IO0FV(3) | RPCIF_CMNCR_IO2FV(3) | \
>  				 RPCIF_CMNCR_IO3FV(3))
> @@ -126,6 +127,9 @@
>  #define RPCIF_SMDRENR_OPDRE	BIT(4)
>  #define RPCIF_SMDRENR_SPIDRE	BIT(0)
>  
> +#define RPCIF_PHYADD		0x0070	/* R/W available on R-Car E3/D3/V3M and RZ/G2{E,L} */
> +#define RPCIF_PHYWR		0x0074	/* R/W available on R-Car E3/D3/V3M and RZ/G2{E,L} */
> +
>  #define RPCIF_PHYCNT		0x007C	/* R/W */
>  #define RPCIF_PHYCNT_CAL	BIT(31)
>  #define RPCIF_PHYCNT_OCTA(v)	(((v) & 0x3) << 22)
> @@ -133,10 +137,12 @@
>  #define RPCIF_PHYCNT_OCT	BIT(20)
>  #define RPCIF_PHYCNT_DDRCAL	BIT(19)
>  #define RPCIF_PHYCNT_HS		BIT(18)
> -#define RPCIF_PHYCNT_STRTIM(v)	(((v) & 0x7) << 15)
> +#define RPCIF_PHYCNT_CKSEL(v)	(((v) & 0x3) << 16) /* valid only for RZ/G2L */
> +#define RPCIF_PHYCNT_STRTIM(v)	(((v) & 0x7) << 15) /* valid for R-Car and RZ/G2{E,H,M,N} */
>  #define RPCIF_PHYCNT_WBUF2	BIT(4)
>  #define RPCIF_PHYCNT_WBUF	BIT(2)
>  #define RPCIF_PHYCNT_PHYMEM(v)	(((v) & 0x3) << 0)
> +#define RPCIF_PHYCNT_PHYMEM_MASK GENMASK(1, 0)
>  
>  #define RPCIF_PHYOFFSET1	0x0080	/* R/W */
>  #define RPCIF_PHYOFFSET1_DDRTMG(v) (((v) & 0x3) << 28)
> @@ -244,18 +250,46 @@ int rpcif_sw_init(struct rpcif *rpc, struct device *dev)
>  		return PTR_ERR(rpc->dirmap);
>  	rpc->size = resource_size(res);
>  
> +	rpc->type = (enum rpcif_type)of_device_get_match_data(dev);
>  	rpc->rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
>  
>  	return PTR_ERR_OR_ZERO(rpc->rstc);
>  }
>  EXPORT_SYMBOL(rpcif_sw_init);
>  
> -void rpcif_hw_init(struct rpcif *rpc, bool hyperflash)
> +static void rpcif_rzg2l_timing_adjust_sdr(struct rpcif *rpc)
> +{
> +	u32 data;
> +
> +	regmap_write(rpc->regmap, RPCIF_PHYWR, 0xa5390000);
> +	regmap_write(rpc->regmap, RPCIF_PHYADD, 0x80000000);
> +	regmap_write(rpc->regmap, RPCIF_PHYWR, 0x00008080);
> +	regmap_write(rpc->regmap, RPCIF_PHYADD, 0x80000022);
> +	regmap_write(rpc->regmap, RPCIF_PHYWR, 0x00008080);
> +	regmap_write(rpc->regmap, RPCIF_PHYADD, 0x80000024);
> +
> +	regmap_read(rpc->regmap, RPCIF_PHYCNT, &data);
> +	regmap_write(rpc->regmap, RPCIF_PHYCNT, data | RPCIF_PHYCNT_CKSEL(3));
> +	regmap_write(rpc->regmap, RPCIF_PHYWR, 0x00000030);
> +	regmap_write(rpc->regmap, RPCIF_PHYADD, 0x80000032);
> +}
> +
> +int rpcif_hw_init(struct rpcif *rpc, bool hyperflash)
>  {
>  	u32 dummy;
>  
>  	pm_runtime_get_sync(rpc->dev);
>  
> +	if (rpc->type == RPCIF_RZ_G2L) {
> +		int ret;
> +
> +		ret = reset_control_reset(rpc->rstc);
> +		if (ret)
> +			return ret;
> +		usleep_range(200, 300);
> +		rpcif_rzg2l_timing_adjust_sdr(rpc);
> +	}
> +
>  	/*
>  	 * NOTE: The 0x260 are undocumented bits, but they must be set.
>  	 *	 RPCIF_PHYCNT_STRTIM is strobe timing adjustment bits,
> @@ -264,8 +298,15 @@ void rpcif_hw_init(struct rpcif *rpc, bool hyperflash)
>  	 *	 On H3 ES1.x, the value should be 0, while on others,
>  	 *	 the value should be 7.
>  	 */
> -	regmap_write(rpc->regmap, RPCIF_PHYCNT, RPCIF_PHYCNT_STRTIM(7) |
> -		     RPCIF_PHYCNT_PHYMEM(hyperflash ? 3 : 0) | 0x260);
> +	if (rpc->type == RPCIF_RCAR_GEN3) {
> +		regmap_write(rpc->regmap, RPCIF_PHYCNT, RPCIF_PHYCNT_STRTIM(7) |
> +			     RPCIF_PHYCNT_PHYMEM(hyperflash ? 3 : 0) | 0x260);
> +	} else {
> +		regmap_read(rpc->regmap, RPCIF_PHYCNT, &dummy);
> +		dummy &= ~RPCIF_PHYCNT_PHYMEM_MASK;
> +		dummy |= RPCIF_PHYCNT_PHYMEM(hyperflash ? 3 : 0) | 0x260;
> +		regmap_write(rpc->regmap, RPCIF_PHYCNT, dummy);
> +	}
>  
>  	/*
>  	 * NOTE: The 0x1511144 are undocumented bits, but they must be set
> @@ -282,9 +323,17 @@ void rpcif_hw_init(struct rpcif *rpc, bool hyperflash)
>  		regmap_update_bits(rpc->regmap, RPCIF_PHYINT,
>  				   RPCIF_PHYINT_WPVAL, 0);
>  
> -	regmap_write(rpc->regmap, RPCIF_CMNCR, RPCIF_CMNCR_SFDE |
> -		     RPCIF_CMNCR_MOIIO_HIZ | RPCIF_CMNCR_IOFV_HIZ |
> -		     RPCIF_CMNCR_BSZ(hyperflash ? 1 : 0));
> +	if (rpc->type == RPCIF_RCAR_GEN3)
> +		regmap_write(rpc->regmap, RPCIF_CMNCR, RPCIF_CMNCR_SFDE |
> +			     RPCIF_CMNCR_MOIIO_HIZ | RPCIF_CMNCR_IOFV_HIZ |
> +			     RPCIF_CMNCR_BSZ(hyperflash ? 1 : 0));
> +	else
> +		regmap_write(rpc->regmap, RPCIF_CMNCR, RPCIF_CMNCR_SFDE |
> +			     RPCIF_CMNCR_MOIIO3(1) | RPCIF_CMNCR_MOIIO2(1) |
> +			     RPCIF_CMNCR_MOIIO1(1) | RPCIF_CMNCR_MOIIO0(1) |
> +			     RPCIF_CMNCR_IO3FV(2) | RPCIF_CMNCR_IO2FV(2) |
> +			     RPCIF_CMNCR_IO0FV(2) | RPCIF_CMNCR_BSZ(hyperflash ? 1 : 0));
> +
>  	/* Set RCF after BSZ update */
>  	regmap_write(rpc->regmap, RPCIF_DRCR, RPCIF_DRCR_RCF);
>  	/* Dummy read according to spec */
> @@ -295,6 +344,8 @@ void rpcif_hw_init(struct rpcif *rpc, bool hyperflash)
>  	pm_runtime_put(rpc->dev);
>  
>  	rpc->bus_size = hyperflash ? 2 : 1;
> +
> +	return 0;
>  }
>  EXPORT_SYMBOL(rpcif_hw_init);
>  
> @@ -657,7 +708,8 @@ static int rpcif_remove(struct platform_device *pdev)
>  }
>  
>  static const struct of_device_id rpcif_of_match[] = {
> -	{ .compatible = "renesas,rcar-gen3-rpc-if", },
> +	{ .compatible = "renesas,rcar-gen3-rpc-if", .data = (void *)RPCIF_RCAR_GEN3 },
> +	{ .compatible = "renesas,rzg2l-rpc-if", .data = (void *)RPCIF_RZ_G2L },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, rpcif_of_match);
> diff --git a/drivers/mtd/hyperbus/rpc-if.c b/drivers/mtd/hyperbus/rpc-if.c
> index 367b0d72bf62..40bca89268c3 100644
> --- a/drivers/mtd/hyperbus/rpc-if.c
> +++ b/drivers/mtd/hyperbus/rpc-if.c
> @@ -132,7 +132,9 @@ static int rpcif_hb_probe(struct platform_device *pdev)
>  
>  	rpcif_enable_rpm(&hyperbus->rpc);
>  
> -	rpcif_hw_init(&hyperbus->rpc, true);
> +	error = rpcif_hw_init(&hyperbus->rpc, true);
> +	if (error)
> +		return error;
>  

Not related to this patch, but the concept used here looks fragile. The
child driver calls also rpcif_sw_init() and ignores the error code. What
happens in case of rpcif_sw_init() failure or child probe deferral?
Since the SW and HW init is called in context of child device, the
parent won't do anything. Then, second bind of child device (manual or
because of deferral) will fail on devm_reset_control_get_exclusive()
with -EBUSY.

Initializing parent's resources should be rather done from parent's
context (so renesas-rpc-if.c) to handle properly deferred probe and
other failures. Doing it from a child, breaks encapsulation and
separation of devices.

Is there any reason why memory/renesas-rpc-if.c cannot do SW and HW init?

Best regards,
Krzysztof
