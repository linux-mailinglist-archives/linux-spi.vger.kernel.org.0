Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F63F25DAB7
	for <lists+linux-spi@lfdr.de>; Fri,  4 Sep 2020 15:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730449AbgIDN5f (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 4 Sep 2020 09:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730686AbgIDN50 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 4 Sep 2020 09:57:26 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80368C061244;
        Fri,  4 Sep 2020 06:57:26 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id c2so8023548ljj.12;
        Fri, 04 Sep 2020 06:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hoXXqd8o1tMS9WjpaTwn6JIuueqXzxlr8fJ8ASQWetI=;
        b=cB+oUoplgC6GyIFVtcLejHJV/VcvpasFda3aA7jC4OvseF5QmxCPplLaZ/3CmGESHG
         I/lemT2CDw1SJ22GzYzixEWVeN+w+9XBLwPsmUCFB49z93hHInL+8ABC4pbL3ulr07NU
         zeQYE3deleybCtihNK3FHdJ+iJ4/pHB9jWuxoQrQO+ghVZgxcGeLBfSjSjBxZjb3nPL6
         d+2As+CqoO0AIHUB0vCch7UcVZHjSJ1KLDeiqPU/xq5uJ/8eNuW1aGch4TT4n8wRfAtl
         2LjxqwFcjdB0sVFUbjxnBP39gVu270eetm1ZB1ZgsFOCIMUNSSSoqHXCLqfZfRnoJRlD
         6fNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hoXXqd8o1tMS9WjpaTwn6JIuueqXzxlr8fJ8ASQWetI=;
        b=E5q60vQDu1T3IbgY6LXBcpItHoNzruU5jhVgbJeS3nLBieC7GJfXu3dHX0skQiQWCu
         sulOHWSX67DWgTxCFl9Cbc9LJdvOVtGe4xr0Tovoe7D9bS3f5NRrUlQIBc9MHwwNiPqc
         eoQiNwxFIXKct9dkbKkJ9GmL+IgkZjMtJzZb/fXlf0sn2rhiXMr7foL7dqwrF2LjIC3p
         IWZc2PBUuJ6uY/RPjoQUqAKVwxZGyLIQRwoevF5Are8rxVkTd47wAfKjugGFeTzTUXnb
         9HptX3ecjaTLkGa/CM6NdT2YdvO4jGDQg5+0bEWDDWjyxnTghmmYevJE1jWG5yoVg5oS
         jfQA==
X-Gm-Message-State: AOAM533OfZg0gft6/k/P1wuMX8GKIcWiVhlrp2c55rx4y5ms5qTRDGrx
        lcbE1nttlUXSyywR8SOSqHMhJphUuxD/jJCRZfmDAc1I
X-Google-Smtp-Source: ABdhPJwRaXPdWvGuBAjCghQkCAqkNiK8C3mycScQket1zO5nYHPMm/DqD/BvM0eDN0424CFuDOv01ZIoV1aYuWJT794=
X-Received: by 2002:a2e:390a:: with SMTP id g10mr3629117lja.218.1599227844699;
 Fri, 04 Sep 2020 06:57:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200903144028.20416-1-matthias.schiffer@ew.tq-group.com>
 <CAOMZO5DGHoG_8X+fbrGCHR4g=sGdEaF7bYrHbC_2T=aUnfTs8g@mail.gmail.com> <e1431dd2653dbffdfec39a2e7167db07836e30ac.camel@ew.tq-group.com>
In-Reply-To: <e1431dd2653dbffdfec39a2e7167db07836e30ac.camel@ew.tq-group.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 4 Sep 2020 10:57:13 -0300
Message-ID: <CAOMZO5C7yyA11EOQvU0Fq-uDd5RK-B7WmbtvAy8OtPzfThYXRg@mail.gmail.com>
Subject: Re: (EXT) Re: [PATCH] spi-imx: remove num-cs support, set
 num_chipselect to 4
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Sep 4, 2020 at 10:02 AM Matthias Schiffer
<matthias.schiffer@ew.tq-group.com> wrote:

> This would make num_chipselect default to 1 again (set by
> __spi_alloc_controller()), breaking every i.MX board that uses more
> than 1 native CS.

Which boards are that? Are you referring to non-DT i.MX boards?

If so, I have sent a patch removing all non-DT i.MX boards.

> I'm aware that using cs-gpios instead of native CS is probably a good
> idea in any case, as the native CS of this SPI controller is kinda
> flaky (and at a glance it looks like all in-tree DTs do this; not sure
> about board files that don't use DTs?), but I'm not convinced that
> breaking native CS support completely is desirable either.

Initial i.MX chips with this SPI IP had issues in using chip-select in
native mode and GPIO chip-select has been used since them.

Do we have i.MX dts that make use of native chip select?
