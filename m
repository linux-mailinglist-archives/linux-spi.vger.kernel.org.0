Return-Path: <linux-spi+bounces-7564-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC4EA87699
	for <lists+linux-spi@lfdr.de>; Mon, 14 Apr 2025 05:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3F6B167602
	for <lists+linux-spi@lfdr.de>; Mon, 14 Apr 2025 03:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A2619539F;
	Mon, 14 Apr 2025 03:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lessconfused.com header.i=@lessconfused.com header.b="GOGDAh3l"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29C0F9FE
	for <linux-spi@vger.kernel.org>; Mon, 14 Apr 2025 03:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744602975; cv=none; b=a/IccBflca6vLE/uQh8cnNE0OI7dAkXKxHdBMxADRw0obY1RRk96M8kqz8mEE2nGP+I1a+svV3ipbScABRcaCNuynAL1QtuZn4rAWVOFefrq5iXRSHAWI6+2YdjAmhXZglaSnnqkQlqiLElvKWEy7fk293fbvGvZ/cgUNhhxXzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744602975; c=relaxed/simple;
	bh=QaTRM7wFK5czchUwLIHTiQf/G9eL6q0AyomcDIzNABY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=je+niKxwqGmoXjEWB40u5lH4O4ByjaqhOJel50OBEjn4DV6uEyu8BWYsvYqff3WZcafyLshod8qt9OvfCtGGstxXRcEdC1PtoLmetxIT7Rf7ypxWNLP8S/QR8hTJfxbwnQXBFB0YPzxAra1uxTMkdNIYzRo71hR96G/ss8KVDV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lessconfused.com; spf=pass smtp.mailfrom=lessconfused.com; dkim=pass (1024-bit key) header.d=lessconfused.com header.i=@lessconfused.com header.b=GOGDAh3l; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lessconfused.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lessconfused.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2ff615a114bso4106888a91.0
        for <linux-spi@vger.kernel.org>; Sun, 13 Apr 2025 20:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lessconfused.com; s=lessconfused; t=1744602972; x=1745207772; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pEyQ+6Lry9GDEzWqmLzeC9/yTRJMhLm4hY5bnjDHH1w=;
        b=GOGDAh3lSPGoUmoaC00btuLeihudUGp0kBowIacd2AFmOxno1i6cy5DpmSH6dMBZp1
         Wer/gymIzdZGuRM4swysvtkoF2dYuBcscPNR+o8M3ipKe4FYBRY3apgmfvNkV4ma6qEH
         I2466WaNVGn0e51MSX2V7KInt5c0AcEIq5Fsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744602972; x=1745207772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pEyQ+6Lry9GDEzWqmLzeC9/yTRJMhLm4hY5bnjDHH1w=;
        b=lFZEJ6Zq8aLAoUIHOWZf11cElge3Hls1uGnM7LlFwdPcwwDR5F+QtxRXPC/WQNyhPL
         DuGR7zcV0EEKfJcB5dm0SK5/poOmMUBk/IDTuvDIcBURm/viOlLQIn95G6+5yz/KXatj
         RKIJvkMYKfZs5tnQ/cWaOPKeeKmlH3tySMMx5e8cVRPKe46cuZB05FGxuOXNdJasQ7LP
         B+LHXmaq4H8Uppm7xmSvbAIFN0+ebjU7Js5XNPO05+PFUE5Be/VlEhP7QWrp/LIZmeq7
         okUG7MOyjrcCwB2iiNhHHixisunKD1V47ziYrtPrCSMFpH0aj/TIi/awHZw92EaHpMtQ
         DZIQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9953s4To6EkjkMNhASeSuKkROP22n5HvFI3Dt3kBjeVjbbhdE3liMAw71CJOonnJPcku5/6YFodE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFv5vT3NqpeT4HoCW9QLLA0OKwGM1fE3s/J4FSPqWMITyQkv7Z
	g+xAcGQv4QBn9I/8BkPKsofZMNE50BH/qjdrXSLu/7ujQzsgQA0u26aMRtkt2Bcj2yTPQxAvuW/
	SgxKUn+dG+RVnkjnShZd0edW6O3qA8FAXI553dg==
