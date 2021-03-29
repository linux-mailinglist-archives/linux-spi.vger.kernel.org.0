Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ADB734CE11
	for <lists+linux-spi@lfdr.de>; Mon, 29 Mar 2021 12:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232579AbhC2KmJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 29 Mar 2021 06:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbhC2Klz (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 29 Mar 2021 06:41:55 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F030FC061574;
        Mon, 29 Mar 2021 03:41:54 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id g10so4193887plt.8;
        Mon, 29 Mar 2021 03:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rHBLv22li+Y93cVWlMkPprlgmJPyM4H/Pq7TZ5iR8qE=;
        b=H4IKakm9kmDi2KnvEIC35pNPRV6sCXKafabaRGc7Sqjgmp34gBYPxVGUS1CWxutZzV
         GlRKpfMSoRKzJV3iyeSkmW4ihEcLu992qQdqTq8JQvTy4vbZXG8lKcSsqejK3E5ybKVd
         vciPnu4lfI+7t4fhxzyccyEp+v96q0eSjnTKHEC7JJyCyNlqsxJelwk797VmEJNYPL/U
         oVXk36FmEDiCYCBkPqPGx9KIT4COiLJDCFPBduihw2VcSc3MAih5ja3yy2QRfgAD/Gjz
         dMDXcrvp7YzwQT5Y39P7r2naxfoMDxIRZBIv44raw0Axv2xfjdPTSW0Plq4wSlaWxUwt
         UmIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rHBLv22li+Y93cVWlMkPprlgmJPyM4H/Pq7TZ5iR8qE=;
        b=QjFiSFLsDYN3xFw/dhyYotTneHIMeo8smUEm61935Yo9Cb3VgH8Jv+2IH8+Q67+v6a
         cPxTskVhuyBNJbomNs18KL9iI2JAUQ2NHHCXqvAV3dUUHiWlfnNg+JzxINgo0YtzCyio
         xQmGH25if/cFaF45aMgO37cyD91avKL1/GecWDXAneqxsMLtpw4mHCc34CDe+VOHBq11
         WX/O6FJCI/e24puZ1f8FtTdoH5io6IANcC5IG8SnzZ5UrCVna4y/JNpL6GQYPeyEjzfi
         9AO6Rx/6DESfYOqp8n+Fv3Iy0d1hTEUibwbH+PuH9yGzVdqDao1U0GL4PGWeeC1PD2We
         zsSA==
X-Gm-Message-State: AOAM532SFzZZOpUn1kKhjLQBH8exUwWhgN5+K9kyQkCkUaxKVGy1JpZn
        /SQGI2acOaj/816VcjIIO5+w6phbEq1Zdyhg9dg=
X-Google-Smtp-Source: ABdhPJxqUWx3prtUg6VjM14MCrWLRzRkLydqMsobi69dqWIobFrGRTqKt7qf6Skw33pS6A6x5C4+ZtUd8zYg0vwUahw=
X-Received: by 2002:a17:90a:e454:: with SMTP id jp20mr26891397pjb.129.1617014514572;
 Mon, 29 Mar 2021 03:41:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210329015938.20316-1-brad@pensando.io> <20210329015938.20316-2-brad@pensando.io>
In-Reply-To: <20210329015938.20316-2-brad@pensando.io>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 29 Mar 2021 13:41:38 +0300
Message-ID: <CAHp75VczOyiD+F9MDqdZdZGhAFF5Kh5U7CAmTj+i-Fy7KZsEog@mail.gmail.com>
Subject: Re: [PATCH v2 01/13] gpio: Add Elba SoC gpio driver for spi cs control
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
> This GPIO driver is for the Pensando Elba SoC which
> provides control of four chip selects on two SPI busses.

Same comments as per v1.
NAK from me until we get settled in that discussion.

...

> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("Pensando Elba SoC SPI chip-select driver");

It's funny, you told it can't be a module and you add a dead code. Be
somehow consistent, please.


-- 
With Best Regards,
Andy Shevchenko
