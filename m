Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 291BF348026
	for <lists+linux-spi@lfdr.de>; Wed, 24 Mar 2021 19:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237354AbhCXSOb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 24 Mar 2021 14:14:31 -0400
Received: from mail-il1-f181.google.com ([209.85.166.181]:38908 "EHLO
        mail-il1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237440AbhCXSOG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 24 Mar 2021 14:14:06 -0400
Received: by mail-il1-f181.google.com with SMTP id d10so15452907ils.5;
        Wed, 24 Mar 2021 11:14:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ssoghzsOG5hysFjvkRd4198Oad5+uJEC9oHKsrVndbM=;
        b=d0cgPi+GBQxdRrHdS6VMZxfQ7AZ4wl3SnAb7xrE7K7pDb+WhkrkTDnCYUMuDrBrJpN
         f1UPDlpkaTiVEocb1wYNOwPVCitI9VqYPCrUyk1qjX7KLIRGAUmf+14WlNSsIIp3AG72
         gkGWgQBm1o0Z1vsRmzAU5pa0CT78pJhOOtrWxh1beNKDyevR6XIlrMAfkC2KKQfeqqwC
         CLRvYzOvGe9Ja3MBXICGUgxhhp1N/MFKrf0X+fZg4We07oLNujZmxt24FJLJTfJk+E6X
         iuPfOERw2xySws/tRkHtaAU3gYUB92Ukj96cTn80x5T6wcAULIbLXhog4ToNuZ5O4cHz
         Aotw==
X-Gm-Message-State: AOAM533iqSGqmMnFt9rqBCJWkRoyE4SwB7N1BGLBcSWuZ4MzzdrV4S6Q
        jKC0zTFc8NfV37ILSsoV5iVXkL+cvOD6
X-Google-Smtp-Source: ABdhPJzt7P0oMiJe000k25s5sJgAwOYPu8ykRtIWOfIcyq4DDbe6ysw5OMrnPS2VJk+7If0OfXIBNw==
X-Received: by 2002:a05:6e02:965:: with SMTP id q5mr3356487ilt.95.1616609645405;
        Wed, 24 Mar 2021 11:14:05 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id k11sm1441183iok.1.2021.03.24.11.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 11:14:04 -0700 (PDT)
Received: (nullmailer pid 3360900 invoked by uid 1000);
        Wed, 24 Mar 2021 18:14:03 -0000
Date:   Wed, 24 Mar 2021 12:14:03 -0600
From:   Rob Herring <robh@kernel.org>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Kuldeep Singh <kuldeep.singh@nxp.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [EXT] Re: [PATCH] dt-bindings: spi: Convert Freescale DSPI to
 json schema
Message-ID: <20210324181403.GC3320002@robh.at.kernel.org>
References: <20210315121518.3710171-1-kuldeep.singh@nxp.com>
 <20210315205440.lb6hcrvzxtqxdb5x@skbuf>
 <DB6PR0402MB27580AF77ED738B995616EB5E06B9@DB6PR0402MB2758.eurprd04.prod.outlook.com>
 <20210316101506.rkqcxkw6slv4vuhr@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316101506.rkqcxkw6slv4vuhr@skbuf>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Mar 16, 2021 at 12:15:06PM +0200, Vladimir Oltean wrote:
> On Tue, Mar 16, 2021 at 06:08:17AM +0000, Kuldeep Singh wrote:
> > Compatible entries in conjugation require enum and const pair.
> > For example, ls1012a.dtsi uses compatible = "fsl,ls1012a-dspi","fsl,ls1021a-v1.0-dspi";
> > Same goes for LS1028 as well.
> > 
> > Therefore, can't mention the compatible entry as single entity otherwise
> > it may fail "make dt_binding_check" and "make dtbs_check".
> > 
> > > 
> > > > +examples:
> > > > +  - |
> > > > +    #include <dt-bindings/clock/fsl,qoriq-clockgen.h>
> > > > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > > > +
> > > > +    soc {
> > > > +        #address-cells = <2>;
> > > > +        #size-cells = <2>;
> > > > +
> > > > +        spi@2100000 {
> > > > +            compatible = "fsl,ls1028a-dspi", "fsl,ls1021a-v1.0-dspi";
> > > 
> > > This doesn't need the "fsl,ls1021a-v1.0-dspi" compatible, can you please remove
> > > it?
> > 
> > I have taken this example from LS1028a.dtsi and it uses these compatibles in conjugation.
> > If "fsl,ls1021a-v1.0-dspi" is not required, then it should also be removed from device-tree
> > As well as from bindings both.
> 
> Yes, the second compatible is never required by the driver and should be
> removed from existing device trees if that makes "make dtbs_check" fail.

Can you say that is true for every possible driver implementation? 
u-boot, *BSD, etc.?

Rob
