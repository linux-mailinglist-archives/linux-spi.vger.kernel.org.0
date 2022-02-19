Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 021DE4BC893
	for <lists+linux-spi@lfdr.de>; Sat, 19 Feb 2022 14:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236736AbiBSN1q (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 19 Feb 2022 08:27:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234934AbiBSN1q (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 19 Feb 2022 08:27:46 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DEAC1011;
        Sat, 19 Feb 2022 05:27:27 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id m185so10782938iof.10;
        Sat, 19 Feb 2022 05:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KO/8QQs4orfHfNwOFQo7k4l8avyPAUDelGciJGBrvjg=;
        b=FCg0kn+ekzhlXs3p+TIEjeOc7qQPGiI/q8jB8XBmvUyIx5TBTcCg/gEKMkHE1kmeSo
         ZGyostuAgkpcxUz9yVWzEwB4Awn7HiPxP6SIbIIlOaWvdB8kNsiyylnEpweS3mrwrLBO
         yfIt/poGl6z7G2byxupCCVRRd2diNVuVkjN8CF6Q/uA1srZRtIJkbf1zJdGjQB/QHQ1I
         amlqKdLH4pJZC+4Jq6hWP7ypUuGkze6Cy9etl/RGVVphmSgpe2NSDb08pHcdhtfz8cWw
         mpti+uZMYIs5DkkXvA6BouF+5V2FdgMvwqp09fYHvaANl4MIvKIvXEKErguPM02txOiS
         3ROw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KO/8QQs4orfHfNwOFQo7k4l8avyPAUDelGciJGBrvjg=;
        b=z6MtmHG4aIkrTsXYVbvtZG8B2Z2LD5qINpTKEAtBgFY0A3HbsCRQpilWMM1jWa4cUo
         LreJvsmND1hXBt11TiKjnDpYM6shRHE9bnJAYuDKB14QTV4L/EAlALAJupR4J314V8e7
         5LOUcej9N2eRSLTmxaaC4RTAa2UvGMJago6fWXr4iEeTtfp9BBbY8FC3glRdxmoskR3k
         S0PlXRnro3nAzOLj0htOuZo8uWlhE5C9yr0y+UFbXdIxZf/TpJudzi5ZWy2IId8RMVTG
         3IgNhpIgnXqqsF5FB8Y5E0/2iy3yPkBx7GluZ02kDP1RJRg+LaDXp8qXakPrjEVLQh+o
         ZoQA==
X-Gm-Message-State: AOAM531EVVloTM+uJSwGZHh9yLwmcSA073t9cer/htHS7V/F/QbMFxUY
        r1/LfTUFd9rMevMxbWHNo4wtYKAEPI7QkPrUpeo=
X-Google-Smtp-Source: ABdhPJwU+05GoNQh/jt+OuH0dD2VBbuy+3+srpnHGgkPn+kA5W8tdUu+qBDt7gcW4QbpT8KA0+Fu2CWPpEiOlPEuK90=
X-Received: by 2002:a05:6638:204d:b0:314:a290:48c with SMTP id
 t13-20020a056638204d00b00314a290048cmr7068120jaj.264.1645277246525; Sat, 19
 Feb 2022 05:27:26 -0800 (PST)
MIME-Version: 1.0
References: <4172e59f-b9d5-d87d-9dbd-a6f683a2173c@gmail.com>
In-Reply-To: <4172e59f-b9d5-d87d-9dbd-a6f683a2173c@gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 19 Feb 2022 14:27:15 +0100
Message-ID: <CANiq72mi5fj07cfo6T4jPmp=EiRtE_uDeHHCqjG9h+duPrUMKg@mail.gmail.com>
Subject: Re: [PATCH 0/6] auxdisplay: Add support for the Titanmec TM1628 7
 segment display controller
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
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
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, Feb 19, 2022 at 2:13 PM Heiner Kallweit <hkallweit1@gmail.com> wrot=
e:
>
> This series adds support for the Titanmec TM1628 7 segment display
> controller. It's based on previous RFC work from Andreas F=C3=A4rber.
> The RFC version placed the driver in the LED subsystem, but this was
> NAK'ed by the LED maintainer. Therefore I moved the driver to
> /drivers/auxdisplay what seems most reasonable to me.

Could you please link to the discussion and/or summarize the rationale
behind the NAK?

Cheers,
Miguel
