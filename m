Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5FE1118267
	for <lists+linux-spi@lfdr.de>; Tue, 10 Dec 2019 09:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfLJIkS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 10 Dec 2019 03:40:18 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:46902 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbfLJIkS (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 10 Dec 2019 03:40:18 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBA8eEuu083342;
        Tue, 10 Dec 2019 02:40:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1575967214;
        bh=ieszD3YSfu51ufC36/QrYyxWRF0AbihQa26c3lvy8Lk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=tTqQWTq/1CVyh5bguPJxFCP9QVolaaQti46OlUVvtNR93BGOw22/hjgzwLsGyCYmT
         38b/voCv55pLP/Ox2nKixWO2DlBQlU8OydENaPv2+4f5it/tL6AoggsDVjtkHyiABk
         MUJEb17hBDg72KrUGCHdp7DY9ts2LkjaZGDVhjFA=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBA8eEca073526;
        Tue, 10 Dec 2019 02:40:14 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 10
 Dec 2019 02:40:13 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 10 Dec 2019 02:40:14 -0600
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBA8eBG0094374;
        Tue, 10 Dec 2019 02:40:11 -0600
Subject: Re: [PATCH 3/3] TI QSPI: optimize transfers for dual and quad read
To:     Jean Pihet <jean.pihet@newoldbits.com>,
        Mark Brown <broonie@kernel.org>, Tero Kristo <t-kristo@ti.com>
CC:     <linux-omap@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        Ryan Barnett <ryan.barnett@rockwellcollins.com>,
        Conrad Ratschan <conrad.ratschan@rockwellcollins.com>
References: <20191206160007.331801-1-jean.pihet@newoldbits.com>
 <20191206160007.331801-4-jean.pihet@newoldbits.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <2efd2981-73d1-6975-a385-871809ec43f1@ti.com>
Date:   Tue, 10 Dec 2019 14:10:40 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191206160007.331801-4-jean.pihet@newoldbits.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 06/12/19 9:30 pm, Jean Pihet wrote:
> By reading the 32 bits data register and copy the contents to the
> receive buffer, according to the single/dual/quad read mode and
> the data length to read.
> 
> The speed improvement is 3.5x using quad read.
> ---
>  drivers/spi/spi-ti-qspi.c | 48 ++++++++++++++++++++++++++-------------
>  1 file changed, 32 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
> index 13916232a959..65ec3bcb25ae 100644
> --- a/drivers/spi/spi-ti-qspi.c
> +++ b/drivers/spi/spi-ti-qspi.c
> @@ -313,24 +313,25 @@ static int qspi_write_msg(struct ti_qspi *qspi, struct spi_transfer *t,
>  static int qspi_read_msg(struct ti_qspi *qspi, struct spi_transfer *t,
>  			 int count)
>  {
> -	int wlen;
>  	unsigned int cmd;
> +	u32 rx;
>  	u8 *rxbuf;
> +	u8 xfer_len;
>  
>  	rxbuf = t->rx_buf;
>  	cmd = qspi->cmd;
> +	/* Optimize the transfers for dual and quad read */
>  	switch (t->rx_nbits) {
> -	case SPI_NBITS_DUAL:
> -		cmd |= QSPI_RD_DUAL;
> -		break;
>  	case SPI_NBITS_QUAD:
> -		cmd |= QSPI_RD_QUAD;
> +		cmd |= QSPI_RD_QUAD | QSPI_WLEN(32);

Why does QUAD mode mean 32 bit words?

IO mode and word size are independent of each other. If you want to
optimize for speed, why not set FLEN field to max and WLEN to max and
use ti_qspi_adjust_op_size to clamp max read size to 4096 words when
required. This should work irrespective of IO modes.
Driver already does something similar to this in the write path.

> +		break;
> +	case SPI_NBITS_DUAL:
> +		cmd |= QSPI_RD_DUAL | QSPI_WLEN(16);
>  		break;
>  	default:
> -		cmd |= QSPI_RD_SNGL;
> +		cmd |= QSPI_RD_SNGL | QSPI_WLEN(8);
>  		break;
>  	}
> -	wlen = t->bits_per_word >> 3;	/* in bytes */
>  
>  	while (count) {
>  		dev_dbg(qspi->dev, "rx cmd %08x dc %08x\n", cmd, qspi->dc);
> @@ -342,19 +343,34 @@ static int qspi_read_msg(struct ti_qspi *qspi, struct spi_transfer *t,
>  			dev_err(qspi->dev, "read timed out\n");
>  			return -ETIMEDOUT;
>  		}
> -		switch (wlen) {
> -		case 1:
> -			*rxbuf = readb(qspi->base + QSPI_SPI_DATA_REG);
> +
> +		/* Optimize the transfers for dual and quad read */
> +		rx = readl(qspi->base + QSPI_SPI_DATA_REG);
> +		switch (t->rx_nbits) {
> +		case SPI_NBITS_QUAD:
> +			if (count >= 1)
> +				*rxbuf++ = rx >> 24;
> +			if (count >= 2)
> +				*rxbuf++ = rx >> 16;
> +			if (count >= 3)
> +				*rxbuf++ = rx >> 8;
> +			if (count >= 4)
> +				*rxbuf++ = rx;
> +			xfer_len = min(count, 4);
>  			break;
> -		case 2:
> -			*((u16 *)rxbuf) = readw(qspi->base + QSPI_SPI_DATA_REG);
> +		case SPI_NBITS_DUAL:
> +			if (count >= 1)
> +				*rxbuf++ = rx >> 8;
> +			if (count >= 2)
> +				*rxbuf++ = rx;
> +			xfer_len = min(count, 2);
>  			break;
> -		case 4:
> -			*((u32 *)rxbuf) = readl(qspi->base + QSPI_SPI_DATA_REG);
> +		default:
> +			*rxbuf++ = rx;
> +			xfer_len = 1;
>  			break;

This will fail in case of t->rx_nbits = 1 and t->bits_per_word = 32
(1 bit SPI bus bit slave with 32-bit addressable registers)

bits_per_word indicate the address granularity within SPI Slave
(represented by WLEN field in TI QSPI) and rx_nbits tells about buswidth
(bits received per bus clock)

>  		}
> -		rxbuf += wlen;
> -		count -= wlen;
> +		count -= xfer_len;
>  	}
>  
>  	return 0;
> 

-- 
Regards
Vignesh
