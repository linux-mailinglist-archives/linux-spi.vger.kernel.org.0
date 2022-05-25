Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6425341D1
	for <lists+linux-spi@lfdr.de>; Wed, 25 May 2022 18:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245540AbiEYQ7E (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 25 May 2022 12:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245530AbiEYQ7C (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 25 May 2022 12:59:02 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388E8A502E
        for <linux-spi@vger.kernel.org>; Wed, 25 May 2022 09:59:00 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id p10so12324389wrg.12
        for <linux-spi@vger.kernel.org>; Wed, 25 May 2022 09:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BuZEGOxN6s+QpJ7ff5N18tZNmtTRq26kp+p3466K8F8=;
        b=PN7c+ZsciJ/kEOjPj7CShyBj/DLMdY+SeuzKoJuV+aZs00rsfGtKPxXYuXkDBJ+S65
         +uM95I3LPBfkBnNJtlsq3Hb54Vee//W2JCMtzVXiGtQO50V488NIYCi61azqiCWc6O3c
         Q5lU3W83LYTjnEIjbwpSasu8MmFtG9SIpezhIsHVO5szkxK6XNck9CfoRN9NbVUaLhQ8
         rYnP9qSQ9RsaMMG4frzZhL/yat5iLtRzzgeCf/MMbJh08/WMAAcFYYbFqaqpNUYbIOLm
         zw8NrHxtN81kOAdgF/FzYqXwubENk2rIRCDyHk6nuO2yj17cVhEWMQAi40vrNhwTac3X
         RwsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BuZEGOxN6s+QpJ7ff5N18tZNmtTRq26kp+p3466K8F8=;
        b=SdLk2GelXNhteGgt8HDl6IaEnRX/ijWXB8DwXnDGiN1/8R+UNubAKopM3va2ChZF06
         am4qA2YVr17kNnYtHelqs1Ib16Wt6vzi2ml56HmebGCD/RSIZMuDe2j2PmLTZQatq+oS
         DRCNRYqhUT31WPOQpj4urgJCvr+e4pB7D59CsaVj/Gsk0+bMmCVg5wG1OqPauMoRe4+j
         H9g0EZNtGGO6o4KkEZPqGpEjyxJ9Qaejbv88KsT2hj3rsRIKa5a5Wo/wubCaxpDLq4qG
         e2WXRi1pSgx5COg2amu5bGscK2RKHdYTqUZ/jvoDYd6rqUn0acCJ0+5vHZbYAbGicg1k
         8NHg==
X-Gm-Message-State: AOAM5306Bwi1DFVK8cvcqbpID8gzJ4ktjHYBTNflg1XOTWxFwzXnQ2Zz
        HIND7fxLDitCB+Gy2HSv4Elxi1Gf1yrJ8XUAK9iJ6g==
X-Google-Smtp-Source: ABdhPJybIyWNzIkBX1luV1MnU9OIiN8pAZht74AaILdEoJbIQZLlkTffZeSVmkFeLQons+gYVBsMhKaLpMV+YAPqwYA=
X-Received: by 2002:a5d:5954:0:b0:20c:4d55:1388 with SMTP id
 e20-20020a5d5954000000b0020c4d551388mr28019559wri.90.1653497938850; Wed, 25
 May 2022 09:58:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220406233648.21644-1-brad@pensando.io> <20220406233648.21644-5-brad@pensando.io>
 <7363c5bb-89ed-b6aa-b346-f314a058f2a7@linaro.org>
In-Reply-To: <7363c5bb-89ed-b6aa-b346-f314a058f2a7@linaro.org>
From:   Brad Larson <brad@pensando.io>
Date:   Wed, 25 May 2022 09:58:47 -0700
Message-ID: <CAK9rFnzHOTg9BR-KY7rQttN2Cu2SYqAXfjXLYsH+RKYO8Su01g@mail.gmail.com>
Subject: Re: [PATCH 04/11] dt-bindings: spi: Add compatible for Pensando Elba SoC
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        David Clear <dac2@pensando.io>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Krzysztof,

On Thu, Apr 7, 2022 at 11:59 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 07/04/2022 01:36, Brad Larson wrote:
> > Document the cadence qspi controller compatible for Pensando Elba SoC
> > boards.  The Elba qspi fifo size is 1024.
> >

> > @@ -48,7 +49,7 @@ properties:
> >      description:
> >        Size of the data FIFO in words.
> >      $ref: "/schemas/types.yaml#/definitions/uint32"
> > -    enum: [ 128, 256 ]
> > +    enum: [ 128, 256, 1024 ]
>
> Is 1024 valid for other controllers? If not, then probably this should
> be further constraint in allOf:if:then...

I'll change this to allOf:if:then so that the 1024 deep FIFO is
specific to Elba SoC.

Regards,
Brad