X-Gm-Gg: ASbGncsOPH3mO+qyCaIQ+clBTHRaOT7Gj7DIsbbNOydWb4e+ZG0coH35wXQeIprqQ2u
	uhn9PV+8jIipBc9iFmKObMc4RP0ktDr5Yd9MBBQUCFfQtvXXqtmLTR4BbKH8Fhx1JhotQcMoBMt
	uAjMcL6GNITPp8BWLNZuNNlZpIdNGrbC7YL7WDwl3JfPxrGXq2RbG31+M=
X-Google-Smtp-Source: AGHT+IHWQwgZyTngxDZx1znmrgvaA/ygkKWtQ2ojCjZB+MrRyIVrf8sqL/NozQzHRrJRRHczcNu3I0AVXBhPavuQFMg=
X-Received: by 2002:a17:90b:5744:b0:2f1:2e10:8160 with SMTP id
 98e67ed59e1d1-30823672b84mr16288128a91.11.1744602972004; Sun, 13 Apr 2025
 20:56:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250408-spi-dma-v1-1-3c38be62c09c@amlogic.com>
 <c29a8c28-996c-4e94-b0a1-0e4a37f0bebb@linaro.org> <aebccc51-14a2-40be-8d9e-20a55ce94459@amlogic.com>
 <d9d81cb4-12b4-4db3-becb-4578548986b2@linaro.org> <c9f0ca5f-17c4-474f-8370-fc0c83ac9093@amlogic.com>
