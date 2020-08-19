Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A58B24A734
	for <lists+linux-spi@lfdr.de>; Wed, 19 Aug 2020 21:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbgHSTvP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 19 Aug 2020 15:51:15 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46148 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgHSTvO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 19 Aug 2020 15:51:14 -0400
Received: by mail-ed1-f68.google.com with SMTP id t15so19072496edq.13;
        Wed, 19 Aug 2020 12:51:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Bb7ExWmhyq/T0GrV/7A/j43KNL60oMDaO5uFv+AFuAg=;
        b=LQr5YtTtOXyORJOqRO/zYTug6FM7xWhiDxL0qW434xxdJkgMOJC8Fhv491mM2nRiJi
         mzAxEluLL2oWWCyC3MyfMNahKrmm09Or0JB3N5vqkpizcu3sZMxhkesiKMUxbg397eYA
         S1Ij9yZdU0S6dWRvaItHeDdT4NwxMZGDYlKReaRpFJKZimh0kSZwEx102G+fjhu2v/aw
         6bKNd+KyNc5HAyGNVEoSOI3Qr/L1NN6onXsKkMqblM36mSICnNeWLXLVpGdr89VOs2XS
         h5Cb+5L21xTjDxoq6G+G9VZZHogI1uQUhCv7tHHKuoVa0gsv6dyhfhOV4EUL7TFipLIl
         9Oqg==
X-Gm-Message-State: AOAM531IR+YUtubOAPjs9luZ/iHUZZGRO9G3RWwP8AfQCsV9OAIHbBJN
        NiaedG9218QyKbTowtull0FnFSZFEas=
X-Google-Smtp-Source: ABdhPJx7j3Lrm4/qFAWyj9HphpiOLZn+rlreZc+t2vrnccL41YTdGaaoZeU2eRxltKfnhqvLZP5zyg==
X-Received: by 2002:aa7:cdd0:: with SMTP id h16mr26397727edw.116.1597866671520;
        Wed, 19 Aug 2020 12:51:11 -0700 (PDT)
Received: from kozik-lap ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id c5sm19332234ejb.103.2020.08.19.12.51.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Aug 2020 12:51:10 -0700 (PDT)
Date:   Wed, 19 Aug 2020 21:51:07 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Mark Brown <broonie@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Andi Shyti <andi@etezian.org>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v2 23/41] ARM: s3c24xx: move spi fiq handler into platform
Message-ID: <20200819195107.GA10594@kozik-lap>
References: <20200806181932.2253-1-krzk@kernel.org>
 <20200806182059.2431-23-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200806182059.2431-23-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Aug 06, 2020 at 08:20:40PM +0200, Krzysztof Kozlowski wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The fiq handler needs access to some register definitions that
> should not be used directly by device drivers.
> 
> Since this is closely related to the irqchip driver anyway,
> move it into the same place.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> [krzk: Add a header guard in include/linux/spi/s3c24xx-fiq.h, fix
>       SPDX comment style, update maintainer's entry]
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> Changes since v1:
> 1. Add a header guard in include/linux/spi/s3c24xx-fiq.h,
> 2. Fix SPDX comment style,
> 3. Update maintainer's entry.
> ---
>  MAINTAINERS                                            |  1 +
>  arch/arm/mach-s3c24xx/Makefile                         |  2 ++
>  arch/arm/mach-s3c24xx/irq-s3c24xx-fiq-exports.c        |  9 +++++++++
>  .../arm/mach-s3c24xx/irq-s3c24xx-fiq.S                 |  2 +-
>  drivers/spi/Makefile                                   |  1 -
>  drivers/spi/spi-s3c24xx.c                              |  7 +------
>  .../linux/spi/s3c24xx-fiq.h                            | 10 ++++++++++
>  7 files changed, 24 insertions(+), 8 deletions(-)
>  create mode 100644 arch/arm/mach-s3c24xx/irq-s3c24xx-fiq-exports.c
>  rename drivers/spi/spi-s3c24xx-fiq.S => arch/arm/mach-s3c24xx/irq-s3c24xx-fiq.S (98%)
>  rename drivers/spi/spi-s3c24xx-fiq.h => include/linux/spi/s3c24xx-fiq.h (66%)

Applied patches 1-23 to samsung-soc.

Best regards,
Krzysztof

