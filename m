Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BABBA5EC18E
	for <lists+linux-spi@lfdr.de>; Tue, 27 Sep 2022 13:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbiI0Lg0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 27 Sep 2022 07:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbiI0LgU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 27 Sep 2022 07:36:20 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040712AC4D;
        Tue, 27 Sep 2022 04:36:17 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-1280590722dso12891303fac.1;
        Tue, 27 Sep 2022 04:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=1unAcBPms8l1u5y+bUrsZE/aRoHBgQycErvx/3JapII=;
        b=P3mqWUvtb5ZBrCuTwvdhq+VSg14YpkiYqxG8iZ46U9DSnxTyh0uyqWUtRUzQRGtkgl
         CKqdpzYcfjroJ00r9WPG+mpdU4OPBkvfWALt3s51bJnHxQeVoa6ARYJfL0ix+cyBGNIV
         DHV42BzQmSqlpebCN6g13n2V8D6YgoD1gJYuGZtD+ubcF4xKlcLlb0kmQ2Q+LQfT+AWF
         LLiA9iaDi4fX4R3zvM/rWF86DOAfFRs+ANPOmzWsyPJhz/WlyqpkgJUwH42r/k9wFtcu
         IPbmqR7Tn+1YDr094vLe26L3mQZxA94R4Mw9XiwnuSS61sKQjPMSRribJUoR6PbwpECM
         gIvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=1unAcBPms8l1u5y+bUrsZE/aRoHBgQycErvx/3JapII=;
        b=mECNXuUNBHFNPRsCYHPo3RM0+tTLZzD5xcEtl56QJrveyhYysuewasEj10nMpmG0dg
         6kMNyQNv9type8PmuY3K7dIFzG7eLsDHmr92rLjEzjtGH2ujcG2aO6riwDj+FbxoIg2c
         xE/f1noF4/2EmG4JbPMOQwdNk91tRece6Hka5SsMnqQTq5lkqcanijnKu521ptllgQwb
         2qM6kPh0Wpp/9Q+Ydz5jb8LdOcj0vnm5Abgz7HjhsfGzOtqy8mJPf0EDmW0LxtFhL7BC
         td1D3FwSIa2L8BAJPYJVhIG1jIhmEZol0z63NJ3FKKie0DLUug6/FKhiJb9Y/2wU59cw
         0sOQ==
X-Gm-Message-State: ACrzQf2DnVKyLYcCTc/6KxPXNdXldkGFeZJEw0MWcGyVkjYor+nedXLI
        hIdNXWmKGnoSUcnOXNEKgHxNQjc0kUT9t4W9aHU=
X-Google-Smtp-Source: AMsMyM7CeCaiK47N8ubQlmdGyE2IqbSawtaF1dlJRH+3KigI+QcOLH1qHTzmaNKK/P4UQ5Z6kQT1CstxA9KdgTkBZUY=
X-Received: by 2002:a05:6871:89:b0:131:6362:e26f with SMTP id
 u9-20020a056871008900b001316362e26fmr1887883oaa.144.1664278576297; Tue, 27
 Sep 2022 04:36:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220927031929.807070-1-sergio.paracuellos@gmail.com> <YzLagn9/j0w4UymU@sirena.org.uk>
In-Reply-To: <YzLagn9/j0w4UymU@sirena.org.uk>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Tue, 27 Sep 2022 13:36:04 +0200
Message-ID: <CAMhs-H8664babt9xwE-iCJNCdm+kues-c6V1iPwS63EtdWCV1w@mail.gmail.com>
Subject: Re: [RESEND PATCH v3] dt-bindings: spi: migrate mt7621 text bindings
 to YAML
To:     Mark Brown <broonie@kernel.org>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark,

On Tue, Sep 27, 2022 at 1:12 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Sep 27, 2022 at 05:19:29AM +0200, Sergio Paracuellos wrote:
> > SoC MT7621 SPI bindings used text format, so migrate them to YAML.
> > There are some additions to the binding that were not in the original
>
> Please submit patches using subject lines reflecting the style for the
> subsystem, this makes it easier for people to identify relevant patches.
> Look at what existing commits in the area you're changing are doing and
> make sure your subject lines visually resemble what they're doing.
> There's no need to resubmit to fix this alone.

Since this is a binding migration change I sent the patch expecting
this going into the devicetree kernel tree. So I just use the common
device tree change style 'dt-bindings: spi: migrate mt7621 text
bindings to YAML' as the subject. So I don't really understand what
you mean above, sorry. What is wrong with this subject? I submitted
this v3 [0] and I was told by Rob to resend it to you and the
linux-spi mail list also.

Thanks in advance for clarification.

Best regards,
    Sergio Paracuellos

[0]: https://lore.kernel.org/linux-devicetree/CAMhs-H-fK=F7Wy7-pti+0SKo8DqyZGWu_g74-5MYLxzBhaihmA@mail.gmail.com/T/#m28f6b6d720a7f4477c1c0e8f49ba8e59ed95d6dc
