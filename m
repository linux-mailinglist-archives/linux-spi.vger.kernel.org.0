Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD0932CFF8
	for <lists+linux-spi@lfdr.de>; Thu,  4 Mar 2021 10:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237919AbhCDJqH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 4 Mar 2021 04:46:07 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:37689 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237909AbhCDJpk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 4 Mar 2021 04:45:40 -0500
Received: from mail-ot1-f45.google.com ([209.85.210.45]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MKKpV-1l4KvM311b-00LnNe; Thu, 04 Mar 2021 10:43:07 +0100
Received: by mail-ot1-f45.google.com with SMTP id j8so1196745otc.0;
        Thu, 04 Mar 2021 01:43:06 -0800 (PST)
X-Gm-Message-State: AOAM531LkWx+WR7CbwGtzEMUdZiCjH3TRYdXoT81BUobxv2kHrKHJqyt
        E1vx2B9BSSe7lEshfBg1R0fkQEQNF98HyjbrIKw=
X-Google-Smtp-Source: ABdhPJzXUnZi1hHLvC4dUbPTb80i0k+xJjv00UqbhC+F0NRGhVxE6/TJKObEP1C8smvDLYSAYZqvGq7BFJ7u+C6SdbE=
X-Received: by 2002:a9d:6b8b:: with SMTP id b11mr2818377otq.210.1614850985815;
 Thu, 04 Mar 2021 01:43:05 -0800 (PST)
MIME-Version: 1.0
References: <20210304034141.7062-1-brad@pensando.io> <20210304034141.7062-7-brad@pensando.io>
In-Reply-To: <20210304034141.7062-7-brad@pensando.io>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 4 Mar 2021 10:42:49 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0EaT28a55dJKJxhQKa3p3ZmpFw7sj3G+o4C419UfT5oQ@mail.gmail.com>
Message-ID: <CAK8P3a0EaT28a55dJKJxhQKa3p3ZmpFw7sj3G+o4C419UfT5oQ@mail.gmail.com>
Subject: Re: [PATCH 6/8] arm64: Add config for Pensando SoC platforms
To:     Brad Larson <brad@pensando.io>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:dMRRch4nDV6kqVsPZq21veOwypuVReTnzCSu1bzqAYhR2YmxfMY
 ZTVsQSZ+GCktNzUmTZMnTbrORRW48iiyKMh1PRiFY5kZ6bqoIg3ei3y5FmSAqrkJqwhr57t
 tXmriHFu2kkCEDUX22ucSvm5AnXcLFT6CTOMb0zs6urq6svDsfL8H6GMJtHq+M/ZljgANvf
 c4w/tOdjJ7n8D0K1fo5nA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Uf3BXgtTBH4=:ZcFmGL+UJ7zNCZq3v/gJ4v
 kf6W84D+Fk5OpAuTkDDJEtv1TGws5Caw+Dhe/sJgQ2AyNZOJnwL5v4kxsauR8ccSIo88A5FL2
 I7skBGTiZuPw6UnD5OJZnEV4HBLG8JUn0WXbAub1hnmmUdXE6hNL7mUacEI0XavtlpTCfikJH
 PTOvU8sPosVYYemphPkVYw2oG3ttHsE81K5arqKJOmGS3+SkzBbu7ELSoCnUsV0sNPjFaDGhG
 asxcckNYsH3H8RFF+KeDquj25Kne/9TwIoGBB6gkcvlKeKGZkhS6c8/DEkpg4SUdoSeeqJICs
 ybf2Kwk9/rmCBD6nBIviH8ETvxLZRvs18m+hKZi2Mngewxfap0qr3KrZ1H5pYtvXXLWj0lYH+
 aAei+98l2CBoCpy9/GSQzyIaX+kODFvKChkaO6R0U6rtOTm2xvP6Yu4jOCbrwCEqv6+tMLpGY
 PS3xnEda8fvcGWDupkmDvkHNIHHoX0b83EweuyWnm/TV8t7dGxzZHWDwhpPjVbrtehuoPBA0L
 ohUbtkgtJCRoPHuipoNpHr9VR/FjxNB4h2dd/mR+NF6FLWCNx9QlKTiLQAQAATxKg==
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Mar 4, 2021 at 4:41 AM Brad Larson <brad@pensando.io> wrote:
>
> Add ARCH_PENSANDO configuration option for Pensando SoC
> based platforms.
>
> Signed-off-by: Brad Larson <brad@pensando.io>

The changelog and the platform help text could use a little more information
about what that platform is and where to find more information. This will
help users decide whether they should enable support for the platform or not.

       Arnd
