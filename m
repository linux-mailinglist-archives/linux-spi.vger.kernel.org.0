Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC50A45768
	for <lists+linux-spi@lfdr.de>; Fri, 14 Jun 2019 10:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbfFNIXs (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 14 Jun 2019 04:23:48 -0400
Received: from mail-pf1-f181.google.com ([209.85.210.181]:37493 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbfFNIXr (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 14 Jun 2019 04:23:47 -0400
Received: by mail-pf1-f181.google.com with SMTP id 19so987659pfa.4
        for <linux-spi@vger.kernel.org>; Fri, 14 Jun 2019 01:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IbROzr8FoRs1kLVb6zqUpOyz06MuvRZq9MAyDRUAEVQ=;
        b=vEKJzigg2ioobI/J/vq6CTq6DrquDGogNgeekS5h0XUZe/f7y5yiL4mEr6SHyJkwDj
         l340ictH7fMq9UlenUObreqd0BYEVHmjJejf8ewcR/1/amw/FiUHcyCUwR1MzrepDnk7
         fk233C2bitoz7B4E2oWYN7fpQ3mEhktp6XfHKQFNN/B/UEdzwEaL0EDC/NQh9cqMr06T
         hhEqfpbEoypLZWm23OYh+XhWMKkRM5bdG5+ua402Zs5gctNZpFaWJoRK2JXs/MHRXNul
         yB0cQYVQ+10GzxSYMQ+/KKpIjHzMxnYsa+MhBEYY60YVs8qH2FDNbjUAJWvMrADKSCq+
         Yhmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IbROzr8FoRs1kLVb6zqUpOyz06MuvRZq9MAyDRUAEVQ=;
        b=eNYi0OYqnsAGKQL+AVZg6lbNRz2WDTKVrtBM/xmg0a2cwL7OHhB7zjDiD+OJaGiXRB
         ab7rgGIQILkXp+l3la8xI5fa51E29muk+i0pL4ecrKyGrZFdtgsV7wiiCyLvz+fNmgAH
         RH5adF1GDMaP4XZgaFAWM9FpXTFOzelFwA5yqUPd5YPl181sySYc0aw2iqDXXNwEhq3b
         cU/sOPqG8d4xJLulk40xroWSGyTJqHHh/sWtU66hM72TukoopshBayPFd7VPM9mXi4mD
         ijh1T3tqpVaWD23YSJwzcST+NV3FXeEg3v3Mw8j1z8Z1cX09W/rd7hhKsDGGEyfB3t5c
         DFIg==
X-Gm-Message-State: APjAAAUGhUAsHESmr6uXU7AzWubgy+Lv+LLZuUT3U8cdFskH8UskBU1M
        +3GX6acDjObzYs658Z2spJgIyOA1TlNYEZqoAcI=
X-Google-Smtp-Source: APXvYqz1iiROZDSaHXqQIMegtkaArZX+A1PliWoUdxr8KiUcEa0kOyoK45fv/ybjocWGcOEWKPNwbJeVSg7mCB7YUl8=
X-Received: by 2002:a63:c0e:: with SMTP id b14mr15896922pgl.4.1560500626977;
 Fri, 14 Jun 2019 01:23:46 -0700 (PDT)
MIME-Version: 1.0
References: <5be80c08e0873ab200ed472b98ea8772666852ff.camel@suse.de>
 <a2f71bcab3756dc35385288ca3287af6849933a6.camel@suse.de> <0f0b3e3c-93c4-b76c-854c-6f498bc017d6@tronnes.org>
 <20190509022701.GS14916@sirena.org.uk>
In-Reply-To: <20190509022701.GS14916@sirena.org.uk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 14 Jun 2019 11:23:36 +0300
Message-ID: <CAHp75VcWB+UyAjXg5rjhw4-g9pJUHLtGwpr1XSSn1rOm+Rm=9g@mail.gmail.com>
Subject: Re: SPI regression with today's build
To:     Mark Brown <broonie@kernel.org>
Cc:     =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-spi <linux-spi@vger.kernel.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Martin Sperl <kernel@martin.sperl.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, May 9, 2019 at 5:27 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, May 08, 2019 at 07:33:32PM +0200, Noralf Tr=C3=B8nnes wrote:
>
> > Unless Martin Sperl, who wrote spi_split_transfers_maxsize(), has other
> > suggestions, I think we should just revert this patch.
>
> I'll just revert for now, we can always re-apply things later but
> that'll get the problem sorted in Linus' tree quickest.

I got the same issue on v5.2-rc4. Are you going to submit the fix to v5.2 c=
ycle?

P.S. The commit misses Fixes tag AFAICS.

--=20
With Best Regards,
Andy Shevchenko
