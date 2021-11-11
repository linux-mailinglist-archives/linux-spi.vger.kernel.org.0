Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 597C044D8DF
	for <lists+linux-spi@lfdr.de>; Thu, 11 Nov 2021 16:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233813AbhKKPJm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 11 Nov 2021 10:09:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233798AbhKKPJj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 11 Nov 2021 10:09:39 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5194EC061767;
        Thu, 11 Nov 2021 07:06:50 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id 1so12548066ljv.2;
        Thu, 11 Nov 2021 07:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=atEvBZS6JbH/fBakpxl0ydNMlsxU8a3CAtxPkHgUBao=;
        b=LbEOQHk3kfHEAj//dva6jU1GJiv3HQ0rVQnV+XhhrL2EQeC2olmucVRAU9Cj7ghLva
         yOx3bDdeVY4nZ4+l37woZHhXAmw8QmhhGSNO77e4WNFz+kM38flm75wNmQ8zS6YgV6Vp
         q/HSCKUlDf8JNPyHo2Or8qCncVvI/1kM5VMI69bnSu6aodrjQZZypdRqTBcFwBPJATaa
         kc3ogUpC6cPbMb50hOATzFHke/z9Cs4xRF6TDvon25eE9cgmnABeErPskpSX87lEuYsI
         5C2rH26s+SoDXiPpxXMuNGPQ8JI52eEq81gsDAer0MpRr3E5Db1+rVC07agGEf/SSEbN
         qajg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=atEvBZS6JbH/fBakpxl0ydNMlsxU8a3CAtxPkHgUBao=;
        b=AQCWzvNlC8YIWanwW08iEHs244c7KC3DKnz2JaUYxWo10Y0zej7PT10gO3St/FAWX6
         /SVxsRez76BWkShSIe5E7Vu/z3SQWuvLrLftAqgDgygtVm9h57kMPAUTFw4O5ciEfXkZ
         x9AMcsVCNUi6un+IjpIAM8xF+gCuvNZcNHi2o/iqxnNIvqxyrnkMHbbGdJbobmyky9Wa
         fl3Ft0tIo7g4h0rI2Jc/CMiSQTm8uakxtcnYqXQlNU0itGI5q7PlR7rBnKzkmsj4sUH6
         ny4aBlbwxxRAWhxEagae9oBay+Qcs6yRlplffO2qhx00O94eT/lNKBl8rzh4XVD94e7y
         8gZA==
X-Gm-Message-State: AOAM532s1XgxCI+zcYK4FtHxNL3rHc624cDRRSkcYVa7fyce20bZsCCt
        yQTARhhmZUXKmTk5WyGJOfs=
X-Google-Smtp-Source: ABdhPJzTWLuwNN9l+pwtH1zTo7roHWjcBfwY6YyodN5aV17cRAD0iKv9VEGBAwG05nQOrFA/uILl5w==
X-Received: by 2002:a2e:bd09:: with SMTP id n9mr7788404ljq.40.1636643208712;
        Thu, 11 Nov 2021 07:06:48 -0800 (PST)
Received: from mobilestation ([95.79.188.236])
        by smtp.gmail.com with ESMTPSA id u3sm306633lft.215.2021.11.11.07.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 07:06:48 -0800 (PST)
Date:   Thu, 11 Nov 2021 18:06:45 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Mark Brown <broonie@kernel.org>, nandhini.srikandan@intel.com
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        robh+dt@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mgross@linux.intel.com, kris.pan@intel.com,
        kenchappa.demakkanavar@intel.com, furong.zhou@intel.com,
        mallikarjunappa.sangannavar@intel.com, mahesh.r.vaidya@intel.com,
        rashmi.a@intel.com
Subject: Re: [PATCH v3 1/5] dt-bindings: spi: Add SSTE support for DWC SSI
 controller
Message-ID: <20211111150645.f6qmnzy6hcoiatun@mobilestation>
References: <20211111065201.10249-1-nandhini.srikandan@intel.com>
 <20211111065201.10249-2-nandhini.srikandan@intel.com>
 <20211111143108.pxovseqvm2ywmoc2@mobilestation>
 <YY0wOBoT7X//GfQ8@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YY0wOBoT7X//GfQ8@sirena.org.uk>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Nov 11, 2021 at 03:01:12PM +0000, Mark Brown wrote:
> On Thu, Nov 11, 2021 at 05:31:08PM +0300, Serge Semin wrote:
> 
> > BTW Mark, why not to have a generic DT-property which would set that
> > flag automatically by the SPI-core subsystem seeing it's indeed a
> > client device-property? For instance there can be some property like
> > "spi-cs-toggle" DT-property which when specified for the particular
> > SPI-client DT-node will make the SPI-core subsystem to set the
> 
> Anything like this is fundamentally part of the wire protocol for the
> device, there's no need for an extra property on top of the compatible
> for the device and the driver really, really needs to know what's going
> on to avoid data corruption.  You could also use this feature together
> with varying the word size as an optimisation at runtime (eg, do long
> sequences of register writes in a single hardware operation by setting
> an appropriate word length to cause the controller to bounce chip
> select between writes).
> 
> > SPI_CS_WORD flag of the device mode? Like it has already been done for
> > "spi-cs-high"/"spi-lsb-first"/etc.
> 
> I don't think either of those properties was a good idea, there's a
> bunch of stuff in the older SPI bindings that don't make much sense.

Ok. Thanks for clarification. No new DT-property then.

Nandhini, could you please drop this patch in v4? One more time I'm sorry
for misleading you on v2.

-Sergey

