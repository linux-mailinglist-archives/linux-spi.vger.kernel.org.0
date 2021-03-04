Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD8E32DB63
	for <lists+linux-spi@lfdr.de>; Thu,  4 Mar 2021 21:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237209AbhCDUs5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 4 Mar 2021 15:48:57 -0500
Received: from mail-ot1-f46.google.com ([209.85.210.46]:43146 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235648AbhCDUsc (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 4 Mar 2021 15:48:32 -0500
Received: by mail-ot1-f46.google.com with SMTP id v12so27544423ott.10;
        Thu, 04 Mar 2021 12:48:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=2OoGTJOyct6c2S8dv3hmx3zLqIL0twuJ2fEgd59m/TU=;
        b=VZwxrZ5bA/QdC0MS7WdX3QbMN4hfMXIkI1TDesxNvVMN9KMYmCs9WJ5ncBEJLb1ftw
         DzinOM30H/PZDFCU0sT/rnikrq1FimmdCG2kYyCVe1L34kg0TKlkKgo6d01bPu37R199
         VMfZ8Uy7Kjozo/YAhG276N7VE9L8D79n73nZpZYBd9GF3lXeDN+Bi/MtpOMXz2zIBnMn
         fDS3fJfOtlVorTkoX80VqrZqSYTy8Sk8395FIYmlJAaNU6aL8MsEl3Eeg79HIIgjfTHW
         9rpSjC10ZMBhQxWZQzCydSZYm9+LQy+GpTLvNETUN5JctwnGehOR7msuvRu1ypPTi3zO
         tokA==
X-Gm-Message-State: AOAM533Oc+d6wXDAKp/4x/uIDHq7TYldc31r18I1GJiUOJ6qNcbQenFB
        1c246niHGvmEYpJLQz4alg==
X-Google-Smtp-Source: ABdhPJzd3nJvYXZhRJFS+SMlJsLzkWd0UMzd0TMfhc3TUuc6jKDJCflKn9KZ8VetSGIqdeybqOJ9ew==
X-Received: by 2002:a9d:3422:: with SMTP id v31mr653634otb.260.1614890871544;
        Thu, 04 Mar 2021 12:47:51 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t4sm98452ooh.4.2021.03.04.12.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 12:47:50 -0800 (PST)
Received: (nullmailer pid 2778955 invoked by uid 1000);
        Thu, 04 Mar 2021 20:47:29 -0000
From:   Rob Herring <robh@kernel.org>
To:     Brad Larson <brad@pensando.io>
Cc:     arnd@arndb.de, linux-spi@vger.kernel.org,
        bgolaszewski@baylibre.com, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        broonie@kernel.org, olof@lixom.net, devicetree@vger.kernel.org,
        fancer.lancer@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org
In-Reply-To: <20210304034141.7062-8-brad@pensando.io>
References: <20210304034141.7062-1-brad@pensando.io> <20210304034141.7062-8-brad@pensando.io>
Subject: Re: [PATCH 7/8] arm64: dts: Add Pensando Elba SoC support
Date:   Thu, 04 Mar 2021 14:47:29 -0600
Message-Id: <1614890849.092166.2778954.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 03 Mar 2021 19:41:40 -0800, Brad Larson wrote:
> Add Pensando common and Elba SoC specific device nodes
> and corresponding binding documentation.
> 
> Signed-off-by: Brad Larson <brad@pensando.io>
> ---
>  .../bindings/gpio/pensando,elba-spics.txt     |  24 ++
>  .../devicetree/bindings/mmc/cdns,sdhci.yaml   |   2 +-
>  .../bindings/spi/cadence-quadspi.txt          |   1 +
>  .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
>  arch/arm64/boot/dts/Makefile                  |   1 +
>  arch/arm64/boot/dts/pensando/Makefile         |   6 +
>  arch/arm64/boot/dts/pensando/elba-16core.dtsi | 171 ++++++++++
>  .../boot/dts/pensando/elba-asic-common.dtsi   | 113 +++++++
>  arch/arm64/boot/dts/pensando/elba-asic.dts    |   8 +
>  .../boot/dts/pensando/elba-flash-parts.dtsi   |  80 +++++
>  arch/arm64/boot/dts/pensando/elba.dtsi        | 310 ++++++++++++++++++
>  11 files changed, 717 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/gpio/pensando,elba-spics.txt
>  create mode 100644 arch/arm64/boot/dts/pensando/Makefile
>  create mode 100644 arch/arm64/boot/dts/pensando/elba-16core.dtsi
>  create mode 100644 arch/arm64/boot/dts/pensando/elba-asic-common.dtsi
>  create mode 100644 arch/arm64/boot/dts/pensando/elba-asic.dts
>  create mode 100644 arch/arm64/boot/dts/pensando/elba-flash-parts.dtsi
>  create mode 100644 arch/arm64/boot/dts/pensando/elba.dtsi
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/cdns,sdhci.example.dt.yaml: mmc@5a000000: compatible: ['socionext,uniphier-sd4hc', 'cdns,sd4hc', 'pensando,elba-emmc'] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/cdns,sdhci.example.dt.yaml: mmc@5a000000: compatible: Additional items are not allowed ('pensando,elba-emmc' was unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml

See https://patchwork.ozlabs.org/patch/1447072

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

