Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70ABF2654E4
	for <lists+linux-spi@lfdr.de>; Fri, 11 Sep 2020 00:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725379AbgIJWPw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 10 Sep 2020 18:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbgIJWPu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 10 Sep 2020 18:15:50 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B113FC061573
        for <linux-spi@vger.kernel.org>; Thu, 10 Sep 2020 15:15:49 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id c18so9036457wrm.9
        for <linux-spi@vger.kernel.org>; Thu, 10 Sep 2020 15:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xL46EKHdUAe28O/xpV5/mdAjbLeGwABswJE/jPWXDpU=;
        b=gkuqVsTizd3Iy1tD9bOeuDijPrrHbfVSg97mseZZ9jCGb3z9klNUQzdHOwbj06Xtvi
         7oioRJHtOQRBXt0846A/AAip9hWl88KWda5HQQ2SdiZsSN933ILMfumdrXs2ieSDDF+V
         gNv8iV1+KPbpsiIV0Y1jhYErQKH/Xxh8FdgkM2K68RIg3hDUEQdAJy9kKRkSFCtim7K7
         vOo2XJ16YYD6Ms3tkcid+L+yZbaln0nTlSvnci9k0B/p7ojj5d7HAzRNssZUczlebZBz
         VT5lOTLZ4bWMT2AnQqVj1qREwNzHTojWY3gIhXFQtT8gIEAGCt/3cy40PPda8TuOEvFW
         kdrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xL46EKHdUAe28O/xpV5/mdAjbLeGwABswJE/jPWXDpU=;
        b=C4jBByfHdj1EmJ7vwOvk/utbcwViufkF1rEXca8mtZ9tgMM0H4sncZMqCRZeprabjl
         yORUvCZB5X58tJldRph9Gi1tM/Wzu6Yv/wVHnYAAruh3H++aRAN04lDWe4QQevqh8EXX
         34+4x56TSyJdQmCzBoEiQ4b9PaCvdHxTYsseUyI5kXVugvGr3N6DemrbpGp6JZ0wgljb
         M1uTvbQLqH+5DksGvnRN5MWdvehui+nRbgi50Oetzs8wk4A5QeM1o8BrFoLYNnTftOH5
         un+otBZVxiGbCj4usubunb0u2IrMsXAz6XXONJKUFBhYzggLRtvk69nHTf/QfHC42Wx5
         110A==
X-Gm-Message-State: AOAM530U8wU7yTFc8hqxAkygklPXa1uZFrnBTq+BivWB1yMf0tXvBHdr
        t2/X6rc5b1bg1uOQ9NwRoDKSn51V6h5bHVcRwOI=
X-Google-Smtp-Source: ABdhPJwTVP6cjq4eEIv/cwbf/GNJtz0o80yCatHKXmdR3M24trCTRDY7nMTwOP9CrE/Uu79wbMfda7NhwyV+PYG3PNs=
X-Received: by 2002:a5d:4d82:: with SMTP id b2mr10782749wru.232.1599776148263;
 Thu, 10 Sep 2020 15:15:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200908072400.GB294938@mwanda>
