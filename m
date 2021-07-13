Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF7F13C71C1
	for <lists+linux-spi@lfdr.de>; Tue, 13 Jul 2021 16:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236727AbhGMOGH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 13 Jul 2021 10:06:07 -0400
Received: from mail-il1-f171.google.com ([209.85.166.171]:34471 "EHLO
        mail-il1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236765AbhGMOGH (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 13 Jul 2021 10:06:07 -0400
Received: by mail-il1-f171.google.com with SMTP id e13so23300087ilc.1;
        Tue, 13 Jul 2021 07:03:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=sTck8MT1tcfpVCvL1kgsklddyUpTEtuVs7S3TVtOJY0=;
        b=SrDZNtvdgMPFw4Jye5GTBSnSBJawROP0DtP0nBwdtUEi0EglYqRLwyOU2EMVHQPmgG
         Tyl66RQAC6p7RubgAAvf5X4opK6ajIGRoeI1RaJ59nMSPjmgcoxMdVkeEAnPIubqfGSj
         fgEhck5wDsUoB9M+m9A9uCqb5QC8eTnIDvzD6tuAQqkRJpGMf2MJ7gEO/m5XdfK28q1V
         axRpdgtfC44xu0VrOpYLuQh05P2QMPlgshZ6dklY1DaUicZNbX/A0UxLTkTXbwBjwQMn
         G1pbVvAYRclKOUh6qV/27Qy5JoFo9Zbh7JJWGtHoIilIueAhWNqqwxpWoMkYgi5TuWuh
         HCLQ==
X-Gm-Message-State: AOAM532ZQJgNMniMtvKOuXRFNlJv4vsWUHgpXrLaKOMQvLjlJFzGeDAU
        6PtTnfYQrxG8ZkbAdDNZvA==
X-Google-Smtp-Source: ABdhPJzrE0TMePTKV6hzrsV09nnwJnBTynrp9bH4nZNdyfgGXyIW71KBdOIQERmDZOb82by5hSyJTA==
X-Received: by 2002:a92:d10:: with SMTP id 16mr3000342iln.189.1626184997191;
        Tue, 13 Jul 2021 07:03:17 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id f3sm719146iob.30.2021.07.13.07.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 07:03:16 -0700 (PDT)
Received: (nullmailer pid 129710 invoked by uid 1000);
        Tue, 13 Jul 2021 14:03:13 -0000
From:   Rob Herring <robh@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Sascha Hauer <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        kernel@collabora.com, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ian Ray <ian.ray@ge.com>, Rob Herring <robh+dt@kernel.org>,
        linux-spi@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        Mark Brown <broonie@kernel.org>
In-Reply-To: <20210712150242.146545-2-sebastian.reichel@collabora.com>
References: <20210712150242.146545-1-sebastian.reichel@collabora.com> <20210712150242.146545-2-sebastian.reichel@collabora.com>
Subject: Re: [PATCHv6 1/3] dt-bindings: misc: ge-achc: Convert to DT schema format
Date:   Tue, 13 Jul 2021 08:03:13 -0600
Message-Id: <1626184993.653258.129709.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 12 Jul 2021 17:02:40 +0200, Sebastian Reichel wrote:
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
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  .../devicetree/bindings/misc/ge-achc.txt      | 26 --------
>  .../devicetree/bindings/misc/ge-achc.yaml     | 65 +++++++++++++++++++
>  2 files changed, 65 insertions(+), 26 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/misc/ge-achc.txt
>  create mode 100644 Documentation/devicetree/bindings/misc/ge-achc.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/misc/ge-achc.example.dt.yaml: spi: spi@1:reg: [[1], [0]] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/misc/ge-achc.example.dt.yaml: spi: spi@1:reg: Additional items are not allowed ([0] was unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
\ndoc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1504037

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

