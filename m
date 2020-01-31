Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6D714F000
	for <lists+linux-spi@lfdr.de>; Fri, 31 Jan 2020 16:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbgAaPqs (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 31 Jan 2020 10:46:48 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:38589 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728846AbgAaPqs (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 31 Jan 2020 10:46:48 -0500
Received: by mail-pj1-f65.google.com with SMTP id j17so3011131pjz.3;
        Fri, 31 Jan 2020 07:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=20E0tLR1e2lz9G6IdX950Sr/F1JbRNRc72pTD1KbpUo=;
        b=ktH5RzxX5QP2mEJgmf+3+EmCIxCLbS47vn+m0ivWcrbF7Ug2/wJxNnnKlLYS4zpfC/
         wOST6FQY5IeaEdBxsx2xvoENwSFgicaHwhlrGp04lemZNVdnEL+TQn9e1H9n6Q2tJPtI
         7TeWU9SztQqXVU87G/b40uUOXotnao2uadaFIvUeaj/TfVwhDSPoGGLW3AixLo7JdVNn
         EfnjKxjQxbdSK9XZYbVWYgScGs8OleW841MzlEdYzol0kZkF8jjuGDOE93u/q4dPCbIu
         AOvHcOL3RZAXi0Q9bNWAEUszaEHh4Hfkbs9XUWdGwiTLQyN/YHG1m5T/RLidmZGjeN+o
         weog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=20E0tLR1e2lz9G6IdX950Sr/F1JbRNRc72pTD1KbpUo=;
        b=Qax6COLwHu9Q1soRQ7IWrlJ5JyaRAcp+LjJAGhqBRSoZa5S+DxRXPkCvI/iggDvYl6
         8JlUzdXjCLRiBYpvs5PQrwUKzh+JaIX6A2QipXG2Zhe0ows14DMwK5PhSY6mGMU3GeDq
         7b2gWuvlj+0tcPK3sj6yPer3oqv289AFRRhysrAKYrvDfIliIPIu6GGamW82IKVtHQfT
         QugmBBS8JUdbYmZb2ZYKlJPKt4qErnhU/H/O6ykAe5iQEAdPtBL2PhTyhvikcYmxqXLZ
         vdnCsZ0pYxkbiToo+tTSBud0WhDW2EhXby2laDiGnvrOlQstFbroH6tMT4/i6LUO3moi
         4C6g==
X-Gm-Message-State: APjAAAXrp9qk1CbiQ5Xg2SzgbIGlHkUScLX9lwEInoVA2exTlTROWvoA
        RShoRLO+bST2Tcg9x7tBOoQExpCO2aRV/ghuR5Q=
X-Google-Smtp-Source: APXvYqzqatk1VScaz2nJKJO1gCXqZihSdef8LqWJv55wUY4BND/+R9BV7L3dBUfBB5VN+XOCF9JwnodMXvjtodssym0=
X-Received: by 2002:a17:902:d20c:: with SMTP id t12mr11072217ply.18.1580485607842;
 Fri, 31 Jan 2020 07:46:47 -0800 (PST)
MIME-Version: 1.0
References: <df67b562-7d82-19f6-7581-680190a7772d@huawei.com>
 <20200110140726.GB5889@sirena.org.uk> <6db83881-927c-d11c-9c77-23a45892ddab@huawei.com>
 <20200110193119.GI32742@smile.fi.intel.com> <612a3c5d-69a4-af6b-5c79-c3fb853193ab@huawei.com>
 <20200113114256.GH3897@sirena.org.uk> <6dd45da9-9ccf-45f7-ed12-8f1406a0a56b@huawei.com>
 <20200113140627.GJ3897@sirena.org.uk> <CAHp75VfepiiVFLLmCwdBS0Z6tmR+XKBaOLg1qPPuz1McLjS=4Q@mail.gmail.com>
 <20200113142754.GL3897@sirena.org.uk> <20200113143403.GQ32742@smile.fi.intel.com>
 <0252a76d-7e2b-2c70-8b1b-0d041d972098@huawei.com> <CAHp75Ve=ZwJe2XV8Y1UN6sMe1ZHOBwUtRUD=aGqhR4Gc7BNUcg@mail.gmail.com>
 <136bd652-dcb9-3efa-a92f-2263cbf840ad@huawei.com>
In-Reply-To: <136bd652-dcb9-3efa-a92f-2263cbf840ad@huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 31 Jan 2020 17:46:39 +0200
Message-ID: <CAHp75Vd=TY0tPfSHMSLTh1Pgg-E7MCP5Gym1yjpLgH0Tx-2xSg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] spi: Add HiSilicon v3xx SPI NOR flash controller driver
To:     John Garry <john.garry@huawei.com>
Cc:     Mark Brown <broonie@kernel.org>, chenxiang66@hisilicon.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        liusimin4@huawei.com, Linuxarm <linuxarm@huawei.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        "open list:MEMORY TECHNOLOGY..." <linux-mtd@lists.infradead.org>,
        tudor.ambarus@microchip.com,
        Jiancheng Xue <xuejiancheng@hisilicon.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        wanghuiqiang <wanghuiqiang@huawei.com>, fengsheng5@huawei.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Jan 31, 2020 at 2:03 PM John Garry <john.garry@huawei.com> wrote:
> On 31/01/2020 11:39, Andy Shevchenko wrote:
> > On Fri, Jan 31, 2020 at 12:08 PM John Garry <john.garry@huawei.com> wrote:
> >> On 13/01/2020 14:34, Andy Shevchenko wrote:

...

> >> About this topic of ACPI having no method to describe device buswidth in
> >> the resource descriptor, it may be an idea for me to raise a Tianocore
> >> feature request @ https://bugzilla.tianocore.org/
> >>
> >
> > The 19.6.126 describes the SPI resource, in particular:
> >
> > ---8<---8<---
> > DataBitLength is the size, in bits, of the smallest transfer unit for
> > this connection. _LEN is automatically
> > created to refer to this portion of the resource descriptor.
> > ---8<---8<---
> >
> > Is it what you are looking for? (As far as I know most of the
> > firmwares simple abuse this field among others)
>
> I didn't think so - I thought that there was a distinction between width
> and length in SPI terms.

My interpretation of this field is a data width of the slave.
Basically what we have as transfer->size inside SPI in the Linux
kernel.

> So how do you find that most firmwares abuse this field? AFAICS, linux
> kernel doesn't interpret this field at all.

From all tables I have this is the result of appearance (some of the
tables are like 10x times present in my data base, but nevertheless)

    140 SpiSerialBusV2(0x0000,PolarityHigh,FourWireMode,0x08,
   411 SpiSerialBusV2(0x0000,PolarityLow,FourWireMode,0x08,
     1 SpiSerialBusV2(0x0000,PolarityLow,FourWireMode,0x08,
    36 SpiSerialBusV2(0x0000,PolarityLow,FourWireMode,0x10,
    35 SpiSerialBusV2(0x0000,PolarityLow,FourWireMode,0x18,
    35 SpiSerialBusV2(0x0000,PolarityLow,FourWireMode,0x20,
     1 SpiSerialBusV2(0x0000,PolarityLow,ThreeWireMode,0x10,
     8 SpiSerialBusV2(0x0001,PolarityLow,FourWireMode,0x08,
     1 SpiSerialBusV2(0x0001,PolarityLow,FourWireMode,0x10,

So, it seems I stand corrected, the field is in right use, although
cases like 0x10 and 0x20 should be carefully checked.

We may teach kernel to get something meaningful out of it.

-- 
With Best Regards,
Andy Shevchenko
