Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDD394E87
	for <lists+linux-spi@lfdr.de>; Mon, 19 Aug 2019 21:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbfHSTnM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 19 Aug 2019 15:43:12 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38085 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727957AbfHSTnM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 19 Aug 2019 15:43:12 -0400
Received: by mail-qk1-f196.google.com with SMTP id u190so2470018qkh.5
        for <linux-spi@vger.kernel.org>; Mon, 19 Aug 2019 12:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rlM5AzB9s5TeikF7kk6z1rI+2KL4m9xBg+VneDzDbn8=;
        b=P6VJoA/a2BjGl5vmP4/jndOuZirS8Yy4veHIaA+17rdRD6KXC5M0yyAReRdXnJkusj
         oUWqhQcPJxKhLVmQ+cuBThJL1vxXLku20zb0RPwkm5dXyz6rcryo9S508pMhzpvVjA3l
         A3Z5WDmrTCLuWMOllcC9OD1+/o8TJBDeVrmP3JojyXqKLj0xrKCsUpr1S7q/TVapm4Lm
         CyqRrHtozeNjGYKxaO9muEUnnb+LlnvxWAna0gwqzmmVXjegZv9SeChR8la+LAHvi6oV
         9wXqOskTonAEZdTjBYTY5TLLWExzZkNqZJwWCqgWQ4w+s58KSAxq9oXieAJLLkCsfj1n
         5pXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rlM5AzB9s5TeikF7kk6z1rI+2KL4m9xBg+VneDzDbn8=;
        b=QA8JceqL3XvfHX0FRJMgOOiM2hYcWhUpzDPepM7qUWTCNL+obyjHWRvl6NoxgFQga3
         bbkTQ+b6ssXff5xkSrmet2CW4+JaMmyHZsUMsO1gWxEondA+PZiJbxzKUM2i1mJZucIV
         ZoZojg2IjpJjXwKqIne/XsVyXk61KWEpeTjGz23lGjASxYDB0OBHcNOh+wyCIx3dIKAo
         9t24uWJFAvdtAZY5NRR+xfM2PJ5SPA5WQDb8ZUCJxwjR4PAdFhOk61kxG0h2tRHIuMzF
         CGgpzEEddkqUJOis58j0c7AhyZzOZwti1eW0ch4yCF9U9+UtqBIrHZXnNGJqomJcNL71
         n0NQ==
X-Gm-Message-State: APjAAAVOFUQPJT4tDAFO1ZJw6Lrr1ZgB0ofdLcDyQv7kasrmrkayCqSd
        Jltq6Gfn1jWYqZNGxOK2i1JCsjzuk7u1HRCZS3cUMw==
X-Google-Smtp-Source: APXvYqyRyCND4xFLwaTN72YL3fCEWtw0G/uMrkMebnxPdSdnkd0Xux32IpzoNr7vZ4FpLPDvsdfKScHW8L5zUJbDUQk=
X-Received: by 2002:a37:61c3:: with SMTP id v186mr21313755qkb.158.1566243791196;
 Mon, 19 Aug 2019 12:43:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190816223333.144924-1-cujomalainey@chromium.org> <b9c7bb4f-e115-670a-99df-af37e7e299b0@linux.intel.com>
In-Reply-To: <b9c7bb4f-e115-670a-99df-af37e7e299b0@linux.intel.com>
From:   Curtis Malainey <cujomalainey@google.com>
Date:   Mon, 19 Aug 2019 12:43:00 -0700
Message-ID: <CAOReqxhr+Pdvnw6jUY4A9qCUFdhX6ksMCM8U-2SPrJ1H9Bo-RQ@mail.gmail.com>
Subject: Re: [PATCH] spi: pxa2xx: restore lpss state after resume
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     Curtis Malainey <cujomalainey@chromium.org>,
        linux-spi@vger.kernel.org, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sun, Aug 18, 2019 at 11:46 PM Jarkko Nikula
<jarkko.nikula@linux.intel.com> wrote:
>
> On 8/17/19 1:33 AM, Curtis Malainey wrote:
> > On broadwell machines it has been observed that the registers do not
> > maintain their state through a suspend resume cycle. This is given that
> > after a suspend resume cycle the SW CS bit is no longer set. This can
> > break reads as CS will now be asserted between transmissions in messages
> > and therefore reset the slave device unintentionally.
> >
> > Signed-off-by: Curtis Malainey <cujomalainey@chromium.org>
> > Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> > ---
> >   drivers/spi/spi-pxa2xx.c | 3 +++
> >   1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
> > index fc7ab4b268802..3f313a9755640 100644
> > --- a/drivers/spi/spi-pxa2xx.c
> > +++ b/drivers/spi/spi-pxa2xx.c
> > @@ -1913,6 +1913,9 @@ static int pxa2xx_spi_resume(struct device *dev)
> >                       return status;
> >       }
> >
> > +     if (is_lpss_ssp(drv_data))
> > +             lpss_ssp_setup(drv_data);
> > +
> >       /* Start the queue running */
> >       return spi_controller_resume(drv_data->controller);
> >   }
>
> So there is actually a regression caused by my b53548f9d9e4 ("spi:
> pxa2xx: Remove LPSS private register restoring during resume").
>
> Which suggests to me there may be need to save/restore other private
> registers too.
>
> Do you Andy or Heikki remember why this LPSS context save/restore wasn't
> implemented for Lynxpoint? I was testing my above commit on a Haswell
> based machine which didn't need it but apparently Broadwell needs.
>
> Curtis: would a diff below fix the issue you are seeing? I added context
> save/restore for I2C and UART controllers too.
>

I tried that and it worked with SPI for me. It preserved the CS SW bit. :)
Thanks for the quick response. I'll add a tested-by if you send a patch.

> diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
> index d696f165a50e..60bbc5090abe 100644
> --- a/drivers/acpi/acpi_lpss.c
> +++ b/drivers/acpi/acpi_lpss.c
> @@ -219,12 +219,13 @@ static void bsw_pwm_setup(struct lpss_private_data
> *pdata)
>   }
>
>   static const struct lpss_device_desc lpt_dev_desc = {
> -       .flags = LPSS_CLK | LPSS_CLK_GATE | LPSS_CLK_DIVIDER | LPSS_LTR,
> +       .flags = LPSS_CLK | LPSS_CLK_GATE | LPSS_CLK_DIVIDER | LPSS_LTR
> +                       | LPSS_SAVE_CTX,
>         .prv_offset = 0x800,
>   };
>
>   static const struct lpss_device_desc lpt_i2c_dev_desc = {
> -       .flags = LPSS_CLK | LPSS_CLK_GATE | LPSS_LTR,
> +       .flags = LPSS_CLK | LPSS_CLK_GATE | LPSS_LTR | LPSS_SAVE_CTX,
>         .prv_offset = 0x800,
>   };
>
> @@ -236,7 +237,8 @@ static struct property_entry uart_properties[] = {
>   };
>
>   static const struct lpss_device_desc lpt_uart_dev_desc = {
> -       .flags = LPSS_CLK | LPSS_CLK_GATE | LPSS_CLK_DIVIDER | LPSS_LTR,
> +       .flags = LPSS_CLK | LPSS_CLK_GATE | LPSS_CLK_DIVIDER | LPSS_LTR
> +                       | LPSS_SAVE_CTX,
>         .clk_con_id = "baudclk",
>         .prv_offset = 0x800,
>         .setup = lpss_uart_setup,
