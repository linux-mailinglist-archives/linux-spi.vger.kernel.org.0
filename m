Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 690594C4738
	for <lists+linux-spi@lfdr.de>; Fri, 25 Feb 2022 15:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241702AbiBYOQp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 25 Feb 2022 09:16:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241704AbiBYOQo (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 25 Feb 2022 09:16:44 -0500
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B2FC1FEFB3;
        Fri, 25 Feb 2022 06:16:12 -0800 (PST)
Received: by mail-oi1-f176.google.com with SMTP id p15so7566406oip.3;
        Fri, 25 Feb 2022 06:16:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=whxK/TXlb+DFYwGBGz/bUt/Sh+5/wa4c981iioKE+D0=;
        b=JlX9/l7kgmrt5oSqkPBfRLvyef3zkr1/RtpEK4ybPqHNXLFk9HYMeiAOgDH0MMdkwh
         v8+DtkbJ6SVsOFowY87UsQiMpynlP76JYcAK5PdjEf9CpS8arL7FzExqv5ShxxJLvcUX
         rk6Z3JWcm4eJnrGkH4VEIYXGYs1k+0hnIZLfqx1OD3BNyjj8yFiVwTBfCRQE3FKvLXQQ
         KEh1fXihuaCYGd2n2OYigA0ZsawyJ0ZuCx1kHN4KAp4za68qGY6uVfifgp+yXi7dXcAK
         L2E3l5H+a0qnvG8XFdGEv4l7gx+LdNLY/ypa5oIBNOHfDTxfq+s1TNfaOGXu1lKMGKM8
         eW2A==
X-Gm-Message-State: AOAM532FhPqHwc0erB/vv8Vv3HQpGk+y0JH+0Kq4oL3qFHDpFywE3/BC
        evnrPzqXVQFeMraLx0jkmMPg3I+Fdg==
X-Google-Smtp-Source: ABdhPJwu0SE8cZZ/r+xEfNz77uFx9+Ea20npSfAZTWUoKpnnuj7JRKXbD4QOrrf2Gmd4cq34qh5GqA==
X-Received: by 2002:a05:6808:1304:b0:2d5:4170:e084 with SMTP id y4-20020a056808130400b002d54170e084mr1581990oiv.19.1645798571598;
        Fri, 25 Feb 2022 06:16:11 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id be40-20020a05680821a800b002d06df28063sm1480818oib.5.2022.02.25.06.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 06:16:10 -0800 (PST)
Received: (nullmailer pid 857890 invoked by uid 1000);
        Fri, 25 Feb 2022 14:16:07 -0000
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Antipov <daantipov@gmail.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Rob Herring <robh+dt@kernel.org>, linux-spi@vger.kernel.org,
        Dmitry Antipov <dmanti@microsoft.com>,
        Felipe Balbi <balbi@kernel.org>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org
In-Reply-To: <20220225005936.3485405-4-dmanti@microsoft.com>
References: <20220225005936.3485405-1-dmanti@microsoft.com> <20220225005936.3485405-4-dmanti@microsoft.com>
Subject: Re: [PATCH v4 3/6] Documentation: DT bindings for Microsoft G6 Touch Digitizer
Date:   Fri, 25 Feb 2022 08:16:07 -0600
Message-Id: <1645798567.332089.857887.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 24 Feb 2022 16:59:33 -0800, Dmitry Antipov wrote:
> From: Dmitry Antipov <dmanti@microsoft.com>
> 
> Documentation describes the required and optional properties for
> implementing Device Tree for a Microsoft G6 Touch Digitizer that
> supports HID over SPI Protocol 1.0 specification.
> 
> Signed-off-by: Dmitry Antipov <dmanti@microsoft.com>
> ---
>  .../input/microsoft,g6-touch-digitizer.yaml   | 105 ++++++++++++++++++
>  1 file changed, 105 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/microsoft,g6-touch-digitizer.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/input/microsoft,g6-touch-digitizer.yaml:22:9: [warning] wrong indentation: expected 10 but found 8 (indentation)

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/input/microsoft,g6-touch-digitizer.example.dts:23.11-21: Warning (reg_format): /example-0/spi-hid-dev0:reg: property has invalid length (4 bytes) (#address-cells == 1, #size-cells == 1)
Documentation/devicetree/bindings/input/microsoft,g6-touch-digitizer.example.dts:21.22-37.11: Warning (unit_address_vs_reg): /example-0/spi-hid-dev0: node has a reg or ranges property, but no unit name
Documentation/devicetree/bindings/input/microsoft,g6-touch-digitizer.example.dt.yaml: Warning (pci_device_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/input/microsoft,g6-touch-digitizer.example.dt.yaml: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/input/microsoft,g6-touch-digitizer.example.dt.yaml: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/input/microsoft,g6-touch-digitizer.example.dt.yaml: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/input/microsoft,g6-touch-digitizer.example.dt.yaml: Warning (spi_bus_reg): Failed prerequisite 'reg_format'

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1597405

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

