Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE0D5175B1
	for <lists+linux-spi@lfdr.de>; Mon,  2 May 2022 19:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236884AbiEBR0n (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 2 May 2022 13:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235761AbiEBR0n (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 2 May 2022 13:26:43 -0400
Received: from mail.tkos.co.il (hours.tkos.co.il [84.110.109.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2130326E0
        for <linux-spi@vger.kernel.org>; Mon,  2 May 2022 10:23:13 -0700 (PDT)
Received: from tarshish (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.tkos.co.il (Postfix) with ESMTPS id 06D9B440E72;
        Mon,  2 May 2022 20:22:19 +0300 (IDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
        s=default; t=1651512139;
        bh=mGwPiPXKKppVi1nI6QcaKFWRLYZZxZGXxY5xHskzekE=;
        h=References:From:To:Cc:Subject:Date:In-reply-to:From;
        b=VdCLzRFg9eqLekgEE9aMDQWbVHMc04jUX/by3DPRrRjhB1pqZjs2l7yfOHx1ekN2R
         JIfyxMET6AEG1QQeGfy97emM2YGhXWxQLlqImQ4XvVcBmfDX0NVXuElwwwhA9SiER6
         hj4c5hlONJRUlmoYl0+EBuc85OCh7hTJaFRIWsTZrhBoRmfH34i/vSq/FLSoF+YCVr
         AusMZIeoLpv2c+I/W01gR0bkyLFSx93+aGL1TQrnZ1nMNMHguR1jy4XmFmJbt88OmD
         VM0nTg/S0bwcx+jxK+fYGrEpX2DMevyUhYlkPKrmNLYNMUhnf98i2WCSHs+pfnQsg/
         iC/nv+FJ4LCvQ==
References: <20220502165210.1956397-1-mkl@pengutronix.de>
 <20220502165210.1956397-8-mkl@pengutronix.de>
User-agent: mu4e 1.6.10; emacs 27.1
From:   Baruch Siach <baruch@tkos.co.il>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-spi@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        Marek Vasut <marex@denx.de>, kernel@pengutronix.de,
        linux-imx@nxp.com, Mark Brown <broonie@kernel.org>,
        David Jander <david@protonic.nl>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC 7/9] spi: spi-imx: replace struct spi_imx_data::bitbang by
 pointer to struct spi_controller
Date:   Mon, 02 May 2022 20:14:28 +0300
In-reply-to: <20220502165210.1956397-8-mkl@pengutronix.de>
Message-ID: <87a6bzyhky.fsf@tarshish>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Marc,

On Mon, May 02 2022, Marc Kleine-Budde wrote:

> There's no need to embed the struct spi_bitbang into our private
> data (struct spi_imx_data), the spi core is flexible enough, so that
> we only need a pointer to the allocated struct spi_controller.
>
> This is also a preparation patch to add PIO based polling support to
> the driver.
>
> Co-developed-by: David Jander <david@protonic.nl>
> Signed-off-by: David Jander <david@protonic.nl>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

[...]

> @@ -1641,17 +1642,17 @@ static int spi_imx_probe(struct platform_device *pdev)
>  	else
>  		controller->num_chipselect = 3;
>  
> -	spi_imx->bitbang.setup_transfer = spi_imx_setupxfer;
> -	spi_imx->bitbang.txrx_bufs = spi_imx_transfer;
> -	spi_imx->bitbang.master->setup = spi_imx_setup;
> -	spi_imx->bitbang.master->cleanup = spi_imx_cleanup;
> -	spi_imx->bitbang.master->prepare_message = spi_imx_prepare_message;
> -	spi_imx->bitbang.master->unprepare_message = spi_imx_unprepare_message;
> -	spi_imx->bitbang.master->slave_abort = spi_imx_slave_abort;
> -	spi_imx->bitbang.master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_NO_CS;
> +	spi_imx->controller->transfer_one = spi_imx_transfer_one;
> +	spi_imx->controller->setup = spi_imx_setup;
> +	spi_imx->controller->cleanup = spi_imx_cleanup;
> +	spi_imx->controller->prepare_message = spi_imx_prepare_message;
> +	spi_imx->controller->unprepare_message = spi_imx_unprepare_message;
> +	spi_imx->controller->slave_abort = spi_imx_slave_abort;
> +	spi_imx->controller->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_NO_CS;
> +
>  	if (is_imx35_cspi(spi_imx) || is_imx51_ecspi(spi_imx) ||
>  	    is_imx53_ecspi(spi_imx))
> -		spi_imx->bitbang.master->mode_bits |= SPI_LOOP | SPI_READY;
> +		spi_imx->controller->mode_bits |= SPI_LOOP | SPI_READY;
>  
>  	if (is_imx51_ecspi(spi_imx) &&
>  	    device_property_read_u32(&pdev->dev, "cs-gpios", NULL))

This hunk conflicts with commit 79422ed9bd7f ("spi: spi-imx: add support
for SPI_RX_CPHA_FLIP") in Mark's for-5.19 branch. That commit also adds
another reference to bitbang.master.

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
