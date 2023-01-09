Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32DD6662CDD
	for <lists+linux-spi@lfdr.de>; Mon,  9 Jan 2023 18:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237257AbjAIRfY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Jan 2023 12:35:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237255AbjAIRfI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 Jan 2023 12:35:08 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4CA1BC81;
        Mon,  9 Jan 2023 09:34:25 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id bf43so14136665lfb.6;
        Mon, 09 Jan 2023 09:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j/a6jdGAfZ7pIbpWGVVuD5gf5IZMu1/POVTFRtaxPG4=;
        b=Oy6QPTM/AN37YaK3JtPCP+jDRO6F3KE1MNe0/loFI9GTyhHyTOURvDzFK84eQO9FfO
         mrPkSb2aulFnStIU6P0kwOlHSrbOEPsoOsGnJxxTopwjJ4SYIBLTGz2dQ2A74HGC7T4K
         0oUphA7mZLoEk/apZofHVmQJfj+RQFgAXbYL/TphA2D90x8FjuB8WQVQ4ORsb8PhDrkc
         +dZ03A79ZQZjXbaSLpv7BF1+lFt2M/nPzjNncG2rAMfsvxNDmrBQLjx8ZInqQJ8sccFI
         kvMZsa5Mb/lYyfo3jv0wbegpqbbdwD5pS5yLTz5psIkWbW0AxUqrlleblFY+UD4fGE24
         eA6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j/a6jdGAfZ7pIbpWGVVuD5gf5IZMu1/POVTFRtaxPG4=;
        b=S/gTjjmo00EQahd1FWTKuQjQuxznl8TIhg3txhpODIN79OqjVjZ7I24ttUEorekNzz
         l/3rR9ma0Hs+iAcJD0a+35tG2NNB4Lg5mWnQL8zCaR9vwiLOyiYTz/n5kF4Ry6iODsIX
         lsfXC+crO+NkmuLvrYGdLc3z7PkR6++rz0HBWvTbuKKlYhPd4sw/1auAf+RrkOkljwi5
         FeBVeN89QJXC0h2m1sFkUxj1qdIjkmpkpdjrXig5GwFVy0Vy5UyNIYkgJr/A0493wYFo
         iirNGMw2hWW4SJejKgB2Y4iekg4c9cfqNJ2CAtm6T7ug9eRCX+kYZQ3VKpZ8pqYcMHPE
         cmow==
X-Gm-Message-State: AFqh2korgEz/ZAfQqtKucLNSqVMO2z+2P4x+aOkPxvZaXYx+84x5yFGa
        2eabj3jWLniHtO9Yu5XHcaE=
X-Google-Smtp-Source: AMrXdXtzdUVLC+bmCVsj5cHC/kijG5r3W/HBMl7bo413BmHfubxeOR9AHmOCBKV91spZxJG6XrCHlw==
X-Received: by 2002:a05:6512:2526:b0:4a4:68b9:66e1 with SMTP id be38-20020a056512252600b004a468b966e1mr16101198lfb.44.1673285659808;
        Mon, 09 Jan 2023 09:34:19 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id s11-20020a056512314b00b004b592043413sm1719984lfi.12.2023.01.09.09.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 09:34:18 -0800 (PST)
Date:   Mon, 9 Jan 2023 20:34:16 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Sudip Mukherjee <sudip.mukherjee@sifive.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        jude.onyenegecha@sifive.com, ben.dooks@sifive.com,
        jeegar.lakhani@sifive.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/15] spi: dw: add check for support of enhanced spi
Message-ID: <20230109173416.zzphzen7vnzsttsu@mobilestation>
References: <20221212180732.79167-1-sudip.mukherjee@sifive.com>
 <20221212180732.79167-5-sudip.mukherjee@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221212180732.79167-5-sudip.mukherjee@sifive.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Dec 12, 2022 at 06:07:21PM +0000, Sudip Mukherjee wrote:
