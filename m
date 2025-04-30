Return-Path: <linux-spi+bounces-7803-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E240EAA4438
	for <lists+linux-spi@lfdr.de>; Wed, 30 Apr 2025 09:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DEF04C5D00
	for <lists+linux-spi@lfdr.de>; Wed, 30 Apr 2025 07:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE93C20C463;
	Wed, 30 Apr 2025 07:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ULyxw41A"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7963620C461
	for <linux-spi@vger.kernel.org>; Wed, 30 Apr 2025 07:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745999025; cv=none; b=L7L+CwJ0kfcas75cSbdmmnXo/BqaHjGy8fcmTdgnbGcMMyvHgyBGnj+wOK9WAN8Flk/0A8bo4ubpVLLt+pa2T3bAkRHSR1042q7vJ/F7lSzSDLVixnNikz+sGMIwaJjdQkRdBIrjfKtTiNnlP6vC6MB9JVhuji8l4jdiVlDOHrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745999025; c=relaxed/simple;
	bh=agsCNs4S/XEFYrPDe6QLdxGQEYJXBtNljxqEMSTH9oY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=s1EJRmYrV+PJl+BPZyiXcOU6sfHfFoZ8k+tGTqc3FLL3g7Hp4NFTOMB5gsSy92bsNZ/2gxoafo3wFag0S4CFmjWcAxdw6yH2+lvIxcaStgxL92vzdAqLb8XDq2TsHwG0fgsmU5Dk8tyAlk/hTtlbHWXbv+mQBRY1y6nwdJZMtWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ULyxw41A; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a07a7b4ac7so2253756f8f.2
        for <linux-spi@vger.kernel.org>; Wed, 30 Apr 2025 00:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745999022; x=1746603822; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9SzEy6AnjCXnf6XCivHNCHEN/tEDWXGvmycVUe8Tdeg=;
        b=ULyxw41A+aKmBP5JJW6lr8gMXSsgmLBUioWo5BSWCSGJP49gia46V6IdFWuQoCzAgS
         roIfl1+pPqDGJd6IKXLBqOvhMQU83WgNty9VS/TWjt2R+lholc0j2U2XWtDxFUKIupmv
         4oFzdRHlTRevLHARCUVOsGiJu0GZv/Sm3SwntCP3K79YPN08QhbS/iQsFV0s+LG3nr75
         lYVMhUv8VLtKoAP/fRn1Pq20tyaLr4VFR/Gvz+PF1fQUJRl+X8IJk7PkcxLAS4Ghqroh
         +lHkSijnxsW+I+v0YEk+A74ZqboYKwrUPdlMchORc5Lwj41kzwUj7geTLKCfU7hD5aTG
         1NzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745999022; x=1746603822;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9SzEy6AnjCXnf6XCivHNCHEN/tEDWXGvmycVUe8Tdeg=;
        b=SxqX7i/r9luhNKTPTiR6hHpOfcgH7c/QO1v1P8OYsiVdod4GOA+ANOcC4QZjgQ7Q8d
         SdKqXZWmGtpqz0wbBMuso/bjnDh3HLlDbrhVBI1mBU/sX664J2dGV31ovLY30vsE31lK
         E+mHCocycK79DOHe17nhJnItLhQBl5E/xhQ6B2t9pH/3lhVix90bMEpXDhEH9GaxSXO/
         CTQpE5MLIIsDo03fFQqQKnFAB2wbZ5w8iV/GxOO/IcKj6pIPUj3kw819YCeLYpqH8X/+
         59wIb0NhKVqCefsgoX602ELwnmIR3M7N01YU8F9d2ysxMHF3YT4/YZKAcCSQdiK218CF
         QzdA==
X-Forwarded-Encrypted: i=1; AJvYcCXrI8VmCtLEx7mBwpHSQPFbuu4HOkouijqKn2PiDnl2+Ko1jz6RmrQWrcmZ0CfGNQTOwpNGtVQdsk0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEFooUg33vo/ea5FrdOezRSTAukITetyOxGVxkS6ucYIhrUvW/
	2mDbQJLz5nDjhF1gHe8wnLWiHn/EShkk1P3b3gx1D0TAtndVIaGiOGknlHB7f0Q=
