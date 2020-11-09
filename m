Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 377AD2ABFF1
	for <lists+linux-spi@lfdr.de>; Mon,  9 Nov 2020 16:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730769AbgKIPhK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Nov 2020 10:37:10 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35907 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbgKIPhK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 Nov 2020 10:37:10 -0500
Received: by mail-oi1-f196.google.com with SMTP id d9so10623333oib.3;
        Mon, 09 Nov 2020 07:37:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5slTwVhSNDVMLD7tCbB4PGMpIyRmJcLd067yqXtkj+g=;
        b=bzA4C/5IVQhI3hl8r9nc3BFOJOuTpE3Ehkt0fXi0Q8xCGds/CEgPVPZCIpzo+PecGY
         esiQh4aUzD6Ukm39HiMh3dHeRKiT78SWoDr01f0XWy1lj0CSd6ZW9tAZRecgM7bEECLw
         OC8Hwl8ZjAJeg7ZEm/pcnXq0FqHpI2Qhv/YDNUleaFKq5WAEvBLaLoCqBmfr/2lTxhIy
         oKFIstwRa11cL0nxCTu5mW7kmivLOF7z6C7bGeRj9po/3RHFbmwr8Dvz9ofdYF+h7Uhp
         Ht9yqjEI+R9pldS2y5ddSEoB6+DvyVBIrg9jzTIeA8AIZVbZI67N6ZD+wJl3ODf6eDp0
         NPHQ==
X-Gm-Message-State: AOAM530XJsOX275vdMOmVb8LkHenEzGDNmtIylAdtCnNu4BeeSE3Emn3
        8YlGVJpdq1o52SqSBLxwuQ==
X-Google-Smtp-Source: ABdhPJxHInpvbaRcnyGlAnIy6yItKltYP3NNIO8viuEKZcwftEcK3bqtQnCT3XfuHU1Tvf3tE0/A/A==
X-Received: by 2002:aca:4e02:: with SMTP id c2mr9607216oib.97.1604936227723;
        Mon, 09 Nov 2020 07:37:07 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w18sm2582679otl.38.2020.11.09.07.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 07:37:07 -0800 (PST)
Received: (nullmailer pid 1335757 invoked by uid 1000);
        Mon, 09 Nov 2020 15:37:05 -0000
Date:   Mon, 9 Nov 2020 09:37:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Serge Semin <fancer.lancer@gmail.com>,
        Sean Anderson <seanga2@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Frank Rowand <frowand.list@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, linux-clk@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-gpio@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-spi@vger.kernel.org
Subject: Re: [PATCH 25/32] dt-bindings: Document kendryte,k210-rst bindings
Message-ID: <20201109153705.GA1335181@bogus>
References: <20201107081420.60325-1-damien.lemoal@wdc.com>
 <20201107081420.60325-26-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201107081420.60325-26-damien.lemoal@wdc.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, 07 Nov 2020 17:14:13 +0900, Damien Le Moal wrote:
> Document the device tree bindings for the Kendryte K210 SoC reset
> controller driver in
> Documentation/devicetree/bindings/reset/kendryte,k210-rst.yaml.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> ---
>  .../bindings/reset/kendryte,k210-rst.yaml     | 78 +++++++++++++++++++
>  1 file changed, 78 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/kendryte,k210-rst.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/reset/kendryte,k210-rst.yaml:24:9: [warning] wrong indentation: expected 10 but found 8 (indentation)

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/reset/kendryte,k210-rst.example.dts:19:18: fatal error: dt-bindings/mfd/k210-sysctl.h: No such file or directory
   19 |         #include <dt-bindings/mfd/k210-sysctl.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [scripts/Makefile.lib:342: Documentation/devicetree/bindings/reset/kendryte,k210-rst.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1364: dt_binding_check] Error 2


See https://patchwork.ozlabs.org/patch/1396082

The base for the patch is generally the last rc1. Any dependencies
should be noted.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

