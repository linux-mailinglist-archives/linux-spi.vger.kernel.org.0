Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C00524E857
	for <lists+linux-spi@lfdr.de>; Sat, 22 Aug 2020 17:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbgHVPSq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Sat, 22 Aug 2020 11:18:46 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39827 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727807AbgHVPSp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 22 Aug 2020 11:18:45 -0400
Received: by mail-wr1-f66.google.com with SMTP id a5so4567744wrm.6;
        Sat, 22 Aug 2020 08:18:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=fPurPcq4qIlsFmVZToY8qZyZV/HXm+35zPSjztTMBbk=;
        b=RnHBy8FoT6Z6vtdD4wKfJaNHSVPsg4CvGvsOy/FAascPpMTGFY438NYgVrT+clquCY
         5zKgykQGAXd3WLMcDv7b1Zp8KxvuF3PjAvgEnjF/q+WQLatvdJvPDmlFimLpQRDBz4Pg
         03zomDg/gzdAFQtdFz8nkRQpaRYUIBXwipjXjQeTgy3lx5s9mpyCjTi4dpiFlF/H3+Q2
         ZB7FeFnsFVkMG0f1UZJy4lJjjKDVSVq6qc8juoyfiz0P/wCzZ9pIyR2EocrmEvYFSGEY
         RVjZWdmW1uyh98Vj4C4cHGrgSjbx+ZYsSiFb4rfZNdrGYSzLkSSGBd5HBb8wYHhBAVES
         uqPw==
X-Gm-Message-State: AOAM532T1qkDrwy7WF7qxKlxDF5r5xu4gTNrpPgTxb522aW1o15+gHFT
        6ZbymATerxUhDdTuSkEHjcg=
X-Google-Smtp-Source: ABdhPJxopqANZ1WSRtMZknMlZMkWKProljOBBBQjtUznRcRFTqGL5IEt7HEGpC7njulqLAHazh5Wgg==
X-Received: by 2002:adf:fac8:: with SMTP id a8mr7477185wrs.368.1598109523037;
        Sat, 22 Aug 2020 08:18:43 -0700 (PDT)
Received: from kozik-lap ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id m16sm10738841wrr.71.2020.08.22.08.18.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Aug 2020 08:18:42 -0700 (PDT)
Date:   Sat, 22 Aug 2020 17:18:19 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     =?utf-8?Q?=C5=81ukasz?= Stelmach <l.stelmach@samsung.com>,
        Kukjin Kim <kgene@kernel.org>, Andi Shyti <andi@etezian.org>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v2 7/9] spi: spi-s3c64xx: Ensure cur_speed holds actual
 clock value
Message-ID: <20200822151819.GA13668@kozik-lap>
References: <20200821161401.11307-1-l.stelmach@samsung.com>
 <CGME20200821161407eucas1p249e4833b8839f717cc2a496ab43bb8a2@eucas1p2.samsung.com>
 <20200821161401.11307-8-l.stelmach@samsung.com>
 <20200822124325.GF20423@kozik-lap>
 <CAAFQd5CmPXDsOWmPBS+z5McxGvn+L2nkV2Wh934Bq7xY6DMO4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <CAAFQd5CmPXDsOWmPBS+z5McxGvn+L2nkV2Wh934Bq7xY6DMO4A@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, Aug 22, 2020 at 04:52:40PM +0200, Tomasz Figa wrote:
> On Sat, Aug 22, 2020 at 2:43 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >
> > On Fri, Aug 21, 2020 at 06:13:59PM +0200, Łukasz Stelmach wrote:
> > > cur_speed is used to calculate transfer timeout and needs to be
> > > set to the actual value of (half) the clock speed for precise
> > > calculations.
> >
> > If you need this only for timeout calculation just divide it in
> > s3c64xx_wait_for_dma().
> 
> Division is not the point of the patch. The point is that
> clk_set_rate() that was originally there doesn't guarantee that the
> rate is set exactly.

Unfortunately onlt that point of timeout is mentioned in commit msg. If
the correction of timeout was not the point of the patch, then describe
the real point...

> The rate directly determines the SPI transfer
> speed and thus the driver needs to use the rate that was actually set
> for further calculations.

Yep, makes sense.

> 
> > Otherwise why only if (cmu) case is updated?
> 
> Right, the !cmu case actually suffers from the same problem. The code
> divides the parent clock rate with the requested speed to obtain the
> divider to program into the register. This is subject to integer
> rounding, so (parent / (parent / speed)) doesn't always equal (speed).

It is not only this problem. The meaning of cur_speed is now changed.
For !cmu_case this the requested in trasnfer SPI bus clock frequency,
for cmu_case this is now real src_clk frequency. It's getting slightly
messier.

> 
> >
> > You are also affecting here not only timeout but
> > s3c64xx_enable_datapath() which is not mentioned in commit log. In other
> > words, this looks wrong.
> 
> Actually this is right and fixes one more problem, which I didn't spot
> when looking at this code when I suggested the change (I only spotted
> the effects on timeout calculation). The rounding error might have
> caused wrong configuration there, because e.g. 30000000 Hz could be
> requested and rounded to 28000000 Hz. The former is a threshold for
> setting the S3C64XX_SPI_CH_HS_EN bit, but the real frequency wouldn't
> actually require setting it.

Wrong is here describing one thing and doing much more.

Best regards,
Krzysztof

