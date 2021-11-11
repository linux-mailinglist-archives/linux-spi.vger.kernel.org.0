Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 289FF44D810
	for <lists+linux-spi@lfdr.de>; Thu, 11 Nov 2021 15:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233854AbhKKOT2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 11 Nov 2021 09:19:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233851AbhKKOT2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 11 Nov 2021 09:19:28 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364F7C061766;
        Thu, 11 Nov 2021 06:16:39 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id f18so14539178lfv.6;
        Thu, 11 Nov 2021 06:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vvvg5goyxnNtBDDyL+5XBTEueO5Upm10tDntI2rRZdc=;
        b=qOMXdKbQJVPhsFQ5qipUZll2T6Qv7Y6RQTnQ+m+ZtJY1UQkHADy0QlvZiEncrMmJYk
         qZIIn6aIoBFKRRgur/ZtPALZaf2fE93yJVElc31QhtQkKx7ktzRA9HN2cO1mGGMalsG0
         BmhJMofSdWpgEHZpghjM5/LGNVA+5eZ19bfGUXRX3sZ7nVKx7vBkPyYfz+uZdgjf88Wu
         06rpt9es97TZ9+IowvFHCZPSgMwt9YssdKMfMAKI2PvTZsHG10oV3G3MlHVzIJFmrSQC
         kq7gI7jwftRR9BW7AG1IMj0bgnmkIJBeG+CcVMIPMaagaZMHtQjKzrraRqRCOiyP5jvI
         h8Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vvvg5goyxnNtBDDyL+5XBTEueO5Upm10tDntI2rRZdc=;
        b=TaSUewuj27dyVSeU2LCPIaQ0vN+jNpn+/2jLBFss8sZikHTX2e8kM4MP6Gz/kpmUHo
         49tY1RicsbpM4+lIyD2YPZfX1Ix/ElF/afWh8LWoE/rh0vEyQ+/dPgiPPaZg7EGRDs2N
         Cet4kfZFIOtCLxbSnocKHtYAOeEXDRg3risFmgBup56jeyZKQfscznafLoEDPe442l/b
         xcEgHS62BM/1SvaXL3WcrdHNzqloqv3neyiUcydYY6EcmjJmKOTpNvBd1JVFrsZEc+Jg
         3eGSt7cXoOy3jPlNZqOxO6ThlqLmxbdBAeEi6rpSJjsYEhsTkC9oizPBFqu9HtM+8Q9f
         2d4g==
X-Gm-Message-State: AOAM531GK9yLA128lTEsua1g+dlODCRqE4RETTyOsvTU3KhoD9vjvyym
        E8jaK4BmwV35xvvxYkNBjxE=
X-Google-Smtp-Source: ABdhPJwOxa8XwL6nFJlBHrZ0DFadmhJopWDpAOoYS1UDp12vKAegHyBhDOlZ6kY5fYVGWdy9KWEsKg==
X-Received: by 2002:a05:6512:2314:: with SMTP id o20mr6770526lfu.51.1636640196918;
        Thu, 11 Nov 2021 06:16:36 -0800 (PST)
Received: from mobilestation ([95.79.188.236])
        by smtp.gmail.com with ESMTPSA id y15sm283960ljy.10.2021.11.11.06.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 06:16:36 -0800 (PST)
Date:   Thu, 11 Nov 2021 17:16:34 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        nandhini.srikandan@intel.com, robh+dt@kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mgross@linux.intel.com,
        kris.pan@intel.com, kenchappa.demakkanavar@intel.com,
        furong.zhou@intel.com, mallikarjunappa.sangannavar@intel.com,
        mahesh.r.vaidya@intel.com, rashmi.a@intel.com
Subject: Re: [PATCH v3 2/5] spi: dw: Add SSTE support for DWC SSI controller
Message-ID: <20211111141634.je2lppv5yjhsannb@mobilestation>
References: <20211111065201.10249-1-nandhini.srikandan@intel.com>
 <20211111065201.10249-3-nandhini.srikandan@intel.com>
 <YY0hFOr0SnDDDuSf@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YY0hFOr0SnDDDuSf@sirena.org.uk>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Nov 11, 2021 at 01:56:36PM +0000, Mark Brown wrote:
> On Thu, Nov 11, 2021 at 02:51:58PM +0800, nandhini.srikandan@intel.com wrote:
> > From: Nandhini Srikandan <nandhini.srikandan@intel.com>
> > 
> > Add support for Slave Select Toggle Enable (SSTE) in DWC SSI controller
> > via DTS. The slave select line will toggle between consecutive data frames,
> > with the serial clock being held to its default value while slave
> > select line is high.
> 

> This should be controlled by SPI_CS_WORD.

Oh, yeah. I've absolutely forgotten about that flag. Indeed then there
is no need in implementing a separate DT-property. In this case the
patchset will need to be fixed a bit: remove the DT-part of the
sste-feature and alter the dw_spi_setup() method so to take the
SPI_CS_WORD flag into account.

Nandhini, sorry about a wrong advice on v2. It seems v4 will be
required...

-Sergey

