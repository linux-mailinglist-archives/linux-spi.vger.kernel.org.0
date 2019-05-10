Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03C3319A24
	for <lists+linux-spi@lfdr.de>; Fri, 10 May 2019 10:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbfEJI6s (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 10 May 2019 04:58:48 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:46184 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727038AbfEJI6s (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 10 May 2019 04:58:48 -0400
Received: by mail-ua1-f66.google.com with SMTP id a95so1864102uaa.13
        for <linux-spi@vger.kernel.org>; Fri, 10 May 2019 01:58:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y/d5Ifswy3YqVl9Xug/va1f5QH34DIA8vxfgHTAgVCI=;
        b=RRyGIPUEsOEGf/UaOEDuWoioRLRinFS4DuwTzD8eF4VHPKV6XU47YBGkP7DGAL0mgg
         PY/ClKVp/n5sx8oltiQytgCx/1XVcwWMIx+KdtlMCvU/Yzh1o0ttpEl49aWaPl5wE8U0
         hfT26nszKg9rKnYKtxWDOacfnJn+Khq9n6fV2VRgyKrbOdMO8TckLBX//752Nau6UZTI
         duRND48qJEYF1z8Ox0gUqP9H1zO4ee634ONYoB+82Gf59RAB2RTeSPnHw3ioMdS5Zt2l
         Te0FipF0atpjjMPxnNE9Z7Peo4W13P/y9zJbUkn7qLrqy+Nu8AFOUPttDC2ip0ZKGAIG
         pHmQ==
X-Gm-Message-State: APjAAAUVHbE6uXpV5Bga1dg4J1hjzK6PTUMQ3gph9hsLRuL7bKtZw7cI
        m0akRh01eNJjxHBomYGzx+qF+OKCiP4gIB++EMsgs7JZ
X-Google-Smtp-Source: APXvYqyXMm3lCed9SDXn/XOymM42x1HVXQHzWqD7RKR0b1qdhybEgwHwcAU2Wu1PloVsAkKVFa9eUeX5s3hNIH8prkE=
X-Received: by 2002:ab0:d89:: with SMTP id i9mr4679017uak.96.1557478726866;
 Fri, 10 May 2019 01:58:46 -0700 (PDT)
MIME-Version: 1.0
References: <1557477738-20634-1-git-send-email-na-hoan@jinso.co.jp>
In-Reply-To: <1557477738-20634-1-git-send-email-na-hoan@jinso.co.jp>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 10 May 2019 10:58:34 +0200
Message-ID: <CAMuHMdUFr3BMYH5LmvS9vxCoQnqzA6m3X-E9B6vKbMyeH8QK-w@mail.gmail.com>
Subject: Re: [PATCH] spi: bcm2835: Remove spi_alloc_master() error printing
To:     Nguyen An Hoan <na-hoan@jinso.co.jp>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, May 10, 2019 at 10:44 AM Nguyen An Hoan <na-hoan@jinso.co.jp> wrote:
> From: Hoan Nguyen An <na-hoan@jinso.co.jp>
>
> Printing an error on memory allocation failure is unnecessary,
> as the memory allocation core code already takes care of that.
>
> Signed-off-by: Hoan Nguyen An <na-hoan@jinso.co.jp>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
