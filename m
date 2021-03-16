Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8BDC33E075
	for <lists+linux-spi@lfdr.de>; Tue, 16 Mar 2021 22:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbhCPVZW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 16 Mar 2021 17:25:22 -0400
Received: from bmailout1.hostsharing.net ([83.223.95.100]:47999 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbhCPVZO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 16 Mar 2021 17:25:14 -0400
X-Greylist: delayed 443 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Mar 2021 17:25:14 EDT
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id B9EFC30000CC4;
        Tue, 16 Mar 2021 22:17:44 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id AC9728AAB6; Tue, 16 Mar 2021 22:17:44 +0100 (CET)
Date:   Tue, 16 Mar 2021 22:17:44 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Alain Volmat <alain.volmat@foss.st.com>
Cc:     broonie@kernel.org, amelie.delaunay@foss.st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        fabrice.gasnier@foss.st.com, antonio.borneo@foss.st.com
Subject: Re: [PATCH] spi: stm32: drop devres version of spi_register_master
Message-ID: <20210316211744.GA25311@wunner.de>
References: <1615545286-5395-1-git-send-email-alain.volmat@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615545286-5395-1-git-send-email-alain.volmat@foss.st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Mar 12, 2021 at 11:34:46AM +0100, Alain Volmat wrote:
> --- a/drivers/spi/spi-stm32.c
> +++ b/drivers/spi/spi-stm32.c
> @@ -1960,6 +1960,7 @@ static int stm32_spi_remove(struct platform_device *pdev)
>  	struct spi_master *master = platform_get_drvdata(pdev);
>  	struct stm32_spi *spi = spi_master_get_devdata(master);
>  
> +	spi_unregister_master(master);
>  	spi->cfg->disable(spi);
>  
>  	if (master->dma_tx)

This introduces a use-after-free because spi_unregister_master()
drops the last reference on the spi_master allocation (which includes
the struct stm32_spi), causing it to be freed, yet the stm32_spi
struct is accessed afterwards.

You need to convert the driver to devm_spi_alloc_master() to
fix the use-after-free.  See commit 6cfd39e212de for an example.

Thanks,

Lukas
