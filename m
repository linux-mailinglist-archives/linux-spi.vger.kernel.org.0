Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C32542B1A04
	for <lists+linux-spi@lfdr.de>; Fri, 13 Nov 2020 12:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgKML01 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 13 Nov 2020 06:26:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbgKML0U (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 13 Nov 2020 06:26:20 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9E6C0613D1;
        Fri, 13 Nov 2020 03:26:20 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id o24so10238338ljj.6;
        Fri, 13 Nov 2020 03:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d9BtORohRQssqcZEmJuQti+AVje2Xav6yhqEjMh69G8=;
        b=fBeRvct2Z3dYw0c28ajh8qJJqmJDD8V4Cmf/d8MKaLD0FKcR4TWPdlWJtkhJQSsJDp
         AQi9JyDFeadS5klwC+/Q6MhMT7xSItw8MRYQe0CgVPDIo8/l4X7Ig9CPZK8sYZF3R5Q0
         Kx98CLaXIq132Y0ZVSNdbLpNuuiMmwMyM/Oz1dbfXXYsgi/7zaTPqixfEE9VQcM3hqiT
         kn/qQr0tr7pTgc7QE0Nwst++n5P5Dqw5gTSnizv2n3GhzYVYddBTL3otcmBOBvYZ9BUT
         g5r/x+CZDWr9EKqoa/MTZ+5YDDMvm95UwJmZupuY2uNVkMiQ0NI2BOHjNJwagqoQbi0x
         qTKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d9BtORohRQssqcZEmJuQti+AVje2Xav6yhqEjMh69G8=;
        b=CkjAZACT03NfPGKubLqro+ftrD7UuFR7EKSkR+tZY8/GK+YCsvVGp8Kkjz+pODlGGs
         D4XENAd2gOXoWZGRKaWS3NSy9/kafbOxsjRhk3a7+ftTzKUR5uMsSltPkGGo9khgrV1s
         rNmJFWbRy5GLpJLuBgiYLuiWuZWYjtksQD06QudgB8Xz3+hw/TbMpDMHYnPQXCEkekrX
         hSkdRp6IDG7edAmYK9ovVKJKw3y30TKKfefIIu7H0Tc0Z3jJu1Rc8YIIl+twlugUztN/
         3A9qWyUHoBidF7wzbaDHzHu+N5GpFwxSblbzKDO8q7yEikznRm1mYT9SxV/i9yQvzaUs
         veaA==
X-Gm-Message-State: AOAM5314Vz/zTBpsyh3VsiifytYsQV+hhUNgA39F3elWNHf77bE2/zmW
        F+vAL1z/8HrYyTUV0qQskl0ioK5PnJskURQTbM4=
X-Google-Smtp-Source: ABdhPJwW4VYqcQoCtpQGzUMhORhViySVIWN5LwCEoWVfoD9h1YxmV8VyWB+4ahuA3xAuU0uzIpNgu5k6KFJaqDqDhms=
X-Received: by 2002:a2e:8682:: with SMTP id l2mr801866lji.218.1605266778484;
 Fri, 13 Nov 2020 03:26:18 -0800 (PST)
MIME-Version: 1.0
References: <20200727063354.17031-1-xiaoning.wang@nxp.com> <20201113091800.27469-1-nikita.shubin@maquefel.me>
In-Reply-To: <20201113091800.27469-1-nikita.shubin@maquefel.me>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 13 Nov 2020 08:26:07 -0300
Message-ID: <CAOMZO5AVJjhqEvkiB3mXc24RNy+Ac3VW_CTg6BGNsqfSVLq0Sg@mail.gmail.com>
Subject: Re: [PATCH] spi: imx: enable runtime pm support
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Clark Wang <xiaoning.wang@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Nikita,

On Fri, Nov 13, 2020 at 6:18 AM Nikita Shubin <nikita.shubin@maquefel.me> wrote:
>
> Hello Clark,
>
> This patch breaks spi-imx on imx7d.
> Toradex Colibri imx7d spi reports with:
>
>     [    4.258468] inv-mpu6000-spi spi2.0: I/O Error in PIO
>     [    4.264269] inv-mpu6000-spi spi2.0: SPI transfer failed: -110
>     [    4.264305] spi_master spi2: failed to transfer one message from queue
>
> We are using spi-imx with dma.
>
> Reverting your patch fixes this issue.
>
> The baseline commit 951cbbc386ff01b50da4f46387e994e81d9ab431 (tag: v5.9.8, stable/linux-5.9.y)
>
> Could you please give some comments on this issue ?

Could you please try this patch from Sascha?
https://lkml.org/lkml/2020/10/12/981
