Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 889F14B207
	for <lists+linux-spi@lfdr.de>; Wed, 19 Jun 2019 08:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725881AbfFSGTD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 19 Jun 2019 02:19:03 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33127 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfFSGTD (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 19 Jun 2019 02:19:03 -0400
Received: by mail-wm1-f68.google.com with SMTP id h19so3830157wme.0
        for <linux-spi@vger.kernel.org>; Tue, 18 Jun 2019 23:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ARjohvqvMzEy8Wt5d1xLPSZTobeYlfPS/trXnHM/+Ws=;
        b=CgHLT/P7Ak82+EGpXCJTu9eFXFTuQM+XCyfV6vOBjmRJqs9J5KVKny2zP2AAMRZYzl
         zqWUX/ViEbpaHUoQFjJ1IrH2+2GoLEJ+fpoZ1yEGnZg43xn5BT9o27zDIkIeEEjwA95w
         X3Ism89homysvx8b/tyw3sh1cyeygDqxXoVZTTcgH5X6oAn2bxPLqNXoMS551ebvAv4B
         FjeOKDLCFtypO2wYpUHbBehlkj16zrw437c1zJyJISrnKY05TIcLbDP572TIhiWHbvcj
         GheuQuFaoO92gvbgSagz2C2qxXGwC7ms+u+5mO5qhpIjikz0mY5pVtYNi+n0f+sNsOyw
         0S/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ARjohvqvMzEy8Wt5d1xLPSZTobeYlfPS/trXnHM/+Ws=;
        b=EOaeIONVVWEMr9VM8VbsIIWdmh5McdRKx+QpUQofAALFJcPP3HK2WJq2lqb8liZg1P
         va1EJAKo8p80rtZBD+4gmRfCJTp90U/AbOeNgnwIxTDWJRNam3sQ4m5dVOUVhbN/Tm80
         Mfl7K4gwb9eBwdauB2JKc33mRvwT92JUkCcOw+0rQaB159CrNQuTbH3EAlbRFGPWRjS3
         xU6jiFf3boy1czKbVu2k55EIhBh9dwe/t1bOi8bxfbca4Ff6M7ZMXQjuNTSGrqgwdKkv
         78D4dJoFcIF2fSRG6ScCTZqsM7F3QavzhCF32gfPM0G8ewPC4MO9Dk8v/zBj6Rv6HypM
         p/Tw==
X-Gm-Message-State: APjAAAVsArPltfmZYG2uZDylKX3KqlnOICMz5zB/XwzZz3CpnNCUpx+U
        L9mCQj4tTZMDx6oINYWTfDgvIKtcoWk=
X-Google-Smtp-Source: APXvYqzNoF8ns09nJ5m2qlCAmuiq1GzDOwIBjJZI2ZQpr6VPjOGpwxFyI9TvoYQUbLhUiHPUxSqs8g==
X-Received: by 2002:a1c:b457:: with SMTP id d84mr7012356wmf.153.1560925140710;
        Tue, 18 Jun 2019 23:19:00 -0700 (PDT)
Received: from dell ([2.27.35.243])
        by smtp.gmail.com with ESMTPSA id x6sm19477794wru.0.2019.06.18.23.18.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Jun 2019 23:19:00 -0700 (PDT)
Date:   Wed, 19 Jun 2019 07:18:58 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Mason Yang <masonccyang@mxic.com.tw>,
        linux-spi <linux-spi@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>
Subject: Re: [PATCH RFC 2/2] mfd: add Renesas RPC-IF driver
Message-ID: <20190619061858.GI18371@dell>
References: <20190612090552.GD4797@dell>
 <41d74ecf-c939-27e1-4ef2-ad052b4e924b@cogentembedded.com>
 <20190617093048.GD16364@dell>
 <CAMuHMdX6GC2ZDam=odC-QFLUdrh1PYPVWEo5x3EHduqJ4FmTng@mail.gmail.com>
 <20190618091955.GN16364@dell>
 <CAMuHMdX7fFSO25TPJA9PO=VQC0czKux8nritMeffBcnaxr=WMQ@mail.gmail.com>
 <20190618095741.GA18371@dell>
 <CAMuHMdX829_CFGt53fS4nd9=qdS479OvJXYY3++DZ=4fLmp62w@mail.gmail.com>
 <20190618113426.GD18371@dell>
 <303086dc-5ec0-f46d-3e41-8f12878f5db0@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <303086dc-5ec0-f46d-3e41-8f12878f5db0@cogentembedded.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 18 Jun 2019, Sergei Shtylyov wrote:

> Hello!
> 
> On 06/18/2019 02:34 PM, Lee Jones wrote:
> 
> >>>>> So is an RPC-IF a real hardware device.  Can you share the datasheet?
> >>>>
> >>>> Unfortunately the datasheet for the R-Car Gen3 and RZ/G2 SoCs is
> >>>> not yet public.
> >>>
> >>> When will it be public?
> >>
> >> Dunno. RZ/G1 documentation became public a few months after the SoC
> >> release.
> >>
> >>> Do you have access to it?
> >>
> >> Yes I do.
> > 
> > Great.  Maybe you can help Sergei with his 'undocumented bits' issue.
> 
>    You're an optimist. :-)
>    I think I have the same gen3 manual v1.50 as Geert. It won't help as the
> bits that constitute the magic numbers in the driver are not described (not
> even the default values are listed for the most of them).

Then how did you get hold of them?

> >>>> However, a very similar hardware block is present in the RZ/A2M SoC.
> >>>> Please see Chapter 20 ("SPI Multi I/O Bus Controller") of the "RZ/A2M Group
> >>>> User’s Manual: Hardware", which you can download from
> >>>> https://www.renesas.com/eu/en/products/microcontrollers-microprocessors/rz/rza/rza2m.html#documents
> >>>
> >>>   "The SPI multi I/O bus controller enables the direct connection of
> >>>    serial flash, OctaFlashTM, XccelaTM flash, or HyperFlashTM memory
> >>>    devices to this LSI chip.
> >>>
> >>>    This module allows the connected serial flash, OctaFlashTM, XccelaTM
> >>>    flash, or HyperFlashTM memory devices to be accessed by reading the
> >>>    external address space, or using Manual mode to transmit and receive
> >>>    data."
> >>>
> >>> Looks like a flash device to me.
> >>
> >> The external address space is a small window.
> 
>    Yeah, it only provides 64 MiB window into the flash chip.
> 
> >>> Can the SPI portion be used to connect generic SPI devices?
> >>
> >> I'll defer that to the people who worked on the driver...
> 
>    Yes. Or at least it should, looking at the driver code...

Judging by that response, I'm guessing that this is unused/untested.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
