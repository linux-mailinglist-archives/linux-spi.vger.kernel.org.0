Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F97714CA08
	for <lists+linux-spi@lfdr.de>; Wed, 29 Jan 2020 13:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgA2MBu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 29 Jan 2020 07:01:50 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:39435 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbgA2MBu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 29 Jan 2020 07:01:50 -0500
Received: by mail-ua1-f68.google.com with SMTP id 73so6051000uac.6;
        Wed, 29 Jan 2020 04:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=II6jP9RfTeFZs+69kOn+DuyTf0n8DpC9lhDnS/Cus2A=;
        b=tRwtyby5Y6zJIsADGYIhdMxBrCuc6zdLKUisRUqUJ+TrFDkDcGAUCUV/dz7Hn7cIdr
         8s0KZz/rsMJ/88V3GVAvUEzonLgJuWYB1pzigA/HTy3PKnFaFJ6dgYkGv66FD3+Grkzo
         85VyXm7hmwXkl3YNLmIxI4mrpqNbDNvramNErDPzM1FlaCJsS5+zg9qhX/xJTNoXFrk6
         n9LSANynPVzs+b2YiMqZ4O3XKiB1QmChZcLSXfme3KA5XE+8Khg1WucVJQUdd+IyNbdx
         9JOqqFGgrF02RfPJsbezNAjAnhJYnfZsNDSeD0ZSDb8b/8/nncEI8YA0R/Sitz0eC2Wy
         ORzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=II6jP9RfTeFZs+69kOn+DuyTf0n8DpC9lhDnS/Cus2A=;
        b=RxXZnEhDLwfhMwvR8zAx4TnCrp31qk4dMW0wEJz0VckWK/7yHj1j/seNfR4sFdObqR
         W+T2Ey0AtviYDCU6ptb5p6v1lnt5D/Qjdfva3GOAOlmUePR4K7A4uJ/LOb63VmA+DP+F
         8iQOT/soKMGIONzJOEGqQacdi/jTjhOawk3PTvYV5Vgh3TCNvKfqnZfyD3mB8pBardda
         b9YAEgYIns7diakNFI8ys/XcjS7pYpHY5IdcyZNFlvYKWyeYY2hpicq4EajI6qWHgnD3
         jby4SQ0VhEGi4H+BmLfZ6fgNLfaZgWVn86e2wRJCzcs80dfB4Q0sWctO0LX5BBbFB3Jp
         WTqA==
X-Gm-Message-State: APjAAAUh7pypA2u3skRouWwITQcHreCFHox0bfqZmkW6hNNBe38qbG2I
        +4CUQZaSkJiktt00hQEiyO3OMw6wsU/ij1MV7MY=
X-Google-Smtp-Source: APXvYqzbhWAF50hEWqozzK2YSCQ4v92AP7++Ra6tAILK/GeatfgHx9QWGslbZzC+E0uvzCC6AEUS31YBJZixGqLu4gE=
X-Received: by 2002:ab0:248a:: with SMTP id i10mr15600216uan.108.1580299308894;
 Wed, 29 Jan 2020 04:01:48 -0800 (PST)
MIME-Version: 1.0
References: <20200129072455.35807-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200129072455.35807-3-vadivel.muruganx.ramuthevar@linux.intel.com>
 <CAAh8qszwQ5sJw4G_fM5vKjYu24xs03CuW371gyFE4G0hNJHdXw@mail.gmail.com> <abaae0fa-c2b8-bbe0-b64d-0ee4c95c1479@linux.intel.com>
In-Reply-To: <abaae0fa-c2b8-bbe0-b64d-0ee4c95c1479@linux.intel.com>
From:   Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
Date:   Wed, 29 Jan 2020 13:01:37 +0100
Message-ID: <CAAh8qsxRPx8KDyqvp=8zcrGCE82YJ_9O9cJXrgKdH7VwXeGQgg@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] spi: cadence-quadpsi: Add support for the Cadence
 QSPI controller
To:     "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Tien-Fong Chee <tien.fong.chee@intel.com>,
        Marek Vasut <marex@denx.de>
Cc:     Mark Brown <broonie@kernel.org>, Vignesh R <vigneshr@ti.com>,
        linux-spi@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, dan.carpenter@oracle.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

+ some people possibly interested in this for the Altera platforms (see below)

Hi all,

This is about moving the cadence qspi driver (which is used on TI, Altera FPGAs
and a new Intel SoC) to spi-mem.Vadivel asked me to include some Altera people
in the loop (see below), as this is the only platform currently untested,
I think.

Right now, I'm not in the position to test this myself as we're currently stuck
on an older RT kernel, so I cannot test with HEAD.

Feel free to involve other Intel/Altera if you're interested in that peripheral
not being broke for socfpga in one of the next releases :-)

On Wed, Jan 29, 2020 at 10:18 AM Ramuthevar, Vadivel MuruganX
<vadivel.muruganx.ramuthevar@linux.intel.com> wrote:
>
> Hi,
>
>   Thank you for the query and confirmation.
>
> On 29/1/2020 4:31 PM, Simon Goldschmidt wrote:
>
> On Wed, Jan 29, 2020 at 8:25 AM Ramuthevar,Vadivel MuruganX
> <vadivel.muruganx.ramuthevar@linux.intel.com> wrote:
>
> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>
> Add support for the Cadence QSPI controller. This controller is
> present in the Intel Lightning Mountain(LGM) SoCs, Altera and TI SoCs.
> This driver has been tested on the Intel LGM SoCs.
>
> So it has been tested on LGM and Vignesh gave his ok for TI. Is there anyone
> in the loop by now checking that this is valid for the 3rd platform using this
> (Altera)?
>
> Or am I wrong in thinking that this driver is meant to replace
> drivers/mtd/spi-nor/cadence-quadspi.c used on that platform?
>
> Absolutely , You are right, this driver is meant to replace to drivers/mtd/spi-nor/cadence-quadspi.c
> for Intel, TI and Altera SoC's using Cadence-QSPI IP.
>
> Meanwhile we have adapted to spi-mem framework (to support spi-nor/nand)and also didn't change the existing
> functionalities of spi-nor flash operations like hw_init/read/write/erase in drivers/mtd/spi-nor/cadence-quadspi.c,
> so it works fine (might be in Altera as well).
>
> Already I checked that Graham Moore <grmoore@opensource.altera.com> who has submitted the existing driver patches to upstream,
> His mail-id is bouncing back, then I decided that you are the right person to ask, could you please add them in loop if you know the team
> (socfpga platform engineers).

OK, done that. I mainly know them from U-Boot development, so I'm not sure
who's responsible for the Linux drivers...

Regards,
Simon

>
> Regards
> Vadivel
>
> Regards,
> Simon
>
