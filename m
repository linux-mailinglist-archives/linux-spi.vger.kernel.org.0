Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 217F04BFAD8
	for <lists+linux-spi@lfdr.de>; Tue, 22 Feb 2022 15:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbiBVOXR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Feb 2022 09:23:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232812AbiBVOXP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 22 Feb 2022 09:23:15 -0500
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D44C6803;
        Tue, 22 Feb 2022 06:22:49 -0800 (PST)
Received: by mail-oi1-f173.google.com with SMTP id j24so12454281oii.11;
        Tue, 22 Feb 2022 06:22:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=rD5aOaysoX7AXKi/miKBCGc1jjVI4baaQQsU/wovaeg=;
        b=grhQNwLuK5G4B8GXFmif1k+mlFW3TwbAfEb2hoAsMSzmrh0q7p6rdhlzbRj+l3lK6K
         fMN+oYdQaOYL2RJobQHTm5jWT79UJLBxlrts75oBXoSnJILNTVyNRnBGjrArXWY7Mv58
         wuMDDVebwgIGmPbBwf2+OxnGASokXPhT1kO+2728MczJcwJT5UhrAr8deLLcsOtGi0RA
         Bkl0KLePGkH6Ip93cC3o0vSe/0n2o9MYnt+fkWWiEeQ+wUvnyCBNbdj4Un7K5dfxzWXj
         6h2WCMdvuzq2hH6mn3cuwrcQ9TPbynXGGG0uKNkpitBYT1W2DcMNxT0DlvzrnmSmA8ZX
         5YXg==
X-Gm-Message-State: AOAM531UqAZN2BRc3qiCCE+7Iw/vs79pBnXN30nwAhJ5AxKvvQhCM3kc
        beQTvVWS1yMY59XUpryUJg==
X-Google-Smtp-Source: ABdhPJwVon8hc/Aiatn3KQ49ftntGD1o45JbfKv8M5qfLueMW864329WvIdvFp+I4R2VvQVOUJgEtQ==
X-Received: by 2002:aca:2112:0:b0:2d4:653d:82b8 with SMTP id 18-20020aca2112000000b002d4653d82b8mr1921220oiz.126.1645539768672;
        Tue, 22 Feb 2022 06:22:48 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bf13sm7569801oib.32.2022.02.22.06.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 06:22:47 -0800 (PST)
Received: (nullmailer pid 3016156 invoked by uid 1000);
        Tue, 22 Feb 2022 14:22:43 -0000
From:   Rob Herring <robh@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        =?utf-8?q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Neil Armstrong <narmstrong@baylibre.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Brown <broonie@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
In-Reply-To: <39d61ddb-4b54-4a13-fbb2-c0f88d9bf017@gmail.com>
References: <1f39432b-84e2-e6dc-a6b8-c48ad5cf2210@gmail.com> <39d61ddb-4b54-4a13-fbb2-c0f88d9bf017@gmail.com>
Subject: Re: [PATCH v2 3/6] dt-bindings: auxdisplay: Add Titan Micro Electronics TM1628
Date:   Tue, 22 Feb 2022 08:22:43 -0600
Message-Id: <1645539763.080061.3016155.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,PP_MIME_FAKE_ASCII_TEXT,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 21 Feb 2022 21:23:18 +0100, Heiner Kallweit wrote:
> Add a YAML schema binding for TM1628 auxdisplay
> (7/11-segment LED) controller.
> 
> This patch is partially based on previous RFC work from
> Andreas Färber <afaerber@suse.de>.
> 
> Signed-off-by: Andreas Färber <afaerber@suse.de>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
> v2:
> - (re-)add Andreas' SoB
> - fix YAML errors reported by Rob
> ---
>  .../bindings/auxdisplay/titanmec,tm1628.yaml  | 88 +++++++++++++++++++
>  1 file changed, 88 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/auxdisplay/titanmec,tm1628.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/auxdisplay/titanmec,tm1628.example.dt.yaml: led-controller@0: 'spi-3-wire', 'spi-lsb-first', 'spi-max-frequency' do not match any of the regexes: '^.*@[1-7],([1-9]|1[0-6])$', 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/auxdisplay/titanmec,tm1628.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1595730

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

