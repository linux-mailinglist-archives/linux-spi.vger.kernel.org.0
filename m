Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBA0633082
	for <lists+linux-spi@lfdr.de>; Mon,  3 Jun 2019 15:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbfFCNEd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 3 Jun 2019 09:04:33 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51656 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728133AbfFCNEc (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 3 Jun 2019 09:04:32 -0400
Received: by mail-wm1-f65.google.com with SMTP id f10so11123289wmb.1
        for <linux-spi@vger.kernel.org>; Mon, 03 Jun 2019 06:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=03wIuI+95U2k5wsZC8Hm2JFpOnjzC3cBrRUf8IxbDpU=;
        b=iIlx/qlAtzx4C+kJiByh9KQ/8RYsdZpNtII/z4eZYZqEFIDOqI3yOqbROGVScEIhFg
         dhIVxFYa8JH/414z6aG+bF8W10a3l0G5I2opFuAeeCIhZ8JG4uEKH3J8lPD+lg6QNR4t
         9jG3T32ausmHo7QnAhk9TP5XOQQBhCiuMxVKwoK1TGLZYVsdaSsGWmK44dIVFm2iGCoZ
         FVc0cUPmdmfq7XzWQBCwLAOJZQ8k4pp5NDz5oKyZeco3NmzRvsp26ASWtPnethz/BBIa
         Sj79C/FFLdVdOvIrgz7iKVSzela8aqrxdRyAPluVPG9ENrCBdAUh9QN7B0jLNsIc7Ols
         /CDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=03wIuI+95U2k5wsZC8Hm2JFpOnjzC3cBrRUf8IxbDpU=;
        b=dlZuBWWzg1QuIl3ySofV9o8Z1du1W0L/pkpEU4XzAkKfZ/GJlykkawvdDc5q0RbKyH
         u+otKKQCC1r7khiV78J7cJXxH4K+XnLkgZ/xE+ENShLhA7P4Tf42l7IMtxO+xvlWrTIV
         Atj+RJFqIGqiZBYwEom2UXJsxwz0fVafPAEQEp/3cvDlYga/rVIlTp6OU8c9etEy/KUb
         tx/J85ZcnaF5vJ4cXs0lxaS8AV7L/MJ03RkUyWHgIWYRGGjb0veP2wUhnzI7L27TR05D
         trd2wlqaF013xcjihXLSL4bmHu2w9EJHne7/u6EsbS8WNbrNppO6SlchtM9hhZ3fusr3
         uNTw==
X-Gm-Message-State: APjAAAVuOaAQzUC0HnzDXJotNllK8aPLKFJ1tdbupoQRAWYxsnekbc/8
        mDj6Q5waEbiiQaIWV48o4HCU2A==
X-Google-Smtp-Source: APXvYqzE0Z8unVGrUlHJ6gais9BAMuNRWey3Q/3dVyTPEl/lsPXneHfZZPM8FyhWjW7pcb2cO6NENg==
X-Received: by 2002:a1c:6a11:: with SMTP id f17mr13444788wmc.110.1559567071120;
        Mon, 03 Jun 2019 06:04:31 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id b69sm10857016wme.44.2019.06.03.06.04.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Jun 2019 06:04:30 -0700 (PDT)
Date:   Mon, 3 Jun 2019 14:04:28 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     Mason Yang <masonccyang@mxic.com.tw>, broonie@kernel.org,
        marek.vasut@gmail.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, bbrezillon@kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, juliensu@mxic.com.tw,
        Simon Horman <horms@verge.net.au>, miquel.raynal@bootlin.com
Subject: Re: [PATCH v13 3/3] dt-bindings: mfd: Document Renesas R-Car Gen3
 RPC-IF controller bindings
Message-ID: <20190603130428.GX4797@dell>
References: <1558423174-10748-1-git-send-email-masonccyang@mxic.com.tw>
 <1558423174-10748-4-git-send-email-masonccyang@mxic.com.tw>
 <0e2994d6-6efc-9f36-f681-609199f20b9f@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0e2994d6-6efc-9f36-f681-609199f20b9f@cogentembedded.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 22 May 2019, Sergei Shtylyov wrote:

> On 05/21/2019 10:19 AM, Mason Yang wrote:
> 
> > Document the bindings used by the Renesas R-Car Gen3 RPC-IF controller.
> > 
> > Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> > ---
> >  .../devicetree/bindings/mfd/renesas-rpc-if.txt     | 65 ++++++++++++++++++++++
> >  1 file changed, 65 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mfd/renesas-rpc-if.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/mfd/renesas-rpc-if.txt b/Documentation/devicetree/bindings/mfd/renesas-rpc-if.txt
> > new file mode 100644
> > index 0000000..20ec85b
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mfd/renesas-rpc-if.txt
> > @@ -0,0 +1,65 @@
> > +Renesas R-Car Gen3 RPC-IF controller Device Tree Bindings
> > +---------------------------------------------------------
> > +
> > +RPC-IF supports both SPI NOR and HyperFlash (CFI-compliant flash)
> > +
> > +Required properties:
> > +- compatible: should be an SoC-specific compatible value, followed by
> > +		"renesas,rcar-gen3-rpc" as a fallback.
> > +		supported SoC-specific values are:
> > +		"renesas,r8a77995-rpc"	(R-Car D3)
> > +- reg: should contain three register areas:
> > +	first for RPC-IF registers,
> > +	second for the direct mapping read mode and
> > +	third for the write buffer area.
> > +- reg-names: should contain "regs", "dirmap" and "wbuf"
> > +- clocks: should contain 1 entries for the module's clock
> > +- clock-names: should contain "rpc"
> > +- power-domains: should contain system-controller(sysc) for power-domain-cell
> > +- resets: should contain clock pulse generator(cpg) for reset-cell,
> > +	  power-domain-cell and clock-cell
> 
>    That's just some nonsense, sorry...
>    I suggest that you stop reposting your patches as I'm going to post
> my version of this patchset RSN (based on your patches, of course) and I'm
> going to take care of fixing this file as well.

Why is this necessary?

Why not just provide some constructive feedback instead?

> > +- #address-cells: should be 1
> > +- #size-cells: should be 0
> [...]
> 
> MBR, Sergei

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
