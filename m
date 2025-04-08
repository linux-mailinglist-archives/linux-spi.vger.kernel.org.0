Return-Path: <linux-spi+bounces-7445-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF30A7F6AE
	for <lists+linux-spi@lfdr.de>; Tue,  8 Apr 2025 09:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6770717A082
	for <lists+linux-spi@lfdr.de>; Tue,  8 Apr 2025 07:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359D925F996;
	Tue,  8 Apr 2025 07:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uxWitSMX"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D550A263F5F
	for <linux-spi@vger.kernel.org>; Tue,  8 Apr 2025 07:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744098067; cv=none; b=QLzIAlW9msEnH1vw3UshkFXA0FZr7R5dC7OHOYDnDq5z8bmNhd7KtxDs05Psb/g5yFaj1bxtKYA9IjQji1OFxaZzXl2OlmmlVnAPf4O1KtW2nlZkNd1T9PdZdB+KWcEUYmBl8W+0QcelMpZbNYOkvMXsrRGsaSGt/pWF0ELgAdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744098067; c=relaxed/simple;
	bh=2HEqD+NaO4qVhm2uejEvDidDqdkG34DXVu8SdUH0Sc0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=AY45yiJJrgv06oG7Vxg64/79of6OKBHVIv0YKqpkyyXgWSqNBEXNPouYEC98v9cx20l/UVZbW5E6n9+KkKggG90zi5l6YwrTPqtRY9FtqhStg+7OaYSfhH80OEFFdj9on6MAqSjQ/HbxQgam9KEPPIlVGmqFskq7tuxMgJmdl1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uxWitSMX; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-39ac8e7688aso3861854f8f.2
        for <linux-spi@vger.kernel.org>; Tue, 08 Apr 2025 00:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744098063; x=1744702863; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OBzY4DNAkSQIYTJkGYgxcjbp4RlcVNAfKTRv/D7futA=;
        b=uxWitSMXw658AJUhAS6hAjjquAEB/oOGIdunwm/JM5DAEw8W0QWFCJztrLVoVAtuLF
         1cjz1lHs9+g5CxDjZ6otXZdv4IQ/CtUdVb5xuoLL4sEk4dik16CYKK6nOvRZGdS21uKi
         ZjjyLnJJo/7Y8ddzhkW3XpYzd8jzklvjwnN7T+m3T1F9eqj/SM030FuRojvh3gssuHIj
         TmvuoeNbrqZLdHbQ9Bkyvtw/LbJ3C99KbOqxF9q2/N5J62dptHIjxFEYsYZUZgn69ADc
         DiGPSms7/ycHNzaaWvkY7dLLIT1MwaN6PlxcoHf2+yVxNKSyw9xYvPP4BeaJfNZ4OrZz
         pQjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744098063; x=1744702863;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OBzY4DNAkSQIYTJkGYgxcjbp4RlcVNAfKTRv/D7futA=;
        b=ivjqqAZLIywzFIvFazP0eh+m+SBoiXVVApaFLVLAgEkJWXF7ir+cV/t8ulpmnwTxCG
         EVHhic292o68ZGCv85QQSfVZxtYoJETcrDfXWlqYxO/nTLmIR+V94dFKHtgLK4Bzgv3C
         eSFbp0qRPIekIUbR2XPbwifWVcJPnAKq0Ia4W9COYeGOdavSrckw9KQVj9TmpU1bL9EB
         qp6TMV6tBqrUHPqChyIew0g1HkCu6Z2S6dL9Fw2RdC0mBvEryKELZWeqVeHwsS7c5ic+
         bu6QGU2T3BthU39x7RnMrg2v/Rlt15/+NwP0H18PEL75fdqaav54cCzby6s0HgUnIpgI
         E4+Q==
X-Gm-Message-State: AOJu0YzCfXwm62T4OIYwuNGewOhJEfIU8d9mrR1BfTIfdfl2tu25+DwI
	Ys/CQ5fj2uL+AAWetwMG06u1up3S7q9xHO/Xe5ubS2OaiAEMWARdhnfIjxZmQIM=
