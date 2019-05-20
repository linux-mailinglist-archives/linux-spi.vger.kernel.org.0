Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7741B243E4
	for <lists+linux-spi@lfdr.de>; Tue, 21 May 2019 01:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfETXG2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 20 May 2019 19:06:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:41344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbfETXG1 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 20 May 2019 19:06:27 -0400
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FAA121479;
        Mon, 20 May 2019 23:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558393587;
        bh=zxZqkul/sTbxyu+eM1Nmt52EDE6qD47t2CYt1WMWGmw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=t57emVAroUNmFc09zSwAchJ2sPFP0C+TBvS7LjUzMB4ifZHWRJT+TF3vxwmzrqE60
         VUX1a4Cc2Memx0l1DsIyBXAwTrHPWfdJkYX4UXcx7MAaxdaY55sjVZ/xoSLU8HKg2k
         YMLMfN12PPpsZoqp06aaoGzE7BIYgj23rKZ4iyBg=
Received: by mail-qt1-f179.google.com with SMTP id o7so18373981qtp.4;
        Mon, 20 May 2019 16:06:27 -0700 (PDT)
X-Gm-Message-State: APjAAAU2jGwNGS962MobijFNNhauXa21cZliU3z57lZGwa6XZy2EgW4K
        O5GJHrylQgSOpRG+K3AmTp0WwLBrP27gIn2qkg==
X-Google-Smtp-Source: APXvYqxTBlQRphJSKJk0cqONxVkO51IvOVX9rYbFAdpvKFLZYH0AcktYM+pXXr+n2xDfL6n/o8Rsr6P5N3LVKDPc+Yk=
X-Received: by 2002:a05:6214:41:: with SMTP id c1mr54647840qvr.138.1558393586421;
 Mon, 20 May 2019 16:06:26 -0700 (PDT)
MIME-Version: 1.0
References: <f53ee257855c6499fd783dc8665558f7670312f6.1558363790.git-series.maxime.ripard@bootlin.com>
 <b83d0e208072a4f7d017650bc10de8cbe7558a99.1558363790.git-series.maxime.ripard@bootlin.com>
In-Reply-To: <b83d0e208072a4f7d017650bc10de8cbe7558a99.1558363790.git-series.maxime.ripard@bootlin.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 20 May 2019 18:06:15 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJaNDZHyh7DFu1YO7OBE3wsTfgDALxx1cp_1E0Beue7Tg@mail.gmail.com>
Message-ID: <CAL_JsqJaNDZHyh7DFu1YO7OBE3wsTfgDALxx1cp_1E0Beue7Tg@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] dt-bindings: spi: sun4i: Add YAML schemas
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
>  Documentation/devicetree/bindings/spi/allwinner,sun4i-a10-spi.yaml | 86 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  Documentation/devicetree/bindings/spi/spi-sun4i.txt                | 23 +-------------------
>  2 files changed, 86 insertions(+), 23 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/spi/allwinner,sun4i-a10-spi.yaml
>  delete mode 100644 Documentation/devicetree/bindings/spi/spi-sun4i.txt

Reviewed-by: Rob Herring <robh@kernel.org>
