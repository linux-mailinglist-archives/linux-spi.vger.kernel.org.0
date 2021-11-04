Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 704E44455D5
	for <lists+linux-spi@lfdr.de>; Thu,  4 Nov 2021 15:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbhKDPA7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 4 Nov 2021 11:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbhKDPA7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 4 Nov 2021 11:00:59 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8138BC061203
        for <linux-spi@vger.kernel.org>; Thu,  4 Nov 2021 07:58:21 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id v138so15079568ybb.8
        for <linux-spi@vger.kernel.org>; Thu, 04 Nov 2021 07:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kKJ8G13KehG55O+zH0KRmsND1437+etUwIH34WzymDc=;
        b=E/IZ8HyU/GNkCQdqukSRLw9WUrVPvDLIFKJ2YqGz0Yy30Clzhv3F9FeJI/GbRc9BLr
         fQG/UtMaTDJ0FdUkTpIQsV5UyII936MXAGZmn5+bBZ8d3nR6EGRdGGdKDcDJOlSn9gwC
         VwiOagSfSwm6qCL/mydZVPbp6yqf4h9XghDzyIAQd0+2e6gacPDgQrOqQ4iYiU103rSP
         bsFonXghQE1YaeCWNg4pereHwzq0J/myntpvIwEAhptHcnNRu7wiNlzqrbBAC9khBShd
         4VsIYXoPSq6D2B6u5IKiqtha34bDSSEwLGVPqq0YKKdLisknQ4e8kW4vO29ATFwPsO2Z
         qckQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kKJ8G13KehG55O+zH0KRmsND1437+etUwIH34WzymDc=;
        b=kWQsOd1k0uFod3EvJtivO/wc1IQj4QMe0BwvqTCixu6UeKb0UOxhjhOnO2gfUW5afO
         we/3Sqc20JGN5TUQrjC4TNTbZNImD7WX5tPsb7ZAKiOGTnD3zt7BblUqlRmWZV3hIl3w
         9DZCsCQaGBQLzIvauOjAKywMWrfImKzdRjZKizt+hZGwCvaIecGdBcSsvw9sOR5gFcIC
         ESxT5BRhp7mT99vIaaRZAtkUNMWxkJo/e0f3OeLg5WnIagozsLCTdtl64TUJIl2Zc8rj
         NWjUt+tZq0TlYQAfjVDDGPYUBttHugLQ9rZUrV/YbpO0NCLXvE62e2wcx3QWJ/U5DlO/
         yWpQ==
X-Gm-Message-State: AOAM532+CSw+J+KMddmhNN5S7kCDM41SKExFkMMM4sj4fGqZntE14n5V
        0Lu2k3mPwSVPSnY0VNuhcSz7fvIzH1LzFmPDYW/vFquhA7Y=
X-Google-Smtp-Source: ABdhPJxM/p+OQQIxsZ4AqlI0a2ihINTTUp6MuRYc5e+Hysm/5DOEiWbzhJjcml7rWdkD992mUzO+YsJMxK3smxEF9y4=
X-Received: by 2002:a25:8b90:: with SMTP id j16mr58012625ybl.210.1636037900687;
 Thu, 04 Nov 2021 07:58:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAETHaKpiZEWHUrKtNw+W3XHAPUA4h=OC=RL4Jbcs94o1MgDj6w@mail.gmail.com>
 <CAMuHMdXwYH2n+C5AEzhCjtH+eX5mBFH=cB1hYAy-XYtPYRn9jw@mail.gmail.com>
In-Reply-To: <CAMuHMdXwYH2n+C5AEzhCjtH+eX5mBFH=cB1hYAy-XYtPYRn9jw@mail.gmail.com>
From:   Dave Bender <codehero@gmail.com>
Date:   Thu, 4 Nov 2021 10:58:09 -0400
Message-ID: <CAETHaKrQ-UDPjMm_jpNe3P0VzQg7qDLZGaViqXvz+qVuUuZCgg@mail.gmail.com>
Subject: Re: spi-ar934x: Using GPIO CS issue
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Geert,
  Thanks for the response.
  There is a pullup resistor on that CS line, so that GPIO must be active low.
  Digging deeper into the code, it looks like David Bauer made some
changes that limit the spi driver's CS usage to only the CS0, CS1, CS2
pins.
  There is also no bounds checking on the CS value.
  I don't understand how this driver can even use generic GPIO if it
forces use of the CS bits on the SPI_IOC register.

static int ar934x_spi_transfer_one_message(struct spi_controller *master,
             struct spi_message *m)
{
   ....
   ....
    for (trx_done = 0; trx_done < t->len; trx_done += 4) {

   .....
      reg = AR934X_SPI_SHIFT_VAL(spi->chip_select, term,
               trx_cur * 8);
      iowrite32(reg, sp->base + AR934X_SPI_REG_SHIFT_CTRL);



-Dave

On Thu, Nov 4, 2021 at 5:50 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Dave.
>
> On Tue, Nov 2, 2021 at 11:31 PM Dave Bender <codehero@gmail.com> wrote:
> > Under the mach-* era of configuring boards, I was able to use a second
> > SPI NOR flash with a GPIO chip select, as in:
> >
> > static struct spi_board_info spi_info[] = {
> >        { ... },
> >        {
> >                .bus_num        = 0,
> >                .chip_select    = 1,
> >                .max_speed_hz   = 25000000,
> >                .modalias       = "m25p80",
> >        },
> > };
> >
> > static int cs_gpios[2] = {
> >        -ENOENT,
> >        11,
> > };
> >
> > static struct ath79_spi_platform_data mtriq_spi_data __initdata = {
> >        .bus_num = 0
> >        ,.num_chipselect = 2
> >        ,.cs_gpios = cs_gpios
> > };
> >
> > static void __init board_setup(){
> >  ath79_register_spi(&spi_data, spi_info, 2);
> > }
> >
> >
> > However, under the new dts regime, I try to use a CS gpio but cannot
> > communicate successfully to the chip:
> >
> > &spi {
> >     status = "okay";
> >     cs-gpios = <0>,<&gpio 11 GPIO_ACTIVE_LOW>;
> >
> >     flash@1 {
> >     compatible = "jedec,spi-nor";
> >     spi-max-frequency = <25000000>;
> >     reg = <1>;
> >   };
> > };
> >
> > Am I missing something here?
>
> Does it work if you change GPIO_ACTIVE_LOW to GPIO_ACTIVE_HIGH?
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
