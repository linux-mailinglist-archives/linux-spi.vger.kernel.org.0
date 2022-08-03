Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB106589183
	for <lists+linux-spi@lfdr.de>; Wed,  3 Aug 2022 19:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238107AbiHCRfJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 3 Aug 2022 13:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237639AbiHCRfI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 3 Aug 2022 13:35:08 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7136657250
        for <linux-spi@vger.kernel.org>; Wed,  3 Aug 2022 10:35:06 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id j8so7471007ejx.9
        for <linux-spi@vger.kernel.org>; Wed, 03 Aug 2022 10:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=39DQIGQXThBozrEjWiDrDLhudCkP9OJY7K/8OUvd6/I=;
        b=T0ECUMDQyzHYeVYDtBxdrJfXbZ6pCVez9cmhnZRCRu5+U4KzPZUaNDD2xluVSBppE/
         gFdLH//buvE6AMKInJkbT83OWEFjWoziInti0CnrgWH9ip5wzV5ykMwcAiGQ0SuKnsat
         RcpOxXDWkr4mWKi0AqCe3bMiGzIFfrOiL1xdFXkNmHd2Mi8bsuLOtKK2JsCG0lBuHWt7
         knaJo/3VYjNjxFf/fwYTRfpRSC+DiPEbImNzF2e/cRoXO8vYs24OxpfKmpLNlsHbfpVo
         /93/MsnxblKS7iEUOuF1gRJRZrIMgZo8rjJHPeoQrYOY50XWc933rr7850HnkVhm3Snt
         mM1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=39DQIGQXThBozrEjWiDrDLhudCkP9OJY7K/8OUvd6/I=;
        b=3DVMU+udUiVU6IbHXL/LI7bi2xTb5dQ+T/CWfFjhY5qpIDvsnFkj5Og8DV5jRinZac
         QE34Vb3JMHwYTseKQINWK7WKssix8r2nfK+ncZk3hHOsStcJHOMnQa+MXZbKAQ0k6j6C
         QDpNdBm1z6N64NQExtnm8Lf16ZzCDjZe651x3c/p5GCuUhQzCN6OkhuaIJlpCIIkmHBz
         IIQDuxP/lZz6/yyNiGzf8kWaoeBj1LYhAAmMZYQDAHYF2jNbSM8jx5CoJ5pY18jKJjP9
         oo//uF2O+j9rz6dAYGjqr7Tax7nMFKO0zPBCpfduYc9vQsYFH0AWw7uetJUqtIOL6IiS
         WFLg==
X-Gm-Message-State: AJIora8sgYOTTFrUwVuD08QtBY11lMn50MfqZBV4nJiy935HOTnWwSAS
        G4AwfJ+0ZxIZH1MFWU03sktN9Th3Bm/6iab29HDCNw==
X-Google-Smtp-Source: AGRyM1ua61ngReTCruH53k/WgeL39qAn7374O3trKod4RhmxrLdTDW1BzvH+okqkgk8HVOl/oaOepnZjb6M/dewNQEk=
X-Received: by 2002:a17:906:a089:b0:72f:826b:e084 with SMTP id
 q9-20020a170906a08900b0072f826be084mr21382249ejy.708.1659548105017; Wed, 03
 Aug 2022 10:35:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220802175755.6530-1-sudip.mukherjee@sifive.com>
 <20220802175755.6530-2-sudip.mukherjee@sifive.com> <YulxX3Zo168cWhwP@sirena.org.uk>
In-Reply-To: <YulxX3Zo168cWhwP@sirena.org.uk>
From:   Sudip Mukherjee <sudip.mukherjee@sifive.com>
Date:   Wed, 3 Aug 2022 18:34:53 +0100
Message-ID: <CAHyZL-dA+mFW6Jcvpds69f-9iJf6nk7PCpO6S2Au+ugSZMgisw@mail.gmail.com>
Subject: Re: [PATCH 01/11] spi: dw: define capability for enhanced spi
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Aug 2, 2022 at 7:48 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Aug 02, 2022 at 06:57:45PM +0100, Sudip Mukherjee wrote:
>
> > Some Synopsys SSI controllers support enhanced SPI which includes
> > Dual mode, Quad mode and Octal mode. Define the capability and mention
> > it in the controller supported modes.
>
> > +#define DW_SPI_CAP_EXT_SPI           BIT(2)
>
> This isn't at all descriptive, it'd be better to have a capability bit
> for the various multi-line data modes (or possibly individual bits for
> them, though board setup will stop us using things that aren't supported
> in a given design anyway so it's a bit redundant) - that'd be a lot
> clearer and avoid confusion further down the line when some other
> feature gets added.

Do you mean to add separate capability bit like:
DW_SPI_CAP_DUAL_SPI
DW_SPI_CAP_QUAD_SPI and
DW_SPI_CAP_OCTAL_SPI ?


--
Regards
Sudip
