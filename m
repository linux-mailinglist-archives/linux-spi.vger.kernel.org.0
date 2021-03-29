Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0B7C34D194
	for <lists+linux-spi@lfdr.de>; Mon, 29 Mar 2021 15:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbhC2No7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 29 Mar 2021 09:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbhC2Nov (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 29 Mar 2021 09:44:51 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A7EC061765
        for <linux-spi@vger.kernel.org>; Mon, 29 Mar 2021 06:44:51 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id n138so18540731lfa.3
        for <linux-spi@vger.kernel.org>; Mon, 29 Mar 2021 06:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/xbwOyUoByuGnZGoWKpGwyaF8Ra1/D45zi9BaPI7asA=;
        b=iLaLQP3gfwQoeqqnF5bgUGM7HmMcRJd2XQHUEp2ZXgZlKyrHNnyDBgzyenG7VRZAkF
         TkzvXw0PdghuCeoFyIHVAyjML18L6DnL1Hm2qHPdqlUDIqO+7D5DIFdTbqWTL6RsoslN
         frLA/pVwrLgTFkwzc8E+HCJfWM2a1mHPJxa5YgZ+221DPxMO5Dy422whkdUC9MhzSUh9
         2rOQox2y9WTkTSEc/xw4jjloCHigCq6GFtgQYrqbSvXYEZAy3M4vdnPZgY+i1bRuZ7CU
         Z8VriZNADTlteSOp000kLFSykkZfOujZP2h5exuCf3xSPgm0yGnV9sxj3dfzMnrR4+bG
         c37A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/xbwOyUoByuGnZGoWKpGwyaF8Ra1/D45zi9BaPI7asA=;
        b=TcCBxTsQv5IIJMgVZlKA55idO05vuh4l6lfLDmIVQmw5Wh5oJ5IOiT8nc5H5oMSJMa
         S/642neSk5Pc0HPDksQ1qNNDI7+0uMiK2J0FWKGSiJJpRQ/MVAC8+itA5OgFmxCbp80a
         5k64jyOySxRfz7f/PGQLO6XUc626vtoj4mx762YmKkCz8wijijeKpyxG/zFzhaU2TKrr
         sIAMIrxSDhX5GzOPAsyktyICTFyfvZ2PHJEYjDYpfR+Ca41Z7FAu8dLMi6ZZmku1q0/C
         FbHN0k69t9dnzXVkqa/+7oO3mhxopxtmbho61Sb+NdfbAZkzWNUC6aeB1BJNn697O0hH
         g2yw==
X-Gm-Message-State: AOAM533rGz4Fq4FLsLANfnRpPRCiUojFq8oyN67gu9qooI9NfLTfpfsK
        GOdqL6ZYjKuXpp5DaUfQK5+ncb6iZ7ogArYmv3HUGQ==
X-Google-Smtp-Source: ABdhPJx46cwsZAPTk7xADrpjLswh2jZ2RWz0/XBNMefSDCHrAKWZDNbXjH4pAv01Lms1i1d6DR1r6h75l/y09/ITdeY=
X-Received: by 2002:a05:6512:243:: with SMTP id b3mr16860525lfo.529.1617025489839;
 Mon, 29 Mar 2021 06:44:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210329015938.20316-1-brad@pensando.io> <20210329015938.20316-14-brad@pensando.io>
In-Reply-To: <20210329015938.20316-14-brad@pensando.io>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 29 Mar 2021 15:44:38 +0200
Message-ID: <CACRpkda78p=aU5xfT+HtC9OCkZdkVEiN64F1jck2FDJB02C+Rg@mail.gmail.com>
Subject: Re: [PATCH v2 13/13] gpio: Use linux/gpio/driver.h
To:     Brad Larson <brad@pensando.io>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Mar 29, 2021 at 4:00 AM Brad Larson <brad@pensando.io> wrote:

> New drivers should include <linux/gpio/driver.h> instead
> of legacy <linux/gpio.h>.
>
> Signed-off-by: Brad Larson <brad@pensando.io>

Fold into patch 1 as indicated by Greg.

Yours,
Linus Walleij
