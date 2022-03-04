Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97FB94CE091
	for <lists+linux-spi@lfdr.de>; Sat,  5 Mar 2022 00:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbiCDXIj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 4 Mar 2022 18:08:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiCDXIi (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 4 Mar 2022 18:08:38 -0500
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C3FDE6;
        Fri,  4 Mar 2022 15:07:49 -0800 (PST)
Received: by mail-oi1-f172.google.com with SMTP id ay7so9359681oib.8;
        Fri, 04 Mar 2022 15:07:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=EuVtOzmDY8KQtxviZjbiWvVDjL6QwHXJTtn2aF7LIXc=;
        b=3Zp1SBCWu7lI8TVO2TZ7IJdeAsLUQzcFyfB6rm0SDk2oT3y9vyGWKsDLco+lr06hwx
         nq+kSul7yhEI+PUiL9BJPrGV+rLVqBR6GI64s4JBvQsSmtPHCaRUdQdRA9e5OkUM2uWz
         8uEeTnMASvvmx0Wt8/vV3FdMp/Ibd3IMq5jjn/EJ+mPmnJaVor0aa/V/R6njEyLPLgey
         gi3EoECVxA8OovQmlKC1gG0K3prRDLXLNSmq5Na8KOWiDtA/uiNSbvltIe3GbRinVa3L
         UzFvNl79/G/ZHMjfHPvucoJzf9K7ovlWHcarhV/pvOrZ2eolcNp6hguzVho+MRobpOpz
         f0gg==
X-Gm-Message-State: AOAM530LzzundRZ3/VjHjoPsT7wBVsrtGkfYJexpDnyi/mF9ciR+cd+D
        thsyNorhwLrOCXDIXOZS4w==
X-Google-Smtp-Source: ABdhPJzBMpgUUCLDYr6YbsXtD5Tw6YhhPdQRKDAFpiM7eprWpaKATZipSf90dkk5P62+xaVtLQfLoA==
X-Received: by 2002:a05:6808:148d:b0:2d9:a01a:4873 with SMTP id e13-20020a056808148d00b002d9a01a4873mr959275oiw.190.1646435268666;
        Fri, 04 Mar 2022 15:07:48 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id e7-20020a056830200700b005a09222e268sm2889932otp.7.2022.03.04.15.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 15:07:47 -0800 (PST)
Received: (nullmailer pid 629083 invoked by uid 1000);
        Fri, 04 Mar 2022 23:07:46 -0000
Date:   Fri, 4 Mar 2022 17:07:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v5 2/6] dt-bindings: auxdisplay: Add Titan Micro
 Electronics TM1628
Message-ID: <YiKbwv2mg3//5EAa@robh.at.kernel.org>
References: <90668779-b53d-b3e7-5327-af11ff4a1d18@gmail.com>
 <2671e6e3-8f18-8b70-244b-9e1415bfdf8f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2671e6e3-8f18-8b70-244b-9e1415bfdf8f@gmail.com>
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

On Fri, 25 Feb 2022 22:13:16 +0100, Heiner Kallweit wrote:
> Add a YAML schema binding for TM1628 auxdisplay
> (7/11-segment LED) controller.
> 
> This patch is partially based on previous work from
> Andreas Färber <afaerber@suse.de>.
> 
> Co-developed-by: Andreas Färber <afaerber@suse.de>
> Signed-off-by: Andreas Färber <afaerber@suse.de>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
> v5:
> - add vendor prefix to driver-specific properties
> ---
>  .../bindings/auxdisplay/titanmec,tm1628.yaml  | 92 +++++++++++++++++++
>  1 file changed, 92 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/auxdisplay/titanmec,tm1628.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
