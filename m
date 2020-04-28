Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 838F71BCFB1
	for <lists+linux-spi@lfdr.de>; Wed, 29 Apr 2020 00:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbgD1WPF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 28 Apr 2020 18:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726559AbgD1WPE (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 28 Apr 2020 18:15:04 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B24EC03C1AC;
        Tue, 28 Apr 2020 15:15:02 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id ms17so123687pjb.0;
        Tue, 28 Apr 2020 15:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=boJZE6BDXCfHOPHK+WJ/6OwBrwj+STldC97IMfhZp3s=;
        b=RduMw49iN8JvvnMv/cE3eyIXbNhV/mgQp33cK83pwnb7bh6Ao9JvLoGUByPxtqMS82
         rsd5SbVostHX49VOHwyQw0dRszKU2VHomVMSwjnpYbDdm96YKzTXACFx/M9saR0PhSGi
         JZrH0crPabmdbwWVFXDzPSSTjZzUtaCIi2qiURujc/NQXGozlUvy8t6YzFpefcvw7jDw
         jA5Wpt9xsTrhjo3Vk2KlhW8R0H9/1OWrwvGDkwf+5X7sjs2bkkAmSsss4DU5ifgKNdbS
         AyzlvcEJGVaGlVHDPb4ju4UaQ0ioEOUeU3beEL7YmIzJ/ZNXpmQAZ6RRi+mf4N8pKUfN
         BryA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=boJZE6BDXCfHOPHK+WJ/6OwBrwj+STldC97IMfhZp3s=;
        b=HmBwUO0GcladYROfJvpwNPupiPjyU0NlO1v2nrn+kM9qML5e7P3OZmeSincHBqwI7X
         3yf02gUXfS3of7ej/cWQb9mjCueD1MqdyPBX3Vim5Y5rbulMbpKN0cNCjrgF7c5NqgRL
         O3uNfRRL62PRhNeMGuBuyRDazWL4x5M8HoFRGzAalHD8vJS1RZU5XRpR7rkarI7+83Xf
         PjhaMbSkikHmW8ZOVd4oeeQNyFKS/mnXhmdVjBMMN4Cv7QSWOs7PxcPF7h+Dh+KJi3s2
         KW8aT8uMHtrWdqrKVrN8ro+OGYF9UKX24KbwI9JuJdF/SXIavUPLzHAmdj3X2ABJm5zD
         G5fQ==
X-Gm-Message-State: AGi0PuYn1CKxpgY+HSNssjw7p9Ru/F9r9wSZeLNnHNRPrL5vHp6QkObY
        TiW4t70UzUXr7XrKXRmWyPk5pQn8tIlEMigJDv2Vh0J+
X-Google-Smtp-Source: APiQypIW6NH2ApbvCliWq4+GnhFXVj3ODpcigahv4DKl+tO6BF1ebBSrbhk+pudPUmomEsSTYaq2N4bZMhteCmM3CGs=
X-Received: by 2002:a17:90a:224b:: with SMTP id c69mr7881986pje.8.1588112101148;
 Tue, 28 Apr 2020 15:15:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200422141142.25591-1-wan.ahmad.zainie.wan.mohamad@intel.com>
 <20200428141449.GV185537@smile.fi.intel.com> <20200428180720.GO5677@sirena.org.uk>
In-Reply-To: <20200428180720.GO5677@sirena.org.uk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 29 Apr 2020 01:14:48 +0300
Message-ID: <CAHp75Vf6OenGTz3Pvg9QQVEygK71E5j-2W-s+0G6dh=QDDfR2Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] spi: dw: Add support for Intel Keem Bay SPI
To:     Mark Brown <broonie@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Apr 28, 2020 at 9:08 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Apr 28, 2020 at 05:14:49PM +0300, Andy Shevchenko wrote:
>
> > Rob, can we get your Ack if everything is okay, please?
>
> > I have more patches coming to this driver and I would not like to delay this
> > series to be applied.
>
> If there are problems with the DT binding conversion

We don't know (yet) if there is any problem, that's why I'm asking Rob
to have a look.

> it'd be good to
> make sure the next version of the series that moves it to the last patch
> so the rest of the series isn't blocked on it.



-- 
With Best Regards,
Andy Shevchenko
