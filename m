Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7D564D587A
	for <lists+linux-spi@lfdr.de>; Fri, 11 Mar 2022 03:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238183AbiCKC6b (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 10 Mar 2022 21:58:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235272AbiCKC6a (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 10 Mar 2022 21:58:30 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE13188A05;
        Thu, 10 Mar 2022 18:57:27 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id r12so6584597pla.1;
        Thu, 10 Mar 2022 18:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4mGxAN+bed1cqRQjQBn14iEXY6BzLxG8/XtH3YgM+/k=;
        b=T0Mdk7vH8MtnRfu/Wx3qs6mOhHVbz80A7BVVjjimvvdVk9VcoFXwMj1T8FhvWQzn8Z
         N0kwQnatyWXjjAGyFinRgfToBFobpnHD3jyd2mr1ZRD4B2bZEfZVEFdpnT9dX5e2H9fk
         DVDWS1+EBLA03RUJFcBtajOi+8gE+rjUgp7s1HF/sgohdZ563OgfgHB7kAdjrFwigWZp
         vXkf16gexWdVifGv+bRMg93eEOiyoB/hYtKPU8G/38lHsITTPG4nNU44tfXN2SEN2c+Z
         ttJDzAOJPK6fHm9uUcJoDRQoRtdCoLZr7aaoOaduw6/A2IBI43RYEYrCey1+Dh4vgDN4
         Db3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4mGxAN+bed1cqRQjQBn14iEXY6BzLxG8/XtH3YgM+/k=;
        b=o5lHuIXlTGuqDsBCer2SDUgiCX5+gzox0WJUQhVaMe1oNdBJv+JOX1ZDvWuMUcxBXt
         GtGQyK2os6ja0hvYd+85PNDUnFyiRodQr14RAGieWs0tgsfx0/6VHPWpNoX2XdVFqQ1K
         66VI1GhuakJm8YRNTbqZyE74s4HWH/90NfihlCXhjbY8HZqxQh0KWOc+LHpMM92DpDjE
         imQf0Y02bKVc4JXDWELy/n9UECvaeHP7kNfNJaChBGUjvbC1hHDx6WEzpXTnWK5uLb2E
         epU9sa+cBjoeLlnhQN/nw+IHS16b/tkGGzxt/g19vrQ68PA2rGURhR+1H4JLDlor8Un1
         +Xiw==
X-Gm-Message-State: AOAM530/PYuW0+2ORtHwHQAjHFPzkI4XWKwwIwENaaAfFP9U6BJO90/l
        WAQHX6/DUtQwLxFBIisA+VI=
X-Google-Smtp-Source: ABdhPJwiPqnzVkUBtFFNnYqrm+dgYTz7h1VmEwvXmIyRsmDM+Jrty/3vhZCYwjPZQTW1zWaE2QYNPw==
X-Received: by 2002:a17:903:22cb:b0:151:9f41:8738 with SMTP id y11-20020a17090322cb00b001519f418738mr8338166plg.46.1646967446844;
        Thu, 10 Mar 2022 18:57:26 -0800 (PST)
Received: from 9a2d8922b8f1 ([122.161.53.68])
        by smtp.gmail.com with ESMTPSA id b62-20020a633441000000b0037c794cb68fsm6525593pga.9.2022.03.10.18.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 18:57:26 -0800 (PST)
Date:   Fri, 11 Mar 2022 08:27:21 +0530
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: spi: Update clock-names property for
 ARM pl022
Message-ID: <20220311025721.GC54098@9a2d8922b8f1>
References: <20220308072125.38381-1-singh.kuldeep87k@gmail.com>
 <20220308072125.38381-2-singh.kuldeep87k@gmail.com>
 <Yip26uBIHgt42PDf@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yip26uBIHgt42PDf@robh.at.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Mar 10, 2022 at 04:08:42PM -0600, Rob Herring wrote:
> On Tue, Mar 08, 2022 at 12:51:25PM +0530, Kuldeep Singh wrote:
> > Pl022 clock-names can be one of following:
> > ['apb_pclk'] or ['sspclk', 'apb_pclk']
> > 
> > The current schema refers to second case only. Make necessary changes to
> > incorporate both the cases and resolve below dtc warning:
> > clock-names: 'apb_pclk' is not one of ['sspclk']
> > 
> > Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
> > ---
> > v2:
> > - Reword commit message
> > - Drop SSPCLK
> > 
> >  Documentation/devicetree/bindings/spi/spi-pl022.yaml | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/spi/spi-pl022.yaml b/Documentation/devicetree/bindings/spi/spi-pl022.yaml
> > index 7d36e15db5b3..6cfab948624e 100644
> > --- a/Documentation/devicetree/bindings/spi/spi-pl022.yaml
> > +++ b/Documentation/devicetree/bindings/spi/spi-pl022.yaml
> > @@ -38,11 +38,13 @@ properties:
> >      maxItems: 2
> >  
> >    clock-names:
> > -    items:
> > +    oneOf:
> >        - enum:
> > -          - SSPCLK
> > -          - sspclk
> > -      - const: apb_pclk
> > +          - apb_pclk
> 
> Are you going to make the driver work with no SPI clock? Because this 
> change is saying that it is valid to have the APB bus clock and no SPI 
> clock.

Kindly take a loot at newer version to this series as this one is
deprecated.

https://lore.kernel.org/linux-spi/20220309171847.5345-1-singh.kuldeep87k@gmail.com/

- Kuldeep
> 
> Rob
> 
> > +      - items:
> > +          - enum:
> > +              - sspclk
> > +          - const: apb_pclk
> >  
> >    pl022,autosuspend-delay:
> >      description: delay in ms following transfer completion before the
> > -- 
> > 2.25.1
> > 
> > 
