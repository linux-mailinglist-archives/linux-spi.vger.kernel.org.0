Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66A693AE771
	for <lists+linux-spi@lfdr.de>; Mon, 21 Jun 2021 12:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbhFUKqd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 21 Jun 2021 06:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbhFUKqd (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 21 Jun 2021 06:46:33 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F372C061574;
        Mon, 21 Jun 2021 03:44:18 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id g4so9738631pjk.0;
        Mon, 21 Jun 2021 03:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DzKcTgIKNYDuFjG2WDdnfH4KwIP/17p6jNsN/iYSEK4=;
        b=MsDvwPLle7M86KT1QJMKorhLgd2F+5wzMd5P3z4kpa8BZQ248ySkw/KI4HwQ8W/Ien
         HST3rGJjp8wcgWVbSV7nRDWAmxu8RxnrJM8CnD5jHGkTjBy2oUifJSDhx0ckw5JInOpO
         lKQTEeH37h4pGOFwUeTXUNWfVLrOcHVNYVC0i181IXA0HOT5enF0LmhJD47w1gG3HwdC
         os4icNUius93nBMMsl+NeTQBwkSw/BCH/nUrKTv/dyqcXNw9TkYdgIZXRAs0ff2G4uJz
         r8EIc3dDPmk2n6reaCDBRoz61K7uYrVa7vvIpG5fgBTr9fkQ1aeSJ4QSKQgzTJYS0bDu
         lxlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DzKcTgIKNYDuFjG2WDdnfH4KwIP/17p6jNsN/iYSEK4=;
        b=ZfTot3NI5pWjW0KDz5Sk/ndcxxHas6RgJNjm8ZLDwofAxakXDMmBM+ew8KePI0PakI
         QujX9YGtvIJtj4wuEZc50qm+1ZdmdwsibQSJrV1DV1AhqupvtZdsLl7OJ4h3E0aL/Ulw
         iv9LbkcZsh4gDiSQYh2jbdqSCPtCyXGTtG6qMIQ/T2IIjZgjzz8xixbPo1Iu2mF/ACNz
         pmUCf8+HGQSk3Ks0CB5UK01HLn59JVZ7GERxbPTj/Ug+QzxU9lWH9R1gKmLUgsfrUUa4
         va4P9piaUTmb8XdqC8CvGIYLWANt3sdqMATyrvu9n/Gancy+XMcYlmSajLGzyGoCsxgd
         8guQ==
X-Gm-Message-State: AOAM532KleSTjTZ0XSQifODiZowctU/ThYGF8MQnnl43Vd/oCjfXZ3Yf
        /HazYvQ6gMfK8v64SWdpXY8F1EwAVA3BGcTQxAH7L9orjNk=
X-Google-Smtp-Source: ABdhPJzOETVZ8l9h+Rjexf6EiUmrD7OBpYfQCs542VHR2ifwcaetCafsV7QYZhowUA4W3oo2kjGu7cYc1c+DwzpyekQ=
X-Received: by 2002:a17:90a:17ad:: with SMTP id q42mr38209920pja.181.1624272257803;
 Mon, 21 Jun 2021 03:44:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210619111526.27776-1-andriy.shevchenko@linux.intel.com> <20210621103923.GA4094@sirena.org.uk>
In-Reply-To: <20210621103923.GA4094@sirena.org.uk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 21 Jun 2021 13:43:41 +0300
Message-ID: <CAHp75Vc8CDRBKMiJNehsU2CUc4VVrWL9fHZO1rr7V7pZDg_QaQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] spi: Remove unneeded parentheses in spi_map_buf()
To:     Mark Brown <broonie@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Jun 21, 2021 at 1:40 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Sat, Jun 19, 2021 at 02:15:26PM +0300, Andy Shevchenko wrote:
> > The boolean expression to get kmap_buf is hard to read due to
> > too many unneeded parentheses. Remove them for good.
>
> > -     const bool kmap_buf = ((unsigned long)buf >= PKMAP_BASE &&
> > -                             (unsigned long)buf < (PKMAP_BASE +
> > -                                     (LAST_PKMAP * PAGE_SIZE)));
> > +     const bool kmap_buf = (unsigned long)buf >= PKMAP_BASE &&
> > +                           (unsigned long)buf < (PKMAP_BASE + LAST_PKMAP * PAGE_SIZE);
>
> No, I think this makes things worse - to the extent there's an issue
> here it's not excessive brackets.

How? I can't see any issues here and dropping excessive brackets helps
to read it better. For example, the exterior brackets do nothing
except making it harder to read, i.e. the expression inside them is
already type of boolean and I have no clue what they are for.



-- 
With Best Regards,
Andy Shevchenko