> Before doing the mem op, spi controller will be queried about the
> buswidths it supports. Add the dual/quad/octal if the controller
> has the DW_SPI_CAP_EMODE capability.
> The DW_SPI_CAP_EMODE capability will be enabled in a later patch.
> 
> Signed-off-by: Sudip Mukherjee <sudip.mukherjee@sifive.com>
> ---
>  drivers/spi/spi-dw-core.c | 25 ++++++++++++++++++++++++-
>  drivers/spi/spi-dw.h      |  1 +
>  2 files changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
> index d59401f16c47a..49fad58ceb94a 100644
> --- a/drivers/spi/spi-dw-core.c
> +++ b/drivers/spi/spi-dw-core.c
> @@ -510,6 +510,26 @@ static int dw_spi_adjust_mem_op_size(struct spi_mem *mem, struct spi_mem_op *op)
>  	return 0;
>  }
>  
> +static bool dw_spi_supports_enh_mem_op(struct spi_mem *mem,
> +				       const struct spi_mem_op *op)
> +{
> +	if (op->addr.nbytes != 0 && op->addr.buswidth != 1 &&
> +	    op->addr.buswidth != op->data.buswidth)
> +		return false;
> +
> +	if (op->cmd.buswidth != 1 && op->cmd.buswidth != op->addr.buswidth &&
> +	    op->cmd.buswidth != op->data.buswidth)
> +		return false;
> +
> +	if (op->dummy.nbytes != 0 && op->data.dir == SPI_MEM_DATA_OUT)
> +		return false;
> +
> +	if (op->dummy.nbytes != 0 && op->dummy.nbytes / op->dummy.buswidth > 4)
> +		return false;
> +
> +	return spi_mem_default_supports_op(mem, op);
> +}
> +
>  static bool dw_spi_supports_mem_op(struct spi_mem *mem,
>  				   const struct spi_mem_op *op)
>  {
> @@ -792,7 +812,10 @@ static void dw_spi_init_mem_ops(struct dw_spi *dws)

>  	if (!dws->mem_ops.exec_op && !(dws->caps & DW_SPI_CAP_CS_OVERRIDE) &&
>  	    !dws->set_cs) {
>  		dws->mem_ops.adjust_op_size = dw_spi_adjust_mem_op_size;
> -		dws->mem_ops.supports_op = dw_spi_supports_mem_op;

Please see my comment to the cover letter. In order to have a more
readable method I'd suggest to convert it to something like this:

< dw_spi_init_mem_ops() {
< 	if (dws->mem_ops.exec_op || dws->caps & DW_SPI_CAP_CS_OVERRIDE ||
< 	    dws->set_cs)
<		return;
<
< 	if (dws->caps & DW_SPI_CAP_ENH_CLK_STR) {
< 		dws->mem_ops.adjust_op_size = dw_spi_enh_adjust_mem_op;
< 		dws->mem_ops.supports_op = dw_spi_enh_supports_mem_op;
< 		dws->mem_ops.exec_op = dw_spi_enh_exec_mem_op;
< 
<		return;
< 	}
<
<  	dws->mem_ops.adjust_op_size = dw_spi_adjust_mem_op_size;
< 	dws->mem_ops.supports_op = dw_spi_supports_mem_op;
< 	dws->mem_ops.exec_op = dw_spi_exec_mem_op;
<
<	return;
< }

> +		if (dws->caps & DW_SPI_CAP_EMODE)

Your implementation is working only if the clock-stretching feature is
available.

> +			dws->mem_ops.supports_op = dw_spi_supports_enh_mem_op;
> +		else
> +			dws->mem_ops.supports_op = dw_spi_supports_mem_op;
>  		dws->mem_ops.exec_op = dw_spi_exec_mem_op;
>  		if (!dws->max_mem_freq)
>  			dws->max_mem_freq = dws->max_freq;
> diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
> index f29d89d05f34b..327d037bdb10e 100644
> --- a/drivers/spi/spi-dw.h
> +++ b/drivers/spi/spi-dw.h
> @@ -34,6 +34,7 @@
>  /* DW SPI controller capabilities */
>  #define DW_SPI_CAP_CS_OVERRIDE		BIT(0)
>  #define DW_SPI_CAP_DFS32		BIT(1)

> +#define DW_SPI_CAP_EMODE		BIT(2)

As I suggested in the cover letter let's make it DW_SPI_CAP_ENH (any
better suggestion?). Then the clock-stretching capability flag will be
DW_SPI_CAP_ENH_CLK_STR.

-Serge(y)

>  
>  /* Register offsets (Generic for both DWC APB SSI and DWC SSI IP-cores) */
>  #define DW_SPI_CTRLR0			0x00
> -- 
> 2.30.2
> 
