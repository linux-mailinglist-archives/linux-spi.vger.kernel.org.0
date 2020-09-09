Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA04A262A2D
	for <lists+linux-spi@lfdr.de>; Wed,  9 Sep 2020 10:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbgIIIZd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 9 Sep 2020 04:25:33 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46979 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbgIIIZ3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 9 Sep 2020 04:25:29 -0400
Received: by mail-ot1-f66.google.com with SMTP id c10so1561640otm.13
        for <linux-spi@vger.kernel.org>; Wed, 09 Sep 2020 01:25:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lPiqo1zf0KUuVvaua/90dypqAIdFtxJvK78vkvCDvCI=;
        b=fhih5ng2pN6mHZcI/yVjrC2wpXqqQyImvGiz26L4oBEeCkB4tId0rE0mzXkD4GMBif
         KgqQ6WhQu45iXvHVs/mPMwWoelZZK46HyHp6I8SVQqLVXI0jaLAPWEqONirdoc5R+oVt
         vnY181vvX3A0wA7CmH88P1mhX/6S8z70NTt7VTRxs4Z3hzK1V45XwgUKjlA1w1QDfEqg
         WzlPegVWHyLROVUlxu6Z+TRANy506/YisKzhGVvO1qCduiyqdcfUynJrj8ZYueP7KIJT
         lp33wC7Skuu8T/2n25cyxkXoMYTKh8FB4UFrUzI+2nnM2/Dj0C2gu3cPDKZVwEuHrIWB
         q5hg==
X-Gm-Message-State: AOAM5311/318iC28ocLNpg+bw1/tmTM2ZaQEl+YBM48xiqvLs/TgEOQT
        lkIBgI5BIKGMr5EZsU8HcuIQ7w0aSqC/hYtBgmg=
X-Google-Smtp-Source: ABdhPJxNAsER/RwmgGFoV8nYT3awgfDBc5hYkIbOfbwK6BC48MogDPMRqIMfzLpK+Z3aJ5b0oqzDNqczSVQsRbebuEk=
X-Received: by 2002:a9d:3b76:: with SMTP id z109mr2019717otb.250.1599639928881;
 Wed, 09 Sep 2020 01:25:28 -0700 (PDT)
MIME-Version: 1.0
References: <1599631704-53232-1-git-send-email-f.fangjian@huawei.com>
In-Reply-To: <1599631704-53232-1-git-send-email-f.fangjian@huawei.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 9 Sep 2020 10:25:17 +0200
Message-ID: <CAMuHMdW8XNyLo18w+GSoGmb7tdxAoF+hRJTgdTVS6B_KbbTThw@mail.gmail.com>
Subject: Re: [PATCH] spi: spidev: Remove redundant initialization of variable status
To:     Jay Fang <f.fangjian@huawei.com>
Cc:     linux-spi <linux-spi@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>, huangdaode@huawei.com,
        Linuxarm <linuxarm@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Sep 9, 2020 at 8:11 AM Jay Fang <f.fangjian@huawei.com> wrote:
> In spidev_read() and spidev_write(), the variable status is being
> initialized with a value that is never read and it is being updated
> later with a new value. The initialization is redundant and can be
> removed.
>
> Signed-off-by: Jay Fang <f.fangjian@huawei.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
