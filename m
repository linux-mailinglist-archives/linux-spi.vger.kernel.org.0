Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2868615BAB3
	for <lists+linux-spi@lfdr.de>; Thu, 13 Feb 2020 09:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgBMIXY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 13 Feb 2020 03:23:24 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38399 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgBMIXY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 13 Feb 2020 03:23:24 -0500
Received: by mail-oi1-f196.google.com with SMTP id l9so4946118oii.5;
        Thu, 13 Feb 2020 00:23:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5kjBjy6Q908Xaoy0onIKKA8RMCzHPl/gt5iy034q4o8=;
        b=DTWHM7kzN557+Bxo2XoxC6vzmONi78KvRyFSKrGklPXH7z0sP4QOtZAI3gOp3t6RaC
         eW6EV3lYBAFp8lc/YUvAxtdU1dHtmiUeSbq8DGyhLAvy/RfEMvHElqZu7eu6PWMssQ5x
         o1FMn2u7BOdyNeLW0LMzmwf10Rp2EsGUVfvP2QFkIA34bxUxSyNpecP6u/KPNwStecdk
         21mcl3f1pj0bTlEzge6brh3rdvmpfxPeUS9wafUQzamdP5uwil1kGVvmWjZ0dgaGNEqt
         ipzujIMqghlPFL76PhtQ4GyoKuWI7DwGVKTtDOk8k2LPDzWn65w++kmClldkPBUUJhfT
         uTLw==
X-Gm-Message-State: APjAAAVOgytCAQnM1o2A3g3mAkhhq33e6xSQqjvByaLvEWWgEscNPkVy
        bXRt6yRJkdnQmznluNXI+x14yAsU5xsFnxR+Aqtcfw==
X-Google-Smtp-Source: APXvYqzl2kxvFjQrQc8a75ni4iddVrYCVIIJ7pE6Abbyi2dbl4mTRwbPvdvwmO8plk+FEcXSp81TC3ASDVHYcLVnlJM=
X-Received: by 2002:aca:48cd:: with SMTP id v196mr2207687oia.102.1581582203615;
 Thu, 13 Feb 2020 00:23:23 -0800 (PST)
MIME-Version: 1.0
References: <1581567368-8055-1-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1581567368-8055-1-git-send-email-yangtiezhu@loongson.cn>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 13 Feb 2020 09:23:12 +0100
Message-ID: <CAMuHMdWEUkdMWFDRt3G_HQTAMpnbrmFdBd8jcH4oAhtMoYch-g@mail.gmail.com>
Subject: Re: [PATCH 1/4] spi: spidev_test: Remove break after exit statement
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Feb 13, 2020 at 5:17 AM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
> When call print_usage() in parse_opts(), it will exit directly.
> Since break is not useful after exit statement, remove it.
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
