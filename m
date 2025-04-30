Return-Path: <linux-spi+bounces-7801-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E09AA40DB
	for <lists+linux-spi@lfdr.de>; Wed, 30 Apr 2025 04:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A918C9853F8
	for <lists+linux-spi@lfdr.de>; Wed, 30 Apr 2025 02:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D663B13C9A3;
	Wed, 30 Apr 2025 02:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lessconfused.com header.i=@lessconfused.com header.b="MNSYsdrk"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D950839F4
	for <linux-spi@vger.kernel.org>; Wed, 30 Apr 2025 02:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745979213; cv=none; b=gNBm3sT0+VKu1wI8F6ydDYvrMYBDwoZrgJaZmgCjm/E/esI2x4eIrA02zudBf9zvEkUfOCYEJpQnfJfkzu/dglFqDASkjNTn6XRI5+u2VN2vKombVt+XtJtQNzV8HnszNEbGjlwTB//4lA4RStCMHeHTQfTPl2T5mcOTPtNmdC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745979213; c=relaxed/simple;
	bh=zFZlbFIFgKXluwwz4NSj8L4Sj2ltXBd1M+pTDGo+hdU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OvyGbP62n7Va17yC7ncrdriEIstr7gg6w3njwB6d9toq5ow/a9r9KomrKWrDa69h56zYgVNHbIB4ga3/BQwEqy3o8rJC2xy5REf3aUSa5yOQRejzdH9F9jk4pQPmoX2COplmhRFICS3wv2pfsOif0++Aj3sdOjVR8kkMwen5CfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lessconfused.com; spf=pass smtp.mailfrom=lessconfused.com; dkim=pass (1024-bit key) header.d=lessconfused.com header.i=@lessconfused.com header.b=MNSYsdrk; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lessconfused.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lessconfused.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-301e05b90caso7388111a91.2
        for <linux-spi@vger.kernel.org>; Tue, 29 Apr 2025 19:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lessconfused.com; s=lessconfused; t=1745979210; x=1746584010; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hxQSNWJIpgLL0K345+9EHCJtfozXJ2Yu+qkzD2t1E54=;
        b=MNSYsdrkS289FScvzD9oq9EigytwUdpUt0OqpCGay6Ams3kys1vv7G16jUDjWh0eUT
         O2ASnFH2j/aPJsGgsZ2QNd4/Vbyccs8MGOEH8jECiZzcqZKNEM9eksK9TfHxy5PfxSSc
         v0RRYuQ/pqnzeNlLIi5zvvxWuZ2MXBjc/QBms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745979210; x=1746584010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hxQSNWJIpgLL0K345+9EHCJtfozXJ2Yu+qkzD2t1E54=;
        b=T8OqGWAeQzu5w90umDtRXtDhYDJg662yczEP5JNm6ouZ3gWnUf+Jp0mvu9dqlDNqNG
         sAr+ZV5pRcrQbMJn2GczPpNoxrAqwsFlWrYD/IxdMzPXtl+9CHe6oEyjat0xIa0M9Ad4
         4ZfNtkUPWxoVfKDvrhP2YEVDP526wx+mppeqp8hFSg22sQpqlo1eEdx2dePZ+eXhrQv9
         5+Sf0H6PZX9Pcihw7sDrSk4VO8aVFy71Jf4rLQX30dLKSxRbmfTQTQosTEjnm4gN1ONV
         WlY5SqizZLJHGNVuJIFsaTWioZ3QLmWuQ24HRpG8NHz4B3WZzeZU8cEEsCBfEWg5elMI
         9N/A==
X-Forwarded-Encrypted: i=1; AJvYcCWMrvBxqjC8o77vM2sx4whKq5fkbqWT6CNHbzAC/HIULlmXfzE7uC5lV3YpbZ/pgRhgC+YZ+VGx6WE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCGAbwGxpAPA5TFpfijN0u4pVfyxXY3W3c4iXYjcBKNQE8pMfr
	F9URjmBSvV1j90HQmUWWi/iKKpE22rCOMah+EzH5qT76RJIqtUyHTI676xn/ROnMF55qyxeTgIS
	k1mY3YTpwxrl8DQX9h3QNGjTb0nVZ3clPDWM5KA==
