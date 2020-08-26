Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B646425346B
	for <lists+linux-spi@lfdr.de>; Wed, 26 Aug 2020 18:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgHZQJ6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 26 Aug 2020 12:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbgHZQJz (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 26 Aug 2020 12:09:55 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17F4C061574;
        Wed, 26 Aug 2020 09:09:54 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id l23so2204614edv.11;
        Wed, 26 Aug 2020 09:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=M2MxZIUXPUpmUf6QxK3hAeLX83FtG2l1uckG74gDySM=;
        b=LVgL1WzYWIpvD7I2Liu6jZDHK9m8clGdyi/splNF9igVB7uUtJEJBZ15e5GRgDMtOE
         6Th8gEWPmn5l2m4S0n6t0rrMUCY6Q8gwUBg63Ph2YY+QRif9WKC+cQUMdh/vIBSEydHQ
         zIdX575OJZSeUjw6M9E7H+d2IjSGnpDqgFjPcdrOfG85QRK9a+PrvuEyjIuUwPfqQMSG
         UnC9orzRbyMDpa0zbHFH4nvwRbhylY9p+X3aVqAHguWIexwBSeQQUrcqYYzw5g4ElSda
         aVjf78FGAMVwLNKxarR9AbkcnkZ8vF4JLNOOUWK2kjhryzLMz8ptGttY9sY/k545V1Yu
         7jPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M2MxZIUXPUpmUf6QxK3hAeLX83FtG2l1uckG74gDySM=;
        b=WocmhEeAn3HodgNQSOLIlFGHgjOXah4qt1snSFWuihKLMp4B9uEHRVUwrTKPHqJOHc
         mxOUdNQJKcI/FiLA+mU0ZFrvGGrBYx5qz/5A+may+9Y05nn+egORG7j3CRnX5U4febEY
         khwBK64YT5t5N2z45k62Ff5DSGZVq6dcZBlK3VuoZrn1PLn+P9MV8R3tTexNVAEITd7z
         KhJmgoQ0Y2rWPXsx8+khCFB+dM1lvb9stK6tvbL2Kd9B3cJ6Pc2G8uPGFsqDUNfxylTB
         eCOeB4Ub8iLppJd3Vo4ghDXfrIwvqKT6zYDbzDd2fiqaYr9IeOuFM6ZhS0+N6WTqLcTn
         3rDA==
X-Gm-Message-State: AOAM530eZw7uxCz5oEVii0E5H/z4PGp3T1vzkkYSpTxNNKV3gTxPEgOc
        1Akp0YiJpwzLaB53VkP+vvA=
X-Google-Smtp-Source: ABdhPJyr2pY6Ky2yatr/El2379cMj7jCE2Z19cx/t1xeCXQHBPZnYJa/14OQIxUzJt7h5dn1UWDaFQ==
X-Received: by 2002:a50:f403:: with SMTP id r3mr14483693edm.260.1598458193415;
        Wed, 26 Aug 2020 09:09:53 -0700 (PDT)
Received: from skbuf ([86.126.22.216])
        by smtp.gmail.com with ESMTPSA id v5sm2429132ede.13.2020.08.26.09.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 09:09:52 -0700 (PDT)
Date:   Wed, 26 Aug 2020 19:09:50 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Kuldip Dwivedi <kuldip.dwivedi@puresoftware.com>
Cc:     Mark Brown <broonie@kernel.org>, Qiang Zhao <qiang.zhao@nxp.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pankaj Bansal <pankaj.bansal@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        Tanveer Alam <tanveer.alam@puresoftware.com>
Subject: Re: [PATCH] spi: spi-fsl-dspi: Add ACPI support
Message-ID: <20200826160950.i3k2oy6w2dlvmj34@skbuf>
References: <20200821131029.11440-1-kuldip.dwivedi@puresoftware.com>
 <20200821140718.GH4870@sirena.org.uk>
 <c810740d75f64e308fd362e6c6a5f437@mail.gmail.com>
 <20200822152118.rlwbcgfk4abjldtg@skbuf>
 <VE1PR04MB6768699B6D7A507A5BF82F9191540@VE1PR04MB6768.eurprd04.prod.outlook.com>
 <20200826114758.4agph53ag2fin6um@skbuf>
 <20200826142312.GH4965@sirena.org.uk>
 <20200826144744.c4yzgoovk6f4t3id@skbuf>
 <2e19f8979be4f962045a1597bdbe7886@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e19f8979be4f962045a1597bdbe7886@mail.gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Aug 26, 2020 at 08:43:20PM +0530, Kuldip Dwivedi wrote:
> Just a query, Can't we use meaningful HID for different SoC just like
> compatible strings in DT ?
> In this way Silicon parameters can also be added in
> fsl_dspi_devtype_data structure , which is already exist in driver

I don't know, is that the preferred way?
I don't even know if NXP0005 is made up or if it's written down
somewhere in the PNP ID registry. NXP0006 seems to be assigned to the
MDIO controller already, so the list of _HID values for the DSPI
controller would be discontiguous at best, as well as ever-growing.
Again, I'm just raising the concern, if somebody comes in and declares
that as "not a problem", then ok.
In the ACPI spec there's also a _HRV (Hardware Revision) object, which
comes as a simple DWORD. We could use acpi_evaluate_integer() to read
that, and use it as index into the array of fsl_dspi_devtype_data, if
we declare that as ABI within the driver (and new SoCs would be added
only at the end of the enum). Then we could use the NXP0005 _HID for
everything DSPI.
Again, maybe somebody could chime in and guide us on what's preferable.

Thanks,
-Vladimir
