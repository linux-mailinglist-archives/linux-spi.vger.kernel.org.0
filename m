Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1F9371388
	for <lists+linux-spi@lfdr.de>; Mon,  3 May 2021 12:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233196AbhECKR7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 3 May 2021 06:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233025AbhECKR6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 3 May 2021 06:17:58 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7BBC06174A;
        Mon,  3 May 2021 03:17:05 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id t22so3302376pgu.0;
        Mon, 03 May 2021 03:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JGoNho5qhHXcNX/6xkx8MH8jm4iW/zXjwlOYf0+600M=;
        b=FjIHVwaGnGayhXAs+rrb9zbYivlOmvv1TmP3SMoxXoVXXKvgNdle9uWh4RZTtZO1qy
         vVI78tlPXdFEHDPK/UwE/hHACnZVYmNBNVO/NgvZ648qyQewGJDk4TC0PRaVwt3GtX9a
         flw762fk81TNl8sy3rp50QaiGrZjLB5991MbugHeSwE+YO9wHMseA1lxiptrlHUeNKM+
         J7pSR7BT0y7ERWiVZJu92WvxNiPmPttN6PIBgSNfrC/UAAosoPnCPyBTlGkqV6ozCPxs
         ELR25WWtPZUL+ouzD/L0LViCu6XoK47veoLjMW4r3L3zppNNXTFbyYJCPYuOB378Bjfn
         BGJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JGoNho5qhHXcNX/6xkx8MH8jm4iW/zXjwlOYf0+600M=;
        b=Uh2b58GD48xwtiQEQAZL9dNlXGsE8gMuuG8j6XxGRsO/6DO4yLcPDV4lcy8vCBAXS0
         ukI92tNyH9uaLwNt0hQXt47igN70UepXCtyaPfIdcp5W8Vd7K6BVegWqf0YLEmXC4tqn
         o4oPvudDBvQ80fJounzDX+WeIceO2l2dk5vblBWbQIZlt6X6WheGsAkeV8BR2aYE83k3
         a3nufIPnJVlb9t5HTKR/A+z6c/8wkgKatIiORxGvrr3/90aa/VIzo0Bp3n6SKXmtu+Uv
         toxnyT02opgEpL06dAXrdWVEX1pI2Zpm7TI/wX0Sb/4RpTNzqz6NTCshRAkWmaIk5Tgr
         AlMg==
X-Gm-Message-State: AOAM530ctg4PuHa3PCKkQsEWTqMsGc4sXKkZ8E3uoIol1eiLqHPqZG5t
        Z4myXCJLZ9bJoMiNLRurs6zK/1FJu78cvn2khmg=
X-Google-Smtp-Source: ABdhPJxaCD5dDtT3vokswKxf5sULrlYsBo2zIB234cOz1l5ETf0rXnaE5/AQjkcSwI49aNlHdkoMAgrLAl2o2PpuSdY=
X-Received: by 2002:a62:528e:0:b029:1f5:c5ee:a487 with SMTP id
 g136-20020a62528e0000b02901f5c5eea487mr18002258pfb.7.1620037024533; Mon, 03
 May 2021 03:17:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210426235638.1285530-1-saravanak@google.com> <20210503100733.GA8114@wunner.de>
In-Reply-To: <20210503100733.GA8114@wunner.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 3 May 2021 13:16:48 +0300
Message-ID: <CAHp75VfFigeSDVixOZTy7feQh2-V+zzKPNpNFViPGg6MoZ3t6A@mail.gmail.com>
Subject: Re: [PATCH] spi: Fix spi device unregister flow
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Saravana Kannan <saravanak@google.com>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Android Kernel Team <kernel-team@android.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, May 3, 2021 at 1:07 PM Lukas Wunner <lukas@wunner.de> wrote:
> On Mon, Apr 26, 2021 at 04:56:38PM -0700, Saravana Kannan wrote:
> > When an SPI device is unregistered, the spi->controller->cleanup() is
> > called in the device's release callback. That's wrong for a couple of
> > reasons:
> >
> > 1. spi_dev_put() can be called before spi_add_device() is called. And
> >    it's spi_add_device() that calls spi_setup(). This will cause clean()
> >    to get called without the spi device ever being setup.
>
> Well, yes, but it's not a big problem in practice so far:
>
> I've checked all drivers and there are only four which are affected
> by this: spi-mpc512x-psc.c spi-pic32.c spi-s3c64xx.c spi-st-ssc4.c
>
> They all fiddle with the chipselect GPIO in their ->cleanup hook
> and the GPIO may not have been requested yet because that happens
> during ->setup.
>
> All the other drivers merely invoke kzalloc() on ->setup and kfree()
> on ->cleanup.  The order doesn't matter in this case because
> kfree(NULL) is a no-op.

Thanks, Lukas, for jumping in.

> > 2. There's no guarantee that the controller's driver would be present by
> >    the time the spi device's release function gets called.
>
> How so?  spi_devices are instantiated on ->probe of the controller
> via spi_register_controller() and destroyed on ->remove via
> spi_unregister_controller().  I don't see how the controller driver
> could ever be unavailable, so this point seems moot.
>
>
> > Fix these issues by simply moving the cleanup from the device release
> > callback to the actual spi_unregister_device() function.
>
> Unfortunately the fix is wrong, it introduces a new problem:
>
> > @@ -713,6 +717,8 @@ void spi_unregister_device(struct spi_device *spi)
> >       if (!spi)
> >               return;
> >
> > +     spi_cleanup(spi);
> > +
> >       if (spi->dev.of_node) {
> >               of_node_clear_flag(spi->dev.of_node, OF_POPULATED);
> >               of_node_put(spi->dev.of_node);
>
> Now you're running ->cleanup before the SPI slave's driver is unbound.
> That's bad, the driver may need to access the physical device on unbound,
> e.g. to quiesce interrupts.  That may not work now because the
> slave's controller_state is gone.
>
> NAK, this needs to be reverted.

I guess somebody should send the actual revert. Are you going to do so?


-- 
With Best Regards,
Andy Shevchenko
