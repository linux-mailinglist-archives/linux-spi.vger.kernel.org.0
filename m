Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5B02C28CA
	for <lists+linux-spi@lfdr.de>; Tue, 24 Nov 2020 14:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387709AbgKXNyr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 24 Nov 2020 08:54:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387631AbgKXNyq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 24 Nov 2020 08:54:46 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94395C0613D6;
        Tue, 24 Nov 2020 05:54:46 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id n137so8524659pfd.3;
        Tue, 24 Nov 2020 05:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bFiWTt4rZpALfk96ockHBL57Xo1g7R1/SK5/u3ELrPo=;
        b=R8ne0sI0l2GBu9LhZhD293kTbgsrhybMTsS76z0V/dkcAHOoj3Yds5LyLL9tiG+OpJ
         Gx1e6u9z2n1NxASuR9/AwcM1cHq0nlvX+pNudrfxAznUtHqt+sJnPCgBF9Wf2NBvcB6c
         bcsExc2IhEJxqABrgiaZtlNAmXSCG6jwTKvExS9TCbbtzCHcCP8jishZljGcYyIecttG
         3FdaLTiLeNGDCTrew8CM8PslsDZbQdKQwvdCWcJNdf1lnxamOcrDZMxKXMxjg4bKJOKP
         Cbrwi7HmgpFjCpk5EagIB3KjFY0iQAM9ljgkJr3I4lLtfHOccOFPpWZGaPVzh2264mcV
         LsHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bFiWTt4rZpALfk96ockHBL57Xo1g7R1/SK5/u3ELrPo=;
        b=nJp76Bsei1QLMJ/7tKZbf/OVL5Qj9qYSJCUpvcfZ/NfcLZN92hEgxaa1rQbOOWD8i4
         /eSxfFwJzjwQb2kN0vFVTltZX3jIhToDn3lvX+46d5zDDwB+iRUTSoAzeDy3O2YJO3v2
         zXgd7/rmay9cuO4Av3MbRd/Nn0H154PuLQXrSOdFMWk4WnQeZkQT14MbM5LJDNDZsBll
         CktNTy2eOBaHheB9FHQ5JC4xc7MyeZupeb7555BmCYVxdPb7MevmHSHyi+KkRMdw3iR8
         w0Xb2J23h/A7S2zfkBNjBDr/R3qHFFkmoJZ81EYARZWGqrPZKVkddzIaQTkqqQP3u7PP
         5uvg==
X-Gm-Message-State: AOAM531FUxCsBmJokxrAPdWkb52vftz+QuWieQ/S/1Z2oC12K24QSxIW
        TWc1mTJhiNir4dZ5Id2OO5klKpRqoZzEmIuUo5A=
X-Google-Smtp-Source: ABdhPJw27eAo6K7hsc4Xr4GhI6SZcvJOUxCtVuen5OJhSaaFoF1LpsXMRUyUf1y/TPfXkqjSrZJcMoKLEdbL66/Fa0Q=
X-Received: by 2002:a63:1514:: with SMTP id v20mr3847208pgl.203.1606226086051;
 Tue, 24 Nov 2020 05:54:46 -0800 (PST)
MIME-Version: 1.0
References: <20201124102152.16548-1-alexandru.ardelean@analog.com>
 <202011241901.eIm4FyEB-lkp@intel.com> <CAHp75Vc+M2veG25pehO-8LSj0WcXvotijwaYvkYvAr3LF1n10Q@mail.gmail.com>
 <DM6PR03MB4411ABE610061A840224159EF9FB0@DM6PR03MB4411.namprd03.prod.outlook.com>
In-Reply-To: <DM6PR03MB4411ABE610061A840224159EF9FB0@DM6PR03MB4411.namprd03.prod.outlook.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 24 Nov 2020 15:55:34 +0200
Message-ID: <CAHp75VeNEAxgSjpe1A5dvsW_Rqnp5K5FwHk_Zfopr_--raNDXg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] spi: convert to BIT() all spi_device flags
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     kernel test robot <lkp@intel.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Nov 24, 2020 at 2:03 PM Ardelean, Alexandru
<alexandru.Ardelean@analog.com> wrote:

> > >    In file included from drivers/spi/spidev.c:26:
> > > >> include/uapi/linux/spi/spidev.h:33: warning: "SPI_CPHA" redefined
> > >       33 | #define SPI_CPHA  0x01
> >
> > Argh! Can we have only one set of flags?
> >
>
> My bad here for not catching this earlier.
>
> It might be an idea to create a "include/uapi/linux/spi/spi.h" and include this in " include/uapi/linux/spi/spidev.h "
> Then the " include/uapi/linux/spi/spi.h " would also be included in " include/linux/spi/spi.h "
> We would naturally drop the BIT() macros for the uapi header.

uAPI has its own _BIT*() macros.


-- 
With Best Regards,
Andy Shevchenko
