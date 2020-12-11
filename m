Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD87B2D8043
	for <lists+linux-spi@lfdr.de>; Fri, 11 Dec 2020 21:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390392AbgLKU4s (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 11 Dec 2020 15:56:48 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36969 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729581AbgLKU43 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 11 Dec 2020 15:56:29 -0500
Received: by mail-oi1-f193.google.com with SMTP id l207so11382052oib.4;
        Fri, 11 Dec 2020 12:56:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oZMbLI/p6n3mu1U8gcQ9n+p5KHzJ0EBoVbGx3EQ0oI4=;
        b=tOWfW3ZZGlKhZvn61x0XuRgL7lK74hZnXnbL1r03VmNQkLRcB/Q8nssfGv6rGbD6nO
         m5im9WnhPfLiXxI87LMBANI1XmMJd1GhLNK71LLH7h8NRa0V5yRrQQ8kpVCl6oethyTW
         k9MHlk7Qq/jRQ9JK5DmlXXRMA/yzMPdmHPHGqFeXQ+mDNAuslLDZHf6JhLCh/vFgM8vs
         fByj585wT1WOiprqHci4eDW8WuNtbFCkqf+ncVDbDYhOFF5vT7xafjYk4NnwkQ/6SQrc
         Cp1/ZAscDNJJ/5pNExx8uE24Lq6flB+/tD0fBjuaspnGjBAynpeeUJREsaAzDYiaKHAT
         znPQ==
X-Gm-Message-State: AOAM533RQy+ngR0UsSupI/28rbLv1eY5dNIvEbB8b8u1+kfzSleT57r5
        6HGNTt8rpJBOmADkG+OY7Ggxb+dZOw==
X-Google-Smtp-Source: ABdhPJxb7DR5rJB0l1QJh7XdRRRsyuFis3+BKlCSMqac1opUSMLgVJtyEeeqU0ltgyV/9gC6SbcfEQ==
X-Received: by 2002:a05:6808:64d:: with SMTP id z13mr2625334oih.177.1607720148474;
        Fri, 11 Dec 2020 12:55:48 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h2sm2095018otn.15.2020.12.11.12.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 12:55:47 -0800 (PST)
Received: (nullmailer pid 905129 invoked by uid 1000);
        Fri, 11 Dec 2020 20:55:46 -0000
Date:   Fri, 11 Dec 2020 14:55:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, lukas@wunner.de, broonie@kernel.org,
        devicetree@vger.kernel.org, thierry.reding@gmail.com
Subject: Re: [PATCH v2 2/9] dt-bindings: spi: Add Tegra QSPI device tree
 binding
Message-ID: <20201211205546.GA904872@robh.at.kernel.org>
References: <1607706088-1437-1-git-send-email-skomatineni@nvidia.com>
 <1607706088-1437-3-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1607706088-1437-3-git-send-email-skomatineni@nvidia.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 11 Dec 2020 09:01:19 -0800, Sowjanya Komatineni wrote:
> This patch adds YAML based device tree binding document for Tegra
> QSPI driver.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  .../bindings/spi/nvidia,tegra210-quad.yaml         | 128 +++++++++++++++++++++
>  1 file changed, 128 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/spi/nvidia,tegra210-quad.yaml#
Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.example.dts:35.25-35: Warning (reg_format): /example-0/spi@70410000/flash@0:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.example.dt.yaml: Warning (pci_device_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.example.dt.yaml: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.example.dt.yaml: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.example.dt.yaml: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.example.dts:23.22-40.11: Warning (spi_bus_bridge): /example-0/spi@70410000: incorrect #address-cells for SPI bus
Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.example.dts:23.22-40.11: Warning (spi_bus_bridge): /example-0/spi@70410000: incorrect #size-cells for SPI bus
Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.example.dt.yaml: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.example.dt.yaml: Warning (spi_bus_reg): Failed prerequisite 'spi_bus_bridge'
Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.example.dts:33.25-39.19: Warning (avoid_default_addr_size): /example-0/spi@70410000/flash@0: Relying on default #address-cells value
Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.example.dts:33.25-39.19: Warning (avoid_default_addr_size): /example-0/spi@70410000/flash@0: Relying on default #size-cells value
Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.example.dt.yaml: Warning (unique_unit_address): Failed prerequisite 'avoid_default_addr_size'


See https://patchwork.ozlabs.org/patch/1415099

The base for the patch is generally the last rc1. Any dependencies
should be noted.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

