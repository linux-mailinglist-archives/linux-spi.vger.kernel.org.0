Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCE663FED66
	for <lists+linux-spi@lfdr.de>; Thu,  2 Sep 2021 14:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344017AbhIBMFC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 2 Sep 2021 08:05:02 -0400
Received: from mail-oi1-f181.google.com ([209.85.167.181]:42548 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344009AbhIBMFB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 2 Sep 2021 08:05:01 -0400
Received: by mail-oi1-f181.google.com with SMTP id bi4so2175573oib.9;
        Thu, 02 Sep 2021 05:04:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=BUqaoDHq1kYFFgkimw5x11z+/dNmgaH0b/piYmufZsc=;
        b=ONnHFr23J9Mb0NCyELQ9ukDFrIP+M4mf6BqmI41R1D+UgovQt2rcYIQbdOD5QXStbF
         Xe8AGLPQSmIRyRaATqzDoy1dpTADHL2AvAWWKMYgmkxWKWnGWNDaiyBacySlJEnGunEB
         koDORoxWSduWfViKDq49NHm4rZvhEfqND7QzPrG6BLlR9q602JH6cI7O+wkTKOks2irZ
         /JNPQyXjddcyCnRvBa8FhlCnn/kvwSgS/79tvJ1IXiuD18UBo5cZsGYiZQWf50pFONhK
         c5hXT5pL6eQpun7HjTtV16jG4g7O9awbuhiOZ8s3SdT94czvDx3eIN+56hR/ql/+MOPq
         VJKw==
X-Gm-Message-State: AOAM530RHZBXlgfeoPiFH5eKCCwhC/Ge7dq7g6WVKhYATTSuWBF1CSc5
        3Ikpjj5EBQsz2pjk0BeFlw==
X-Google-Smtp-Source: ABdhPJzZjPOnSEHSOOdDAwed/sSzwFVLOD22JH0MBNpNoffHUul1Kchpby31Nq0NZJa/G9emURVtpw==
X-Received: by 2002:aca:220a:: with SMTP id b10mr1859658oic.101.1630584242534;
        Thu, 02 Sep 2021 05:04:02 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id b25sm338667ooq.6.2021.09.02.05.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 05:04:01 -0700 (PDT)
Received: (nullmailer pid 685601 invoked by uid 1000);
        Thu, 02 Sep 2021 12:03:59 -0000
From:   Rob Herring <robh@kernel.org>
To:     Parshuram Thombare <pthombar@cadence.com>
Cc:     p.yadav@ti.com, devicetree@vger.kernel.org,
        Konrad Kociolek <konrad@cadence.com>,
        linux-spi@vger.kernel.org, broonie@kernel.org, jpawar@cadence.com,
        lukas@wunner.de, robh+dt@kernel.org, mparab@cadence.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <1630499829-20059-1-git-send-email-pthombar@cadence.com>
References: <1630499755-18751-1-git-send-email-pthombar@cadence.com> <1630499829-20059-1-git-send-email-pthombar@cadence.com>
Subject: Re: [PATCH v3 1/2] spi: cadence: add dt-bindings documentation for Cadence XSPI controller
Date:   Thu, 02 Sep 2021 07:03:59 -0500
Message-Id: <1630584239.096691.685600.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 01 Sep 2021 14:37:09 +0200, Parshuram Thombare wrote:
> Add DT binding for Cadence's XSPI controller driver.
> 
> Signed-off-by: Konrad Kociolek <konrad@cadence.com>
> Signed-off-by: Jayshri Pawar <jpawar@cadence.com>
> Signed-off-by: Parshuram Thombare <pthombar@cadence.com>
> ---
>  .../devicetree/bindings/spi/cdns,xspi.yaml         | 66 ++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/cdns,xspi.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/cdns,xspi.yaml: 'additionalProperties' is a required property
	hint: A schema without a "$ref" to another schema must define all properties and use "additionalProperties"
	from schema $id: http://devicetree.org/meta-schemas/base.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/cdns,xspi.yaml: ignoring, error in schema: 
warning: no schema found in file: ./Documentation/devicetree/bindings/spi/cdns,xspi.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/cdns,xspi.example.dt.yaml: example-0: spi@a0010000:reg:0: [0, 2684420096, 0, 65536] is too long
	From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/reg.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/cdns,xspi.example.dt.yaml: example-0: spi@a0010000:reg:1: [0, 2952790016, 0, 65536] is too long
	From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/reg.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/cdns,xspi.example.dt.yaml: example-0: spi@a0010000:reg:2: [0, 2684485632, 0, 65536] is too long
	From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/reg.yaml
Documentation/devicetree/bindings/spi/cdns,xspi.example.dt.yaml:0:0: /example-0/spi@a0010000: failed to match any schema with compatible: ['cdns,xspi-nor']
Documentation/devicetree/bindings/spi/cdns,xspi.example.dt.yaml:0:0: /example-0/spi@a0010000/mt35xu512@0: failed to match any schema with compatible: ['spi-nor', 'micron,mt35xu512']
Documentation/devicetree/bindings/spi/cdns,xspi.example.dt.yaml:0:0: /example-0/spi@a0010000/mt35xu512@0: failed to match any schema with compatible: ['spi-nor', 'micron,mt35xu512']
Documentation/devicetree/bindings/spi/cdns,xspi.example.dt.yaml:0:0: /example-0/spi@a0010000/mt35xu512@1: failed to match any schema with compatible: ['spi-nor', 'micron,mt35xu512']
Documentation/devicetree/bindings/spi/cdns,xspi.example.dt.yaml:0:0: /example-0/spi@a0010000/mt35xu512@1: failed to match any schema with compatible: ['spi-nor', 'micron,mt35xu512']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1523137

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

