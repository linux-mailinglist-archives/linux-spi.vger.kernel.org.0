Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7FA93A054C
	for <lists+linux-spi@lfdr.de>; Tue,  8 Jun 2021 22:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbhFHUxK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 8 Jun 2021 16:53:10 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43]:45570 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbhFHUxJ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 8 Jun 2021 16:53:09 -0400
Received: by mail-ot1-f43.google.com with SMTP id 6-20020a9d07860000b02903e83bf8f8fcso8669824oto.12;
        Tue, 08 Jun 2021 13:51:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=yiKyoptaaysab5Fo1rGVaoicrRW/xpQQvXSGwjLxWNw=;
        b=Cz/38WeZsnxQIkQerEXmkiBP5eVdd+kZAWXD7cqbiX9uvPTuNI67XX1FiASEnO3Tqq
         o/yEtMVGzG6HsLuuTIbL6RGykznRqURg5ALtktV5a01RqA7mPgwTF+gPLKXvBjUt1DNM
         D7bdASJOQYj100YJ9hxJXg75O394GW5BIAPtr8pEXR936zDGVhWBbg64/3aLwLVcdmCo
         Ov0oPS9CemNMMsjxwDsI7hE9W8gESGcfctTzvKoWBaemF57mY2AMAy5iHtyJYfrnWa88
         ENyLiyZiMB8RgBKVoVnAYeakMsqHfylcuQm5ODigxd6zsi6Q/ka7//vdGctyLoh3jLgH
         Qg1g==
X-Gm-Message-State: AOAM5303MWU+AKb5xqQijOi8fEw70qb7jiGL6Djng0AXEYRhaufE5yUB
        P+2IpC7agY8mrJKa92uZgg==
X-Google-Smtp-Source: ABdhPJy7TQBWX65tHgc+EHrt1j0YQ7W9UDW5Ax7Wb/tf4y/D7lnLWrIHb0ZAuQzJRawt41CRHLK1mA==
X-Received: by 2002:a9d:6c89:: with SMTP id c9mr16701595otr.163.1623185460131;
        Tue, 08 Jun 2021 13:51:00 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n11sm3008569ooo.12.2021.06.08.13.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 13:50:59 -0700 (PDT)
Received: (nullmailer pid 1556866 invoked by uid 1000);
        Tue, 08 Jun 2021 20:50:56 -0000
From:   Rob Herring <robh@kernel.org>
To:     Jon Lin <jon.lin@rock-chips.com>
Cc:     devicetree@vger.kernel.org, Chris Morgan <macromorgan@hotmail.com>,
        linux-arm-kernel@lists.infradead.org, p.yadav@ti.com,
        jbx6244@gmail.com, linux-kernel@vger.kernel.org, heiko@sntech.de,
        macroalpha82@gmail.com, sugar.zhang@rock-chips.com,
        hjc@rock-chips.com, linux-mtd@lists.infradead.org,
        robh+dt@kernel.org, linux-spi@vger.kernel.org, broonie@kernel.org,
        linux-rockchip@lists.infradead.org, yifeng.zhao@rock-chips.com
