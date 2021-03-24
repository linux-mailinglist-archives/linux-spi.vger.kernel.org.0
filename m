Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB367348011
	for <lists+linux-spi@lfdr.de>; Wed, 24 Mar 2021 19:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237381AbhCXSKl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 24 Mar 2021 14:10:41 -0400
Received: from mail-il1-f180.google.com ([209.85.166.180]:42824 "EHLO
        mail-il1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237298AbhCXSKk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 24 Mar 2021 14:10:40 -0400
Received: by mail-il1-f180.google.com with SMTP id l5so22217293ilv.9;
        Wed, 24 Mar 2021 11:10:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RdLddjC+iEoz4u6jK63hDy1PT64QJ2geKnpXuxhai+o=;
        b=YWWPMQViLkl9FQYdYnyR044N0GurX1P22Lm1cju9vf4CGc9lJDeUFgjBFHrdeU+xWl
         RIiKPNXv77gpolW0y8oolLSItnc24ZnZSlP7L8aWH4k+kLcxmECHq3aYj3lvXijOc6mN
         u123rpeIGUil6qVEEn2gO+1POSupQHm1fOs3mMOlfXUal62EPClj2u9ocsKrwsS8VtpC
         HhOxQVbuAFuxleoMKobryU2bg92eWSC0l39c/dfmzI7ohk6fcAX9uvi8Iwk7WBvdv6DE
         6Nvv+F6GURYE8eQ0LxqBmieKKXyK0PK2zvFvCLRHBA2/hIIzA95hugy4fxtA2um8cmBv
         ySQg==
X-Gm-Message-State: AOAM530cXiIMnrqOhKEHLScXOGzgyeuqK82a2rUL6HpRd+FZaa8eYty9
        MboVKajWm0MY5uGe6yZzOQ==
X-Google-Smtp-Source: ABdhPJwm0lu4eHHZUt2iJVbAnUdqjkeCxMGA0KTL4TLAcSjo5jjJ4hxUEVPPY6roCmHkoYeekofWyg==
X-Received: by 2002:a92:c748:: with SMTP id y8mr1842248ilp.37.1616609440259;
        Wed, 24 Mar 2021 11:10:40 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id b9sm1443474iof.54.2021.03.24.11.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 11:10:39 -0700 (PDT)
Received: (nullmailer pid 3355529 invoked by uid 1000);
        Wed, 24 Mar 2021 18:10:37 -0000
Date:   Wed, 24 Mar 2021 12:10:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Kuldeep Singh <kuldeep.singh@nxp.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Vladimir Oltean <olteanv@gmail.com>,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: spi: Convert Freescale DSPI to json schema
Message-ID: <20210324181037.GB3320002@robh.at.kernel.org>
References: <20210315121518.3710171-1-kuldeep.singh@nxp.com>
 <20210315183051.ugvmz4zqrvuo6iqq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210315183051.ugvmz4zqrvuo6iqq@ti.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Mar 16, 2021 at 12:00:52AM +0530, Pratyush Yadav wrote:
> +Cc mtd list
> 
> Hi,
> 
> On 15/03/21 05:45PM, Kuldeep Singh wrote:
> > Convert the Freescale DSPI binding to DT schema format using json-schema.
> > 
> > Signed-off-by: Kuldeep Singh <kuldeep.singh@nxp.com>
> > ---
> > Hi Rob,
> > This patch is checked with following commands with no warnings observed.
> > make distclean; make allmodconfig;
> > make dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/spi/fsl,spi-fsl-dspi.yaml;
> > make dtbs_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/spi/fsl,spi-fsl-dspi.yaml
> 
> When I add the "fsl,spi-cs-sck-delay" property under the flash@0 node in 
> the example and run dt_binding_check, I see the below error:
> 
>   /home/pratyush/src/linux/Documentation/devicetree/bindings/spi/fsl,spi-fsl-dspi.example.dt.yaml: flash@0: 'fsl,spi-cs-sck-delay' does not match any of the regexes: '^partition@', 'pinctrl-[0-9]+'
>      From schema: /home/pratyush/src/lin/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> 
> I am trying to solve a similar problem for the Cadence QSPI controller 
> binding and I wonder what the best solution for this is. The obvious one 
> would be to add these properties to jedec,spi-nor.yaml. I haven't 
> managed to come up with any other solution to this problem.
> 
> Rob, all, any suggestions on how to best model this?

I'm aware of the issue, but I don't have a solution for this situation. 
It's a problem anywhere we have a parent or bus binding defining 
properties for child nodes. For now, I'd just avoid it in the examples 
and we'll figure out how to deal with actual dts files later.

For this one in particular, CS to clock timing isn't any FSL or 
controller specific, but is device specific. So this probably should 
have been a generic spi bus property (if not implicit). That's somewhat 
easier to work-around than potentially adding controller specific 
properties to every slave device schema.

Rob
