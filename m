Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D96A6B4E78
	for <lists+linux-spi@lfdr.de>; Tue, 17 Sep 2019 14:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725920AbfIQMvn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 17 Sep 2019 08:51:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:45220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbfIQMvn (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 17 Sep 2019 08:51:43 -0400
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29D4F218AE;
        Tue, 17 Sep 2019 12:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568724702;
        bh=8HTUssJ30wmJ3525tuBKRrrjnbwk2zySpokpgctlMDU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1uHhAjUQjIlqvRMEcXRDWSXV5OxlxLAP4lEsXxfuLJJxX9TZ49AOIIL/GEZ9FkwXq
         1xevUYBmoOhmyK+PXmWYvHF/OYI9FtRZpT01pd6svZGxau07u4gNPXRbLdRvP8qFUr
         nKsF3HK/cDUfoppvfOOMYiKL5qMG16PbCOs00RLQ=
Received: by mail-qk1-f179.google.com with SMTP id 4so3817741qki.6;
        Tue, 17 Sep 2019 05:51:42 -0700 (PDT)
X-Gm-Message-State: APjAAAXDetFZflOijPeC//k4tMqt2oPxajjqSZt/UzJ896CtHFF+HdtQ
        6o6S+33tL+4y/DadlpKucF0y7grMkbPG9HjLag==
X-Google-Smtp-Source: APXvYqzGZsXAlPhiYh2alH7jD4hHEpI33KIoVHXQC9xRmxchQF6hwXrY16sEph5+/s5f2sKazHtQfHO0iFuWVh1oZd8=
X-Received: by 2002:a37:682:: with SMTP id 124mr3420891qkg.393.1568724701388;
 Tue, 17 Sep 2019 05:51:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190916075352.32108-1-horms+renesas@verge.net.au>
In-Reply-To: <20190916075352.32108-1-horms+renesas@verge.net.au>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 17 Sep 2019 07:51:29 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLq7sUyh=E=D-Lk+Q=JrrKdsHkfsF88p=703mn-gwiLSA@mail.gmail.com>
Message-ID: <CAL_JsqLq7sUyh=E=D-Lk+Q=JrrKdsHkfsF88p=703mn-gwiLSA@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: hspi: Convert bindings to json-schema
To:     Simon Horman <horms+renesas@verge.net.au>
Cc:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Rutland <mark.rutland@arm.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Yoshihiro Kaneko <ykaneko0929@gmail.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "open list:MEDIA DRIVERS FOR RENESAS - FCP" 
        <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Sep 16, 2019 at 2:54 AM Simon Horman <horms+renesas@verge.net.au> wrote:
>
> Convert Renesas HSPI bindings documentation to json-schema.
> Also name bindings documentation file according to the compat string
> being documented.
>
> As a side effect of this change all currently supported/used compat
> strings are listed while no while card compat string is documented.
> This, in my opinion, is desirable as only supported hardware should
> be documented.
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
> Based on v5.3-rc1
> Tested using:
>   ARCH=arm make dtbs_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/spi/renesas,hspi.yaml
>
> v2
> - reference spi-controller.yaml# and thus do not document
>   #address-cells and #size-cells properties.
>   These properties are still listed as required.
> - Drop comment regarding pinctrl properties.
>   These are not needed as only one state, "default", is supported
> - Document clocks and power-domains properties.
>   The clocks property is required. Add these properties to the example.
> - Drop unnecessary interrupt-parent property from example.
> ---
>  .../devicetree/bindings/spi/renesas,hspi.yaml      | 57 ++++++++++++++++++++++
>  Documentation/devicetree/bindings/spi/sh-hspi.txt  | 26 ----------
>  2 files changed, 57 insertions(+), 26 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/spi/renesas,hspi.yaml
>  delete mode 100644 Documentation/devicetree/bindings/spi/sh-hspi.txt

Reviewed-by: Rob Herring <robh@kernel.org>