X-Gm-Gg: ASbGncs324ykwV2M1TnGAJCth6UD77hjJjARuFhSpIIdYhD4/nTleDXS/12Q73T6jLG
	lRHBRAwC5wczxaaiUDIbWI8LPGdWEltm/MuhDth/iQLwaTiCa3cGvW1XjsCjEbrKOLzSocXde+n
	l0BoLo/rzSdoKZsGXcs8EU6xvyfvJATDBBomj21/LLmoM9pctYe/X+g2JnQFDVn1ILXX3MTxZ7h
	5J/KmkLObLSGsNuwNyJxDzVFvh6cQ9JSz8RkbZR0ElE3OhPsVd6Bl38rKF2tomxNSFbwpKSUdH/
	sntnEjgz17wXuF2gccs3hUbzCx5LAVggLOYg7xrdZj70BXB2Dv8rZAz5ytwIO2PBGMyxWpK4ckI
	E7oPzqEX2fD3r0cUI+A==
X-Google-Smtp-Source: AGHT+IEr1/MzNOmXxqQwDD4O840Mb+7POrGnK1mUIw70eit5hq1zEM9H1eqLXUSzjw3gY02wAaBIag==
X-Received: by 2002:a05:6000:3104:b0:39e:cbf2:e23f with SMTP id ffacd0b85a97d-3a08f728f4fmr1951888f8f.0.1745999021648;
        Wed, 30 Apr 2025 00:43:41 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:b3d6:213c:5c50:7785? ([2a01:e0a:3d9:2080:b3d6:213c:5c50:7785])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073e5e198sm16578112f8f.97.2025.04.30.00.43.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Apr 2025 00:43:41 -0700 (PDT)
Message-ID: <b202538e-5520-48ce-a957-034c0ce7beb1@linaro.org>
Date: Wed, 30 Apr 2025 09:43:40 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2] spi: meson-spicc: add DMA support
To: Da Xue <da@lessconfused.com>, xianwei.zhao@amlogic.com
Cc: Mark Brown <broonie@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
 Sunny Luo <sunny.luo@amlogic.com>
