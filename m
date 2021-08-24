Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 719513F6655
	for <lists+linux-spi@lfdr.de>; Tue, 24 Aug 2021 19:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240233AbhHXRWp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 24 Aug 2021 13:22:45 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:34782 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236192AbhHXRUo (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 24 Aug 2021 13:20:44 -0400
Received: by mail-ot1-f53.google.com with SMTP id k12-20020a056830150c00b0051abe7f680bso42972036otp.1;
        Tue, 24 Aug 2021 10:19:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VNcuv0HqBUSJ/AboskcrVII1u6Cg/7GBIg74AqxzSDA=;
        b=aRmgP13Ez3dvZYjywPm0BjMtAe6nvyWW2IL64UqSgMBb/QEF+phgXkVEX5m3LvQVBA
         KjhcytmxUo5iGjhLy03HFKAtOsJ2CCF9sy3u6ZA7EzbYIL3NOEtkOeeHR3c8IhhII3Ci
         /wTCuXL+TqkqWsZSyRK/G7+L1MBWi+XZFTtA1qOiQ8QDV3nIuOXV/cKPBHlBf1VviOhD
         9U099VFge3ggOfR1TPX8zWgiabr0df6IDJiKe+jTQZFwxO9LDd7HPfmqtRAHp1r2Wgcv
         n/HX6CNnOSbTksJcCvIzl5VmBhC02DBXVV4PkvHTLpHvfweoeNOfzhe0uIDi0PG+yggc
         UJ3g==
X-Gm-Message-State: AOAM5301h0HUTS+MWjOTCFbsuI0l8hInPbw8XFRDQatqC5oSB7cao6pP
        CfFG2/O/VpmWpi7N4iC0Ehvz05oTRw==
X-Google-Smtp-Source: ABdhPJzBkwBpMgX9rEjwIv9ZCvRgSwnxW0Hor7k/ODRN4iOCh25hDZc6L+2YbhxQefHk7yWhzuNHKA==
X-Received: by 2002:aca:33d7:: with SMTP id z206mr3588120oiz.82.1629825599271;
        Tue, 24 Aug 2021 10:19:59 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id x3sm4087999ooe.32.2021.08.24.10.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 10:19:58 -0700 (PDT)
Received: (nullmailer pid 659131 invoked by uid 1000);
        Tue, 24 Aug 2021 17:19:57 -0000
Date:   Tue, 24 Aug 2021 12:19:57 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Luting Guo <luting.guo@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] dt-bindings: spi: Convert sprd ADI bindings to yaml
Message-ID: <YSUqPTr+aNLpjsj+@robh.at.kernel.org>
References: <20210824092745.2093640-1-zhang.lyra@gmail.com>
 <20210824092745.2093640-3-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210824092745.2093640-3-zhang.lyra@gmail.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Aug 24, 2021 at 05:27:44PM +0800, Chunyan Zhang wrote:
> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> 
> Convert spi-sprd-adi.txt to yaml.
> 
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> ---
>  .../devicetree/bindings/spi/spi-sprd-adi.txt  | 63 ------------
>  .../devicetree/bindings/spi/sprd,spi-adi.yaml | 99 +++++++++++++++++++
>  2 files changed, 99 insertions(+), 63 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/spi/spi-sprd-adi.txt
>  create mode 100644 Documentation/devicetree/bindings/spi/sprd,spi-adi.yaml

[...]

> diff --git a/Documentation/devicetree/bindings/spi/sprd,spi-adi.yaml b/Documentation/devicetree/bindings/spi/sprd,spi-adi.yaml
> new file mode 100644
> index 000000000000..f464fb6033f9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/sprd,spi-adi.yaml
> @@ -0,0 +1,99 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/spi/sprd,spi-adi.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Spreadtrum ADI controller
> +
> +maintainers:
> +  - Orson Zhai <orsonzhai@gmail.com>
> +  - Baolin Wang <baolin.wang7@gmail.com>
> +  - Chunyan Zhang <zhang.lyra@gmail.com>
> +
> +description: |
> +  ADI is the abbreviation of Anolog-Digital interface, which is used to access
> +  analog chip (such as PMIC) from digital chip. ADI controller follows the SPI
> +  framework for its hardware implementation is alike to SPI bus and its timing
> +  is compatile to SPI timing.
> +
> +  ADI controller has 50 channels including 2 software read/write channels and
> +  48 hardware channels to access analog chip. For 2 software read/write channels,
> +  users should set ADI registers to access analog chip. For hardware channels,
> +  we can configure them to allow other hardware components to use it independently,
> +  which means we can just link one analog chip address to one hardware channel,
> +  then users can access the mapped analog chip address by this hardware channel
> +  triggered by hardware components instead of ADI software channels.
> +
> +  Thus we introduce one property named "sprd,hw-channels" to configure hardware
> +  channels, the first value specifies the hardware channel id which is used to
> +  transfer data triggered by hardware automatically, and the second value specifies
> +  the analog chip address where user want to access by hardware components.
> +
> +  Since we have multi-subsystems will use unique ADI to access analog chip, when
> +  one system is reading/writing data by ADI software channels, that should be under
> +  one hardware spinlock protection to prevent other systems from reading/writing
> +  data by ADI software channels at the same time, or two parallel routine of setting
> +  ADI registers will make ADI controller registers chaos to lead incorrect results.
> +  Then we need one hardware spinlock to synchronize between the multiple subsystems.
> +
> +  The new version ADI controller supplies multiple master channels for different
> +  subsystem accessing, that means no need to add hardware spinlock to synchronize,
> +  thus change the hardware spinlock support to be optional to keep backward
> +  compatibility.
> +
> +allOf:
> +  - $ref: /spi/spi-controller.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - sprd,sc9860-adi
> +
> +  reg:
> +    maxItems: 1
> +
> +  hwlocks:
> +    description: Reference to a phandle of a hwlock provider node.

Drop, and add 'maxItems: 1'.

> +
> +  hwlock-names:
> +    description: |
> +      Reference to hwlock name strings defined in the same order
> +      as the hwlocks, should be "adi".

Should be a schema. So drop and add:

const: adi

> +
> +  sprd,hw-channels:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    maxItems: 1

This means 1 uint32.

> +    description: |
> +      This is an array of channel values up to 49 channels.

But this implies 49 entries.

> +      The first value specifies the hardware channel id which is used to
> +      transfer data triggered by hardware automatically, and the second
> +      value specifies the analog chip address where user want to access
> +      by hardware components.

Or 49x2 and that's a uint32-matrix given it's pairs of values. That 
should look something like this:

minItems: 1
maxItems: 49
items:
  items:
    - description: the hardware channel id...
      minimum: ??
      maximum: ?? (range of channel ids?)
    - description: the analog chip address where user want to access...

Rob
