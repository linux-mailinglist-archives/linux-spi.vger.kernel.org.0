Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB433A1AB8
	for <lists+linux-spi@lfdr.de>; Wed,  9 Jun 2021 18:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237342AbhFIQS5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 9 Jun 2021 12:18:57 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:33583 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbhFIQS4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 9 Jun 2021 12:18:56 -0400
Received: by mail-ot1-f45.google.com with SMTP id o17-20020a9d76510000b02903eabfc221a9so10740627otl.0;
        Wed, 09 Jun 2021 09:16:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=NYXHJI4Kx3eiwThUs5yqYYIde++NFf0oIszmROtqUoY=;
        b=KUSj5COIJnbmA1o7eaZpfgIuW6OOrCixID66tw20dzvl4NB36Vi3+tG2f9Se2cry5b
         Il6cM/N69bY4NbQB0FLscABz7MTPQZtSrVYz4IVfckefAgzrsKG4DMtcw2SlOUy00PRr
         8dv4QbWwwJq9hw4EWnEgvAGDezDRjtEiux0mDKeQabbj56CiBTYw4+7wkgxS13xne0AE
         /WMSzyM9FXoLrdLuiEgOFghx2tcY2RjuKNAkCsLT1nAjMR6ivyPG6J4mcWRzNxdBaSTy
         nXGfkE/C5MUzMEsDIfvCP2Mf6mlFJJTJ5xNce0kSCERT8sAxN0msw0p8ImBVEoWuKfDJ
         zqTw==
X-Gm-Message-State: AOAM531/DDNSz4WsY9JVx4JcOaco+rsLQ0eDcreQxG1j5qTZ3PKJR+ux
        6jOxKlRoqG9N2rgnoi/PoA==
X-Google-Smtp-Source: ABdhPJyyFLCSgdauyi4+TKqtKVi+eaXOEEd+HR/EHYo0r6k5qWvlaRPdV1iCq+OxSaL1ccGDwnDQbQ==
X-Received: by 2002:a9d:1b05:: with SMTP id l5mr141741otl.335.1623255406773;
        Wed, 09 Jun 2021 09:16:46 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id x31sm75149ota.24.2021.06.09.09.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 09:16:46 -0700 (PDT)
Received: (nullmailer pid 3763298 invoked by uid 1000);
        Wed, 09 Jun 2021 16:16:43 -0000
From:   Rob Herring <robh@kernel.org>
To:     Jon Lin <jon.lin@rock-chips.com>
Cc:     yifeng.zhao@rock-chips.com, sugar.zhang@rock-chips.com,
        hjc@rock-chips.com, mturquette@baylibre.com, robh+dt@kernel.org,
        linux-clk@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-mtd@lists.infradead.org,
        Chris Morgan <macromorgan@hotmail.com>, macroalpha82@gmail.com,
        p.yadav@ti.com, linux-spi@vger.kernel.org, jbx6244@gmail.com,
        heiko@sntech.de, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, sboyd@kernel.org, broonie@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210609140412.16058-2-jon.lin@rock-chips.com>
References: <20210609140412.16058-1-jon.lin@rock-chips.com> <20210609140412.16058-2-jon.lin@rock-chips.com>
Subject: Re: [PATCH v7 1/9] dt-bindings: rockchip-sfc: Bindings for Rockchip serial flash controller
Date:   Wed, 09 Jun 2021 11:16:43 -0500
Message-Id: <1623255403.626186.3763297.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 09 Jun 2021 22:04:04 +0800, Jon Lin wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add bindings for the Rockchip serial flash controller. New device
> specific parameter of rockchip,sfc-no-dma included in documentation.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> Signed-off-by: Jon Lin <jon.lin@rock-chips.com>
> ---
> 
> Changes in v7:
> - Fix up the sclk_sfc parent error in rk3036
> - Unify to "rockchip,sfc" compatible id because all the feature update
>   will have a new IP version, so the driver is used for the SFC IP in
>   all SoCs
> - Change to use node "sfc" to name the SFC pinctrl group
> - Add subnode reg property check
> - Add rockchip_sfc_adjust_op_size to workaround in CMD + DUMMY case
> - Limit max_iosize to 32KB
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
>  .../devicetree/bindings/spi/rockchip-sfc.yaml | 88 +++++++++++++++++++
>  1 file changed, 88 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/rockchip-sfc.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/spi/rockchip-sfc.yaml:45:5: [warning] wrong indentation: expected 2 but found 4 (indentation)

dtschema/dtc warnings/errors:
\ndoc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1489897

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