In-Reply-To: <20200908072400.GB294938@mwanda>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Thu, 10 Sep 2020 15:15:36 -0700
Message-ID: <CAHQ1cqGeFPbaucoDDjJFJLpKUDkfnQiCCfBbcS61b3GeXy2a2g@mail.gmail.com>
Subject: Re: [bug report] spi: gpio: Use devm_spi_register_master()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Sep 8, 2020 at 12:24 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> Hello Andrey Smirnov,
>
> The patch 79567c1a321e: "spi: gpio: Use devm_spi_register_master()"
> from Apr 2, 2019, leads to the following static checker warning:
>
>         drivers/spi/spi-gpio.c:435 spi_gpio_probe()
>         warn: 'master->dev.kobj' not decremented on lines: 435.
>
> drivers/spi/spi-gpio.c
>    358  static int spi_gpio_probe(struct platform_device *pdev)
>    359  {
>    360          int                             status;
>    361          struct spi_master               *master;
>    362          struct spi_gpio                 *spi_gpio;
>    363          struct device                   *dev = &pdev->dev;
>    364          struct spi_bitbang              *bb;
>    365
>    366          master = spi_alloc_master(dev, sizeof(*spi_gpio));
>    367          if (!master)
>    368                  return -ENOMEM;
>    369
>    370          status = devm_add_action_or_reset(&pdev->dev, spi_gpio_put, master);
>    371          if (status) {
>    372                  spi_master_put(master);
>                         ^^^^^^^^^^^^^^^^^^^^^^
> The devm_add_action_or_reset() function calls spi_gpio_put() on error
> so this seems like a double free.
>

This does look like a double free. Can't comment on the logic behind
it, that's a change Navid made, so I'll let him speak for it.


>    373                  return status;
>    374          }
>    375
>    376          if (pdev->dev.of_node)
>    377                  status = spi_gpio_probe_dt(pdev, master);
>    378          else
>    379                  status = spi_gpio_probe_pdata(pdev, master);
>    380
>    381          if (status)
>    382                  return status;
>    383
>    384          spi_gpio = spi_master_get_devdata(master);
>    385
>    386          status = spi_gpio_request(dev, spi_gpio);
>    387          if (status)
>    388                  return status;
>    389
>    390          master->bits_per_word_mask = SPI_BPW_RANGE_MASK(1, 32);
>    391          master->mode_bits = SPI_3WIRE | SPI_3WIRE_HIZ | SPI_CPHA | SPI_CPOL |
>    392                              SPI_CS_HIGH;
>    393          if (!spi_gpio->mosi) {
>    394                  /* HW configuration without MOSI pin
>    395                   *
>    396                   * No setting SPI_MASTER_NO_RX here - if there is only
>    397                   * a MOSI pin connected the host can still do RX by
>    398                   * changing the direction of the line.
>    399                   */
>    400                  master->flags = SPI_MASTER_NO_TX;
>    401          }
>    402
>    403          master->bus_num = pdev->id;
>    404          master->setup = spi_gpio_setup;
>    405          master->cleanup = spi_gpio_cleanup;
>    406
>    407          bb = &spi_gpio->bitbang;
>    408          bb->master = master;
>    409          /*
>    410           * There is some additional business, apart from driving the CS GPIO
>    411           * line, that we need to do on selection. This makes the local
>    412           * callback for chipselect always get called.
>    413           */
>    414          master->flags |= SPI_MASTER_GPIO_SS;
>    415          bb->chipselect = spi_gpio_chipselect;
>    416          bb->set_line_direction = spi_gpio_set_direction;
>    417
>    418          if (master->flags & SPI_MASTER_NO_TX) {
>    419                  bb->txrx_word[SPI_MODE_0] = spi_gpio_spec_txrx_word_mode0;
>    420                  bb->txrx_word[SPI_MODE_1] = spi_gpio_spec_txrx_word_mode1;
>    421                  bb->txrx_word[SPI_MODE_2] = spi_gpio_spec_txrx_word_mode2;
>    422                  bb->txrx_word[SPI_MODE_3] = spi_gpio_spec_txrx_word_mode3;
>    423          } else {
>    424                  bb->txrx_word[SPI_MODE_0] = spi_gpio_txrx_word_mode0;
>    425                  bb->txrx_word[SPI_MODE_1] = spi_gpio_txrx_word_mode1;
>    426                  bb->txrx_word[SPI_MODE_2] = spi_gpio_txrx_word_mode2;
>    427                  bb->txrx_word[SPI_MODE_3] = spi_gpio_txrx_word_mode3;
>    428          }
>    429          bb->setup_transfer = spi_bitbang_setup_transfer;
>    430
>    431          status = spi_bitbang_init(&spi_gpio->bitbang);
>    432          if (status)
>    433                  return status;
>    434
>    435          return devm_spi_register_master(&pdev->dev, spi_master_get(master));
>                                                             ^^^^^^^^^^^^^^^^^^^^^^
> Why are we taking a second reference here?  Where will it be released?
>

This additional reference taking came from inlining of the code from
spi_bitbang_start():
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/spi/spi-bitbang.c?h=v5.9-rc4#n405

and the logic behind reference taking seems to have come from this
change: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers?h=v5.9-rc4&id=702a4879ec337463f858c8ab467482cce260bf18

Release should happen once devres action registered by

>    370          status = devm_add_action_or_reset(&pdev->dev, spi_gpio_put, master);

is executed upon devres "unwinding", see
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers?h=v5.9-rc4&id=8b797490b4db09492acda4b4a4a4355d2311a614

At least I think that what my thinking was for making that change.
