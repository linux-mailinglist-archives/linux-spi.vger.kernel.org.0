Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2BEA4CD27
	for <lists+linux-spi@lfdr.de>; Thu, 20 Jun 2019 13:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731736AbfFTLwI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 20 Jun 2019 07:52:08 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:38017 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731670AbfFTLwH (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 20 Jun 2019 07:52:07 -0400
Received: by mail-io1-f67.google.com with SMTP id j6so938198ioa.5
        for <linux-spi@vger.kernel.org>; Thu, 20 Jun 2019 04:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jVBoYYRrPBDX+kuGGwJPxxJyMS52ARosg5ixIQGjklw=;
        b=DG0f4JGtv059/Otp9svxTQ7njz9mcZtnMRJhcJc0feDSJgaUeNwEcG5g8Xf2vxCfyn
         w0zh7s2+bbbvVobQE/8ThchUy0Xt/pHHoFy6pTJC/yqrqwP5FqGs6sIuj3OUI5m1EfVz
         2g3tKSjHO9Ky66tIBBbocjmvz5JZpAdleFBaCjUgQe2vXT7SBdlIuAYvk1BcKTX0AoyY
         SUCuU6l3TmqmhpRFy2wcwuoKgRxdgWTXhodNwD+IrMXlAY+0tymK4OWAtTqLie84cPlC
         mnt3Fvb1un4XWtpc97X6UHCMWT6mlDEyUcxSiqQh5hPHpi7+tZO3uUmE2xuJABrZviZs
         GpbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jVBoYYRrPBDX+kuGGwJPxxJyMS52ARosg5ixIQGjklw=;
        b=MKKECwyGdqBEjDTywlN3SsxNKgQOdzxQXeWnPilujK0LeIq1bt1NUmb6yIBOF4Cgor
         /NgcwtQnClGK4qdHS6j2i9GRVbgpKjFpgD9mNdzGmm9cLwKdx34bA9H1zD3oRpqZby1z
         lfZfK+O9G3nOTpQGIydeKXwg5n3SUqmpO5TWCvjyOpEZKTJd6pcHXiFWsSDGz27sVYLU
         HkOIg6xRlf5FPLLmt24gkJYCPK9RQZy4T2fvTFodZ33pIlyBqYRzu9fL4Fu6JcmNqo66
         IfbIZtccvMX/fL7sdCXno3cWXv5PIaJg9dViVd4J9jNk6HSW1SqBffjeBYXTyr4vFnrY
         OpDw==
X-Gm-Message-State: APjAAAVs41ZTxnp81FvEa+5YSWGXAp2odUTFMp+lglh+t4BoBu6vM+kq
        nKYkW/nmEZY9wYY3DUecj+ClxWuu68Y80ZhJFx8Jwg==
X-Google-Smtp-Source: APXvYqxaHGpWOO6IMoixMUGJWidaaytKG3CtxaIXbf0pvWRlhfbGy9Ejui1hoLjUhW3PTmVXRy5nJzPo7rfiuN9VxxE=
X-Received: by 2002:a6b:7312:: with SMTP id e18mr10913137ioh.156.1561031526622;
 Thu, 20 Jun 2019 04:52:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190619095254.19559-1-ard.biesheuvel@linaro.org>
 <20190619101604.GR2640@lahna.fi.intel.com> <54ede1d8-0e6b-e7d9-5e61-a7d057abbd2b@linux.intel.com>
 <CAKv+Gu_Bw3aV-pUVYf8T1hLfL35X7ozEPtqL9oLcDvwcQ4qMiw@mail.gmail.com>
 <c96afe71-c7bd-d30f-ef37-0c6eeb726f67@linux.intel.com> <CAKv+Gu9fafXNrAYAgUuqMPVjZm2bWJmzg_aPz9WD1skemQme8A@mail.gmail.com>
 <08e498d6-1ff8-771f-7d4f-6ea5f705d386@linux.intel.com> <20190619144255.GG2640@lahna.fi.intel.com>
 <CAKv+Gu82UcBcj_cjfEDpEyQyGzPvtGnVJN22hCroHKyudhk=8w@mail.gmail.com>
 <20190620104128.GW2640@lahna.fi.intel.com> <20190620111905.GA5316@sirena.org.uk>
In-Reply-To: <20190620111905.GA5316@sirena.org.uk>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 20 Jun 2019 13:51:54 +0200
Message-ID: <CAKv+Gu_dc4N07cD37AKdh1POJBzKGxfeEd0UHd4=YkbBt-meLw@mail.gmail.com>
Subject: Re: [PATCH] spi/acpi: fix incorrect ACPI parent check
To:     Mark Brown <broonie@kernel.org>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        linux-spi@vger.kernel.org, kbuild test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 20 Jun 2019 at 13:19, Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Jun 20, 2019 at 01:41:28PM +0300, Mika Westerberg wrote:
> > On Thu, Jun 20, 2019 at 12:33:41PM +0200, Ard Biesheuvel wrote:
>
> > IMHO it's better to do:
>
> >       memset(&lookup, 0, sizeof(lookup));
> >       lookup.ctlr = ctlr;
> >       lookup.irq = -1;
>
> > this also initializes chip_select and possibly other fields that get
> > added to the lookup structure later.
>
> I agree.

Sure, I will spin it like that once Jarkko confirms that this fixes his problem.
