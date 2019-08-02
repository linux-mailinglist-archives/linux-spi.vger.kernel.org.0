Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8AC7EFB7
	for <lists+linux-spi@lfdr.de>; Fri,  2 Aug 2019 10:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732563AbfHBI75 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 2 Aug 2019 04:59:57 -0400
Received: from condef-04.nifty.com ([202.248.20.69]:61974 "EHLO
        condef-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728232AbfHBI75 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 2 Aug 2019 04:59:57 -0400
X-Greylist: delayed 501 seconds by postgrey-1.27 at vger.kernel.org; Fri, 02 Aug 2019 04:59:56 EDT
Received: from conssluserg-05.nifty.com ([10.126.8.84])by condef-04.nifty.com with ESMTP id x728hC8g001018
        for <linux-spi@vger.kernel.org>; Fri, 2 Aug 2019 17:43:12 +0900
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id x728h6K2001670;
        Fri, 2 Aug 2019 17:43:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x728h6K2001670
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1564735387;
        bh=wardMXZhqHfzRdaUlSRopeNLdww/l/rmzyPDmUhlXoo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VgRGuQWUqhWhXTBkiq4DIonh2QCcj/QII79U1nOFS+0JcL4bpKDpYrxykm3tnyvll
         n1Ee5JP7t9W00qU/H9nOYEcFZbHArDCHE3NoTVMNBbbXXy9Zzot4keYIQKUyaCCjDC
         gq0jZaiJHoB51JXyk7csyKde3gmsp0uCjNBBQ9Btz9CJTv0B1KvZ1IQU34rWuhIUMr
         Vmaj6IZ8GyWFf5XQlbjF1xMXJFsfYsfFGZF6e1krbFxMtAPFF+z+Wsw/wM17JAV7VD
         MFT7kpGiY6fEzGGpB3/qeCdQ7X21CIqyyPVOB5LJ0Go3YJEP5ZGU+1en/oOXY2ed+8
         5rBEWfAnGzDTg==
X-Nifty-SrcIP: [209.85.217.47]
Received: by mail-vs1-f47.google.com with SMTP id h28so50790795vsl.12;
        Fri, 02 Aug 2019 01:43:07 -0700 (PDT)
X-Gm-Message-State: APjAAAVPpNcPs9acSAhXYvK7ueGc7sLMrO+qy5LqtZUz4MzC+L0Ss+jx
        JHlKPc5zlFyutq8VsiRp3mTNWW1zgjEFADoZo7I=
X-Google-Smtp-Source: APXvYqxb7HdOEocm1IkNIV8cZl+5shkbOoifQs/U/sfBj+Ev+87riBEz7Tu/XQyoeC1AxLbAnSyV3St7fc8y/cJtAOw=
X-Received: by 2002:a67:8e0a:: with SMTP id q10mr61970449vsd.215.1564735386265;
 Fri, 02 Aug 2019 01:43:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190728161304.32022-1-yamada.masahiro@socionext.com> <20190729105125.GA4787@sirena.org.uk>
In-Reply-To: <20190729105125.GA4787@sirena.org.uk>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 2 Aug 2019 17:42:29 +0900
X-Gmail-Original-Message-ID: <CAK7LNASq-WB5zJ+3uFHtzxtc2Vhmv5SKRXA2JwwFGrR5q9uMnw@mail.gmail.com>
Message-ID: <CAK7LNASq-WB5zJ+3uFHtzxtc2Vhmv5SKRXA2JwwFGrR5q9uMnw@mail.gmail.com>
Subject: Re: [RFC PATCH] spi: tle620x: remove stale driver
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Jul 29, 2019 at 7:51 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Mon, Jul 29, 2019 at 01:13:04AM +0900, Masahiro Yamada wrote:
> > This driver seems obsolte because this driver needs platform data
> > but no one in upstream passes it.
>
> I've not noticed this driver getting in the way of anything?


I just happened to take a look at include/linux/spi/tle62x0.h
when I was working on my header-test feature of Kbuild.

Then, I asked this in ML, and Arnd was positive
for deleting this.

https://lkml.org/lkml/2019/7/21/19


IMHO, stale code should be cleaned away periodically.

Yet, if you are happy with keeping this driver,
that is fine.

If we could get comments from Ben Books,
that would be helpful.




-- 
Best Regards
Masahiro Yamada
