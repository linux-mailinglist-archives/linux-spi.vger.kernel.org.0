Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 606244BD640
	for <lists+linux-spi@lfdr.de>; Mon, 21 Feb 2022 07:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235270AbiBUGcx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 21 Feb 2022 01:32:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345176AbiBUGcv (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 21 Feb 2022 01:32:51 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9811D8;
        Sun, 20 Feb 2022 22:32:29 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id u1so25192018wrg.11;
        Sun, 20 Feb 2022 22:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=TVB1SAwyejdejCoebVJa4rEH4qtbM8FunJaGvyM3xDM=;
        b=iM9rYwji7ExpIYsMATDt3yW2TvXSImXKy56t9ZnCBnNRyO+AslIr0JjDxly7meBJNS
         XPjTZIEJ2MxaBO+A/wWNBg6Z8uq39L8PSFfLo7MV8szZKnCg6cC0lcSz0mxX/HUvJ///
         TZ5u8EC8YdenrWo/0aeQ854OfRtrNyOZo7BUUubaQZqm4YzwYXu6TfcKhxapndcPhiHY
         bpuQ3lj0caDNdo7axv8aGGS1HMhqpDpIlrmxt9Eo++ZZcKu2yVr8zZb1sheFDbrnWhn3
         +CdgL1HoKv+E1pSyfqT9E3g2QrS2ijx701r+jwlN4ZvwQ0UlMKYmXSw6VPyJE35UWduB
         O52Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=TVB1SAwyejdejCoebVJa4rEH4qtbM8FunJaGvyM3xDM=;
        b=eoiw5HLgPQO2DTDWeQ+tmi+lAc4hcNGcOpfFnh3zTauoXwM2GOuVZsL1TiW4AUethJ
         Y7AvHjrcpXZaEQtXrUaIhvybVK0h9bBm8bP4PBt8ifdEBHmEgNUc7ZQ8uenICE+Ei9ww
         FSB9FKMshA7J9tcJ831cG+2226yyPAnDvSOwn5JF4+wH48/V6nyVKl++ygw/Knd7qQEe
         Qd2FIVTmoIihBzUyZ0zJteW79d2RzxEuPYOkAG+JbUNxjdLanVBwB+4xqQD2YnpVMbT4
         Tzi0T+tokbo0PH9HOaHL/qzWsuTcHJZwLsTgK45RkivkeJzM55YMdd0XN3Kanc6dC7PN
         g31w==
X-Gm-Message-State: AOAM532guFJl3eOhLRijfFtx93CIXl+gGbDVK8x+hpVc8dw77HlhBXJU
        dEUpLmG0HvW6NTGabMjR0qg=
X-Google-Smtp-Source: ABdhPJx+1Angj51NlGm4D2VR44yakbH8bYZ+MvkrSDPFeVRwcN3Ulhy+q7jJf6Yf2bNkid5hRieHAA==
X-Received: by 2002:a05:6000:258:b0:1e4:eee1:93b9 with SMTP id m24-20020a056000025800b001e4eee193b9mr14735201wrz.558.1645425147536;
        Sun, 20 Feb 2022 22:32:27 -0800 (PST)
Received: from smtpclient.apple ([167.99.200.149])
        by smtp.gmail.com with ESMTPSA id s2sm6429180wmc.45.2022.02.20.22.32.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Feb 2022 22:32:27 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH 0/6] auxdisplay: Add support for the Titanmec TM1628 7
 segment display controller
From:   Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <4172e59f-b9d5-d87d-9dbd-a6f683a2173c@gmail.com>
Date:   Mon, 21 Feb 2022 10:32:22 +0400
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        =?utf-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Miguel Ojeda <ojeda@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <5B4B8165-5D64-4336-A149-DF55C47D5ACE@gmail.com>
References: <4172e59f-b9d5-d87d-9dbd-a6f683a2173c@gmail.com>
To:     Heiner Kallweit <hkallweit1@gmail.com>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

resend from correct mail account:

> On 19 Feb 2022, at 5:13 pm, Heiner Kallweit <hkallweit1@gmail.com> =
wrote:
>=20
> This series adds support for the Titanmec TM1628 7 segment display
> controller. It's based on previous RFC work from Andreas F=C3=A4rber.
> The RFC version placed the driver in the LED subsystem, but this was
> NAK'ed by the LED maintainer. Therefore I moved the driver to
> /drivers/auxdisplay what seems most reasonable to me.
>=20
> To be decided is through which tree this series should go.
> I'd think SPI would be most suited, but that's a decision I
> leave up to the respective maintainers.
>=20
> Further changes to the RFC version:
> - Driver can be built also w/o LED class support, for displays that
> don't have any symbols to be exposed as LED's.
> - Simplified the code and rewrote a lot of it.
> - Driver is now kind of a MVP, but functionality should be sufficient
> for most use cases.
> - Use the existing 7 segment support in uapi/linux/map_to_7segment.h
> as suggested by Geert Uytterhoeven.
>=20
> Note: There's a number of chips from other manufacturers that are
>     almost identical, e.g. FD628, SM1628. Only difference I saw so
>     far is that they partially support other display modes.
>     TM1628: 6x12, 7x11
>     SM1628C: 4x13, 5x12, 6x11, 7x10
>     For typical displays on devices using these chips this
>     difference shouldn't matter.
>=20
> Successfully tested on a TX3 Mini TV box that has an SM1628C and a
> display with 4 digits and 7 symbols.

Thanks for dusting off sources and working on this! - it=E2=80=99s =
another piece
of the upstream puzzle for distros that install on Android boxes.

I needed the following patch to address compile issues (missing include,
and the recent void/int change in linux-next (I=E2=80=99m using 5.17.y):

diff --git a/drivers/auxdisplay/tm1628.c b/drivers/auxdisplay/tm1628.c
index a39b638282c1..ab3557f8b330 100644
--- a/drivers/auxdisplay/tm1628.c
+++ b/drivers/auxdisplay/tm1628.c
@@ -5,6 +5,7 @@
* Copyright (c) 2019 Andreas F=C3=A4rber
*/

+#include <linux/ctype.h>
#include <linux/delay.h>
#include <linux/leds.h>
#include <linux/module.h>
@@ -327,10 +328,11 @@ static int tm1628_spi_probe(struct spi_device =
*spi)
      return device_create_file(&spi->dev, &dev_attr_display_text);
}

-static void tm1628_spi_remove(struct spi_device *spi)
+static int tm1628_spi_remove(struct spi_device *spi)
{
      device_remove_file(&spi->dev, &dev_attr_display_text);
      tm1628_set_display_ctrl(spi, false);
+       return 0;
}

static void tm1628_spi_shutdown(struct spi_device *spi)

I also needed CONFIG_SPI_GPIO=3Dy in kernel config. With this added the
driver probes on my TX3 mini box and the display goes dark overwriting
the default =E2=80=98boot=E2=80=99 text. The following systemd service =
and script sets
the clock and flashes the colon separator on/off to count seconds:

=
https://github.com/chewitt/LibreELEC.tv/commit/c8f1ebe6f6c366188f18f9d2b40=
1de6c2979fdd7

With the include fixup and maybe a Kconfig tweak, for the series:

Tested-by: Christian Hewitt <christianshewitt@gmail.com>=
