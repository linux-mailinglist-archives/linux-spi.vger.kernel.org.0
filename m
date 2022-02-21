Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE7A34BD66D
	for <lists+linux-spi@lfdr.de>; Mon, 21 Feb 2022 07:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345263AbiBUGhH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 21 Feb 2022 01:37:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345294AbiBUGhE (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 21 Feb 2022 01:37:04 -0500
X-Greylist: delayed 304 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 20 Feb 2022 22:36:40 PST
Received: from m239-7.eu.mailgun.net (m239-7.eu.mailgun.net [185.250.239.7])
        by lindbergh.monkeyblade.net (Postfix) with UTF8SMTPS id E90C121A6
        for <linux-spi@vger.kernel.org>; Sun, 20 Feb 2022 22:36:40 -0800 (PST)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=hewittfamily.org.uk;
 q=dns/txt; s=s1; t=1645425400; h=To: References: Message-Id:
 Content-Transfer-Encoding: Cc: Date: In-Reply-To: From: Subject:
 Mime-Version: Content-Type: Sender;
 bh=nh91ABop/kMzqvCnHihv6nbKToFnlhJ3AYmAB1JeUWk=; b=ecBPG241+obwfYs9LdKa1jybI3G68VE3uW3ranYngVAswad3dequYHM8+pPmIuDO8kRvLSpC
 V8xkswAsaBFfiAIeHCwAL+HqEBLINsaDWt5z2kIB9Dy3c0nNKHcTFL2bkunnLrA4zGsS+d21
 Q1S4EwK/6AUdsqMJJ2wby7ulAGqyh0MxVAzqSYz+h+jHQCq/i/qoW5w4ZKj9Wp3xpJdNPAzO
 yIaWn9LKqXib017Pdf3WoRT3DcR4t39efS1prfDpjRD6sVCTyL0mOmjLsSF/372G4k+CX5vm
 QDDRDH2AsVhCbcsybuB22ESU40f0bReb0KXqZLRiaruaLPfN0BdnvQ==
X-Mailgun-Sending-Ip: 185.250.239.7
X-Mailgun-Sid: WyJhNzNkZCIsICJsaW51eC1zcGlAdmdlci5rZXJuZWwub3JnIiwgImUzNzIwIl0=
Received: from mail.hewittfamily.org.uk (<unknown> [87.200.95.144]) by
 smtp-out-n01.prod.eu-central-1.postgun.com with SMTP id
 621331c5a6f2f5d904897640 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 21 Feb 2022 06:31:33
 GMT
Sender: andrew@hewittfamily.org.uk
Received: from smtpclient.apple (unknown [167.99.200.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.hewittfamily.org.uk (Postfix) with ESMTPSA id A9BD06A6C53;
        Mon, 21 Feb 2022 10:31:26 +0400 (+04)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH 0/6] auxdisplay: Add support for the Titanmec TM1628 7
 segment display controller
From:   Christian Hewitt <andrew@hewittfamily.org.uk>
In-Reply-To: <4172e59f-b9d5-d87d-9dbd-a6f683a2173c@gmail.com>
Date:   Mon, 21 Feb 2022 10:31:16 +0400
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
Message-Id: <5A223478-0404-4D2D-BE7E-85A6E852174F@hewittfamily.org.uk>
References: <4172e59f-b9d5-d87d-9dbd-a6f683a2173c@gmail.com>
To:     Heiner Kallweit <hkallweit1@gmail.com>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
X-Synology-Spam-Status: score=3.742, required 5, TO_DN_EQ_ADDR_SOME 0, TO_DN_SOME 0, MV_CASE 0.5, __THREADED 0, __INR_AND_NO_REF 0, FREEMAIL_TO 0, RCVD_COUNT_ZERO 0, FROM_EQ_ENVFROM 0, MIME_TRACE 0, __NOT_SPOOFED 0, __BODY_URI_ONLY 0, MID_RHS_MATCH_FROM 0, NO_RECEIVED -0.001, FROM_HAS_DN 0, FREEMAIL_ENVRCPT 0, TO_MATCH_ENVRCPT_ALL 0, TAGGED_RCPT 0, MIME_GOOD -0.1, SCC_BODY_URI_ONLY 0.833, RCPT_COUNT_TWELVE 0, __HDRS_LCASE_KNOWN 0, SUSPICIOUS_RECIPS 2.51
X-Synology-Spam-Flag: no
X-Synology-Virus-Status: no
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


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
>  don't have any symbols to be exposed as LED's.
> - Simplified the code and rewrote a lot of it.
> - Driver is now kind of a MVP, but functionality should be sufficient
>  for most use cases.
> - Use the existing 7 segment support in uapi/linux/map_to_7segment.h
>  as suggested by Geert Uytterhoeven.
>=20
> Note: There's a number of chips from other manufacturers that are
>      almost identical, e.g. FD628, SM1628. Only difference I saw so
>      far is that they partially support other display modes.
>      TM1628: 6x12, 7x11
>      SM1628C: 4x13, 5x12, 6x11, 7x10
>      For typical displays on devices using these chips this
>      difference shouldn't matter.
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

Tested-by: Christian Hewitt <christianshewitt@gmail.com>