X-Gm-Gg: ASbGncuVb8BAg+PO96BhV+YNym5MpL4h/iIxAlF+ReNkBzUjK8UG2qeBAT09tFc69lL
	uHV2RmrsvfpQvXWA9U1JYZ4b7olEdpRayiC0nFysMeZC8epXA8IivtNK4TQAAaw+cAqEWJ+aN1l
	VlUTLp2jMOjGZ3PN5FPlah0M/QOgiBy2K/iuK+yr6lFdDzelSoCK/sUxQ=
X-Google-Smtp-Source: AGHT+IFWh6po6oeHM9w2N/xbVzQ8pllPfaIp/ocjh5/n+lZ05a6r7QzsR9e8d0QT+TpFdsiXtNRkoEQTcLTUuUwJQ44=
X-Received: by 2002:a17:90a:bd97:b0:2ff:6167:e92d with SMTP id
 98e67ed59e1d1-30a34489514mr915586a91.32.1745979209448; Tue, 29 Apr 2025
 19:13:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414-spi-dma-v2-1-84bbd92fa469@amlogic.com>
In-Reply-To: <20250414-spi-dma-v2-1-84bbd92fa469@amlogic.com>
From: Da Xue <da@lessconfused.com>
Date: Tue, 29 Apr 2025 22:13:18 -0400
X-Gm-Features: ATxdqUF1uePmGqw_DHzosv8XmIVsTIOhJnSFRlSHFpTZiilbCy-M7TFAp_71R8M
Message-ID: <CACdvmAhEXstEBdaiktU4n-R6M6mYiBnSx15ZJfb1FOKGD7Zfaw@mail.gmail.com>
Subject: Re: [PATCH v2] spi: meson-spicc: add DMA support
To: xianwei.zhao@amlogic.com
Cc: Mark Brown <broonie@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, linux-spi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Sunny Luo <sunny.luo@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 14, 2025 at 2:30=E2=80=AFAM Xianwei Zhao via B4 Relay
<devnull+xianwei.zhao.amlogic.com@kernel.org> wrote:
>
> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
>
> Add DMA support for spicc driver.
>
> DMA works if the transfer meets the following conditions:
> 1. 64 bits per word;
> 2. The transfer length must be multiples of the dma_burst_len,
>    and the dma_burst_len should be one of 8,7...2,
>    otherwise, it will be split into several SPI bursts.
>
> Signed-off-by: Sunny Luo <sunny.luo@amlogic.com>
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
> Changes in v2:
> - Make formatting adjustments and code optimizations according to Neil's =
suggestions.
> - Remove two special DMA trigger modes that are not fully implemented.
> - Link to v1: https://lore.kernel.org/r/20250408-spi-dma-v1-1-3c38be62c09=
c@amlogic.com
> ---
>  drivers/spi/spi-meson-spicc.c | 241 ++++++++++++++++++++++++++++++++++++=
++----
>  1 file changed, 220 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/spi/spi-meson-spicc.c b/drivers/spi/spi-meson-spicc.=
c
> index df74ad5060f8..6b9137307533 100644
> --- a/drivers/spi/spi-meson-spicc.c
> +++ b/drivers/spi/spi-meson-spicc.c
> @@ -21,18 +21,26 @@
>  #include <linux/interrupt.h>
>  #include <linux/reset.h>
>  #include <linux/pinctrl/consumer.h>
> +#include <linux/dma-mapping.h>
>
>  /*
> - * The Meson SPICC controller could support DMA based transfers, but is =
not
> - * implemented by the vendor code, and while having the registers docume=
ntation
> - * it has never worked on the GXL Hardware.
> - * The PIO mode is the only mode implemented, and due to badly designed =
HW :
> - * - all transfers are cutted in 16 words burst because the FIFO hangs o=
n
> - *   TX underflow, and there is no TX "Half-Empty" interrupt, so we go b=
y
> - *   FIFO max size chunk only
> - * - CS management is dumb, and goes UP between every burst, so is reall=
y a
> - *   "Data Valid" signal than a Chip Select, GPIO link should be used in=
stead
> - *   to have a CS go down over the full transfer
> + * There are two modes for data transmission: PIO and DMA.
> + * When bits_per_word is 8, 16, 24, or 32, data is transferred using PIO=
 mode.
> + * When bits_per_word is 64, DMA mode is used by default.
> + *
> + * DMA achieves a transfer with one or more SPI bursts, each SPI burst i=
s made
> + * up of one or more DMA bursts. The DMA burst implementation mechanism =
is,
> + * For TX, when the number of words in TXFIFO is less than the preset
> + * reading threshold, SPICC starts a reading DMA burst, which reads the =
preset
> + * number of words from TX buffer, then writes them into TXFIFO.
> + * For RX, when the number of words in RXFIFO is greater than the preset
> + * writing threshold, SPICC starts a writing request burst, which reads =
the
> + * preset number of words from RXFIFO, then write them into RX buffer.
> + * DMA works if the transfer meets the following conditions,
> + * - 64 bits per word

Just for clarification, DMA can only send 64-bit words due to hardware
design, right?
The bit-per-word in spi control register (CONREG) has no effect?

> + * - The transfer length in word must be multiples of the dma_burst_len,=
 and
> + *   the dma_burst_len should be one of 8,7...2, otherwise, it will be s=
plit
> + *   into several SPI bursts by this driver
>   */
>
>  #define SPICC_MAX_BURST        128
> @@ -128,6 +136,23 @@
>
>  #define SPICC_DWADDR   0x24    /* Write Address of DMA */
>
> +#define SPICC_LD_CNTL0 0x28
> +#define VSYNC_IRQ_SRC_SELECT           BIT(0)
> +#define DMA_EN_SET_BY_VSYNC            BIT(2)
> +#define XCH_EN_SET_BY_VSYNC            BIT(3)
> +#define DMA_READ_COUNTER_EN            BIT(4)
> +#define DMA_WRITE_COUNTER_EN           BIT(5)
> +#define DMA_RADDR_LOAD_BY_VSYNC                BIT(6)
> +#define DMA_WADDR_LOAD_BY_VSYNC                BIT(7)
> +#define DMA_ADDR_LOAD_FROM_LD_ADDR     BIT(8)
> +
> +#define SPICC_LD_CNTL1 0x2c
> +#define DMA_READ_COUNTER               GENMASK(15, 0)
> +#define DMA_WRITE_COUNTER              GENMASK(31, 16)
> +#define DMA_BURST_LEN_DEFAULT          8
> +#define DMA_BURST_COUNT_MAX            0xffff
> +#define SPI_BURST_LEN_MAX      (DMA_BURST_LEN_DEFAULT * DMA_BURST_COUNT_=
MAX)
> +

