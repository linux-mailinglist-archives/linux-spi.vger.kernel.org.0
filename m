Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34A212E7D20
	for <lists+linux-spi@lfdr.de>; Thu, 31 Dec 2020 00:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgL3XSI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 30 Dec 2020 18:18:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbgL3XSG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 30 Dec 2020 18:18:06 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3685C061573;
        Wed, 30 Dec 2020 15:17:25 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id x2so16044468ybt.11;
        Wed, 30 Dec 2020 15:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z8q0Nh83KQJqdrU3Ti3YzSkwdpifTCJmR0XUgZguW3Q=;
        b=WhUPBZY/x3x0VRC7PC223KPWQKbX6BbE2crEq/K7/wDpFGbvd1mfTTVKkg8p+aZdy3
         yCjRUtxHVk1lpX7EvXsM2FNNGz6K48BKWiVP9j4gvaWUU4c68KzOaHllkB0lmzqZEqSa
         jd7jfewbMlJIpxzRE3QgswTtksWV8L+62JLZ37W7Jjqf/88LM5e+R/2DHWEmQu8HsuwY
         hzxCDcbSDWJgdA/T7Jt71Ky+ewCTi+uOKqvLzXZojQiNsOSHZj4Kq62qo7Dt3Lzy/EsV
         WzSo0ADlVVkqA9B6K8VEkRajyebynpKybmJLjM0FOwVFf6Uraq8QwcjPrcGjbRzGSUOn
         mBCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z8q0Nh83KQJqdrU3Ti3YzSkwdpifTCJmR0XUgZguW3Q=;
        b=LwlOjxwQXVtW8X2PQ1xGsExeIKIHXEdXxsR8iXTFRB6woyx7J92fX8VwZK7Zy2b0og
         EkJcX1c0KI7iEaHEnpZvHv11Xsv79Oq4ZlCwoLyfT80teN8Klfwn7/bgxkx4oKGuNZRP
         9cl4DQXaSKr+3onP9Gvgai+t6nyk+O5LGfhaunMwbbKnUrFi9CQwwKZXS0/oMGwc8ZaV
         rSLK/DdFvtn28OvQbiQgx/SNHdk7USydUdc81HAbTvql+2k0WXDm04b2staC2VVx6RXn
         62U3YdpXZ5UpTsylQQSYYqbZOZ4QKHKxDWQKt/nMm+igriDkLD/LRToOYVY9DAvpPJ2p
         f9ng==
X-Gm-Message-State: AOAM532wr0Peh8DEMkj7QsfDNea/ZecebpTkWy2bCOnyuANIL6CnDgFo
        O4gVliKMaC+guWOftRkWBDxsFbBDv42WxYPhjG8=
X-Google-Smtp-Source: ABdhPJzt7E5JtXHWlwqtDFR/KU2YqC8mMoZ4CNWFAOvMWUHN23R8bq4hIVK6SJSJr3P1SIeOOjM8uLv8MiM88Rmqm6k=
X-Received: by 2002:a25:7c06:: with SMTP id x6mr16995551ybc.445.1609370244898;
 Wed, 30 Dec 2020 15:17:24 -0800 (PST)
MIME-Version: 1.0
References: <20201230145708.28544-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201230145708.28544-2-prabhakar.mahadev-lad.rj@bp.renesas.com> <822dc356-4416-23a4-a460-90055dfd627a@gmail.com>
In-Reply-To: <822dc356-4416-23a4-a460-90055dfd627a@gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 30 Dec 2020 23:16:58 +0000
Message-ID: <CA+V-a8tOwOvYVRJj8Yf5U58DOfzwzY8XGZrYattLCPUFwG=cqQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] spi: rpc-if: Avoid use of C++ style comments
To:     Sergei Shtylyov <sergei.shtylyov@gmail.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Mark Brown <broonie@kernel.org>,
        Jiri Kosina <trivial@kernel.org>, Pavel Machek <pavel@denx.de>,
        linux-spi <linux-spi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Sergei,

On Wed, Dec 30, 2020 at 4:27 PM Sergei Shtylyov
<sergei.shtylyov@gmail.com> wrote:
>
> On 12/30/20 5:57 PM, Lad Prabhakar wrote:
>
> > Replace C++ style comment with C style.
>
>    Note that the switch to // was made following the SPI maintainer's request...
>
Thanks for letting me know, let's drop this patch.

Cheers,
Prabhakar

> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> [...]
>
> MBR, Sergei
