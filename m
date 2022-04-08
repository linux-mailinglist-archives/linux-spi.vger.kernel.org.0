Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 791274F8AAD
	for <lists+linux-spi@lfdr.de>; Fri,  8 Apr 2022 02:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232944AbiDHAcx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 7 Apr 2022 20:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232174AbiDHAcw (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 7 Apr 2022 20:32:52 -0400
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE05429F11A;
        Thu,  7 Apr 2022 17:30:50 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-d6e29fb3d7so8172178fac.7;
        Thu, 07 Apr 2022 17:30:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=W70F/zd2AKch386n29+TKgnYuWJ1dPUuzRF3aXkzTdw=;
        b=fFKOEndy7Ln5agkPC4XFZoNfgDqQbp2yoUL3N8MqfVEfb2BOTC6v2XpKZeDyL5SEO3
         CiU39HDryUSfa1mwqS0QvM+T9lc/rbaiDtcHLWm7wU3BDQeAMPpUfWpQjICrT2fy0vLl
         4kl996yLvN1+wZ97fo7THLWpI+Kw+PjpWTPM2rvNk7rCPJop9Ke4Ts2j+hmciv7rJrtB
         6lguvJnbrF4fUKbxwGz82D8o9l/RgPjYtxkpT9w9Ta9f+RA35F3WkRsmfDISz53iLSSU
         JNFKwICX4oTMEZut5T/qbZHhk1eeEuCl6wwqXlfGPMHfg/m/OVsm+ztc/4cV/hycZUqt
         nIpQ==
X-Gm-Message-State: AOAM532vXUtPe3Ez2lm5CAoZHRMIPVr2jqqpVNzrIS3C39ahIfYsyU5J
        oMhNx2sJRfAFtFYWRhxNpqEt8Tl3YA==
X-Google-Smtp-Source: ABdhPJyh0KtpubbGQRl0vMSxyBRMX5cXuTTcgR9gbNVftxyA3x9smxRykHIUBImThHKPQ9vZmgat8w==
X-Received: by 2002:a05:6870:d154:b0:e2:8d2f:b725 with SMTP id f20-20020a056870d15400b000e28d2fb725mr47677oac.56.1649377849962;
        Thu, 07 Apr 2022 17:30:49 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l33-20020a0568302b2100b005cdad9100desm8818369otv.40.2022.04.07.17.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 17:30:49 -0700 (PDT)
Received: (nullmailer pid 2311421 invoked by uid 1000);
        Fri, 08 Apr 2022 00:30:48 -0000
From:   Rob Herring <robh@kernel.org>
To:     Marek Vasut <marex@denx.de>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org
In-Reply-To: <20220407194936.223041-1-marex@denx.de>
References: <20220407194936.223041-1-marex@denx.de>
Subject: Re: [PATCH] dt-bindings: spi: Add YAML DT binding document for trivial devices
Date:   Thu, 07 Apr 2022 19:30:48 -0500
Message-Id: <1649377848.893085.2311420.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 07 Apr 2022 21:49:36 +0200, Marek Vasut wrote:
> Document trivial SPI devices in single YAML DT binding document.
> Currently this overlaps Linux kernel spidev.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> To: linux-spi@vger.kernel.org
> ---
>  .../devicetree/bindings/spi/trivial.yaml      | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/trivial.yaml
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/


/: '#address-cells', '#size-cells', 'aliases', 'chosen', 'cpus', 'fxosc', 'iio-hwmon', 'leds', 'memory@80000000', 'model', 'oscillator-audio', 'oscillator-ethernet', 'regulator-3p3v', 'regulator-vcc3v3mcu', 'soc', 'spi-gpio', 'sxosc', 'syscon-reboot' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/vf610-bk4.dtb

channel@0: '#address-cells', '#size-cells', 'spi-cpha' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/am335x-sancloud-bbe-lite.dtb

/: compatible: ['lwn,bk4', 'fsl,vf610'] is too long
	arch/arm/boot/dts/vf610-bk4.dtb

dac@0: 'spi-cpha', 'spi-cpol' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/rv1108-elgin-r1.dtb

/: 'reg' is a required property
	arch/arm/boot/dts/vf610-bk4.dtb

slave: 'reg' is a required property
	arch/arm/boot/dts/vf610-bk4.dtb

spidev0@0: 'fsl,spi-cs-sck-delay', 'fsl,spi-sck-cs-delay' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/vf610-bk4.dtb

