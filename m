Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11C556CD4CB
	for <lists+linux-spi@lfdr.de>; Wed, 29 Mar 2023 10:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjC2Ihb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 29 Mar 2023 04:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjC2Ih3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 29 Mar 2023 04:37:29 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0F84696
        for <linux-spi@vger.kernel.org>; Wed, 29 Mar 2023 01:37:17 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-545cb3c9898so205077927b3.7
        for <linux-spi@vger.kernel.org>; Wed, 29 Mar 2023 01:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680079036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fEEjt5KTOiMxdxcRezWpGMm6v+AEsQGVPozQ3NTxWGQ=;
        b=RyxRU52zrMaY1+rCiw2RsrCGt9/viM3/l3sfw4JQCjh/8bpNfF7lm5FztCSqWhgmdf
         ssDYQ6iDt8NQablYueMCScBaQNhiokwb0JUI/pUrlXqHvMXCupxNmWWheju/N6FIvc/P
         HTbInlTEaEK9sK04pzgm1v5UnAqcTGRl7sAr45kkgbFRRvwvsqEnzSyb0A6K9b3q6dKr
         R/EjzL7WFDTFJv47uBKGwjutYgjEQptSHSmDXIeuDeoqdQXPsE1L5NVsYJX1vvf0/qBm
         hq8CvAowe7oUE6hVym2BqUo35uDTr+VJ99EVE8AoaIE2TYRC/aNHoX/W6jcj/M0Uqm0Y
         wQlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680079036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fEEjt5KTOiMxdxcRezWpGMm6v+AEsQGVPozQ3NTxWGQ=;
        b=yJqwG5/MkjWjvhikvcfIjiFUkxjJsK0PUeJ0HQ/p0x+S3XVl/ehAzzfoVyqCpdfjRM
         ud9/8E0kNmhm2X0OvaY0ZLKXwKGCUQsZUe+uhyz5gKjKhtKG9c9Tx5+rrSWuzRvsk0QI
         xuDT2iBBD3crJxYpnLiO19V7onwCccsL8NZPq4i48oBzNhha4WsmMhr7FNNxr5VhFv3y
         eCwh4788T/xj9G5OyaWIXnkQx9mT/qoVfPvAsxBEI4GD/J4iksPS3ZzjY/9tGuiFY+bx
         ZpqYVS9hWhD3bfG+aSb8iEpdArij2+D6XuNHQP/O70FDGAjl4pNkRF3FHrFD3Pjx2nE3
         uKvQ==
X-Gm-Message-State: AAQBX9cHFf93IhOYT5nfhuL0XQGVQ6kk8jaDSL+XstL69+sKaM3BHAT9
        3PynbPQUeQghbXQxhQD+l8y49w9GcrY/p8ie9SVNHw==
X-Google-Smtp-Source: AKy350bwKhACZ5LjWDNs8HRhrB7fLtOYZiPiILPtu5+aF4SvdFnw0KrxlhqAmKxWV8fUa8xzRfUKXoUyKG2s33koCf8=
X-Received: by 2002:a81:eb02:0:b0:545:883a:544d with SMTP id
 n2-20020a81eb02000000b00545883a544dmr9195077ywm.9.1680079036640; Wed, 29 Mar
 2023 01:37:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230325154711.2419569-1-xiang.ye@intel.com> <20230325154711.2419569-5-xiang.ye@intel.com>
In-Reply-To: <20230325154711.2419569-5-xiang.ye@intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 29 Mar 2023 10:37:05 +0200
Message-ID: <CACRpkdbDmPpKFVxmn1ntKJWr5_mraKuafuTgJtgBU+39PxEYgg@mail.gmail.com>
Subject: Re: [PATCH v7 4/6] gpio: Add support for Intel LJCA USB GPIO driver
To:     Ye Xiang <xiang.ye@intel.com>, Marc Zyngier <maz@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Matthias Kaehlcke <mka@chromium.org>,
        Lee Jones <lee@kernel.org>, Wolfram Sang <wsa@kernel.org>,
        Tyrone Ting <kfting@nuvoton.com>,
        Mark Brown <broonie@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-usb@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-gpio@vger.kernel.org,
        srinivas.pandruvada@intel.com, heikki.krogerus@linux.intel.com,
        andriy.shevchenko@linux.intel.com, sakari.ailus@linux.intel.com,
        zhifeng.wang@intel.com, wentong.wu@intel.com, lixu.zhang@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Ye,

