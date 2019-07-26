Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21C8276540
	for <lists+linux-spi@lfdr.de>; Fri, 26 Jul 2019 14:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbfGZMKS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 26 Jul 2019 08:10:18 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34770 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbfGZMKP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 26 Jul 2019 08:10:15 -0400
Received: by mail-ot1-f68.google.com with SMTP id n5so55157672otk.1
        for <linux-spi@vger.kernel.org>; Fri, 26 Jul 2019 05:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JrQTsqOEOykeYsYpjUAu93byMK1KwkPcKibV3U5vnJs=;
        b=n/Tfy/qYbxxPMGO0GtR4PSwWNzJiHr/teYhJWdmOLIQXeIGRhXlrNAOjHxIg44X/c8
         rTMphlu7MEMszPQPE7i0KXL/fg/5WjYEzxco2QaaRD1yrK2bg+KCzZWa39ZRgNTM2LtM
         lCI+/my1YocZGIgiqhq3JHhPYzlOqgYvp6ZdftyiDQSF1s5Nqn4vzv+ZzYEuh31enYTk
         jjQ04X5nn2NicQK3HyVuUjV+toViPvNj+wcJA44R4DusLvIx9mXjaDaZ27VLOEOxPKkn
         k32sNyCUvsUw8nN+h7F+9P8EGFwgzyFqenM4BP1xKx9k2fNKMAwbFIXSWbIArOH/RDFF
         Qdtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JrQTsqOEOykeYsYpjUAu93byMK1KwkPcKibV3U5vnJs=;
        b=cb48iI6JrhH3OOb5J9jPx9jmj1biGJ7fA2MLleajJz1Go660QSXMkQaQ1d5K1utBld
         m3wehBbL3+0Nj3/1MV9a2P+o7A6k11nIyAtFXKTUhn+Ew9CaqxMDTHRyVvm1ii4Lzt0x
         Bnc1yGcc7P/fx/0wcHNgj1aisHh4TIjMBlhUW7BK+B10S0FfWVK1f2RBy+mAmTF11ZVs
         7VBe3tEQIMYke2Ys01LI6qNcFsq5qWw3aW2om2A/LakO3cYunuDU7PukT5uQhTWwvCfC
         JkrZK1mrkwoYdXlZHKs4BtnnwnDBK3uU7+sjIj5Woom0eoISKwT7iQc17OJ94TI1EWZT
         lujg==
X-Gm-Message-State: APjAAAU92u2XG8WF0PTuf+cobBzdJAAGO2tGWOLsUwlPnP3SGpk9KwVo
        fA65Msfs5sG47i6L61DO1DBO33ytgm7y5XgjIZGUkA==
X-Google-Smtp-Source: APXvYqywRN7n6lzmjA5a4KHs4TPzxtEcwP96gaeiFcPkyYj2chffCIcDU5MoSxlTXx3/N/hta8tMsIUOdAnpviY8SDk=
X-Received: by 2002:a9d:529:: with SMTP id 38mr69587609otw.145.1564143014185;
 Fri, 26 Jul 2019 05:10:14 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1564125131.git.baolin.wang@linaro.org> <23d51f5d9c9cc647ad0c5a1fb950d3d9fb9c1303.1564125131.git.baolin.wang@linaro.org>
 <20190726112901.GC4902@sirena.org.uk>
In-Reply-To: <20190726112901.GC4902@sirena.org.uk>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Fri, 26 Jul 2019 20:10:02 +0800
Message-ID: <CAMz4ku+3FVOYr7Gvh-Yrdhvw2cfntbnEkhONYGbC71UmCgZA-A@mail.gmail.com>
Subject: Re: [PATCH 6/6] dt-bindings: spi: sprd: Change the hwlock support to
 be optional
To:     Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>, weicx@spreadst.com,
        sherry.zong@unisoc.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark,

On Fri, 26 Jul 2019 at 19:29, Mark Brown <broonie@kernel.org> wrote:
>
> On Fri, Jul 26, 2019 at 03:20:53PM +0800, Baolin Wang wrote:
> > No need to add hardware spinlock proctection due to add multiple
> > msater channel, so change it to be optional in documentation.
>
> Please use subject lines matching the style for the subsystem.  This
> makes it easier for people to identify relevant patches.

The subject lines format 'dt-bindings: xxx' was recommended by Rob, so
I am not sure if I need to change the format as 'spi: sprd:'? Thanks.

-- 
Baolin Wang
Best Regards
