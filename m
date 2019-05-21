Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 293D12558A
	for <lists+linux-spi@lfdr.de>; Tue, 21 May 2019 18:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbfEUQ13 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 21 May 2019 12:27:29 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38922 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727932AbfEUQ13 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 21 May 2019 12:27:29 -0400
Received: by mail-pf1-f196.google.com with SMTP id z26so9327617pfg.6;
        Tue, 21 May 2019 09:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1KdNzkB02hCw0gTx5J78D1RziQV2In86W7l7xwN50vM=;
        b=NRAnCoY75887mJx98L+K97F0yu4Uh44Geb3eNn5ftcmyFTGAopnSnujnFd53azc5b7
         XuKNkE0+0yTxxYDt3e1tIpVX2eYlWMNRoDF+F6sSDvPsDAS3i+oFWyf2ShYi8zZ221DE
         r1HlFX+vnGBO1uYT0UYk/wWI30E7DeJte/YADAA3Uv9mdnQqKBb8mK/cRrblUwesRVrp
         A2Kf1w+K9kz5v2kwPKrBWWTRMGrQOayyOjQeJzSLfzhMvpqoWDrnLc2qq09PCObNS8PP
         rX4pg4AAXXl1YTAZy2r5D/+PDj85jm2qF/YBgbAfQG67l2jJwuFrePCSYAvyvI2CLzxm
         55Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1KdNzkB02hCw0gTx5J78D1RziQV2In86W7l7xwN50vM=;
        b=tWmOI2wNrkY3W4C9kVjn+8EnCnZ50QYFSLsLhtDNii0QvcpssJ/CKZwKnsds8PmdDr
         OoySG35VZ4LjUB39MxaXbZjSkpZBWh0qB3tATWZemoVHPJr5LCeVAHwlTaU+Sys06eM6
         CZkPi7/sjneu4/R+NFsz2zBQCkcUHNLXiajce71YgdjaqM5zEuICFMR9LskkBpSFrLIt
         vX8N8rjSmcrckpZy/EwcDn84jYjhKYAO5p1+nO+OOu8a2hHAixnO8I/Z4RoCXxo0RRqa
         N3uGGiLSy2MvphThWlsqrH2FiHgGvpMCzKykd1C2MT/Rx62ttp7HsRLvlpiI9ELiz3GJ
         NxTw==
X-Gm-Message-State: APjAAAUnCgAb3ZpxHzgUpIErtk42GBma15CJjdM0/KK6DiZR4awVkq1w
        JFtbcsNg9fdYjsEwulUl0Zc2LcqvOWytehwYnR8=
X-Google-Smtp-Source: APXvYqyPJtS767MY11vacdaFoYBFftgMDGiDu3J3VKXwIw6xeQ3Zm9WTOznkcOCWloBqHrIP5niZgHtbNSL4ZE+CK4U=
X-Received: by 2002:a63:2c14:: with SMTP id s20mr65656635pgs.182.1558456048495;
 Tue, 21 May 2019 09:27:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190521115958.22504-1-masahisa.kojima@linaro.org>
 <20190521115958.22504-4-masahisa.kojima@linaro.org> <CAKv+Gu8zhymKrbuNo+KU58svKyBO2cyLw-wKcKwgON2sDYBK7A@mail.gmail.com>
In-Reply-To: <CAKv+Gu8zhymKrbuNo+KU58svKyBO2cyLw-wKcKwgON2sDYBK7A@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 21 May 2019 19:27:17 +0300
Message-ID: <CAHp75Vdo3io9eDuuSJnt1VcEDSi7+pnQW8V+ter37GwH1be2JQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] spi: Add spi driver for Socionext Synquacer platform
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Masahisa Kojima <masahisa.kojima@linaro.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Trent Piepho <tpiepho@impinj.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jaswinder Singh <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Satoru Okamoto <okamoto.satoru@socionext.com>,
        Yoshitoyo Osaki <osaki.yoshitoyo@socionext.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, May 21, 2019 at 4:55 PM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> On Tue, 21 May 2019 at 13:00, Masahisa Kojima
> <masahisa.kojima@linaro.org> wrote:

> > +       ret = clk_prepare_enable(sspi->clk);
> > +       if (ret)
> > +               goto put_spi;
> > +
>
> Make this depend on DT probing

We may use devm_clk_get_optional() and drop dependencies.

-- 
With Best Regards,
Andy Shevchenko
