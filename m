Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A897A15D7A8
	for <lists+linux-spi@lfdr.de>; Fri, 14 Feb 2020 13:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbgBNMu4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 14 Feb 2020 07:50:56 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:35579 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728062AbgBNMu4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 14 Feb 2020 07:50:56 -0500
Received: by mail-vs1-f65.google.com with SMTP id x123so6163029vsc.2;
        Fri, 14 Feb 2020 04:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YfI+Uxxh/VfHkmQ0LRtfuf8KZr2lKr4QwAFen6h03ik=;
        b=DVKyEU+GnBaKKqP71klCRTUVWyd8UlLuGATHM8PQf1cs6w+JuWbXkqq3aTPVBuN7fW
         PM6JL0p+ncls8I72Olm6eG609Hk7Yk+Dl/0ZWiCNPUkZA0ylNc6P4F5ar9laxNiy0D+O
         /Q07+EC49BWHoHuss762lz3tOoy11ivwY1I5yT/6550hXP+LNV59H845IFnRNmpGENGX
         ExRGw6LfKbcH5rCIc+GvIU0YExpW9BN4IAHaP6TIB0LyqRPEPxegNrdm2ME7f0gf7Ehv
         UIu/e1SsIDWJajDwWgkrQyMQaE5z8LUhKc23Ktn910SFaB7dmHHmvXp++wGLoE4GrJyB
         JkDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YfI+Uxxh/VfHkmQ0LRtfuf8KZr2lKr4QwAFen6h03ik=;
        b=JxWpn0ElzD+n3k+AuywgWCBTPXgM3Bl2UDxeW7FXWBhepQceF78e9LT0bxKW2fPvcG
         VTjG07TyFuB+VtbBjQoAL29GRuf2DwCqRr3L9TPu0mvcQZhY+iC10vQaqgckchMZbEyU
         yJKgmo2iRXHGN1pBB9U8aUpaf4uwPYIiFi9NAntvWD7foDwzag0E5k127d2Uwm1flQL2
         7WJK/Cr0+WeG3Gh5cr+IByJV6paiIMRx0/6z1t6Vlk0JU/oeVv3SoKSEbDdafqeudEJr
         I5nU5LQgO2amRn7i7qcbvobqGlQcZ1MCy9DFMRt3HBY/lvYVzaxKx2oRSfwGeAw2vQsR
         Kcqg==
X-Gm-Message-State: APjAAAUuzb3TUAiX2HNCUnaYBl4RWELAPPk2KbnVIFdf6NUFEekbQQFe
        AsAzwLA8W/XtkgBci3B4FWm8eYI1ly/V92ETNv0=
X-Google-Smtp-Source: APXvYqydl0OQh4w0yGWu+8OFaoA5y1yt42vbxh0IO7hLH1yYx3PU0cYmEM8KRoXTWRsVGBYd0VAGSMi89mjuQrpG/Tg=
X-Received: by 2002:a67:2f06:: with SMTP id v6mr1237125vsv.12.1581684655278;
 Fri, 14 Feb 2020 04:50:55 -0800 (PST)
MIME-Version: 1.0
References: <20200214114618.29704-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <CAAh8qsxnRSwonuEPrriuS=gUMTjt8ddUVy5HxegmoCk-FoE4qg@mail.gmail.com> <20200214121145.GF4827@sirena.org.uk>
In-Reply-To: <20200214121145.GF4827@sirena.org.uk>
From:   Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
Date:   Fri, 14 Feb 2020 13:50:44 +0100
Message-ID: <CAAh8qsxmYmpyAg-FQJLnEwvKKFZYg6VQenKf83_TJ4oF0GyMsA@mail.gmail.com>
Subject: Re: [PATCH v9 0/2] spi: cadence-quadpsi: Add support for the Cadence
 QSPI controller
To:     Mark Brown <broonie@kernel.org>
Cc:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-spi@vger.kernel.org, Vignesh R <vigneshr@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, dan.carpenter@oracle.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Feb 14, 2020 at 1:11 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Fri, Feb 14, 2020 at 01:02:22PM +0100, Simon Goldschmidt wrote:
> > On Fri, Feb 14, 2020 at 12:46 PM Ramuthevar,Vadivel MuruganX
> > <vadivel.muruganx.ramuthevar@linux.intel.com> wrote:
>
> > > Add support for the Cadence QSPI controller. This controller is
> > > present in the Intel Lightning Mountain(LGM) SoCs, Altera and TI SoCs.
> > > This driver has been tested on the Intel LGM SoCs.
>
> > This is v9 and still, none of the altera maintainers are on CC?
> > How will it be ensured that this doesn't break altera if it is merged?
>
> Given that this is a new driver I'd be very surprised if it broke other
> users?  I can imagine it might not work for them and it would definitely
> be much better to get their review but it shouldn't be any worse than
> the current lack of support.

It is a new driver, but the hardware it supports is not currently unsupported.
Both Vadivel and Vignesh have stated that this driver merely moves the existing
generic spi driver to the spi-mem interface and should replace the existing
driver.

So please correct me if I'm wrong, but to me it seems like if this driver won't
work on altera, and after merging it the currently working driver will be
removed, altera will be broken.

Regards,
Simon
