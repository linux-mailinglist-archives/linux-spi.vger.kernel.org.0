Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17736365D2E
	for <lists+linux-spi@lfdr.de>; Tue, 20 Apr 2021 18:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232303AbhDTQW2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 20 Apr 2021 12:22:28 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:44619 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232174AbhDTQW1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 20 Apr 2021 12:22:27 -0400
Received: by mail-ot1-f51.google.com with SMTP id 5-20020a9d09050000b029029432d8d8c5so10352164otp.11;
        Tue, 20 Apr 2021 09:21:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=7rCWJmNituqDy50oQV6vLgBSIuPKc5eqe/iLgSwO2TM=;
        b=I7vqDCeqNeiMACIfkyVWzcYWtQaPtdq7vbfXkk4q8cJRW+SqmGrBM94bz2MiWhvycg
         cvGGt/yJIiMymbs4gEGxaUmXuQabovdY0xr6sWIoe/+I2mluzt0lGItx7MlBHywbKoD3
         J2zcxIDRMU+sEtD/BdXSow7Bejjg91sGeUU6c4RFPPuCJlVD+objTjUwHoUFrXhRemkq
         fkfB4vcRhTR4U5ULxMNssLUVHqpuxXrFEVO0yuJ62DZLofyc5QmgyzUr9STJspRD/RJ4
         0QDFMqK44ZW/E0VbGaM1Bfmw3RfKZoaMI4Xy6QymyvLQck9NT0aFbu26UsXRIDW9+W6K
         IcAg==
X-Gm-Message-State: AOAM531aiKbvxBBnAb2Fnhf2uR9QYa22WI0U6A+sxD2y3Bm4HuopV8Fi
        cMYIHC0+R/up9adT070kDhBm4wAIaw==
X-Google-Smtp-Source: ABdhPJzSZJd1xZjbRrIhDmOV9dO5iilxg5M145vsthNtjLR9vWBjyBiv2DCy1LrMWYVpe5u2D2KkOg==
X-Received: by 2002:a9d:6649:: with SMTP id q9mr11012411otm.197.1618935715512;
        Tue, 20 Apr 2021 09:21:55 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p127sm1454676oig.16.2021.04.20.09.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 09:21:54 -0700 (PDT)
Received: (nullmailer pid 3427069 invoked by uid 1000);
        Tue, 20 Apr 2021 16:21:52 -0000
Date:   Tue, 20 Apr 2021 11:21:52 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     linux-spi@vger.kernel.org, Kamal Dasu <kdasu.kdev@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH V3] dt-bindings: spi: brcm,spi-bcm-qspi: convert to the
 json-schema
Message-ID: <20210420162152.GA3427001@robh.at.kernel.org>
References: <20210416062320.21414-1-zajec5@gmail.com>
 <20210416194723.23855-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210416194723.23855-1-zajec5@gmail.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 16 Apr 2021 21:47:23 +0200, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> This helps validating DTS files.
> 
> Changes that require mentioning:
> 1. reg-names
>    "mspi_regs" and "bspi_regs" were renamed to "mspi" and "bspi" as that
>    is what's used in DTS files and in Linux driver
> 2. interrupt-names
>    Names were reordered. "mspi_done" has to go first as it's always
>    required.
> 3. spi-rx-bus-width
>    Property description was dropped as it's part of the
>    spi-controller.yaml
> 4. Examples:
>    * drop partitions as they are well documented elsewhere
>    * regs and interrupts were formatted and reordered to match yaml
>    * <0x1c> was replaced with <&gic>
>    * "m25p80" node name became "flash"
>    * dropped invalid "m25p,fast-read" property
>    * dropped undocumented and Linux-unused "clock-names"
> 
> This rewritten binding validates cleanly using the  "dt_binding_check".
> Some Linux stored DTS files will require reordering regs and interrupts
> to make dtbs_check happy.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
> V2: Add Kamal as maintainer
> V3: Fix examples (see commit message for details) - thanks Rob
> ---
>  .../bindings/spi/brcm,spi-bcm-qspi.txt        | 245 ------------------
>  .../bindings/spi/brcm,spi-bcm-qspi.yaml       | 198 ++++++++++++++
>  MAINTAINERS                                   |   2 +-
>  3 files changed, 199 insertions(+), 246 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.txt
>  create mode 100644 Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
