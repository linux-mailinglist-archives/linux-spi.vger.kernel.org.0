Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8E0F2CEE0D
	for <lists+linux-spi@lfdr.de>; Fri,  4 Dec 2020 13:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbgLDM07 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 4 Dec 2020 07:26:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgLDM07 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 4 Dec 2020 07:26:59 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E678C0613D1;
        Fri,  4 Dec 2020 04:26:18 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id ga15so8425680ejb.4;
        Fri, 04 Dec 2020 04:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Do3oqdTH7dveVVzcLf/9LFZKZhHi0k7C7i3j07nGhQ8=;
        b=OJKLJ5CF7IFSOrgs4oKmQdpr+n4H0yOrjsgmMTQpqzyVk9V6sEOr9krgIR2CqI/eg2
         Olo2mJ373LWDKVEs4Zvxs6xOat5nXq3f8jPu1NeSZvHt09Q8+YN5xls41wKGDSMpJX/K
         4HgneLa13KR/eb5Yzw0NBIYdXx4L4NkQqFvMAY0EY8sNpCrlrI8cDLlBGrmQMxEvE+XE
         xoyMVCPLeAYJru9kb0QbkzbjNA+mwtfIvvY526ZkQB2Vnz7QmArTzmUAh1PY0N0PPZVW
         1Oj6Y5T1ofLG3dEdL8w9l51AFDIWfZZnZEZU3NtxU28cQFubQiSHelxZKhjzivtXmsxf
         tGpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Do3oqdTH7dveVVzcLf/9LFZKZhHi0k7C7i3j07nGhQ8=;
        b=EGL0nft7BOkvEVlvfjYXTRViLnP7t8wLsTX8+zOreO87UASnq6BuTAx5uhgcNiT6X6
         abezLJUOt1dhx17k2ikXPWpWWvagu0Rp5w4H6yN2yr1gT+ezKKwKNExzTEHhiZxDJOfC
         b5K/lvIxl+Z2EGfpHD3WZOyelAtZGT8xCQB+/spGGYTjyZY/9kjUv5+vhVuDdh61TEBz
         uvStP06gZyaTSKlUFx7n8d1W9XnptkA+Ch2BvL2qnNzgj5KBQwgxgezKUnG29z1BHuiW
         AEp0kuEeESOsn5eEsHqpZhMMVmEuJXGkh8MzDJBofcK1ef0GcqYEoiN1a3KUq5KDz12Y
         xJNg==
X-Gm-Message-State: AOAM531Sw80kYTQwS+UKdOxlCHJG7aaYdpg5gQfgT2HpIG4u3ZFpHqXJ
        5m2efzvacVWffILUk3qpCdM=
X-Google-Smtp-Source: ABdhPJwyOdmo/tJVMsSbtt3KeXnx37toRK0rO7Y5EgRhnsY2ZjlH90vCVdnqHBzTke2oBWNZyceV/g==
X-Received: by 2002:a17:906:a51:: with SMTP id x17mr6924333ejf.97.1607084777415;
        Fri, 04 Dec 2020 04:26:17 -0800 (PST)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id 65sm3375145edj.83.2020.12.04.04.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 04:26:15 -0800 (PST)
Date:   Fri, 4 Dec 2020 13:26:14 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     Mark Brown <broonie@kernel.org>, jonathanh@nvidia.com,
        robh+dt@kernel.org, linux-spi@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v1 3/7] spi: qspi-tegra: Add support for Tegra210 QSPI
 controller
Message-ID: <X8oq5vZRD600IFwd@ulmo>
References: <1606857168-5839-1-git-send-email-skomatineni@nvidia.com>
 <1606857168-5839-4-git-send-email-skomatineni@nvidia.com>
 <20201202172721.GL5560@sirena.org.uk>
 <2257bc33-80ef-a6d8-8542-480defa32937@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dMt5SDLPoOEwNGde"
Content-Disposition: inline
In-Reply-To: <2257bc33-80ef-a6d8-8542-480defa32937@nvidia.com>
User-Agent: Mutt/2.0.2 (d9268908) (2020-11-20)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--dMt5SDLPoOEwNGde
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 02, 2020 at 11:17:18AM -0800, Sowjanya Komatineni wrote:
> On 12/2/20 9:27 AM, Mark Brown wrote:
> > On Tue, Dec 01, 2020 at 01:12:44PM -0800, Sowjanya Komatineni wrote:
[...]
> > > +static int tegra_qspi_setup(struct spi_device *spi)
> > > +{
> > > +	if (cdata && cdata->tx_clk_tap_delay)
> > > +		tx_tap = cdata->tx_clk_tap_delay;
> > > +	if (cdata && cdata->rx_clk_tap_delay)
> > > +		rx_tap = cdata->rx_clk_tap_delay;
> > > +	tqspi->def_command2_reg = QSPI_TX_TAP_DELAY(tx_tap) |
> > > +				  QSPI_RX_TAP_DELAY(rx_tap);
> > > +	tegra_qspi_writel(tqspi, tqspi->def_command2_reg, QSPI_COMMAND2);
> > The setup for one device shouldn't be able to affect the operation of
> > another, already running, device so either these need to be configured
> > as part of the controller probe or these configurations need to be
> > deferred until we're actually doing a transfer.
> We will only have 1 device on QSPI as we only support single chip select.

Even so we could make the driver operate as if there were multiple
devices. This has the advantage of setting a better example for someone
who might be reading this code as reference, and it might come in handy
if for whatever reason we ever end up with a QSPI controller that does
support multiple chip selects.

If that's overly complicated, maybe a compromise would be to document
very explicitly that this only works because Tegra QSPI supports a
single chip select?

Thierry

--dMt5SDLPoOEwNGde
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl/KKuYACgkQ3SOs138+
s6FFpBAAjwrCChoV/mRCl1qXNIhjHrIrX80SlHghztIcd2MELmlTh9T7eQfFQpwl
XXHldwrXRyUNLvHs4GoKdRqigimgf/BbtaWFrQtKT+7y26WRLoQD7LLAC6i2gRoy
58ugbuGeo4klocB82RLxS/zBgGcB32tb9dwkssOvxnqnKXkKgsKa6d7VBvnwKSnI
u3NlS8YbEchDG13XmyFjbh18t4wQiu7yFrq6XqGHVatJ3Tf9FUfry9RHUqcagaTp
qDyI70Zqk0xWoZi6LU16MulJtVThFCQq+LP6cPjZcqQbhba1XNwF/vl9j71wDEpx
BvWWNmmvU5q0a0v0lDIcSpUVV5ZySOIwM1zniQhRosoknwApG4ckoqasj/Wa8H+Y
xYBecR8Y8er9XQfRX+4XAY82Y5TKAirIyYkjibfc3+20O8Fjrx/BpWFMDlb+DF7K
tVsaJzDeE1hqdl0DvALYZELLl47qjk+fybujvnsg1y5Dc48RujyNAtAPAIF0VKg2
x/bo1A+zRe7gS54fCjoZ3GXl8MG9dsFLOD4A8Ei2L1ai20+Ip0N1CIs2SkTungkL
YuUld3ETG5Zp3ropWjJMORQppGnZk9fSiYdLsfsZbyMUPmOPn2qVtZfGTZ4CLLdt
6TaqE3zh0Sf3XygAUcNLNMLyrbB5YSKZ9sW4WSneQu/96lPmMgk=
=TdSe
-----END PGP SIGNATURE-----

--dMt5SDLPoOEwNGde--