X-Gm-Gg: ASbGncu8GyvYOoV+JpuY8cjAaoBg1C+Ye7+46F6mz77wcuXAP7Frst607j1sGxXqgcF
	kYVXbHvfXM80Q39wetwOcmwE3xYg9AA3l8CBkbyZo6CoARASsHggAS7Br9Pir5VY+QFmBC1R9XD
	hd0bNgl7+p46hEujCkXUYODfov7Fizi6XJEPxg/9sgkmn+AQmhMmOe5YHvBlKGZN4yp1nDbs3pt
	1Nyg/X4O7Jqt+SRSYgYKExo9of5O5iP9REBEOfuROtTD30G8rXUtZk16KMY8nVZcGNCMbq/KOxL
	ngaNAxxiKD7pK5KSqApOkMpC4wMvu6SWoBZ2eJh26GySZV7NBMR56KnVOqqtx4FsuQZitp5FXJY
	wu8Ua3OXnamlGKyM4FS80IQ==
X-Google-Smtp-Source: AGHT+IFB8Ly9Bao3VXkAcSQAwJBj2tnrdH5KrQ7SEyBJsye1iKO4P0uzMFvkdrMfwWSiD/9/K0KzUg==
X-Received: by 2002:a05:6000:4310:b0:391:3bba:7f18 with SMTP id ffacd0b85a97d-39d6fc01096mr9411816f8f.12.1744098063061;
        Tue, 08 Apr 2025 00:41:03 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:3daa:5b6d:6ccb:4c71? ([2a01:e0a:3d9:2080:3daa:5b6d:6ccb:4c71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c301b76f2sm14209868f8f.53.2025.04.08.00.41.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Apr 2025 00:41:02 -0700 (PDT)
Message-ID: <c29a8c28-996c-4e94-b0a1-0e4a37f0bebb@linaro.org>
Date: Tue, 8 Apr 2025 09:41:02 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] spi: meson-spicc: add DMA support
To: xianwei.zhao@amlogic.com, Mark Brown <broonie@kernel.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
 Sunny Luo <sunny.luo@amlogic.com>
References: <20250408-spi-dma-v1-1-3c38be62c09c@amlogic.com>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20250408-spi-dma-v1-1-3c38be62c09c@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 08/04/2025 09:04, Xianwei Zhao via B4 Relay wrote:
> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
> 
> Add DMA support for spicc driver.
> 
> DMA works if the transfer meets the following conditions:
> 1. 64 bits per word;
> 2. The transfer length must be multiples of the dma_burst_len,
>     and the dma_burst_len should be one of 8,7...2,
>     otherwise, it will be split into several SPI bursts.
> 
> Signed-off-by: Sunny Luo <sunny.luo@amlogic.com>
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
>   drivers/spi/spi-meson-spicc.c | 243 ++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 232 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/spi/spi-meson-spicc.c b/drivers/spi/spi-meson-spicc.c
> index df74ad5060f8..81e263bceba9 100644
> --- a/drivers/spi/spi-meson-spicc.c
> +++ b/drivers/spi/spi-meson-spicc.c
> @@ -21,6 +21,7 @@
>   #include <linux/interrupt.h>
>   #include <linux/reset.h>
>   #include <linux/pinctrl/consumer.h>
> +#include <linux/dma-mapping.h>
>   
>   /*
>    * The Meson SPICC controller could support DMA based transfers, but is not
> @@ -33,6 +34,20 @@
>    * - CS management is dumb, and goes UP between every burst, so is really a
>    *   "Data Valid" signal than a Chip Select, GPIO link should be used instead
>    *   to have a CS go down over the full transfer
> + *
> + * DMA achieves a transfer with one or more SPI bursts, each SPI burst is made
> + * up of one or more DMA bursts. The DMA burst implementation mechanism is,
> + * For TX, when the number of words in TXFIFO is less than the preset
> + * reading threshold, SPICC starts a reading DMA burst, which reads the preset
> + * number of words from TX buffer, then writes them into TXFIFO.
> + * For RX, when the number of words in RXFIFO is greater than the preset
> + * writing threshold, SPICC starts a writing request burst, which reads the
> + * preset number of words from RXFIFO, then write them into RX buffer.
> + * DMA works if the transfer meets the following conditions,
> + * - 64 bits per word
> + * - The transfer length in word must be multiples of the dma_burst_len, and
> + *   the dma_burst_len should be one of 8,7...2, otherwise, it will be split
> + *   into several SPI bursts by this driver

Fine, but then also rephrase the previous paragraph since you're adding DMA.

Could you precise on which platform you tested the DMA ?

>    */
>   
>   #define SPICC_MAX_BURST	128
> @@ -128,6 +143,29 @@
>   
>   #define SPICC_DWADDR	0x24	/* Write Address of DMA */
>   
> +#define SPICC_LD_CNTL0	0x28
> +#define VSYNC_IRQ_SRC_SELECT		BIT(0)
> +#define DMA_EN_SET_BY_VSYNC		BIT(2)
> +#define XCH_EN_SET_BY_VSYNC		BIT(3)
> +#define DMA_READ_COUNTER_EN		BIT(4)
> +#define DMA_WRITE_COUNTER_EN		BIT(5)
> +#define DMA_RADDR_LOAD_BY_VSYNC		BIT(6)
> +#define DMA_WADDR_LOAD_BY_VSYNC		BIT(7)
> +#define DMA_ADDR_LOAD_FROM_LD_ADDR	BIT(8)
> +
> +#define SPICC_LD_CNTL1	0x2c
> +#define DMA_READ_COUNTER		GENMASK(15, 0)
> +#define DMA_WRITE_COUNTER		GENMASK(31, 16)
> +#define DMA_BURST_LEN_DEFAULT		8
> +#define DMA_BURST_COUNT_MAX		0xffff
> +#define SPI_BURST_LEN_MAX	(DMA_BURST_LEN_DEFAULT * DMA_BURST_COUNT_MAX)
> +
> +enum {
> +	DMA_TRIG_NORMAL = 0,
> +	DMA_TRIG_VSYNC,
> +	DMA_TRIG_LINE_N,

You're only using DMA_TRIG_NORMAL, what the other 2 values for ?

> +};
> +
>   #define SPICC_ENH_CTL0	0x38	/* Enhanced Feature */
>   #define SPICC_ENH_CLK_CS_DELAY_MASK	GENMASK(15, 0)
>   #define SPICC_ENH_DATARATE_MASK		GENMASK(23, 16)
> @@ -171,6 +209,9 @@ struct meson_spicc_device {
>   	struct pinctrl			*pinctrl;
>   	struct pinctrl_state		*pins_idle_high;
>   	struct pinctrl_state		*pins_idle_low;
> +	dma_addr_t			tx_dma;
> +	dma_addr_t			rx_dma;
> +	bool				using_dma;
>   };
>   
>   #define pow2_clk_to_spicc(_div) container_of(_div, struct meson_spicc_device, pow2_div)
> @@ -202,6 +243,155 @@ static void meson_spicc_oen_enable(struct meson_spicc_device *spicc)
>   	writel_relaxed(conf, spicc->base + SPICC_ENH_CTL0);
>   }
>   
> +static int meson_spicc_dma_map(struct meson_spicc_device *spicc,
> +			       struct spi_transfer *t)
> +{
> +	struct device *dev = spicc->host->dev.parent;
> +
> +	if (!(t->tx_buf && t->rx_buf))
> +		return -EINVAL;
> +
> +	t->tx_dma = dma_map_single(dev, (void *)t->tx_buf, t->len, DMA_TO_DEVICE);
> +	if (dma_mapping_error(dev, t->tx_dma))
> +		return -ENOMEM;
> +
> +	t->rx_dma = dma_map_single(dev, t->rx_buf, t->len, DMA_FROM_DEVICE);
> +	if (dma_mapping_error(dev, t->rx_dma))
> +		return -ENOMEM;
> +
> +	spicc->tx_dma = t->tx_dma;
> +	spicc->rx_dma = t->rx_dma;
> +
> +	return 0;
> +}
> +
> +static void meson_spicc_dma_unmap(struct meson_spicc_device *spicc,
> +				  struct spi_transfer *t)
> +{
> +	struct device *dev = spicc->host->dev.parent;
> +
> +	if (t->tx_dma)
> +		dma_unmap_single(dev, t->tx_dma, t->len, DMA_TO_DEVICE);
> +	if (t->rx_dma)
> +		dma_unmap_single(dev, t->rx_dma, t->len, DMA_FROM_DEVICE);
> +}
> +
> +/*
> + * According to the remain words length, calculate a suitable spi burst length
> + * and a dma burst length for current spi burst
> + */
> +static u32 meson_spicc_calc_dma_len(struct meson_spicc_device *spicc,
> +				    u32 len, u32 *dma_burst_len)
> +{
> +	u32 i;
> +
> +	if (len <= spicc->data->fifo_size) {
> +		*dma_burst_len = len;
> +		return len;
> +	}
> +
> +	*dma_burst_len = DMA_BURST_LEN_DEFAULT;
> +
> +	if (len == (SPI_BURST_LEN_MAX + 1))
> +		return SPI_BURST_LEN_MAX - DMA_BURST_LEN_DEFAULT;
> +
> +	if (len >= SPI_BURST_LEN_MAX)
> +		return SPI_BURST_LEN_MAX;
> +
> +	for (i = DMA_BURST_LEN_DEFAULT; i > 1; i--)
> +		if ((len % i) == 0) {
> +			*dma_burst_len = i;
> +			return len;
> +		}
> +
> +	i = len % DMA_BURST_LEN_DEFAULT;
> +	len -= i;
> +
> +	if (i == 1)
> +		len -= DMA_BURST_LEN_DEFAULT;
> +
> +	return len;
> +}
> +
> +static void meson_spicc_setup_dma(struct meson_spicc_device *spicc, u8 trig)
> +{
> +	unsigned int len;
> +	unsigned int dma_burst_len, dma_burst_count;
> +	unsigned int count_en = 0;
> +	unsigned int txfifo_thres = 0;
> +	unsigned int read_req = 0;
> +	unsigned int rxfifo_thres = 31;
> +	unsigned int write_req = 0;
> +	unsigned int ld_ctr1 = 0;
> +
> +	writel_relaxed(spicc->tx_dma, spicc->base + SPICC_DRADDR);
> +	writel_relaxed(spicc->rx_dma, spicc->base + SPICC_DWADDR);
> +
> +	/* Set the max burst length to support a transmission with length of
> +	 * no more than 1024 bytes(128 words), which must use the CS management
> +	 * because of some strict timing requirements
> +	 */
> +	writel_bits_relaxed(SPICC_BURSTLENGTH_MASK, SPICC_BURSTLENGTH_MASK,
> +			    spicc->base + SPICC_CONREG);
> +
> +	len = meson_spicc_calc_dma_len(spicc, spicc->xfer_remain,
> +				       &dma_burst_len);
> +	spicc->xfer_remain -= len;
> +	dma_burst_count = DIV_ROUND_UP(len, dma_burst_len);
> +	dma_burst_len--;
> +
> +	if (trig == DMA_TRIG_LINE_N)
> +		count_en |= VSYNC_IRQ_SRC_SELECT;

Is this the VPU VSYNC irq ? is this a tested and valid usecase ?

> +
> +	if (spicc->tx_dma) {
> +		spicc->tx_dma += len;
> +		count_en |= DMA_READ_COUNTER_EN;
> +		if (trig == DMA_TRIG_VSYNC || trig == DMA_TRIG_LINE_N)
> +			count_en |= DMA_RADDR_LOAD_BY_VSYNC
> +				    | DMA_ADDR_LOAD_FROM_LD_ADDR;
> +		txfifo_thres = spicc->data->fifo_size - dma_burst_len;
> +		read_req = dma_burst_len;
> +		ld_ctr1 |= FIELD_PREP(DMA_READ_COUNTER, dma_burst_count);
> +	}
> +
> +	if (spicc->rx_dma) {
> +		spicc->rx_dma += len;
> +		count_en |= DMA_WRITE_COUNTER_EN;
> +		if (trig == DMA_TRIG_VSYNC || trig == DMA_TRIG_LINE_N)
> +			count_en |= DMA_WADDR_LOAD_BY_VSYNC
> +				    | DMA_ADDR_LOAD_FROM_LD_ADDR;
> +		rxfifo_thres = dma_burst_len;
> +		write_req = dma_burst_len;
> +		ld_ctr1 |= FIELD_PREP(DMA_WRITE_COUNTER, dma_burst_count);
> +	}
> +
> +	writel_relaxed(count_en, spicc->base + SPICC_LD_CNTL0);
> +	writel_relaxed(ld_ctr1, spicc->base + SPICC_LD_CNTL1);
> +	writel_relaxed(((trig == DMA_TRIG_NORMAL) ? SPICC_DMA_ENABLE : 0)
> +		    | SPICC_DMA_URGENT
> +		    | FIELD_PREP(SPICC_TXFIFO_THRESHOLD_MASK, txfifo_thres)
> +		    | FIELD_PREP(SPICC_READ_BURST_MASK, read_req)
> +		    | FIELD_PREP(SPICC_RXFIFO_THRESHOLD_MASK, rxfifo_thres)
> +		    | FIELD_PREP(SPICC_WRITE_BURST_MASK, write_req),
> +		    spicc->base + SPICC_DMAREG);
> +}
> +
> +static void meson_spicc_dma_irq(struct meson_spicc_device *spicc)
> +{
> +	if (readl_relaxed(spicc->base + SPICC_DMAREG) & SPICC_DMA_ENABLE)
> +		return;
> +
> +	if (spicc->xfer_remain) {
> +		meson_spicc_setup_dma(spicc, DMA_TRIG_NORMAL);
> +	} else {
> +		writel_bits_relaxed(SPICC_SMC, 0, spicc->base + SPICC_CONREG);
> +		writel_relaxed(0, spicc->base + SPICC_INTREG);
> +		writel_relaxed(0, spicc->base + SPICC_DMAREG);
> +		meson_spicc_dma_unmap(spicc, spicc->xfer);
> +		complete(&spicc->done);
> +	}
> +}
> +
>   static inline bool meson_spicc_txfull(struct meson_spicc_device *spicc)
>   {
>   	return !!FIELD_GET(SPICC_TF,
> @@ -293,6 +483,11 @@ static irqreturn_t meson_spicc_irq(int irq, void *data)
>   
>   	writel_bits_relaxed(SPICC_TC, SPICC_TC, spicc->base + SPICC_STATREG);
>   
> +	if (spicc->using_dma) {
> +		meson_spicc_dma_irq(spicc);
> +		return IRQ_HANDLED;
> +	}

Make meson_spicc_dma_irq() return irqreturn_t and return IRQ_HANDLED.

> +
>   	/* Empty RX FIFO */
>   	meson_spicc_rx(spicc);
>   
> @@ -426,9 +621,6 @@ static int meson_spicc_transfer_one(struct spi_controller *host,
>   
>   	meson_spicc_reset_fifo(spicc);
>   
> -	/* Setup burst */
> -	meson_spicc_setup_burst(spicc);
> -
>   	/* Setup wait for completion */
>   	reinit_completion(&spicc->done);
>   
> @@ -442,11 +634,40 @@ static int meson_spicc_transfer_one(struct spi_controller *host,
>   	/* Increase it twice and add 200 ms tolerance */
>   	timeout += timeout + 200;
>   
> -	/* Start burst */
> -	writel_bits_relaxed(SPICC_XCH, SPICC_XCH, spicc->base + SPICC_CONREG);
> +	if (xfer->bits_per_word == 64) {
> +		int ret;
>   
> -	/* Enable interrupts */
> -	writel_relaxed(SPICC_TC_EN, spicc->base + SPICC_INTREG);
> +		/* must tx */
> +		if (!xfer->tx_buf)
> +			return -EINVAL;
> +
> +		/* dma_burst_len 1 can't trigger a dma burst */
> +		if (xfer->len < 16)
> +			return -EINVAL;

Those 2 checks should be done to enable the DMA mode, you should fallback to FIFO mode
instead of returning EINVAL, except if 64 bits_per_word is only valid in DMA mode ?

> +
> +		ret = meson_spicc_dma_map(spicc, xfer);
> +		if (ret) {
> +			meson_spicc_dma_unmap(spicc, xfer);
> +			dev_err(host->dev.parent, "dma map failed\n");
> +			return ret;
> +		}
> +
> +		spicc->using_dma = true;
> +		spicc->xfer_remain = DIV_ROUND_UP(xfer->len, spicc->bytes_per_word);
> +		meson_spicc_setup_dma(spicc, DMA_TRIG_NORMAL);
> +		writel_relaxed(SPICC_TE_EN, spicc->base + SPICC_INTREG);
> +		writel_bits_relaxed(SPICC_SMC, SPICC_SMC, spicc->base + SPICC_CONREG);
> +	} else {
> +		spicc->using_dma = false;
> +		/* Setup burst */
> +		meson_spicc_setup_burst(spicc);
> +
> +		/* Start burst */
> +		writel_bits_relaxed(SPICC_XCH, SPICC_XCH, spicc->base + SPICC_CONREG);
> +
> +		/* Enable interrupts */
> +		writel_relaxed(SPICC_TC_EN, spicc->base + SPICC_INTREG);
> +	}
>   
>   	if (!wait_for_completion_timeout(&spicc->done, msecs_to_jiffies(timeout)))
>   		return -ETIMEDOUT;
> @@ -853,10 +1074,10 @@ static int meson_spicc_probe(struct platform_device *pdev)
>   	host->num_chipselect = 4;
>   	host->dev.of_node = pdev->dev.of_node;
>   	host->mode_bits = SPI_CPHA | SPI_CPOL | SPI_CS_HIGH | SPI_LOOP;
> -	host->bits_per_word_mask = SPI_BPW_MASK(32) |
> -				   SPI_BPW_MASK(24) |
> -				   SPI_BPW_MASK(16) |
> -				   SPI_BPW_MASK(8);
> +	/* DMA works at 64 bits, but it is invalidated by the spi core,
> +	 * clr the mask to avoid the spi core validation check
> +	 */
> +	host->bits_per_word_mask = 0;

Fine, instead please add a check in meson_spicc_setup() to make sure
we operate only in 8, 16, 24, 32 & 64 bits_per_word.

So not need to clear it, the host buffer was allocated with spi_alloc_host() which
allocates with kzalloc(), already zeroing the allocated memory.

Neil

>   	host->flags = (SPI_CONTROLLER_MUST_RX | SPI_CONTROLLER_MUST_TX);
>   	host->min_speed_hz = spicc->data->min_speed_hz;
>   	host->max_speed_hz = spicc->data->max_speed_hz;
> 
> ---
> base-commit: 49807ed87851916ef655f72e9562f96355183090
> change-id: 20250408-spi-dma-c499f560d295
> 
> Best regards,

With those fixed, the path is clear & clean, thanks !

Neil

