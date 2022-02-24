Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D56274C37DA
	for <lists+linux-spi@lfdr.de>; Thu, 24 Feb 2022 22:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234931AbiBXVbo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 24 Feb 2022 16:31:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233714AbiBXVbn (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 24 Feb 2022 16:31:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59AC51CB16;
        Thu, 24 Feb 2022 13:31:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E984661A30;
        Thu, 24 Feb 2022 21:31:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 570B5C340F3;
        Thu, 24 Feb 2022 21:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645738272;
        bh=xAaV71khgyxJSYNTbghVh0hGPi9acURlzOoApHgt5V8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hBViD1MEgdFwxvUNZIgAlV+jLNlQODbe5yBXsIOVuvuimoXXdMarWY445b2ktBqkL
         dL57YHKBnQe6NYAYrppZ16n+4KMvWWOHLzD6QKx9QtlPINdyMmjJuVz18SN6XCri3m
         kefdK48sqpQMoCMKhCuJosOoiAQ6XvIMAfzPC1i8VPEFF0UhBkcQTQeWwg/3pIWzT9
         Iz0bS9QqE1bwo1zMgEBogxotkZ2JCgOW6khUWdKd33h0Rrd6wjwreHooZqhgZNwBDq
         WvLc4jVBVaQHr/jjgeXJU0Ua+QPO9m6n8wCppqdPYePOi9xlRrGtiqIyeD2N8NUpd9
         PB1n09f5SzcmA==
Received: by mail-ej1-f53.google.com with SMTP id qk11so7088989ejb.2;
        Thu, 24 Feb 2022 13:31:12 -0800 (PST)
X-Gm-Message-State: AOAM533Uoti9mAqSH/tRxjXYTmIMAZRtjk5MC9ZTVvdl+tQc7F14wSZX
        z70NRbTil9lWGIznW1WAI+qavPIUzcTk6c6oOw==
X-Google-Smtp-Source: ABdhPJz9gGO5RwkLo5KhzTerkRw/zvkylyNwIdinxgbHvG3V6vn/A+xfja9Q/OgQ6dBDyAoiZqpRMB7qHSQ/5wFGBPo=
X-Received: by 2002:a17:906:f6d9:b0:6ce:e7d:5f3a with SMTP id
 jo25-20020a170906f6d900b006ce0e7d5f3amr3727571ejb.20.1645738270497; Thu, 24
 Feb 2022 13:31:10 -0800 (PST)
MIME-Version: 1.0
References: <4eb7b036-a9b9-3bd2-4e84-f56ba4b1a740@gmail.com>
 <2b7f0011-8872-70fa-b9b7-50b7817e7084@gmail.com> <YhfpD9qfcuAlC+wp@robh.at.kernel.org>
 <29fcdfe3-1b8e-f466-6e20-919c6ab2a7ae@gmail.com>
In-Reply-To: <29fcdfe3-1b8e-f466-6e20-919c6ab2a7ae@gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 24 Feb 2022 15:30:57 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL-yFJkq9Uj9XAzfcN=yD9AGUQEGk7f-h81P7MNj7p==A@mail.gmail.com>
Message-ID: <CAL_JsqL-yFJkq9Uj9XAzfcN=yD9AGUQEGk7f-h81P7MNj7p==A@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] dt-bindings: auxdisplay: Add Titan Micro
 Electronics TM1628
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
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
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Feb 24, 2022 at 2:56 PM Heiner Kallweit <hkallweit1@gmail.com> wrot=
e:
>
> On 24.02.2022 21:22, Rob Herring wrote:
> > On Wed, Feb 23, 2022 at 06:59:31PM +0100, Heiner Kallweit wrote:
> >> Add a YAML schema binding for TM1628 auxdisplay
> >> (7/11-segment LED) controller.
> >>
> >> This patch is partially based on previous work from
> >> Andreas F=C3=A4rber <afaerber@suse.de>.
> >>
> >> Co-Developed-by: Andreas F=C3=A4rber <afaerber@suse.de>
> >> Signed-off-by: Andreas F=C3=A4rber <afaerber@suse.de>
> >> Co-Developed-by: Heiner Kallweit <hkallweit1@gmail.com>
> >> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> >> ---
> >> v3:
> >> - fix remaining YAML issues
> >> - use Co-Developed-by
> >> ---
> >>  .../bindings/auxdisplay/titanmec,tm1628.yaml  | 92 ++++++++++++++++++=
+
> >>  1 file changed, 92 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/auxdisplay/titan=
mec,tm1628.yaml
> >>
> >> diff --git a/Documentation/devicetree/bindings/auxdisplay/titanmec,tm1=
628.yaml b/Documentation/devicetree/bindings/auxdisplay/titanmec,tm1628.yam=
l
> >> new file mode 100644
> >> index 000000000..2a1ef692c
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/auxdisplay/titanmec,tm1628.yam=
l
> >> @@ -0,0 +1,92 @@
> >> +# SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
> >> +%YAML 1.2
> >> +---
> >> +$id: http://devicetree.org/schemas/auxdisplay/titanmec,tm1628.yaml#
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: Titan Micro Electronics TM1628 LED controller
> >> +
> >> +maintainers:
> >> +  - Andreas F=C3=A4rber <afaerber@suse.de>
> >> +  - Heiner Kallweit <hkallweit1@gmail.com>
> >> +
> >> +allOf:
> >> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> >> +
> >> +properties:
> >> +  compatible:
> >> +    const: titanmec,tm1628
> >> +
> >> +  reg:
> >> +    maxItems: 1
> >> +
> >
> >> +  grid:
> >> +    description:
> >> +      Mapping of display digit position to grid number.
> >> +      This implicitly defines the display size.
> >> +    $ref: /schemas/types.yaml#/definitions/uint8-array
> >> +    minItems: 1
> >> +    maxItems: 7
> >> +
> >> +  segment-mapping:
> >> +    description:
> >> +      Mapping of 7 segment display segments A-G to bit numbers 1-12.
> >> +    $ref: /schemas/types.yaml#/definitions/uint8-array
> >> +    minItems: 7
> >> +    maxItems: 7
> >
> > Are these properties useful for any 7 segment display or specific to
> > this controller?
> >
> Both are controller-specific. E.g. the functionally similar driver
> ht16k33 uses different properties.

Then they both need a vendor prefix.

> > The commit msg mentions 11 segment display. Does this need to be?:
> >
> > oneOf:
> >   - minItems: 7
> >     maxItems: 7
> >   - minItems: 11
> >     maxItems: 11
> >
> The controller would be able to drive 11 segments, but the driver
> supports 7 segments only (at least for now). Therefore a 11 segment
> display can be used, but only the 7 segment part will be active.
> All devices with this controller I've seen and heard of have
> 7 segment displays.

Bindings should be complete, not just what a particular version of a
driver supports. However, if all known h/w is just 7 seg, then it is
fine.

Rob
