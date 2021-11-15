Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8069345080E
	for <lists+linux-spi@lfdr.de>; Mon, 15 Nov 2021 16:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236510AbhKOPTF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Nov 2021 10:19:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235268AbhKOPSw (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 15 Nov 2021 10:18:52 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E083C061570
        for <linux-spi@vger.kernel.org>; Mon, 15 Nov 2021 07:15:37 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id g14so9814161edb.8
        for <linux-spi@vger.kernel.org>; Mon, 15 Nov 2021 07:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=89jkR8hzDI3MqGwPElGcBHtxq54ozan1YEQ/wOBkM7E=;
        b=O+XXJAibKAWoMU0IKSdQ5gXuSW8qYlQ+SvHQGbI0h2/zgyVBxt154gDnh3rL1J+Ajr
         OQrQfP8WcK7Vrxx3W5AcaISucj6Y4QR/EGZDTHD9a0HJPUORNlmBTvEo0OBUppH9PWNu
         AISJa+0YqcaO2vAzO5QH1fnEZGynDQW4iN1lHY5msMNZu+AoRF+/ANnFuOhYhplZQi4S
         wvYfKgJ/xG+Rf3gK4ZARiPLV+Pt1ZwA0ZXb5qJyYCEvRmrljPIGPtNrTssBk7UPOGr20
         HZOYnonqJJf43+8INwhu8UZrTMrzvClb/39SN+0oaOxqBoHX6+/qEIoRc4dWIgMLnV0a
         vKww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=89jkR8hzDI3MqGwPElGcBHtxq54ozan1YEQ/wOBkM7E=;
        b=xj8LjA9ReqHyoiIbEI1JvKG0TGm3fcDqRpb3f+GAF8JXJPg5PolU8S8x1wW7ieq4qV
         9frL2G5GNAGxxNE5KvfB1v0wqWGXXE99n3mh9qd6v3be11iFh8h/JUq5S5X1kE9fCvzg
         YEW29vk43aoLUAMvtPnXYk/UKmIwFhN4Yt7POxrnvlbeB47xzwWuYSmLtlWUJqMF74uH
         uNWxQs/qoSYu7hlrUzJr+L8wL6xSWGydpp2JmwDAbJlPHrT9qnGrtGdJgxA5sQMaGh3C
         ZzQRm+Yypz6e7JuJc0qv6fHi0s0AY9hprjN6jlSvOGBXgdig1pKO1qVX0EntNBjz72z8
         psBg==
X-Gm-Message-State: AOAM530+jRd6oOysVKdcUIXP4IHZYmtrXzoD/vWIKSvUAM7FEL/Az5/F
        K4RPstQ1EqC/dp8eZRRUqs8Tnx2QHVT8RfIrw70=
X-Google-Smtp-Source: ABdhPJy/o9pe9pEW5eDMLCQR7f+aOB8+nqbJoaR6t/NCTW6aUM6INIBA9wtJtDSXX7AVonYjE1Urf6MNb+tbmLQVYUo=
X-Received: by 2002:a17:907:869e:: with SMTP id qa30mr48157832ejc.356.1636989334515;
 Mon, 15 Nov 2021 07:15:34 -0800 (PST)
MIME-Version: 1.0
References: <d9ef0f42-4ebe-b7db-f18f-8652dcf38ca0@fbautosys.co.uk>
In-Reply-To: <d9ef0f42-4ebe-b7db-f18f-8652dcf38ca0@fbautosys.co.uk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 15 Nov 2021 17:14:52 +0200
Message-ID: <CAHp75VeAJ5QBcWmXwcVs8A_nzy9DRQ-eGjK1iuN2F1k1mXiv8g@mail.gmail.com>
Subject: Re: Remap, SPI and parity bit
To:     christopher tyerman <linuxkernel@fbautosys.co.uk>,
        Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, Pavel Machek <pavel@ucw.cz>
Cc:     linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sun, Nov 14, 2021 at 8:41 PM christopher tyerman
<linuxkernel@fbautosys.co.uk> wrote:

> I'm not sure if this is the correct place to be asking this, if there is
> a better place please redirect me.

I guess it's induced by your (?) posts on SO?
Anyway, it's the correct place to ask, yes. I Cc'ed this to regulator,
LED, and MFD subsystem maintainers to gather their opinions.

> I'm currently working on a kernel driver for the Texas Instruments
> tps92518-Q1 and tps92518HV-Q1.
>
> This device uses 16-bit SPI Frames (7-bit control, 9-bit data).
>
> is "Command Frame"
>
> |1-bit command bit 5-bit Address 1-bit parity 9-bit data|
>
> requires a parity bit
>
> |PARITY = XNOR(CMD, A4..A0, D8..D0)|
>
> I'm trying to use regmaps where possible and I can define a regmap, e.g.
>
> |static struct regmap_config tps92518_regmap_config = { .reg_bits = 6,
> .pad_bits = 1, // parity bit .val_bits = 9, .max_register =
> tps92518_RESET, }; |
>
> however so far i cannot currently see how to automatically calculate it
> without replacing large chunks of code
>
> e.g replacing chunks of /drivers/base/regmap/regmap-spi.c with a new
> regmap_bus
>
> some where i need to be able to calculate and insert a parity bit
>
> is there anywhere i can setup a callback that preprocesses the spi
> frames before sending?
>
> I'm working up the chain an i can see a potential patch to regmaps that
> would  fix this if nothing better already exists
>
> with regmap_config exists /@read_flag_mask/ and /@write_flag_mask/,
> along the same line there could be added a "@read_parity_mask" and
> "@write_parity_mask"
> and an optional "@reg_parity" callback that calculates the parity
> from/reg/ and /val/ similar/@reg_read/ and /@reg_write/ but without
> replacing the entire read/write operations
>
> I may even be able to write this but that is outside the spi-subsystem,
> and i'm currently not sure what list regmaps fall under

-- 
With Best Regards,
Andy Shevchenko
