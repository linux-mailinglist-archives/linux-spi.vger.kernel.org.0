Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C274E483EAD
	for <lists+linux-spi@lfdr.de>; Tue,  4 Jan 2022 10:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiADJCi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 4 Jan 2022 04:02:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiADJCh (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 4 Jan 2022 04:02:37 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215CDC061761
        for <linux-spi@vger.kernel.org>; Tue,  4 Jan 2022 01:02:36 -0800 (PST)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 543CF1F42CDE;
        Tue,  4 Jan 2022 09:02:34 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641286954;
        bh=EjiF8JgzQOmIC33Yr7BZyniqqcCirXbHs/l6SFY7XGo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ku5qmKYa/6QHQmB+iMoW92b5cMwjVzeo4qC1EYXYWBRPstW3keRmsE9PQJNVLf4w+
         Jas2+42Wal0jdisrhFDjUZSUTj9nmtHRHDTZ2jlsxmKaw4Xr/nsXB+jrTGmq/EYyP4
         l8LjElwAvcXKP7cG4GmXEoCq8AdKQ2A387wD4+2Xzdqw9z1wZofJeSG/nBQ+Ptofgt
         70hpPMUWk1ABtaO+qt+kxzk01hDPAFY4GORE7tFRSh9ThXdgb9xEPi0ge3UzoZobKF
         DUFME8v9yJc7TxUKLvG//wrz+0zDsPnCgxE+sOgqlccxxo9LLGYbdeHTGuOLDlLIZ/
         CGoOcKwsj2RjQ==
Date:   Tue, 4 Jan 2022 10:02:30 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>, Mark Brown <broonie@kernel.org>,
        <linux-spi@vger.kernel.org>, Julien Su <juliensu@mxic.com.tw>,
        Jaime Liao <jaimeliao@mxic.com.tw>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Xiangsheng Hou <xiangsheng.hou@mediatek.com>
Subject: Re: [PATCH v9 06/13] spi: spi-mem: Add an ecc parameter to the
 spi_mem_op structure
Message-ID: <20220104100230.1076beed@collabora.com>
In-Reply-To: <20220104083631.40776-7-miquel.raynal@bootlin.com>
References: <20220104083631.40776-1-miquel.raynal@bootlin.com>
        <20220104083631.40776-7-miquel.raynal@bootlin.com>
Organization: Collabora
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue,  4 Jan 2022 09:36:24 +0100
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Soon the SPI-NAND core will need a way to request a SPI controller to
> enable ECC support for a given operation. This is because of the
> pipelined integration of certain ECC engines, which are directly managed
> by the SPI controller itself.
> 
> Introduce a spi_mem_op additional field for this purpose: ecc.
> 
> So far this field is left unset and checked to be false by all
> the SPI controller drivers in their ->supports_op() hook, as they all
> call spi_mem_default_supports_op().
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Acked-by: Pratyush Yadav <p.yadav@ti.com>
> ---
>  drivers/spi/spi-mem.c       | 5 +++++
>  include/linux/spi/spi-mem.h | 5 +++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
> index ed966d8129eb..f38ac31961c9 100644
> --- a/drivers/spi/spi-mem.c
> +++ b/drivers/spi/spi-mem.c
> @@ -178,6 +178,11 @@ bool spi_mem_default_supports_op(struct spi_mem *mem,
>  			return false;
>  	}
>  
> +	if (op->data.ecc) {
> +		if (!spi_mem_controller_is_capable(ctlr, ecc))
> +			return false;
> +	}

Nit:

	if (op->data.ecc &&
	    !spi_mem_controller_is_capable(ctlr, ecc))
		return false;

> +
>  	return spi_mem_check_buswidth(mem, op);
>  }
>  EXPORT_SYMBOL_GPL(spi_mem_default_supports_op);
> diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
> index 4a1bfe689872..051050b40309 100644
> --- a/include/linux/spi/spi-mem.h
> +++ b/include/linux/spi/spi-mem.h
> @@ -89,6 +89,7 @@ enum spi_mem_data_dir {
>   * @dummy.dtr: whether the dummy bytes should be sent in DTR mode or not
>   * @data.buswidth: number of IO lanes used to send/receive the data
>   * @data.dtr: whether the data should be sent in DTR mode or not
> + * @data.ecc: whether error correction is required or not
>   * @data.dir: direction of the transfer
>   * @data.nbytes: number of data bytes to send/receive. Can be zero if the
>   *		 operation does not involve transferring data
> @@ -119,6 +120,7 @@ struct spi_mem_op {
>  	struct {
>  		u8 buswidth;
>  		u8 dtr : 1;
> +		u8 ecc : 1;
>  		enum spi_mem_data_dir dir;
>  		unsigned int nbytes;
>  		union {
> @@ -126,6 +128,7 @@ struct spi_mem_op {
>  			const void *out;
>  		} buf;
>  	} data;
> +
>  };
>  
>  #define SPI_MEM_OP(__cmd, __addr, __dummy, __data)		\
> @@ -288,9 +291,11 @@ struct spi_controller_mem_ops {
>  /**
>   * struct spi_controller_mem_caps - SPI memory controller capabilities
>   * @dtr: Supports DTR operations
> + * @ecc: Supports operations with error correction
>   */
>  struct spi_controller_mem_caps {
>  	bool dtr;
> +	bool ecc;
>  };
>  
>  #define spi_mem_controller_is_capable(ctlr, cap)	\

