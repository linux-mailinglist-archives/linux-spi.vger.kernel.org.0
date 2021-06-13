Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACC53A58FC
	for <lists+linux-spi@lfdr.de>; Sun, 13 Jun 2021 16:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbhFMOUg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 13 Jun 2021 10:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbhFMOUg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 13 Jun 2021 10:20:36 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A5EC061574;
        Sun, 13 Jun 2021 07:18:35 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id m13-20020a17090b068db02901656cc93a75so8548225pjz.3;
        Sun, 13 Jun 2021 07:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QwLlMM9Ym/Uy69pRc1FVK0iMOa3n64q/HffKmsDL1Z4=;
        b=Wvsf4aR5w+AGAuJ1oTPhJR7mRp4YZz+d6+AO2xTUrJp54aMuKDjHBlhdp1p9j5Qt2F
         pQobVjZMXmH6TGtdc5qiq9FndkbRJsdo9iL1CYB7fKZNDLmF4/T1WP0RpBrrpLXfLisJ
         IiZhcjrDc2SNQUDg5yvfgwFZDBsAVtKTIDmNYlCJlVY3ZheWhTwWALN2YuilkXogoDPc
         6XUniP2fcMIgBGMacrg74r3tmfUYlY3pvwRE/nH0Y2eiYo/WKRrIWk4xU0RXsm8kHqLg
         hV0+To4ovr+oT2Q2pUFPBZukiQ/5/h7acwfMn8wKGDvsEXIEDFejcZqYX1kEWvV7QCGk
         6sSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QwLlMM9Ym/Uy69pRc1FVK0iMOa3n64q/HffKmsDL1Z4=;
        b=gs7qs3tecUy6ChxoFjL+ixjrL2wDRzBK3n0pnagvee9kKdhWQMltpMwh01hjh5g+3k
         TkioJ/8Ffa1hwzJ0et21GiztO4dLIXCuDoYCznTXiUdVxWWOiyTebuA81JtDN9mLyacn
         xepHs82OqxbmlYtnBgoLI8dPkH4Bb8iiVcqgvcCXrQWhRJZQ1Bi/18B4y+Dlcre+PGC8
         AEw7AUYW4FW76SuFNPN7xli4IPaGaP703XFFnx9d7L2fSfCI73Z8vJy/aY6Gpz4YOtSY
         ZKgNDhMCHVTDpo3oxOszepZFwDGBUDGkMi7n5znKu2pvO/RPqSFDCFsQjmFbxNl9zJXa
         fFOw==
X-Gm-Message-State: AOAM5337EWOI+I8xb+jZAP/SrHBDk9K8rZHV7bld7TN45a6QI2nMcSgG
        WYK4FT7nFjzfGN4PJ9GJzvGxmqgiZOYhHdhYw8k=
X-Google-Smtp-Source: ABdhPJxKgTfZRHr3uE+3zi0q3q6e85npnHbtSAQUHWx3cyKtrAHubN3pdpUpMNXxoEKeTWRYjo5QfqzSlX2Ct3zye2g=
X-Received: by 2002:a17:902:d305:b029:10d:c8a3:657f with SMTP id
 b5-20020a170902d305b029010dc8a3657fmr12682275plc.0.1623593914137; Sun, 13 Jun
 2021 07:18:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210609151235.48964-1-sebastian.reichel@collabora.com> <20210609151235.48964-2-sebastian.reichel@collabora.com>
In-Reply-To: <20210609151235.48964-2-sebastian.reichel@collabora.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 13 Jun 2021 17:18:17 +0300
Message-ID: <CAHp75Ve7c9ncLNfTRUdAPYxaPgMF_oGpg6kh3RnTJejAfKjKGg@mail.gmail.com>
Subject: Re: [PATCHv4 1/6] spi: add ancillary device support
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Ian Ray <ian.ray@ge.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Jun 9, 2021 at 7:07 PM Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
>
> Introduce support for ancillary devices, similar to existing
> implementation for I2C. This is useful for devices having
> multiple chip-selects, for example some microcontrollers
> provide a normal SPI interface and a flashing SPI interface.

...

> @@ -1993,7 +2019,7 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
>         }
>
>         /* Device address */
> -       rc = of_property_read_u32(nc, "reg", &value);
> +       rc = of_property_read_u32_index(nc, "reg", 0, &value);
>         if (rc) {
>                 dev_err(&ctlr->dev, "%pOF has no valid 'reg' property (%d)\n",
>                         nc, rc);

Unrelated change.

-- 
With Best Regards,
Andy Shevchenko