In-Reply-To: <c9f0ca5f-17c4-474f-8370-fc0c83ac9093@amlogic.com>
From: Da Xue <da@lessconfused.com>
Date: Sun, 13 Apr 2025 23:56:00 -0400
X-Gm-Features: ATxdqUH2S8feawtLOZq9m8SKM3_aIASnBY9S2tM4a1H6Cu1XC7JIAnD2mtBsLzw
Message-ID: <CACdvmAg5px00er9TUd6_Nhr1GoSf=6LK6vSWOB-YcC1Ve0NRQQ@mail.gmail.com>
Subject: Re: [PATCH] spi: meson-spicc: add DMA support
To: Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc: neil.armstrong@linaro.org, Mark Brown <broonie@kernel.org>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, linux-spi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Sunny Luo <sunny.luo@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 13, 2025 at 11:14=E2=80=AFPM Xianwei Zhao <xianwei.zhao@amlogic=
.com> wrote:
>
> Hi Neil,
>     Thanks for your reply.
>
> On 2025/4/9 20:35, neil.armstrong@linaro.org wrote:
> >
> > Hi,
> >
> > On 09/04/2025 03:49, Xianwei Zhao wrote:
> >> Hi Neil,
> >>     Thanks for your reply.
> >>
> >> On 2025/4/8 15:41, Neil Armstrong wrote:
> >>> [ EXTERNAL EMAIL ]
> >>>
> >>> Hi,
> >>>
> >>> On 08/04/2025 09:04, Xianwei Zhao via B4 Relay wrote:
> >>>> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
> >>>>
> >>>> Add DMA support for spicc driver.
> >>>>
> >>>> DMA works if the transfer meets the following conditions:
> >>>> 1. 64 bits per word;
> >>>> 2. The transfer length must be multiples of the dma_burst_len,
> >>>>     and the dma_burst_len should be one of 8,7...2,
> >>>>     otherwise, it will be split into several SPI bursts.
> >>>>
> >>>> Signed-off-by: Sunny Luo <sunny.luo@amlogic.com>
> >>>> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> >>>> ---
> >>>>   drivers/spi/spi-meson-spicc.c | 243
> >>>> ++++++++++++++++++++++++++++++++++++++++--
> >>>>   1 file changed, 232 insertions(+), 11 deletions(-)
> >>>>
> >>>> diff --git a/drivers/spi/spi-meson-spicc.c
> >>>> b/drivers/spi/spi-meson-spicc.c
> >>>> index df74ad5060f8..81e263bceba9 100644
> >>>> --- a/drivers/spi/spi-meson-spicc.c
> >>>> +++ b/drivers/spi/spi-meson-spicc.c
> >>>> @@ -21,6 +21,7 @@
> >>>>   #include <linux/interrupt.h>
> >>>>   #include <linux/reset.h>
> >>>>   #include <linux/pinctrl/consumer.h>
> >>>> +#include <linux/dma-mapping.h>
> >>>>
> >>>>   /*
> >>>>    * The Meson SPICC controller could support DMA based transfers,
> >>>> but is not
> >>>> @@ -33,6 +34,20 @@
> >>>>    * - CS management is dumb, and goes UP between every burst, so is
> >>>> really a
> >>>>    *   "Data Valid" signal than a Chip Select, GPIO link should be
> >>>> used instead
> >>>>    *   to have a CS go down over the full transfer
> >>>> + *
> >>>> + * DMA achieves a transfer with one or more SPI bursts, each SPI
> >>>> burst is made
> >>>> + * up of one or more DMA bursts. The DMA burst implementation
> >>>> mechanism is,
> >>>> + * For TX, when the number of words in TXFIFO is less than the pres=
et
> >>>> + * reading threshold, SPICC starts a reading DMA burst, which reads
> >>>> the preset
> >>>> + * number of words from TX buffer, then writes them into TXFIFO.
> >>>> + * For RX, when the number of words in RXFIFO is greater than the
> >>>> preset
> >>>> + * writing threshold, SPICC starts a writing request burst, which
> >>>> reads the
> >>>> + * preset number of words from RXFIFO, then write them into RX buff=
er.
> >>>> + * DMA works if the transfer meets the following conditions,
> >>>> + * - 64 bits per word
> >>>> + * - The transfer length in word must be multiples of the
> >>>> dma_burst_len, and
> >>>> + *   the dma_burst_len should be one of 8,7...2, otherwise, it will
> >>>> be split
> >>>> + *   into several SPI bursts by this driver
> >>>
> >>> Fine, but then also rephrase the previous paragraph since you're
> >>> adding DMA.
> >>>
> >> Will do.
> >>
> >>> Could you precise on which platform you tested the DMA ?
> >>>
> >>
> >> aq222(S4)
> >
> > Will you be able to test on other platforms ?
> >
>
> I tested it on other platforms over the last few days. G12A and C3 and
> T7(T7 CLOCK use local source).
>
> My board SPI does not connect peripherals and is tested through a
> hardware loop.

I can test it on GXL and SM1 in the next two weeks against a SPI
display and some WS2812B LCDs.

> cmd:
> spi_test -D /dev/spidev0.0 -v -s 5000000 -b 64 -l
>
> >>
> >>>>    */
> >>>>
> >>>>   #define SPICC_MAX_BURST     128
> >>>> @@ -128,6 +143,29 @@
> >>>>
> >>>>   #define SPICC_DWADDR        0x24    /* Write Address of DMA */
> >>>>
> >>>> +#define SPICC_LD_CNTL0       0x28
> >>>> +#define VSYNC_IRQ_SRC_SELECT         BIT(0)
> >>>> +#define DMA_EN_SET_BY_VSYNC          BIT(2)
> >>>> +#define XCH_EN_SET_BY_VSYNC          BIT(3)
> >>>> +#define DMA_READ_COUNTER_EN          BIT(4)
> >>>> +#define DMA_WRITE_COUNTER_EN         BIT(5)
> >>>> +#define DMA_RADDR_LOAD_BY_VSYNC              BIT(6)
> >>>> +#define DMA_WADDR_LOAD_BY_VSYNC              BIT(7)
> >>>> +#define DMA_ADDR_LOAD_FROM_LD_ADDR   BIT(8)
> >>>> +
> >>>> +#define SPICC_LD_CNTL1       0x2c
> >>>> +#define DMA_READ_COUNTER             GENMASK(15, 0)
> >>>> +#define DMA_WRITE_COUNTER            GENMASK(31, 16)
> >>>> +#define DMA_BURST_LEN_DEFAULT                8
> >>>> +#define DMA_BURST_COUNT_MAX          0xffff
> >>>> +#define SPI_BURST_LEN_MAX    (DMA_BURST_LEN_DEFAULT *
> >>>> DMA_BURST_COUNT_MAX)
> >>>> +
> >>>> +enum {
> >>>> +     DMA_TRIG_NORMAL =3D 0,
> >>>> +     DMA_TRIG_VSYNC,
> >>>> +     DMA_TRIG_LINE_N,
> >>>
> >>> You're only using DMA_TRIG_NORMAL, what the other 2 values for ?
> >>>
> >>
> >> DMA_TRIG_VSYNC and DMA_TRIG_LINE_N are used by VOUT modules in certain
> >> partial TV SoCs. These DMA triggering methods rely on special signal
> >> lines, and are not supported in this context. I will delete the
> >> corresponding information.
> >>
> >>>
> >>>> +
> >>>>   #define SPICC_ENH_CTL0      0x38    /* Enhanced Feature */
> >>>>   #define SPICC_ENH_CLK_CS_DELAY_MASK GENMASK(15, 0)
> >>>>   #define SPICC_ENH_DATARATE_MASK             GENMASK(23, 16)
> >>>> @@ -171,6 +209,9 @@ struct meson_spicc_device {
> >>>>       struct pinctrl                  *pinctrl;
> >>>>       struct pinctrl_state            *pins_idle_high;
> >>>>       struct pinctrl_state            *pins_idle_low;
> >>>> +     dma_addr_t                      tx_dma;
> >>>> +     dma_addr_t                      rx_dma;
> >>>> +     bool                            using_dma;
> >>>>   };
> >>>>
> >>>>   #define pow2_clk_to_spicc(_div) container_of(_div, struct
> >>>> meson_spicc_device, pow2_div)
> >>>> @@ -202,6 +243,155 @@ static void meson_spicc_oen_enable(struct
> >>>> meson_spicc_device *spicc)
> >>>>       writel_relaxed(conf, spicc->base + SPICC_ENH_CTL0);
> >>>>   }
> >>>>
> >>>> +static int meson_spicc_dma_map(struct meson_spicc_device *spicc,
> >>>> +                            struct spi_transfer *t)
> >>>> +{
> >>>> +     struct device *dev =3D spicc->host->dev.parent;
> >>>> +
> >>>> +     if (!(t->tx_buf && t->rx_buf))
> >>>> +             return -EINVAL;
> >>>> +
> >>>> +     t->tx_dma =3D dma_map_single(dev, (void *)t->tx_buf, t->len,
> >>>> DMA_TO_DEVICE);
> >>>> +     if (dma_mapping_error(dev, t->tx_dma))
> >>>> +             return -ENOMEM;
> >>>> +
> >>>> +     t->rx_dma =3D dma_map_single(dev, t->rx_buf, t->len,
> >>>> DMA_FROM_DEVICE);
> >>>> +     if (dma_mapping_error(dev, t->rx_dma))
> >>>> +             return -ENOMEM;
> >>>> +
> >>>> +     spicc->tx_dma =3D t->tx_dma;
> >>>> +     spicc->rx_dma =3D t->rx_dma;
> >>>> +
> >>>> +     return 0;
> >>>> +}
> >>>> +
> >>>> +static void meson_spicc_dma_unmap(struct meson_spicc_device *spicc,
> >>>> +                               struct spi_transfer *t)
> >>>> +{
> >>>> +     struct device *dev =3D spicc->host->dev.parent;
> >>>> +
> >>>> +     if (t->tx_dma)
> >>>> +             dma_unmap_single(dev, t->tx_dma, t->len, DMA_TO_DEVICE=
);
> >>>> +     if (t->rx_dma)
> >>>> +             dma_unmap_single(dev, t->rx_dma, t->len,
> >>>> DMA_FROM_DEVICE);
> >>>> +}
> >>>> +
> >>>> +/*
> >>>> + * According to the remain words length, calculate a suitable spi
> >>>> burst length
> >>>> + * and a dma burst length for current spi burst
> >>>> + */
> >>>> +static u32 meson_spicc_calc_dma_len(struct meson_spicc_device *spic=
c,
> >>>> +                                 u32 len, u32 *dma_burst_len)
> >>>> +{
> >>>> +     u32 i;
> >>>> +
> >>>> +     if (len <=3D spicc->data->fifo_size) {
> >>>> +             *dma_burst_len =3D len;
> >>>> +             return len;
> >>>> +     }
> >>>> +
> >>>> +     *dma_burst_len =3D DMA_BURST_LEN_DEFAULT;
> >>>> +
> >>>> +     if (len =3D=3D (SPI_BURST_LEN_MAX + 1))
> >>>> +             return SPI_BURST_LEN_MAX - DMA_BURST_LEN_DEFAULT;
> >>>> +
> >>>> +     if (len >=3D SPI_BURST_LEN_MAX)
> >>>> +             return SPI_BURST_LEN_MAX;
> >>>> +
> >>>> +     for (i =3D DMA_BURST_LEN_DEFAULT; i > 1; i--)
> >>>> +             if ((len % i) =3D=3D 0) {
> >>>> +                     *dma_burst_len =3D i;
> >>>> +                     return len;
> >>>> +             }
> >>>> +
> >>>> +     i =3D len % DMA_BURST_LEN_DEFAULT;
> >>>> +     len -=3D i;
> >>>> +
> >>>> +     if (i =3D=3D 1)
> >>>> +             len -=3D DMA_BURST_LEN_DEFAULT;
> >>>> +
> >>>> +     return len;
> >>>> +}
> >>>> +
> >>>> +static void meson_spicc_setup_dma(struct meson_spicc_device *spicc,
> >>>> u8 trig)
> >>>> +{
> >>>> +     unsigned int len;
> >>>> +     unsigned int dma_burst_len, dma_burst_count;
> >>>> +     unsigned int count_en =3D 0;
> >>>> +     unsigned int txfifo_thres =3D 0;
> >>>> +     unsigned int read_req =3D 0;
> >>>> +     unsigned int rxfifo_thres =3D 31;
> >>>> +     unsigned int write_req =3D 0;
> >>>> +     unsigned int ld_ctr1 =3D 0;
> >>>> +
> >>>> +     writel_relaxed(spicc->tx_dma, spicc->base + SPICC_DRADDR);
> >>>> +     writel_relaxed(spicc->rx_dma, spicc->base + SPICC_DWADDR);
> >>>> +
> >>>> +     /* Set the max burst length to support a transmission with
> >>>> length of
> >>>> +      * no more than 1024 bytes(128 words), which must use the CS
> >>>> management
> >>>> +      * because of some strict timing requirements
> >>>> +      */
> >>>> +     writel_bits_relaxed(SPICC_BURSTLENGTH_MASK,
> >>>> SPICC_BURSTLENGTH_MASK,
> >>>> +                         spicc->base + SPICC_CONREG);
> >>>> +
> >>>> +     len =3D meson_spicc_calc_dma_len(spicc, spicc->xfer_remain,
> >>>> +                                    &dma_burst_len);
> >>>> +     spicc->xfer_remain -=3D len;
> >>>> +     dma_burst_count =3D DIV_ROUND_UP(len, dma_burst_len);
> >>>> +     dma_burst_len--;
> >>>> +
> >>>> +     if (trig =3D=3D DMA_TRIG_LINE_N)
> >>>> +             count_en |=3D VSYNC_IRQ_SRC_SELECT;
> >>>
> >>> Is this the VPU VSYNC irq ? is this a tested and valid usecase ?
> >>>
> >>
> >> Yes, it is VPU VSYNC irq, This part of the code is not completely. NO
> >> tested about it. I will delete it.
> >
> > Thx
> >
> >>
> >>>> +
> >>>> +     if (spicc->tx_dma) {
> >>>> +             spicc->tx_dma +=3D len;
> >>>> +             count_en |=3D DMA_READ_COUNTER_EN;
> >>>> +             if (trig =3D=3D DMA_TRIG_VSYNC || trig =3D=3D DMA_TRIG=
_LINE_N)
> >>>> +                     count_en |=3D DMA_RADDR_LOAD_BY_VSYNC
> >>>> +                                 | DMA_ADDR_LOAD_FROM_LD_ADDR;
> >>>> +             txfifo_thres =3D spicc->data->fifo_size - dma_burst_le=
n;
> >>>> +             read_req =3D dma_burst_len;
> >>>> +             ld_ctr1 |=3D FIELD_PREP(DMA_READ_COUNTER, dma_burst_co=
unt);
> >>>> +     }
> >>>> +
> >>>> +     if (spicc->rx_dma) {
> >>>> +             spicc->rx_dma +=3D len;
> >>>> +             count_en |=3D DMA_WRITE_COUNTER_EN;
> >>>> +             if (trig =3D=3D DMA_TRIG_VSYNC || trig =3D=3D DMA_TRIG=
_LINE_N)
> >>>> +                     count_en |=3D DMA_WADDR_LOAD_BY_VSYNC
> >>>> +                                 | DMA_ADDR_LOAD_FROM_LD_ADDR;
> >>>> +             rxfifo_thres =3D dma_burst_len;
> >>>> +             write_req =3D dma_burst_len;
> >>>> +             ld_ctr1 |=3D FIELD_PREP(DMA_WRITE_COUNTER,
> >>>> dma_burst_count);
> >>>> +     }
> >>>> +
> >>>> +     writel_relaxed(count_en, spicc->base + SPICC_LD_CNTL0);
> >>>> +     writel_relaxed(ld_ctr1, spicc->base + SPICC_LD_CNTL1);
> >>>> +     writel_relaxed(((trig =3D=3D DMA_TRIG_NORMAL) ? SPICC_DMA_ENAB=
LE : 0)
> >>>> +                 | SPICC_DMA_URGENT
> >>>> +                 | FIELD_PREP(SPICC_TXFIFO_THRESHOLD_MASK,
> >>>> txfifo_thres)
> >>>> +                 | FIELD_PREP(SPICC_READ_BURST_MASK, read_req)
> >>>> +                 | FIELD_PREP(SPICC_RXFIFO_THRESHOLD_MASK,
> >>>> rxfifo_thres)
> >>>> +                 | FIELD_PREP(SPICC_WRITE_BURST_MASK, write_req),
> >>>> +                 spicc->base + SPICC_DMAREG);
> >>>> +}
> >>>> +
> >>>> +static void meson_spicc_dma_irq(struct meson_spicc_device *spicc)
> >>>> +{
> >>>> +     if (readl_relaxed(spicc->base + SPICC_DMAREG) & SPICC_DMA_ENAB=
LE)
> >>>> +             return;
> >>>> +
> >>>> +     if (spicc->xfer_remain) {
> >>>> +             meson_spicc_setup_dma(spicc, DMA_TRIG_NORMAL);
> >>>> +     } else {
> >>>> +             writel_bits_relaxed(SPICC_SMC, 0, spicc->base +
> >>>> SPICC_CONREG);
> >>>> +             writel_relaxed(0, spicc->base + SPICC_INTREG);
> >>>> +             writel_relaxed(0, spicc->base + SPICC_DMAREG);
> >>>> +             meson_spicc_dma_unmap(spicc, spicc->xfer);
> >>>> +             complete(&spicc->done);
> >>>> +     }
> >>>> +}
> >>>> +
> >>>>   static inline bool meson_spicc_txfull(struct meson_spicc_device
> >>>> *spicc)
> >>>>   {
> >>>>       return !!FIELD_GET(SPICC_TF,
> >>>> @@ -293,6 +483,11 @@ static irqreturn_t meson_spicc_irq(int irq,
> >>>> void *data)
> >>>>
> >>>>       writel_bits_relaxed(SPICC_TC, SPICC_TC, spicc->base +
> >>>> SPICC_STATREG);
> >>>>
> >>>> +     if (spicc->using_dma) {
> >>>> +             meson_spicc_dma_irq(spicc);
> >>>> +             return IRQ_HANDLED;
> >>>> +     }
> >>>
> >>> Make meson_spicc_dma_irq() return irqreturn_t and return IRQ_HANDLED.
> >>>
> >>
> >> Will do.
> >>
> >>>> +
> >>>>       /* Empty RX FIFO */
> >>>>       meson_spicc_rx(spicc);
> >>>>
> >>>> @@ -426,9 +621,6 @@ static int meson_spicc_transfer_one(struct
> >>>> spi_controller *host,
> >>>>
> >>>>       meson_spicc_reset_fifo(spicc);
> >>>>
> >>>> -     /* Setup burst */
> >>>> -     meson_spicc_setup_burst(spicc);
> >>>> -
> >>>>       /* Setup wait for completion */
> >>>>       reinit_completion(&spicc->done);
> >>>>
> >>>> @@ -442,11 +634,40 @@ static int meson_spicc_transfer_one(struct
> >>>> spi_controller *host,
> >>>>       /* Increase it twice and add 200 ms tolerance */
> >>>>       timeout +=3D timeout + 200;
> >>>>
> >>>> -     /* Start burst */
> >>>> -     writel_bits_relaxed(SPICC_XCH, SPICC_XCH, spicc->base +
> >>>> SPICC_CONREG);
> >>>> +     if (xfer->bits_per_word =3D=3D 64) {
> >>>> +             int ret;
> >>>>
> >>>> -     /* Enable interrupts */
> >>>> -     writel_relaxed(SPICC_TC_EN, spicc->base + SPICC_INTREG);
> >>>> +             /* must tx */
> >>>> +             if (!xfer->tx_buf)
> >>>> +                     return -EINVAL;
> >>>> +
> >>>> +             /* dma_burst_len 1 can't trigger a dma burst */
> >>>> +             if (xfer->len < 16)
> >>>> +                     return -EINVAL;
> >>>
> >>> Those 2 checks should be done to enable the DMA mode, you should
> >>> fallback to FIFO mode
> >>> instead of returning EINVAL, except if 64 bits_per_word is only valid
> >>> in DMA mode ?
> >>>
> >>
> >> I only support DMA when bits_per_word equals 64, because the register
> >> operation is more complicated if use PIO module. The register is 32
> >> bits wide, a word needs to be written twice to the register.
> >
> > OK then leave it as-is
> >
> >>
> >>>> +
> >>>> +             ret =3D meson_spicc_dma_map(spicc, xfer);
> >>>> +             if (ret) {
> >>>> +                     meson_spicc_dma_unmap(spicc, xfer);
> >>>> +                     dev_err(host->dev.parent, "dma map failed\n");
> >>>> +                     return ret;
> >>>> +             }
> >>>> +
> >>>> +             spicc->using_dma =3D true;
> >>>> +             spicc->xfer_remain =3D DIV_ROUND_UP(xfer->len,
> >>>> spicc->bytes_per_word);
> >>>> +             meson_spicc_setup_dma(spicc, DMA_TRIG_NORMAL);
> >>>> +             writel_relaxed(SPICC_TE_EN, spicc->base + SPICC_INTREG=
);
> >>>> +             writel_bits_relaxed(SPICC_SMC, SPICC_SMC, spicc->base
> >>>> + SPICC_CONREG);
> >>>> +     } else {
> >>>> +             spicc->using_dma =3D false;
> >>>> +             /* Setup burst */
> >>>> +             meson_spicc_setup_burst(spicc);
> >>>> +
> >>>> +             /* Start burst */
> >>>> +             writel_bits_relaxed(SPICC_XCH, SPICC_XCH, spicc->base
> >>>> + SPICC_CONREG);
> >>>> +
> >>>> +             /* Enable interrupts */
> >>>> +             writel_relaxed(SPICC_TC_EN, spicc->base + SPICC_INTREG=
);
> >>>> +     }
> >>>>
> >>>>       if (!wait_for_completion_timeout(&spicc->done,
> >>>> msecs_to_jiffies(timeout)))
> >>>>               return -ETIMEDOUT;
> >>>> @@ -853,10 +1074,10 @@ static int meson_spicc_probe(struct
> >>>> platform_device *pdev)
> >>>>       host->num_chipselect =3D 4;
> >>>>       host->dev.of_node =3D pdev->dev.of_node;
> >>>>       host->mode_bits =3D SPI_CPHA | SPI_CPOL | SPI_CS_HIGH | SPI_LO=
OP;
> >>>> -     host->bits_per_word_mask =3D SPI_BPW_MASK(32) |
> >>>> -                                SPI_BPW_MASK(24) |
> >>>> -                                SPI_BPW_MASK(16) |
> >>>> -                                SPI_BPW_MASK(8);
> >>>> +     /* DMA works at 64 bits, but it is invalidated by the spi core=
,
> >>>> +      * clr the mask to avoid the spi core validation check
> >>>> +      */
> >>>> +     host->bits_per_word_mask =3D 0;
> >>>
> >>> Fine, instead please add a check in meson_spicc_setup() to make sure
> >>> we operate only in 8, 16, 24, 32 & 64 bits_per_word.
> >>>
> >>> So not need to clear it, the host buffer was allocated with
> >>> spi_alloc_host() which
> >>> allocates with kzalloc(), already zeroing the allocated memory.
> >>>
> >>
> >> Will drop this line, and check bits_per_word in meson_spicc_setup.
> >
> > Thanks,
> > Neil
> >
> >>
> >>> Neil
> >>>
> >>>>       host->flags =3D (SPI_CONTROLLER_MUST_RX | SPI_CONTROLLER_MUST_=
TX);
> >>>>       host->min_speed_hz =3D spicc->data->min_speed_hz;
> >>>>       host->max_speed_hz =3D spicc->data->max_speed_hz;
> >>>>
> >>>> ---
> >>>> base-commit: 49807ed87851916ef655f72e9562f96355183090
> >>>> change-id: 20250408-spi-dma-c499f560d295
> >>>>
> >>>> Best regards,
> >>>
> >>> With those fixed, the path is clear & clean, thanks !
> >>>
> >>> Neil
> >
>
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic

