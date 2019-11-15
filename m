Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4698FE5E0
	for <lists+linux-spi@lfdr.de>; Fri, 15 Nov 2019 20:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfKOTnh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 15 Nov 2019 14:43:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:41942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726505AbfKOTnh (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 15 Nov 2019 14:43:37 -0500
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36B1B2073A;
        Fri, 15 Nov 2019 19:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573847016;
        bh=ld4rW2k11Lbg2rHEcey2VfnIi5Nl31fVQgLrDuiv6/4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TWSZA0dCh+qFFJatZQNp41RyPHBy+vjy2Pyq2efmOp9AB7P/1lAj8oTRAASabhbMJ
         8hQTnObbyuELO7dqN/qWn2SNHQyyxjwEC8EAKifdBM9iwKMSZvKVtrzi9ykSwWVuaG
         sbx29g/Hh0yEmTyS8OeGSP6b02b2bXSz0eVnNDqc=
Received: by mail-qv1-f45.google.com with SMTP id g12so4200834qvy.12;
        Fri, 15 Nov 2019 11:43:36 -0800 (PST)
X-Gm-Message-State: APjAAAXH3xn1MdwH7Nu+1Lk/egUjddzdBsaO9WuHxJd4wIaEAFs4mLA+
        1yE5kNYMsKQglJW/HWnGP6Yj9mSrpJVjS5iDkw==
X-Google-Smtp-Source: APXvYqzb9iMcXyAFITPQ01iU7106R3B8CRt3Yj3H790DDelfdGgmOQj80dVzPja+pL4WGrPQxTeaRIP7VepFEpUdfEo=
X-Received: by 2002:ad4:42b4:: with SMTP id e20mr1570396qvr.85.1573847015232;
 Fri, 15 Nov 2019 11:43:35 -0800 (PST)
MIME-Version: 1.0
References: <20191112055412.192675-1-dmitry.torokhov@gmail.com>
 <20191112055412.192675-2-dmitry.torokhov@gmail.com> <20191112120307.GB5195@sirena.co.uk>
 <20191112190328.GA199853@dtor-ws> <20191112191547.GK5195@sirena.co.uk>
 <20191112193653.GB13374@dtor-ws> <20191114222652.GA7517@bogus>
 <CAKdAkRQBrKOUTW8puakA26ODYW9=0H4VhwFhGQAqMs-cMmj3CQ@mail.gmail.com>
 <CAL_JsqKUXPTC-fmUowpaHQpuKTfgfQ6D2n7kOZgkYt+MS7OfaA@mail.gmail.com> <20191115152221.GA4210@sirena.co.uk>
In-Reply-To: <20191115152221.GA4210@sirena.co.uk>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 15 Nov 2019 13:43:23 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+9eejCg41poj--GDtUqOgSUoNMpB=OEAuKhNu1Ggb7Ew@mail.gmail.com>
Message-ID: <CAL_Jsq+9eejCg41poj--GDtUqOgSUoNMpB=OEAuKhNu1Ggb7Ew@mail.gmail.com>
Subject: Re: [PATCH 1/2] spi: dt-bindings: spi-controller: add wakeup-source
 and interrupts
To:     Mark Brown <broonie@kernel.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Nov 15, 2019 at 9:22 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Fri, Nov 15, 2019 at 07:52:22AM -0600, Rob Herring wrote:
>
> > if:
> >   properties:
> >     interrupt-names:
> >       contains:
> >         const: wakeup
> >   required:
> >     - interrupt-names
> > then:
> >   required:
> >     - wakeup-source
>
> That seems to say that if we have a device that has an interrupt called
> "wakeup" then it must be a wakeup source.  Is that desirable?  Being
> able to wake the system is partly a property of the system as a whole
> (the wakeup signal needs to be wired somewhere where it can wake things)
> and a device might have a signal that could be used to wake the system,
> may even be called "wakeup" by the device but for some reason isn't
> wired suitably in a given system.

Perhaps it is too strict. It would be useful as a "Did you forget
wakeup-source?" message, but we don't have a way to distinguish that.

Rob
