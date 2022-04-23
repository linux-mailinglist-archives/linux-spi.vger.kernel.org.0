Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 184D750CD75
	for <lists+linux-spi@lfdr.de>; Sat, 23 Apr 2022 22:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237049AbiDWVAz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 23 Apr 2022 17:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237044AbiDWVAz (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 23 Apr 2022 17:00:55 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949E513C3F1;
        Sat, 23 Apr 2022 13:57:57 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id z19so7432489iof.12;
        Sat, 23 Apr 2022 13:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KrTlP84sZ2q5qV0OF1MH+Ufo+yrPdkF+OvI5ZSe0jgE=;
        b=Zdr8iQjYCBDIUgbJctwOL/1gZqD3DUi9DyZ0WpMPJQxQb/H8ZwjlSFDAyVp2naGgJb
         Wgr6z6OlYj1NAsZq/0fKyM9CzjAx3EUou2Ulfw+S6Y7XFj4uTmPhx3orCs/fqBI8OZ7C
         UBRw8E4df8fAAdp+P9eAljYoBch/+3yuX/eSaTfM3A1iAyE76G6x4BudVQ4dm+IrRmfq
         iMUt66zfh9L24q/WkPmW3qh1BOaIwm/cEzjkuTUBa9XZYnJ99TWxp1FArB0fpwxS+x0H
         toF66mheGEck/AqwBXaXpOnuC23HzXKja44wIs+fTWjDF7XH1GMb4JpOpkiAXu8tOr0E
         Q6uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KrTlP84sZ2q5qV0OF1MH+Ufo+yrPdkF+OvI5ZSe0jgE=;
        b=IGkPPyN55Lcf2tp3RipJAnB2FpNi3Z69A5KiLEbKoNdCehCMj9/ZUpLzm/Yok8H5KV
         2oT4x1o/QHDnG+w9jPH6dqbMB38csg9z3A211Jarirf1ltKw97+JYR9/625bvstjiATx
         Oq7xmnao4fqa0/+O0F7EcbHmZa4aAUjPvAq9NTLClv7c1jAAzXrGk9J2ANIkvlfDDS3U
         /TRfwbtoAtW9R59h42Ynz0Ye4ClQZqLcoEyFZLOcH011HKsvx7jTlgTedkY43tnFR071
         Se938fXf7UsDBq2R3i5kPJNLziGAYLZfDQ8N6i1d2Sti1yrhNWPo819wXSpY6vgFwkAA
         tbRQ==
X-Gm-Message-State: AOAM5323iL+YECx6ovzv0pOLcCnM8WkNpxeueN0X8fafiBHaxB918dRS
        XogvQ2fbAOX6cTxYvNUPfzlgtD2NOpUyBxIBAOk=
X-Google-Smtp-Source: ABdhPJyitWaqU5hnYOdQGXm3PyDxpC5KNGGEV8H09M4KIHkejT5Z88ThOAHu/OoRWLEyeUmbiPGCZ/22Kj3HZkt2abM=
X-Received: by 2002:a05:6602:15c6:b0:611:591d:1d9a with SMTP id
 f6-20020a05660215c600b00611591d1d9amr4315448iow.177.1650747476966; Sat, 23
 Apr 2022 13:57:56 -0700 (PDT)
MIME-Version: 1.0
References: <90668779-b53d-b3e7-5327-af11ff4a1d18@gmail.com>
In-Reply-To: <90668779-b53d-b3e7-5327-af11ff4a1d18@gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 23 Apr 2022 22:57:46 +0200
Message-ID: <CANiq72m+OVcX1gPit94D1hjzkduyVFoCWXKSXTxpUDFtKs8z6g@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] auxdisplay: Add support for the Titanmec TM1628 7
 segment display controller
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Miguel Ojeda <ojeda@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Feb 25, 2022 at 10:09 PM Heiner Kallweit <hkallweit1@gmail.com> wro=
te:
>
> This series adds support for the Titanmec TM1628 7 segment display
> controller. It's based on previous RFC work from Andreas F=C3=A4rber.

AFAIU the discussion has converged at this point, correct? Is there
any feedback left to address?

Cheers,
Miguel
