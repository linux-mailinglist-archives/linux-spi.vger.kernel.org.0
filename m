Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03D25496BB0
	for <lists+linux-spi@lfdr.de>; Sat, 22 Jan 2022 11:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233239AbiAVKdQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 22 Jan 2022 05:33:16 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:47010
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233094AbiAVKdO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 22 Jan 2022 05:33:14 -0500
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8FD9240012
        for <linux-spi@vger.kernel.org>; Sat, 22 Jan 2022 10:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642847593;
        bh=mEs+f11ymEwQZPMZ2yNnkqKc9mZDhZ/EMxOn0PWlPJA=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=tL3fZ5HjojSZNyGg2/ELLG+JUvE2WBe97BaG7rN+YW1Rpm9ebxEAnYuSK+36Yn6Sm
         ilcEZ1oJPwEoToabugib+78oUIEcA+hQ2Z7VTr3AaPtBEIkPTelxtuob+cfHJCASox
         syEHEaXp+SiuyKbbCcJ2/8FAEbE0y4R/4L0MOyM0q4a1cTfkZbnCPc88+ezeF6ks7U
         b/Dx3uF3Q7S+7hJmP/eH23U7bzv7qwUozB0twRI0vXPy6v+KZvj6M4pF/DaTsrRn6k
         z2fUrnTi1l4BqcwGC1zDwaUFcqDZoF32w+EDd50aP/TrjqV119GjivPz+gbhaASpf8
         /mkv7a1Ys+NKA==
Received: by mail-ej1-f70.google.com with SMTP id 9-20020a170906218900b0065e2a9110b9so784606eju.11
        for <linux-spi@vger.kernel.org>; Sat, 22 Jan 2022 02:33:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mEs+f11ymEwQZPMZ2yNnkqKc9mZDhZ/EMxOn0PWlPJA=;
        b=2n7d3DMgOKnKy1+l1PdnKd12BPkDBUoNVTJs1bhsJ1Hx8ykvLz7Z9qwiajgXjlGjok
         6ePLdBaAYKfqO7ceMpJAlYJQTGQaY8mgAN9/EyJeZg2vWTzu+NOgaocrZJUmxrVoK5AH
         zRA5IvhrNtHqjHlYZ42dxYTpcLECovJrYEGCmK8Lkp1doihXh941jg3HSoSsX5Qdi2er
         WNfo1kaey4QKiv4JyhR6vl8l1SpOWU3Okba0LxBIx+flA6VAV5bmIRdYPA7pAy4egCFp
         u6dh3miRABulRWtqWqJBlLtSfsYlZRT9HBphG/MDM0zVw4OH4HiKLVU0ZXol09zJTvI2
         g5Nw==
X-Gm-Message-State: AOAM532mtrkpOllQl2cDmKsMlswxp+Ps9wxEi6Nh2fBZon2P9HlxjL4l
        b4hmmVAqRSv5oj4nyLzShxWh81chIQpTsxKNkC+2CXxL/p3UCEwrvqo4Jzq+Q6zJhmISSIK+O6y
        oYNwDE+AAD89UyzmV7CmCLJXNrJF3NSrrDgjaEerlAkAnrzrPVaoZLQ==
X-Received: by 2002:a05:6402:2712:: with SMTP id y18mr7751443edd.337.1642847592951;
        Sat, 22 Jan 2022 02:33:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwU3NQ0IukQs+QZK207vEa5wMx7Mph+E8lv8sh5VymdubKUP7F5ZeYqGNNI96g1mpj44AR9ntiVWdDTLxHhDmw=
X-Received: by 2002:a05:6402:2712:: with SMTP id y18mr7751433edd.337.1642847592826;
 Sat, 22 Jan 2022 02:33:12 -0800 (PST)
MIME-Version: 1.0
References: <20220120192438.25555-1-alim.akhtar@samsung.com>
 <CGME20220120193613epcas5p238851849d212e01d7d830d78ca7d6379@epcas5p2.samsung.com>
 <20220120192438.25555-2-alim.akhtar@samsung.com> <aa172f14-2328-fc7c-0063-5c0033970d1d@canonical.com>
 <YevcOlARxNcBeDJE@jack.zhora.eu>
In-Reply-To: <YevcOlARxNcBeDJE@jack.zhora.eu>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Date:   Sat, 22 Jan 2022 11:33:01 +0100
Message-ID: <CA+Eumj7ab9E_4sbVPSQjOc-ZwM9LVdrgE=rj3duYKBYHjtDhyA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] spi: dt-bindings: samsung: Add fsd spi compatible
To:     Andi Shyti <andi@etezian.org>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linus.walleij@linaro.org,
        robh+dt@kernel.org, linux-samsung-soc@vger.kernel.org,
        pankaj.dubey@samsung.com, broonie@kernel.org,
        linux-spi@vger.kernel.org, linux-fsd@tesla.com,
        Adithya K V <adithya.kv@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, 22 Jan 2022 at 11:28, Andi Shyti <andi@etezian.org> wrote:
>
> Hi Krzysztof and Alim,
>
> On Fri, Jan 21, 2022 at 07:33:15PM +0100, Krzysztof Kozlowski wrote:
> > On 20/01/2022 20:24, Alim Akhtar wrote:
> > > Adds spi controller dt-binding compatible information for
> > > Tesla Full Self-Driving (FSD) SoC.
> > >
> > > Cc: linux-fsd@tesla.com
> > > Signed-off-by: Adithya K V <adithya.kv@samsung.com>
> > > Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> > > ---
> > >  Documentation/devicetree/bindings/spi/samsung,spi.yaml | 1 +
> > >  1 file changed, 1 insertion(+)
> >
> > I think you forgot to mention - in cover letter - that this depends on
> > my Samsung SPI bindings conversion to dtschema.
>
> It's written in the cover letter:
>
> "Note: This series is depended on [1] patches which adds
> support of FSD SoC and on Krzysztof's v5 [2] of spi schema
> changes"

Indeed, it is. I simply could not find the cover letter so I assumed
none was sent, but it just got hidden.
