Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF9991D9DFA
	for <lists+linux-spi@lfdr.de>; Tue, 19 May 2020 19:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729335AbgESRhC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 19 May 2020 13:37:02 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:37155 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729001AbgESRhC (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 19 May 2020 13:37:02 -0400
Received: by mail-io1-f67.google.com with SMTP id t15so40477ios.4;
        Tue, 19 May 2020 10:37:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XTPJr0RoCtcKkiWN8fbDLRyRDQpXZpviGSZLqL/Da5g=;
        b=LW41viB7s8Sjv6KJfEB+P/EXQE5HrneqawvZL60GZiOu2fGYVtsz1GnXeh1nti8J6j
         S5fJ5W8DW51OMK6u0TZALywnnC5lx77tkrnYVF6Nyfx9p8t8Fgd07G0QdzIIUYcpYZU2
         +vOBVFCEPBPzMZqcqANgDIaQn7c+PL2HYpQNeCNKEQXtTeUwPhisK5nlUGcdnZuHjQlu
         Xu9xwzuF/1lY2103vKFLFjnfU+f3U4vSr28ZYyqQKYzvwGn7SExphnxR1zFlNRKBQkyx
         +O4At3463i46J61TAq5yoQ8GXCUixXB35cj0OpdUW988uZ6eRvtWEYvJl4SvDEyQJxEe
         W2ZQ==
X-Gm-Message-State: AOAM530pvKjFMEYVsotyA5XAhPnoGxxnvq8QCi9UtEOdE0h0TiTfjcUv
        U6fj0N0f09hnDGCsteSXBWqD3FA=
X-Google-Smtp-Source: ABdhPJwH2K7ECQ4/Q1DUnIHStWxaucXWvfJTMS0U8iF4gW6tfpn8mAiwZOMeQ4V6tSAqwn3rTWkewQ==
X-Received: by 2002:a6b:d219:: with SMTP id q25mr41096iob.202.1589909821031;
        Tue, 19 May 2020 10:37:01 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id h9sm127992ioa.6.2020.05.19.10.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 10:37:00 -0700 (PDT)
Received: (nullmailer pid 341666 invoked by uid 1000);
        Tue, 19 May 2020 17:36:58 -0000
Date:   Tue, 19 May 2020 11:36:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     Mason Yang <masonccyang@mxic.com.tw>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Chris Brandt <chris.brandt@renesas.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: memory: document Renesas RPC-IF
 bindings
Message-ID: <20200519173658.GA340788@bogus>
References: <26faf5e8-26eb-cceb-a500-f0fd64609737@cogentembedded.com>
 <f998fe6c-c586-17cb-9343-30460ce0bf9d@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f998fe6c-c586-17cb-9343-30460ce0bf9d@cogentembedded.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 18 May 2020 23:33:15 +0300, Sergei Shtylyov wrote:
> Renesas Reduced Pin Count Interface (RPC-IF) allows a SPI flash or
> HyperFlash connected to the SoC to be accessed via the external address
> space read mode or the manual mode.
> 
> Document the device tree bindings for the Renesas RPC-IF found in the R-Car
> gen3 SoCs.
> 
> Based on the original patch by Mason Yang <masonccyang@mxic.com.tw>.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---
> Changes in version 3:
> - fixed up the whitespace and added hyphens in the "compatible" prop text, also
>   removed the comments;
> - specified the subnode name as "flash", and used "enum" in the subnode text;
> - fixed up the SPDX-License-Identifier: tag.
> 
> Changes in version 2:
> - rewrote the bindings in YAML.
> 
>  Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml |   88 ++++++++++
>  1 file changed, 88 insertions(+)
> 


My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml: patternProperties:flash@[0-9a-f]+$:properties:compatible: [{'enum': ['cfi-flash', 'jedec,spi-nor']}] is not of type 'object', 'boolean'
Documentation/devicetree/bindings/Makefile:12: recipe for target 'Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.example.dts' failed
make[1]: *** [Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
Makefile:1300: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1292811

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

