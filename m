Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF2A150399
	for <lists+linux-spi@lfdr.de>; Mon,  3 Feb 2020 10:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbgBCJuw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 3 Feb 2020 04:50:52 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41617 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbgBCJuw (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 3 Feb 2020 04:50:52 -0500
Received: by mail-pg1-f196.google.com with SMTP id l3so3426864pgi.8;
        Mon, 03 Feb 2020 01:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EWRKsWaWmg5NO/mnYvImE8+2/MqqhQvfqqUf6+UV82M=;
        b=sTgNH601s+cs5seICnN457wor5rcnZdDi9R2868VFJp5S2mk+clBQGsh578++udKxD
         DGgtgP6+JuVe1hlDbIAbg7PKQ0o8QWD2C0DPFijb0PDhh8lxkfiN7RNeGIBiQTeyeHwN
         HIjH3Jmx8vK/NugnFh7U/H8eui7iUv2nsrZXE7LqRhvMAGYcFaFolMGJr6pMUDW1XWTc
         fwvz6eaD4swsb5sKIGVdtG8GLs9JGOediDdPgqTtvEd1L/+1ODzAxNsN49N5ZB4jt6Ys
         L9UADWe99kpnOAgtPtQbc4j6R8B3uwjeSSosjT5apPPuI15WnFAWCiXqxjr6uNMW1H7I
         QCTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EWRKsWaWmg5NO/mnYvImE8+2/MqqhQvfqqUf6+UV82M=;
        b=dKJxiGQ2yJ2Yh9PZ65BWrxpA3S/klJN9KtCUR1i4nFOyD2Z6owkJK/HHDbyJ7IILJg
         PZNfLnzLvqCCYT5t8+2jSZNeQ7aDMcGwgmqlztjc4QBPwVxVKKHswL5h3IXsAmp3/1bG
         msvjdyy0H5jWg76pq3bs9+uRtnQGn1lZwgDoSPJAd+/Jshj4LRBzRmO3U3MlrnbtxX6x
         /ECujEX60mTUit8k2uHJKUyCEHtWONbfvhjxxKtzfPsXn6ikvElYzZY406iPCRFWDraX
         q6toITNH+iFW2mzOfSj4nLhIYLTWT5ucUYXOPzZid9VmyQ0S1/brktWE5X4iysTcDJ5U
         MfQg==
X-Gm-Message-State: APjAAAWqOKbP6c6nB8dQ5Q58I1L87QH9k7F63zZqP97V5KXCAI+iaPJO
        /+VP0+HAr74mMne+VHizmzVb48Ha3hK5qIwElpM=
X-Google-Smtp-Source: APXvYqw8y57bod1JAAwsPHyqT98wQ90m4CAg3j8uNvdGBt7JwYxPmdmqDV4w1DH3vCs/JGdJO3tZRGH8vhCdHg3bEWM=
X-Received: by 2002:a63:5a23:: with SMTP id o35mr24113786pgb.4.1580723450104;
 Mon, 03 Feb 2020 01:50:50 -0800 (PST)
MIME-Version: 1.0
References: <20200131023433.12133-1-chris.packham@alliedtelesis.co.nz> <20200131023433.12133-3-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20200131023433.12133-3-chris.packham@alliedtelesis.co.nz>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 3 Feb 2020 11:50:42 +0200
Message-ID: <CAHp75VfT=KNM6J1bP5cPsLw7Z776opcB9Kf6qhNCZukY-7g=pQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] spi: Add generic SPI multiplexer
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Jan 31, 2020 at 4:34 AM Chris Packham
<chris.packham@alliedtelesis.co.nz> wrote:
>
> Add a SPI device driver that sits in-band and provides a SPI controller
> which supports chip selects via a mux-control. This enables extra SPI
> devices to be connected with limited native chip selects.

Thanks for an update, my comments below.

...

>  #
>  # Add new SPI master controllers in alphabetical order above this line
>  #

> +#

Redundant line.

...

> +/*
> + * General Purpose SPI multiplexer
> + */

I think Mark wants to have this in one line with C++ style of comments.

...

> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/err.h>
> +#include <linux/slab.h>
> +#include <linux/spi/spi.h>
> +#include <linux/mux/consumer.h>

Perhaps sorted?

...

> +       /* do the transfer */
> +       ret = spi_async(priv->spi, m);
> +       return ret;

return spi_async(...);

...


> +       priv->mux = devm_mux_control_get(&spi->dev, NULL);

> +       ret = PTR_ERR_OR_ZERO(priv->mux);

This is a bit complicated.

> +       if (ret) {

Why not simple do

  if (IS_ERR(priv->mux)) {
    ret = PTR_ERR(...);
    ...
  }

?

> +               if (ret != -EPROBE_DEFER)
> +                       dev_err(&spi->dev, "failed to get control-mux\n");
> +               goto err_put_ctlr;
> +       }

> +       ctlr->dev.of_node = spi->dev.of_node;

I'm wondering why SPI core can't handle this by default (like GPIO
subsystem does).

> +       ret = devm_spi_register_controller(&spi->dev, ctlr);
> +       if (ret)
> +               goto err_put_ctlr;
> +

> +       return ret;

return 0;

...

> +static const struct of_device_id spi_mux_of_match[] = {
> +       { .compatible = "spi-mux" },
> +       { },

Comma is not needed in terminator line.

> +};

-- 
With Best Regards,
Andy Shevchenko
