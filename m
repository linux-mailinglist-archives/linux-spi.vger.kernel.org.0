Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A257158CE7
	for <lists+linux-spi@lfdr.de>; Tue, 11 Feb 2020 11:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbgBKKtw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 11 Feb 2020 05:49:52 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:36212 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727805AbgBKKtw (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 11 Feb 2020 05:49:52 -0500
Received: by mail-il1-f196.google.com with SMTP id b15so3047289iln.3;
        Tue, 11 Feb 2020 02:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eHqxkFhOftXeIrIg8vUiaV+dk3ty7YkSnlLZYLlo5Ko=;
        b=qCcZP1t+3ytI3YacltBjs5aKyI9mSEFglR48Tb8Mrub6EIG2JXT27BMmeSwlJsMmE5
         nD3++mwLzkcVxY5Sdec9Mubfc/z4ZWB5alqUoO8Sn6YnKKM/R3iQtfo+iXt6ALg/ukhj
         urQg/71GNxQoYQeiUcku2HlWH5uhLitfmxayfbJbMfkPReSc9D0lvKNilG/HXLcI3TMZ
         U6yHFwNBJociSPqISHUoLEssn8rQ5Z5YHScHZKxEjflOdHHWll4yHLuD+NNMjUWQ1wC+
         KODO6dsc8Z7WswM0+DXXxwwRQ4iqg2N6q1tj3zBW31JmM/W0BSZQhcOuJ5SCenFgRdfO
         HELA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eHqxkFhOftXeIrIg8vUiaV+dk3ty7YkSnlLZYLlo5Ko=;
        b=rRMmp85JxsbyG4MeYtxYw24Aclv0aUyFDJIv8d1T8mDCr76IcDuVC6wZZB61++qZSV
         g43KU3D3QUqk4x1SDWwI+phzAFGwD30ToO6RWt39hVf4b1agdNEzoq4T4MjhnIQqtGcK
         tMUncrAWs1MrKflSvf+uG3freRFiIbuNIPytgZExI5+SOkV7mG0VanMPMZJUbqQ8d99J
         k/gjThCBBCQ+tiOyko1S+VT83ZwW/ps4ioegqptKtkMjGC6TnHAf0200biLp/pgh69l8
         trVkZj50ztwTkeZUsl6mxBkjMQG002ynovMPZmbdUg4VnBZBNBVg8P65l2o9P+L+omRu
         Ot0w==
X-Gm-Message-State: APjAAAXVRS8DVbHAeA9wmDFGkbLS5AZGjTEqwF/KJ13PRmMAH5VjB3Xw
        SQvgpIaF5xf8HJarTt7NWyuMwTMrsJGQ+GONRuw=
X-Google-Smtp-Source: APXvYqyV+gu2TZnHhPamDm/mFEOi79lFtDv1oEvHa0mxrqSPfvikSLJ/I2MVcG7LFj84tE+XHcvU+qhf4aKcVcfBz3k=
X-Received: by 2002:a92:350d:: with SMTP id c13mr6001818ila.205.1581418191475;
 Tue, 11 Feb 2020 02:49:51 -0800 (PST)
MIME-Version: 1.0
References: <20200202125950.1825013-1-aford173@gmail.com> <20200202125950.1825013-4-aford173@gmail.com>
 <20200206184030.GA11381@bogus>
In-Reply-To: <20200206184030.GA11381@bogus>
From:   Adam Ford <aford173@gmail.com>
Date:   Tue, 11 Feb 2020 04:49:39 -0600
Message-ID: <CAHCN7x+uCwyJ60ZG_0m5SgNmqUAyEwxqXVTL7nQzJLXxXrh+Tw@mail.gmail.com>
Subject: Re: [PATCH V2 4/5] dt-bindings: spi: spi-nxp-fspi: Add support for
 imx8mm, imx8qxp
To:     Rob Herring <robh@kernel.org>
Cc:     linux-spi <linux-spi@vger.kernel.org>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        Ashish Kumar <ashish.kumar@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Feb 6, 2020 at 2:46 PM Rob Herring <robh@kernel.org> wrote:
>
> On Sun, Feb 02, 2020 at 06:59:49AM -0600, Adam Ford wrote:
> > Add support for nxp,imx8qxp-fspi and nxp,imx8mm-fspi do the bindings
>
> s/do/to/

Oops.  Thanks for catching that.

>
> > document.
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> > ---
> > V2: No change
> >
> > diff --git a/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
> > index 2cd67eb727d4..7ac60d9fe357 100644
> > --- a/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
> > +++ b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
> > @@ -2,6 +2,9 @@
> >
> >  Required properties:
> >    - compatible : Should be "nxp,lx2160a-fspi"
> > +                         "nxp,imx8qxp-fspi"
> > +                         "nxp,imx8mm-fspi"
>
> All 3 are different and no compatibility?

This was all based on a series from NXP's repo where they have some
data tables all associated to the various compatible entries, and they
created a place holder for quirks.  Based on an older NXP repo, it
seems like there might be some quirks associated to the different
families, but the newer repo where I got this patch series didn't
implement them, however, it's possible the quirks may enhance
functionality later. If that's true, I think this is the best solution
for future enhancements without having to change the compatibility
names down the road.  Maybe someone from NXP can comment?  I am just
trying to help push things upstream so we can support QSPI flash.  I
would prefer to keep them separate for now, because we might have
these improvements later. However, I'll do what you request.  Do you
want me to drop the additional compatible flags and just use the
original, or create a new one that's a bit more generic?

adam


adam
>
> > +
> >    - reg :        First contains the register location and length,
> >                   Second contains the memory mapping address and length
> >    - reg-names :  Should contain the resource reg names:
> > --
> > 2.24.0
> >
