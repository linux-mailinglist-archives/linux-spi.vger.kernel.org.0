Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A40B9222484
	for <lists+linux-spi@lfdr.de>; Thu, 16 Jul 2020 16:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728996AbgGPN7e (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 Jul 2020 09:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728799AbgGPN7c (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 16 Jul 2020 09:59:32 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F82C08C5C0
        for <linux-spi@vger.kernel.org>; Thu, 16 Jul 2020 06:59:31 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id h19so7202925ljg.13
        for <linux-spi@vger.kernel.org>; Thu, 16 Jul 2020 06:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lZC+VUIMSIdeiW4C+7bhtdxicqg0klJV1GCIZXtbGAA=;
        b=E3j3mH3r+XkBoto3dQuOfETz6ViU9Snkp2Koila0Uf+neOY8KxhS7M8s6meXWiWRn0
         rC5I583w3pAokCM95whNcx/gMkitc48zcX1BHKjGkc8/Q5gnu1l3s69VzIJBp1IPHfD2
         e3gIxZhPoKCtYb/zdidvFULdF1Ey509C5qVkRq5DnwhviNHwONZW/WeOlQPCV49rBobt
         r6OdGlqKMm8bHuVsVDaTNOunpXvtD+zkZU5b7sxSc3mgwDmYN0TlR66arJWX9kUq39ZY
         eN2ThecFcCanhZnsSwAG//+eDbzaVZRzCswiq4RI2kP4v+pxlUGr805zVOWDU3ZOlsN2
         hdVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lZC+VUIMSIdeiW4C+7bhtdxicqg0klJV1GCIZXtbGAA=;
        b=iSOYCngPqKxafvonAy5H1bCxdlId2bBBlbemS3i9QU3aCWTF7AQlQCSWMG75XOyImt
         NZhVE0q5KmaET7sfzaAjji36fPPoe/EE7xY68vluE55ybwBzk9mHpzGRKOQVy7031BMY
         7Dt6NLqmt9R2i3QddHfKBlTHHfcNueduQocydbB2E8+QSlRIq+k0LnU+z7IUIBx0buM9
         gq4a/DdC2yg2GyUknKNwsDOXBseqoZplbP/lmy8MkKV36TBRwfC0Nss1p6RjWEI7SOGU
         QmGY6zk94ORfQPhvrFupu6PF2zEWoZYTm/4DUPy3HJk/DoqDQoKz7f24RE/GclKEZnZZ
         eYug==
X-Gm-Message-State: AOAM532lrXd6QV5F4gRSS85k8scMILZTzZtrqwnhgXUp60fLQLAP9T/7
        kAhxMjEzXOTodldFVXIiB7nv2OyCraQLYsg+hqjFug==
X-Google-Smtp-Source: ABdhPJyfBNW+iS3vmrvvdIc4uq6KgXCHDA3QojwI2tgqo1YiWXX74TEniRPfv5JC52n/VfPedlfGiJPMJ5384sP6Siw=
X-Received: by 2002:a2e:8597:: with SMTP id b23mr1938808lji.338.1594907970394;
 Thu, 16 Jul 2020 06:59:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200715150632.409077-1-lee.jones@linaro.org> <20200715150632.409077-9-lee.jones@linaro.org>
In-Reply-To: <20200715150632.409077-9-lee.jones@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 16 Jul 2020 15:59:19 +0200
Message-ID: <CACRpkdbFWy9wkMbegtL+nKG2RNvBADuxCxDRJTP8f0QGgUHZ3A@mail.gmail.com>
Subject: Re: [PATCH 08/14] spi: spi-pl022: Provide missing struct
 attribute/function param docs
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Sachin Verma <sachin.verma@st.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Jul 15, 2020 at 5:06 PM Lee Jones <lee.jones@linaro.org> wrote:

> Also demote non-worthy kerneldoc headers to standard comment blocks.
>
> Fixes the following W=1 kernel build warning(s):
>
>  drivers/spi/spi-pl022.c:304: warning: cannot understand function prototype: 'enum ssp_writing '
>  drivers/spi/spi-pl022.c:330: warning: Function parameter or member 'loopback' not described in 'vendor_data'
>  drivers/spi/spi-pl022.c:398: warning: Function parameter or member 'rx_lev_trig' not described in 'pl022'
>  drivers/spi/spi-pl022.c:398: warning: Function parameter or member 'tx_lev_trig' not described in 'pl022'
>  drivers/spi/spi-pl022.c:398: warning: Function parameter or member 'dma_running' not described in 'pl022'
>  drivers/spi/spi-pl022.c:670: warning: Function parameter or member 'pl022' not described in 'readwriter'
>  drivers/spi/spi-pl022.c:1250: warning: Function parameter or member 'irq' not described in 'pl022_interrupt_handler'
>  drivers/spi/spi-pl022.c:1250: warning: Function parameter or member 'dev_id' not described in 'pl022_interrupt_handler'
>  drivers/spi/spi-pl022.c:1343: warning: Function parameter or member 'pl022' not described in 'set_up_next_transfer'
>  drivers/spi/spi-pl022.c:1343: warning: Function parameter or member 'transfer' not described in 'set_up_next_transfer'
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Sachin Verma <sachin.verma@st.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
