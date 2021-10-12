Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD2A42A8B2
	for <lists+linux-spi@lfdr.de>; Tue, 12 Oct 2021 17:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237023AbhJLPoU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 12 Oct 2021 11:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236864AbhJLPoU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 12 Oct 2021 11:44:20 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DFBAC061570;
        Tue, 12 Oct 2021 08:42:18 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id g10so1290807edj.1;
        Tue, 12 Oct 2021 08:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=H5OJKGHhb12cbBhIkOEVY2gJnukL9FN05ea6u1g8Ems=;
        b=fmki5fEnr2QZdmejR7IvjqoeZTDrquzPOwrj/9VAvbRiDtutM8RYqfV1GX4UtijXO9
         l9wpy23RqdIBZaUu0t0n3tvlwJepe8XWy3SVQaqmVmSG74dQfQYwSR+crtCddWMDOSFq
         0x7uESYTSsE+rxPiiXFBotTpGQjdVbd0PId06jgC0laHCp6g6cHsjrqt+U1tIlq7kU7J
         n67SMC2KVmKwWbR81vmqAOHGvDuvHW17nGiTJXrtWgHPLNLIPP8r9RDj6aqDJonqWxJk
         28A363OBLx8Om53I9N9gaHi38VVCL9840hbT3uwOUjIoaUXDdEWqgW+JIcUZEq6317cy
         Be1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=H5OJKGHhb12cbBhIkOEVY2gJnukL9FN05ea6u1g8Ems=;
        b=aaZrFQ0xoPM13PxwsPJc4p/4BOa/wtS0NN6m/54A+PUvlBNJQmSXwdOYE6cCaHq4jV
         95Q47dUEPnLMr0DP9ufqqDwQGQztuukIQx0F6Yz6TFIViP0sfwcDcpgZUWfQSTp+XmOW
         hW+AlDHSQkWQhsKfofO1W3iN+72zygrcOHj9KENxsLJnXoc2hlkKYmwXmkIaAHRs5sK5
         X1Z4W/J3TbFsiVbNnHWk3/wdb3gCG/56TmYMf3EcWFeSjQUMml+l3r3qBEjBh6j/LtPd
         qhb0XHTK7A75qvHMmYLrL/JJ7IPZukMlwYnqPbTmbiHqSYW/e/7aCJ6MJgyydTbA/xgq
         eS6g==
X-Gm-Message-State: AOAM532q/rcpnPf4nYcp7i0dy+saT69aIV8VncfEQ79iR3JeOfw248/z
        B5UmlASoptjluvNWBpAkl1B+ktZ5XnrhWUyKyKM=
X-Google-Smtp-Source: ABdhPJyq3IvnlDoPn+uU3tU76YH7XHRrXJj4IkaFmiXSrPtBQT/+M63VK9AeTvtzw+b4xXROKMZIihwfPxgt+5wvDxw=
X-Received: by 2002:a17:906:eb86:: with SMTP id mh6mr34177816ejb.141.1634053336853;
 Tue, 12 Oct 2021 08:42:16 -0700 (PDT)
MIME-Version: 1.0
References: <20211012153945.2651412-1-u.kleine-koenig@pengutronix.de> <20211012153945.2651412-20-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20211012153945.2651412-20-u.kleine-koenig@pengutronix.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 12 Oct 2021 21:41:29 +0300
Message-ID: <CAHp75VcUVRL0Cr7rGEngM=DTmsSr-kyg4uyRNhwZ_xisZDww4A@mail.gmail.com>
Subject: Re: [PATCH v2 19/20] staging: fbtft: Make fbtft_remove_common()
 return void
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Len Baker <len.baker@gmx.com>, Mark Brown <broonie@kernel.org>,
        Phil Reid <preid@electromag.com.au>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-staging@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Oct 12, 2021 at 6:40 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> fbtft_remove_common() is only called with a non-NULL fb_info. (All
> callers are in remove callbacks and the matching probe callbacks set
> driver data accordingly.) So fbtft_remove_common() always returns zero.
> Make it return void instead which makes it easier to see in the callers
> that there is no error to handle.
>
> Also the return value of platform and spi remove callbacks is ignored
> anyway and not freeing resources in .remove() is a bad idea.

Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/staging/fbtft/fbtft-core.c | 8 +-------
>  drivers/staging/fbtft/fbtft.h      | 8 +++++---
>  2 files changed, 6 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/f=
btft-core.c
> index ed992ca605eb..9c9eab1182a6 100644
> --- a/drivers/staging/fbtft/fbtft-core.c
> +++ b/drivers/staging/fbtft/fbtft-core.c
> @@ -1318,23 +1318,17 @@ EXPORT_SYMBOL(fbtft_probe_common);
>   * @info: Framebuffer
>   *
>   * Unregisters and releases the framebuffer
> - *
> - * Return: 0 if successful, negative if error
>   */
> -int fbtft_remove_common(struct device *dev, struct fb_info *info)
> +void fbtft_remove_common(struct device *dev, struct fb_info *info)
>  {
>         struct fbtft_par *par;
>
> -       if (!info)
> -               return -EINVAL;
>         par =3D info->par;
>         if (par)
>                 fbtft_par_dbg(DEBUG_DRIVER_INIT_FUNCTIONS, par,
>                               "%s()\n", __func__);
>         fbtft_unregister_framebuffer(info);
>         fbtft_framebuffer_release(info);
> -
> -       return 0;
>  }
>  EXPORT_SYMBOL(fbtft_remove_common);
>
> diff --git a/drivers/staging/fbtft/fbtft.h b/drivers/staging/fbtft/fbtft.=
h
> index 76f8c090a837..6869f3603b0e 100644
> --- a/drivers/staging/fbtft/fbtft.h
> +++ b/drivers/staging/fbtft/fbtft.h
> @@ -252,7 +252,7 @@ void fbtft_unregister_backlight(struct fbtft_par *par=
);
>  int fbtft_init_display(struct fbtft_par *par);
>  int fbtft_probe_common(struct fbtft_display *display, struct spi_device =
*sdev,
>                        struct platform_device *pdev);
> -int fbtft_remove_common(struct device *dev, struct fb_info *info);
> +void fbtft_remove_common(struct device *dev, struct fb_info *info);
>
>  /* fbtft-io.c */
>  int fbtft_write_spi(struct fbtft_par *par, void *buf, size_t len);
> @@ -283,7 +283,8 @@ static int fbtft_driver_remove_spi(struct spi_device =
*spi)                 \
>  {                                                                       =
   \
>         struct fb_info *info =3D spi_get_drvdata(spi);                   =
    \
>                                                                          =
  \
> -       return fbtft_remove_common(&spi->dev, info);                     =
  \
> +       fbtft_remove_common(&spi->dev, info);                            =
  \
> +       return 0;                                                        =
  \
>  }                                                                       =
   \
>                                                                          =
  \
>  static int fbtft_driver_probe_pdev(struct platform_device *pdev)        =
   \
> @@ -295,7 +296,8 @@ static int fbtft_driver_remove_pdev(struct platform_d=
evice *pdev)          \
>  {                                                                       =
   \
>         struct fb_info *info =3D platform_get_drvdata(pdev);             =
    \
>                                                                          =
  \
> -       return fbtft_remove_common(&pdev->dev, info);                    =
  \
> +       fbtft_remove_common(&pdev->dev, info);                           =
  \
> +       return 0;                                                        =
  \
>  }                                                                       =
   \
>                                                                          =
  \
>  static const struct of_device_id dt_ids[] =3D {                         =
     \
> --
> 2.30.2
>


--=20
With Best Regards,
Andy Shevchenko
