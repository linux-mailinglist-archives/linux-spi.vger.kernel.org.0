Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C53232812E
	for <lists+linux-spi@lfdr.de>; Mon,  1 Mar 2021 15:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236508AbhCAOpH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 1 Mar 2021 09:45:07 -0500
Received: from mail-ot1-f43.google.com ([209.85.210.43]:45772 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236497AbhCAOpG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 1 Mar 2021 09:45:06 -0500
Received: by mail-ot1-f43.google.com with SMTP id d9so16610291ote.12;
        Mon, 01 Mar 2021 06:44:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=n+0MRcMClqJTsWrqj7q8LaJFXf/RAofYD+19AKoxa9k=;
        b=siTM3F1Pc+BwWqlPBSn5muFLzB1ijqmQvU3Sn0RGImfzPDKDIbeYlrvydLKzxhIwAX
         4NlqMM6DDAH9NBOVIy2clROMcRrvFD5nTAaX0EYc/NmLQcnwJO9LkU3+BPz0LCDxlfcv
         3MOSeLgHUhbQ+SzMa1hThISQLgx63770/QcHg9TANhB5aQGxgujlpHjyPgLjR7qXj04F
         4aEkS/LYS0dQvnXixoOe4i+dWd/9zyBG8zQWcGq8VEZJ2GkJkvEuw1Q77tvn3hj4lU+Z
         fmP6W/k3jJ6rTOxLcXrIS7tk703P3GvItpVvEq6VLOHbQtrBoH7q5z4PI5HM6+HId5jE
         GITQ==
X-Gm-Message-State: AOAM533TxNhSjcbobA1CobcFXnZnfRARgXLUcpj18n+srjC+ahEgFpQR
        26jlL2S1G7oh+2Evte79hAa3w1cx2A==
X-Google-Smtp-Source: ABdhPJw3jjWkOsGOY59hbdzMvTj3pbAFkeKJLNy80BCa5WC9ZAQ/y8+VIkj4i1SdIGQi6uhwlE8w2A==
X-Received: by 2002:a05:6830:4129:: with SMTP id w41mr13999061ott.332.1614609865079;
        Mon, 01 Mar 2021 06:44:25 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h38sm3680265oth.53.2021.03.01.06.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 06:44:24 -0800 (PST)
Received: (nullmailer pid 37864 invoked by uid 1000);
        Mon, 01 Mar 2021 14:44:21 -0000
From:   Rob Herring <robh@kernel.org>
To:     Kuldeep Singh <kuldeep.singh@nxp.com>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Ashish Kumar <ashish.kumar@nxp.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
In-Reply-To: <1614593046-23832-1-git-send-email-kuldeep.singh@nxp.com>
References: <1614593046-23832-1-git-send-email-kuldeep.singh@nxp.com>
Subject: Re: [PATCH] dt-bindings: spi: Convert NXP flexspi to json schema
Date:   Mon, 01 Mar 2021 08:44:21 -0600
Message-Id: <1614609861.083844.37863.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 01 Mar 2021 15:34:06 +0530, Kuldeep Singh wrote:
> Convert the NXP FlexSPI binding to DT schema format using json-schema.
> Also, update MAINTAINERS to reflect the change.
> 
> Signed-off-by: Kuldeep Singh <kuldeep.singh@nxp.com>
> ---
>  .../bindings/spi/nxp,spi-nxp-fspi.yaml        | 101 ++++++++++++++++++
>  .../devicetree/bindings/spi/spi-nxp-fspi.txt  |  42 --------
>  MAINTAINERS                                   |   2 +-
>  3 files changed, 102 insertions(+), 43 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/spi/nxp,spi-nxp-fspi.yaml
>  delete mode 100644 Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/nxp,spi-nxp-fspi.yaml: properties:clocks:maxItems: False schema does not allow 2
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/nxp,spi-nxp-fspi.yaml: ignoring, error in schema: properties: clocks: maxItems
warning: no schema found in file: ./Documentation/devicetree/bindings/spi/nxp,spi-nxp-fspi.yaml
Error: Documentation/devicetree/bindings/spi/nxp,spi-nxp-fspi.example.dts:26.31-32 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:349: Documentation/devicetree/bindings/spi/nxp,spi-nxp-fspi.example.dt.yaml] Error 1
make: *** [Makefile:1380: dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1445509

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