thanks for your patch!

On Sat, Mar 25, 2023 at 4:48=E2=80=AFPM Ye Xiang <xiang.ye@intel.com> wrote=
:

> This patch implements the GPIO function of Intel USB-I2C/GPIO/SPI adapter
> device named "La Jolla Cove Adapter" (LJCA). It communicate with LJCA
> GPIO module with specific protocol through interfaces exported by LJCA US=
B
> driver.
>
> Signed-off-by: Ye Xiang <xiang.ye@intel.com>

Lots of improvements! here are some comments:

> @@ -1253,6 +1253,18 @@ config GPIO_KEMPLD
>           This driver can also be built as a module. If so, the module wi=
ll be
>           called gpio-kempld.
>
> +config GPIO_LJCA
> +       tristate "INTEL La Jolla Cove Adapter GPIO support"
> +       depends on USB_LJCA
> +       select GPIOLIB_IRQCHIP
> +       default USB_LJCA
> +       help
> +         Select this option to enable GPIO driver for the INTEL
> +         La Jolla Cove Adapter (LJCA) board.
> +
> +         This driver can also be built as a module. If so, the module
> +         will be called gpio-ljca.

The GPIO Kconfig has a separate submenu for USB expanders, so
put this Kconfig in that submenu. This makes the choice come in
a more logical spot and not appear on configs that don't even
have USB.

(...)
> +       DECLARE_BITMAP(unmasked_irqs, LJCA_MAX_GPIO_NUM);
> +       DECLARE_BITMAP(enabled_irqs, LJCA_MAX_GPIO_NUM);
> +       DECLARE_BITMAP(reenable_irqs, LJCA_MAX_GPIO_NUM);
> +       u8 *connect_mode;
> +       /* mutex to protect irq bus */
> +       struct mutex irq_lock;
(...)

With IRQ code like this from a USB callback:

> +static void ljca_gpio_event_cb(void *context, u8 cmd, const void *evt_da=
ta, int len)
> +{
> +       const struct gpio_packet *packet =3D evt_data;
> +       struct ljca_gpio_dev *ljca_gpio =3D context;
> +       int i;
> +       int irq;
> +
> +       if (cmd !=3D LJCA_GPIO_INT_EVENT)
> +               return;
> +
> +       for (i =3D 0; i < packet->num; i++) {
> +               irq =3D irq_find_mapping(ljca_gpio->gc.irq.domain, packet=
->item[i].index);
> +               if (!irq) {
> +                       dev_err(ljca_gpio->gc.parent, "gpio_id %u does no=
t mapped to IRQ yet\n",
> +                               packet->item[i].index);
> +                       return;
> +               }
> +
> +               generic_handle_domain_irq(ljca_gpio->gc.irq.domain, irq);
> +               set_bit(packet->item[i].index, ljca_gpio->reenable_irqs);
> +       }
> +
> +       schedule_work(&ljca_gpio->work);
> +}

I don't feel comfortable merging this unless Marc Zyngier has looked at the
code first, so please CC him on this patch next time.

> +static const struct irq_chip ljca_gpio_irqchip =3D {
> +       .name =3D "ljca-irq",
> +       .irq_mask =3D ljca_irq_mask,
> +       .irq_unmask =3D ljca_irq_unmask,
> +       .irq_set_type =3D ljca_irq_set_type,
> +       .irq_bus_lock =3D ljca_irq_bus_lock,
> +       .irq_bus_sync_unlock =3D ljca_irq_bus_unlock,
> +       .flags =3D IRQCHIP_IMMUTABLE,
> +       GPIOCHIP_IRQ_RESOURCE_HELPERS,
> +};

Thanks for fixing the immutable irq chip!

> +       ljca_gpio->auxdev =3D auxdev;
> +       ljca_gpio->gc.direction_input =3D ljca_gpio_direction_input;
> +       ljca_gpio->gc.direction_output =3D ljca_gpio_direction_output;

Can you implement .get_direction()?

It's scanned on probe to determine the initial state of each
line so it is very nice to have.

Yours,
Linus Walleij
