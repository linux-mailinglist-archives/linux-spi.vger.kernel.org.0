Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9497589185
	for <lists+linux-spi@lfdr.de>; Wed,  3 Aug 2022 19:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238350AbiHCRfW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 3 Aug 2022 13:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238326AbiHCRfT (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 3 Aug 2022 13:35:19 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4AA637B
        for <linux-spi@vger.kernel.org>; Wed,  3 Aug 2022 10:35:18 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id f22so11379805edc.7
        for <linux-spi@vger.kernel.org>; Wed, 03 Aug 2022 10:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t7mzK+VsqxBbknsxZ5Y86hkmSLWbQ885cOUS2ErnhsQ=;
        b=jNNBA5NQLHsI0JyVIXzvuhIkTOOmyLoWRAHk03bJUHB6YpbpNC0an7pMlGB6lZz/ee
         o89HDMIE3QpAs55xNUvZxZn1oPl3DF3vvQ+soHxaMVh1mRr4z4dl9iaSx23EpupA6TL7
         pJkVZlLM9DMFjHlOyycAlG/aAP0fVcwFY3iQ80PSCCcnV+SZXRIhI9+oEvaBliFe2A91
         MPomkiS5rMbCbgHRdkvp4vk4B8hw57pjKD3s6vomjU4Z/xyPMtwZFnB4Mm8TiCUwuIOl
         tjKGNuEy3b37Edcu42Epg6SU3TtkwZAL3Gdy5Un8TEC5s+ZHtxOVEdVZJSNacV/nYxMf
         PMXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t7mzK+VsqxBbknsxZ5Y86hkmSLWbQ885cOUS2ErnhsQ=;
        b=PaY9xigQ11526PPb9JonGMP1bNSN18Cpxpcrvzc9rzbQbObaHEWa089wuF8rEifBfW
         lmDLrWxntIE3XEYN2+8Mtva1P8qqmehjhDzXCj6ZJpMaT6yKV+lH1m6nDF3rud40ra0V
         QzK691LnlJcIR/NS0kTWl0rxVVU3JA5lYbOHuyVP6inEWMcvIZUKEFb/M5m0kFV3a4AZ
         kqu0YTPKVfSf1teK1FhrGGPnFdOzELtISMaVbRvN05NuYXcY51Xi5oz1XcW/DH3wRnyz
         920ufF7NgZE+BO+/vX0+lyzFciUmdqxVg5dUgXBUki71ZE+l7l0fsM0grMvldcYvJFNI
         Ej1A==
X-Gm-Message-State: AJIora862BqDdffRly53LHnMKWTZY6DAKR9sO1UxOW2NmePKhHTkwioV
        uoO5wuN3BHAAAA29qQfl+2DJsyeSj7+bTzyrz15n9g==
X-Google-Smtp-Source: AGRyM1vinRALJaPLSYSNk3fACJZIJzEkUVcr5c6Q656EARzdy9R6EVN6hz5dbO4THnpK7R2eFuigKb95EoAGwHAFY/0=
X-Received: by 2002:a05:6402:430e:b0:43d:1cf6:61ec with SMTP id
 m14-20020a056402430e00b0043d1cf661ecmr25679481edc.194.1659548117129; Wed, 03
 Aug 2022 10:35:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220802175755.6530-1-sudip.mukherjee@sifive.com>
 <20220802175755.6530-5-sudip.mukherjee@sifive.com> <Yul3aNP8yoBf5QWu@sirena.org.uk>
In-Reply-To: <Yul3aNP8yoBf5QWu@sirena.org.uk>
From:   Sudip Mukherjee <sudip.mukherjee@sifive.com>
Date:   Wed, 3 Aug 2022 18:35:06 +0100
Message-ID: <CAHyZL-f73MGxmOGZ_-082BXZs5uxtRXtXiVr39DK+__LHTjTUQ@mail.gmail.com>
Subject: Re: [PATCH 04/11] spi: dw: use TMOD_RO to read in enhanced spi modes
To:     Mark Brown <broonie@kernel.org>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>,
        William Salmon <william.salmon@sifive.com>,
        Adnan Chowdhury <adnan.chowdhury@sifive.com>,
        Ben Dooks <ben.dooks@sifive.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeegar Lakhani <jeegar.lakhani@sifive.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark,

On Tue, Aug 2, 2022 at 8:13 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Aug 02, 2022 at 06:57:48PM +0100, Sudip Mukherjee wrote:
> > When we are using the enhanced spi modes we can not use EEPROM Read.
> > The Synopsys datasheet mentions EEPROM Read is not applicable in
> > enhanced SPI modes. We will need to use Receive only mode.
> >
> > Signed-off-by: Sudip Mukherjee <sudip.mukherjee@sifive.com>
> > ---
> >  drivers/spi/spi-dw-core.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
> > index 8c84a2e991b5..8e624620864f 100644
> > --- a/drivers/spi/spi-dw-core.c
> > +++ b/drivers/spi/spi-dw-core.c
> > @@ -727,7 +727,10 @@ static int dw_spi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
> >       cfg.dfs = 8;
> >       cfg.freq = clamp(mem->spi->max_speed_hz, 0U, dws->max_mem_freq);
> >       if (op->data.dir == SPI_MEM_DATA_IN) {
> > -             cfg.tmode = DW_SPI_CTRLR0_TMOD_EPROMREAD;
> > +             if (enhanced_spi)
> > +                     cfg.tmode = DW_SPI_CTRLR0_TMOD_RO;
> > +             else
> > +                     cfg.tmode = DW_SPI_CTRLR0_TMOD_EPROMREAD;
>
> This is fixing the previous commit...

This was not actually meant to be a fixup patch. I intentionally made
it separate so that "enhanced_spi" is introduced in the previous
patch,
and then modified the tmode read protocol in this patch based on
enhanced_spi. But I can merge it with the previous patch like you have
suggested.

--
Regards
Sudip
