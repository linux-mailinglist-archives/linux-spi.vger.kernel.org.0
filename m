Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2179346DB6
	for <lists+linux-spi@lfdr.de>; Wed, 24 Mar 2021 00:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbhCWXIK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 23 Mar 2021 19:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhCWXHt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 23 Mar 2021 19:07:49 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C460C061574;
        Tue, 23 Mar 2021 16:07:49 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 4A03B22260;
        Wed, 24 Mar 2021 00:07:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1616540866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C8nXM32KMkKRWhGgs0N1HKDFZiCWuwPI3z2aCDDXFbk=;
        b=oALP9ZD3prSS6SGNrjoUUBoDtku9bM8urrR9UjVpLpWMvYdYzQlrQxw+rpSp18OjIZHxiD
        Hc3kdGvzwuhcgZPwbr6iSiFFO3vm1ggyge8oePN6iR+odWSc0ZPJ3YeXzVvmd26GfhJlsp
        QnMuE/U8E6c8gkN1dT5vk7EA9evzk0Q=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 24 Mar 2021 00:07:46 +0100
From:   Michael Walle <michael@walle.cc>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-spi@vger.kernel.org, Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [RFC PATCH 1/6] spi: spi-mem: Tell controller when device is
 ready for calibration
In-Reply-To: <20210311191216.7363-2-p.yadav@ti.com>
References: <20210311191216.7363-1-p.yadav@ti.com>
 <20210311191216.7363-2-p.yadav@ti.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <934c8c6f7bb71729bfdaefd39c63a262@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Pratyush,

Am 2021-03-11 20:12, schrieb Pratyush Yadav:
> Some controllers like the Cadence OSPI controller need to perform a
> calibration sequence to operate at high clock speeds. This calibration
> should happen after the flash is fully initialized otherwise the
> calibration might happen in a different SPI mode from the one the flash
> is finally set to. Add a hook that can be used to tell the controller
> when the flash is ready for calibration. Whether calibration is needed
> depends on the controller.
> 
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> ---
>  drivers/spi/spi-mem.c       | 12 ++++++++++++
>  include/linux/spi/spi-mem.h |  8 ++++++++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
> index dc713b0c3c4d..e2f05ad3f4dc 100644
> --- a/drivers/spi/spi-mem.c
> +++ b/drivers/spi/spi-mem.c
> @@ -464,6 +464,18 @@ int spi_mem_adjust_op_size(struct spi_mem *mem,
> struct spi_mem_op *op)
>  }
>  EXPORT_SYMBOL_GPL(spi_mem_adjust_op_size);
> 
> +int spi_mem_do_calibration(struct spi_mem *mem, struct spi_mem_op *op)
> +{
> +	struct spi_controller *ctlr = mem->spi->controller;
> +
> +	if (!ctlr->mem_ops || !ctlr->mem_ops->do_calibration)
> +		return -EOPNOTSUPP;
> +
> +	ctlr->mem_ops->do_calibration(mem, op);

Can't a calibration fail?

> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(spi_mem_do_calibration);
> +
>  static ssize_t spi_mem_no_dirmap_read(struct spi_mem_dirmap_desc 
> *desc,
>  				      u64 offs, size_t len, void *buf)
>  {
> diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
> index 2b65c9edc34e..97a2d280f2d0 100644
> --- a/include/linux/spi/spi-mem.h
> +++ b/include/linux/spi/spi-mem.h
> @@ -250,6 +250,12 @@ static inline void *spi_mem_get_drvdata(struct
> spi_mem *mem)
>   *		  the currently mapped area), and the caller of
>   *		  spi_mem_dirmap_write() is responsible for calling it again in
>   *		  this case.
> + * @do_calibration: perform calibration needed for high SPI clock 
> speed
> + *		    operation. Should be called after the SPI memory device has
> + *		    been completely initialized. The op passed should contain
> + *		    a template for the read operation used for the device so
> + *		    the controller can decide what type of calibration is
> + *		    required for this type of read.
>   *
>   * This interface should be implemented by SPI controllers providing 
> an
>   * high-level interface to execute SPI memory operation, which is 
> usually the
> @@ -274,6 +280,7 @@ struct spi_controller_mem_ops {
>  			       u64 offs, size_t len, void *buf);
>  	ssize_t (*dirmap_write)(struct spi_mem_dirmap_desc *desc,
>  				u64 offs, size_t len, const void *buf);
> +	void (*do_calibration)(struct spi_mem *mem, struct spi_mem_op *op);
>  };
> 
>  /**
> @@ -346,6 +353,7 @@ bool spi_mem_dtr_supports_op(struct spi_mem *mem,
>  #endif /* CONFIG_SPI_MEM */
> 
>  int spi_mem_adjust_op_size(struct spi_mem *mem, struct spi_mem_op 
> *op);
> +int spi_mem_do_calibration(struct spi_mem *mem, struct spi_mem_op 
> *op);
> 
>  bool spi_mem_supports_op(struct spi_mem *mem,
>  			 const struct spi_mem_op *op);

-- 
-michael
