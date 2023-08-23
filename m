Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D70277850E9
	for <lists+linux-spi@lfdr.de>; Wed, 23 Aug 2023 08:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbjHWG4F (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 23 Aug 2023 02:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233049AbjHWG4E (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 23 Aug 2023 02:56:04 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF448E67
        for <linux-spi@vger.kernel.org>; Tue, 22 Aug 2023 23:56:01 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id 71dfb90a1353d-48d14d11756so1099072e0c.2
        for <linux-spi@vger.kernel.org>; Tue, 22 Aug 2023 23:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692773761; x=1693378561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lB8ZbVq5sQ7DzHOBHLugPDAWi9TKXlIcXjvdJWhqI+A=;
        b=IClLffrpZcMu+6LKkWMb2iYMjsTjrkaUqrYA7WVBTBrZu8Rk9cEmTcQpNzwliaEYOs
         Fh9iUcv2UOIcNrn97Bt9kXa9oRjEbVR0W3uxBGa2NbMYqsgayR3isNmKww9L5bY2Y7HI
         RatRDyLvwjy/V+In9dVfKaPi6OaFcpK+NDakk0Nv89OnO9fYh5YklBNNKQABownwxaLy
         Vc/ih1L6v1WPG18V+1O9nhhKRxifefgFowtPdN/aKz/n20BVZNJSUY38+FJAGH0gEmZp
         idlDOcjuIoF4kaalYRzuLi6zFQOZYQjBzp9E75g8QeWRgjkGt3ZOSHq/LO3lLUIy5rai
         33EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692773761; x=1693378561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lB8ZbVq5sQ7DzHOBHLugPDAWi9TKXlIcXjvdJWhqI+A=;
        b=B0RzcZMX6n9gWfDBqCVMtMIF7fLMLg8nZGSnHURQ1B9KpgcfYojgCs2ZrUCUu7CBWN
         A5odSogLRgYooZcDOVHKNWIdY44gdFp+tduGjbUUmfkGCVRrTjXNDFyjJIW/18EhyxPt
         BnutBkd7rZc5LGEbWaRKuDeU74SgHx2arulSDtK9gKlFdCmEgtxQpkA8eJOFC0qdilgH
         DbJ+hTSdNghSbYJ2VZqwHfnpUTip1/fnmr1VYWZoyNKdm08pEol0BcJEahajPBhu8M7U
         JkWOwwCT8lBnM1hko35YSb6Ue50IvyC7y4ylBjzisFlmetqVhKQgQ4MK9x6dAU5Fska2
         q/Ig==
X-Gm-Message-State: AOJu0YxaXNvAJLYUaU+dRW8L5pFcmHfsKWNO4KVH08KQVpYnnm4T04jQ
        cU+H7xlo/WoA9p3NxlmIaA7EB2k3vFgGT6njuw+mPw==
X-Google-Smtp-Source: AGHT+IEwjcDx1d3S7SNyrAkvaRo8eUvQkQP4M2xlywseolmmO9jwKjqIKIoGVYIjaFiR0hfjVai9PSjnU42jN3gPoW4=
X-Received: by 2002:a1f:e2c2:0:b0:48d:13e5:1376 with SMTP id
 z185-20020a1fe2c2000000b0048d13e51376mr7597851vkg.10.1692773760791; Tue, 22
 Aug 2023 23:56:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230822131237.1022815-1-lizetao1@huawei.com> <20230822131237.1022815-25-lizetao1@huawei.com>
In-Reply-To: <20230822131237.1022815-25-lizetao1@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 23 Aug 2023 08:55:49 +0200
Message-ID: <CACRpkdY1Q0U6Yh69hW6FYJbDf7a94=UnwinuKaUnz6aqOaWaLA@mail.gmail.com>
Subject: Re: [PATCH -next 24/25] spi: spl022: Use helper function devm_clk_get_enabled()
To:     Li Zetao <lizetao1@huawei.com>
Cc:     broonie@kernel.org, chin-ting_kuo@aspeedtech.com, clg@kaod.org,
        joel@jms.id.au, andrew@aj.id.au, florian.fainelli@broadcom.com,
        rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, fancer.lancer@gmail.com,
        olteanv@gmail.com, neil.armstrong@linaro.org, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        conor.dooley@microchip.com, daire.mcnamara@microchip.com,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        heiko@sntech.de, linux-spi@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Aug 22, 2023 at 3:13=E2=80=AFPM Li Zetao <lizetao1@huawei.com> wrot=
e:

> Since commit 7ef9651e9792 ("clk: Provide new devm_clk helpers for prepare=
d
> and enabled clocks"), devm_clk_get() and clk_prepare_enable() can now be
> replaced by devm_clk_get_enabled() when driver enables (and possibly
> prepares) the clocks for the whole lifetime of the device. Moreover, it i=
s
> no longer necessary to unprepare and disable the clocks explicitly.
> Moreover, the label "err_no_clk_en" is no used, drop it for clean code.
>
> Signed-off-by: Li Zetao <lizetao1@huawei.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
