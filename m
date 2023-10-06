Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3B257BB1DA
	for <lists+linux-spi@lfdr.de>; Fri,  6 Oct 2023 08:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbjJFG7x (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 6 Oct 2023 02:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbjJFG7v (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 6 Oct 2023 02:59:51 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B050EB
        for <linux-spi@vger.kernel.org>; Thu,  5 Oct 2023 23:59:50 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id a1e0cc1a2514c-7ab5150a7b5so1950849241.0
        for <linux-spi@vger.kernel.org>; Thu, 05 Oct 2023 23:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1696575589; x=1697180389; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BYvSHxBG2dgNXVlRR25mBsYFXb3dSQ0zb3U7unZUfqw=;
        b=g4hHlfjRXYHesQJbBjTFAv9bKftD7PeNg9WUEZH2FwwgjbyaEPwoJzwidKDRWQW1qO
         WDn7vV1XDeK2XietdXcWuFLDg+u5vJu/BmtILeWHDGO1k42eCl1KbtjtOnaDQ78K+W4R
         RaeAN09GlD7/Tozj6+VIO5dSOZ7p8nRFIleo2Iqus5c9mYMAz79IJfu5RbM5h8WXjRU7
         rhyncxEMDpitlvT15/xgNmNE6T075UG0xpksVWNgob1VA3MuAzHZZnDeEToSxjmyAQVB
         dE9jYlLSFoThywxfzIYLwPcZYe6tfpIp8Sy13bH90xgqHqaoWNuKTOWOTcgyhgsoIxJa
         MC+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696575589; x=1697180389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BYvSHxBG2dgNXVlRR25mBsYFXb3dSQ0zb3U7unZUfqw=;
        b=uS0Dy24B3zulxuv7ma2JvP6JYKsBBMrwE7nUHdtx7xYp3W6H2eblP1YePMotDXF2wC
         drLpbWbkFReKSMYxyW5rd8lBzVGDATSxwtgu51StzwyBGCk91PH3wBGq5k20p+ElpT53
         1QwQ5H3b5L2DHcNwgGEhk8zGZqWFuLHg2BSlf3eF7nSdeO62F4ZOOgTuzKhRfmLSAXZA
         vSDZQUGS0qABt0T1s+mOofmL3SHFs6JUPlKpHZQreBRDz0tsJXRfQdE8p03xgejPug0F
         gXUSL7r8nvqicwGHbEdAHaFVMnTJZTRu+dknjU7qUkgIPYhIvTECjgGXAKU2sINGcpzU
         OvWQ==
X-Gm-Message-State: AOJu0YwckCse0jq6HVDZsWIzFGuP6H/haAU1ilVDDa2J2gkx4DrcANDq
        kV6lA90rtjg9pkWSPvvtjKD+xbS6nirODhqz2nnxiQ==
X-Google-Smtp-Source: AGHT+IEFQXqpGHLnM1FoYxvyZhgGdxF+IAsWxgHanS/EWlcNwUGbusUbSG2isF3zOwbEIeEijyGpNXRzW8TZusWDy4M=
X-Received: by 2002:a05:6102:41a2:b0:452:7341:a098 with SMTP id
 cd34-20020a05610241a200b004527341a098mr2236364vsb.0.1696575589168; Thu, 05
 Oct 2023 23:59:49 -0700 (PDT)
MIME-Version: 1.0
References: <20231004-pxa-gpio-v5-0-d99ae6fceea8@skole.hr> <20231004-pxa-gpio-v5-3-d99ae6fceea8@skole.hr>
In-Reply-To: <20231004-pxa-gpio-v5-3-d99ae6fceea8@skole.hr>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 6 Oct 2023 08:59:38 +0200
Message-ID: <CAMRc=Md5A5Ki-TKTYbv=nLcgLtwxxUAQaU99ijkatoomMgS31w@mail.gmail.com>
Subject: Re: [PATCH RFC v5 3/6] ARM: pxa: Convert Spitz CF power control to
 GPIO descriptors
To:     =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-input@vger.kernel.org, linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Oct 4, 2023 at 4:56=E2=80=AFPM Duje Mihanovi=C4=87 <duje.mihanovic@=
skole.hr> wrote:
>
> Sharp's Spitz board still uses the legacy GPIO interface for controlling
> the power supply to its CF and SD card slots.
>
> Convert it to use the GPIO descriptor interface.
>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Duje Mihanovi=C4=87 <duje.mihanovic@skole.hr>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
