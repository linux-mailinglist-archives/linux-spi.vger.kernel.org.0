Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A111D5EFB45
	for <lists+linux-spi@lfdr.de>; Thu, 29 Sep 2022 18:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234639AbiI2Qsq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 29 Sep 2022 12:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235966AbiI2Qsi (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 29 Sep 2022 12:48:38 -0400
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE6C1C8889;
        Thu, 29 Sep 2022 09:48:38 -0700 (PDT)
Received: by mail-oo1-f49.google.com with SMTP id r15-20020a4abf0f000000b004761c7e6be1so488257oop.9;
        Thu, 29 Sep 2022 09:48:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=XR4eO+TONRmeYijWlAvZxeW8FOqXDqLojRyAVsYVDTk=;
        b=WJ0V/MXXPvtAy/+EVBo6aWj+U8HOplT7/0NWoo6QBnDm5PYCy9FWtrYEt31V3XxVNz
         CDmwe6FN5clIadgh6v4im9eUMwjOl25/SvmGBd+v/dInxdmrZvJcQBpwIouKzsAKn+OD
         w/rJhTpc+59Wp2zqHHGRUe0KP4VvykNXto4dUJlzkHmtOgAT52n4PbQg0mQJI0lo+dC1
         VwGiAI8HzOSBf4+/GEqi3gefGCS+bv2LEM0JNFAgvs5dJU+IpvoDRD+ilCgmjt9AJ5Cg
         0r/rWUB2GAXrDvwyC4h7QuKFQh/bA59ZJ08SRyBL6UGQtc3cOChEwy3vTwXQa7b97Whu
         zcvw==
X-Gm-Message-State: ACrzQf0ms0g4xMv5RILKseQU8sXNqYOUVVyszkABOMtr+AQPzS0Dtrn1
        t9JRmTj/M9v3YBJ1Wh9zFg==
X-Google-Smtp-Source: AMsMyM7tpapBatq6JDd/5gaox3imND1aYC9Ih1GtQKJeEUKzIzkZAw1D5jJ5ZPo+PQJJRiE817R5Qw==
X-Received: by 2002:a05:6830:6518:b0:655:d49f:55a2 with SMTP id cm24-20020a056830651800b00655d49f55a2mr1722191otb.199.1664470117381;
        Thu, 29 Sep 2022 09:48:37 -0700 (PDT)
Received: from macbook.herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l11-20020a056870204b00b0012796e8033dsm31673oad.57.2022.09.29.09.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 09:48:36 -0700 (PDT)
Received: (nullmailer pid 2306729 invoked by uid 1000);
        Thu, 29 Sep 2022 16:48:36 -0000
Date:   Thu, 29 Sep 2022 11:48:36 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [RESEND PATCH v3] dt-bindings: spi: migrate mt7621 text bindings
 to YAML
Message-ID: <20220929164836.GA2297514-robh@kernel.org>
References: <20220927031929.807070-1-sergio.paracuellos@gmail.com>
 <YzLagn9/j0w4UymU@sirena.org.uk>
 <CAMhs-H8664babt9xwE-iCJNCdm+kues-c6V1iPwS63EtdWCV1w@mail.gmail.com>
 <YzLloE/AEdFiHsEj@sirena.org.uk>
 <CAMhs-H9+hp3yLoGyGTNLDZKX__KGwa5PwLrqiFzVP__8_nPrFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMhs-H9+hp3yLoGyGTNLDZKX__KGwa5PwLrqiFzVP__8_nPrFw@mail.gmail.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Sep 27, 2022 at 02:09:21PM +0200, Sergio Paracuellos wrote:
> On Tue, Sep 27, 2022 at 1:59 PM Mark Brown <broonie@kernel.org> wrote:
> >
> > On Tue, Sep 27, 2022 at 01:36:04PM +0200, Sergio Paracuellos wrote:
> > > On Tue, Sep 27, 2022 at 1:12 PM Mark Brown <broonie@kernel.org> wrote:
> > > > On Tue, Sep 27, 2022 at 05:19:29AM +0200, Sergio Paracuellos wrote:
> >
> > > > Please submit patches using subject lines reflecting the style for the
> > > > subsystem, this makes it easier for people to identify relevant patches.
> >
> > > Since this is a binding migration change I sent the patch expecting
> > > this going into the devicetree kernel tree. So I just use the common
> > > device tree change style 'dt-bindings: spi: migrate mt7621 text
> > > bindings to YAML' as the subject. So I don't really understand what
> > > you mean above, sorry. What is wrong with this subject? I submitted
> > > this v3 [0] and I was told by Rob to resend it to you and the
> > > linux-spi mail list also.
> >
> > Bindings mostly go through the subsystem rather than the DT tree.
> 
> I thought when changes are only in the binding side DT tree was
> preferred. Sorry for the inconvenience, then. Will take into account
> your advice from now on.

Sometimes they do, but that's more the exception. The ones from you I've 
picked up don't have a subsystem really or the subsystem maintainer 
isn't too active or doesn't pay much attention to DT only patches. Mark 
is responsive and pays some attention to binding patches, so he takes 
them.

Rob
