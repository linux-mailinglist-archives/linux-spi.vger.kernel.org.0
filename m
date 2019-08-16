Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B066490AF1
	for <lists+linux-spi@lfdr.de>; Sat, 17 Aug 2019 00:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbfHPW32 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 16 Aug 2019 18:29:28 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33257 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727788AbfHPW32 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 16 Aug 2019 18:29:28 -0400
Received: by mail-lj1-f195.google.com with SMTP id z17so6632394ljz.0
        for <linux-spi@vger.kernel.org>; Fri, 16 Aug 2019 15:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UcIQ8f7uiCgBRDYQZgvf9BdkFXQfiqi4Jnab8kvYofM=;
        b=DDD0IAvtj0S3l02ltQU8EpNBnZXa/LPDRrS4ggAiitlDhWaKUUJDCnxA9iSvTLf+N9
         JZWiD52Bcwo2O1maT+VX7N3rDWG8fv9AAnOB7/f/1WWnGc/YMMnbRqLO9qyo/efPOZS/
         Vxx/aIR67dEPcfQpYYXixqhhM2QH0AZsUyogKTjNIBdasiZlwTXiIuexbtky0AZxHq1T
         3xYzXlFudhl39/1Zhd13U4fFewgwdGqBUSj1kW090KxlTnaKJ+VLSIzpIwgSbpiVNCJI
         TdAtYozC06bsrgLh4jUhwGe7flg7gHfJOcuhikauTII5mO35xtcuLhNYkNBH3dVA5HrL
         rYFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UcIQ8f7uiCgBRDYQZgvf9BdkFXQfiqi4Jnab8kvYofM=;
        b=g7/n+lrCf+srm5Gg380ETbvWzbbeMP44zF4q/NL02Q5biIuRDf4OaTkZntQGFetzMf
         sQBQYnhKzd+XI87U2G8kOfNDushADe4y2aIVQoI7XBq6qvoKH4RnX44mJjXPf8B8Puzz
         B8dxt28/d+J/Kb8EJ0uqaWKsLumFDEBc/z+a2UAA9bmvmYFQFmGryBc8boL/9gbpad1d
         LEvYuu9CAN0BC8bWON4XJoP3wf+1V+cxW6LfTU0C/eMYV1zAlQMiDsjBHA7wOo2FDibu
         JTCkIs26A7dScm+BVbRhai/hW+3Go07JWWi2dGlMpfMBAnSG3TRDZ2cEeC1/RcsgVu7g
         NePw==
X-Gm-Message-State: APjAAAV7PhFK5tJ5QtWAH0KZ/7Mjfxpo0B+URnQ+Md/NagmAUEqtev4/
        VurbGLcN0lkiN6sZjmQJigVOldJNgaaw2luZMh6Q4w==
X-Google-Smtp-Source: APXvYqz/Um0VpLAdA90TWsPCo26kbKDPeGImTYJpGVkwKP0ZHIykSPf1mpDFbizhE48JPVnKM4VviobMERdB5LF39uY=
X-Received: by 2002:a2e:80da:: with SMTP id r26mr4644548ljg.62.1565994566351;
 Fri, 16 Aug 2019 15:29:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190816165000.32334-1-andreas@kemnade.info>
In-Reply-To: <20190816165000.32334-1-andreas@kemnade.info>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 17 Aug 2019 00:29:14 +0200
Message-ID: <CACRpkdaVHPFgw9g8D=zrYECO5Syk1kMT3VgL+wq2ebKQxg_FGA@mail.gmail.com>
Subject: Re: [PATCH] gpio: of: fix Freescale SPI CS quirk handling
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        "H . Nikolaus Schaller" <hns@goldelico.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Aug 16, 2019 at 6:50 PM Andreas Kemnade <andreas@kemnade.info> wrote:

> On the gta04 we see:
> spi_gpio: probe of spi_lcd failed with error -2
>
> The quirk introduced in
> commit e3023bf80639 ("gpio: of: Handle the Freescale SPI CS")
> can also be triggered by a temporary -EPROBE_DEFER and
> so "convert" it to a hard -ENOENT.
>
> Disable that conversion by checking for -EPROBE_DEFER.
>
> Fixes: e3023bf80639 ("gpio: of: Handle the Freescale SPI CS")
> Suggested-by: H. Nikolaus Schaller <hns@goldelico.com>
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>

Good catch! Patch applied for fixes.

Yours,
Linus Walleij
