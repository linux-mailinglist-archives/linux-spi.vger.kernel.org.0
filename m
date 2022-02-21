Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 005E44BED08
	for <lists+linux-spi@lfdr.de>; Mon, 21 Feb 2022 23:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233190AbiBUWK5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 21 Feb 2022 17:10:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232574AbiBUWK5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 21 Feb 2022 17:10:57 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3086522BE8;
        Mon, 21 Feb 2022 14:10:33 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id c23so13003679ioi.4;
        Mon, 21 Feb 2022 14:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z+rAJszSEvmqBNoUmCp25Rx7tCIKTIKIJ/vzygiTiNU=;
        b=S7pZm6u3CUoSRWhIevbFJ7iuyoYizjOdMSrxZ8r5RYDp1p/T4i4IpM0PCpfmdSAVcL
         UspswO6GnBhtK4pnq1X6wszMSj9Qbsyo1bmUaKtW5ECHW+tAFw/cx98GWGBDlrl/ZEbm
         /us86SMszml4cBbd63fB8JUK3oLLh+VA4qLagehggzFdAXcivvtO6gvP7v9QqVDieBJk
         PqYhMZFivFCM10K4TFHmmcpRLeSofD39RY1xNLxwjRSoXzkpHbiwh2Zd0HQ3keaph3qb
         DrH064wnjRX3k7hlMa9QPxwj4aVFWmTjvbcD6ssLzl1xv9zmUa4ADZ4sR37IKZwuF4HQ
         no2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z+rAJszSEvmqBNoUmCp25Rx7tCIKTIKIJ/vzygiTiNU=;
        b=rOZHwkH64W2WSNtvTYIq4gTTfwm1KYUYeDOy7c5h/ByiFI1mhBx8JZsEc/zGooLb1K
         UIFasiX5yRg55qgXj9LqBUM+ASporjiAewnLAq0rEH/6LyIyJ84fI4/i/z5/SsrDOuxI
         jK/G/jwkteRxj+gM3vd9cRdAlJbF28jMkEGhI6C9n+C947hQ46EKhKdw1fqz8mx5dUnt
         o2vI0gGdhwg+2Cu0F8rXGStLFGK6t0RrTyAlKNeP3BXwlB7dUicY+acU/kddcoE/xR45
         8y6BOQgnoZ2W4nKbLehZ74R1/YbfwFFVsViwICfkDVrYGcXVfM6MNM/ujSJ37e+u9TG1
         yWGQ==
X-Gm-Message-State: AOAM532DhD0bdI9GroxLs8C9w3AcgxDPEB6z+jMGhq3wrKMKUkW7L9tF
        6R5cTY1FoOxDJ0l9HDS9eZdpU5axjSINlcNigkU=
X-Google-Smtp-Source: ABdhPJxtX6h0gkfIJdOs/LpUaxa9CUaWdh6MY9eyTlILX66v8ZCa3R/8q03D8mwPRfzvvOim7xMhQagxBJ4rkaaFK7U=
X-Received: by 2002:a02:a1ca:0:b0:314:c448:2a4e with SMTP id
 o10-20020a02a1ca000000b00314c4482a4emr10360369jah.186.1645481432583; Mon, 21
 Feb 2022 14:10:32 -0800 (PST)
MIME-Version: 1.0
References: <1f39432b-84e2-e6dc-a6b8-c48ad5cf2210@gmail.com>
In-Reply-To: <1f39432b-84e2-e6dc-a6b8-c48ad5cf2210@gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 21 Feb 2022 23:10:21 +0100
Message-ID: <CANiq72ko6=dYBvbRc5T7Qq_2mxRtq1NpvcV_saMbTDfz0PK1aw@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] auxdisplay: Add support for the Titanmec TM1628 7
 segment display controller
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Miguel Ojeda <ojeda@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Feb 21, 2022 at 9:19 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>
> v2:
> - (re-)add Andreas' SoB to two patches

But those were also developed by you too, right? i.e. it should have a
Co-developed-by too, otherwise it looks like you only handled the
patch:

```
Example of a patch submitted by the From: author::

        <changelog>

        Co-developed-by: First Co-Author <first@coauthor.example.org>
        Signed-off-by: First Co-Author <first@coauthor.example.org>
        Co-developed-by: Second Co-Author <second@coauthor.example.org>
        Signed-off-by: Second Co-Author <second@coauthor.example.org>
        Signed-off-by: From Author <from@author.example.org>
```

Cheers,
Miguel
