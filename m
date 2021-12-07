Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 355B646B7D9
	for <lists+linux-spi@lfdr.de>; Tue,  7 Dec 2021 10:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234306AbhLGJuD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 7 Dec 2021 04:50:03 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60324 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234291AbhLGJuC (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 7 Dec 2021 04:50:02 -0500
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id EF4191F443CB;
        Tue,  7 Dec 2021 09:46:30 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1638870391; bh=gFarT2bn0dBlXD9xDafM6ZB+hovPkSFhEjfxaGGqIQ4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PDAHjih2IAuQNziUOIoXbNjowaV5khrAUR7yqCgTOdT8gqayoIZ4TzMqjOzgKy06r
         WcwI4uewzDXOJfs3SUmFcqdPE4zJZA3WCmzm+At+7Oon5SCpGiejfuFr4yxZkM66s+
         /kFF2HgQjTjZTYSa/CS0eM6f0g9vF7Lv429Xd0i6Zhr1k0G/IxImI6Xw19n4QiDu2g
         HCRVXIq0BCvsNTRxCHs2jeOFpwesAQnh7D7vQ4v4aEjEfhkVqbH0tEcpuX8qjBj8U4
         GqVPD3iGGDeRRZK+kPWw/HAja/JVGv9tvhA3oIu6jh5JJU1j0ftu3my7OTUSfgVv4r
         2kb8eNkZ+XASw==
Date:   Tue, 7 Dec 2021 10:46:27 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>, Mark Brown <broonie@kernel.org>,
        <linux-spi@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Xiangsheng Hou <Xiangsheng.Hou@mediatek.com>,
        Julien Su <juliensu@mxic.com.tw>,
        Jaime Liao <jaimeliao@mxic.com.tw>
Subject: Re: [PATCH v3 17/22] mtd: spinand: Create direct mapping
 descriptors for ECC operations
Message-ID: <20211207104627.7bbad94d@collabora.com>
In-Reply-To: <20211207093422.166934-18-miquel.raynal@bootlin.com>
References: <20211207093422.166934-1-miquel.raynal@bootlin.com>
        <20211207093422.166934-18-miquel.raynal@bootlin.com>
Organization: Collabora
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue,  7 Dec 2021 10:34:17 +0100
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

>  /**
> diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
> index 85e2ff7b840d..3be594be24c0 100644
> --- a/include/linux/spi/spi-mem.h
> +++ b/include/linux/spi/spi-mem.h
> @@ -94,6 +94,7 @@ enum spi_mem_data_dir {
>   *		 operation does not involve transferring data
>   * @data.buf.in: input buffer (must be DMA-able)
>   * @data.buf.out: output buffer (must be DMA-able)
> + * @ecc_en: error correction is required
>   */
>  struct spi_mem_op {
>  	struct {
> @@ -126,6 +127,8 @@ struct spi_mem_op {
>  			const void *out;
>  		} buf;
>  	} data;
> +
> +	bool ecc_en;
>  };

I really think this should be in it's own commit. And you need to make
sure all existing drivers reject operation that have ecc_en set to
true (that shouldn't be too complicated since most of them use generic
helpers to do the check).