LD_CNTL0 and LD_CNTL1 are not in this datasheet for GXL
(S805X/S905X/S905D). Do they exist on these SoCs and are not
documented?

>  #define SPICC_ENH_CTL0 0x38    /* Enhanced Feature */
>  #define SPICC_ENH_CLK_CS_DELAY_MASK    GENMASK(15, 0)
>  #define SPICC_ENH_DATARATE_MASK                GENMASK(23, 16)
> @@ -171,6 +196,9 @@ struct meson_spicc_device {
>         struct pinctrl                  *pinctrl;
>         struct pinctrl_state            *pins_idle_high;
>         struct pinctrl_state            *pins_idle_low;
> +       dma_addr_t                      tx_dma;
> +       dma_addr_t                      rx_dma;
> +       bool                            using_dma;
>  };
>
>  #define pow2_clk_to_spicc(_div) container_of(_div, struct meson_spicc_de=
vice, pow2_div)
> @@ -202,6 +230,148 @@ static void meson_spicc_oen_enable(struct meson_spi=
cc_device *spicc)
>         writel_relaxed(conf, spicc->base + SPICC_ENH_CTL0);
>  }
>
> +static int meson_spicc_dma_map(struct meson_spicc_device *spicc,
> +                              struct spi_transfer *t)
> +{
> +       struct device *dev =3D spicc->host->dev.parent;
> +
> +       if (!(t->tx_buf && t->rx_buf))
> +               return -EINVAL;
> +
> +       t->tx_dma =3D dma_map_single(dev, (void *)t->tx_buf, t->len, DMA_=
TO_DEVICE);
> +       if (dma_mapping_error(dev, t->tx_dma))
> +               return -ENOMEM;
> +
> +       t->rx_dma =3D dma_map_single(dev, t->rx_buf, t->len, DMA_FROM_DEV=
ICE);
> +       if (dma_mapping_error(dev, t->rx_dma))
> +               return -ENOMEM;
> +
> +       spicc->tx_dma =3D t->tx_dma;
> +       spicc->rx_dma =3D t->rx_dma;
> +
> +       return 0;
> +}
> +
> +static void meson_spicc_dma_unmap(struct meson_spicc_device *spicc,
> +                                 struct spi_transfer *t)
> +{
> +       struct device *dev =3D spicc->host->dev.parent;
> +
> +       if (t->tx_dma)
> +               dma_unmap_single(dev, t->tx_dma, t->len, DMA_TO_DEVICE);
> +       if (t->rx_dma)
> +               dma_unmap_single(dev, t->rx_dma, t->len, DMA_FROM_DEVICE)=
;
> +}
> +
> +/*
> + * According to the remain words length, calculate a suitable spi burst =
length
> + * and a dma burst length for current spi burst
> + */
> +static u32 meson_spicc_calc_dma_len(struct meson_spicc_device *spicc,
> +                                   u32 len, u32 *dma_burst_len)
> +{
> +       u32 i;
> +
> +       if (len <=3D spicc->data->fifo_size) {
> +               *dma_burst_len =3D len;
> +               return len;
> +       }
> +
> +       *dma_burst_len =3D DMA_BURST_LEN_DEFAULT;
> +
> +       if (len =3D=3D (SPI_BURST_LEN_MAX + 1))
> +               return SPI_BURST_LEN_MAX - DMA_BURST_LEN_DEFAULT;
> +
> +       if (len >=3D SPI_BURST_LEN_MAX)
> +               return SPI_BURST_LEN_MAX;
> +
> +       for (i =3D DMA_BURST_LEN_DEFAULT; i > 1; i--)
> +               if ((len % i) =3D=3D 0) {
> +                       *dma_burst_len =3D i;
> +                       return len;
> +               }
> +
> +       i =3D len % DMA_BURST_LEN_DEFAULT;
> +       len -=3D i;
> +
> +       if (i =3D=3D 1)
> +               len -=3D DMA_BURST_LEN_DEFAULT;
> +
> +       return len;
> +}
> +
> +static void meson_spicc_setup_dma(struct meson_spicc_device *spicc)
> +{
> +       unsigned int len;
> +       unsigned int dma_burst_len, dma_burst_count;
> +       unsigned int count_en =3D 0;
> +       unsigned int txfifo_thres =3D 0;
> +       unsigned int read_req =3D 0;
> +       unsigned int rxfifo_thres =3D 31;
> +       unsigned int write_req =3D 0;
> +       unsigned int ld_ctr1 =3D 0;
> +
> +       writel_relaxed(spicc->tx_dma, spicc->base + SPICC_DRADDR);
> +       writel_relaxed(spicc->rx_dma, spicc->base + SPICC_DWADDR);
> +
> +       /* Set the max burst length to support a transmission with length=
 of
> +        * no more than 1024 bytes(128 words), which must use the CS mana=
gement
> +        * because of some strict timing requirements
> +        */
> +       writel_bits_relaxed(SPICC_BURSTLENGTH_MASK, SPICC_BURSTLENGTH_MAS=
K,
> +                           spicc->base + SPICC_CONREG);
> +
> +       len =3D meson_spicc_calc_dma_len(spicc, spicc->xfer_remain,
> +                                      &dma_burst_len);
> +       spicc->xfer_remain -=3D len;
> +       dma_burst_count =3D DIV_ROUND_UP(len, dma_burst_len);
> +       dma_burst_len--;
> +
> +       if (spicc->tx_dma) {
> +               spicc->tx_dma +=3D len;
> +               count_en |=3D DMA_READ_COUNTER_EN;
> +               txfifo_thres =3D spicc->data->fifo_size - dma_burst_len;
> +               read_req =3D dma_burst_len;
> +               ld_ctr1 |=3D FIELD_PREP(DMA_READ_COUNTER, dma_burst_count=
);
> +       }
> +
> +       if (spicc->rx_dma) {
> +               spicc->rx_dma +=3D len;
> +               count_en |=3D DMA_WRITE_COUNTER_EN;
> +               rxfifo_thres =3D dma_burst_len;
> +               write_req =3D dma_burst_len;
> +               ld_ctr1 |=3D FIELD_PREP(DMA_WRITE_COUNTER, dma_burst_coun=
t);
> +       }
> +
> +       writel_relaxed(count_en, spicc->base + SPICC_LD_CNTL0);
> +       writel_relaxed(ld_ctr1, spicc->base + SPICC_LD_CNTL1);
> +       writel_relaxed(SPICC_DMA_ENABLE
> +                   | SPICC_DMA_URGENT
> +                   | FIELD_PREP(SPICC_TXFIFO_THRESHOLD_MASK, txfifo_thre=
s)
> +                   | FIELD_PREP(SPICC_READ_BURST_MASK, read_req)
> +                   | FIELD_PREP(SPICC_RXFIFO_THRESHOLD_MASK, rxfifo_thre=
s)
> +                   | FIELD_PREP(SPICC_WRITE_BURST_MASK, write_req),
> +                   spicc->base + SPICC_DMAREG);
> +}
> +
> +static irqreturn_t meson_spicc_dma_irq(struct meson_spicc_device *spicc)
> +{
> +       if (readl_relaxed(spicc->base + SPICC_DMAREG) & SPICC_DMA_ENABLE)
> +               return IRQ_HANDLED;
> +
> +       if (spicc->xfer_remain) {
> +               meson_spicc_setup_dma(spicc);
> +       } else {
> +               writel_bits_relaxed(SPICC_SMC, 0, spicc->base + SPICC_CON=
REG);
> +               writel_relaxed(0, spicc->base + SPICC_INTREG);
> +               writel_relaxed(0, spicc->base + SPICC_DMAREG);
> +               meson_spicc_dma_unmap(spicc, spicc->xfer);
> +               complete(&spicc->done);
> +       }
> +
> +       return IRQ_HANDLED;
> +}
> +
>  static inline bool meson_spicc_txfull(struct meson_spicc_device *spicc)
>  {
>         return !!FIELD_GET(SPICC_TF,
> @@ -293,6 +463,9 @@ static irqreturn_t meson_spicc_irq(int irq, void *dat=
a)
>
>         writel_bits_relaxed(SPICC_TC, SPICC_TC, spicc->base + SPICC_STATR=
EG);
>
> +       if (spicc->using_dma)
> +               return meson_spicc_dma_irq(spicc);
> +
>         /* Empty RX FIFO */
>         meson_spicc_rx(spicc);
>
> @@ -426,9 +599,6 @@ static int meson_spicc_transfer_one(struct spi_contro=
ller *host,
>
>         meson_spicc_reset_fifo(spicc);
>
> -       /* Setup burst */
> -       meson_spicc_setup_burst(spicc);
> -
>         /* Setup wait for completion */
>         reinit_completion(&spicc->done);
>
> @@ -442,11 +612,36 @@ static int meson_spicc_transfer_one(struct spi_cont=
roller *host,
>         /* Increase it twice and add 200 ms tolerance */
>         timeout +=3D timeout + 200;
>
> -       /* Start burst */
> -       writel_bits_relaxed(SPICC_XCH, SPICC_XCH, spicc->base + SPICC_CON=
REG);
> +       if (xfer->bits_per_word =3D=3D 64) {
> +               int ret;
> +
> +               /* dma_burst_len 1 can't trigger a dma burst */
> +               if (xfer->len < 16)
> +                       return -EINVAL;
> +
> +               ret =3D meson_spicc_dma_map(spicc, xfer);
> +               if (ret) {
> +                       meson_spicc_dma_unmap(spicc, xfer);
> +                       dev_err(host->dev.parent, "dma map failed\n");
> +                       return ret;
> +               }
> +
> +               spicc->using_dma =3D true;
> +               spicc->xfer_remain =3D DIV_ROUND_UP(xfer->len, spicc->byt=
es_per_word);
> +               meson_spicc_setup_dma(spicc);
> +               writel_relaxed(SPICC_TE_EN, spicc->base + SPICC_INTREG);
> +               writel_bits_relaxed(SPICC_SMC, SPICC_SMC, spicc->base + S=
PICC_CONREG);
> +       } else {
> +               spicc->using_dma =3D false;
> +               /* Setup burst */
> +               meson_spicc_setup_burst(spicc);
>
> -       /* Enable interrupts */
> -       writel_relaxed(SPICC_TC_EN, spicc->base + SPICC_INTREG);
> +               /* Start burst */
> +               writel_bits_relaxed(SPICC_XCH, SPICC_XCH, spicc->base + S=
PICC_CONREG);
> +
> +               /* Enable interrupts */
> +               writel_relaxed(SPICC_TC_EN, spicc->base + SPICC_INTREG);
> +       }
>
>         if (!wait_for_completion_timeout(&spicc->done, msecs_to_jiffies(t=
imeout)))
>                 return -ETIMEDOUT;
> @@ -545,6 +740,14 @@ static int meson_spicc_setup(struct spi_device *spi)
>         if (!spi->controller_state)
>                 spi->controller_state =3D spi_controller_get_devdata(spi-=
>controller);
>
> +       /* DMA works at 64 bits, the rest works on PIO */
> +       if (spi->bits_per_word !=3D 8 &&
> +           spi->bits_per_word !=3D 16 &&
> +           spi->bits_per_word !=3D 24 &&
> +           spi->bits_per_word !=3D 32 &&
> +           spi->bits_per_word !=3D 64)
> +               return -EINVAL;
> +
>         return 0;
>  }
>
> @@ -853,10 +1056,6 @@ static int meson_spicc_probe(struct platform_device=
 *pdev)
>         host->num_chipselect =3D 4;
>         host->dev.of_node =3D pdev->dev.of_node;
>         host->mode_bits =3D SPI_CPHA | SPI_CPOL | SPI_CS_HIGH | SPI_LOOP;
> -       host->bits_per_word_mask =3D SPI_BPW_MASK(32) |
> -                                  SPI_BPW_MASK(24) |
> -                                  SPI_BPW_MASK(16) |
> -                                  SPI_BPW_MASK(8);

This should not be removed. SPI_BPW_MASK(64) needs to be added.
Removing bits_per_word_mask causes other code to assume this is an
8-bit only controller.



>         host->flags =3D (SPI_CONTROLLER_MUST_RX | SPI_CONTROLLER_MUST_TX)=
;
>         host->min_speed_hz =3D spicc->data->min_speed_hz;
>         host->max_speed_hz =3D spicc->data->max_speed_hz;
>
> ---
> base-commit: 49807ed87851916ef655f72e9562f96355183090
> change-id: 20250408-spi-dma-c499f560d295
>
> Best regards,
> --
> Xianwei Zhao <xianwei.zhao@amlogic.com>
>
>
>
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic

