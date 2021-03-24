Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 853B83480FE
	for <lists+linux-spi@lfdr.de>; Wed, 24 Mar 2021 19:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237691AbhCXSxc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 24 Mar 2021 14:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237620AbhCXSxG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 24 Mar 2021 14:53:06 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D15C061763;
        Wed, 24 Mar 2021 11:53:05 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id b7so34646308ejv.1;
        Wed, 24 Mar 2021 11:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=d0MP68E32DMevL9+M6AmZnQhcJ2RKPw4JlMJNm0RAt8=;
        b=hh+kq8FxalR7zvvYI4yF2Z4nWgkfU6JsWK2XwRjV5+48AglLrRl9OyiNtTGO/h1C2J
         6vpEr0kYaNAQwFIjXSUHQFMVpGe3sEmJ3m2vNmFdeTpbqwfHEgPMhzWAGT7+GTKk2VuY
         bC7EMeyxl3oK2XyE6mol57ZR+eO00rvYY4OZvQxArCcTQLkXf4qJYXMq/NM5XfkQ3MVW
         D/Dj0cwLTDApsJjwcjENr/r2cPgvCUosmImB7WpxlCvK0dNOSFq/fgRaqilHJu+p5BVf
         E7wNkmZoOkgTFa0u+8YRR2Q0PjVmhCVK2pfQKDF+jbe4Qpirw+795s8NFSa0sVvX4i3p
         GZQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d0MP68E32DMevL9+M6AmZnQhcJ2RKPw4JlMJNm0RAt8=;
        b=NSidPMDEBgP88FoEogbh3aHw7wFxyT8cQs7Ruh98uKSC2dczMR26wyR0t1OO8pD4J8
         wbNe8I4l1RjAMl+qEI5A1KvQysU6EIM1CT+U1ZtWeKceaVV2388Dgo0gi6LTJALsTPMq
         pMkUBGYXIMS+kz6mEDXzPp4N34iWeAu0rSOWmtjiW2Jlx7WcMTaAtzJ0YFQmr2uORfO1
         tirA432tnNItxz6kgFYYy+sp8Jw3mjSb25X5bcgHGMbiNvpJQKOtp8orpPVv3ZCovADY
         fPt/yawyXEwv2YvK8ecC0Z/pKxYeFgRsEVhUQlavAZgENyH9skdl73cVqgPS3lQQ+uX1
         IZHA==
X-Gm-Message-State: AOAM530J3T1vzqcouiqRnrjPNHcAMCIj4m27TS0BjjhEakVPSY05eKqJ
        s2Bdgpf9EfE/RpOOy8goZFY=
X-Google-Smtp-Source: ABdhPJzTDcplvdIw7B8FDDmPW5+m/Lx5Y7cSMtmJa+DF80RAFYQ20fIuKJWPM6ZSa1plvCxk+ehpCg==
X-Received: by 2002:a17:906:a052:: with SMTP id bg18mr5346533ejb.18.1616611984482;
        Wed, 24 Mar 2021 11:53:04 -0700 (PDT)
Received: from skbuf (5-12-16-165.residential.rdsnet.ro. [5.12.16.165])
        by smtp.gmail.com with ESMTPSA id k9sm1537480edn.68.2021.03.24.11.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 11:53:04 -0700 (PDT)
Date:   Wed, 24 Mar 2021 20:53:02 +0200
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Kuldeep Singh <kuldeep.singh@nxp.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [EXT] Re: [PATCH] dt-bindings: spi: Convert Freescale DSPI to
 json schema
Message-ID: <20210324185302.dxi2wurf7lgr5yxi@skbuf>
References: <20210315121518.3710171-1-kuldeep.singh@nxp.com>
 <20210315205440.lb6hcrvzxtqxdb5x@skbuf>
 <DB6PR0402MB27580AF77ED738B995616EB5E06B9@DB6PR0402MB2758.eurprd04.prod.outlook.com>
 <20210316101506.rkqcxkw6slv4vuhr@skbuf>
 <20210324181403.GC3320002@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210324181403.GC3320002@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Mar 24, 2021 at 12:14:03PM -0600, Rob Herring wrote:
> On Tue, Mar 16, 2021 at 12:15:06PM +0200, Vladimir Oltean wrote:
> > On Tue, Mar 16, 2021 at 06:08:17AM +0000, Kuldeep Singh wrote:
> > > Compatible entries in conjugation require enum and const pair.
> > > For example, ls1012a.dtsi uses compatible = "fsl,ls1012a-dspi","fsl,ls1021a-v1.0-dspi";
> > > Same goes for LS1028 as well.
> > >
> > > Therefore, can't mention the compatible entry as single entity otherwise
> > > it may fail "make dt_binding_check" and "make dtbs_check".
> > >
> > > >
> > > > > +examples:
> > > > > +  - |
> > > > > +    #include <dt-bindings/clock/fsl,qoriq-clockgen.h>
> > > > > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > > > > +
> > > > > +    soc {
> > > > > +        #address-cells = <2>;
> > > > > +        #size-cells = <2>;
> > > > > +
> > > > > +        spi@2100000 {
> > > > > +            compatible = "fsl,ls1028a-dspi", "fsl,ls1021a-v1.0-dspi";
> > > >
> > > > This doesn't need the "fsl,ls1021a-v1.0-dspi" compatible, can you please remove
> > > > it?
> > >
> > > I have taken this example from LS1028a.dtsi and it uses these compatibles in conjugation.
> > > If "fsl,ls1021a-v1.0-dspi" is not required, then it should also be removed from device-tree
> > > As well as from bindings both.
> >
> > Yes, the second compatible is never required by the driver and should be
> > removed from existing device trees if that makes "make dtbs_check" fail.
>
> Can you say that is true for every possible driver implementation?
> u-boot, *BSD, etc.?

I don't think other systems are required to follow Linux conventions, so
I'm not sure why it matters.
