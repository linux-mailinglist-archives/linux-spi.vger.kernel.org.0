Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5EE136F75D
	for <lists+linux-spi@lfdr.de>; Fri, 30 Apr 2021 10:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbhD3Iuf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 30 Apr 2021 04:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhD3Iue (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 30 Apr 2021 04:50:34 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336C5C06174A;
        Fri, 30 Apr 2021 01:49:47 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id v13so2289347ilj.8;
        Fri, 30 Apr 2021 01:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6XpLFpvoM/MyCxucScV9GHbc1u0ufErrdczH8fINryA=;
        b=XfdyiakISQV0rCr116VJNrN1pSVJBxJnhTJ36wAigGd+atH9iiXt0+lNxlH+horNLb
         ITiUPgvRVyeFfalzkClX0syUiifPxjCE6CGSGGJp/t28z5etiIkNkRO9rIrnkUu15fhf
         GIO1TP2+iIaDMYSRGGp2MyxlEKrb6aGXi9T+9uaIzTKMecoxdO77gb/cI3OjjYXfDElj
         ozBDRGBu/DhpEiRe7fJsEXyaDafnVYnU0y4y4QTe42zmjWctSLpA+9WW9KGIDPCAgNoe
         w3H/j2m9HLeM9sQcgJqcggbYuKqInYiWAIqck2rs3kHs5USyYLaW9h7KmKNfRrqPhiDV
         Bghg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6XpLFpvoM/MyCxucScV9GHbc1u0ufErrdczH8fINryA=;
        b=siq4NxdtLEL9nbmQeHimnzOI17bYt7pMqJAhlQbUadWJW7HSQnTeNo6tpkbeaEfQ/2
         v9sDmYIxouWrtKttYChkiRCL9Ilz2VRZ3prcqqfEfdo5159ZkAe0d/bIZwMPzLNgSe/Z
         +IhWW8aDXW/Q90Jpd29CmIlrLUwvPvuOdjNHgfZBj3tiY9q1eBNBzdrjL/LiqsbqpGwB
         VYz6wAkw/ivXbJytBgGy1rdYt8jUlZ3tUjZhCROgwRB19Kf+KTjyLBw3HA6y7gGr9rn6
         yOXy3cXVZg2ug0Gd8teWnQz+EdCUkshy7CvDpgfOoB7QAjsVlCtsVOx5uOzIKawxYIoZ
         TQCA==
X-Gm-Message-State: AOAM533zthye9ralLGZOTpzCthw78hZaZ0kgk/XLyjWIKizGJrpX9+oB
        BlKu5cK5nvBiFSe7cAEWmwdP7fsIblxrwnVq+1c=
X-Google-Smtp-Source: ABdhPJwq7AMNZNBViIBThuRjUDAbnJQd0R8zTalusTtudatSMQDlQfcewQ6cSi3aISJKRV4yX05N2MCV3b2pDAn5iAM=
X-Received: by 2002:a92:3203:: with SMTP id z3mr3244322ile.22.1619772586655;
 Fri, 30 Apr 2021 01:49:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210423034247.992052-1-art@khadas.com> <20210423114735.GA5507@sirena.org.uk>
 <CAKaHn9+d5crmmG-aKyLuvyxk+A7aC9qqfX_3wuMXm50pg+pZ4w@mail.gmail.com> <20210426115645.GB4590@sirena.org.uk>
In-Reply-To: <20210426115645.GB4590@sirena.org.uk>
From:   Art Nikpal <email2tema@gmail.com>
Date:   Fri, 30 Apr 2021 16:49:35 +0800
Message-ID: <CAKaHn9JM-KEiz3_Btsz8_fr7hcZ2Sm8B64VyLvgpvKK-NKco3w@mail.gmail.com>
Subject: Re: [PATCH] SPI: meson-spifc add missed calls to remove function
To:     Mark Brown <broonie@kernel.org>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>, jbrunet@baylibre.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        dri-devel@lists.freedesktop.org, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Christian Hewitt <christianshewitt@gmail.com>,
        Artem Lapkin <art@khadas.com>, nick@khadas.com,
        Gouwa Wang <gouwa@khadas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Yep! but

if i try call spi_master_put(master) or spi_unregister_controller(master);
it's made Segmentation fault for me

what's wrong - may be somebody can help me


On Mon, Apr 26, 2021 at 7:57 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Sat, Apr 24, 2021 at 07:57:19AM +0800, Art Nikpal wrote:
>
> > > I would expect the driver to unregister the controller at the start of
> > > the remove function, suspend doesn't really make sense here
>
> > It's strange - But without spi_master_suspend i have randomly stucks when i
> > try unload this module - as was written before
> > i was test it (load/unload module in loop) and for me suspend make sense
> > here
>
> > If anybody has another solution - or real problem not here - please write
> > to me the right way!
>
> As I said above unregister the controller at the start of the remove
> function.
