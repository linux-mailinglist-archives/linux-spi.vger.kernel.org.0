Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0690A4BD3E4
	for <lists+linux-spi@lfdr.de>; Mon, 21 Feb 2022 03:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343902AbiBUCgl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 20 Feb 2022 21:36:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343889AbiBUCgh (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 20 Feb 2022 21:36:37 -0500
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 951AF3CA63;
        Sun, 20 Feb 2022 18:36:15 -0800 (PST)
Received: by mail-io1-f50.google.com with SMTP id f14so6653700ioz.1;
        Sun, 20 Feb 2022 18:36:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=2mmcZ0qMjEAikcQvpd5iCmfuIKx/lTLKOc0r1rxTap0=;
        b=WyGupXuGl32WrOJXjrldHA5BFSTUzI7Dxr/2vaa7xKRYn/j0ihjpPsZ3AzL79/xkj7
         L3zEtiqIMmUN1K7eEB0J78dvBP7Ve93ErCPm8aEWZlyMhY9iG8WKEKYu50qCVxlWFCFr
         eFolumqPYgnM1i8g23UqedtnbYr3pzUceT0hiwEgCZ1bFE/fh/hsCDySVhExJ/4QJMZI
         3nLq1u16QV0pflExpWpKRv6ggPgFo31YhntNtyJC/OMI0y1zsQxfGmXXTA4Shyo1l7Dl
         KbajTD+2pBXl674MNgOY33T5pOM9b8sSKeFfrfz3/HcpCCIZgPRw/geg0q42IC/SkC5V
         h2/w==
X-Gm-Message-State: AOAM531NX97pGaQsOOKrpMgnTkz0W30alsXiglXZ60MCTGM0CAiNu3+S
        HqnEjhyrjfHXS5SLWAlIYg==
X-Google-Smtp-Source: ABdhPJypQDHWIJkGf/quhqIersUuQk4DFD1V7BeSFJIZUMfyu9Yn9GnRxz+LJKy432+3svAi+vLRjQ==
X-Received: by 2002:a02:c98b:0:b0:310:f631:dcf8 with SMTP id b11-20020a02c98b000000b00310f631dcf8mr13779004jap.125.1645410974796;
        Sun, 20 Feb 2022 18:36:14 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id s15sm1654358ilq.66.2022.02.20.18.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 18:36:14 -0800 (PST)
Received: (nullmailer pid 2041545 invoked by uid 1000);
        Mon, 21 Feb 2022 02:36:09 -0000
From:   Rob Herring <robh@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        =?utf-8?q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Mark Brown <broonie@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
In-Reply-To: <d8fff247-d3ce-79f0-6d0b-dcce44457681@gmail.com>
References: <4172e59f-b9d5-d87d-9dbd-a6f683a2173c@gmail.com> <d8fff247-d3ce-79f0-6d0b-dcce44457681@gmail.com>
Subject: Re: [PATCH 3/6] dt-bindings: auxdisplay: Add Titan Micro Electronics TM1628
Date:   Sun, 20 Feb 2022 20:36:09 -0600
Message-Id: <1645410969.379359.2041544.nullmailer@robh.at.kernel.org>
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

On Sat, 19 Feb 2022 14:17:54 +0100, Heiner Kallweit wrote:
> Add a YAML schema binding for TM1628 auxdisplay
> (7/11-segment LED) controller.
> 
> This patch is partially based on previous RFC work from
> Andreas Färber <afaerber@suse.de>.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  .../bindings/auxdisplay/titanmec,tm1628.yaml  | 82 +++++++++++++++++++
>  1 file changed, 82 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/auxdisplay/titanmec,tm1628.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/auxdisplay/titanmec,tm1628.yaml:12:5: [warning] wrong indentation: expected 6 but found 4 (indentation)

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/auxdisplay/titanmec,tm1628.yaml: 'maintainers' is a required property
	hint: Metaschema for devicetree binding documentation
	from schema $id: http://devicetree.org/meta-schemas/base.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/auxdisplay/titanmec,tm1628.yaml: 'additionalProperties' is a required property
	hint: A schema without a "$ref" to another schema must define all properties and use "additionalProperties"
	from schema $id: http://devicetree.org/meta-schemas/base.yaml#
./Documentation/devicetree/bindings/auxdisplay/titanmec,tm1628.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/auxdisplay/titanmec,tm1628.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/auxdisplay/titanmec,tm1628.yaml: ignoring, error in schema: 
Documentation/devicetree/bindings/auxdisplay/titanmec,tm1628.example.dt.yaml:0:0: /example-0/spi/led-controller@0: failed to match any schema with compatible: ['titanmec,tm1628']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1595016

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

