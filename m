Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E87C43945C3
	for <lists+linux-spi@lfdr.de>; Fri, 28 May 2021 18:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236355AbhE1QXc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 28 May 2021 12:23:32 -0400
Received: from mail-oo1-f53.google.com ([209.85.161.53]:33742 "EHLO
        mail-oo1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234131AbhE1QXb (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 28 May 2021 12:23:31 -0400
Received: by mail-oo1-f53.google.com with SMTP id j17-20020a4ad6d10000b02901fef5280522so1061714oot.0;
        Fri, 28 May 2021 09:21:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=Tu1wUpDQ2+j5UU78R8du5GXImtZHnLMb7l4b4wsjriU=;
        b=RRA1uHmQdQFsIZJCFJzYZuuKXOk5cfID7ivYhLqGMcuhohFVAZ/tWgyuAGCgdqYsuo
         52TwTEPNDpzCen7sv2uQoi3f9AqNpi9ybWDYI8XlA2h7pQmv5Q0LxhLxpHXkQiHA+9sF
         4EKvRwEKEoUTLhdXkVNzUe1yjuEbPF8xhs1FmjCoWob0B2rNx6hX/5QWgQ1jcDsSJiH/
         MG/6BQz6UjB/pwQT8HaGulyIjQGaOFv1Omj5ykzCcChXo2GfZN1GD88KUquBaIlySzth
         GGxEu/yb61y3+drLdjP0/2ifWvrIKLG/VoV5FDHcYIRnsgaS94PGNAxnkhpHI4O0Ssp1
         Ymyg==
X-Gm-Message-State: AOAM530G5RzO+U5E9UTdVwHW2GLdzPWyMiA65gAPwTccTtd3L+0+lxv5
        YdEEfRP10HC5XSxyWoMEqQ==
X-Google-Smtp-Source: ABdhPJyQAgqeac1wSrTsBTPaEDXesAkPGK2rEOb8wsxmgaco/ReNmaQ36i+O0/XSbunkdSyoH6oHKw==
X-Received: by 2002:a4a:49c8:: with SMTP id z191mr7570889ooa.62.1622218916165;
        Fri, 28 May 2021 09:21:56 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c13sm1211997oto.18.2021.05.28.09.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 09:21:54 -0700 (PDT)
Received: (nullmailer pid 3720616 invoked by uid 1000);
        Fri, 28 May 2021 16:21:50 -0000
From:   Rob Herring <robh@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     kernel@collabora.com, Arnd Bergmann <arnd@arndb.de>,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>, Ian Ray <ian.ray@ge.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
In-Reply-To: <20210528113346.37137-4-sebastian.reichel@collabora.com>
References: <20210528113346.37137-1-sebastian.reichel@collabora.com> <20210528113346.37137-4-sebastian.reichel@collabora.com>
Subject: Re: [PATCHv3 3/5] dt-bindings: misc: ge-achc: Convert to DT schema format
Date:   Fri, 28 May 2021 11:21:50 -0500
Message-Id: <1622218910.762365.3720615.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 28 May 2021 13:33:45 +0200, Sebastian Reichel wrote:
> Convert the binding to DT schema format. Also update the binding
> to fix shortcomings
> 
>  * Add "nxp,kinetis-k20" fallback compatible
>  * add programming SPI interface and reset GPIO
>  * add main clock
>  * add voltage supplies
>  * drop spi-max-frequency from required properties,
>    driver will setup max. frequency
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  .../devicetree/bindings/misc/ge-achc.txt      | 26 -------
>  .../devicetree/bindings/misc/ge-achc.yaml     | 67 +++++++++++++++++++
>  2 files changed, 67 insertions(+), 26 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/misc/ge-achc.txt
>  create mode 100644 Documentation/devicetree/bindings/misc/ge-achc.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/misc/ge-achc.yaml: properties:reg:minItems: False schema does not allow 2
	hint: "minItems/maxItems" equal to the "items" list length are not necessary
	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/misc/ge-achc.yaml: properties:reg:maxItems: False schema does not allow 2
	hint: "minItems/maxItems" equal to the "items" list length are not necessary
	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/misc/ge-achc.yaml: ignoring, error in schema: properties: reg: minItems
warning: no schema found in file: ./Documentation/devicetree/bindings/misc/ge-achc.yaml
Documentation/devicetree/bindings/misc/ge-achc.example.dt.yaml:0:0: /example-0/spi/spi@1: failed to match any schema with compatible: ['ge,achc', 'nxp,kinetis-k20']
Documentation/devicetree/bindings/misc/ge-achc.example.dt.yaml:0:0: /example-0/spi/spi@1: failed to match any schema with compatible: ['ge,achc', 'nxp,kinetis-k20']

See https://patchwork.ozlabs.org/patch/1485219

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

