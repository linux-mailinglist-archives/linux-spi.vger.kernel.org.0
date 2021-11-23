Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5C6945A992
	for <lists+linux-spi@lfdr.de>; Tue, 23 Nov 2021 18:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235873AbhKWRGT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 23 Nov 2021 12:06:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235249AbhKWRGT (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 23 Nov 2021 12:06:19 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F71C061574;
        Tue, 23 Nov 2021 09:03:11 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id r11so94992197edd.9;
        Tue, 23 Nov 2021 09:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U6jALudFHQvyvJHEV0b2RMHJqiK60umjau+aze/FElM=;
        b=kc+WqHAK67dwN3O+m1BR1r0+WGPP0QsNKe797r0yVF2GUNB/FyMgHmdBVG7Et0rh09
         bWC/LRCBItuOJ+XfsUMPSLze9d+R6QRBWOfi7wddIix77cv4IK9mxtlZJx+Z9pGWN1Fg
         iEdPrtrgWr8VXHvZbhaXRHRmqDjaRCIi0ZJHMuG/GqMCb3QiY53ACxOOk9095cBqwHrV
         jEo4ai6q/hFANDYvYW9l26gwgvcI8Ns5G6y6Fc1g8iQL5zchrTI3Z3uHhl3WidtTKneU
         vsfKzgc0kPu4HN4bMgeLmk+6r0vsOv2BsscX56fbP7ecmYaZDE/kxyCEmCzSjJtJt6qi
         c20A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U6jALudFHQvyvJHEV0b2RMHJqiK60umjau+aze/FElM=;
        b=QpsqvlYlUsYGvMfwEJDRXGfa28eEvQOyj3aU3FEKd6lsNQMZshik2U/RXfmBcqFRhY
         uFtvxqSy8WBROXlvvPcxvUes5562kpR3ZWJf6GBdlSPm4bP07y7Q+iaF9EDBq6QQQKXR
         E9WVgOBvlcj1Ji9+1zuUzM629io2dXXNMqbpJ0pG0EhclY8HE96AoGYisP3czhIgbJ1P
         U1l+XuBKPbQa9bEPbDiW5zT62UVwMOU2nAoa0dzshjWCrcjfFC6ZPB7+BPmjw8PNol1D
         Z0AX+8QK1zp7Q1Fkwq7NHUtyT3/+Y3E5CO34ok9xg4KuOQK5rFikVDGlBbYWRJOd1vml
         ilfQ==
X-Gm-Message-State: AOAM533UNKktfo+vA2q6fx6jjJruPv4rjqBR7C59FfpdNDKCk2N0OVrt
        vXsHzyfYAr23rikFaLAt5hgBEzDEAB2ejAzndv8=
X-Google-Smtp-Source: ABdhPJwNKn59/g2sFNpa9NbXm5Wemahhna2OVadG1km53xcWONc0ZwEYVfZi+8VRJTbJ5xtRpAbdW+H8GAZ8ulW7RTk=
X-Received: by 2002:a17:906:489b:: with SMTP id v27mr9336960ejq.567.1637686989831;
 Tue, 23 Nov 2021 09:03:09 -0800 (PST)
MIME-Version: 1.0
References: <20211123170034.41253-1-andriy.shevchenko@linux.intel.com> <20211123170034.41253-3-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20211123170034.41253-3-andriy.shevchenko@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 23 Nov 2021 19:02:32 +0200
Message-ID: <CAHp75Vf6HhvYb_H71E17vuCsbN_feUVNv9NO2Ns32MKJKOmeVg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] spi: Fix multi-line comment style
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Nov 23, 2021 at 7:01 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
>   /*
>    * Fix multi-line comment style as in this short example. Pay attention
>    * to the capitalization, period and starting line of the text.
>    */
>
> While at it, split the (supposedly short) description of couple of functions
> to summary (short description) and (long) description.

This one is already applied, seconds before I have sent it.

-- 
With Best Regards,
Andy Shevchenko