In-Reply-To: <20210608022644.21074-2-jon.lin@rock-chips.com>
References: <20210608022644.21074-1-jon.lin@rock-chips.com> <20210608022644.21074-2-jon.lin@rock-chips.com>
Subject: Re: [PATCH v6 1/8] dt-bindings: rockchip-sfc: Bindings for Rockchip serial flash controller
Date:   Tue, 08 Jun 2021 15:50:56 -0500
Message-Id: <1623185456.817255.1556865.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 08 Jun 2021 10:26:37 +0800, Jon Lin wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add bindings for the Rockchip serial flash controller. New device
> specific parameter of rockchip,sfc-no-dma included in documentation.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> Signed-off-by: Jon Lin <jon.lin@rock-chips.com>
> ---
> 
> Changes in v6:
> - Add support in device trees for rv1126(Declared in series 5 but not
>   submitted)
> - Change to use "clk_sfc" "hclk_sfc" as clock lable, since it does not
>   affect interpretation and has been widely used
> - Support sfc tx_dual, tx_quad(Declared in series 5 but not submitted)
> - Simplify the code, such as remove "rockchip_sfc_register_all"(Declared
>   in series 5 but not submitted)
> - Support SFC ver4 ver5(Declared in series 5 but not submitted)
> - Add author Chris Morgan and Jon Lin to spi-rockchip-sfc.c
> - Change to use devm_spi_alloc_master and spi_unregister_master
> 
> Changes in v5:
> - Add support in device trees for rv1126
> - Support sfc tx_dual, tx_quad
> - Simplify the code, such as remove "rockchip_sfc_register_all"
> - Support SFC ver4 ver5
> 
> Changes in v4:
> - Changing patch back to an "RFC". An engineer from Rockchip
>   reached out to me to let me know they are working on this patch for
>   upstream, I am submitting this v4 for the community to see however
>   I expect Jon Lin (jon.lin@rock-chips.com) will submit new patches
>   soon and these are the ones we should pursue for mainlining. Jon's
>   patch series should include support for more hardware than this
>   series.
> - Clean up documentation more and ensure it is correct per
>   make dt_binding_check.
> - Add support in device trees for rk3036, rk3308, and rv1108.
> - Add ahb clock (hclk_sfc) support for rk3036.
> - Change rockchip_sfc_wait_fifo_ready() to use a switch statement.
> - Change IRQ code to only mark IRQ as handled if it handles the
>   specific IRQ (DMA transfer finish) it is supposed to handle.
> 
> Changes in v3:
> - Changed the name of the clocks to sfc/ahb (from clk-sfc/clk-hsfc).
> - Changed the compatible string from rockchip,sfc to
>   rockchip,rk3036-sfc. A quick glance at the datasheets suggests this
>   driver should work for the PX30, RK180x, RK3036, RK312x, RK3308 and
>   RV1108 SoCs, and possibly more. However, I am currently only able
>   to test this on a PX30 (an RK3326). The technical reference manuals
>   appear to list the same registers for each device.
> - Corrected devicetree documentation for formatting and to note these
>   changes.
> - Replaced the maintainer with Heiko Stuebner and myself, as we will
>   take ownership of this going forward.
> - Noted that the device (per the reference manual) supports 4 CS, but
>   I am only able to test a single CS (CS 0).
> - Reordered patches to comply with upstream rules.
> 
> Changes in v2:
> - Reimplemented driver using spi-mem subsystem.
> - Removed power management code as I couldn't get it working properly.
> - Added device tree bindings for Odroid Go Advance.
> 
> Changes in v1:
> hanges made in this new series versus the v8 of the old series:
> - Added function to read spi-rx-bus-width from device tree, in the
>   event that the SPI chip supports 4x mode but only has 2 pins
>   wired (such as the Odroid Go Advance).
> - Changed device tree documentation from txt to yaml format.
> - Made "reset" message a dev_dbg from a dev_info.
> - Changed read and write fifo functions to remove redundant checks.
> - Changed the write and read from relaxed to non-relaxed when
>   starting the DMA transfer or reading the DMA IRQ.
> - Changed from dma_coerce_mask_and_coherent to just
>   dma_set_mask_and_coherent.
> - Changed name of get_if_type to rockchip_sfc_get_if_type.
> 
>  .../devicetree/bindings/spi/rockchip-sfc.yaml | 87 +++++++++++++++++++
>  1 file changed, 87 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/rockchip-sfc.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/rockchip-sfc.example.dt.yaml: spi@ff3a0000: clock-names:0: 'hclk_sfc' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/rockchip-sfc.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/rockchip-sfc.example.dt.yaml: spi@ff3a0000: clock-names:1: 'clk_sfc' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/rockchip-sfc.yaml
\ndoc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1489062

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

