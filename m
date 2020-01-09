Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 206071352E3
	for <lists+linux-spi@lfdr.de>; Thu,  9 Jan 2020 06:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbgAIF6F (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 9 Jan 2020 00:58:05 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:33853 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbgAIF6F (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 9 Jan 2020 00:58:05 -0500
Received: by mail-vk1-f194.google.com with SMTP id w67so1669202vkf.1
        for <linux-spi@vger.kernel.org>; Wed, 08 Jan 2020 21:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2DjPx1eV8QPqDcx/sjKIxavtaGi+2Rmdyzg645rvwrI=;
        b=Dh0Q3XCsP8JwuJIY/YsgboRS+BQfU1j6Z3n8g/IjRVnL+ysomvfZeFLXAT/kwIjKnY
         O9+XWiunCbvfaklvqvMDu+wOpsVlnAIeVGR6lAnUXSulFNCxc8kk5p4QWd7cvUmtp68v
         eNBWjB+XmNZfoVvnvpBg5rEMLgvomBmINlHg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2DjPx1eV8QPqDcx/sjKIxavtaGi+2Rmdyzg645rvwrI=;
        b=AUgdBoUoAVo7hqSYH2yZO8rUP4R16KPgU8oZyGb5+wJQQefurcGw8ntQLK5cVOr1Cb
         ZQFwytD5/ZUzM9244o9rweSDq85/AW8Six1xOhNcV+9ElLCbZBTvATdaL2RO45t4BnTw
         bi0/A4pQnR3D2/kWdx5ji0kQCH9GGv9ADDKCLj4ILwOI2zfoJq+3fbIWHPBfUScQve9U
         tT/Gngkvqbv2+NZbOMO46z30RW/FBgthezCuPgIydF7X7Sz1+Jus9Qa4pd/decaTJFtJ
         BuXNFh5vzb2SDLMMsEPnEuPn5PYM7nGOWXqyKUzvecbHQG7oyAfxv5wI0xHGbgbZVxaN
         BG6A==
X-Gm-Message-State: APjAAAUj+rZau5RfoGE0FTSZzpVIXXPLE01jJ1oYP3z1nDXw6ul/8Lc2
        ckknhPHU9TYvDUHYA5InAlmBW+wOu2E=
X-Google-Smtp-Source: APXvYqx65UTjG3S/RPsFwB9UWB4A1RRIBW+nzm+xAhRONasTisPllD5pmtKqIoC9txOAJknBvum5Zg==
X-Received: by 2002:a05:6122:1065:: with SMTP id k5mr5713341vko.14.1578549483789;
        Wed, 08 Jan 2020 21:58:03 -0800 (PST)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id r1sm1454905vsi.33.2020.01.08.21.58.02
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2020 21:58:02 -0800 (PST)
Received: by mail-ua1-f48.google.com with SMTP id f7so2062686uaa.8
        for <linux-spi@vger.kernel.org>; Wed, 08 Jan 2020 21:58:02 -0800 (PST)
X-Received: by 2002:ab0:724c:: with SMTP id d12mr5861475uap.0.1578549482261;
 Wed, 08 Jan 2020 21:58:02 -0800 (PST)
MIME-Version: 1.0
References: <20200108133948.1.I35ceb4db3ad8cfab78f7cd51494aeff4891339f5@changeid>
In-Reply-To: <20200108133948.1.I35ceb4db3ad8cfab78f7cd51494aeff4891339f5@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 8 Jan 2020 21:57:48 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XREb0zf=BxwKF7jGO7fwtwQaO+vR1giodsW+RkHZe_XQ@mail.gmail.com>
Message-ID: <CAD=FV=XREb0zf=BxwKF7jGO7fwtwQaO+vR1giodsW+RkHZe_XQ@mail.gmail.com>
Subject: Re: [PATCH] spi: spi-qcom-qspi: Use device managed memory for clk_bulk_data
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Andy Gross <agross@kernel.org>, Mark Brown <broonie@kernel.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On Wed, Jan 8, 2020 at 1:40 PM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> Currrently the memory for the clk_bulk_data of the QSPI controller
> is allocated with spi_alloc_master(). The bulk data pointer is passed
> to devm_clk_bulk_get() which saves it in clk_bulk_devres->clks. When
> the device is removed later devm_clk_bulk_release() is called and
> uses the bulk data referenced by the pointer to release the clocks.
> For this driver this results in accessing memory that has already
> been freed, since the memory allocated with spi_alloc_master() is
> released by spi_controller_release(), which is called before the
> managed resources are released.
>
> Use device managed memory for the clock bulk data to fix the issue
> described above.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>
>  drivers/spi/spi-qcom-qspi.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

It's a little ugly, but it seems somewhat same.  Basically we're
saying that the caller of devm_clk_bulk_get() is in charge of keeping
the list of clocks readable for the devm free function.  Maybe we
should also fix devm_clk_bulk_get() to always make a copy of the
clocks so we can relax this limitation (though that's a lot of extra
copying for the uncommon case), but even if we do change that your
change would still be OK.

...so from my point of view:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

-Doug