References: <20250414-spi-dma-v2-1-84bbd92fa469@amlogic.com>
 <CACdvmAhEXstEBdaiktU4n-R6M6mYiBnSx15ZJfb1FOKGD7Zfaw@mail.gmail.com>
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
In-Reply-To: <CACdvmAhEXstEBdaiktU4n-R6M6mYiBnSx15ZJfb1FOKGD7Zfaw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 30/04/2025 04:13, Da Xue wrote:
> On Mon, Apr 14, 2025 at 2:30 AM Xianwei Zhao via B4 Relay
> <devnull+xianwei.zhao.amlogic.com@kernel.org> wrote:
>>
>> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
>>
>> Add DMA support for spicc driver.
>>
>> DMA works if the transfer meets the following conditions:
>> 1. 64 bits per word;
>> 2. The transfer length must be multiples of the dma_burst_len,
>>     and the dma_burst_len should be one of 8,7...2,
>>     otherwise, it will be split into several SPI bursts.
>>
>> Signed-off-by: Sunny Luo <sunny.luo@amlogic.com>
>> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
>> ---
>> Changes in v2:
>> - Make formatting adjustments and code optimizations according to Neil's suggestions.
>> - Remove two special DMA trigger modes that are not fully implemented.
>> - Link to v1: https://lore.kernel.org/r/20250408-spi-dma-v1-1-3c38be62c09c@amlogic.com
>> ---
>>   drivers/spi/spi-meson-spicc.c | 241 ++++++++++++++++++++++++++++++++++++++----
>>   1 file changed, 220 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/spi/spi-meson-spicc.c b/drivers/spi/spi-meson-spicc.c
>> index df74ad5060f8..6b9137307533 100644
>> --- a/drivers/spi/spi-meson-spicc.c
>> +++ b/drivers/spi/spi-meson-spicc.c
>> @@ -21,18 +21,26 @@
>>   #include <linux/interrupt.h>
>>   #include <linux/reset.h>
>>   #include <linux/pinctrl/consumer.h>
>> +#include <linux/dma-mapping.h>
>>
>>   /*
>> - * The Meson SPICC controller could support DMA based transfers, but is not
>> - * implemented by the vendor code, and while having the registers documentation
>> - * it has never worked on the GXL Hardware.
>> - * The PIO mode is the only mode implemented, and due to badly designed HW :
>> - * - all transfers are cutted in 16 words burst because the FIFO hangs on
>> - *   TX underflow, and there is no TX "Half-Empty" interrupt, so we go by
>> - *   FIFO max size chunk only
>> - * - CS management is dumb, and goes UP between every burst, so is really a
>> - *   "Data Valid" signal than a Chip Select, GPIO link should be used instead
>> - *   to have a CS go down over the full transfer
>> + * There are two modes for data transmission: PIO and DMA.
>> + * When bits_per_word is 8, 16, 24, or 32, data is transferred using PIO mode.
>> + * When bits_per_word is 64, DMA mode is used by default.
>> + *
>> + * DMA achieves a transfer with one or more SPI bursts, each SPI burst is made
>> + * up of one or more DMA bursts. The DMA burst implementation mechanism is,
>> + * For TX, when the number of words in TXFIFO is less than the preset
>> + * reading threshold, SPICC starts a reading DMA burst, which reads the preset
>> + * number of words from TX buffer, then writes them into TXFIFO.
>> + * For RX, when the number of words in RXFIFO is greater than the preset
>> + * writing threshold, SPICC starts a writing request burst, which reads the
>> + * preset number of words from RXFIFO, then write them into RX buffer.
>> + * DMA works if the transfer meets the following conditions,
>> + * - 64 bits per word
> 
> Just for clarification, DMA can only send 64-bit words due to hardware
> design, right?
> The bit-per-word in spi control register (CONREG) has no effect?
> 
>> + * - The transfer length in word must be multiples of the dma_burst_len, and
>> + *   the dma_burst_len should be one of 8,7...2, otherwise, it will be split
>> + *   into several SPI bursts by this driver
>>    */
>>
>>   #define SPICC_MAX_BURST        128
>> @@ -128,6 +136,23 @@
>>
>>   #define SPICC_DWADDR   0x24    /* Write Address of DMA */
>>
>> +#define SPICC_LD_CNTL0 0x28
>> +#define VSYNC_IRQ_SRC_SELECT           BIT(0)
>> +#define DMA_EN_SET_BY_VSYNC            BIT(2)
>> +#define XCH_EN_SET_BY_VSYNC            BIT(3)
>> +#define DMA_READ_COUNTER_EN            BIT(4)
>> +#define DMA_WRITE_COUNTER_EN           BIT(5)
>> +#define DMA_RADDR_LOAD_BY_VSYNC                BIT(6)
>> +#define DMA_WADDR_LOAD_BY_VSYNC                BIT(7)
>> +#define DMA_ADDR_LOAD_FROM_LD_ADDR     BIT(8)
>> +
>> +#define SPICC_LD_CNTL1 0x2c
>> +#define DMA_READ_COUNTER               GENMASK(15, 0)
>> +#define DMA_WRITE_COUNTER              GENMASK(31, 16)
>> +#define DMA_BURST_LEN_DEFAULT          8
>> +#define DMA_BURST_COUNT_MAX            0xffff
>> +#define SPI_BURST_LEN_MAX      (DMA_BURST_LEN_DEFAULT * DMA_BURST_COUNT_MAX)
>> +
> 
> LD_CNTL0 and LD_CNTL1 are not in this datasheet for GXL
> (S805X/S905X/S905D). Do they exist on these SoCs and are not
> documented?
> 
>>   #define SPICC_ENH_CTL0 0x38    /* Enhanced Feature */
>>   #define SPICC_ENH_CLK_CS_DELAY_MASK    GENMASK(15, 0)
>>   #define SPICC_ENH_DATARATE_MASK                GENMASK(23, 16)
>> @@ -171,6 +196,9 @@ struct meson_spicc_device {
>>          struct pinctrl                  *pinctrl;
>>          struct pinctrl_state            *pins_idle_high;
>>          struct pinctrl_state            *pins_idle_low;
>> +       dma_addr_t                      tx_dma;
>> +       dma_addr_t                      rx_dma;
>> +       bool                            using_dma;
>>   };
>>
>>   #define pow2_clk_to_spicc(_div) container_of(_div, struct meson_spicc_device, pow2_div)
>> @@ -202,6 +230,148 @@ static void meson_spicc_oen_enable(struct meson_spicc_device *spicc)
>>          writel_relaxed(conf, spicc->base + SPICC_ENH_CTL0);
>>   }
>>
>> +static int meson_spicc_dma_map(struct meson_spicc_device *spicc,
>> +                              struct spi_transfer *t)
>> +{
>> +       struct device *dev = spicc->host->dev.parent;
>> +
>> +       if (!(t->tx_buf && t->rx_buf))
>> +               return -EINVAL;
>> +
>> +       t->tx_dma = dma_map_single(dev, (void *)t->tx_buf, t->len, DMA_TO_DEVICE);
>> +       if (dma_mapping_error(dev, t->tx_dma))
>> +               return -ENOMEM;
>> +
>> +       t->rx_dma = dma_map_single(dev, t->rx_buf, t->len, DMA_FROM_DEVICE);
>> +       if (dma_mapping_error(dev, t->rx_dma))
>> +               return -ENOMEM;
>> +
>> +       spicc->tx_dma = t->tx_dma;
>> +       spicc->rx_dma = t->rx_dma;
>> +
>> +       return 0;
>> +}
>> +
>> +static void meson_spicc_dma_unmap(struct meson_spicc_device *spicc,
>> +                                 struct spi_transfer *t)
>> +{
>> +       struct device *dev = spicc->host->dev.parent;
>> +
>> +       if (t->tx_dma)
>> +               dma_unmap_single(dev, t->tx_dma, t->len, DMA_TO_DEVICE);
>> +       if (t->rx_dma)
>> +               dma_unmap_single(dev, t->rx_dma, t->len, DMA_FROM_DEVICE);
>> +}
>> +
>> +/*
>> + * According to the remain words length, calculate a suitable spi burst length
>> + * and a dma burst length for current spi burst
>> + */
>> +static u32 meson_spicc_calc_dma_len(struct meson_spicc_device *spicc,
>> +                                   u32 len, u32 *dma_burst_len)
>> +{
>> +       u32 i;
>> +
>> +       if (len <= spicc->data->fifo_size) {
>> +               *dma_burst_len = len;
>> +               return len;
>> +       }
>> +
>> +       *dma_burst_len = DMA_BURST_LEN_DEFAULT;
>> +
>> +       if (len == (SPI_BURST_LEN_MAX + 1))
>> +               return SPI_BURST_LEN_MAX - DMA_BURST_LEN_DEFAULT;
>> +
>> +       if (len >= SPI_BURST_LEN_MAX)
>> +               return SPI_BURST_LEN_MAX;
>> +
>> +       for (i = DMA_BURST_LEN_DEFAULT; i > 1; i--)
>> +               if ((len % i) == 0) {
>> +                       *dma_burst_len = i;
>> +                       return len;
>> +               }
>> +
>> +       i = len % DMA_BURST_LEN_DEFAULT;
>> +       len -= i;
>> +
>> +       if (i == 1)
>> +               len -= DMA_BURST_LEN_DEFAULT;
>> +
>> +       return len;
>> +}
>> +
>> +static void meson_spicc_setup_dma(struct meson_spicc_device *spicc)
>> +{
>> +       unsigned int len;
>> +       unsigned int dma_burst_len, dma_burst_count;
>> +       unsigned int count_en = 0;
>> +       unsigned int txfifo_thres = 0;
>> +       unsigned int read_req = 0;
>> +       unsigned int rxfifo_thres = 31;
>> +       unsigned int write_req = 0;
>> +       unsigned int ld_ctr1 = 0;
>> +
>> +       writel_relaxed(spicc->tx_dma, spicc->base + SPICC_DRADDR);
>> +       writel_relaxed(spicc->rx_dma, spicc->base + SPICC_DWADDR);
>> +
>> +       /* Set the max burst length to support a transmission with length of
>> +        * no more than 1024 bytes(128 words), which must use the CS management
>> +        * because of some strict timing requirements
>> +        */
>> +       writel_bits_relaxed(SPICC_BURSTLENGTH_MASK, SPICC_BURSTLENGTH_MASK,
>> +                           spicc->base + SPICC_CONREG);
>> +
>> +       len = meson_spicc_calc_dma_len(spicc, spicc->xfer_remain,
>> +                                      &dma_burst_len);
>> +       spicc->xfer_remain -= len;
>> +       dma_burst_count = DIV_ROUND_UP(len, dma_burst_len);
>> +       dma_burst_len--;
>> +
>> +       if (spicc->tx_dma) {
>> +               spicc->tx_dma += len;
>> +               count_en |= DMA_READ_COUNTER_EN;
>> +               txfifo_thres = spicc->data->fifo_size - dma_burst_len;
>> +               read_req = dma_burst_len;
>> +               ld_ctr1 |= FIELD_PREP(DMA_READ_COUNTER, dma_burst_count);
>> +       }
>> +
>> +       if (spicc->rx_dma) {
>> +               spicc->rx_dma += len;
>> +               count_en |= DMA_WRITE_COUNTER_EN;
>> +               rxfifo_thres = dma_burst_len;
>> +               write_req = dma_burst_len;
>> +               ld_ctr1 |= FIELD_PREP(DMA_WRITE_COUNTER, dma_burst_count);
>> +       }
>> +
>> +       writel_relaxed(count_en, spicc->base + SPICC_LD_CNTL0);
>> +       writel_relaxed(ld_ctr1, spicc->base + SPICC_LD_CNTL1);
>> +       writel_relaxed(SPICC_DMA_ENABLE
>> +                   | SPICC_DMA_URGENT
>> +                   | FIELD_PREP(SPICC_TXFIFO_THRESHOLD_MASK, txfifo_thres)
>> +                   | FIELD_PREP(SPICC_READ_BURST_MASK, read_req)
>> +                   | FIELD_PREP(SPICC_RXFIFO_THRESHOLD_MASK, rxfifo_thres)
>> +                   | FIELD_PREP(SPICC_WRITE_BURST_MASK, write_req),
>> +                   spicc->base + SPICC_DMAREG);
>> +}
>> +
>> +static irqreturn_t meson_spicc_dma_irq(struct meson_spicc_device *spicc)
>> +{
>> +       if (readl_relaxed(spicc->base + SPICC_DMAREG) & SPICC_DMA_ENABLE)
>> +               return IRQ_HANDLED;
>> +
>> +       if (spicc->xfer_remain) {
>> +               meson_spicc_setup_dma(spicc);
>> +       } else {
>> +               writel_bits_relaxed(SPICC_SMC, 0, spicc->base + SPICC_CONREG);
>> +               writel_relaxed(0, spicc->base + SPICC_INTREG);
>> +               writel_relaxed(0, spicc->base + SPICC_DMAREG);
>> +               meson_spicc_dma_unmap(spicc, spicc->xfer);
>> +               complete(&spicc->done);
>> +       }
>> +
>> +       return IRQ_HANDLED;
>> +}
>> +
>>   static inline bool meson_spicc_txfull(struct meson_spicc_device *spicc)
>>   {
>>          return !!FIELD_GET(SPICC_TF,
>> @@ -293,6 +463,9 @@ static irqreturn_t meson_spicc_irq(int irq, void *data)
>>
>>          writel_bits_relaxed(SPICC_TC, SPICC_TC, spicc->base + SPICC_STATREG);
>>
>> +       if (spicc->using_dma)
>> +               return meson_spicc_dma_irq(spicc);
>> +
>>          /* Empty RX FIFO */
>>          meson_spicc_rx(spicc);
>>
>> @@ -426,9 +599,6 @@ static int meson_spicc_transfer_one(struct spi_controller *host,
>>
>>          meson_spicc_reset_fifo(spicc);
>>
>> -       /* Setup burst */
>> -       meson_spicc_setup_burst(spicc);
>> -
>>          /* Setup wait for completion */
>>          reinit_completion(&spicc->done);
>>
>> @@ -442,11 +612,36 @@ static int meson_spicc_transfer_one(struct spi_controller *host,
>>          /* Increase it twice and add 200 ms tolerance */
>>          timeout += timeout + 200;
>>
>> -       /* Start burst */
>> -       writel_bits_relaxed(SPICC_XCH, SPICC_XCH, spicc->base + SPICC_CONREG);
>> +       if (xfer->bits_per_word == 64) {
>> +               int ret;
>> +
>> +               /* dma_burst_len 1 can't trigger a dma burst */
>> +               if (xfer->len < 16)
>> +                       return -EINVAL;
>> +
>> +               ret = meson_spicc_dma_map(spicc, xfer);
>> +               if (ret) {
>> +                       meson_spicc_dma_unmap(spicc, xfer);
>> +                       dev_err(host->dev.parent, "dma map failed\n");
>> +                       return ret;
>> +               }
>> +
>> +               spicc->using_dma = true;
>> +               spicc->xfer_remain = DIV_ROUND_UP(xfer->len, spicc->bytes_per_word);
>> +               meson_spicc_setup_dma(spicc);
>> +               writel_relaxed(SPICC_TE_EN, spicc->base + SPICC_INTREG);
>> +               writel_bits_relaxed(SPICC_SMC, SPICC_SMC, spicc->base + SPICC_CONREG);
>> +       } else {
>> +               spicc->using_dma = false;
>> +               /* Setup burst */
>> +               meson_spicc_setup_burst(spicc);
>>
>> -       /* Enable interrupts */
>> -       writel_relaxed(SPICC_TC_EN, spicc->base + SPICC_INTREG);
>> +               /* Start burst */
>> +               writel_bits_relaxed(SPICC_XCH, SPICC_XCH, spicc->base + SPICC_CONREG);
>> +
>> +               /* Enable interrupts */
>> +               writel_relaxed(SPICC_TC_EN, spicc->base + SPICC_INTREG);
>> +       }
>>
>>          if (!wait_for_completion_timeout(&spicc->done, msecs_to_jiffies(timeout)))
>>                  return -ETIMEDOUT;
>> @@ -545,6 +740,14 @@ static int meson_spicc_setup(struct spi_device *spi)
>>          if (!spi->controller_state)
>>                  spi->controller_state = spi_controller_get_devdata(spi->controller);
>>
>> +       /* DMA works at 64 bits, the rest works on PIO */
>> +       if (spi->bits_per_word != 8 &&
>> +           spi->bits_per_word != 16 &&
>> +           spi->bits_per_word != 24 &&
>> +           spi->bits_per_word != 32 &&
>> +           spi->bits_per_word != 64)
>> +               return -EINVAL;
>> +
>>          return 0;
>>   }
>>
>> @@ -853,10 +1056,6 @@ static int meson_spicc_probe(struct platform_device *pdev)
>>          host->num_chipselect = 4;
>>          host->dev.of_node = pdev->dev.of_node;
>>          host->mode_bits = SPI_CPHA | SPI_CPOL | SPI_CS_HIGH | SPI_LOOP;
>> -       host->bits_per_word_mask = SPI_BPW_MASK(32) |
>> -                                  SPI_BPW_MASK(24) |
>> -                                  SPI_BPW_MASK(16) |
>> -                                  SPI_BPW_MASK(8);
> 
> This should not be removed. SPI_BPW_MASK(64) needs to be added.
> Removing bits_per_word_mask causes other code to assume this is an
> 8-bit only controller.

SPI_BPW_MASK(64) doesn't not exist, it's only a 32bit field, removing it is fine,
the check is done later.

Neil

> 
> 
> 
>>          host->flags = (SPI_CONTROLLER_MUST_RX | SPI_CONTROLLER_MUST_TX);
>>          host->min_speed_hz = spicc->data->min_speed_hz;
>>          host->max_speed_hz = spicc->data->max_speed_hz;
>>
>> ---
>> base-commit: 49807ed87851916ef655f72e9562f96355183090
>> change-id: 20250408-spi-dma-c499f560d295
>>
>> Best regards,
>> --
>> Xianwei Zhao <xianwei.zhao@amlogic.com>
>>
>>
>>
>> _______________________________________________
>> linux-amlogic mailing list
>> linux-amlogic@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-amlogic


