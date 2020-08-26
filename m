Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09047253729
	for <lists+linux-spi@lfdr.de>; Wed, 26 Aug 2020 20:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgHZSau (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 26 Aug 2020 14:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbgHZSat (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 26 Aug 2020 14:30:49 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58462C061574;
        Wed, 26 Aug 2020 11:30:49 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id l63so2597751edl.9;
        Wed, 26 Aug 2020 11:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gUzRrKeBm76GXoaIjO5FwcKwXY3xhRCmZGDO9IKNZ24=;
        b=vY5kFz9qaN/SdhYc9bkkwmAgLFcK1jk+Ll3pf4wP+mPs0DxVVIkuZWflbqhaT4kFM9
         P6ogFBmytpoG9x9oM/9PPbUtfllkGox7bpU6pXHZS8MYgoPN5zEVxl4ZdSo6GF9XrFPs
         BwWG/XOPuHLOshCFbnmhxj1U41lJvg2NFcVyGHBKAi2507PKGJvIVIqZj02Cp7BQEy8A
         plScB8qx56HImXr/+pWZU2d5Cs+FyQ6yCzjwWANya1tOr/WRAfxXu7jBn+0BwkoH7f1D
         2DAciOmsyNlXG/BIrzSGXy7IwVJHJKAIzbz4QJ6dO/U3ZFXhBBQdwW9I13MgQOKMC/kB
         6nIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gUzRrKeBm76GXoaIjO5FwcKwXY3xhRCmZGDO9IKNZ24=;
        b=Gn+n8EC4UExPp8ElcrMpqJhP/51daUj+QlA0zwnd7UAsloYNAiOOaMAg6U5wiJFoV+
         X+yqL/6BqCShZOumSBjwZQh7+qVxGJ5XzIrDtuT6zA8wpb1jXpmhi2LATuuf0Hv+Tqqt
         pOtPddw/2U2n6Li5+TDp7a+jR85sThmRTzZZj3HuKmEUXhgaBJF/SlCqvkKRXewpmY/+
         ddbEzoftOczB6sbjIXUbC291IA/dlJOrN1ZKCM69qc2/z/JwZYON8VnH00iRPwC6OyLQ
         KGhsBzqJ9BiHwcl59WYbzGSeWZ9IqBhWzhE/oEQNhuYxs5tFxC96KhDed+WKYEITu6yQ
         RjIw==
X-Gm-Message-State: AOAM530g6t/Odm2/fsT8Jv48j6gqrLipJzEQESs4L1Gm41dZ1ApFlvLE
        LlnOQjk5tj/hWBKaTkS8VLna1vH84tc=
X-Google-Smtp-Source: ABdhPJwr9xy0CA8pse0SVzU64Qo4kG1Ogl74mI54Xs+VnFJmrPLgL2VYTsYbjyZEq7CE965Tr3NICQ==
X-Received: by 2002:a05:6402:1d2a:: with SMTP id dh10mr965264edb.278.1598466647576;
        Wed, 26 Aug 2020 11:30:47 -0700 (PDT)
Received: from skbuf ([86.126.22.216])
        by smtp.gmail.com with ESMTPSA id jx14sm2925692ejb.20.2020.08.26.11.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 11:30:46 -0700 (PDT)
Date:   Wed, 26 Aug 2020 21:30:44 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Kuldip Dwivedi <kuldip.dwivedi@puresoftware.com>,
        Qiang Zhao <qiang.zhao@nxp.com>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pankaj Bansal <pankaj.bansal@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        Tanveer Alam <tanveer.alam@puresoftware.com>
Subject: Re: [PATCH] spi: spi-fsl-dspi: Add ACPI support
Message-ID: <20200826183044.4g6jvfrgkhpxki3k@skbuf>
References: <20200821140718.GH4870@sirena.org.uk>
 <c810740d75f64e308fd362e6c6a5f437@mail.gmail.com>
 <20200822152118.rlwbcgfk4abjldtg@skbuf>
 <VE1PR04MB6768699B6D7A507A5BF82F9191540@VE1PR04MB6768.eurprd04.prod.outlook.com>
 <20200826114758.4agph53ag2fin6um@skbuf>
 <20200826142312.GH4965@sirena.org.uk>
 <20200826144744.c4yzgoovk6f4t3id@skbuf>
 <2e19f8979be4f962045a1597bdbe7886@mail.gmail.com>
 <20200826160950.i3k2oy6w2dlvmj34@skbuf>
 <20200826170205.GL4965@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200826170205.GL4965@sirena.org.uk>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Aug 26, 2020 at 06:02:05PM +0100, Mark Brown wrote:
> On Wed, Aug 26, 2020 at 07:09:50PM +0300, Vladimir Oltean wrote:
> 
> > I don't even know if NXP0005 is made up or if it's written down
> > somewhere in the PNP ID registry. NXP0006 seems to be assigned to the
> 
> Well, any ID is made up to some extent.  I am concerned about the
> allocation of IDs too, it needs to be coordinated with NXP since it's
> being allocated from their namespace, but unfortunately in general
> there's no sensible way to go from a chip/feature name to an ACPI name
> due to ACPI's specification mechanism.  There's also not any kind of
> central list of IDs.
> 
> > In the ACPI spec there's also a _HRV (Hardware Revision) object, which
> > comes as a simple DWORD. We could use acpi_evaluate_integer() to read
> > that, and use it as index into the array of fsl_dspi_devtype_data, if
> > we declare that as ABI within the driver (and new SoCs would be added
> > only at the end of the enum). Then we could use the NXP0005 _HID for
> > everything DSPI.
> 
> That's not something that it's particularly idiomatic to actually use in
> ACPI and you end up with the same namespacing problem assigning IDs so
> I'm not sure it makes life any better.

So what's the idiomatic thing to do in this case, allocate the first
free PNP ID now for DSPI controller on LS2085A, then another one for
DSPI on LX2160A later, etc etc?

Thanks,
-Vladimir
