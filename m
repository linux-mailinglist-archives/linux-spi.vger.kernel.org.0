Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7CD7127EE1
	for <lists+linux-spi@lfdr.de>; Fri, 20 Dec 2019 16:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbfLTPB1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 20 Dec 2019 10:01:27 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44659 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727362AbfLTPB0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 20 Dec 2019 10:01:26 -0500
Received: by mail-lj1-f195.google.com with SMTP id u71so10304035lje.11
        for <linux-spi@vger.kernel.org>; Fri, 20 Dec 2019 07:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=newoldbits-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=N/ljYV8b1qvhi8OUxOGT6VrYFdvE16U1QnhxGL4VbDQ=;
        b=PFTcCyE5lmTJ7zs8PFa4WP8ZCUWLfdHuy3sj7tZ0rVdCdcS7iSLcsaMnp7XI2GD/Au
         zWtxV4r2cJa/VJDaZk1bEqXv66mm3M29QS/1zdcfS8kTSupzIjJ9mq29VO5qDUwXikMB
         OEehulm0oFqqv+ujKAFOMPUJdj48oEeRetBwozQNjItdRQqUedBxX5+BvdpwJH4CBd4t
         Hm4ZsAmiHToeUXMqeUfzsJjh0vhu05rE/cQPzCz9cdV0e795SwO7YbameBFKXSl6CH95
         utli7xAFdDLO9nx5aCIuxE+hgNxLIhVrefKZ8hXxFYWUeynTAW6cN/ZgQVFexhA7/1WJ
         8oBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=N/ljYV8b1qvhi8OUxOGT6VrYFdvE16U1QnhxGL4VbDQ=;
        b=CAr8buhPnP6cb415zi+LWjjLOtYh8uYKtGE5xJBdp/4A/R36+AYdJUsuv8tHrKIE3Q
         QeT1yq8zFUXNZxAloqerFegqFtZ0g1rkO9fj5FKTbE4n50iBbvDCkP61KEdsF7IDEb1t
         sJDluU5aw+tvvkeW/5OraSkcqPRhFJ0syODAwDaokvyRi0vv8tL3/IgV5djeHWz8Q2Ur
         w4ZZoNVecX6WeroghSkNe/bnynnrpsr/02szRG4KGyPX3mqQroI37X282jd9HeelsfCx
         ylMUNmRdYuo5xmGDBdMtnKiqH1bjxvr58GS5CyaF7G3tKUIpfgw5PpekpiC3Dcj4jpO1
         TStw==
X-Gm-Message-State: APjAAAUlCUWyCw+UziU7la7dzPX96FV0HEJizdW/eJ9fSU9FwDk+pZrC
        AvqPJNZSTaCub0eUVPXoT2sqoPZwFRll9V9AUOreoA==
X-Google-Smtp-Source: APXvYqzaL7tUgedzSpCPrACjOyVBFXQP/XXGN5x3MNi0usJsoByLurnG5jdSRK0Donfl6aN9/zw8SchbiMzM+VXrVV8=
X-Received: by 2002:a2e:9cd8:: with SMTP id g24mr9884543ljj.243.1576854084696;
 Fri, 20 Dec 2019 07:01:24 -0800 (PST)
MIME-Version: 1.0
References: <20191211193954.747745-1-jean.pihet@newoldbits.com>
 <20191211193954.747745-3-jean.pihet@newoldbits.com> <20191220130830.GH4790@sirena.org.uk>
In-Reply-To: <20191220130830.GH4790@sirena.org.uk>
From:   Jean Pihet <jean.pihet@newoldbits.com>
Date:   Fri, 20 Dec 2019 16:01:13 +0100
Message-ID: <CAORVsuVqHRYZ-CbD=L-pLkJLDmLPmGm=EtTRKGa=ncbr_gz5iQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] spi: spi-ti-qspi: support large flash devices
To:     Mark Brown <broonie@kernel.org>
Cc:     Tony Lindgren <tony@atomide.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org, linux-spi@vger.kernel.org,
        Ryan Barnett <ryan.barnett@rockwellcollins.com>,
        Conrad Ratschan <conrad.ratschan@rockwellcollins.com>,
        Arnout Vandecappelle <arnout.vandecappelle@essensium.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Dec 20, 2019 at 2:08 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, Dec 11, 2019 at 08:39:53PM +0100, Jean Pihet wrote:
>
> > +                     if (op->addr.val + op->data.nbytes > qspi->mmap_s=
ize) {
> > +                             max_len =3D qspi->mmap_size - op->addr.va=
l;
> > +                             op->data.nbytes =3D min(op->data.nbytes, =
max_len);
> > +                     }
>
> This introduces a massive warning splat for me (just one warning but
> it's very verbose):

I do not have it here on a buildroot build.
Let me check it with more verbose compile flags.

Thanks for reviewing!

Regards,
Jean

>
>   CC      drivers/spi/spi-ti-qspi.o
> In file included from drivers/spi/spi-ti-qspi.c:9:
> drivers/spi/spi-ti-qspi.c: In function =E2=80=98ti_qspi_adjust_op_size=E2=
=80=99:
> ./include/linux/kernel.h:844:29: warning: comparison of distinct pointer =
types lacks a cast
>    (!!(sizeof((typeof(x) *)1 =3D=3D (typeof(y) *)1)))
>                              ^~
> ./include/linux/kernel.h:858:4: note: in expansion of macro =E2=80=98__ty=
pecheck=E2=80=99
>    (__typecheck(x, y) && __no_side_effects(x, y))
>     ^~~~~~~~~~~
> ./include/linux/kernel.h:868:24: note: in expansion of macro =E2=80=98__s=
afe_cmp=E2=80=99
>   __builtin_choose_expr(__safe_cmp(x, y), \
>                         ^~~~~~~~~~
> ./include/linux/kernel.h:877:19: note: in expansion of macro =E2=80=98__c=
areful_cmp=E2=80=99
>  #define min(x, y) __careful_cmp(x, y, <)
>                    ^~~~~~~~~~~~~
> drivers/spi/spi-ti-qspi.c:535:23: note: in expansion of macro =E2=80=98mi=
n=E2=80=99
>      op->data.nbytes =3D min(op->data.nbytes, max_len);
>                        ^~~
> ./include/linux/kernel.h:844:29: warning: comparison of distinct pointer =
types lacks a cast
>    (!!(sizeof((typeof(x) *)1 =3D=3D (typeof(y) *)1)))
>                              ^~
> ./include/linux/kernel.h:858:4: note: in expansion of macro =E2=80=98__ty=
pecheck=E2=80=99
>    (__typecheck(x, y) && __no_side_effects(x, y))
>     ^~~~~~~~~~~
> ./include/linux/kernel.h:868:24: note: in expansion of macro =E2=80=98__s=
afe_cmp=E2=80=99
>   __builtin_choose_expr(__safe_cmp(x, y), \
>                         ^~~~~~~~~~
> ./include/linux/kernel.h:877:19: note: in expansion of macro =E2=80=98__c=
areful_cmp=E2=80=99
>  #define min(x, y) __careful_cmp(x, y, <)
>                    ^~~~~~~~~~~~~
> drivers/spi/spi-ti-qspi.c:545:22: note: in expansion of macro =E2=80=98mi=
n=E2=80=99
>     op->data.nbytes =3D min(op->data.nbytes, max_len);
>                       ^~~
>
> Using compilers from Debian stable.
