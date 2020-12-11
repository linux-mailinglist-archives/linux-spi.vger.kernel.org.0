Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1A682D8047
	for <lists+linux-spi@lfdr.de>; Fri, 11 Dec 2020 21:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387661AbgLKU5U (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 11 Dec 2020 15:57:20 -0500
Received: from mail-oo1-f65.google.com ([209.85.161.65]:44450 "EHLO
        mail-oo1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394400AbgLKU45 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 11 Dec 2020 15:56:57 -0500
Received: by mail-oo1-f65.google.com with SMTP id n20so2466164ooq.11;
        Fri, 11 Dec 2020 12:56:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uujRb1yYs4/gF6xQWvYU0z21VRblAw4XTaoO98WlTk8=;
        b=cG9BQyRRFQKRyg0EoxsxM1Bg60TXoYPDNZ3P7pF02yvSPv0op9jeQEe1r6dHrnD3gM
         IP0/+5UJ6BmRVqPonoDGh5qdxdW/BmqlZMZqQkgKbiWfkK+LKcgRA+xPPGKmRTpidfrr
         an1kfO2Hr2gZdGHPI4mp1lp+O+as/0THCoNG1xISlJshb5u6Fz8IZtXcmbuLbeVU+ra2
         d5eMq7kIbGgIERKTEhu11iZCjvQeFSgKGph3o9U57uZeUcRKr2Cp0/vH7pd/hXLOv3b8
         9qgxxXtf93f4RzAkyDOSxKbkCoumdXymVm/tVfyseMfFUpwt4bcXGHxoeS43rYN2I1dV
         HT+Q==
X-Gm-Message-State: AOAM532rrHfvbp3XoDkr38wW/FgBIx7b+8P2kXUOzqRX6vnL93mfA5T0
        2Ut3E8D6nbr2WLqvWWmNmQ==
X-Google-Smtp-Source: ABdhPJzQcK/JTQ3dKxka+F9jtzOoVa2tqeq3ot4i7VtlBgOh+6JBnCCHK6UVg04im6JmhR3L8b4fDg==
X-Received: by 2002:a4a:9e02:: with SMTP id t2mr11637745ook.42.1607720176795;
        Fri, 11 Dec 2020 12:56:16 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h26sm1351527ots.9.2020.12.11.12.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 12:56:15 -0800 (PST)
Received: (nullmailer pid 905876 invoked by uid 1000);
        Fri, 11 Dec 2020 20:56:14 -0000
Date:   Fri, 11 Dec 2020 14:56:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     jonathanh@nvidia.com, broonie@kernel.org, thierry.reding@gmail.com,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-spi@vger.kernel.org, lukas@wunner.de, robh+dt@kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/9] dt-bindings: spi: Add Tegra Quad SPI device tree
 binding
Message-ID: <20201211205614.GA905591@robh.at.kernel.org>
References: <1607706088-1437-1-git-send-email-skomatineni@nvidia.com>
 <1607706088-1437-4-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1607706088-1437-4-git-send-email-skomatineni@nvidia.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 11 Dec 2020 09:01:20 -0800, Sowjanya Komatineni wrote:
> This patch adds YAML based device tree binding document for Tegra
> Quad SPI driver.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  .../bindings/spi/nvidia,tegra210-quad.yaml         | 130 +++++++++++++++++++++
>  1 file changed, 130 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.example.dts:29.38-39 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:342: Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1364: dt_binding_check] Error 2


See https://patchwork.ozlabs.org/patch/1415094

The base for the patch is generally the last rc1. Any dependencies
should be noted.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

