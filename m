Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F175A34CE16
	for <lists+linux-spi@lfdr.de>; Mon, 29 Mar 2021 12:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbhC2Knq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 29 Mar 2021 06:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbhC2KnU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 29 Mar 2021 06:43:20 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26C1C061574;
        Mon, 29 Mar 2021 03:43:19 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id bt4so5786614pjb.5;
        Mon, 29 Mar 2021 03:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dwOgLZt/8mlPArcO6wAAqKSrT/wgxlezGfFwx/q+fHE=;
        b=vFBYl/C6Mk+Gn33WegEQNIdQ5NuJ/nJPbqU0+6CdyKDDSAbpxfEOL7Od/bL1nJ8ikF
         Ju9SE9WTEqjN8N/NDiFLa+h6G346JuK7qY6Z7dRC8eSRz6Lfwiy+VHMPozpLEDUzyonE
         vhTe5c032hcXglQ5egNJrxxKVaBxThxiBkKFHZIjPUKOT8hWla0nSkMjW3ZsWHESmw+y
         mKnhl494TY/MqO76G1Rtjprzs5uinWGQoXxp0+w3+3yb1u1fK/IuUaGnrOXbPpOxshn5
         fDm9kjQcZQUe9tK3xU02itXQUqWse3SWawxTKDW6FVwGnF8AdKPspwIu/loFdaW/9jpY
         h6Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dwOgLZt/8mlPArcO6wAAqKSrT/wgxlezGfFwx/q+fHE=;
        b=tU4L9oXZAxt/KlGwRVeBmA8AZVtSlc8BRsd7K8Qb0gyDbJnw4RbKX0pMm9WTYq/wO/
         lxBmYoKZvqtih4lBPL2ddB9Hi95nnPFuF8TNEAHPw3nDHUm+fHqNcFg+a5QVjLi/KNOZ
         L6ScD7JvXVb+1kR+3hKxIoTZvlYE7LgNWUOcaiySWR95EDtIUJmsOw8Shio73zAzeGbn
         mpU/OwBNDD6zHopayFu7Cz+u+aweqFmkdDN47mbLaJcro9bFpHOQg7Z0A7tRl35nbKL+
         dxc/SYj91obIr272T6okvNAFPdbQSV+sRcCKKyUahz9ScAEeP16OkFpxU9KIoiMNj/q0
         gW3Q==
X-Gm-Message-State: AOAM531ysrnzY91rZvf7eIj1J3VeOEl/fdxygfHrTxZRJR3yosAI2rxe
        3HlfG6Uom2KqUumngUbbLD5YyMia9I4zUH9XESc=
X-Google-Smtp-Source: ABdhPJxZKw/Pjc81S3By5GpueAwyyLViyN98oVmeWosQtHCRYYhVTTJhNv8knjrg89ZyK1pR35HUA7uacoNjnUsVQaw=
X-Received: by 2002:a17:902:ee02:b029:e6:5397:d79c with SMTP id
 z2-20020a170902ee02b02900e65397d79cmr28167959plb.21.1617014599456; Mon, 29
 Mar 2021 03:43:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210329015938.20316-1-brad@pensando.io> <20210329015938.20316-4-brad@pensando.io>
In-Reply-To: <20210329015938.20316-4-brad@pensando.io>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 29 Mar 2021 13:43:03 +0300
Message-ID: <CAHp75VfmSKVRB+Rm+sWDjZaJwdX4qt56Qj6aehe4YnA5d6+a6Q@mail.gmail.com>
Subject: Re: [PATCH v2 03/13] spi: dw: Add support for Pensando Elba SoC SPI
To:     Brad Larson <brad@pensando.io>
Cc:     linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Mar 29, 2021 at 5:01 AM Brad Larson <brad@pensando.io> wrote:
>
> The Pensando Elba SoC uses a GPIO based chip select
> for two DW SPI busses with each bus having two
> chip selects.

...

> +static void dw_spi_elba_set_cs(struct spi_device *spi, bool enable)
> +{
> +       struct dw_spi *dws = spi_master_get_devdata(spi->master);
> +
> +       if (!enable) {

Can you use positive conditional?

> +               /*
> +                * Using a GPIO-based chip-select, the DW SPI
> +                * controller still needs its own CS bit selected
> +                * to start the serial engine.  On Elba the specific
> +                * CS doesn't matter to start the serial engine,
> +                * so using CS0.
> +                */
> +               dw_writel(dws, DW_SPI_SER, BIT(0));
> +       } else {
> +               dw_writel(dws, DW_SPI_SER, 0);
> +       }
> +}

-- 
With Best Regards,
Andy Shevchenko
