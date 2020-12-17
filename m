Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15AE12DD27D
	for <lists+linux-spi@lfdr.de>; Thu, 17 Dec 2020 14:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbgLQN5J (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 17 Dec 2020 08:57:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgLQN5J (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 17 Dec 2020 08:57:09 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDBAFC061794
        for <linux-spi@vger.kernel.org>; Thu, 17 Dec 2020 05:56:28 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id d11so13285460qvo.11
        for <linux-spi@vger.kernel.org>; Thu, 17 Dec 2020 05:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xPt9ndUPLWdKnPREGGrnhLGFSj0/IvKW6TbYWxdqNWA=;
        b=fLk4XCXVauRe2GWRUOB2aVcwzGoK07QIVYHWPgIjXOWg4JsdQGVLNDvJLI8Pu+zRti
         Ic9Z6j5lrCvy+Mh91JRMr8+9FmtzCj6wT8pNB9qpenc9Fkb5zEq/uI9LKPkWYQ7hZM4t
         4izsHcKGiDYqiyuObRlyw+ExUPnpt/5gwACAfTu4WEhVC/Gp++cGtBUXdSZONCxS9ahD
         Q7aIXv4a/ipmRtjiXvI/DezBACBOMVoqsO4Tb5CCARxZGo9nBqNdUuqZZc5dYIhFnJxw
         U/JU0J3yvzYKB5TKY0MK2//JMuUPOIJ5ushgE+udQbnVu1uVxuTcABqgNA2o0Hsj+qGs
         HeCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xPt9ndUPLWdKnPREGGrnhLGFSj0/IvKW6TbYWxdqNWA=;
        b=qvB3JrZJln2Yz6o8KXCnpg+BjzZ8/cHC7FuRx6+7JpSq2Nr5Y8abtsTkb2pa8dvmLe
         LH15jHHnhlAmoXUTUO051xtwUdVCkQT8SIVPV33ahD/hYx4Hmv1jZhzsX0QoImJFYC0Y
         Zk1TaYEcH9sA59PSuw8Yzt6AcGO49UT3933OKM9a1FePRruxufxSJ8tP1ZJzPbQbF8YK
         lYSvyMuFSeZ5CE/47h4gdBt5mWgt5opfcxaaXyL+RLluk9LCbSeOeuRLK9NhZhKDWQSw
         zZuEC9fz7GdxuXzCTZOIWBExOWbWWjzm+XziqbuQYi1U+db+Gax6EyEXb24alLPgQC72
         9oXQ==
X-Gm-Message-State: AOAM5314JXIC2lY3eRwTWSwwsE69ctsy08fOgGrXCpQbsw41yHd20+uu
        K9DUSwRNkOyv+YreEGhVPBCCoM6lJBARgKPPGJypRg==
X-Google-Smtp-Source: ABdhPJxQ+Ke75x89YHbVzH3k7uvsogqRmnnUGmNyZ7ovk2xwUs23CfSsQpWlEQ2nl7IdAzL0S7ggcIr2al0mgsePgRI=
X-Received: by 2002:a05:6214:14ae:: with SMTP id bo14mr48320969qvb.16.1608213387949;
 Thu, 17 Dec 2020 05:56:27 -0800 (PST)
MIME-Version: 1.0
References: <20201217112708.3473-1-kostap@marvell.com> <20201217112708.3473-3-kostap@marvell.com>
In-Reply-To: <20201217112708.3473-3-kostap@marvell.com>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Thu, 17 Dec 2020 14:56:16 +0100
Message-ID: <CAPv3WKdRM_=t8Rn8LkRWTV2+WGQ3biStjmGXwfQD0z9yKR19jA@mail.gmail.com>
Subject: Re: [PATCH 2/3] spi: orion: enable support for switching CS every
 transferred byte
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi <linux-spi@vger.kernel.org>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Grzegorz Jaszczyk <jaz@semihalf.com>, nadavh@marvell.com,
        =?UTF-8?B?QmVuIFBlbGVkICjXkdefINek15zXkyk=?= <bpeled@marvell.com>,
        Stefan Chulski <stefanc@marvell.com>,
        Konstantin Porotchkin <kostap@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark,

czw., 17 gru 2020 o 12:27 <kostap@marvell.com> napisa=C5=82(a):
>
> From: Marcin Wojtas <mw@semihalf.com>
>
> Some SPI devices, such as SLIC (Subscriber Line Interface Card)
> require toggling the CS every transferred byte. Enable such
> possibility by creating a new DT property and enabling SPI
> device mode update. Add according support in the spi-orion driver.
>
> Signed-off-by: Marcin Wojtas <mw@semihalf.com>
> Signed-off-by: Konstantin Porotchkin <kostap@marvell.com>
> ---
>  drivers/spi/spi-orion.c | 20 +++++++++++++++++++-
>  drivers/spi/spi.c       |  6 ++++--
>  include/linux/spi/spi.h |  1 +
>  3 files changed, 24 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
> index 3bfda4225d45..7db9034b0879 100644
> --- a/drivers/spi/spi-orion.c
> +++ b/drivers/spi/spi-orion.c
> @@ -369,8 +369,15 @@ orion_spi_write_read_8bit(struct spi_device *spi,
>  {
>         void __iomem *tx_reg, *rx_reg, *int_reg;
>         struct orion_spi *orion_spi;
> +       bool cs_single_byte;
> +
> +       cs_single_byte =3D spi->mode & SPI_1BYTE_CS;
>
>         orion_spi =3D spi_master_get_devdata(spi->master);
> +
> +       if (cs_single_byte)
> +               orion_spi_set_cs(spi, 0);
> +
>         tx_reg =3D spi_reg(orion_spi, ORION_SPI_DATA_OUT_REG);
>         rx_reg =3D spi_reg(orion_spi, ORION_SPI_DATA_IN_REG);
>         int_reg =3D spi_reg(orion_spi, ORION_SPI_INT_CAUSE_REG);
> @@ -384,6 +391,11 @@ orion_spi_write_read_8bit(struct spi_device *spi,
>                 writel(0, tx_reg);
>
>         if (orion_spi_wait_till_ready(orion_spi) < 0) {
> +               if (cs_single_byte) {
> +                       orion_spi_set_cs(spi, 1);
> +                       /* Satisfy some SLIC devices requirements */
> +                       udelay(4);
> +               }
>                 dev_err(&spi->dev, "TXS timed out\n");
>                 return -1;
>         }
> @@ -391,6 +403,12 @@ orion_spi_write_read_8bit(struct spi_device *spi,
>         if (rx_buf && *rx_buf)
>                 *(*rx_buf)++ =3D readl(rx_reg);
>
> +       if (cs_single_byte) {
> +               orion_spi_set_cs(spi, 1);
> +               /* Satisfy some SLIC devices requirements */
> +               udelay(4);
> +       }
> +
>         return 1;
>  }
>
> @@ -626,7 +644,7 @@ static int orion_spi_probe(struct platform_device *pd=
ev)
>         }
>
>         /* we support all 4 SPI modes and LSB first option */
> -       master->mode_bits =3D SPI_CPHA | SPI_CPOL | SPI_LSB_FIRST;
> +       master->mode_bits =3D SPI_CPHA | SPI_CPOL | SPI_LSB_FIRST | SPI_1=
BYTE_CS;
>         master->set_cs =3D orion_spi_set_cs;
>         master->transfer_one =3D orion_spi_transfer_one;
>         master->num_chipselect =3D ORION_NUM_CHIPSELECTS;
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 51d7c004fbab..998579807a04 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -1937,6 +1937,8 @@ static int of_spi_parse_dt(struct spi_controller *c=
tlr, struct spi_device *spi,
>                 spi->mode |=3D SPI_LSB_FIRST;
>         if (of_property_read_bool(nc, "spi-cs-high"))
>                 spi->mode |=3D SPI_CS_HIGH;
> +       if (of_find_property(nc, "spi-1byte-cs", NULL))
> +               spi->mode |=3D SPI_1BYTE_CS;

Regarding your comment from patch 3/3 that "spi-1byte-cs" should be
replaced by handling based on the compatible string - do you mean
dropping above parsing and updating SPI bus mode field with
SPI_1BYTE_CS flag in the relevant SPI device driver?

Best regards,
Marcin

>
>         /* Device DUAL/QUAD mode */
>         if (!of_property_read_u32(nc, "spi-tx-bus-width", &value)) {
> @@ -3419,15 +3421,15 @@ int spi_setup(struct spi_device *spi)
>                 spi_set_thread_rt(spi->controller);
>         }
>
> -       dev_dbg(&spi->dev, "setup mode %d, %s%s%s%s%u bits/w, %u Hz max -=
-> %d\n",
> +       dev_dbg(&spi->dev, "setup mode %d, %s%s%s%s%s%u bits/w, %u Hz max=
 --> %d\n",
>                         (int) (spi->mode & (SPI_CPOL | SPI_CPHA)),
>                         (spi->mode & SPI_CS_HIGH) ? "cs_high, " : "",
>                         (spi->mode & SPI_LSB_FIRST) ? "lsb, " : "",
>                         (spi->mode & SPI_3WIRE) ? "3wire, " : "",
>                         (spi->mode & SPI_LOOP) ? "loopback, " : "",
> +                       (spi->mode & SPI_1BYTE_CS) ? "single_cs_byte, " :=
 "",
>                         spi->bits_per_word, spi->max_speed_hz,
>                         status);
> -
>         return status;
>  }
>  EXPORT_SYMBOL_GPL(spi_setup);
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index aa09fdc8042d..7f65ff6fc25d 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -186,6 +186,7 @@ struct spi_device {
>  #define        SPI_TX_OCTAL    0x2000                  /* transmit with =
8 wires */
>  #define        SPI_RX_OCTAL    0x4000                  /* receive with 8=
 wires */
>  #define        SPI_3WIRE_HIZ   0x8000                  /* high impedance=
 turnaround */
> +#define        SPI_1BYTE_CS    0x10000                 /* toggle cs afte=
r each byte */
>         int                     irq;
>         void                    *controller_state;
>         void                    *controller_data;
> --
> 2.17.1
>
