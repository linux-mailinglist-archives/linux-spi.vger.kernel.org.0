Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C30292E9657
	for <lists+linux-spi@lfdr.de>; Mon,  4 Jan 2021 14:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbhADNuh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 Jan 2021 08:50:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbhADNug (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 4 Jan 2021 08:50:36 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 734A8C061574;
        Mon,  4 Jan 2021 05:49:56 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 30so14386218pgr.6;
        Mon, 04 Jan 2021 05:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+DJZ244fWmm1Eu3AuZWtTvG/4qgtx5ebkDRnS934fwE=;
        b=KNvpcfIuHglIYpeV2XoKyh7PP2hPT/N01s9VVO7BHOdFN5t7SA3yECdLD558utKc4Y
         uMNyOz8qpMqJq41XG/HR9suOxw1LM12EpFoPFO1GWa3m9MqVUCSj4tITIkvSPVIS0gje
         B8OrCdYuIzdK+GVU3dURuph0ggE9GZ+K2ediPWOB4WL4yt24S3zzHWVLXlqoH/0xU7GC
         mP1oLTBFmlGd8xqhYURiNNKaobjfxAL0RKzj975tkyeR9oY8lLn535GArZWiZmgQgWTD
         JUv9fFhbrLrjTH/HRfpoNKrCRtNEwQFd8h1RKbAB3gB1CvbAWEvVKrTTjyIqioF+1tMq
         fGkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+DJZ244fWmm1Eu3AuZWtTvG/4qgtx5ebkDRnS934fwE=;
        b=CJx+7HhDaIN3RJOiwH3drGcAEu3FIl9dUqsHyqwdPlpfQQA15Gl9sSjZ9qKs83chwd
         bd0L7zsXMbUoodFe7JgLz0vT9/N8N7uisw/SI15BTfeja74ZwC3JKCRJcnuSO+mdGA/I
         e9/1QZt6RnnxwSvQDC14DoklrAcHoji+7ph3PbaOXY5/5cIYpPNHuVjNIhp0vffmepWi
         bmHxUrYALykv9NtHSW8Iu5JBXOWrV+fx/PSLeKuwJMtutgM1ZLenRrh4lcxHmh+kq7Gb
         1OA1zrKXJPf9fKokWym89Yscpt76UYa5iTJzRHY8GipIzATYcs2ufwzIp+njXBagDiOB
         V/eg==
X-Gm-Message-State: AOAM531+nVW1gR4XPveP7wBRAnutPKpQ6/TIoKskQxNz9/RuNblLYzIv
        +94FvmaAplTA3A2hN8awJnLZBkrMOf6yAmNM0Pc=
X-Google-Smtp-Source: ABdhPJxqi8qDckN3jm/Qah53DZywTHfIi81ycD9UrvEU6ouSQLNhgM7OlLPtzLTUhoAq2snYcNXRpLt89kYbE7SI/5Q=
X-Received: by 2002:a62:19cc:0:b029:19e:321b:a22e with SMTP id
 195-20020a6219cc0000b029019e321ba22emr66235798pfz.73.1609768195997; Mon, 04
 Jan 2021 05:49:55 -0800 (PST)
MIME-Version: 1.0
References: <20210104085923.53705-1-alexandru.ardelean@analog.com>
In-Reply-To: <20210104085923.53705-1-alexandru.ardelean@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 4 Jan 2021 15:50:44 +0200
Message-ID: <CAHp75VdsXDr8kAREiGhSF9-ffr05+LDHcqOzWnomfWTH2mN9Gw@mail.gmail.com>
Subject: Re: [PATCH] spi: stm32: update dev_dbg() print format for SPI params
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Jan 4, 2021 at 10:55 AM Alexandru Ardelean
<alexandru.ardelean@analog.com> wrote:
>
> With the introduction of the 'include/uapi/linux/spi/spi.h' header, the
> type of the macros are enforced to 'unsigned long int' via the _BITUL()
> macro.
>
> This causes some -Wformat warnings in the spi-stm32 driver.
> This patch changes the printf() specifiers from '%d' to '%lu' to
> accommodate for this change.
>
> Fixes: f7005142dace ("spi: uapi: unify SPI modes into a single spi.h header")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>

LKP also reported this before.

...

> -       dev_dbg(spi->dev, "cpol=%d cpha=%d lsb_first=%d cs_high=%d\n",
> +       dev_dbg(spi->dev, "cpol=%lu cpha=%lu lsb_first=%lu cs_high=%lu\n",
>                 spi_dev->mode & SPI_CPOL,
>                 spi_dev->mode & SPI_CPHA,
>                 spi_dev->mode & SPI_LSB_FIRST,

Wouldn't the output be a bit awful with all these?

I think the proper fix is to add !! to each bit mask.

-- 
With Best Regards,
Andy Shevchenko
