Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38DF4C2764
	for <lists+linux-spi@lfdr.de>; Mon, 30 Sep 2019 22:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731375AbfI3Uyz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 30 Sep 2019 16:54:55 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:46951 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731130AbfI3Uyz (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 30 Sep 2019 16:54:55 -0400
Received: by mail-io1-f67.google.com with SMTP id c6so41903040ioo.13;
        Mon, 30 Sep 2019 13:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5EvV0rHaKuqZX7x+0kWB9K0Htf4/eT/XzhMy6LlTa6U=;
        b=CYUUHhvRgRttbUU0EflAv4wNyRlLQ9182afeyQkWAluUoxDYpAJlSJkO5hqhnoEM0R
         xtOgstn0SpD8hAPSHVDr7iUUFjYHgYE03BhHLx1Vve8K4TTsnjLCI8PlICi7NJyApEXR
         q+Vlx97Ft5Fp1Ck1oVsnUOFOw/GFYkfeTK0lkpYZ3csosq8LcxrqWa798zGvH/Ob+k8O
         nIEEuVvqELLOtZur6okWysQGBlYAnL+BY0Zk3gYIvHfB/CMRCdp+ytSroQWb1+8+abhT
         //SddmgcliOEo6yT3GdaFxMJKQtc0sa0F34vnv/tBqwT5P5W0kpH0/e+86utiiKbx0aR
         CFbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5EvV0rHaKuqZX7x+0kWB9K0Htf4/eT/XzhMy6LlTa6U=;
        b=S/YNZmbkpN60xTpdp/ZghxTo84WDmp141UELWMXdBEQepFhySHFVYKdjIraYNP8ZAy
         +DH16Jvr273tHpN4OP9Xkff8k1VaaN+aKynAHOR4FniMy3CHAFVGtD4cjZ51/bEaeKzO
         jdlW7YVvUk+3OqbYo6rw0fHnZG5nflxvmwdqIMfx32kRanFOtum7ukwyFknLMbhAJ+IZ
         GjGVbBMqLWPFLz5jl+Z/buEQ1gPHZrHUeOcRrqdXOg9QtTtqfS0Cg17C3zUOxcO+D/it
         pDTuKnV9zzGnySjFWjhkLOFydxoL7ud+ZAtpfPOuSSgt3kr16VtHxWPC6aLLawS5S2x4
         5GFQ==
X-Gm-Message-State: APjAAAUkG0J2od3o/a36Cv6C2TATUis6scclQi6MN6e6L1M6Rgwh7Zi5
        Q05bxOvrQlAm1BNP4iRHEbhE13T/Eh15BTXO/Lw=
X-Google-Smtp-Source: APXvYqwd8c/Sw9GwhVCKSPwcRlQXMnSdWLKTWuLDMlfxm/c0XuJiFPWTDOqyaI28HonPSzCzUAY7UV9BuOuxa7o4np8=
X-Received: by 2002:a6b:c9d7:: with SMTP id z206mr6368561iof.172.1569876894668;
 Mon, 30 Sep 2019 13:54:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190930033928.32312-1-navid.emamdoost@gmail.com> <dcd26f62-e384-bf6d-2e7d-63c0d0f7da11@web.de>
In-Reply-To: <dcd26f62-e384-bf6d-2e7d-63c0d0f7da11@web.de>
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Date:   Mon, 30 Sep 2019 15:54:43 -0500
Message-ID: <CAEkB2ES3kKSU+mQojZHrzMaeQZhjRUoLe+4wOaZONGT=OwRc4g@mail.gmail.com>
Subject: Re: [PATCH] spi: gpio: prevent memory leak in spi_gpio_probe
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     linux-spi@vger.kernel.org, Navid Emamdoost <emamd001@umn.edu>,
        Kangjie Lu <kjlu@umn.edu>, Stephen McCamant <smccaman@umn.edu>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Fixed the issues in v2.

Thanks,
Navid.

On Mon, Sep 30, 2019 at 1:24 AM Markus Elfring <Markus.Elfring@web.de> wrote:
>
> * Please avoid typos in the commit message.
>
> * I would prefer an other wording for the change description.
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=97f9a3c4eee55b0178b518ae7114a6a53372913d#n151
>
>
> Regards,
> Markus



-- 
Navid.
