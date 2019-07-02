Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 758805D700
	for <lists+linux-spi@lfdr.de>; Tue,  2 Jul 2019 21:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbfGBTlS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 2 Jul 2019 15:41:18 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45515 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbfGBTlS (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 2 Jul 2019 15:41:18 -0400
Received: by mail-lj1-f195.google.com with SMTP id m23so18144081lje.12
        for <linux-spi@vger.kernel.org>; Tue, 02 Jul 2019 12:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZYo3fqkgckZ01WAJt3EqS51tHEujjvkKZjkmoWDUa9A=;
        b=Xpi3vAPbwBAlVsv0euo5n4oQ6uuO0hk1xXNMSeCj4fUnq4AY25PEkmkkI++aTo2Jw6
         VJwf1SKbDpivAthOmK8wEUGxRyBzWbKmFvdQL/QKpH03GQa9FORJz3/kIm2l6tdlaxfh
         ZVStIPp9g7LN3Aj+SAe5pG+D9WKFIA/iFRIzuR/XbnJJ6rby72ncCB/IxAtewnquIwVp
         /lpu5mCEpcVKdkFRRaOpI7ciD3GB+R7FpPV5XY/LLm1zFLw8BcgTlwMQhs6ZVP6mzKMx
         jrU8gqcGwPkF/D2xuzoRmYeWk1aR2Szmd6ehrRYJGi7AAsXu87HzRwGNLW3CP4QasQ6i
         vDuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZYo3fqkgckZ01WAJt3EqS51tHEujjvkKZjkmoWDUa9A=;
        b=ZT0KG5JL6MMYNfKSJQv9zgeFBqduC2Wz5UF6628RCvXSXV9ialhisowizBUbdSIBYZ
         88RvVbeU4OTSh6T0VqXlYmMR55BipQYnwoqr7Qi9r6ZK6gwWETA0XVihiMctss1sRLkN
         zDloRhZBHriswPGuP8bpboXC5cYkdw6ZZ5e7r09ZU8D2wDWdLM1eMBlqDu+eOEwj4R+3
         9blfDtZ5+a/LgBaBA9inbjqOhNheibi7gXqD5bWXq/lOk5TyofkPn7ZKDUglZKoJoqww
         jg+DGeysKMnNf+I41Iw8YI6wy8+RA4Alj7I5iSM0RfJ3GaaselbH2ua+rW1kuf7hjHt9
         H3Wg==
X-Gm-Message-State: APjAAAWTcXYayCO+GTpawj4tDMzoRfzM6wAPNDQI+mSkm+uaV4yFO7f3
        3J+vqvhf0ZwWAVkRtcw648z8+MRJuTyUZf0cg0nEig==
X-Google-Smtp-Source: APXvYqzlfSQ2odWRbFfHpnUHsDrMaxebp6ZbRHkkCp3wBOqoPBe3KPJAJ7knDKlNyx6IHJexgvlVZtuUd8j5oYh2UUo=
X-Received: by 2002:a2e:2c14:: with SMTP id s20mr18257301ljs.54.1562096476358;
 Tue, 02 Jul 2019 12:41:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190701172517.31641-1-linus.walleij@linaro.org>
 <20190702113914.GH2793@sirena.org.uk> <CACRpkdbng1M=5BnzFuiubRaqM1Bu4eLxqKvb3fCQuqyKsVcBjg@mail.gmail.com>
In-Reply-To: <CACRpkdbng1M=5BnzFuiubRaqM1Bu4eLxqKvb3fCQuqyKsVcBjg@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 2 Jul 2019 21:41:04 +0200
Message-ID: <CACRpkdZ=FTUc2xTx9JJtU1c8x0s8N3c_=wbUzJpCRq=_xV9HKw@mail.gmail.com>
Subject: Re: [PATCH] Revert "spi: gpio: Don't request CS GPIO in DT use-case"
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi <linux-spi@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Jul 2, 2019 at 3:08 PM Linus Walleij <linus.walleij@linaro.org> wrote:

> I am trying to rootcause it, I suspect I was just the first to try this
> on real hardware actually.

Ha! I found it. Only affects active high CS GPIO users.
A nasty one. Sent a patch.

Yours,
Linus Walleij
