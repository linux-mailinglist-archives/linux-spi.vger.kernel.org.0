Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62D6F2AE54D
	for <lists+linux-spi@lfdr.de>; Wed, 11 Nov 2020 02:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730254AbgKKBIc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 10 Nov 2020 20:08:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727275AbgKKBIc (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 10 Nov 2020 20:08:32 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE13C0613D1
        for <linux-spi@vger.kernel.org>; Tue, 10 Nov 2020 17:08:30 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id j205so865527lfj.6
        for <linux-spi@vger.kernel.org>; Tue, 10 Nov 2020 17:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OKnTpb6WDK79h6wzA/BGMIqbAHNaR/GEp/A0ryb8Y1s=;
        b=ST83Kv6mMeTo+80B4tYYL95DnnqVTImdY5ZZb3uEwhr9CRDv2QHlUfRCNcmxIoMHuc
         +kHBzQG7KQA5gBSNNuGb9jqENXxRGimjrlkEkZ0K+lpssMvOVnK4JbS8L4O8wBgq2UNB
         ykrpf8YV4mHTIUtsErKhFjpGIpRNLKk3iIHMa0aXTLWvUqQTOBB8Q/2nbecCIAvjFFTg
         iE2FFBrv3xPe9vSOjZvcNcrzz6G4hA3JcoMq1V3P9wmmp5wy/1JmAhAQQ7FNvkoSk3KG
         TAOKk3y3pJJDeuO8ZU7NgyXI6ByFBJVT5cDcoMLhw1/hDGsL++oo6AgN8wxNZQrUspEh
         18YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OKnTpb6WDK79h6wzA/BGMIqbAHNaR/GEp/A0ryb8Y1s=;
        b=khK0NyYmZFzCl3Rvf4W3GGMVNCJs9MyWSoDBWNwIUVsEz37Q5vz1YfIZ+wh1juWpuH
         AMeVnTxNkyrPwl1AGujBEmK9AHzOCwnhZFf2XrUsmJOC/mC2ftLV+W2h3H3wWRBls39M
         DOSGH5FT2bgWusR/oMZfjw784xaAIAvPU4rKU4WaVJF+vXtSX3wzZEZSjhcsT92BcyvI
         ryMxaXuq45scixs8h1AF2UPExgILy44Wz/9w6FgEutOmV4DIp/rsHwQBBtB+hs5s51Gr
         6GmpdGqT/eoQnJLJN8XZKvTmiRPt1LK/15PBDlT0tmNJJO6o2+Y2yz2s6pP60VbswaDK
         hMnw==
X-Gm-Message-State: AOAM533KI5Wh7x0Cbb8GUOfnIXcXjzV3KRrwuAnzTqKrM14oNboGhlLu
        l14cL38LYRJrznmf6Fnq/Vt7F7YzBXPU1lME8CFhFg==
X-Google-Smtp-Source: ABdhPJyTz8edr2BkyMyzpSGiwVzBOi5L8wucnKcO8juRdvYXVu85AtYasLPNSH9oTli6dkFHHgq6lfKAkHprd/QE7Bw=
X-Received: by 2002:a19:5e0b:: with SMTP id s11mr7865088lfb.502.1605056907439;
 Tue, 10 Nov 2020 17:08:27 -0800 (PST)
MIME-Version: 1.0
References: <20201106150706.29089-1-TheSven73@gmail.com>
In-Reply-To: <20201106150706.29089-1-TheSven73@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 11 Nov 2020 02:08:16 +0100
Message-ID: <CACRpkdbti4j+oL8=7i=G8YOGjpNre9X5dMs+HH0vLA4QpYPD0A@mail.gmail.com>
Subject: Re: [PATCH v1] spi: fix client driver breakages when using GPIO descriptors
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Simon Han <z.han@kunbus.com>, Lukas Wunner <lukas@wunner.de>,
        linux-spi <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Nov 6, 2020 at 4:07 PM Sven Van Asbroeck <thesven73@gmail.com> wrote:

> From: Sven Van Asbroeck <thesven73@gmail.com>
>
> Commit f3186dd87669 ("spi: Optionally use GPIO descriptors for CS GPIOs")
> introduced the optional use of GPIO descriptors for chip selects.
>
> A side-effect of this change: when a SPI bus uses GPIO descriptors,
> all its client devices have SPI_CS_HIGH set in spi->mode. This flag is
> required for the SPI bus to operate correctly.
>
> This unfortunately breaks many client drivers, which use the following
> pattern to configure their underlying SPI bus:
>
> static int client_device_probe(struct spi_device *spi)
> {
>         ...
>         spi->mode = SPI_MODE_0;
>         spi->bits_per_word = 8;
>         err = spi_setup(spi);

I feel torn about it, there are so many weird corners of semantics
in this code. The patch makes the code easier to understand
too.

If it provedly fixes more than it breaks:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
