Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0E1D2DFF96
	for <lists+linux-spi@lfdr.de>; Mon, 21 Dec 2020 19:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgLUSVX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 21 Dec 2020 13:21:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgLUSVW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 21 Dec 2020 13:21:22 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A082CC0613D3;
        Mon, 21 Dec 2020 10:21:07 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id bd6so4834102qvb.9;
        Mon, 21 Dec 2020 10:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YQyxMOAZavE8xWe7epnSrp7G2ojv5j6Sb/NY3BtEg90=;
        b=EhkwNlHmCF+mbmZdrC06M89+vsXiApYrR+/qS/L6MPLb/pvSjaFJYYH6awt8PTWae2
         27kLcdkE1a9okCsXHPMMmOwv89vzgvOLKGPcwcNndBT6ty3MyRjqeONUGfwIaX3j6pPg
         tTT378bWBdGN+nexdiWHlZX3N6uW7HnFcPmAgWz00rN7X9ocjBiKW7K5dDyxK7wVTksI
         eK7i1ySXUkklSJDoI8C1kdArK8orMTInF7eZr5G7tSq/AzYCWcWpiHe8i05T/sOQATK/
         Ext7ImN/q/UEMzSa8/kBGFX2ecNISWKqszhFzH1WnpjqRxu+jysmW4VH/tw3p4yA2tDQ
         Chww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YQyxMOAZavE8xWe7epnSrp7G2ojv5j6Sb/NY3BtEg90=;
        b=Xo4qvHJrfLzVTmc0cBIzz71XwJAIkH8ir+CKAUXFUj7mkOg2lMFu6HC6rmcQbZvQu9
         uf7HLAtnJDjZCYXqcmU/a9SVXDcLp5CyUloMEYKs3Px1+3kLEesdvLpAJgGxT/JIGeRt
         voTREClL4ojEWKMQwYVxlYMfmtG1TSz8EPbldCbrGGghsINHs7KJ4RyCiPfg896jT2yP
         kFZRD1YtZbUaPnWMVq2mCMHIP63pnYx6ihUbfkqBmaIVGmQFEu30yCzgz6/DhXwFbrM5
         9CZO56VUsshw5WloJN2SbKxIo7mvz/N126+cuq2sNZJqfeTacgpb7xGDHpO/hHP9C68Z
         VuhQ==
X-Gm-Message-State: AOAM532flmMZbk+0NqXiajMs/7YCrT8/QN9mxYaL4nRifKkg5WFQW7gw
        Z1An7wQxAc4LB+a/k0U3zyXnfCYfiu4CzFyJdwhKfO/ANjg=
X-Google-Smtp-Source: ABdhPJx5AWw3ZNb2YvJW/rtqH2L4WLH+VXv1atxRvPxfxaY9gK+sKEVMevoq/0sY9BZzty5UBI4aZ6NX7Oy6hWq0I6k=
X-Received: by 2002:a17:902:e98c:b029:da:cb88:f11d with SMTP id
 f12-20020a170902e98cb02900dacb88f11dmr17381890plb.17.1608571434318; Mon, 21
 Dec 2020 09:23:54 -0800 (PST)
MIME-Version: 1.0
References: <20201221141906.48922-1-alexandru.ardelean@analog.com>
 <20201221141906.48922-2-alexandru.ardelean@analog.com> <CAHp75VfR1eNMry8JwJoFuaU48KZ6rdBWau=yaR1AnsaRSLTC=g@mail.gmail.com>
 <CAHp75VftBQEK10Z7pkD18fpr8B7ipCXUXVx=1Hnuq-2w=z2hgQ@mail.gmail.com> <CY4PR03MB29666C090DF4E882DFB5AA12F9C00@CY4PR03MB2966.namprd03.prod.outlook.com>
In-Reply-To: <CY4PR03MB29666C090DF4E882DFB5AA12F9C00@CY4PR03MB2966.namprd03.prod.outlook.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 21 Dec 2020 19:24:42 +0200
Message-ID: <CAHp75VcVDCL1VnUzmAmcDJ3deveXy-S8C4gaiKJGAts3V8FjSA@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] spi: Add SPI_NO_TX/RX support
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Dec 21, 2020 at 5:19 PM Ardelean, Alexandru
<alexandru.Ardelean@analog.com> wrote:
> > -----Original Message-----
> > From: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Sent: Monday, December 21, 2020 4:37 PM
> > On Mon, Dec 21, 2020 at 4:34 PM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:

...

> > One nit, though...
> >
> > > > -               "setup: can not select dual and quad at the same time\n");
> > > > +               "setup: can not select any two of dual, quad and no-rx/tx "
> > > > +               "at the same time\n");
> >
> > Can we avoid splitting string literals which are assumed to be on one line when
> > printed?
>
> It ends up at about 96 cols, but it's within limits.
> The patch may have been written before the new 100 col-width limit.

JFYI: string literals do not have limits (neither 80, nor 100).
It's a special category.

-- 
With Best Regards,
Andy Shevchenko
