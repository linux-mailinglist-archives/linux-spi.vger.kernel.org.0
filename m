Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE81D183296
	for <lists+linux-spi@lfdr.de>; Thu, 12 Mar 2020 15:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbgCLOO7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 12 Mar 2020 10:14:59 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37539 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbgCLOO6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 12 Mar 2020 10:14:58 -0400
Received: by mail-ot1-f66.google.com with SMTP id i12so1098192otp.4;
        Thu, 12 Mar 2020 07:14:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pOL1fdrEckcE7hJhdExxXt7416zv/+dKTzYWxtpFQ5Q=;
        b=SBKcur7vE2mAiWxK/rdJ9MlnEILtE+o0eC0lDUtNLug4OyAmB3huHKP9J7hriqh02Z
         rDR0d22D1kauLy/b3L2sE5Ayu5+0Q7Ole+byS764HUx3MOTgtZGOPmaRzVWSalkAsm6e
         cbNY59phYYqMbho8D8riY16r84PYsAqdXkBReieWckCGWwq/lkG0O6+NAHJq1rti9x8k
         JRLj7zX8MLF2tC3cFqRvyVWmEAe33OaEBrFcefe9RXDyT5ZPuh9DfGKveSvKa75LrZd4
         Ee7aGt0wqNPUijnvIZzO2aV1JUdPCigRgcbKX5kJbwiDO58dtO3Vnlp6/eHf6juktPyj
         HBvg==
X-Gm-Message-State: ANhLgQ3BrFrqWsqIVZ6wUitPfQXfgxe/HsfUm55+pkqZ4/KSRjUHS+iX
        rUcOqjSI3bBzppivXLbl+OMD8UBJELXKSACUY5c=
X-Google-Smtp-Source: ADFU+vvw9YBIxb/zGcDozzqkQM8ryEvyQgefsBfXbJ6bo8TQ47RYC/QeIzO2bonpnj+Gy9Vb03e74N/4v5XxsYQz7sw=
X-Received: by 2002:a9d:5c0c:: with SMTP id o12mr6487677otk.145.1584022498177;
 Thu, 12 Mar 2020 07:14:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200312134507.10000-1-wsa@the-dreams.de>
In-Reply-To: <20200312134507.10000-1-wsa@the-dreams.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 12 Mar 2020 15:14:47 +0100
Message-ID: <CAMuHMdWxOa9Fo+oipWOS2DEXsJP6fiCV--0GDmDnd=1PoSg66Q@mail.gmail.com>
Subject: Re: [PATCH] spi: acpi: remove superfluous parameter check
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     linux-spi <linux-spi@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Mar 12, 2020 at 2:46 PM Wolfram Sang <wsa@the-dreams.de> wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> to_spi_device() already checks 'dev'. No need to do it before calling
> it.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
