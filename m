Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B900B20138
	for <lists+linux-spi@lfdr.de>; Thu, 16 May 2019 10:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbfEPIZX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 May 2019 04:25:23 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:36199 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfEPIZX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 16 May 2019 04:25:23 -0400
Received: by mail-vs1-f66.google.com with SMTP id l20so1778738vsp.3;
        Thu, 16 May 2019 01:25:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kom7CYU+qZNtW2jhA/vUJyPJXygJervJGsEuV/SOp60=;
        b=iuMcoLFRmGqCnoME87YxWMHfyLCUC+TKrE+vv6libXqIBnyoGZ6IbsvKwvOKa9FVlc
         P7AWl7nqQN8ZKQr2KOWY7UtdMe25ui1Hq6NU20z1rf6JvmMLvg899FZ5irb/SIXBhI1W
         VCTXfF9HUEyKA33cG9rxCavhm8Oy3MAl+pyNZDCTY7HR/PtRjWx5U+mRQMYE0tc71bu6
         2azFS5w2Pi24ELZVx0GTM9x89nXy3fIqZ1Z4tUnzNlQvZmDejYxPAyj2mLy9loYBXmUc
         XJIQvOjpyJ4OtJn0gn0ndEf1AaTVo+p1m3kVp5nQtw+B7GTKlFFbkWZOACC086cqqeBt
         x08g==
X-Gm-Message-State: APjAAAUGcwLAjT3wqhM3Y6Emu2G5NKIc+6FbphsXRiR47Vye4P63MFzc
        l4d/2ACUUaIrN6oU/9n66sYVsIJEb7zxskWXlIQ=
X-Google-Smtp-Source: APXvYqz8A+UKfZ2oOCYzeXseCIyYZ4wWUIDb6b9Gxt8lpJxZNlnNHTRGzBSCc2MdFNDG5Jw0r3bbHv8IOqodaorNY/Q=
X-Received: by 2002:a67:fdd4:: with SMTP id l20mr18322924vsq.63.1557995122611;
 Thu, 16 May 2019 01:25:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190516075656.25880-1-yuehaibing@huawei.com>
In-Reply-To: <20190516075656.25880-1-yuehaibing@huawei.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 16 May 2019 10:25:11 +0200
Message-ID: <CAMuHMdUMBg9HL8PQvkHvppP+qJ6fWjs0ZbFTX=8x0A1_AVUJqw@mail.gmail.com>
Subject: Re: [PATCH] spi: bitbang: Fix NULL pointer dereference in spi_unregister_master
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Mark Brown <broonie@kernel.org>, Axel Lin <axel.lin@ingics.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>, albeu@free.fr,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, May 16, 2019 at 9:57 AM YueHaibing <yuehaibing@huawei.com> wrote:
> If spi_register_master fails in spi_bitbang_start
> because device_add failure, We should return the
> error code other than 0, otherwise calling
> spi_bitbang_stop may trigger NULL pointer dereference
> like this:
>
> BUG: KASAN: null-ptr-deref in __list_del_entry_valid+0x45/0xd0
> Read of size 8 at addr 0000000000000000 by task syz-executor.0/3661

[...]

> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: 702a4879ec33 ("spi: bitbang: Let spi_bitbang_start() take a reference to master")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
