Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20D4A49F45
	for <lists+linux-spi@lfdr.de>; Tue, 18 Jun 2019 13:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729695AbfFRLea (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 Jun 2019 07:34:30 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50705 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729621AbfFRLea (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 18 Jun 2019 07:34:30 -0400
Received: by mail-wm1-f68.google.com with SMTP id c66so2866027wmf.0
        for <linux-spi@vger.kernel.org>; Tue, 18 Jun 2019 04:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=GXSsckTMqxje7wmnOmj8eR9o0K5epX6miDSEzrBDFq4=;
        b=u1r760zPa/orghgy/1lKLcY0HOyAVNwKz7ZGvJtEm+nZl38cDdKYEaBTJm8QoHOBAN
         9QqwCupkkKJrhSOS7moQBzm3EapRM07JjqvxsFLuHDzg7gS3PMPU26FXulWU5lDuyNuJ
         OaDX+2g1HDIN1FlyiCz7rd3VmzZXMakK2NcZwdexVwPvtiE/97FxqV2eq/9Qdb+hPYMG
         4Y4q1pCTR8vlwgzpfuBz6iFpzhobOQlRygR/NUpm6U6R9BzK7zr7XRILXjYBiAjK0tp7
         P2oPrluRHYdg0H4NcogC1V9SelHSUMXEE1y8pMkQdLDUpjLPIM8Z84fNssBd9XG7vEir
         wZSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=GXSsckTMqxje7wmnOmj8eR9o0K5epX6miDSEzrBDFq4=;
        b=UtI1GotkGOqEqA+rh0CPgORV59JFwYkEDZNOh0wctpb/Otk9yFwUL6oAV9PTBZnMSz
         Xaz5PA6hAdaomOvMlqEeQsRvY/80DAZs4BAyIfcO1ILdDevW9VSEcLV69TWqLcbgWUy0
         Jb5ZZF2oSOXwQC9x7O/wsoRv52wosoGwvcvQ0CZwLLzKsloIIhgLcxIPYLrZ7SBUhwfp
         +Ti/aCBqyZ3qzGUPcgk3XxY++QFsfgEJLecW8V7THSgP50yiuPIMB4RHh8xWSE8BAvh6
         fMZHsmh+9bP6tdxirSf1upsE/hsp3AvJUSRpCsUtc0CjUnQ6EFVjMS1xXqW1MOgYDBIH
         HAHA==
X-Gm-Message-State: APjAAAW4DvuUom2YMKdYo0aYuB1MA/JITOHybf8rWh35OnvDrNVBGROr
        ddiig7u63lUyBlKm41t4/pn6Pw==
X-Google-Smtp-Source: APXvYqxihQrpdmh4ryVLmwf4vT8JM1RjRHndJmSPE7pLg7PvRtpOD8iPdbgdmTU897eaaYKaJ5pDvg==
X-Received: by 2002:a1c:ac81:: with SMTP id v123mr3291332wme.145.1560857668594;
        Tue, 18 Jun 2019 04:34:28 -0700 (PDT)
Received: from dell ([2.27.35.243])
        by smtp.gmail.com with ESMTPSA id t6sm2577260wmb.29.2019.06.18.04.34.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Jun 2019 04:34:28 -0700 (PDT)
Date:   Tue, 18 Jun 2019 12:34:26 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Mason Yang <masonccyang@mxic.com.tw>,
        linux-spi <linux-spi@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>
Subject: Re: [PATCH RFC 2/2] mfd: add Renesas RPC-IF driver
Message-ID: <20190618113426.GD18371@dell>
References: <ad503d6e-4739-9744-64b4-fd13f44ea6fe@cogentembedded.com>
 <1538cadb-7c6a-2c4c-fe8c-960b25286950@cogentembedded.com>
 <20190612090552.GD4797@dell>
 <41d74ecf-c939-27e1-4ef2-ad052b4e924b@cogentembedded.com>
 <20190617093048.GD16364@dell>
 <CAMuHMdX6GC2ZDam=odC-QFLUdrh1PYPVWEo5x3EHduqJ4FmTng@mail.gmail.com>
 <20190618091955.GN16364@dell>
 <CAMuHMdX7fFSO25TPJA9PO=VQC0czKux8nritMeffBcnaxr=WMQ@mail.gmail.com>
 <20190618095741.GA18371@dell>
 <CAMuHMdX829_CFGt53fS4nd9=qdS479OvJXYY3++DZ=4fLmp62w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdX829_CFGt53fS4nd9=qdS479OvJXYY3++DZ=4fLmp62w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 18 Jun 2019, Geert Uytterhoeven wrote:

> Hi Lee,
> 
> On Tue, Jun 18, 2019 at 11:57 AM Lee Jones <lee.jones@linaro.org> wrote:
> > On Tue, 18 Jun 2019, Geert Uytterhoeven wrote:
> > > On Tue, Jun 18, 2019 at 11:20 AM Lee Jones <lee.jones@linaro.org> wrote:
> > > > So is an RPC-IF a real hardware device.  Can you share the datasheet?
> > >
> > > Unfortunately the datasheet for the R-Car Gen3 and RZ/G2 SoCs is
> > > not yet public.
> >
> > When will it be public?
> 
> Dunno. RZ/G1 documentation became public a few months after the SoC
> release.
> 
> > Do you have access to it?
> 
> Yes I do.

Great.  Maybe you can help Sergei with his 'undocumented bits' issue.

> > > However, a very similar hardware block is present in the RZ/A2M SoC.
> > > Please see Chapter 20 ("SPI Multi I/O Bus Controller") of the "RZ/A2M Group
> > > User’s Manual: Hardware", which you can download from
> > > https://www.renesas.com/eu/en/products/microcontrollers-microprocessors/rz/rza/rza2m.html#documents
> >
> >   "The SPI multi I/O bus controller enables the direct connection of
> >    serial flash, OctaFlashTM, XccelaTM flash, or HyperFlashTM memory
> >    devices to this LSI chip.
> >
> >    This module allows the connected serial flash, OctaFlashTM, XccelaTM
> >    flash, or HyperFlashTM memory devices to be accessed by reading the
> >    external address space, or using Manual mode to transmit and receive
> >    data."
> >
> > Looks like a flash device to me.
> 
> The external address space is a small window.
> 
> > Can the SPI portion be used to connect generic SPI devices?
> 
> I'll defer that to the people who worked on the driver...

...

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
