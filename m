Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6F80252CCA
	for <lists+linux-spi@lfdr.de>; Wed, 26 Aug 2020 13:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728870AbgHZLsL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 26 Aug 2020 07:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728786AbgHZLsD (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 26 Aug 2020 07:48:03 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70AC1C061574;
        Wed, 26 Aug 2020 04:48:02 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id si26so2379842ejb.12;
        Wed, 26 Aug 2020 04:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=c1XozxQRBMRgCKFKdNle/Ejgq+G0usremp3MX2cyWos=;
        b=ocRCgCm1md7sljlo+SIzz85uD6Xuib+W3pQzgHaGXjz9/C0I2MggKbwptLqFIiH/vw
         EjI7LIiJ9CArRO9o4Roys6YXJ8ib3E5uBplGpHCSCI69vA3DBuHJIC9LfaLGWKTm6BjV
         qIRex/PhQ1S35OkHEV2uuLNUoX7vxJWy7tBTECAYXQQK/nYWkjcljdMptHZOqTDMXV7A
         oO53byRis2jOE8OXXbZAHrEO+jiLW00Grzf+6uPIzlXfuWB6gcdWpXLOboktsY9Unp62
         tAQS2CnQMafG2gZ8FK0jUwtIuyZW0BQ0Y1YF+C4XhYY8+/xby0sFWl30AMbycGJJaJ17
         uPuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=c1XozxQRBMRgCKFKdNle/Ejgq+G0usremp3MX2cyWos=;
        b=fR9oiNGWkTE47mJZ9gzzF7ZCQmBCxjxMYiPiVqKPeVCtBaIiRIs6GgCFXiJFBplDsT
         1pwVJL6k7sO1mj8HzfIKmIqFEoVAEYRcveg4zdObd9ZKOYFZmedqOn4wou05dd5kLA6e
         w2RFXQ7EUzqi6BJEnpUS7NGiAXU9UmhUrF/+Gl3B5yZCAck1Ig7T6oviRuONJ1HEZZ+w
         RUXrqOOhivQgFNe1QkWhox7jqyKwCRcpEBgVeQOkGuC1ISyRixEKKsvk/U2w/YxwzsK7
         UhXhW/sYBKXOZ8rhIqlZlcZGm1yMmZvVZlsnH+bMhAjzYWggW8HZgIKH4c4QHdsbycJJ
         xLAA==
X-Gm-Message-State: AOAM530uPS3xOKsQUsQgLJGTnFLrPNl8qm96qKXeaJNIH431KOn7nJSE
        KO4Ed0OuBtfwag1Etj5ewC8=
X-Google-Smtp-Source: ABdhPJzhid1dnmRXgGd4Cm6Jwp4Nteh8EDCcXbUEZ7SwOXXIZm7aWyXRxE8lLcwuzMu9jhpQXen34A==
X-Received: by 2002:a17:906:f0c1:: with SMTP id dk1mr10704937ejb.44.1598442480970;
        Wed, 26 Aug 2020 04:48:00 -0700 (PDT)
Received: from skbuf ([86.126.22.216])
        by smtp.gmail.com with ESMTPSA id dj16sm1863342edb.5.2020.08.26.04.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 04:48:00 -0700 (PDT)
Date:   Wed, 26 Aug 2020 14:47:58 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Qiang Zhao <qiang.zhao@nxp.com>
Cc:     kuldip dwivedi <kuldip.dwivedi@puresoftware.com>,
        Mark Brown <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pankaj Bansal <pankaj.bansal@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        Tanveer Alam <tanveer.alam@puresoftware.com>
Subject: Re: [PATCH] spi: spi-fsl-dspi: Add ACPI support
Message-ID: <20200826114758.4agph53ag2fin6um@skbuf>
References: <20200821131029.11440-1-kuldip.dwivedi@puresoftware.com>
 <20200821140718.GH4870@sirena.org.uk>
 <c810740d75f64e308fd362e6c6a5f437@mail.gmail.com>
 <20200822152118.rlwbcgfk4abjldtg@skbuf>
 <VE1PR04MB6768699B6D7A507A5BF82F9191540@VE1PR04MB6768.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VE1PR04MB6768699B6D7A507A5BF82F9191540@VE1PR04MB6768.eurprd04.prod.outlook.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Aug 26, 2020 at 11:10:49AM +0000, Qiang Zhao wrote:
> On Sat, Aug 22, 2020 at 23:21PM, Vladimir Oltean <olteanv@gmail.com> wrote:
> > Yes, definitely bloatware from the old days. I think this driver needs the existing
> > device tree bindings rethought a little bit before mindlessly porting them to
> > ACPI.
>
> Could you give more details?
>
> Best Regards
> Qiang Zhao

Yes.
This driver has some device tree bindings.
Some thought need to be given as to which one of those is necessary for
a functional ACPI setup, and which one isn't.
For example:

- fsl,spi-cs-sck-delay and fsl,spi-sck-cs-delay are many times
  necessary. I don't see an attempt to read something equivalent to
  those in this patch, or to do something about those, otherwise, in
  case a peripheral needs special treatment. If we want to do something
  like e.g. deprecate these bindings and just set up a large enough
  CS-to-SCK and SCK-to-CS delay to make every peripheral happy, in order
  to not carry this binding over to ACPI, at least we should establish
  that and do it now, so that the DT code can benefit from that as well.

- The bus-num property was made optional by Sascha Hauer in commit
  29d2daf2c33c ("spi: spi-fsl-dspi: Make bus-num property optional").
  I think this is because he couldn't just remove it completely. But
  that doesn't mean we should carry it over to ACPI. The SPI core should
  know to allocate a bus_num dynamically (using IDR, or by looking at
  aliases) if we just set spi->bus_num = -1.

- The spi-num-chipselects can be deduced from compatible string and bus
  number, and therefore we can avoid carrying it over to ACPI. But
  again, DT should have this logic first, and then ACPI can be added.

- The compatible string plays an integral part in the functionality of
  the spi-fsl-dspi driver. I want to see a solution for ACPI where the
  driver knows on which SoC it's running on. Otherwise it doesn't know
  what are the silicon parameters of the DSPI module (XSPI present or
  not, DMA present or not, FIFO depth). I don't see that now. I just see
  something hardcoded for:
  { "NXP0005", .driver_data = (kernel_ulong_t)&devtype_data[LS2085A], }

Thanks,
-Vladimir
