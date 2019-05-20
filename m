Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9C9243E9
	for <lists+linux-spi@lfdr.de>; Tue, 21 May 2019 01:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbfETXIQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 20 May 2019 19:08:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:41934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726107AbfETXIP (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 20 May 2019 19:08:15 -0400
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DED602173E;
        Mon, 20 May 2019 23:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558393695;
        bh=ADrBNYwjJaQRdD8qP6L3ZncT4kT3HxR4MJLlIgRo1fw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QDEaFDw4x2j8sWPdkyEZ1Gc/aTUCHVN17mXVua90r6wy6VVcJZlLguJdTsRDWlsms
         kfZTrCGxDTc4JCu9vFiNg4ww4LhJ1U5LNEQbSmli3itLi65i48W+f7Z3W1eV5qaEFO
         DfTycFiMXIt2iVa8ZXrlMFW2yhotvsHI6nTLJhjc=
Received: by mail-qt1-f181.google.com with SMTP id h1so18404529qtp.1;
        Mon, 20 May 2019 16:08:14 -0700 (PDT)
X-Gm-Message-State: APjAAAX52h0oUXf5DGArLxGBV/t5waD/gWpOXVRF1+9vBLX/wLjUxniJ
        TavOxmATG+PCgTT6vIROKS8d3/YEvXFy21gNbw==
X-Google-Smtp-Source: APXvYqwbvpvnRbI++0UunGJk2DioJdUwpLpIyA/fbn7qfEvVnN8HhjmnIthfVEA4znX5UdjOIGfKuO58qc+BGQfRS+4=
X-Received: by 2002:a0c:929a:: with SMTP id b26mr61995364qvb.148.1558393694150;
 Mon, 20 May 2019 16:08:14 -0700 (PDT)
MIME-Version: 1.0
References: <f53ee257855c6499fd783dc8665558f7670312f6.1558363790.git-series.maxime.ripard@bootlin.com>
 <682af95d93f4065ee7ab6a5d6f226c848f6a7da8.1558363790.git-series.maxime.ripard@bootlin.com>
In-Reply-To: <682af95d93f4065ee7ab6a5d6f226c848f6a7da8.1558363790.git-series.maxime.ripard@bootlin.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 20 May 2019 18:08:03 -0500
X-Gmail-Original-Message-ID: <CAL_JsqK4aj4tNoHpnhkJfw_2+sf=EZkZ14vC=nnUDTM0Ogp20A@mail.gmail.com>
Message-ID: <CAL_JsqK4aj4tNoHpnhkJfw_2+sf=EZkZ14vC=nnUDTM0Ogp20A@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] dt-bindings: spi: sun6i: Add YAML schemas
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org,
        linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, May 20, 2019 at 9:51 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> Switch the DT binding to a YAML schema to enable the DT validation.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
>
> ---
>
> Changes from v1:
>   - Fix the slave device regex
> ---
>  Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml | 106 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  Documentation/devicetree/bindings/spi/spi-sun6i.txt                |  44 +------------------------------
>  2 files changed, 106 insertions(+), 44 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
>  delete mode 100644 Documentation/devicetree/bindings/spi/spi-sun6i.txt

Reviewed-by: Rob Herring <robh@kernel.org>
