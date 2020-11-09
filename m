Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F19402ABFE6
	for <lists+linux-spi@lfdr.de>; Mon,  9 Nov 2020 16:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730157AbgKIPcq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Nov 2020 10:32:46 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36253 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729289AbgKIPcq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 Nov 2020 10:32:46 -0500
Received: by mail-ot1-f65.google.com with SMTP id 32so9306386otm.3;
        Mon, 09 Nov 2020 07:32:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Tw75G9a7V25EA3GXaIvjRHeBvH+Ysq7ymdHrpXMTU6I=;
        b=XGPiMTM3wTxSsPrKcDgMfVVKQMJAr6xBuL1XCgkUi/Luou0UnxD/6vqd2wKOChOm4z
         iIQMNrnvSw8YF0VVVGa3PbDmGnL4fHeBhtiFBX16yvkKeMqF1XASHKQJz9eqWL9e0epc
         JOoEHKFOBPmMbzmm2FS2yP5QHGCk1xABMFqnZxDsnTuoUuks4ROdgDSWtEH1U7Xfn+Rn
         zZWHz6tx32hTUWll26vgFPKnwQ3yhiG+LNDshPkh4IJlCsKndMKO+MXjuagRJYffwpU6
         A5lc6h54yZm5kq2yi0iBQzELj+oNcP13G57iOAW+kpas+xvNT9VXhB9mOMECAcYLmQBH
         0PSQ==
X-Gm-Message-State: AOAM5335/50LDQjscUcIYWI904a3h3MZLw5nVxwzwZZAlwBuzqJd9b6a
        MnF4mmYq343b7JlL49Sf8w==
X-Google-Smtp-Source: ABdhPJwRiGrW+JjelyJhHBUlKu/+vl1LLGAK0xrUOMfZH4tQcVRAHs7VgoszCBsOt+we9xJQtMI+Tg==
X-Received: by 2002:a9d:f67:: with SMTP id 94mr11068345ott.282.1604935965006;
        Mon, 09 Nov 2020 07:32:45 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e15sm1135751otj.43.2020.11.09.07.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 07:32:44 -0800 (PST)
Received: (nullmailer pid 1330824 invoked by uid 1000);
        Mon, 09 Nov 2020 15:32:43 -0000
Date:   Mon, 9 Nov 2020 09:32:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-spi@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-gpio@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
        Serge Semin <fancer.lancer@gmail.com>,
        Sean Anderson <seanga2@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 24/32] dt-bindings: Document kendryte,k210-fpioa bindings
Message-ID: <20201109153243.GA1330401@bogus>
References: <20201107081420.60325-1-damien.lemoal@wdc.com>
 <20201107081420.60325-25-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201107081420.60325-25-damien.lemoal@wdc.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, 07 Nov 2020 17:14:12 +0900, Damien Le Moal wrote:
> Document the device tree bindings for the Kendryte K210 SoC Fully
> Programmable IO Array (FPIOA) pinctrl driver in
> Documentation/devicetree/bindings/pinctrl/kendryte,k210-fpioa.yaml
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> ---
>  .../bindings/pinctrl/kendryte,k210-fpioa.yaml | 106 ++++++++++++++++++
>  1 file changed, 106 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/kendryte,k210-fpioa.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pinctrl/kendryte,k210-fpioa.yaml: properties:clocks:minItems: False schema does not allow 2
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pinctrl/kendryte,k210-fpioa.yaml: properties:clocks:maxItems: False schema does not allow 2
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pinctrl/kendryte,k210-fpioa.yaml: properties:clock-names:minItems: False schema does not allow 2
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pinctrl/kendryte,k210-fpioa.yaml: properties:clock-names:maxItems: False schema does not allow 2
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pinctrl/kendryte,k210-fpioa.yaml: ignoring, error in schema: properties: clocks: minItems
warning: no schema found in file: ./Documentation/devicetree/bindings/pinctrl/kendryte,k210-fpioa.yaml
Documentation/devicetree/bindings/pinctrl/kendryte,k210-fpioa.example.dts:19:18: fatal error: dt-bindings/pinctrl/k210-pinctrl.h: No such file or directory
   19 |         #include <dt-bindings/pinctrl/k210-pinctrl.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [scripts/Makefile.lib:342: Documentation/devicetree/bindings/pinctrl/kendryte,k210-fpioa.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1364: dt_binding_check] Error 2


See https://patchwork.ozlabs.org/patch/1396081

The base for the patch is generally the last rc1. Any dependencies
should be noted.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

