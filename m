Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096767B4E41
	for <lists+linux-spi@lfdr.de>; Mon,  2 Oct 2023 10:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236104AbjJBI5z (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 2 Oct 2023 04:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235997AbjJBI5p (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 2 Oct 2023 04:57:45 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1762D40
        for <linux-spi@vger.kernel.org>; Mon,  2 Oct 2023 01:54:28 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5a2379a8b69so36571627b3.2
        for <linux-spi@vger.kernel.org>; Mon, 02 Oct 2023 01:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696236867; x=1696841667; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SAHGe0Dh0hTiu77ede4jd3f5FD+aqZVWssvCBucRdDw=;
        b=x+rCB5P0HkIE4YZ0A0EF23AnFJ6/bHqPz17K2I0HhU69pCtY8vnw4nVu1mN7jOqZOk
         uRKEAfz5IWwj82uwdBNh9BtZWmgWfL31yejXEm2cwIRCaux7vs3/yRrayCuQ/jsDHzDi
         +abzVezajzIhLbUYC0CKP3tjl4q9Lv3MN0juTymENW4u6j19RSBK+9Ku6EhnlCjLsbmT
         3E9qgIrCtATJsFWiUbmgn4ZAMoaRMxumE1tDlIZzeiWfa6Q1opTQ0DE5QhW994Nt0oVD
         4P+f3LTFuubQ6eOGoTR4UrBuwTiDHxSIrPKNvlqxITWR9/dRdaGZtyufKhlwv3a6ql9w
         k+UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696236867; x=1696841667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SAHGe0Dh0hTiu77ede4jd3f5FD+aqZVWssvCBucRdDw=;
        b=A3cPEwENtlxUKyQHch7yfVeJE7t8qrAQ/qDUE82IdQINtq6GzLhuwITvEx00QbefF6
         2k5KqHDbMG8CrjhSX/PLujt+RVb5/MKjwerYVIEc1mjMaOCNYFZPlW2p4FMnDJn2dmhI
         B7hYjQSd4866lN6QY4Ed3fsngvc9TvfYfWDSuyX6vBtkDw6pDdBTckwU6Xkg0HxkLw2g
         MNbhgP+gDJiOe/TBmtfIBo1ee5AizQc7KPbjKmxzB299Mo2c/cYBhgeE2RgWoatI59NV
         OJ+HGj96o5acjHAeihOVLmKFFEBeWpoPasOQc51CKVqbMdJnt6XoKmkt7rdaQ5uv6lyx
         ejvQ==
X-Gm-Message-State: AOJu0YyAhp7/JJit7IlzhVN0XpFQLcQplu9zp8X/armCW/0lTIbZSldZ
        U4GFd3BTMKjx5fkZkwtBU+2Lp20P4l+SEuenDzqnyw==
X-Google-Smtp-Source: AGHT+IH3xhl+OqZLFGjc/FIIZK7vVneZIRUfkgmVwUJ1Lbcx2j8iWEa2u1r3zv87HGXUt/qD+sekTdSLdXL30TNvBos=
X-Received: by 2002:a0d:dc01:0:b0:599:b59f:5280 with SMTP id
 f1-20020a0ddc01000000b00599b59f5280mr10777800ywe.28.1696236866969; Mon, 02
 Oct 2023 01:54:26 -0700 (PDT)
MIME-Version: 1.0
References: <20231001-pxa-gpio-v4-0-0f3b975e6ed5@skole.hr> <20231001-pxa-gpio-v4-2-0f3b975e6ed5@skole.hr>
In-Reply-To: <20231001-pxa-gpio-v4-2-0f3b975e6ed5@skole.hr>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 2 Oct 2023 10:54:15 +0200
Message-ID: <CACRpkdbi9fcna_giYR9HubWYoR-ZfrxZK7dPOJR9vX1n5A8Vtg@mail.gmail.com>
Subject: Re: [PATCH RFC v4 2/6] ARM: pxa: Convert Spitz LEDs to GPIO descriptors
To:     =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-input@vger.kernel.org, linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sun, Oct 1, 2023 at 4:13=E2=80=AFPM Duje Mihanovi=C4=87 <duje.mihanovic@=
skole.hr> wrote:

> Sharp's Spitz board still uses the legacy GPIO interface for configuring
> its two onboard LEDs.
>
> Convert them to use the GPIO descriptor interface.
>
> Signed-off-by: Duje Mihanovi=C4=87 <duje.mihanovic@skole.hr>

LGTM:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
